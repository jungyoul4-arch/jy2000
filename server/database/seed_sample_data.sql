-- ============================================================
-- 샘플 데이터 (개발/테스트용)
-- ============================================================

USE jysk;

-- ============================================================
-- 1. 관리자 계정
-- ============================================================
INSERT INTO users (login_id, password_hash, user_name, role_code, phone, email) VALUES
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '관리자', 'ROLE_ADMIN', '010-0000-0000', 'admin@jungyoul.com'),
('manager1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '김매니저', 'ROLE_MANAGER', '010-1111-1111', 'manager1@jungyoul.com');

-- 비밀번호: password (bcrypt 해시)

-- ============================================================
-- 2. TC (상담사) 데이터
-- ============================================================
INSERT INTO tc_info (user_id, tc_name, tc_code, phone, email, tc_type_code, branch_code, hire_date) VALUES
(1, '김상담', 'TC001', '010-2222-2222', 'tc1@jungyoul.com', 'TC_TYPE_INBOUND', 'BRANCH_MAIN', '2024-01-15'),
(2, '이상담', 'TC002', '010-3333-3333', 'tc2@jungyoul.com', 'TC_TYPE_OUTBOUND', 'BRANCH_MAIN', '2024-03-01'),
(NULL, '박상담', 'TC003', '010-4444-4444', 'tc3@jungyoul.com', 'TC_TYPE_FIELD', 'BRANCH_GANGNAM', '2024-06-01');

-- ============================================================
-- 3. 학생 샘플 데이터
-- ============================================================
INSERT INTO student_info (
    student_name, phone, email, birth_date, gender_code, school_name, grade_code,
    guardian_name, guardian_phone, guardian_relation,
    status_code, source_code, tc_id, first_contact_date, created_by
) VALUES
-- 잠재 고객
('홍길동', '010-1234-5678', 'hong@test.com', '2012-03-15', 'GENDER_MALE', '서울초등학교', 'GRADE_ELEM_6',
 '홍어머니', '010-1234-0001', 'RELATION_MOTHER',
 'STATUS_PROSPECT', 'SOURCE_ONLINE', 1, '2026-04-25', 1),

('김철수', '010-2345-6789', 'kim@test.com', '2011-07-22', 'GENDER_MALE', '강남중학교', 'GRADE_MID_1',
 '김아버지', '010-2345-0001', 'RELATION_FATHER',
 'STATUS_CONTACT', 'SOURCE_REFERRAL', 1, '2026-04-20', 1),

-- 상담 예약
('이영희', '010-3456-7890', 'lee@test.com', '2010-11-08', 'GENDER_FEMALE', '분당중학교', 'GRADE_MID_2',
 '이어머니', '010-3456-0001', 'RELATION_MOTHER',
 'STATUS_CONSULT_BOOK', 'SOURCE_CAFE', 2, '2026-04-18', 1),

-- 상담 완료
('박민수', '010-4567-8901', 'park@test.com', '2009-05-30', 'GENDER_MALE', '대치고등학교', 'GRADE_HIGH_1',
 '박어머니', '010-4567-0001', 'RELATION_MOTHER',
 'STATUS_CONSULT_DONE', 'SOURCE_BLOG', 2, '2026-04-10', 1),

-- 등록
('최지은', '010-5678-9012', 'choi@test.com', '2013-09-12', 'GENDER_FEMALE', '서초초등학교', 'GRADE_ELEM_5',
 '최아버지', '010-5678-0001', 'RELATION_FATHER',
 'STATUS_REGISTER', 'SOURCE_WALK_IN', 1, '2026-04-01', 1),

-- 재원 (현재 수강중)
('정우성', '010-6789-0123', 'jung@test.com', '2012-01-25', 'GENDER_MALE', '역삼초등학교', 'GRADE_ELEM_6',
 '정어머니', '010-6789-0001', 'RELATION_MOTHER',
 'STATUS_ENROLLED', 'SOURCE_REFERRAL', 1, '2026-01-15', 1),

('강민지', '010-7890-1234', 'kang@test.com', '2011-04-18', 'GENDER_FEMALE', '청담중학교', 'GRADE_MID_1',
 '강어머니', '010-7890-0001', 'RELATION_MOTHER',
 'STATUS_ENROLLED', 'SOURCE_PREV_STUDENT', 2, '2026-02-01', 1),

('윤서준', '010-8901-2345', 'yoon@test.com', '2010-08-05', 'GENDER_MALE', '압구정중학교', 'GRADE_MID_2',
 '윤아버지', '010-8901-0001', 'RELATION_FATHER',
 'STATUS_ENROLLED', 'SOURCE_ONLINE', 3, '2025-09-01', 1),

-- 퇴원
('한소희', '010-9012-3456', 'han@test.com', '2009-12-30', 'GENDER_FEMALE', '서울고등학교', 'GRADE_HIGH_2',
 '한어머니', '010-9012-0001', 'RELATION_MOTHER',
 'STATUS_WITHDRAW', 'SOURCE_REFERRAL', 1, '2025-03-01', 1),

-- 이탈
('임재현', '010-0123-4567', 'lim@test.com', '2012-06-14', 'GENDER_MALE', '개포초등학교', 'GRADE_ELEM_6',
 '임어머니', '010-0123-0001', 'RELATION_MOTHER',
 'STATUS_LOST', 'SOURCE_SNS', 2, '2026-04-15', 1);

-- 날짜 업데이트
UPDATE student_info SET consult_date = '2026-04-22' WHERE status_code IN ('STATUS_CONSULT_DONE', 'STATUS_REGISTER', 'STATUS_ENROLLED', 'STATUS_WITHDRAW');
UPDATE student_info SET register_date = '2026-04-25' WHERE status_code IN ('STATUS_REGISTER');
UPDATE student_info SET register_date = '2026-02-01', enroll_date = '2026-02-01' WHERE student_name = '정우성';
UPDATE student_info SET register_date = '2026-02-10', enroll_date = '2026-02-10' WHERE student_name = '강민지';
UPDATE student_info SET register_date = '2025-09-10', enroll_date = '2025-09-10' WHERE student_name = '윤서준';
UPDATE student_info SET register_date = '2025-03-15', enroll_date = '2025-03-15', withdraw_date = '2026-03-15' WHERE student_name = '한소희';

-- ============================================================
-- 4. 상담 샘플 데이터
-- ============================================================
INSERT INTO consult (
    student_id, consult_type_code, consult_date, consult_duration,
    channel_code, tc_id, content, student_needs, consult_result_code,
    next_action_code, next_consult_date, interest_subject, created_by
) VALUES
-- 홍길동 상담
(1, 'CONSULT_TYPE_INITIAL', '2026-04-25 14:00:00', 30,
 'CHANNEL_PHONE', 1, '최초 전화 상담. 수학 성적 향상 희망', '수학 기초 보강 필요', 'RESULT_PENDING',
 'ACTION_VISIT', '2026-04-30 15:00:00', '수학', 1),

-- 김철수 상담
(2, 'CONSULT_TYPE_INITIAL', '2026-04-20 10:00:00', 45,
 'CHANNEL_VISIT', 1, '학원 방문 상담. 영어/수학 동시 수강 희망', '중1 선행 필요', 'RESULT_POSITIVE',
 'ACTION_LEVEL_TEST', '2026-04-28 16:00:00', '영어,수학', 1),

-- 이영희 레벨테스트 예약
(3, 'CONSULT_TYPE_INITIAL', '2026-04-18 11:00:00', 30,
 'CHANNEL_KAKAO', 2, '카톡 문의. 수학 레벨테스트 희망', '현재 성적 중위권, 상위권 목표', 'RESULT_PENDING',
 'ACTION_LEVEL_TEST', '2026-04-29 14:00:00', '수학', 1),

-- 박민수 상담 완료
(4, 'CONSULT_TYPE_INITIAL', '2026-04-10 15:00:00', 60,
 'CHANNEL_VISIT', 2, '학원 방문. 고1 수학/영어 상담', '내신 대비 필요', 'RESULT_REGISTER',
 'ACTION_REGISTER', NULL, '수학,영어', 1),

(4, 'CONSULT_TYPE_FOLLOWUP', '2026-04-22 16:00:00', 30,
 'CHANNEL_PHONE', 2, '등록 관련 재상담', '5월부터 수강 희망', 'RESULT_REGISTERED',
 'ACTION_NONE', NULL, '수학,영어', 1),

-- 재원생 학습상담
(6, 'CONSULT_TYPE_PROGRESS', '2026-04-15 17:00:00', 30,
 'CHANNEL_VISIT', 1, '월간 학습 상담. 성적 향상 확인', '다음 학기 선행 요청', 'RESULT_POSITIVE',
 'ACTION_NONE', NULL, '수학', 1),

(7, 'CONSULT_TYPE_PROGRESS', '2026-04-20 18:00:00', 45,
 'CHANNEL_PHONE', 2, '학부모 통화. 영어 추가 수강 문의', '영어 회화 관심', 'RESULT_PENDING',
 'ACTION_CALLBACK', '2026-04-30 10:00:00', '영어', 1);

-- ============================================================
-- 5. 이전 학원 정보 샘플
-- ============================================================
INSERT INTO former_academy (
    student_id, academy_name, academy_type_code, subject,
    start_date, end_date, duration_months, monthly_fee,
    leave_reason_code, satisfaction_code, created_by
) VALUES
(4, 'ABC수학학원', 'ACADEMY_MATH', '수학', '2025-03-01', '2026-02-28', 12, 350000, 'LEAVE_OTHER', 'SATISFY_NORMAL', 1),
(6, '영재수학', 'ACADEMY_MATH', '수학', '2025-01-01', '2026-01-31', 13, 400000, 'LEAVE_DISSATISFY', 'SATISFY_LOW', 1),
(7, '스마트영어', 'ACADEMY_ENGLISH', '영어', '2025-06-01', '2026-01-31', 8, 300000, 'LEAVE_SCHEDULE', 'SATISFY_NORMAL', 1),
(8, '종합학원A', 'ACADEMY_COMP', '수학,영어', '2024-03-01', '2025-08-31', 18, 500000, 'LEAVE_MOVE', 'SATISFY_HIGH', 1);

-- ============================================================
-- 6. 프로모션 샘플
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
-- 7. 학생-프로모션 연결
-- ============================================================
INSERT INTO student_promotion (student_id, promotion_id, applied_date, applied_amount, created_by) VALUES
(5, 1, '2026-04-25', 70000, 1),
(6, 2, '2026-02-01', 350000, 1);
