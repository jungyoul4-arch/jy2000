-- ============================================================
-- 일정 캘린더에 시(event_hour) 추가
-- 시간대 슬롯 카테고리는 카테고리명에서 시각을 알 수 있지만,
-- '전화상담' 카테고리는 시각 정보가 없어 별도로 저장해야 한다.
-- ============================================================

USE jysk;

-- 1. schedule_event 테이블에 event_hour 컬럼 추가
ALTER TABLE schedule_event
ADD COLUMN event_hour TINYINT NULL COMMENT '일정 시 (10~21, 시간대 슬롯이 아닌 카테고리에서 사용)'
AFTER event_date;

-- 2. v_schedule_event_detail 뷰 재생성 (event_hour 포함)
DROP VIEW IF EXISTS v_schedule_event_detail;

CREATE VIEW v_schedule_event_detail AS
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
LEFT JOIN User uu ON se.updated_by = uu.user_id
WHERE se.deleted_at IS NULL;
