# JY2000 프로젝트 메모

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

## Windows 설치 프로그램 빌드 (jy.exe)

### 빌드 명령어
```bash
# 1. Flutter Windows Release 빌드
cd C:\jy2000\client
flutter build windows --release

# 2. Inno Setup으로 설치 프로그램 생성
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" C:\jy2000\client\installer\setup.iss
```

### 출력 파일
- **설치 프로그램**: `client/build/installer/jy.exe` (~11MB)
- **실행 파일**: `client/build/windows/x64/runner/Release/jy2000.exe`

### 관련 파일
- Inno Setup 스크립트: `client/installer/setup.iss`
- 앱 아이콘: `client/windows/runner/resources/app_icon.ico`

## macOS 설치 프로그램 빌드 (jy2000.dmg)

### 빌드 명령어
```bash
cd /Users/wikiihome/Desktop/jy2000/client

# 1. Flutter macOS Release 빌드
flutter build macos --release

# 2. DMG 패키징 (스테이징 폴더 + Applications 심볼릭 링크 + hdiutil)
BUILD_DIR=build/macos/Build/Products/Release
DMG_STAGING=build/dmg_staging
OUTPUT=build/installer/jy2000.dmg
rm -rf "$DMG_STAGING" && mkdir -p "$DMG_STAGING" build/installer
cp -R "$BUILD_DIR/jy2000.app" "$DMG_STAGING/"
ln -s /Applications "$DMG_STAGING/Applications"
rm -f "$OUTPUT"
hdiutil create -volname "jy2000" -srcfolder "$DMG_STAGING" -ov -format UDZO "$OUTPUT"
```

### 출력 파일
- **DMG**: `client/build/installer/jy2000.dmg` (~22MB)
- **앱 번들**: `client/build/macos/Build/Products/Release/jy2000.app` (~49MB)

### 설치 방법
DMG 마운트 → `jy2000.app`을 `Applications`로 드래그.

### Gatekeeper 우회 (코드 서명/공증 미적용 상태)
인터넷에서 받은 DMG를 실행하면 "Apple could not verify..." 경고가 뜸. 설치 후 터미널에서 격리 속성 제거:
```bash
xattr -dr com.apple.quarantine /Applications/jy2000.app
```
