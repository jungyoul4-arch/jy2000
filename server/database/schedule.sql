-- ============================================================
-- 일정 캘린더 시스템 (Schedule Calendar System)
-- MySQL DDL Script
-- Database: jysk
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 일정 카테고리 테이블
-- ============================================================
CREATE TABLE IF NOT EXISTS schedule_category (
    category_id     INT AUTO_INCREMENT PRIMARY KEY COMMENT '카테고리 ID',
    category_name   VARCHAR(50) NOT NULL COMMENT '카테고리명 (상담자 이슈, 신입생, 10-11 등)',
    category_type   VARCHAR(20) NOT NULL COMMENT '카테고리 유형 (INFO, TIME_SLOT, ISSUE, OTHER)',
    sort_order      INT DEFAULT 0 COMMENT '표시 순서',
    is_active       TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at      DATETIME NULL COMMENT '삭제일시 (soft delete)',

    INDEX idx_category_type (category_type),
    INDEX idx_sort_order (sort_order),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='일정 캘린더 카테고리';

-- ============================================================
-- 2. 일정 유형 테이블 (색상 구분)
-- ============================================================
CREATE TABLE IF NOT EXISTS schedule_event_type (
    event_type_id   INT AUTO_INCREMENT PRIMARY KEY COMMENT '일정 유형 ID',
    event_type_name VARCHAR(50) NOT NULL COMMENT '유형명 (상담, 설명회, 수납, 기타)',
    color_code      VARCHAR(20) NOT NULL COMMENT '배경색 (#FFFF00, #FF69B4 등)',
    sort_order      INT DEFAULT 0 COMMENT '정렬 순서',
    is_active       TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='일정 유형 (색상)';

-- ============================================================
-- 3. 일정 이벤트 테이블
-- ============================================================
CREATE TABLE IF NOT EXISTS schedule_event (
    event_id        INT AUTO_INCREMENT PRIMARY KEY COMMENT '일정 ID',
    category_id     INT NOT NULL COMMENT 'FK: schedule_category',
    event_type_id   INT NOT NULL COMMENT 'FK: schedule_event_type',
    event_date      DATE NOT NULL COMMENT '일정 날짜',
    event_hour      TINYINT NULL COMMENT '일정 시 (10~21, 시간대 슬롯이 아닌 카테고리에서 사용)',
    event_minute    TINYINT DEFAULT 0 COMMENT '일정 분 (0, 10, 20, 30, 40, 50)',
    content         TEXT COMMENT '일정 내용',
    is_important    TINYINT(1) DEFAULT 0 COMMENT '중요 일정 여부 (0: 일반, 1: 중요)',
    event_status    VARCHAR(20) NOT NULL DEFAULT 'NORMAL' COMMENT '일정 상태 (NORMAL: 예정, COMPLETED: 완료, CANCELLED: 취소)',
    student_id      INT NULL COMMENT 'FK: User (학생 연동시)',
    tc_id           INT NULL COMMENT 'FK: User (상담자)',
    consult_id      INT NULL COMMENT 'FK: consult (자동 생성된 상담 기록)',
    created_by      INT NOT NULL COMMENT 'FK: User (작성자)',
    updated_by      INT NULL COMMENT 'FK: User (수정자)',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    deleted_at      DATETIME NULL COMMENT '삭제일시 (soft delete)',

    FOREIGN KEY (category_id) REFERENCES schedule_category(category_id),
    FOREIGN KEY (event_type_id) REFERENCES schedule_event_type(event_type_id),
    FOREIGN KEY (student_id) REFERENCES User(user_id),
    FOREIGN KEY (tc_id) REFERENCES User(user_id),
    FOREIGN KEY (consult_id) REFERENCES consult(consult_id),
    FOREIGN KEY (created_by) REFERENCES User(user_id),
    FOREIGN KEY (updated_by) REFERENCES User(user_id),
    INDEX idx_event_date (event_date),
    INDEX idx_date_category (event_date, category_id),
    INDEX idx_student (student_id),
    INDEX idx_consult (consult_id),
    INDEX idx_created_by (created_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='일정 이벤트';

-- ============================================================
-- 4. 초기 데이터 - 카테고리
-- ============================================================
INSERT INTO schedule_category (category_name, category_type, sort_order) VALUES
-- 정보성 카테고리
('상담자 이슈', 'INFO', 1),
('신입생', 'INFO', 2),
-- 시간대별 슬롯 (10시~22시)
('10-11', 'TIME_SLOT', 3),
('11-12', 'TIME_SLOT', 4),
('12-1', 'TIME_SLOT', 5),
('1-2', 'TIME_SLOT', 6),
('2-3', 'TIME_SLOT', 7),
('3-4', 'TIME_SLOT', 8),
('4-5', 'TIME_SLOT', 9),
('5-6', 'TIME_SLOT', 10),
('6-7', 'TIME_SLOT', 11),
('7-8', 'TIME_SLOT', 12),
('8-9', 'TIME_SLOT', 13),
('9-10', 'TIME_SLOT', 14),
-- 전화상담 (시간대 슬롯 아래)
('전화상담', 'CONSULT', 15),
-- 설명회 카테고리 (특수)
('설명회', 'PROMOTION', 16),
-- 정보성 카테고리 (계속)
('전일부재', 'INFO', 17),
-- 업무/이슈 카테고리
('시간지정', 'ISSUE', 18),
('신입문의', 'ISSUE', 19),
('재학생문의', 'ISSUE', 20),
('대면상담 후 팔로우업', 'ISSUE', 21),
('결제예정', 'ISSUE', 22),
('조교할일', 'ISSUE', 23),
('정산관련', 'ISSUE', 24),
('꼭 처리 필요 건', 'ISSUE', 25);

-- ============================================================
-- 5. 초기 데이터 - 일정 유형 (색상)
-- ============================================================
INSERT INTO schedule_event_type (event_type_name, color_code, sort_order) VALUES
('상담', '#FFFF00', 1),        -- 노란색
('설명회', '#FF69B4', 2),      -- 분홍색
('수납/결제', '#90EE90', 3),   -- 연두색
('행정', '#87CEEB', 4),        -- 하늘색
('기타', '#D3D3D3', 5);        -- 회색

-- ============================================================
-- 6. 일정 상세 조회 뷰
-- ============================================================
CREATE OR REPLACE VIEW v_schedule_event_detail AS
SELECT
    se.event_id,
    se.category_id,
    sc.category_name,
    sc.category_type,
    se.event_type_id,
    st.event_type_name,
    st.color_code,
    se.event_date,
    se.event_hour,
    se.event_minute,
    se.content,
    se.is_important,
    se.event_status,
    se.student_id,
    su.name AS student_name,
    su.phone AS student_phone,
    su.grade AS student_grade,
    CASE su.grade
        WHEN 1 THEN '초1' WHEN 2 THEN '초2' WHEN 3 THEN '초3'
        WHEN 4 THEN '초4' WHEN 5 THEN '초5' WHEN 6 THEN '초6'
        WHEN 7 THEN '중1' WHEN 8 THEN '중2' WHEN 9 THEN '중3'
        WHEN 10 THEN '고1' WHEN 11 THEN '고2' WHEN 12 THEN '고3'
        WHEN 13 THEN 'N수생' WHEN 14 THEN '성인'
        ELSE NULL
    END AS grade_name,
    sch.school_name,
    se.tc_id,
    tcu.name AS tc_name,
    se.consult_id,
    c.consult_date,
    c.consult_type_code,
    ctc.code_name AS consult_type_name,
    se.created_by,
    cu.name AS created_by_name,
    se.updated_by,
    uu.name AS updated_by_name,
    se.created_at,
    se.updated_at
FROM schedule_event se
JOIN schedule_category sc ON se.category_id = sc.category_id
JOIN schedule_event_type st ON se.event_type_id = st.event_type_id
JOIN User cu ON se.created_by = cu.user_id
LEFT JOIN User su ON se.student_id = su.user_id
LEFT JOIN student_info si ON se.student_id = si.student_id
LEFT JOIN School sch ON si.school_id = sch.school_id
LEFT JOIN User tcu ON se.tc_id = tcu.user_id
LEFT JOIN consult c ON se.consult_id = c.consult_id
LEFT JOIN code_master ctc ON c.consult_type_code = ctc.code_id
LEFT JOIN User uu ON se.updated_by = uu.user_id
WHERE se.deleted_at IS NULL;
