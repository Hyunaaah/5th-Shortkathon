# 메주
## 서비스 이름: 리딧
## 서비스 설명: 대학생들 독서 습관 길들이기

![KakaoTalk_Photo_2025-05-24-08-34-53 004](https://github.com/user-attachments/assets/68f95479-2657-4204-9c1e-4d1c8a414e94)
![KakaoTalk_Photo_2025-05-24-08-34-53 003](https://github.com/user-attachments/assets/ae737b6a-ef3c-44ee-9968-a58ddb6bb156)
![KakaoTalk_Photo_2025-05-24-08-34-53 002](https://github.com/user-attachments/assets/523b606a-9165-4d23-99f6-83d2ba2088e9)
![KakaoTalk_Photo_2025-05-24-08-34-52 001](https://github.com/user-attachments/assets/83425dc3-45a7-4494-b59c-cf0d8cbfcd26)
![KakaoTalk_Photo_2025-05-24-08-35-19 002](https://github.com/user-attachments/assets/de2076b0-5b57-442c-b547-d2a50681414e)
![KakaoTalk_Photo_2025-05-24-08-35-19 001](https://github.com/user-attachments/assets/72910e84-4e5e-492a-9099-60f24a959b35)

# 📚 BookReadTracker

> 📖 책 읽기 습관을 형성하고, 하루에 읽어야 할 분량을 계산해주는 독서 관리 애플리케이션

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](#)  
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](#)

## 목차
- [소개](#소개)  
- [기능](#기능)  
- [기술 스택](#기술-스택)  
- [설치](#설치)  
- [설정](#설정)  
- [사용법](#사용법)  
- [API 엔드포인트](#api-엔드포인트)  
- [프로젝트 구조](#프로젝트-구조)  
- [기여](#기여)  
- [라이선스](#라이선스)  

---

## 소개
BookReadTracker는  
1. **도서 추가**: 제목, 저자, 총 페이지 수, 표지 이미지를 입력하여 서버에 저장  
2. **읽기 타이머**: 실제 책 읽는 시간을 측정  
3. **일일 독서량 계산**: 남은 책 분량과 사용자의 목표 기간을 바탕으로 하루에 읽어야 할 페이지 수를 제안  

을 통해 사용자의 독서 습관을 체계적으로 관리하도록 돕습니다.

---

## 기능
- **도서 추가/조회/삭제**  
  - 제목, 저자, 페이지 수, 표지 URL 입력  
  - 저장된 도서 목록 조회 및 개별 도서 삭제
- **읽기 타이머**  
  - ▶️ 시작/⏸️ 일시정지/■ 종료 기능  
  - 읽은 시간 자동 저장
- **일일 독서량 제안**  
  - 남은 페이지 ÷ 목표 기간(일) = 하루 권장 페이지 수
  - 목표 기간 설정(예: 7일, 14일 등)
- **읽기 기록 히스토리**  
  - 날짜별 읽은 시간 및 진행 상태 확인

---

## 기술 스택
- **Frontend**: SwiftUI (iOS)  
- **Backend**: Node.js + Express  
- **Database**: MongoDB  
- **Authentication**: JWT  
- **배포**: Docker, AWS EC2

---

## 설치

1. 저장소 클론  
   ```bash
   git clone https://github.com/yourusername/BookReadTracker.git
   cd BookReadTracker
