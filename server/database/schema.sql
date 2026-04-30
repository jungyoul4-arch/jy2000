-- ============================================================
-- 학생 상담 관리 시스템 (Student Counseling Management System)
-- MySQL DDL Script
-- Database: jysk
-- ============================================================

-- 기존 DB 사용 (jysk)
-- CREATE DATABASE IF NOT EXISTS jysk
--     DEFAULT CHARACTER SET utf8mb4
--     DEFAULT COLLATE utf8mb4_unicode_ci;

USE jysk;

-- ============================================================
-- 1. 코드 마스터 테이블
-- ============================================================
CREATE TABLE code_master (
    code_id         VARCHAR(30) NOT NULL COMMENT '코드 ID (GROUP_VALUE 형식)',
    code_group      VARCHAR(50) NOT NULL COMMENT '코드 그룹',
    code_value      VARCHAR(50) NOT NULL COMMENT '코드 값',
    code_name       VARCHAR(100) NOT NULL COMMENT '코드 표시명',
    code_name_en    VARCHAR(100) NULL COMMENT '코드 영문명',
    parent_code_id  VARCHAR(30) NULL COMMENT '상위 코드 ID',
    sort_order      INT DEFAULT 0 COMMENT '정렬 순서',
    description     VARCHAR(500) NULL COMMENT '코드 설명',
    is_active       TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at      DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (code_id),
    INDEX idx_code_group (code_group),
    INDEX idx_code_group_active (code_group, is_active),
    INDEX idx_parent_code (parent_code_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='코드 마스터';

-- ============================================================
-- 2. 사용자 테이블 (이미 있다고 가정, 참조용)
-- ============================================================
CREATE TABLE IF NOT EXISTS User (
    user_id         INT AUTO_INCREMENT COMMENT '사용자 ID',
    user_pw_hash    VARCHAR(255) NOT NULL COMMENT '비밀번호 해시',
    name            VARCHAR(50) NOT NULL COMMENT '사용자명',
    kind            TINYINT NOT NULL COMMENT '사용자 유형 (1=관리자, 2=학생, 3=선생님, 4=학부모, 5=상담원)',
    phone           VARCHAR(20) NOT NULL COMMENT '전화번호 (로그인 ID)',
    email           VARCHAR(100) NULL COMMENT '이메일',
    department      VARCHAR(100) NULL COMMENT '부서',
    active_flag     TINYINT(1) DEFAULT 1 COMMENT '활성화 여부 (1=활성)',
    last_login_dt   DATETIME NULL COMMENT '마지막 로그인 일시',
    reg_dt          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at      DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (user_id),
    UNIQUE INDEX idx_phone (phone),
    INDEX idx_kind (kind),
    INDEX idx_active_flag (active_flag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='사용자';

-- ============================================================
-- 3. TC 정보 테이블 (상담사/텔레마케터)
-- ============================================================
CREATE TABLE tc_info (
    tc_id           INT AUTO_INCREMENT COMMENT 'TC ID',
    user_id         INT NOT NULL COMMENT '사용자 ID (FK: User) - 이름/전화/이메일은 User 테이블 참조',
    tc_code         VARCHAR(20) NULL COMMENT 'TC 코드 (사번)',
    tc_type_code    VARCHAR(30) NULL COMMENT 'TC 유형 (FK: code_master)',
    branch_code     VARCHAR(30) NULL COMMENT '지점 코드 (FK: code_master)',
    hire_date       DATE NULL COMMENT '입사일',
    resign_date     DATE NULL COMMENT '퇴사일',
    is_active       TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at      DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (tc_id),
    INDEX idx_user_id (user_id),
    INDEX idx_tc_code (tc_code),
    INDEX idx_branch_code (branch_code),
    INDEX idx_is_active (is_active),

    CONSTRAINT fk_tc_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='TC(상담사/텔레마케터) 정보';

-- ============================================================
-- 4. 학교 테이블
-- ============================================================
CREATE TABLE School (
    school_id       INT AUTO_INCREMENT COMMENT '학교 ID',
    school_name     VARCHAR(100) NOT NULL COMMENT '학교명 (중, 고로 끝남)',
    school_kind     TINYINT NOT NULL COMMENT '학교 종류 (1=중학교, 2=고등학교)',
    region_kind     TINYINT NOT NULL COMMENT '학교 권역 (1=원미권, 2=소사권,3=오정권, 4=인천권, 5=서울권, 6=경기기타권,99=기타)',
    is_active       TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at      DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (school_id),
    UNIQUE INDEX idx_school_name (school_name),
    INDEX idx_school_kind (school_kind),
    INDEX idx_region_kind (region_kind),
    INDEX idx_is_active (is_active),
    INDEX idx_deleted_at (deleted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='학교';

-- ============================================================
-- 5. 학생 정보 테이블
-- ============================================================
CREATE TABLE student_info (
    student_id          INT NOT NULL COMMENT '학생 ID (FK: User.user_id) - 이름/전화/이메일은 User 테이블 참조',

    -- 추가 연락처
    phone_sub           VARCHAR(20) NULL COMMENT '보조 전화번호',

    -- 학생 상세 (grade는 User 테이블에서 관리, 보호자는 ParentPhone 테이블에서 관리)
    birth_date          DATE NULL COMMENT '생년월일',
    gender_code         VARCHAR(30) NULL COMMENT '성별 (FK: code_master)',
    school_id           INT NULL COMMENT '학교 ID (FK: school)',
    school_name         VARCHAR(100) NULL COMMENT '학교명 (school_id가 없을 때 직접 입력)',

    -- 주소
    zip_code            VARCHAR(10) NULL COMMENT '우편번호',
    address             VARCHAR(200) NULL COMMENT '주소',
    address_detail      VARCHAR(200) NULL COMMENT '상세주소',

    -- 상태 정보
    status_code         VARCHAR(30) NOT NULL DEFAULT 'STATUS_PROSPECT' COMMENT '학생 상태 (FK: code_master)',
    sub_status_code     VARCHAR(30) NULL COMMENT '세부 상태 (FK: code_master)',

    -- 유입 경로
    source_code         VARCHAR(30) NULL COMMENT '유입 경로 (FK: code_master)',
    source_detail       VARCHAR(200) NULL COMMENT '유입 경로 상세',

    -- 담당자 (User.role_code = 'ROLE_TC'인 사용자)
    tc_id               INT NULL COMMENT '담당 TC (FK: User.user_id)',

    -- 주요 일자
    first_contact_date  DATE NULL COMMENT '최초 접촉일',
    consult_date        DATE NULL COMMENT '상담일',
    register_date       DATE NULL COMMENT '등록일',
    enroll_date         DATE NULL COMMENT '재원 시작일',
    withdraw_date       DATE NULL COMMENT '퇴원일',

    -- 메모
    memo                TEXT NULL COMMENT '메모',

    -- 시스템 필드
    created_by          INT NULL COMMENT '생성자 (FK: User)',
    updated_by          INT NULL COMMENT '수정자 (FK: User)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (student_id),
    INDEX idx_status_code (status_code),
    INDEX idx_tc_id (tc_id),
    INDEX idx_school_id (school_id),
    INDEX idx_source_code (source_code),
    INDEX idx_first_contact_date (first_contact_date),
    INDEX idx_register_date (register_date),
    INDEX idx_created_at (created_at),
    INDEX idx_deleted_at (deleted_at),

    CONSTRAINT fk_student_user FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_student_school FOREIGN KEY (school_id) REFERENCES School(school_id) ON DELETE SET NULL,
    CONSTRAINT fk_student_tc FOREIGN KEY (tc_id) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_student_created_by FOREIGN KEY (created_by) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_student_updated_by FOREIGN KEY (updated_by) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='학생 정보';

-- ============================================================
-- 5-1. 보호자-학생 연결 테이블
-- ============================================================
CREATE TABLE ParentPhone (
    parent_id           INT NOT NULL COMMENT '보호자 ID (FK: User.user_id, kind=4)',
    student_id          INT NOT NULL COMMENT '학생 ID (FK: User.user_id, kind=2)',
    phone               VARCHAR(20) NOT NULL COMMENT '보호자 전화번호',
    seq                 TINYINT NOT NULL DEFAULT 1 COMMENT '보호자 순번 (1, 2, ...)',
    parent_kind         TINYINT NOT NULL DEFAULT 2 COMMENT '보호자 관계 (1=부, 2=모, 3=친척, 99=기타)',

    reg_dt              DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',

    PRIMARY KEY (parent_id, student_id),
    INDEX idx_student_id (student_id),
    INDEX idx_phone (phone),

    CONSTRAINT fk_parentphone_parent FOREIGN KEY (parent_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_parentphone_student FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='보호자-학생 연결';

-- ============================================================
-- 6. 학생 상태 변경 이력 테이블
-- ============================================================
CREATE TABLE student_history (
    history_id          INT AUTO_INCREMENT COMMENT '이력 ID',
    student_id          INT NOT NULL COMMENT '학생 ID (FK: User)',

    -- 상태 변경
    prev_status_code    VARCHAR(30) NULL COMMENT '이전 상태',
    new_status_code     VARCHAR(30) NOT NULL COMMENT '변경 상태',
    prev_sub_status     VARCHAR(30) NULL COMMENT '이전 세부 상태',
    new_sub_status      VARCHAR(30) NULL COMMENT '변경 세부 상태',

    -- 변경 정보
    change_type_code    VARCHAR(30) NOT NULL COMMENT '변경 유형 (FK: code_master)',
    change_reason_code  VARCHAR(30) NULL COMMENT '변경 사유 (FK: code_master)',
    change_reason       TEXT NULL COMMENT '변경 사유 상세',

    -- 담당자 변경
    prev_tc_id          INT NULL COMMENT '이전 담당 TC (FK: User.user_id)',
    new_tc_id           INT NULL COMMENT '변경 담당 TC (FK: User.user_id)',

    -- 시스템 필드
    changed_by          INT NOT NULL COMMENT '변경자 (FK: User)',
    changed_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '변경일시',

    PRIMARY KEY (history_id),
    INDEX idx_student_id (student_id),
    INDEX idx_new_status_code (new_status_code),
    INDEX idx_change_type_code (change_type_code),
    INDEX idx_changed_at (changed_at),
    INDEX idx_changed_by (changed_by),

    CONSTRAINT fk_history_student FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_history_changed_by FOREIGN KEY (changed_by) REFERENCES User(user_id) ON DELETE RESTRICT,
    CONSTRAINT fk_history_prev_tc FOREIGN KEY (prev_tc_id) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_history_new_tc FOREIGN KEY (new_tc_id) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='학생 상태 변경 이력';

-- ============================================================
-- 6. 상담 테이블
-- ============================================================
CREATE TABLE consult (
    consult_id          INT AUTO_INCREMENT COMMENT '상담 ID',
    student_id          INT NOT NULL COMMENT '학생 ID (FK: User)',

    -- 상담 정보
    consult_type_code   VARCHAR(30) NOT NULL COMMENT '상담 유형 (FK: code_master)',
    consult_date        DATETIME NOT NULL COMMENT '상담 일시',
    consult_duration    INT NULL COMMENT '상담 시간 (분)',

    -- 상담 채널/방법
    channel_code        VARCHAR(30) NULL COMMENT '상담 채널 (FK: code_master)',

    -- 담당자 (User.role_code = 'ROLE_TC'인 사용자)
    tc_id               INT NULL COMMENT '상담 TC (FK: User.user_id)',

    -- 상담 내용
    content             TEXT NULL COMMENT '상담 내용',
    student_needs       TEXT NULL COMMENT '학생 니즈/요구사항',
    consult_result_code VARCHAR(30) NULL COMMENT '상담 결과 (FK: code_master)',
    result_detail       TEXT NULL COMMENT '결과 상세',

    -- 후속 조치
    next_action_code    VARCHAR(30) NULL COMMENT '후속 조치 (FK: code_master)',
    next_action_detail  TEXT NULL COMMENT '후속 조치 상세',
    next_consult_date   DATETIME NULL COMMENT '다음 상담 예정일',

    -- 관심 과목/프로그램
    interest_subject    VARCHAR(200) NULL COMMENT '관심 과목',
    interest_program    VARCHAR(200) NULL COMMENT '관심 프로그램',

    -- 시스템 필드
    created_by          INT NULL COMMENT '생성자 (FK: User)',
    updated_by          INT NULL COMMENT '수정자 (FK: User)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (consult_id),
    INDEX idx_student_id (student_id),
    INDEX idx_consult_type_code (consult_type_code),
    INDEX idx_consult_date (consult_date),
    INDEX idx_tc_id (tc_id),
    INDEX idx_consult_result_code (consult_result_code),
    INDEX idx_next_consult_date (next_consult_date),
    INDEX idx_created_at (created_at),
    INDEX idx_deleted_at (deleted_at),

    CONSTRAINT fk_consult_student FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_consult_tc FOREIGN KEY (tc_id) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_consult_created_by FOREIGN KEY (created_by) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_consult_updated_by FOREIGN KEY (updated_by) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='상담';

-- ============================================================
-- 7. 프로모션 테이블
-- ============================================================
CREATE TABLE promotion (
    promotion_id        INT AUTO_INCREMENT COMMENT '프로모션 ID',

    -- 프로모션 정보
    promotion_name      VARCHAR(200) NOT NULL COMMENT '프로모션명',
    promotion_code      VARCHAR(50) NULL COMMENT '프로모션 코드',
    promotion_type_code VARCHAR(30) NULL COMMENT '프로모션 유형 (FK: code_master)',

    -- 기간
    start_date          DATE NOT NULL COMMENT '시작일',
    end_date            DATE NULL COMMENT '종료일',

    -- 내용
    description         TEXT NULL COMMENT '프로모션 설명',
    discount_type_code  VARCHAR(30) NULL COMMENT '할인 유형 (FK: code_master)',
    discount_value      DECIMAL(10,2) NULL COMMENT '할인 값',

    -- 대상
    target_grade        VARCHAR(100) NULL COMMENT '대상 학년',
    target_subject      VARCHAR(100) NULL COMMENT '대상 과목',

    -- 상태
    is_active           TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',

    -- 시스템 필드
    created_by          INT NULL COMMENT '생성자 (FK: User)',
    updated_by          INT NULL COMMENT '수정자 (FK: User)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (promotion_id),
    UNIQUE INDEX idx_promotion_code (promotion_code),
    INDEX idx_promotion_type_code (promotion_type_code),
    INDEX idx_start_date (start_date),
    INDEX idx_end_date (end_date),
    INDEX idx_is_active (is_active),
    INDEX idx_deleted_at (deleted_at),

    CONSTRAINT fk_promotion_created_by FOREIGN KEY (created_by) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_promotion_updated_by FOREIGN KEY (updated_by) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='프로모션';

-- ============================================================
-- 8. 학생-프로모션 연결 테이블
-- ============================================================
CREATE TABLE student_promotion (
    id                  INT AUTO_INCREMENT COMMENT 'ID',
    student_id          INT NOT NULL COMMENT '학생 ID (FK: User)',
    promotion_id        INT NOT NULL COMMENT '프로모션 ID (FK: promotion)',
    applied_date        DATE NOT NULL COMMENT '적용일',
    applied_amount      DECIMAL(10,2) NULL COMMENT '적용 금액',
    memo                VARCHAR(500) NULL COMMENT '메모',

    created_by          INT NULL COMMENT '생성자 (FK: User)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',

    PRIMARY KEY (id),
    INDEX idx_student_id (student_id),
    INDEX idx_promotion_id (promotion_id),
    INDEX idx_applied_date (applied_date),

    CONSTRAINT fk_sp_student FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_sp_promotion FOREIGN KEY (promotion_id) REFERENCES promotion(promotion_id) ON DELETE CASCADE,
    CONSTRAINT fk_sp_created_by FOREIGN KEY (created_by) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='학생-프로모션 연결';

-- ============================================================
-- 9. 이전 학원 정보 테이블
-- ============================================================
CREATE TABLE former_academy (
    former_id           INT AUTO_INCREMENT COMMENT 'ID',
    student_id          INT NOT NULL COMMENT '학생 ID (FK: User)',

    -- 학원 정보
    academy_name        VARCHAR(200) NOT NULL COMMENT '학원명',
    academy_type_code   VARCHAR(30) NULL COMMENT '학원 유형 (FK: code_master)',
    subject             VARCHAR(100) NULL COMMENT '수강 과목',

    -- 수강 기간
    start_date          DATE NULL COMMENT '수강 시작일',
    end_date            DATE NULL COMMENT '수강 종료일',
    duration_months     INT NULL COMMENT '수강 기간 (개월)',

    -- 상세
    monthly_fee         DECIMAL(10,0) NULL COMMENT '월 수강료',
    leave_reason_code   VARCHAR(30) NULL COMMENT '퇴원 사유 (FK: code_master)',
    leave_reason_detail TEXT NULL COMMENT '퇴원 사유 상세',
    satisfaction_code   VARCHAR(30) NULL COMMENT '만족도 (FK: code_master)',
    memo                TEXT NULL COMMENT '메모',

    -- 시스템 필드
    created_by          INT NULL COMMENT '생성자 (FK: User)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (former_id),
    INDEX idx_student_id (student_id),
    INDEX idx_academy_name (academy_name),
    INDEX idx_academy_type_code (academy_type_code),
    INDEX idx_deleted_at (deleted_at),

    CONSTRAINT fk_former_student FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_former_created_by FOREIGN KEY (created_by) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='이전 학원 정보';

-- ============================================================
-- 10. 상담 첨부파일 테이블
-- ============================================================
CREATE TABLE consult_attachment (
    attachment_id       INT AUTO_INCREMENT COMMENT '첨부파일 ID',
    consult_id          INT NOT NULL COMMENT '상담 ID (FK: consult)',

    file_name           VARCHAR(255) NOT NULL COMMENT '원본 파일명',
    file_path           VARCHAR(500) NOT NULL COMMENT '저장 경로',
    file_size           INT NULL COMMENT '파일 크기 (bytes)',
    file_type           VARCHAR(100) NULL COMMENT '파일 타입 (MIME)',

    created_by          INT NULL COMMENT '생성자 (FK: User)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (attachment_id),
    INDEX idx_consult_id (consult_id),
    INDEX idx_deleted_at (deleted_at),

    CONSTRAINT fk_attach_consult FOREIGN KEY (consult_id) REFERENCES consult(consult_id) ON DELETE CASCADE,
    CONSTRAINT fk_attach_created_by FOREIGN KEY (created_by) REFERENCES User(user_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='상담 첨부파일';
