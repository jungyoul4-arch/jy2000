-- ============================================================
-- 신규생 문의(초기상담) 특별 취급 지원
--
-- 1. 상담 유형 '초기상담' -> '신규생 문의' 용어 수정
-- 2. 문의경로 코드그룹(INQUIRY_SOURCE) 신설
-- 3. consult 테이블에 inquiry_source_code / selector_name 컬럼 추가
-- 4. 문의 과목 비트마스크에 논술 3종 추가 (student_info.subject_code)
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 상담 유형 용어 수정: 초기상담 -> 신규생 문의
--    code_id는 그대로 두므로 기존 consult 레코드는 영향 없음
-- ============================================================
UPDATE code_master
SET code_name = '신규생 문의',
    description = '신규생 문의 (구 초기상담)'
WHERE code_id = 'CONSULT_TYPE_INITIAL';

-- ============================================================
-- 2. 문의경로 코드그룹 신설 (INQUIRY_SOURCE)
--    기존 SOURCE(유입경로: 지인소개/블로그/맘카페 등)와는 별개.
--    SOURCE는 학생 단위 유입경로, INQUIRY_SOURCE는 문의 건별 경로.
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('INQUIRY_PHONE',     'INQUIRY_SOURCE', 'PHONE',     '전화',     1),
('INQUIRY_HOMEPAGE',  'INQUIRY_SOURCE', 'HOMEPAGE',  '홈페이지', 2),
('INQUIRY_VISIT',     'INQUIRY_SOURCE', 'VISIT',     '방문',     3),
('INQUIRY_CHANNEL',   'INQUIRY_SOURCE', 'CHANNEL',   '채널',     4),
('INQUIRY_NAVER',     'INQUIRY_SOURCE', 'NAVER',     '네이버',   5),
('INQUIRY_PROMOTION', 'INQUIRY_SOURCE', 'PROMOTION', '설명회 후', 6),
('INQUIRY_OTHER',     'INQUIRY_SOURCE', 'OTHER',     '기타',    99)
ON DUPLICATE KEY UPDATE
  code_name = VALUES(code_name),
  sort_order = VALUES(sort_order);

-- ============================================================
-- 3. consult 테이블 컬럼 추가
--    inquiry_source_code : 문의경로 (FK: code_master, INQUIRY_SOURCE 그룹)
--    selector_name       : 선정자(담당 부원장) 이름. User에 없는 사람도 적을 수 있어 텍스트
-- ============================================================
ALTER TABLE consult
ADD COLUMN inquiry_source_code VARCHAR(30) NULL
    COMMENT '문의경로 (FK: code_master, INQUIRY_SOURCE)'
AFTER channel_code,
ADD COLUMN selector_name VARCHAR(50) NULL
    COMMENT '선정자(담당 부원장) 이름'
AFTER tc_id;

CREATE INDEX idx_inquiry_source_code ON consult (inquiry_source_code);

-- ============================================================
-- 4. 문의 과목 비트마스크 (student_info.subject_code) 값 정의
--    기존: 1=국어, 2=수학, 4=영어, 8=과학, 16=사회, 32=기타
--    추가: 64=약술형 논술, 128=인문 논술, 256=수리 논술
--
--    컬럼 자체는 이미 존재하므로 DDL 변경은 없다.
--    subject_code는 code_master 코드가 아니라 비트마스크 정수이며,
--    표시명은 클라이언트(SubjectCode)에서 비트를 풀어 생성한다.
--    ※ student_info.subject_code는 저장소 DDL에 정의가 없는 컬럼이다
--      (document/database_schema.md 8장 참고). 아래로 존재를 확인할 것.
-- ============================================================
-- SHOW COLUMNS FROM student_info LIKE 'subject_code';

-- ============================================================
-- 확인
-- ============================================================
SELECT code_id, code_group, code_name, sort_order
FROM code_master
WHERE code_id = 'CONSULT_TYPE_INITIAL'
   OR code_group = 'INQUIRY_SOURCE'
ORDER BY code_group, sort_order;

SHOW COLUMNS FROM consult LIKE 'inquiry_source_code';
SHOW COLUMNS FROM consult LIKE 'selector_name';
