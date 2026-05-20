# JY2000 프로젝트 메모

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
