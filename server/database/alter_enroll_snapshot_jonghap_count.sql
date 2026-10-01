-- ============================================================
-- 월 스냅샷에 종합반 인원수 추가
--
-- 배경
--   종합반 수를 수강 행(attend_type)에서 역산하면 '그 달 수업기록이
--   있는 반에 속한' 학생만 잡혀, 반 배정이 아직 없는 종합반생이 빠진다.
--   대시보드의 '현재'는 User를 직접 세므로 두 숫자가 어긋난다 —
--   그대로 두면 이번 달이 월말에 굳는 순간 같은 달 숫자가 바뀐다.
--
--   그래서 굳힐 때 User 기준 인원수를 헤더에 직접 적어 둔다.
--   앞으로는 cron(enrollSnapshotCron)이 매월 1일 전월을 굳히면서
--   자동으로 채운다. 이 스크립트는 컬럼을 만들고 9월분만 메운다.
--
-- 집계 기준
--   SELECT COUNT(*) FROM User
--   WHERE kind = 2 AND active_flag = 1 AND is_jonghap = 1
--
-- 실행 순서: 이 스크립트 -> server/api 재빌드 -> API 재시작 -> 웹 배포
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 컬럼 추가
-- ============================================================
ALTER TABLE enroll_snapshot
    ADD COLUMN jonghap_count INT NULL
        COMMENT '종합반 재원생 수 (굳힌 시점 User.is_jonghap 기준, NULL=집계 전)'
        AFTER row_count;

-- ============================================================
-- 2. 9월 스냅샷 보정
--
-- 9월은 is_jonghap이 생기기 전에 굳어 종합반 수가 없다.
-- 현재 값을 9월말 값으로 본다 — 그 사이 종합↔단과를 옮긴 학생이
-- 있으면 그만큼 어긋나지만, 10월 초라 차이가 크지 않다.
-- ============================================================
UPDATE enroll_snapshot
SET jonghap_count = (
        SELECT COUNT(*) FROM User
        WHERE kind = 2 AND active_flag = 1 AND is_jonghap = 1
    )
WHERE year = 2026 AND month = 9
  AND jonghap_count IS NULL;

-- ============================================================
-- 3. 확인 — 달별 재원생 / 종합반
--
-- 2~8월(엑셀)은 jonghap_count가 비어 있는 게 정상이다.
-- 그 달들은 aca2000 '구분' 칸이 원본 기록이라 대시보드가 행에서
-- 센다(jonghap_from_rows). 헤더 값이 있으면 그쪽을 먼저 쓴다.
-- ============================================================
SELECT
    s.year,
    s.month,
    s.source_kind,
    s.student_count,
    s.jonghap_count,
    COUNT(DISTINCT CASE WHEN r.attend_type LIKE '%종합%'
                        THEN r.student_name END) AS jonghap_from_rows
FROM enroll_snapshot s
LEFT JOIN enroll_snapshot_row r ON r.snapshot_id = s.snapshot_id
GROUP BY s.year, s.month, s.source_kind, s.student_count, s.jonghap_count
ORDER BY s.year, s.month;

-- ============================================================
-- 4. (선택) 9월 수강 행의 구분도 메우기
--
-- 헤더 인원수만으로 충분하면 건너뛴다. 나중에 '종합반 학년별 분포'
-- 같은 쪼갠 집계를 9월까지 보고 싶을 때만 필요하다.
-- 현재 값을 과거 행에 찍는 근사라는 점은 2번과 같다.
--
-- UPDATE enroll_snapshot_row r
-- JOIN User u ON u.user_id = r.student_id
-- SET r.attend_type = CASE WHEN u.is_jonghap = 1 THEN '종합' ELSE '단과' END
-- WHERE r.attend_type IS NULL
--   AND r.year = 2026 AND r.month = 9;
