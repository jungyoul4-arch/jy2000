-- ============================================================
-- 뷰 및 트리거
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 학생 상세 뷰 (코드명 포함) - User 테이블 JOIN
-- grade는 User 테이블, 보호자는 ParentPhone 테이블에서 조회
-- ============================================================
CREATE OR REPLACE VIEW v_student_detail AS
SELECT
    s.student_id,
    u.name AS student_name,
    u.phone,
    s.phone_sub,
    u.email,
    s.birth_date,
    s.gender_code,
    g.code_name AS gender_name,
    s.school_id,
    sch.school_name,
    u.grade,
    CASE u.grade
        WHEN 1 THEN '초1' WHEN 2 THEN '초2' WHEN 3 THEN '초3'
        WHEN 4 THEN '초4' WHEN 5 THEN '초5' WHEN 6 THEN '초6'
        WHEN 7 THEN '중1' WHEN 8 THEN '중2' WHEN 9 THEN '중3'
        WHEN 10 THEN '고1' WHEN 11 THEN '고2' WHEN 12 THEN '고3'
        WHEN 13 THEN 'N수생' WHEN 14 THEN '성인'
        ELSE NULL
    END AS grade_name,
    p.name AS guardian_name,
    pp.phone AS guardian_phone,
    pp.parent_kind AS guardian_relation,
    CASE pp.parent_kind
        WHEN 1 THEN '부' WHEN 2 THEN '모' WHEN 3 THEN '친척' WHEN 99 THEN '기타'
        ELSE NULL
    END AS relation_name,
    s.zip_code,
    s.address,
    s.address_detail,
    s.status_code,
    st.code_name AS status_name,
    s.sub_status_code,
    sub.code_name AS sub_status_name,
    s.source_code,
    src.code_name AS source_name,
    s.source_detail,
    s.tc_id,
    tc.name AS tc_name,
    s.first_contact_date,
    s.consult_date,
    s.register_date,
    s.enroll_date,
    s.withdraw_date,
    s.memo,
    s.created_at,
    s.updated_at
FROM student_info s
JOIN User u ON s.student_id = u.user_id
LEFT JOIN School sch ON s.school_id = sch.school_id
LEFT JOIN code_master g ON s.gender_code = g.code_id
LEFT JOIN code_master st ON s.status_code = st.code_id
LEFT JOIN code_master sub ON s.sub_status_code = sub.code_id
LEFT JOIN code_master src ON s.source_code = src.code_id
LEFT JOIN User tc ON s.tc_id = tc.user_id
LEFT JOIN ParentPhone pp ON pp.student_id = s.student_id AND pp.seq = 1
LEFT JOIN User p ON pp.parent_id = p.user_id
WHERE u.active_flag = 1;

-- ============================================================
-- 2. 상담 상세 뷰 - User 테이블 JOIN
-- ============================================================
CREATE OR REPLACE VIEW v_consult_detail AS
SELECT
    c.consult_id,
    c.student_id,
    u.name AS student_name,
    u.phone AS student_phone,
    c.consult_type_code,
    ct.code_name AS consult_type_name,
    c.consult_date,
    c.consult_duration,
    c.channel_code,
    ch.code_name AS channel_name,
    c.tc_id,
    tc.name AS tc_name,
    c.content,
    c.student_needs,
    c.consult_result_code,
    cr.code_name AS consult_result_name,
    c.result_detail,
    c.next_action_code,
    na.code_name AS next_action_name,
    c.next_action_detail,
    c.next_consult_date,
    c.interest_subject,
    c.interest_program,
    c.created_at,
    c.updated_at
FROM consult c
JOIN User u ON c.student_id = u.user_id
LEFT JOIN code_master ct ON c.consult_type_code = ct.code_id
LEFT JOIN code_master ch ON c.channel_code = ch.code_id
LEFT JOIN code_master cr ON c.consult_result_code = cr.code_id
LEFT JOIN code_master na ON c.next_action_code = na.code_id
LEFT JOIN User tc ON c.tc_id = tc.user_id
WHERE 1=1;

-- ============================================================
-- 3. 퍼널 통계 뷰 (상태별 학생 수)
-- ============================================================
CREATE OR REPLACE VIEW v_funnel_stats AS
SELECT
    s.status_code,
    cm.code_name AS status_name,
    cm.sort_order,
    COUNT(*) AS student_count
FROM student_info s
JOIN code_master cm ON s.status_code = cm.code_id
WHERE cm.code_group = 'STATUS'
GROUP BY s.status_code, cm.code_name, cm.sort_order
ORDER BY cm.sort_order;

-- ============================================================
-- 4. TC별 실적 뷰 - User 테이블에서 role_code='ROLE_TC'인 사용자
-- ============================================================
CREATE OR REPLACE VIEW v_tc_performance AS
SELECT
    u.user_id AS tc_id,
    u.name AS tc_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    SUM(CASE WHEN s.status_code = 'STATUS_PROSPECT' THEN 1 ELSE 0 END) AS prospect_count,
    SUM(CASE WHEN s.status_code = 'STATUS_CONSULT_DONE' THEN 1 ELSE 0 END) AS consult_count,
    SUM(CASE WHEN s.status_code = 'STATUS_REGISTER' THEN 1 ELSE 0 END) AS register_count,
    SUM(CASE WHEN s.status_code = 'STATUS_ENROLLED' THEN 1 ELSE 0 END) AS enrolled_count,
    COUNT(DISTINCT c.consult_id) AS consult_total
FROM User u
LEFT JOIN student_info s ON u.user_id = s.tc_id
LEFT JOIN consult c ON u.user_id = c.tc_id
WHERE u.kind = 5 AND u.active_flag = 1
GROUP BY u.user_id, u.name;

-- ============================================================
-- 5. 오늘 할 일 뷰 (오늘 예정된 상담) - User 테이블 JOIN
-- ============================================================
CREATE OR REPLACE VIEW v_today_tasks AS
SELECT
    c.consult_id,
    c.student_id,
    u.name AS student_name,
    u.phone,
    c.next_consult_date,
    c.next_action_code,
    na.code_name AS next_action_name,
    c.next_action_detail,
    c.tc_id,
    tc.name AS tc_name
FROM consult c
JOIN User u ON c.student_id = u.user_id
LEFT JOIN code_master na ON c.next_action_code = na.code_id
LEFT JOIN User tc ON c.tc_id = tc.user_id
WHERE DATE(c.next_consult_date) = CURDATE()
  AND c.next_action_code IS NOT NULL
  AND c.next_action_code != 'ACTION_NONE'
ORDER BY c.next_consult_date;

-- ============================================================
-- 6. 월별 등록 통계 뷰
-- ============================================================
CREATE OR REPLACE VIEW v_monthly_register_stats AS
SELECT
    DATE_FORMAT(register_date, '%Y-%m') AS month,
    COUNT(*) AS register_count
FROM student_info
WHERE register_date IS NOT NULL
GROUP BY DATE_FORMAT(register_date, '%Y-%m')
ORDER BY month DESC;

-- ============================================================
-- TRIGGERS
-- ============================================================

-- 기존 트리거 삭제 (재생성을 위해)
DROP TRIGGER IF EXISTS trg_student_status_change;
DROP TRIGGER IF EXISTS trg_student_date_auto;
DROP TRIGGER IF EXISTS trg_student_first_contact;
DROP TRIGGER IF EXISTS trg_user_student_insert;
DROP TRIGGER IF EXISTS trg_user_active_flag_change;
DROP TRIGGER IF EXISTS trg_sync_user_active_on_update;
DROP TRIGGER IF EXISTS trg_sync_user_active_on_insert;

-- ============================================================
-- 트리거 1: 학생 상태 변경 시 자동 히스토리 기록
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_student_status_change
AFTER UPDATE ON student_info
FOR EACH ROW
BEGIN
    -- 상태가 변경된 경우에만 기록
    IF OLD.status_code != NEW.status_code OR
       (OLD.sub_status_code IS NULL AND NEW.sub_status_code IS NOT NULL) OR
       (OLD.sub_status_code IS NOT NULL AND NEW.sub_status_code IS NULL) OR
       (OLD.sub_status_code != NEW.sub_status_code) THEN

        INSERT INTO student_history (
            student_id,
            prev_status_code,
            new_status_code,
            prev_sub_status,
            new_sub_status,
            change_type_code,
            prev_tc_id,
            new_tc_id,
            changed_by
        ) VALUES (
            NEW.student_id,
            OLD.status_code,
            NEW.status_code,
            OLD.sub_status_code,
            NEW.sub_status_code,
            'CHANGE_STATUS',
            OLD.tc_id,
            NEW.tc_id,
            COALESCE(NEW.updated_by, (SELECT MIN(user_id) FROM User WHERE kind = 1))
        );
    END IF;

    -- 담당자가 변경된 경우 기록
    IF (OLD.tc_id IS NULL AND NEW.tc_id IS NOT NULL) OR
       (OLD.tc_id IS NOT NULL AND NEW.tc_id IS NULL) OR
       (OLD.tc_id != NEW.tc_id) THEN

        INSERT INTO student_history (
            student_id,
            prev_status_code,
            new_status_code,
            change_type_code,
            prev_tc_id,
            new_tc_id,
            changed_by
        ) VALUES (
            NEW.student_id,
            NEW.status_code,
            NEW.status_code,
            'CHANGE_TC',
            OLD.tc_id,
            NEW.tc_id,
            COALESCE(NEW.updated_by, (SELECT MIN(user_id) FROM User WHERE kind = 1))
        );
    END IF;
END//

DELIMITER ;

-- ============================================================
-- 트리거 2: 학생 등록 시 상태에 따른 날짜 자동 설정
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_student_date_auto
BEFORE UPDATE ON student_info
FOR EACH ROW
BEGIN
    -- 등록 상태로 변경 시 register_date 자동 설정
    IF OLD.status_code != 'STATUS_REGISTER' AND NEW.status_code = 'STATUS_REGISTER' THEN
        IF NEW.register_date IS NULL THEN
            SET NEW.register_date = CURDATE();
        END IF;
    END IF;

    -- 재원 상태로 변경 시 enroll_date 자동 설정
    IF OLD.status_code != 'STATUS_ENROLLED' AND NEW.status_code = 'STATUS_ENROLLED' THEN
        IF NEW.enroll_date IS NULL THEN
            SET NEW.enroll_date = CURDATE();
        END IF;
    END IF;

    -- 퇴원 상태로 변경 시 withdraw_date 자동 설정
    IF OLD.status_code != 'STATUS_WITHDRAW' AND NEW.status_code = 'STATUS_WITHDRAW' THEN
        IF NEW.withdraw_date IS NULL THEN
            SET NEW.withdraw_date = CURDATE();
        END IF;
    END IF;

    -- 상담완료 상태로 변경 시 consult_date 자동 설정
    IF OLD.status_code != 'STATUS_CONSULT_DONE' AND NEW.status_code = 'STATUS_CONSULT_DONE' THEN
        IF NEW.consult_date IS NULL THEN
            SET NEW.consult_date = CURDATE();
        END IF;
    END IF;
END//

DELIMITER ;

-- ============================================================
-- 트리거 3: 신규 학생 등록 시 first_contact_date 자동 설정
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_student_first_contact
BEFORE INSERT ON student_info
FOR EACH ROW
BEGIN
    IF NEW.first_contact_date IS NULL THEN
        SET NEW.first_contact_date = CURDATE();
    END IF;
END//

DELIMITER ;

-- ============================================================
-- 트리거 4: User에 학생(kind=2) 추가 시 student_info 자동 생성
-- User 테이블이 마스터 테이블로서 학생 데이터의 진입점 역할
-- active_flag에 따라 초기 status_code 결정
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_user_student_insert
AFTER INSERT ON User
FOR EACH ROW
BEGIN
    IF NEW.kind = 2 THEN  -- 학생인 경우
        INSERT INTO student_info (student_id, status_code)
        VALUES (NEW.user_id,
            CASE WHEN NEW.active_flag = 1 THEN 'STATUS_ENROLLED' ELSE 'STATUS_PROSPECT' END
        );
    END IF;
END//

DELIMITER ;

-- ============================================================
-- 트리거 5: User.active_flag 변경 시 student_info.status_code 동기화
-- 방향: User → student_info (User.active_flag가 마스터)
-- active_flag 1 → STATUS_ENROLLED (재원)
-- active_flag 0 → STATUS_WITHDRAW (퇴원, 기존 재원인 경우만)
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_user_active_flag_change
AFTER UPDATE ON User
FOR EACH ROW
BEGIN
    IF NEW.kind = 2 AND OLD.active_flag != NEW.active_flag THEN
        IF NEW.active_flag = 1 THEN
            -- 활성화: 재원으로 변경
            UPDATE student_info
            SET status_code = 'STATUS_ENROLLED',
                enroll_date = COALESCE(enroll_date, CURDATE())
            WHERE student_id = NEW.user_id;
        ELSE
            -- 비활성화: 퇴원으로 변경 (기존 재원인 경우만)
            UPDATE student_info
            SET status_code = 'STATUS_WITHDRAW',
                withdraw_date = COALESCE(withdraw_date, CURDATE())
            WHERE student_id = NEW.user_id
              AND status_code = 'STATUS_ENROLLED';
        END IF;
    END IF;
END//

DELIMITER ;
