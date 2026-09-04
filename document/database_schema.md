# JY2000 데이터베이스 구조

> 기준일: 2026-08-15 · DB: `jysk` (MySQL 8, utf8mb4) · 테이블 21개 + 사용 중인 뷰 1개
> DDL 원본: `server/database/schema.sql`, `schedule.sql`, `class_type_mgmt_data.sql`

---

## 1. 설계의 두 축

### 1-1. `User` 통합 테이블

**학생·강사·상담사·학부모가 모두 `User` 한 테이블에 들어갑니다.**

| `kind` | 역할 |
|---|---|
| 1 | 관리자 |
| 2 | 학생 |
| 3 | 선생님 |
| 4 | 학부모 |
| 5 | 상담원 |

이름·전화·학년 같은 공통 정보는 `User`에만 있고, 역할별 상세는 별도 테이블이 `user_id`를 공유하며 1:1로 붙습니다.

- `student_info.student_id` = `User.user_id`
- `tc_info.user_id` = `User.user_id`

그래서 거의 모든 조회가 `User`를 조인합니다. 학생 이름을 바꾸려면 `student_info`가 아니라 `User.name`을 고쳐야 합니다.

로그인 ID는 `User.phone`이며 UNIQUE 인덱스가 걸려 있습니다.

### 1-2. `code_master` 코드 마스터

상태·유형·채널 등 코드성 값은 전부 `code_master`에 문자열 ID로 들어가고, 각 테이블의 `*_code` 컬럼이 이를 참조합니다.

- 코드 ID 형식: `GROUP_VALUE` (예: `STATUS_REGISTER`, `CONSULT_TYPE_INITIAL`, `CHANNEL_PHONE`)
- 주요 그룹: `STATUS`(학생 상태), `SUB_STATUS`, `CONSULT_TYPE`, `CONSULT_RESULT`, `CHANNEL`, `SOURCE`, `LEAVE_REASON`
- 시드 데이터: `server/database/seed_code_master.sql`

---

## 2. 기준 정보

| 테이블 | 설명 |
|---|---|
| `code_master` | 코드 마스터. `code_group`별 코드값, 계층 구조(`parent_code_id`) 지원 |
| `User` | 사용자 통합. 로그인 ID는 `phone`, `kind`로 역할 구분 |
| `tc_info` | 상담사(TC) 상세 — 사번, 지점, 입/퇴사일. `User`에 1:1 |
| `School` | 학교. `school_kind`(1=중, 2=고), `region_kind`(1=원미, 2=소사, 3=오정, 4=인천, 5=서울, 6=경기기타, 99=기타) |

`User.grade` 코드: 1~6 = 초1~초6, 7~9 = 중1~중3, 10~12 = 고1~고3, 13 = N수생, 14 = 성인

---

## 3. 학생 · 상담 (핵심 업무)

| 테이블 | 설명 |
|---|---|
| `student_info` | 학생 상세. 상태(`status_code`), 유입경로, 담당 TC, 주요 일자(최초접촉/상담/등록/재원/퇴원), 주소, 메모 |
| `ParentPhone` | 보호자-학생 연결. `parent_kind`(1=부, 2=모, 3=친척, 99=기타), 순번 |
| `student_history` | 학생 상태 변경 이력. 이전/변경 상태, 담당자 변경, 변경 사유 |
| `consult` | 상담 기록. 유형·일시·채널·내용·니즈·결과·후속조치·다음 상담 예정일 + 문의경로·선정자 |
| `consult_attachment` | 상담 첨부파일 (원본 파일명, 저장 경로, MIME) |
| `former_academy` | 이전 학원 이력. 학원명, 과목, 수강 기간, 월 수강료, 퇴원 사유, 만족도 |
| `promotion` | 설명회/프로모션. 기간, 할인 유형·값, 대상 학년·과목 |
| `student_promotion` | 학생-프로모션 적용 연결 (적용일, 적용 금액) |

### 문의 과목 — `student_info.subject_code`

학생의 문의 과목은 **`student_info.subject_code`에 정수 비트마스크로** 저장됩니다. 다중 선택이 가능합니다.

| 값 | 과목 |
|---|---|
| 1 | 국어 |
| 2 | 수학 |
| 4 | 영어 |
| 8 | 과학 |
| 16 | 사회 |
| 32 | 기타 |
| 64 | 약술형 논술 |
| 128 | 인문 논술 |
| 256 | 수리 논술 |

수학+영어면 `6`으로 저장되고, 검색도 비트 연산으로 합니다 — `studentService.ts`의 `(s.subject_code & ?) > 0`.
과목이 없으면 `NULL`을 저장합니다 (클라이언트가 0을 `null`로 바꿔 보냄).

`code_master` 코드가 **아닙니다.** 표시명은 클라이언트가 비트를 풀어 만듭니다 — `client/lib/screens/student/student_detail_screen.dart`의 `SubjectCode.getName()`.

비트 64/128/256(논술 3종)은 신규생 문의 화면에서 추가된 값입니다. 정의는 `client/lib/models/new_inquiry.dart`의 `InquirySubject`에 모여 있습니다.

#### 이름이 비슷한 다른 컬럼과 구분

| 컬럼 | 의미 | 형식 |
|---|---|---|
| `student_info.subject_code` | **문의 과목** (학생 단위) | 비트마스크 정수 |
| `consult.interest_subject` | 상담 시 관심 과목 (상담 건마다 별도) | `VARCHAR(200)` 자유 입력 |
| `class_type.subject` | 반 형태의 과목 | 순번 정수 (1=국어, 2=수학, 3=영어, 4=과학, 5=사회) |
| `former_academy.subject` | 이전 학원 수강 과목 | `VARCHAR(100)` 자유 입력 |
| `mgmt_data.subject` | 경영보고서 과목 | `VARCHAR(50)` |

> `class_type.subject`와 `student_info.subject_code`는 같은 "과목"이지만 **코드 체계가 다릅니다.** 영어가 전자는 3, 후자는 4입니다. 두 값을 직접 비교하거나 조인하면 안 됩니다.

### 신규생 문의 (상담 유형 `CONSULT_TYPE_INITIAL`)

건수가 많고 중요해 전용 화면(`client/lib/screens/consult/new_inquiry_screen.dart`)과 전용 API로 분리했습니다. `code_master`의 표시명은 '초기상담'에서 **'신규생 문의'로 변경**되었고, `code_id`는 그대로입니다. 일반 상담 등록 화면에서는 이 유형이 선택 목록에서 제외됩니다.

#### 관련 컬럼

| 컬럼 | 설명 |
|---|---|
| `consult.inquiry_source_code` | 문의경로 (FK: `code_master`, **`INQUIRY_SOURCE`** 그룹) |
| `consult.selector_name` | 선정자(담당 부원장) 이름. `User`에 없는 사람도 적을 수 있어 텍스트 |

`INQUIRY_SOURCE` 그룹은 전화/홈페이지/방문/채널/네이버/설명회 후/기타 7개입니다. 학생 단위 유입경로인 `SOURCE`(지인소개·블로그·맘카페 등)와는 **별개 그룹**이니 혼동하지 마세요.

#### 저장 시 동작

`POST /consult/new-inquiry` 한 번에 아래를 트랜잭션으로 처리합니다.

1. 기존 학생이 아니면 `User`(kind=2, **active_flag=0**) 생성 → 트리거가 `student_info` 자동 생성
2. 학부모 연락처가 있으면 `User`(kind=4, active_flag=0) + `ParentPhone` 생성 (같은 번호가 이미 연결돼 있으면 건너뜀)
3. `student_info` 보강: 학교·성별·문의 과목 비트마스크
4. `consult` INSERT: 유형은 항상 `CONSULT_TYPE_INITIAL`, 문의 날짜는 `00:00:00`으로 저장

화면의 **구분(신입/재원)과 재원여부는 `User.active_flag`에서 자동 결정**되며 별도 컬럼에 저장하지 않습니다.

#### 학생 타입어헤드

`GET /consult/inquiry-students?search=` 는 `kind=2`를 **`active_flag` 상관없이** 조회합니다. 문의 단계 학생은 `active_flag=0`으로 저장되므로, 기존 `GET /class/search-users`(active_flag=1만)로는 재문의 시 찾을 수 없습니다.

### 자동화 (트리거)

`server/database/views_triggers.sql`, `sync_user_student.sql`에 정의:

- `trg_student_status_change` — `student_info.status_code` 변경 시 `student_history`에 자동 적재
- `trg_student_date_auto` — 상태를 `STATUS_CONSULT_DONE`으로 바꾸면 `consult_date` 자동 설정 (등록/퇴원도 동일)
- `trg_student_first_contact` — 최초 접촉일 자동 기록
- `trg_user_student_insert` — `User`에 학생(kind=2) 추가 시 `student_info` 자동 생성
- `trg_user_active_flag_change` — 활성 플래그 동기화

---

## 4. 일정 캘린더

| 테이블 | 설명 |
|---|---|
| `schedule_category` | 캘린더 행 구분 |
| `schedule_event_type` | 일정 유형별 배경색 |
| `schedule_event` | 일정 본체 |
| `v_schedule_event_detail` (뷰) | 위 3개 + `User`/`School`/`consult`를 미리 조인한 조회용 뷰 |

### `schedule_category.category_type`

| 값 | 용도 |
|---|---|
| `INFO` | 상담자 이슈, 신입생, 전일부재 |
| `TIME_SLOT` | 10-11, 11-12 … 9-10 시간대별 행. 카테고리명에서 시(hour)를 유도 |
| `CONSULT` | 전화상담. `event_hour`에 시각을 직접 저장 |
| `PROMOTION` | 설명회 (`promotion` 테이블을 표시) |
| `ISSUE` | 시간지정, 신입문의, 결제예정, 조교할일, 정산관련 등 업무 |

### `schedule_event_type` 기본값

상담=노랑(`#FFFF00`), 설명회=분홍(`#FF69B4`), 수납/결제=연두(`#90EE90`), 행정=하늘(`#87CEEB`), 기타=회색(`#D3D3D3`)

### `schedule_event` 표시 관련 컬럼

| 컬럼 | 설명 |
|---|---|
| `is_important` | 중요 일정. 캘린더에 **주황색 볼드**로 표시 |
| `event_status` | `NORMAL`(예정) / `COMPLETED`(완료 → 취소선) / `CANCELLED`(취소 → 빨간색) |

색상 우선순위는 취소 > 중요입니다. 완료 취소선은 색상과 독립이라 "중요 + 완료"는 주황색 + 취소선으로 함께 표시됩니다.
표시 규칙 구현: `client/lib/models/schedule_event.dart`의 `displayTextColor` / `displayDecoration`

### 상담-일정 양방향 연동

학생을 연동해 일정을 만들면 `consult` 레코드가 자동 생성되고 `schedule_event.consult_id`로 묶입니다.
상담 일시는 카테고리에서 유도한 시각을 반영하고(`TIME_SLOT` "2-3" → 14:00), 채널은 `CONSULT` 카테고리면 `CHANNEL_PHONE`, 시간대 슬롯이면 `CHANNEL_VISIT`으로 들어갑니다.

상담 유형 기본값은 **재상담(`CONSULT_TYPE_FOLLOWUP`)** 이며, 선택 목록에서 신규생 문의는 제외됩니다. 신규생 문의는 전용 화면에서만 등록합니다. 이 기본값은 서버 `scheduleService.DEFAULT_CONSULT_TYPE_CODE`와 클라이언트 `defaultConsultTypeCode` 두 곳에 있으니 바꿀 때 함께 고쳐야 합니다.

### 뷰 재생성 주의

`schedule_event`에 컬럼을 추가하면 `v_schedule_event_detail`도 함께 재생성해야 합니다. `server/database/alter_schedule_*.sql`이 모두 이 패턴을 따릅니다.

---

## 5. 반 / 수업 (레거시 테이블)

| 테이블 | 설명 |
|---|---|
| `Class` | 반 기본 정보 (반명, 활성 여부, 장르) |
| `ClassInfo` | 반 상세 (학년, 커리큘럼, 레벨, 년도, 월 수강료, 강의 요일 1~5) |
| `ClassMember` | 반 구성원. `kind=3`이면 강사 |

> **주의**: 이 3개는 저장소의 DDL 스크립트에 정의가 없습니다. 기존 운영 DB에 있던 레거시 테이블을 `classService.ts`가 그대로 읽어 쓰는 구조라, 정확한 스키마를 확인하려면 실제 DB를 봐야 합니다. 컬럼명 규칙도 다른 테이블(snake_case)과 달리 PascalCase 테이블명을 씁니다.

---

## 6. 반 형태 / 경영 보고서

| 테이블 | 설명 |
|---|---|
| `class_type` | 반 형태와 **단가**. 학년 × 과목 × 형태 조합 |
| `class_type_teacher` | 반 형태-강사 연결 |
| `mgmt_data` | 경영보고서 원장. 엑셀 업로드분을 년/월별로 적재 |

- `class_type.subject`: 1=국어, 2=수학, 3=영어, 4=과학, 5=사회
- `class_type.format`: 1=일반, 2=종합, 3=논술, 4=모의, 5=특강, 6=썸머, 7=윈터
- `mgmt_data.price` = `class_type.unit_price` × `enrollment_count` (수강인원은 0.5 또는 1.0)
- `mgmt_data`는 매칭 실패 대비로 엑셀 원본 문자열(`student_name_orig`, `teacher_name_orig`, `class_type_name_orig`)을 함께 보관합니다

---

## 7. 서비스 ↔ 테이블 대응

`server/api/src/services/` 기준입니다.

| 서비스 | 주로 쓰는 테이블 |
|---|---|
| `authService` | `User` |
| `staffService` | `User` |
| `studentService` | `student_info`, `consult`, `student_history`, `ParentPhone`, `former_academy`, `student_promotion`, `consult_attachment`, `School`, `code_master` |
| `consultService` | `consult`, `schedule_event`, `schedule_category`, `student_info`, `code_master` |
| `scheduleService` | `v_schedule_event_detail`, `schedule_event`, `schedule_category`, `schedule_event_type`, `consult` |
| `calendarService` | `consult`, `promotion`, `student_info`, `code_master` (조회 전용) |
| `dashboardService` | `consult`, `student_info`, `code_master` (조회 전용) |
| `promotionService` | `promotion`, `student_promotion`, `student_info`, `ParentPhone`, `School`, `code_master` |
| `classService` | `Class`, `ClassInfo`, `ClassMember` |
| `classTypeService` | `class_type`, `class_type_teacher` |
| `mgmtDataService` | `mgmt_data`, `class_type`, `student_info`, `School` |
| `schoolService` | `School`, `student_info` |
| `tcService` | `tc_info`, `code_master` |

---

## 8. 알아둘 점

### DDL이 없는 컬럼 (주의)

`student_info`의 아래 컬럼들은 **API가 쓰고 있지만 저장소의 어떤 SQL 스크립트에도 정의가 없습니다.** 운영 DB에 직접 추가된 것으로 보입니다.

| 컬럼 | 용도 |
|---|---|
| `subject_code` | 문의 과목 비트마스크 |
| `class_type_code` | 반 유형 (`CLASS_COMP` 종합반, `CLASS_SINGLE` 단과반, `CLASS_SPECIAL` 특강, `CLASS_ETC` 기타) |
| `enroll_start_date` | 수강 시작일 |
| `enroll_end_date` | 수강 종료일 |

새 환경에 `schema.sql`만으로 스키마를 올리면 학생 조회 쿼리가 "Unknown column"으로 깨집니다. 신규 구축 시 운영 DB에서 `SHOW CREATE TABLE student_info`를 떠서 대조하세요.

같은 이유로 `Class` / `ClassInfo` / `ClassMember`도 DDL이 없습니다 (5장 참고).

### soft delete

대부분의 테이블에 `deleted_at`이 있고, 조회 시 `deleted_at IS NULL` 조건이 붙습니다. 물리 삭제가 아닙니다. `v_schedule_event_detail` 뷰에도 이 조건이 들어 있습니다.

### 미사용 뷰

`views_triggers.sql`에 아래 6개 뷰가 정의돼 있지만 **API 코드에서 아무도 참조하지 않습니다**. 각 서비스가 직접 조인 쿼리를 씁니다.

`v_student_detail`, `v_consult_detail`, `v_funnel_stats`, `v_tc_performance`, `v_today_tasks`, `v_monthly_register_stats`

통계 화면을 손볼 일이 생기면 재활용할 여지가 있습니다. 단, 정의 시점 이후 컬럼이 추가됐을 수 있으니 쓰기 전에 최신 스키마와 대조하세요.

### 스키마 변경 배포 순서

**마이그레이션 → API 재빌드(`npm run build`) 및 재시작 → 웹 빌드/배포 → 하드 리로드(Ctrl+Shift+R)**

순서가 뒤집히면 새 코드가 아직 없는 컬럼을 조회해 500이 납니다. 웹은 `flutter_service_worker.js`가 이전 번들을 캐싱하므로 하드 리로드가 필요합니다.

### 마이그레이션 스크립트

`server/database/alter_*.sql`이 시간순 변경 이력 역할을 합니다. 별도 마이그레이션 도구는 쓰지 않으며, `mysql` CLI로 직접 실행합니다.

```bash
mysql -u <user> -p jysk < server/database/alter_schedule_status.sql
```
