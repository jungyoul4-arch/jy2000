-- ============================================================
-- 기존 데이터 동기화 스크립트 (1회성 실행)
-- 방향: User → student_info (User.active_flag가 마스터)
-- ============================================================

USE jysk;

-- ============================================================
-- 트리거 임시 비활성화 (동기화 중 충돌 방지)
-- ============================================================
DROP TRIGGER IF EXISTS trg_sync_user_active_on_insert;
DROP TRIGGER IF EXISTS trg_sync_user_active_on_update;
DROP TRIGGER IF EXISTS trg_user_student_insert;
DROP TRIGGER IF EXISTS trg_user_active_flag_change;
DROP TRIGGER IF EXISTS trg_student_status_change;
DROP TRIGGER IF EXISTS trg_student_date_auto;

-- ============================================================
-- 1. User에 있지만 student_info에 없는 학생 레코드 생성
-- ============================================================
INSERT INTO student_info (student_id, status_code)
SELECT user_id,
    CASE WHEN active_flag = 1 THEN 'STATUS_ENROLLED' ELSE 'STATUS_PROSPECT' END
FROM User
WHERE kind = 2
  AND user_id NOT IN (SELECT student_id FROM student_info);

-- ============================================================
-- 2. User.active_flag 기준으로 student_info.status_code 동기화
-- active_flag=1 → STATUS_ENROLLED (재원)
-- ============================================================
UPDATE student_info s
JOIN User u ON s.student_id = u.user_id
SET s.status_code = 'STATUS_ENROLLED',
    s.enroll_date = COALESCE(s.enroll_date, CURDATE())
WHERE u.kind = 2
  AND u.active_flag = 1
  AND s.status_code != 'STATUS_ENROLLED';

-- ============================================================
-- 트리거 재생성
-- ============================================================

-- 트리거 1: 학생 상태 변경 시 자동 히스토리 기록
DELIMITER //
CREATE TRIGGER trg_student_status_change
AFTER UPDATE ON student_info
FOR EACH ROW
BEGIN
    IF OLD.status_code != NEW.status_code OR
       (OLD.sub_status_code IS NULL AND NEW.sub_status_code IS NOT NULL) OR
       (OLD.sub_status_code IS NOT NULL AND NEW.sub_status_code IS NULL) OR
       (OLD.sub_status_code != NEW.sub_status_code) THEN

        INSERT INTO student_history (
            student_id, prev_status_code, new_status_code,
            prev_sub_status, new_sub_status, change_type_code,
            prev_tc_id, new_tc_id, changed_by
        ) VALUES (
            NEW.student_id, OLD.status_code, NEW.status_code,
            OLD.sub_status_code, NEW.sub_status_code, 'CHANGE_STATUS',
            OLD.tc_id, NEW.tc_id,
            COALESCE(NEW.updated_by, (SELECT MIN(user_id) FROM User WHERE kind = 1))
        );
    END IF;

    IF (OLD.tc_id IS NULL AND NEW.tc_id IS NOT NULL) OR
       (OLD.tc_id IS NOT NULL AND NEW.tc_id IS NULL) OR
       (OLD.tc_id != NEW.tc_id) THEN

        INSERT INTO student_history (
            student_id, prev_status_code, new_status_code,
            change_type_code, prev_tc_id, new_tc_id, changed_by
        ) VALUES (
            NEW.student_id, NEW.status_code, NEW.status_code,
            'CHANGE_TC', OLD.tc_id, NEW.tc_id,
            COALESCE(NEW.updated_by, (SELECT MIN(user_id) FROM User WHERE kind = 1))
        );
    END IF;
END//
DELIMITER ;

-- 트리거 2: 학생 등록 시 상태에 따른 날짜 자동 설정
DELIMITER //
CREATE TRIGGER trg_student_date_auto
BEFORE UPDATE ON student_info
FOR EACH ROW
BEGIN
    IF OLD.status_code != 'STATUS_REGISTER' AND NEW.status_code = 'STATUS_REGISTER' THEN
        IF NEW.register_date IS NULL THEN
            SET NEW.register_date = CURDATE();
        END IF;
    END IF;

    IF OLD.status_code != 'STATUS_ENROLLED' AND NEW.status_code = 'STATUS_ENROLLED' THEN
        IF NEW.enroll_date IS NULL THEN
            SET NEW.enroll_date = CURDATE();
        END IF;
    END IF;

    IF OLD.status_code != 'STATUS_WITHDRAW' AND NEW.status_code = 'STATUS_WITHDRAW' THEN
        IF NEW.withdraw_date IS NULL THEN
            SET NEW.withdraw_date = CURDATE();
        END IF;
    END IF;

    IF OLD.status_code != 'STATUS_CONSULT_DONE' AND NEW.status_code = 'STATUS_CONSULT_DONE' THEN
        IF NEW.consult_date IS NULL THEN
            SET NEW.consult_date = CURDATE();
        END IF;
    END IF;
END//
DELIMITER ;

-- 트리거: User에 학생(kind=2) 추가 시 student_info 자동 생성
DELIMITER //
CREATE TRIGGER trg_user_student_insert
AFTER INSERT ON User
FOR EACH ROW
BEGIN
    IF NEW.kind = 2 THEN
        INSERT INTO student_info (student_id, status_code)
        VALUES (NEW.user_id,
            CASE WHEN NEW.active_flag = 1 THEN 'STATUS_ENROLLED' ELSE 'STATUS_PROSPECT' END
        );
    END IF;
END//
DELIMITER ;

-- 트리거: User.active_flag 변경 시 student_info.status_code 동기화
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
            -- 비활성화: 퇴원으로 변경
            UPDATE student_info
            SET status_code = 'STATUS_WITHDRAW',
                withdraw_date = COALESCE(withdraw_date, CURDATE())
            WHERE student_id = NEW.user_id
              AND status_code = 'STATUS_ENROLLED';
        END IF;
    END IF;
END//
DELIMITER ;

-- ============================================================
-- 3. 동기화 결과 확인
-- ============================================================
SELECT
    '활성 학생 수 (User)' AS category,
    COUNT(*) AS count
FROM User
WHERE kind = 2 AND active_flag = 1 AND deleted_at IS NULL

UNION ALL

SELECT
    '재원 학생 수 (student_info)' AS category,
    COUNT(*) AS count
FROM student_info
WHERE status_code = 'STATUS_ENROLLED' AND deleted_at IS NULL;
