-- ============================================================
-- 코드 마스터 초기 데이터
-- ============================================================

USE jysk;

-- 기존 데이터 삭제 (개발 환경용)
-- TRUNCATE TABLE code_master;

-- ============================================================
-- 1. 사용자 역할 (ROLE)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('ROLE_ADMIN', 'ROLE', 'ADMIN', '관리자', 1),
('ROLE_MANAGER', 'ROLE', 'MANAGER', '매니저', 2),
('ROLE_TC', 'ROLE', 'TC', '상담사', 3),
('ROLE_TEACHER', 'ROLE', 'TEACHER', '강사', 4),
('ROLE_STAFF', 'ROLE', 'STAFF', '일반직원', 5);

-- ============================================================
-- 2. 성별 (GENDER)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('GENDER_MALE', 'GENDER', 'MALE', '남', 1),
('GENDER_FEMALE', 'GENDER', 'FEMALE', '여', 2);

-- ============================================================
-- 3. 학년 (GRADE) - 학교 종류(중/고)는 학교명에서 결정됨
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('GRADE_1', 'GRADE', '1', '1학년', 1),
('GRADE_2', 'GRADE', '2', '2학년', 2),
('GRADE_3', 'GRADE', '3', '3학년', 3),
('GRADE_N', 'GRADE', 'N', 'N수생', 4),
('GRADE_ADULT', 'GRADE', 'ADULT', '성인', 5);

-- ============================================================
-- 4. 학생 상태 (STATUS) - 퍼널 단계
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, description, sort_order) VALUES
('STATUS_PROSPECT', 'STATUS', 'PROSPECT', '잠재', '최초 DB 수집 상태', 1),
('STATUS_CONTACT', 'STATUS', 'CONTACT', '접촉', '첫 연락 완료', 2),
('STATUS_CONSULT_BOOK', 'STATUS', 'CONSULT_BOOK', '상담예약', '상담 예약 완료', 3),
('STATUS_CONSULT_DONE', 'STATUS', 'CONSULT_DONE', '상담완료', '상담 진행 완료', 4),
('STATUS_REGISTER', 'STATUS', 'REGISTER', '등록', '등록 완료 (결제 완료)', 5),
('STATUS_ENROLLED', 'STATUS', 'ENROLLED', '재원', '현재 수강 중', 6),
('STATUS_WITHDRAW', 'STATUS', 'WITHDRAW', '퇴원', '퇴원 완료', 7),
('STATUS_LOST', 'STATUS', 'LOST', '이탈', '상담 후 이탈', 8),
('STATUS_DEFERRED', 'STATUS', 'DEFERRED', '보류', '등록 보류', 9);

-- ============================================================
-- 5. 세부 상태 (SUB_STATUS)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, parent_code_id, sort_order) VALUES
-- 잠재 세부
('SUB_PROSPECT_NEW', 'SUB_STATUS', 'NEW', '신규', 'STATUS_PROSPECT', 1),
('SUB_PROSPECT_RECALL', 'SUB_STATUS', 'RECALL', '재연락필요', 'STATUS_PROSPECT', 2),
-- 이탈 세부
('SUB_LOST_PRICE', 'SUB_STATUS', 'PRICE', '가격', 'STATUS_LOST', 1),
('SUB_LOST_DISTANCE', 'SUB_STATUS', 'DISTANCE', '거리', 'STATUS_LOST', 2),
('SUB_LOST_SCHEDULE', 'SUB_STATUS', 'SCHEDULE', '시간', 'STATUS_LOST', 3),
('SUB_LOST_OTHER', 'SUB_STATUS', 'OTHER', '기타', 'STATUS_LOST', 4),
-- 퇴원 세부
('SUB_WITHDRAW_COMPLETE', 'SUB_STATUS', 'COMPLETE', '수강완료', 'STATUS_WITHDRAW', 1),
('SUB_WITHDRAW_MOVE', 'SUB_STATUS', 'MOVE', '이사', 'STATUS_WITHDRAW', 2),
('SUB_WITHDRAW_DISSATISFY', 'SUB_STATUS', 'DISSATISFY', '불만족', 'STATUS_WITHDRAW', 3),
('SUB_WITHDRAW_SCHEDULE', 'SUB_STATUS', 'SCHEDULE', '시간', 'STATUS_WITHDRAW', 4),
('SUB_WITHDRAW_OTHER', 'SUB_STATUS', 'OTHER', '기타', 'STATUS_WITHDRAW', 5);

-- ============================================================
-- 6. 상담 유형 (CONSULT_TYPE)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('CONSULT_TYPE_INITIAL', 'CONSULT_TYPE', 'INITIAL', '신규생 문의', 1),
('CONSULT_TYPE_FOLLOWUP', 'CONSULT_TYPE', 'FOLLOWUP', '재상담', 2),
('CONSULT_TYPE_LEVEL', 'CONSULT_TYPE', 'LEVEL', '레벨테스트', 3),
('CONSULT_TYPE_REGISTER', 'CONSULT_TYPE', 'REGISTER', '등록상담', 4),
('CONSULT_TYPE_PROGRESS', 'CONSULT_TYPE', 'PROGRESS', '학습상담', 5),
('CONSULT_TYPE_WITHDRAW', 'CONSULT_TYPE', 'WITHDRAW', '퇴원상담', 6);

-- ============================================================
-- 7. 상담 채널 (CHANNEL)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('CHANNEL_VISIT', 'CHANNEL', 'VISIT', '방문', 1),
('CHANNEL_PHONE', 'CHANNEL', 'PHONE', '전화', 2),
('CHANNEL_KAKAO', 'CHANNEL', 'KAKAO', '카카오톡', 3),
('CHANNEL_SMS', 'CHANNEL', 'SMS', '문자', 4),
('CHANNEL_ONLINE', 'CHANNEL', 'ONLINE', '온라인', 5);

-- ============================================================
-- 8. 상담 결과 (CONSULT_RESULT)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('RESULT_PENDING', 'CONSULT_RESULT', 'PENDING', '검토중', 1),
('RESULT_POSITIVE', 'CONSULT_RESULT', 'POSITIVE', '긍정적', 2),
('RESULT_NEGATIVE', 'CONSULT_RESULT', 'NEGATIVE', '부정적', 3),
('RESULT_REGISTER', 'CONSULT_RESULT', 'REGISTER', '등록예정', 4),
('RESULT_REGISTERED', 'CONSULT_RESULT', 'REGISTERED', '등록완료', 5),
('RESULT_DEFERRED', 'CONSULT_RESULT', 'DEFERRED', '보류', 6),
('RESULT_LOST', 'CONSULT_RESULT', 'LOST', '이탈', 7);

-- ============================================================
-- 9. 후속 조치 (NEXT_ACTION)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('ACTION_NONE', 'NEXT_ACTION', 'NONE', '없음', 1),
('ACTION_CALLBACK', 'NEXT_ACTION', 'CALLBACK', '재연락', 2),
('ACTION_VISIT', 'NEXT_ACTION', 'VISIT', '방문유도', 3),
('ACTION_LEVEL_TEST', 'NEXT_ACTION', 'LEVEL_TEST', '레벨테스트', 4),
('ACTION_TRIAL', 'NEXT_ACTION', 'TRIAL', '체험수업', 5),
('ACTION_REGISTER', 'NEXT_ACTION', 'REGISTER', '등록진행', 6);

-- ============================================================
-- 10. 유입 경로 (SOURCE)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('SOURCE_REFERRAL', 'SOURCE', 'REFERRAL', '지인소개', 1),
('SOURCE_ONLINE', 'SOURCE', 'ONLINE', '온라인검색', 2),
('SOURCE_BLOG', 'SOURCE', 'BLOG', '블로그', 3),
('SOURCE_CAFE', 'SOURCE', 'CAFE', '맘카페', 4),
('SOURCE_SNS', 'SOURCE', 'SNS', 'SNS광고', 5),
('SOURCE_FLYER', 'SOURCE', 'FLYER', '전단지', 6),
('SOURCE_BANNER', 'SOURCE', 'BANNER', '현수막', 7),
('SOURCE_WALK_IN', 'SOURCE', 'WALK_IN', '방문', 8),
('SOURCE_PREV_STUDENT', 'SOURCE', 'PREV_STUDENT', '기존학생', 9),
('SOURCE_OTHER', 'SOURCE', 'OTHER', '기타', 99);

-- ============================================================
-- 10-1. 문의경로 (INQUIRY_SOURCE)
--   신규생 문의 작성 화면에서 사용. 문의 건별 경로이며
--   학생 단위 유입경로(SOURCE)와는 별개의 그룹이다.
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('INQUIRY_PHONE', 'INQUIRY_SOURCE', 'PHONE', '전화', 1),
('INQUIRY_HOMEPAGE', 'INQUIRY_SOURCE', 'HOMEPAGE', '홈페이지', 2),
('INQUIRY_VISIT', 'INQUIRY_SOURCE', 'VISIT', '방문', 3),
('INQUIRY_CHANNEL', 'INQUIRY_SOURCE', 'CHANNEL', '채널', 4),
('INQUIRY_NAVER', 'INQUIRY_SOURCE', 'NAVER', '네이버', 5),
('INQUIRY_PROMOTION', 'INQUIRY_SOURCE', 'PROMOTION', '설명회 후', 6),
('INQUIRY_OTHER', 'INQUIRY_SOURCE', 'OTHER', '기타', 99);

-- ============================================================
-- 11. 보호자 관계 (RELATION)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('RELATION_FATHER', 'RELATION', 'FATHER', '부', 1),
('RELATION_MOTHER', 'RELATION', 'MOTHER', '모', 2),
('RELATION_GRAND_F', 'RELATION', 'GRAND_F', '조부', 3),
('RELATION_GRAND_M', 'RELATION', 'GRAND_M', '조모', 4),
('RELATION_OTHER', 'RELATION', 'OTHER', '기타', 5);

-- ============================================================
-- 12. TC 유형 (TC_TYPE)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('TC_TYPE_INBOUND', 'TC_TYPE', 'INBOUND', '인바운드', 1),
('TC_TYPE_OUTBOUND', 'TC_TYPE', 'OUTBOUND', '아웃바운드', 2),
('TC_TYPE_FIELD', 'TC_TYPE', 'FIELD', '현장상담', 3);

-- ============================================================
-- 13. 지점 (BRANCH)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('BRANCH_MAIN', 'BRANCH', 'MAIN', '본점', 1),
('BRANCH_GANGNAM', 'BRANCH', 'GANGNAM', '강남점', 2),
('BRANCH_BUNDANG', 'BRANCH', 'BUNDANG', '분당점', 3);

-- ============================================================
-- 14. 변경 유형 (CHANGE_TYPE) - student_history용
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('CHANGE_STATUS', 'CHANGE_TYPE', 'STATUS', '상태변경', 1),
('CHANGE_TC', 'CHANGE_TYPE', 'TC', '담당자변경', 2),
('CHANGE_INFO', 'CHANGE_TYPE', 'INFO', '정보수정', 3),
('CHANGE_REGISTER', 'CHANGE_TYPE', 'REGISTER', '등록', 4),
('CHANGE_WITHDRAW', 'CHANGE_TYPE', 'WITHDRAW', '퇴원', 5);

-- ============================================================
-- 15. 프로모션 유형 (PROMOTION_TYPE)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('PROMO_DISCOUNT', 'PROMOTION_TYPE', 'DISCOUNT', '할인', 1),
('PROMO_FREE_MONTH', 'PROMOTION_TYPE', 'FREE_MONTH', '무료수강', 2),
('PROMO_GIFT', 'PROMOTION_TYPE', 'GIFT', '사은품', 3),
('PROMO_REFERRAL', 'PROMOTION_TYPE', 'REFERRAL', '소개이벤트', 4);

-- ============================================================
-- 16. 할인 유형 (DISCOUNT_TYPE)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('DISCOUNT_PERCENT', 'DISCOUNT_TYPE', 'PERCENT', '정률할인(%)', 1),
('DISCOUNT_AMOUNT', 'DISCOUNT_TYPE', 'AMOUNT', '정액할인(원)', 2);

-- ============================================================
-- 17. 학원 유형 (ACADEMY_TYPE) - former_academy용
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('ACADEMY_MATH', 'ACADEMY_TYPE', 'MATH', '수학학원', 1),
('ACADEMY_ENGLISH', 'ACADEMY_TYPE', 'ENGLISH', '영어학원', 2),
('ACADEMY_KOREAN', 'ACADEMY_TYPE', 'KOREAN', '국어학원', 3),
('ACADEMY_SCIENCE', 'ACADEMY_TYPE', 'SCIENCE', '과학학원', 4),
('ACADEMY_COMP', 'ACADEMY_TYPE', 'COMPREHENSIVE', '종합학원', 5),
('ACADEMY_OTHER', 'ACADEMY_TYPE', 'OTHER', '기타', 99);

-- ============================================================
-- 18. 퇴원 사유 (LEAVE_REASON)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('LEAVE_COMPLETE', 'LEAVE_REASON', 'COMPLETE', '수강완료', 1),
('LEAVE_MOVE', 'LEAVE_REASON', 'MOVE', '이사', 2),
('LEAVE_DISSATISFY', 'LEAVE_REASON', 'DISSATISFY', '불만족', 3),
('LEAVE_PRICE', 'LEAVE_REASON', 'PRICE', '가격', 4),
('LEAVE_SCHEDULE', 'LEAVE_REASON', 'SCHEDULE', '시간', 5),
('LEAVE_OTHER', 'LEAVE_REASON', 'OTHER', '기타', 99);

-- ============================================================
-- 19. 만족도 (SATISFACTION)
-- ============================================================
INSERT INTO code_master (code_id, code_group, code_value, code_name, sort_order) VALUES
('SATISFY_VERY_HIGH', 'SATISFACTION', 'VERY_HIGH', '매우만족', 1),
('SATISFY_HIGH', 'SATISFACTION', 'HIGH', '만족', 2),
('SATISFY_NORMAL', 'SATISFACTION', 'NORMAL', '보통', 3),
('SATISFY_LOW', 'SATISFACTION', 'LOW', '불만족', 4),
('SATISFY_VERY_LOW', 'SATISFACTION', 'VERY_LOW', '매우불만족', 5);
