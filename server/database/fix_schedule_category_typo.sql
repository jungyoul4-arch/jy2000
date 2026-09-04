-- ============================================================
-- 일정 캘린더 카테고리명 오타 수정
--   '신임문의' -> '신입문의'
--
-- 저장소의 schedule.sql 초기 데이터는 처음부터 '신입문의'였으나
-- 운영 DB에 '신임문의'로 들어가 캘린더 화면에 그대로 노출됨.
-- category_id는 그대로이므로 기존 일정(schedule_event)은 영향 없음.
-- ============================================================

USE jysk;

-- 1. 수정 전 확인
SELECT category_id, category_name, category_type, sort_order
FROM schedule_category
WHERE category_name IN ('신임문의', '신입문의');

-- 2. 오타 수정
UPDATE schedule_category
SET category_name = '신입문의'
WHERE category_name = '신임문의';

-- 3. 수정 후 확인 (1건이 '신입문의'로 나와야 함)
SELECT category_id, category_name, category_type, sort_order
FROM schedule_category
WHERE category_name = '신입문의';
