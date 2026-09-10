-- ============================================================
-- 재원생 월 스냅샷 (경영 대시보드용)
--
-- 재원생 DB 엑셀(aca2000 월말 추출)을 월 단위로 굳혀 두는 테이블.
-- 대시보드가 엑셀 파일이 아니라 이 테이블을 읽는다.
--
-- mgmt_data와 나눠 둔 이유:
--   mgmt_data는 납입이력 기반이라 목적이 매출 계산이고, 과목이
--   '과학' 한 덩어리로 뭉쳐 있어 과학 세부 분석을 할 수 없다.
--   여기는 재원 스냅샷이라 통합과학/물리/화학/생명/지구과학을 나눠 담는다.
--
-- 저장 단위가 '학생 × 과목'이 아니라 '학생 × 과목 × 반'인 이유:
--   한 학생의 한 과목 칸에 반이 둘 이상 들어간다(정규 + 특강 병행).
--   2월 1,587건 / 8월 1,576건이 그렇게 부푼 것이라 실측으로 확인했다.
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 스냅샷 헤더 — 월 1행
-- ============================================================
CREATE TABLE IF NOT EXISTS enroll_snapshot (
    snapshot_id     INT AUTO_INCREMENT COMMENT '스냅샷 ID',
    year            INT NOT NULL COMMENT '년도',
    month           INT NOT NULL COMMENT '월',

    as_of_date      DATE NULL COMMENT '기준일 (월말이 원칙이나 월중 추출도 있어 실제 날짜를 남긴다)',
    source_kind     VARCHAR(10) NOT NULL DEFAULT 'excel' COMMENT '출처 (excel=엑셀 적재, db=DB에서 굳힘)',
    source_file     VARCHAR(255) NULL COMMENT '원본 파일명',
    file_hash       CHAR(32) NULL COMMENT '원본 md5 — 같은 파일 재업로드 차단용',
    source_note     VARCHAR(200) NULL COMMENT '비고 (예: 6월 데이터 재사용)',

    student_count   INT NOT NULL DEFAULT 0 COMMENT '재원생 수',
    row_count       INT NOT NULL DEFAULT 0 COMMENT '수강 행수 (학생×과목×반)',

    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',

    PRIMARY KEY (snapshot_id),
    UNIQUE INDEX idx_year_month (year, month),
    INDEX idx_file_hash (file_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
COMMENT='재원생 월 스냅샷 헤더';

-- ============================================================
-- 2. 스냅샷 상세 — 학생 × 과목 × 반 1행
-- ============================================================
CREATE TABLE IF NOT EXISTS enroll_snapshot_row (
    row_id          BIGINT AUTO_INCREMENT COMMENT '행 ID',
    snapshot_id     INT NOT NULL COMMENT '스냅샷 ID (FK)',

    -- 조회 편의를 위해 year/month를 헤더에서 복사해 둔다.
    -- 대시보드 쿼리가 전부 년월로 걸리는데 매번 조인하면 느리다.
    year            INT NOT NULL COMMENT '년도',
    month           INT NOT NULL COMMENT '월',

    -- 학생
    -- student_name은 엑셀 원본 표기를 그대로 둔다. 동명이인을
    -- '김나경A'/'김나경B'로 구분해 둔 덕에 월간 연결의 키 역할을 한다.
    -- User 쪽은 접미 없이 '김나경'이라 student_id 매칭은 보조 수단이다.
    student_name    VARCHAR(50) NOT NULL COMMENT '학생명 (엑셀 원본, 동명이인 접미 포함)',
    student_id      INT NULL COMMENT '학생 ID (FK: User.user_id, 매칭 실패 시 NULL)',
    school_name     VARCHAR(100) NULL COMMENT '학교명 (엑셀 원본)',
    school_id       INT NULL COMMENT '학교 ID (FK: School)',
    grade           INT NULL COMMENT '학년 (6=초6, 7~9=중1~3, 10~12=고1~3, 13=N수)',
    attend_type     VARCHAR(20) NULL COMMENT '구분 (단과/종합/약술단과/약술종합)',

    -- 과목
    -- subject는 엑셀 컬럼명 17종을 그대로 쓴다. 과학 세부를 살리는 게
    -- 이 테이블의 핵심 목적이라 여기서 뭉개면 안 된다.
    subject         VARCHAR(30) NOT NULL COMMENT '과목 (엑셀 컬럼명: 국어/통합과학/물리/약술국어/…)',
    subject_group   VARCHAR(20) NOT NULL COMMENT '과목 대분류 (국어/영어/수학/과학/사회/약술/논술)',

    -- 반
    class_name      VARCHAR(200) NULL COMMENT '반명 (엑셀 원본)',
    class_kind      VARCHAR(20) NOT NULL DEFAULT '정규' COMMENT '반 성격 (정규/내신/특강) — 반명에서 판정',

    PRIMARY KEY (row_id),
    INDEX idx_year_month (year, month),
    INDEX idx_ym_student (year, month, student_name),
    INDEX idx_ym_subject (year, month, subject),
    INDEX idx_ym_class (year, month, class_name),
    INDEX idx_ym_kind (year, month, class_kind),
    INDEX idx_snapshot (snapshot_id),

    CONSTRAINT fk_esr_snapshot FOREIGN KEY (snapshot_id)
        REFERENCES enroll_snapshot(snapshot_id) ON DELETE CASCADE,
    CONSTRAINT fk_esr_student FOREIGN KEY (student_id)
        REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_esr_school FOREIGN KEY (school_id)
        REFERENCES School(school_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
COMMENT='재원생 월 스냅샷 상세 (학생×과목×반)';

-- ============================================================
-- 3. 담당 강사 — 공동 담당이 흔해 별도 행으로 편다
--
-- 엑셀은 '박주연·지성현'처럼 한 칸에 묶어 두는데, 대시보드의
-- 「강사별 월간 수강 증감」·「강사별 생존율」이 강사 단위 집계라
-- 문자열로 두면 매번 쪼개야 한다. 적재할 때 한 번만 편다.
-- ============================================================
CREATE TABLE IF NOT EXISTS enroll_snapshot_teacher (
    row_id          BIGINT NOT NULL COMMENT '수강 행 ID (FK)',
    teacher_name    VARCHAR(50) NOT NULL COMMENT '강사명 (엑셀 원본)',
    teacher_id      INT NULL COMMENT '강사 ID (FK: User.user_id, 매칭 실패 시 NULL)',

    -- 조회 편의용 비정규화. 강사별 집계가 년월로 걸린다.
    year            INT NOT NULL COMMENT '년도',
    month           INT NOT NULL COMMENT '월',

    PRIMARY KEY (row_id, teacher_name),
    INDEX idx_ym_teacher (year, month, teacher_name),

    CONSTRAINT fk_est_row FOREIGN KEY (row_id)
        REFERENCES enroll_snapshot_row(row_id) ON DELETE CASCADE,
    CONSTRAINT fk_est_teacher FOREIGN KEY (teacher_id)
        REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
COMMENT='재원생 월 스냅샷 담당 강사';
