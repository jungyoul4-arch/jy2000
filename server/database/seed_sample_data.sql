-- ============================================================
-- 샘플 데이터 (개발/테스트용)
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 관리자/TC 계정 (user_id: 1~4)
-- kind: 1=관리자, 2=학생, 3=선생님, 4=학부모, 5=상담원
-- phone이 로그인 ID 역할
-- ============================================================
INSERT INTO User (user_pw_hash, name, kind, phone, email) VALUES
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '관리자', 1, '01000000000', 'admin@jungyoul.com'),
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '김상담', 5, '01022222222', 'tc1@jungyoul.com'),
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '이상담', 5, '01033333333', 'tc2@jungyoul.com'),
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '박상담', 5, '01044444444', 'tc3@jungyoul.com');

-- 비밀번호: password (bcrypt 해시)
-- TC user_id: 김상담=2, 이상담=3, 박상담=4

-- ============================================================
-- 2. TC 추가 정보 (선택사항 - 사번, 입사일 등)
-- ============================================================
INSERT INTO tc_info (user_id, tc_code, tc_type_code, branch_code, hire_date) VALUES
(2, 'TC001', 'TC_TYPE_INBOUND', 'BRANCH_MAIN', '2024-01-15'),
(3, 'TC002', 'TC_TYPE_OUTBOUND', 'BRANCH_MAIN', '2024-03-01'),
(4, 'TC003', 'TC_TYPE_FIELD', 'BRANCH_GANGNAM', '2024-06-01');

-- ============================================================
-- 3. 학생 사용자 계정 생성 (user_id: 5~14)
-- kind=2 (학생), phone이 로그인 ID 역할, grade 포함
-- ============================================================
INSERT INTO User (user_pw_hash, name, kind, phone, email, grade) VALUES
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '홍길동', 2, '01012345678', 'hong@test.com', 6),    -- 초6
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '김철수', 2, '01023456789', 'kim@test.com', 7),    -- 중1
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '이영희', 2, '01034567890', 'lee@test.com', 8),    -- 중2
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '박민수', 2, '01045678901', 'park@test.com', 10),  -- 고1
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '최지은', 2, '01056789012', 'choi@test.com', 5),   -- 초5
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '정우성', 2, '01067890123', 'jung@test.com', 6),   -- 초6
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '강민지', 2, '01078901234', 'kang@test.com', 7),   -- 중1
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '윤서준', 2, '01089012345', 'yoon@test.com', 8),   -- 중2
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '한소희', 2, '01090123456', 'han@test.com', 11),   -- 고2
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '임재현', 2, '01001234567', 'lim@test.com', 6);    -- 초6

-- ============================================================
-- 3-1. 학부모 사용자 계정 생성 (user_id: 15~24)
-- kind=4 (학부모)
-- ============================================================
INSERT INTO User (user_pw_hash, name, kind, phone, email) VALUES
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '홍어머니', 4, '01012340001', NULL),  -- 홍길동 모
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '김아버지', 4, '01023450001', NULL),  -- 김철수 부
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '이어머니', 4, '01034560001', NULL),  -- 이영희 모
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '박어머니', 4, '01045670001', NULL),  -- 박민수 모
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '최아버지', 4, '01056780001', NULL),  -- 최지은 부
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '정어머니', 4, '01067890001', NULL),  -- 정우성 모
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '강어머니', 4, '01078900001', NULL),  -- 강민지 모
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '윤아버지', 4, '01089010001', NULL),  -- 윤서준 부
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '한어머니', 4, '01090120001', NULL),  -- 한소희 모
('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '임어머니', 4, '01001230001', NULL);  -- 임재현 모

-- ============================================================
-- 3-2. 학부모-학생 연결 (ParentPhone)
-- parent_kind: 1=부, 2=모, 3=친척, 99=기타
-- ============================================================
INSERT INTO ParentPhone (parent_id, student_id, phone, seq, parent_kind) VALUES
(15, 5, '01012340001', 1, 2),   -- 홍어머니 - 홍길동 (모)
(16, 6, '01023450001', 1, 1),   -- 김아버지 - 김철수 (부)
(17, 7, '01034560001', 1, 2),   -- 이어머니 - 이영희 (모)
(18, 8, '01045670001', 1, 2),   -- 박어머니 - 박민수 (모)
(19, 9, '01056780001', 1, 1),   -- 최아버지 - 최지은 (부)
(20, 10, '01067890001', 1, 2),  -- 정어머니 - 정우성 (모)
(21, 11, '01078900001', 1, 2),  -- 강어머니 - 강민지 (모)
(22, 12, '01089010001', 1, 1),  -- 윤아버지 - 윤서준 (부)
(23, 13, '01090120001', 1, 2),  -- 한어머니 - 한소희 (모)
(24, 14, '01001230001', 1, 2);  -- 임어머니 - 임재현 (모)

-- ============================================================
-- 4. 학생 상세 정보 (student_id = user_id, tc_id = TC의 user_id)
-- grade는 User 테이블, 보호자는 ParentPhone 테이블에서 관리
-- tc_id: 김상담=2, 이상담=3, 박상담=4
-- ============================================================
INSERT INTO student_info (
    student_id, birth_date, gender_code, school_name,
    status_code, source_code, tc_id, first_contact_date, created_by
) VALUES
-- 잠재 고객 (user_id: 5, 담당: 김상담=2)
(5, '2012-03-15', 'GENDER_MALE', '서울초등학교',
 'STATUS_PROSPECT', 'SOURCE_ONLINE', 2, '2026-04-25', 1),

-- 접촉 (user_id: 6, 담당: 김상담=2)
(6, '2011-07-22', 'GENDER_MALE', '강남중학교',
 'STATUS_CONTACT', 'SOURCE_REFERRAL', 2, '2026-04-20', 1),

-- 상담 예약 (user_id: 7, 담당: 이상담=3)
(7, '2010-11-08', 'GENDER_FEMALE', '분당중학교',
 'STATUS_CONSULT_BOOK', 'SOURCE_CAFE', 3, '2026-04-18', 1),

-- 상담 완료 (user_id: 8, 담당: 이상담=3)
(8, '2009-05-30', 'GENDER_MALE', '대치고등학교',
 'STATUS_CONSULT_DONE', 'SOURCE_BLOG', 3, '2026-04-10', 1),

-- 등록 (user_id: 9, 담당: 김상담=2)
(9, '2013-09-12', 'GENDER_FEMALE', '서초초등학교',
 'STATUS_REGISTER', 'SOURCE_WALK_IN', 2, '2026-04-01', 1),

-- 재원 (user_id: 10, 담당: 김상담=2)
(10, '2012-01-25', 'GENDER_MALE', '역삼초등학교',
 'STATUS_ENROLLED', 'SOURCE_REFERRAL', 2, '2026-01-15', 1),

-- 재원 (user_id: 11, 담당: 이상담=3)
(11, '2011-04-18', 'GENDER_FEMALE', '청담중학교',
 'STATUS_ENROLLED', 'SOURCE_PREV_STUDENT', 3, '2026-02-01', 1),

-- 재원 (user_id: 12, 담당: 박상담=4)
(12, '2010-08-05', 'GENDER_MALE', '압구정중학교',
 'STATUS_ENROLLED', 'SOURCE_ONLINE', 4, '2025-09-01', 1),

-- 퇴원 (user_id: 13, 담당: 김상담=2)
(13, '2009-12-30', 'GENDER_FEMALE', '서울고등학교',
 'STATUS_WITHDRAW', 'SOURCE_REFERRAL', 2, '2025-03-01', 1),

-- 이탈 (user_id: 14, 담당: 이상담=3)
(14, '2012-06-14', 'GENDER_MALE', '개포초등학교',
 'STATUS_LOST', 'SOURCE_SNS', 3, '2026-04-15', 1);

-- 날짜 업데이트
UPDATE student_info SET consult_date = '2026-04-22' WHERE status_code IN ('STATUS_CONSULT_DONE', 'STATUS_REGISTER', 'STATUS_ENROLLED', 'STATUS_WITHDRAW');
UPDATE student_info SET register_date = '2026-04-25' WHERE status_code IN ('STATUS_REGISTER');
UPDATE student_info SET register_date = '2026-02-01', enroll_date = '2026-02-01' WHERE student_id = 10;  -- 정우성
UPDATE student_info SET register_date = '2026-02-10', enroll_date = '2026-02-10' WHERE student_id = 11;  -- 강민지
UPDATE student_info SET register_date = '2025-09-10', enroll_date = '2025-09-10' WHERE student_id = 12;  -- 윤서준
UPDATE student_info SET register_date = '2025-03-15', enroll_date = '2025-03-15', withdraw_date = '2026-03-15' WHERE student_id = 13;  -- 한소희

-- ============================================================
-- 5. 상담 샘플 데이터 (tc_id = TC의 user_id)
-- ============================================================
INSERT INTO consult (
    student_id, consult_type_code, consult_date, consult_duration,
    channel_code, tc_id, content, student_needs, consult_result_code,
    next_action_code, next_consult_date, interest_subject, created_by
) VALUES
-- 홍길동 상담 (student_id: 5, 담당: 김상담=2)
(5, 'CONSULT_TYPE_INITIAL', '2026-04-25 14:00:00', 30,
 'CHANNEL_PHONE', 2, '최초 전화 상담. 수학 성적 향상 희망', '수학 기초 보강 필요', 'RESULT_PENDING',
 'ACTION_VISIT', '2026-04-30 15:00:00', '수학', 1),

-- 김철수 상담 (student_id: 6, 담당: 김상담=2)
(6, 'CONSULT_TYPE_INITIAL', '2026-04-20 10:00:00', 45,
 'CHANNEL_VISIT', 2, '학원 방문 상담. 영어/수학 동시 수강 희망', '중1 선행 필요', 'RESULT_POSITIVE',
 'ACTION_LEVEL_TEST', '2026-04-28 16:00:00', '영어,수학', 1),

-- 이영희 레벨테스트 예약 (student_id: 7, 담당: 이상담=3)
(7, 'CONSULT_TYPE_INITIAL', '2026-04-18 11:00:00', 30,
 'CHANNEL_KAKAO', 3, '카톡 문의. 수학 레벨테스트 희망', '현재 성적 중위권, 상위권 목표', 'RESULT_PENDING',
 'ACTION_LEVEL_TEST', '2026-04-29 14:00:00', '수학', 1),

-- 박민수 상담 완료 (student_id: 8, 담당: 이상담=3)
(8, 'CONSULT_TYPE_INITIAL', '2026-04-10 15:00:00', 60,
 'CHANNEL_VISIT', 3, '학원 방문. 고1 수학/영어 상담', '내신 대비 필요', 'RESULT_REGISTER',
 'ACTION_REGISTER', NULL, '수학,영어', 1),

(8, 'CONSULT_TYPE_FOLLOWUP', '2026-04-22 16:00:00', 30,
 'CHANNEL_PHONE', 3, '등록 관련 재상담', '5월부터 수강 희망', 'RESULT_REGISTERED',
 'ACTION_NONE', NULL, '수학,영어', 1),

-- 재원생 학습상담 (student_id: 10, 담당: 김상담=2)
(10, 'CONSULT_TYPE_PROGRESS', '2026-04-15 17:00:00', 30,
 'CHANNEL_VISIT', 2, '월간 학습 상담. 성적 향상 확인', '다음 학기 선행 요청', 'RESULT_POSITIVE',
 'ACTION_NONE', NULL, '수학', 1),

-- 재원생 학습상담 (student_id: 11, 담당: 이상담=3)
(11, 'CONSULT_TYPE_PROGRESS', '2026-04-20 18:00:00', 45,
 'CHANNEL_PHONE', 3, '학부모 통화. 영어 추가 수강 문의', '영어 회화 관심', 'RESULT_PENDING',
 'ACTION_CALLBACK', '2026-04-30 10:00:00', '영어', 1);

-- ============================================================
-- 6. 이전 학원 정보 샘플
-- ============================================================
INSERT INTO former_academy (
    student_id, academy_name, academy_type_code, subject,
    start_date, end_date, duration_months, monthly_fee,
    leave_reason_code, satisfaction_code, created_by
) VALUES
(8, 'ABC수학학원', 'ACADEMY_MATH', '수학', '2025-03-01', '2026-02-28', 12, 350000, 'LEAVE_OTHER', 'SATISFY_NORMAL', 1),
(10, '영재수학', 'ACADEMY_MATH', '수학', '2025-01-01', '2026-01-31', 13, 400000, 'LEAVE_DISSATISFY', 'SATISFY_LOW', 1),
(11, '스마트영어', 'ACADEMY_ENGLISH', '영어', '2025-06-01', '2026-01-31', 8, 300000, 'LEAVE_SCHEDULE', 'SATISFY_NORMAL', 1),
(12, '종합학원A', 'ACADEMY_COMP', '수학,영어', '2024-03-01', '2025-08-31', 18, 500000, 'LEAVE_MOVE', 'SATISFY_HIGH', 1);

-- ============================================================
-- 7. 프로모션 샘플
-- ============================================================
INSERT INTO promotion (
    promotion_name, promotion_code, promotion_type_code,
    start_date, end_date, description,
    discount_type_code, discount_value, target_grade, is_active, created_by
) VALUES
('신규 등록 할인', 'NEW2026', 'PROMO_DISCOUNT', '2026-04-01', '2026-05-31',
 '신규 등록 시 첫 달 20% 할인', 'DISCOUNT_PERCENT', 20, NULL, 1, 1),

('소개 이벤트', 'REFER2026', 'PROMO_REFERRAL', '2026-01-01', '2026-12-31',
 '기존 학생이 신규 학생 소개 시 1개월 무료', 'DISCOUNT_AMOUNT', 0, NULL, 1, 1),

('중등 특별 할인', 'MID2026', 'PROMO_DISCOUNT', '2026-05-01', '2026-06-30',
 '중학생 신규 등록 시 10만원 할인', 'DISCOUNT_AMOUNT', 100000, '중1,중2,중3', 1, 1);

-- ============================================================
-- 8. 학생-프로모션 연결
-- ============================================================
INSERT INTO student_promotion (student_id, promotion_id, applied_date, applied_amount, created_by) VALUES
(9, 1, '2026-04-25', 70000, 1),   -- 최지은
(10, 2, '2026-02-01', 350000, 1); -- 정우성
