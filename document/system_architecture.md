# 학생 상담 관리 시스템 - 시스템 아키텍처

## 1. 시스템 구성도

```
┌─────────────────────────────────────────────────────────────────┐
│                        Client Layer                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │
│  │ Flutter Desktop │  │ Flutter Desktop │  │   Web Admin     │  │
│  │    (Windows)    │  │     (macOS)     │  │   Dashboard     │  │
│  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘  │
└───────────┼────────────────────┼────────────────────┼───────────┘
            │                    │                    │
            └────────────────────┼────────────────────┘
                                 │ HTTPS (REST API)
                                 ▼
┌─────────────────────────────────────────────────────────────────┐
│                        Server Layer                              │
│                    jungyoul.com (116.125.120.84)                │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    Apache (Reverse Proxy)                │    │
│  │                         Port 80/443                      │    │
│  └─────────────────────────┬───────────────────────────────┘    │
│                            │                                     │
│  ┌─────────────────────────▼───────────────────────────────┐    │
│  │                   Apache Tomcat + PHP                    │    │
│  │                      REST API Server                     │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐      │    │
│  │  │   Auth API  │  │ Student API │  │ Report API  │      │    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘      │    │
│  └─────────────────────────┬───────────────────────────────┘    │
│                            │                                     │
│  ┌─────────────────────────▼───────────────────────────────┐    │
│  │                       MySQL 8.0                          │    │
│  │                    student_counseling                    │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. DB 구조 (MySQL)

### 2.1 핵심 테이블 구조

#### 공통 테이블

```sql
-- 코드 마스터 (enum 대신 사용)
CREATE TABLE code_master (
    code_id VARCHAR(20) PRIMARY KEY,
    code_group VARCHAR(50) NOT NULL,      -- 코드 그룹 (STATUS, GRADE, SUBJECT 등)
    code_value VARCHAR(50) NOT NULL,      -- 코드 값
    code_name VARCHAR(100) NOT NULL,      -- 표시 이름
    sort_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 사용자/직원
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    login_id VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    role_code VARCHAR(20) NOT NULL,       -- FK: code_master (ROLE)
    phone VARCHAR(20),
    email VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### 학생/고객 관리

```sql
-- 학생 기본 정보
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    gender_code VARCHAR(20),              -- FK: code_master (GENDER)
    school_name VARCHAR(100),
    grade_code VARCHAR(20),               -- FK: code_master (GRADE)
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    status_code VARCHAR(20) NOT NULL,     -- FK: code_master (STUDENT_STATUS)
    -- 상담/등록/재원/퇴원
    counseling_date DATE,                 -- 최초 상담일
    register_date DATE,                   -- 등록일
    withdraw_date DATE,                   -- 퇴원일
    created_by INT,                       -- FK: users
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 학부모/보호자 정보
CREATE TABLE guardians (
    guardian_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,              -- FK: students
    guardian_name VARCHAR(50) NOT NULL,
    relation_code VARCHAR(20),            -- FK: code_master (RELATION)
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    is_primary BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 상태 변경 히스토리 (모든 상태 변경 기록)
CREATE TABLE student_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,              -- FK: students
    prev_status_code VARCHAR(20),
    new_status_code VARCHAR(20) NOT NULL,
    change_reason TEXT,
    changed_by INT NOT NULL,              -- FK: users
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### 상담 관리

```sql
-- 상담 기록
CREATE TABLE counselings (
    counseling_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,              -- FK: students
    counseling_type_code VARCHAR(20),     -- FK: code_master (COUNSEL_TYPE)
    counseling_date DATETIME NOT NULL,
    counselor_id INT NOT NULL,            -- FK: users (상담사)
    channel_code VARCHAR(20),             -- FK: code_master (CHANNEL) 방문/전화/온라인
    content TEXT,
    result_code VARCHAR(20),              -- FK: code_master (COUNSEL_RESULT)
    next_action TEXT,
    next_counseling_date DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 상담 첨부파일
CREATE TABLE counseling_attachments (
    attachment_id INT AUTO_INCREMENT PRIMARY KEY,
    counseling_id INT NOT NULL,           -- FK: counselings
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### 등록/수강 관리

```sql
-- 과목/반
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    subject_code VARCHAR(20),             -- FK: code_master (SUBJECT)
    teacher_id INT,                       -- FK: users
    capacity INT DEFAULT 20,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 수강 등록
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,              -- FK: students
    class_id INT NOT NULL,                -- FK: classes
    start_date DATE NOT NULL,
    end_date DATE,
    status_code VARCHAR(20) NOT NULL,     -- FK: code_master (ENROLL_STATUS)
    monthly_fee DECIMAL(10,0),
    created_by INT,                       -- FK: users
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 수강 상태 히스토리
CREATE TABLE enrollment_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    prev_status_code VARCHAR(20),
    new_status_code VARCHAR(20) NOT NULL,
    change_reason TEXT,
    changed_by INT NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### 결제/수납 관리

```sql
-- 결제 내역
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,              -- FK: students
    enrollment_id INT,                    -- FK: enrollments
    payment_type_code VARCHAR(20),        -- FK: code_master (PAYMENT_TYPE)
    amount DECIMAL(10,0) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method_code VARCHAR(20),      -- FK: code_master (PAYMENT_METHOD)
    receipt_no VARCHAR(50),
    memo TEXT,
    created_by INT,                       -- FK: users
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### 2.2 코드 마스터 그룹

| code_group | 설명 | 예시 값 |
|------------|------|---------|
| ROLE | 사용자 역할 | ADMIN, COUNSELOR, TEACHER |
| GENDER | 성별 | MALE, FEMALE |
| GRADE | 학년 | ELEM_1 ~ ELEM_6, MID_1 ~ MID_3, HIGH_1 ~ HIGH_3 |
| STUDENT_STATUS | 학생 상태 | PROSPECT, COUNSELING, REGISTERED, ENROLLED, WITHDRAWN |
| COUNSEL_TYPE | 상담 유형 | INITIAL, FOLLOW_UP, RE_COUNSEL |
| CHANNEL | 상담 채널 | VISIT, PHONE, ONLINE |
| COUNSEL_RESULT | 상담 결과 | PENDING, REGISTERED, DEFERRED, LOST |
| SUBJECT | 과목 | MATH, ENGLISH, KOREAN, SCIENCE |
| ENROLL_STATUS | 수강 상태 | ACTIVE, PAUSED, COMPLETED, CANCELLED |
| PAYMENT_TYPE | 결제 유형 | TUITION, MATERIAL, REFUND |
| PAYMENT_METHOD | 결제 수단 | CASH, CARD, TRANSFER |
| RELATION | 보호자 관계 | FATHER, MOTHER, GRANDFATHER, OTHER |

### 2.3 학생 상태 흐름 (Funnel)

```
PROSPECT (잠재) → COUNSELING (상담중) → REGISTERED (등록) → ENROLLED (재원) → WITHDRAWN (퇴원)
                       ↓                      ↓
                    LOST (이탈)           DEFERRED (보류)
```

---

## 3. API 구조 (REST)

### 3.1 API 기본 구조

**Base URL:** `https://jungyoul.com/api/v1`

**공통 응답 형식:**
```json
{
    "success": true,
    "code": 200,
    "message": "Success",
    "data": { ... },
    "meta": {
        "total": 100,
        "page": 1,
        "per_page": 20
    }
}
```

**에러 응답:**
```json
{
    "success": false,
    "code": 400,
    "message": "Validation Error",
    "errors": [
        {"field": "email", "message": "Invalid email format"}
    ]
}
```

### 3.2 API 엔드포인트

#### 인증 (Auth)
| Method | Endpoint | 설명 |
|--------|----------|------|
| POST | /auth/login | 로그인 |
| POST | /auth/logout | 로그아웃 |
| POST | /auth/refresh | 토큰 갱신 |
| GET | /auth/me | 현재 사용자 정보 |

#### 코드 마스터 (Codes)
| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | /codes | 전체 코드 목록 |
| GET | /codes/{group} | 그룹별 코드 목록 |

#### 학생 (Students)
| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | /students | 학생 목록 (필터, 페이징) |
| GET | /students/{id} | 학생 상세 |
| POST | /students | 학생 등록 |
| PUT | /students/{id} | 학생 수정 |
| PATCH | /students/{id}/status | 상태 변경 |
| GET | /students/{id}/history | 상태 변경 이력 |
| GET | /students/{id}/guardians | 보호자 목록 |
| POST | /students/{id}/guardians | 보호자 추가 |

#### 상담 (Counselings)
| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | /counselings | 상담 목록 |
| GET | /counselings/{id} | 상담 상세 |
| POST | /counselings | 상담 등록 |
| PUT | /counselings/{id} | 상담 수정 |
| GET | /students/{id}/counselings | 학생별 상담 이력 |

#### 수강 (Enrollments)
| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | /enrollments | 수강 목록 |
| POST | /enrollments | 수강 등록 |
| PATCH | /enrollments/{id}/status | 수강 상태 변경 |
| GET | /students/{id}/enrollments | 학생별 수강 목록 |

#### 결제 (Payments)
| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | /payments | 결제 목록 |
| POST | /payments | 결제 등록 |
| GET | /students/{id}/payments | 학생별 결제 내역 |

#### 대시보드/통계 (Dashboard)
| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | /dashboard/summary | 요약 통계 |
| GET | /dashboard/funnel | 퍼널 분석 |
| GET | /dashboard/kpi | KPI 지표 |
| GET | /reports/monthly | 월별 리포트 |

### 3.3 필터/페이징 파라미터

```
GET /students?status=ENROLLED&grade=MID_1&page=1&per_page=20&sort=created_at&order=desc
```

| 파라미터 | 설명 |
|----------|------|
| page | 페이지 번호 (기본: 1) |
| per_page | 페이지당 항목 수 (기본: 20) |
| sort | 정렬 필드 |
| order | 정렬 방향 (asc/desc) |
| search | 검색어 (이름, 전화번호) |
| status | 상태 필터 |
| from_date, to_date | 날짜 범위 |

---

## 4. Flutter 앱 구조

### 4.1 폴더 구조

```
client/lib/
├── main.dart                    # 앱 진입점
├── app.dart                     # MaterialApp 설정
│
├── config/                      # 설정
│   ├── api_config.dart          # API URL, 타임아웃 등
│   ├── app_config.dart          # 앱 설정
│   └── routes.dart              # 라우트 정의
│
├── core/                        # 핵심 기능
│   ├── api/
│   │   ├── api_client.dart      # HTTP 클라이언트 (dio)
│   │   ├── api_response.dart    # 응답 모델
│   │   └── api_exception.dart   # 예외 처리
│   ├── auth/
│   │   ├── auth_service.dart    # 인증 서비스
│   │   └── auth_state.dart      # 인증 상태
│   └── utils/
│       ├── validators.dart      # 입력 검증
│       └── formatters.dart      # 포맷터 (날짜, 금액)
│
├── models/                      # 데이터 모델
│   ├── code_master.dart
│   ├── user.dart
│   ├── student.dart
│   ├── guardian.dart
│   ├── counseling.dart
│   ├── enrollment.dart
│   └── payment.dart
│
├── repositories/                # 데이터 레포지토리
│   ├── base_repository.dart
│   ├── auth_repository.dart
│   ├── code_repository.dart
│   ├── student_repository.dart
│   ├── counseling_repository.dart
│   └── payment_repository.dart
│
├── providers/                   # 상태 관리 (Riverpod)
│   ├── auth_provider.dart
│   ├── code_provider.dart
│   ├── student_provider.dart
│   ├── counseling_provider.dart
│   └── dashboard_provider.dart
│
├── screens/                     # 화면
│   ├── auth/
│   │   └── login_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── student/
│   │   ├── student_list_screen.dart
│   │   ├── student_detail_screen.dart
│   │   └── student_form_screen.dart
│   ├── counseling/
│   │   ├── counseling_list_screen.dart
│   │   └── counseling_form_screen.dart
│   ├── enrollment/
│   │   └── enrollment_screen.dart
│   ├── payment/
│   │   └── payment_screen.dart
│   └── dashboard/
│       └── dashboard_screen.dart
│
└── widgets/                     # 공통 위젯
    ├── common/
    │   ├── app_scaffold.dart
    │   ├── loading_widget.dart
    │   ├── error_widget.dart
    │   └── empty_widget.dart
    ├── forms/
    │   ├── text_input.dart
    │   ├── dropdown_input.dart
    │   ├── date_picker.dart
    │   └── phone_input.dart
    ├── cards/
    │   ├── student_card.dart
    │   └── counseling_card.dart
    └── dialogs/
        ├── confirm_dialog.dart
        └── status_change_dialog.dart
```

### 4.2 주요 의존성

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter

  # 상태 관리
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

  # HTTP 통신
  dio: ^5.4.0
  retrofit: ^4.0.0

  # 로컬 저장소
  shared_preferences: ^2.2.0
  hive: ^2.2.3

  # UI
  flutter_form_builder: ^9.1.0
  form_builder_validators: ^9.1.0
  data_table_2: ^2.5.0
  fl_chart: ^0.66.0
  intl: ^0.19.0

  # 유틸
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.0
  go_router: ^13.0.0

dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  retrofit_generator: ^8.0.0
  riverpod_generator: ^2.3.0
```

### 4.3 데이터 모델 예시

```dart
// models/student.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required int studentId,
    required String studentName,
    String? birthDate,
    String? genderCode,
    String? schoolName,
    String? gradeCode,
    String? phone,
    String? email,
    String? address,
    required String statusCode,
    String? counselingDate,
    String? registerDate,
    String? withdrawDate,
    String? createdAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
```

### 4.4 화면 흐름

```
┌─────────────┐
│   로그인     │
└──────┬──────┘
       ▼
┌─────────────┐
│    홈       │ ← 좌측 네비게이션
├─────────────┤
│ - 대시보드   │ → 요약 통계, 오늘 할 일
│ - 학생 관리  │ → 목록 → 상세 → 등록/수정
│ - 상담 관리  │ → 목록 → 상담 입력
│ - 수강 관리  │ → 수강 등록/변경
│ - 결제 관리  │ → 결제 내역
│ - 리포트    │ → KPI, 퍼널 차트
└─────────────┘
```

---

## 5. 개발 단계 (Phase)

### Phase 1: 기반 구축
- [ ] MySQL DB 스키마 생성
- [ ] PHP REST API 기본 구조
- [ ] Flutter 프로젝트 기본 구조
- [ ] 인증 (로그인/로그아웃)

### Phase 2: 핵심 기능
- [ ] 학생 CRUD
- [ ] 상담 CRUD
- [ ] 상태 변경 및 히스토리

### Phase 3: 확장 기능
- [ ] 수강 등록/관리
- [ ] 결제 관리

### Phase 4: 분석/리포트
- [ ] 대시보드
- [ ] KPI 지표
- [ ] 퍼널 분석

---

## 6. 보안 고려사항

1. **인증**: JWT 토큰 기반 인증
2. **HTTPS**: 모든 API 통신 암호화
3. **비밀번호**: bcrypt 해싱
4. **SQL Injection**: Prepared Statement 사용
5. **입력 검증**: 서버/클라이언트 양쪽에서 검증
