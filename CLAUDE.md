# JY2000 프로젝트 메모

클라이언트는 웹만 지원합니다. Windows·macOS 데스크톱 빌드는 만들지 않습니다.

## Web 빌드 (중요!)

### 빌드 명령어
```bash
cd C:\jy2000\client
# 반드시 --base-href "/jy2000/" 옵션 포함!
MSYS_NO_PATHCONV=1 flutter build web --release --base-href "/jy2000/"
```

### 출력 파일
- **빌드 결과**: `client/build/web`

### 주의사항
- **--base-href "/jy2000/" 옵션 필수**: 서브 경로 설정을 위해 반드시 포함해야 함
- MSYS_NO_PATHCONV=1: Git Bash에서 경로 변환 방지
- `API_BASE_URL` dart-define 은 정율서버 배포 빌드에 넣지 않는다. 없으면 `https://jungyoul.com/node-api/v1` 로 간다.
