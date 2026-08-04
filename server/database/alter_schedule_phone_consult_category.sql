-- ============================================================
-- 일정 캘린더에 '전화상담' 카테고리 추가
-- 위치: 마지막 시간대 슬롯(9-10) 바로 아래
-- ============================================================

USE jysk;

-- 9-10 슬롯의 정렬 순서를 기준으로 삼는다 (시드 데이터가 바뀌어도 안전하게)
SET @slot_order = (
  SELECT sort_order FROM schedule_category
  WHERE category_name = '9-10' AND deleted_at IS NULL
  LIMIT 1
);

-- 이미 추가되어 있으면 건너뛴다
SET @exists = (
  SELECT COUNT(*) FROM schedule_category
  WHERE category_name = '전화상담' AND deleted_at IS NULL
);

-- 1. 9-10 이후 카테고리들의 정렬 순서를 한 칸 밀어낸다
UPDATE schedule_category
SET sort_order = sort_order + 1
WHERE @exists = 0
  AND @slot_order IS NOT NULL
  AND sort_order > @slot_order;

-- 2. '전화상담' 카테고리를 9-10 바로 다음 순서로 추가
INSERT INTO schedule_category (category_name, category_type, sort_order)
SELECT '전화상담', 'CONSULT', @slot_order + 1
WHERE @exists = 0 AND @slot_order IS NOT NULL;
