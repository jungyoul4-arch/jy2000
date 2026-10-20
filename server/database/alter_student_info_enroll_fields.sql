-- ============================================================
-- student_info 수강 컬럼
--
-- 학생 목록/상세/등록이 읽는 컬럼이다. 저장소 schema.sql 에 빠져 있어
-- 이 스크립트 없이 만든 DB 에서는 GET /student/list 가
-- Unknown column 's.class_type_code' 로 실패한다.
--
-- 정율서버에 이미 있는 컬럼은 건너뛴다. 없는 컬럼만 추가한다.
-- 적용: mysql jysk < server/database/alter_student_info_enroll_fields.sql
-- ============================================================

USE jysk;

SET @db := DATABASE();

SET @c := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'student_info' AND COLUMN_NAME = 'class_type_code'
);
SET @sql := IF(@c = 0,
  'ALTER TABLE student_info ADD COLUMN class_type_code VARCHAR(30) NULL COMMENT ''반 유형 (CLASS_COMP/CLASS_SINGLE/CLASS_SPECIAL/CLASS_ETC)'' AFTER sub_status_code',
  'SELECT ''skip class_type_code''');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @c := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'student_info' AND COLUMN_NAME = 'subject_code'
);
SET @sql := IF(@c = 0,
  'ALTER TABLE student_info ADD COLUMN subject_code INT NULL COMMENT ''과목 비트마스크'' AFTER class_type_code',
  'SELECT ''skip subject_code''');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @c := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'student_info' AND COLUMN_NAME = 'enroll_start_date'
);
SET @sql := IF(@c = 0,
  'ALTER TABLE student_info ADD COLUMN enroll_start_date DATE NULL COMMENT ''수강 시작일'' AFTER enroll_date',
  'SELECT ''skip enroll_start_date''');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @c := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'student_info' AND COLUMN_NAME = 'enroll_end_date'
);
SET @sql := IF(@c = 0,
  'ALTER TABLE student_info ADD COLUMN enroll_end_date DATE NULL COMMENT ''수강 종료일'' AFTER enroll_start_date',
  'SELECT ''skip enroll_end_date''');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

INSERT IGNORE INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('CLASS_COMP', 'CLASS_TYPE', 'COMP', '종합반', 1),
('CLASS_SINGLE', 'CLASS_TYPE', 'SINGLE', '단과반', 2),
('CLASS_SPECIAL', 'CLASS_TYPE', 'SPECIAL', '특강', 3),
('CLASS_ETC', 'CLASS_TYPE', 'ETC', '기타', 4);
