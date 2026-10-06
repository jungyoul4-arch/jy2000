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

/**
 * 이름·전화번호 통합 검색 조건을 만든다.
 *
 * 전화번호는 cleanPhone을 거쳐 '01012345678'로 저장되는데, 사용자는
 * '010-1234-5678'처럼 하이픈을 넣어 찾는다. 그대로 LIKE를 걸면 한 건도
 * 안 나온다. 검색어와 컬럼 양쪽에서 구분자를 지우고 비교한다.
 *
 * 예전 데이터에 공백이 남아 있을 수 있어 컬럼 쪽도 함께 지운다.
 * LIKE '%...%'라 어차피 인덱스를 못 타므로 REPLACE를 씌워도 손해가 없다.
 *
 * 검색어에 숫자가 없으면(= 이름만 쳤으면) 전화번호 조건을 넣지 않는다.
 * 넣으면 LIKE '%%'가 되어 모든 행이 걸린다.
 *
 * @param columns 비교할 컬럼. extra는 학교명처럼 이름과 같이 훑을 것들.
 */
export const buildNamePhoneSearch = (
  search: string,
  columns: { name: string; phone: string; extra?: string[] }
): { clause: string; params: string[] } => {
  const term = `%${search.trim()}%`;
  const digits = search.replace(/\D/g, '');

  const parts = [`${columns.name} LIKE ?`];
  const params = [term];

  for (const col of columns.extra ?? []) {
    parts.push(`${col} LIKE ?`);
    params.push(term);
  }

  if (digits) {
    parts.push(`REPLACE(REPLACE(${columns.phone}, '-', ''), ' ', '') LIKE ?`);
    params.push(`%${digits}%`);
  }

  return { clause: `(${parts.join(' OR ')})`, params };
};
