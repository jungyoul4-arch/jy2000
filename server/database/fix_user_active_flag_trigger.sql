-- ============================================================
-- trg_user_active_flag_change 수정
--   User.active_flag 변경 시 student_info.status_code를 무조건 덮어쓰던 것을,
--   이미 플래그와 맞는 상태면 건드리지 않도록 변경
--
-- 배경
--   학생 상태 변경(API studentService.changeState)은 student_info.status_code를
--   먼저 쓰고 그 다음 User.active_flag를 맞춘다. 기존 트리거는 active_flag가
--   0 -> 1이 되면 status_code를 무조건 'STATUS_ENROLLED'로 덮어써서,
--   '등록'을 고른 학생이 '재원'으로 바뀌고 student_history에도 불필요한
--   '재원' 이력이 한 줄 더 남았다.
--
-- 바뀐 조건 (활성화 분기만 수정)
--   active_flag 0 -> 1 : 이미 등록/재원이면 그대로 둠, 그 외에는 재원으로 변경
--   active_flag 1 -> 0 : 기존과 동일 (재원인 경우에만 퇴원으로 변경)
--                        -> '이탈'로 바꾼 학생은 이미 STATUS_LOST라 덮어쓰지 않음
--
-- 정율톡 등 외부에서 active_flag만 바꾸는 경로의 동기화 동작은 그대로 유지된다.
--
-- 실행 순서: 이 스크립트 -> server/api 재빌드(npm run build) -> API 재시작
--   순서가 뒤집히면 그 사이에 '등록'/'이탈'로 바꾼 학생이
--   '재원'/'퇴원'으로 덮어써진다.
-- ============================================================

USE jysk;

-- 1. 수정 전 트리거 확인
SHOW TRIGGERS LIKE 'User';

-- 2. 트리거 재생성
DROP TRIGGER IF EXISTS trg_user_active_flag_change;

DELIMITER //

CREATE TRIGGER trg_user_active_flag_change
AFTER UPDATE ON User
FOR EACH ROW
BEGIN
    IF NEW.kind = 2 AND OLD.active_flag != NEW.active_flag THEN
        IF NEW.active_flag = 1 THEN
            -- 활성화: 재원으로 변경 (이미 등록/재원이면 건드리지 않음)
            UPDATE student_info
            SET status_code = 'STATUS_ENROLLED',
                enroll_date = COALESCE(enroll_date, CURDATE())
            WHERE student_id = NEW.user_id
              AND status_code NOT IN ('STATUS_ENROLLED', 'STATUS_REGISTER');
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

-- 3. 수정 후 확인 (ACTION_STATEMENT에 NOT IN 조건이 보여야 함)
SHOW TRIGGERS LIKE 'User';

-- 4. 상태와 active_flag가 어긋난 기존 학생 확인 (필요하면 아래 5번으로 보정)
SELECT
    CASE
        WHEN s.status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED') THEN '등록/재원인데 active_flag=0'
        ELSE '퇴원/이탈인데 active_flag=1'
    END AS mismatch,
    COUNT(*) AS cnt
FROM student_info s
JOIN User u ON s.student_id = u.user_id
WHERE u.kind = 2
  AND s.deleted_at IS NULL
  AND (
       (s.status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED') AND u.active_flag <> 1)
    OR (s.status_code IN ('STATUS_WITHDRAW', 'STATUS_LOST') AND u.active_flag <> 0)
  )
GROUP BY mismatch;

-- 5. 기존 데이터 보정 (4번 결과를 확인한 뒤 필요할 때만 실행)
--    student_info.status_code를 기준으로 User.active_flag를 맞춘다.
--    트리거는 active_flag가 "바뀔 때"만 돌고, 바뀐 뒤 상태는 이미
--    플래그와 맞으므로 status_code가 다시 덮어써지지 않는다.
--
-- UPDATE User u
-- JOIN student_info s ON s.student_id = u.user_id
-- SET u.active_flag = CASE
--         WHEN s.status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED') THEN 1
--         ELSE 0
--     END
-- WHERE u.kind = 2
--   AND s.deleted_at IS NULL
--   AND s.status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED', 'STATUS_WITHDRAW', 'STATUS_LOST')
--   AND u.active_flag <> CASE
--         WHEN s.status_code IN ('STATUS_REGISTER', 'STATUS_ENROLLED') THEN 1
--         ELSE 0
--     END;
