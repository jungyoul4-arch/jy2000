-- ============================================================
-- 반 형태 관리 및 경영 보고서 테이블
-- ============================================================

USE jysk;

-- ============================================================
-- 기존 테이블 삭제 (의존성 순서대로)
-- ============================================================
DROP TABLE IF EXISTS class_type_teacher;
DROP TABLE IF EXISTS class_type;

-- ============================================================
-- 1. 반 형태 테이블 (class_type)
-- grade: 1~6=초1~초6, 7~9=중1~중3, 10~12=고1~고3
-- subject: 1=국어, 2=수학, 3=영어, 4=과학, 5=사회
-- ============================================================
CREATE TABLE class_type (
    class_type_id       INT AUTO_INCREMENT COMMENT '반형태 ID',
    class_type_name     VARCHAR(100) NOT NULL COMMENT '반형태명 (예: 2026 고등부 과학 (고1))',
    grade               INT NOT NULL COMMENT '학년 (1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3)',
    subject             INT NOT NULL COMMENT '과목 (1=국어, 2=수학, 3=영어, 4=과학, 5=사회)',
    unit_price          INT DEFAULT 0 COMMENT '단가 (원)',
    is_active           TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',

    PRIMARY KEY (class_type_id),
    UNIQUE INDEX idx_class_type_unique (class_type_name, grade, subject),
    INDEX idx_grade (grade),
    INDEX idx_subject (subject),
    INDEX idx_is_active (is_active),
    INDEX idx_deleted_at (deleted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='반 형태';

-- ============================================================
-- 2. 반 형태 - 강사 연결 테이블 (class_type_teacher)
-- teacher_id는 User.user_id의 FK (active_flag 상관없이)
-- ============================================================
CREATE TABLE class_type_teacher (
    id                  INT AUTO_INCREMENT COMMENT 'ID',
    class_type_id       INT NOT NULL COMMENT '반형태 ID (FK: class_type)',
    teacher_id          INT NOT NULL COMMENT '강사 ID (FK: User.user_id)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',

    PRIMARY KEY (id),
    INDEX idx_class_type_id (class_type_id),
    INDEX idx_teacher_id (teacher_id),

    CONSTRAINT fk_ctt_class_type FOREIGN KEY (class_type_id) REFERENCES class_type(class_type_id) ON DELETE CASCADE,
    CONSTRAINT fk_ctt_teacher FOREIGN KEY (teacher_id) REFERENCES User(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='반 형태 - 강사 연결';

-- ============================================================
-- 3. 경영 보고서 데이터 테이블 (mgmt_data)
-- 이미 생성되어 있으므로 DROP 후 재생성
-- ============================================================
DROP TABLE IF EXISTS mgmt_data;

CREATE TABLE mgmt_data (
    mgmt_data_id        INT AUTO_INCREMENT COMMENT '경영보고서 데이터 ID',
    year                INT NOT NULL COMMENT '년도',
    month               INT NOT NULL COMMENT '월',
    student_id          INT NULL COMMENT '학생 ID (FK: User.user_id, 동명이인일 경우 School 참조)',
    school_id           INT NULL COMMENT '학교 ID (FK: School.school_id)',
    grade               INT NULL COMMENT '학년 (1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3)',
    enrollment_count    DECIMAL(3,1) DEFAULT 1.0 COMMENT '수강인원 (0.5 or 1.0)',
    comp_class_type     VARCHAR(50) NULL COMMENT '종합반 종류',
    subject             VARCHAR(50) NULL COMMENT '과목',
    teacher_id          INT NULL COMMENT '강사 ID (FK: User.user_id, 강사이름으로 User에서 찾음)',
    class_name1         VARCHAR(200) NULL COMMENT '반명/교재명 (다른 테이블의 class_name과 구분)',
    class_type_id       INT NULL COMMENT '반형태 ID (FK: class_type.class_type_id)',
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',

    PRIMARY KEY (mgmt_data_id),
    INDEX idx_year_month (year, month),
    INDEX idx_student_id (student_id),
    INDEX idx_school_id (school_id),
    INDEX idx_teacher_id (teacher_id),
    INDEX idx_class_type_id (class_type_id),

    CONSTRAINT fk_mgmt_student FOREIGN KEY (student_id) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_mgmt_school FOREIGN KEY (school_id) REFERENCES School(school_id) ON DELETE SET NULL,
    CONSTRAINT fk_mgmt_teacher FOREIGN KEY (teacher_id) REFERENCES User(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_mgmt_class_type FOREIGN KEY (class_type_id) REFERENCES class_type(class_type_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='경영 보고서 데이터';
