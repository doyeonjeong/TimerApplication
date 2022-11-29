# 카카오 로그인
## 설치
### SPM으로 SDK 설치
의존성에 따라 Alamofire, Common(공통), Auth(사용자 인증 및 토큰 관리), User(카카오 로그인 및 사용자 관리) 모듈 설치

<br></br>
## 설정
KakaoLoginConfig.xcconfig라는 이름의 Configuration Settings File 생성 후, 다음 내용 추가.
```swift
KAKAO_NATIVE_APP_KEY = ...
```
앱 키를 포함하므로, .gitignore에 추가했음.

<br></br>
## 초기화
SceneDelegate.swift에서 초기화 및 설정

<br></br>
## 동작
- 카카오톡 간편 로그인이 가능한지 확인
- 가능하다면, 카카오톡 앱으로 로그인 수행
- 불가능하다면, 카카오 계정을 로그인 수행
- 로그인한 사용자의 회원번호와 닉네임을 가져온 후, 로그아웃
