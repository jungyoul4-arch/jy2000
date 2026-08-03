-- ============================================================
-- 일정 캘린더에 분(minute) 기능 추가
-- ============================================================

USE jysk;

-- 1. schedule_event 테이블에 event_minute 컬럼 추가
ALTER TABLE schedule_event
ADD COLUMN event_minute TINYINT DEFAULT 0 COMMENT '일정 분 (0, 10, 20, 30, 40, 50)'
AFTER event_date;

-- 2. v_schedule_event_detail 뷰 재생성 (학교명, 학년, 상담일시 추가)
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
    se.event_minute,
    se.content,
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
LEFT JOIN consult c ON se.consult_id = c.consult_id
LEFT JOIN User uu ON se.updated_by = uu.user_id
WHERE se.deleted_at IS NULL;
