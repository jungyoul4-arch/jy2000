/**
 * 전화번호 정규화 — '-'와 공백을 모두 제거하고 숫자만 남긴다.
 *
 * User.phone은 NOT NULL UNIQUE(로그인 ID)라 표기가 흔들리면 안 된다.
 * '010 1111 2222'와 '010-1111-2222'가 따로 저장되면 중복 검사가 빗나가
 * 같은 사람이 두 번 등록된다.
 *
 * `\s`가 전각 공백(IME 입력)과 앞뒤 공백까지 걸러 별도 trim은 필요 없다.
 * 빈 값과 공백뿐인 값은 null을 돌려준다 — 컬럼이 NOT NULL이라 ''을 넣으면
 * UNIQUE 때문에 그런 행이 하나만 존재할 수 있고, 두 번째부터 원인을 알기
 * 어려운 중복 오류가 난다.
 */
export const cleanPhone = (phone: string | undefined | null): string | null => {
  if (!phone) return null;
  const cleaned = phone.replace(/[\s-]/g, '');
  return cleaned.length > 0 ? cleaned : null;
};
