# Team6 Phase 3 설명

## 제출물 실행 및 사용방법

1. 함께 첨부한 ```hoban_cowrun.sql```을 데이터베이스에 커밋한다

2. Application을 UTF-8 문자셋으로 실행한다

   1. 이클립스 기준으로 다음과 같이 세팅한다
   2. Window->Preferences 메뉴에 들어가서
   3. General->Content Types 항목에서 Text 선택 후 맨 밑에 Default encoding 란에 ```UTF-8```이라 쓰고 Update
   4. General->Editors->Spelling 항목에서 Encoding을 ```UTF-8```로 설정
   5. General->Workspace 항목에서 Text file encoding 을 ```UTF-8```로 설정

3. ```src/DAO/DAO.java```파일에서 다음 항목들을 접속하고자 하는 데이터베이스 주소와 사용자이름, 비밀번호로 변경한다.

   ```Java
   private final String URL = "jdbc:oracle:thin:@localhost:1600:xe";
   private final String USER_ID ="hoban";
   private final String USER_PASSWD ="cowrun";
   ```

4. ```src/App.java```파일을 실행한다.

## 기능 설명

### 메인 페이지

1. 로그인
   * 로그인 한 계정에 따라 유저페이지 또는 관리자 페이지로 이동
2. 회원가입
3. 종료

### 유저 페이지

1. 캐릭터 창
   * 캐릭터 선택 페이지로 이동
2. 보유 아이템 조회
   * 해당 유저가 가지고 있는 모든 아이템 조회
3. 기록 보기
   * 유저 기록 페이지로 이동
4. 비밀번호 변경
5. 탈퇴

### 캐릭터 선택 페이지

1. 캐릭터 선택
   * 유저의 캐릭터 선택해서 캐릭터 페이지로 이동
2. 모든 캐릭터 조회
   * 유저의 모든 캐릭터가 가진 스킬과 능력치 조회
3. 캐릭터 생성
   * 유저의 닉네임 및 스킬을 입력받아 캐릭터 생성
4. 캐릭터 삭제

### 캐릭터 페이지

1. 각 맵 플레이하기
   * 맵에 있는 발판과 장애물을 모두 출력하고, 랜덤하게 경험치를 획득함
2. 캐릭터 랭킹보기
   * 그 캐릭터의 클리어 시간에 대한 최고 랭킹 출력
3. 어빌리티 강화하기
   * 레벨 * 3 만큼의 포인트 만큼 어빌리티를 강화할 수 있다.

### 유저 기록 페이지

1. 유저의 모든 클리어 기록의 캐릭터명, 맵명, 클리어 시간 조회 
2. 유저의 맵 별 클리어 횟수
3. 유저의 각 스킬을 사용한 클리어 횟수

### 관리자 페이지

1. 전체 계정 조회

2. 계정 이름 검색: %, _로 계정 검색 가능
   검색결과가 하나일 때: 
   i. 보유 캐릭터 조회
   ii. 계정 비밀번호 변경
   iii. 계정 삭제

3. 전체 캐릭터 조회

4. 캐릭터 이름 검색: %, _로 계정 검색 가능
   검색결과가 하나일 때: 
   i. 능력 조회
   ii. 맵별 최고기록 등수
   iii. LV, EXP 변경
   iv. 캐릭터 삭제

5. 캐릭터 관련 조회
   i. 즉발형 스킬을 가진 캐릭터(시전시간이 0인 스킬을 가진 캐릭터)
   ii. SPEED 스텟이 ? 이상인 캐릭터: ?를 입력받아 Qeury 진행

6. 기록 관련 조회
   i. 모든 클리어 기록 조회
   ii. 계정별 각 맵 클리어 횟수 조회
   iii. 스킬별 클리어 횟수 조회
   iv. 목숨 단 3개로 ? 초 이내 클리어한 캐릭터 조회: ?를 입력받아 Qeury 진행

7. 맵 관련 조회
   i. 맵별 발판 조회: 네 종류의 맵 중 선택(a. 북문 b. 일청담 c. 센트럴파크 d. IT융복합관)
   ii. ? 초 이내 클리어한 기록이 있는 맵 조회: ?를 입력받아 Qeury 진행
   iii. 데미지가 너무 강하거나 너무 커 피하기 어려운 장애물 조회

## Application 제작 환경

JDK 1.8

eclipse IDE for Enterprise Java and Web Developers - 2021-09

## 쿼리 수정사항

원활한 실행을 위하여 check 제약 조건들을 수정하였다

* 변경 전

  ```sql
  ...
  CREATE TABLE CHARACTERS (
      USERID        VARCHAR(14), --foreign key
      CHARACTERID   VARCHAR(8) PRIMARY KEY,
      CHARACTERNAME VARCHAR(60) NOT NULL UNIQUE,
      LV            INT CHECK ( LV BETWEEN 1 AND 10 ),
      EXP           INT CHECK ( EXP BETWEEN 0 AND 100 ),
      SKILLID       VARCHAR(8), --foreign key
      FOREIGN KEY ( USERID )
          REFERENCES USERS ( USERID )
              ON DELETE CASCADE,
      FOREIGN KEY ( SKILLID )
          REFERENCES SKILLS ( SKILLID )
              ON DELETE CASCADE
  );
  CREATE TABLE ABILITIES (
      CHARACTERID VARCHAR(14) UNIQUE, --foreign key
      SPEED       INT CHECK ( SPEED BETWEEN 5 AND 10 ),
      LIFE        INT CHECK ( LIFE BETWEEN 3 AND 5 ),
      COOLDOWN    INT CHECK ( COOLDOWN BETWEEN 0 AND 5 ),
      FOREIGN KEY ( CHARACTERID )
          REFERENCES CHARACTERS ( CHARACTERID )
              ON DELETE CASCADE
  );
  ...
  ```

* 변경 후

  ```sql
  ...
  CREATE TABLE CHARACTERS (
      USERID        VARCHAR(14), --foreign key
      CHARACTERID   VARCHAR(8) PRIMARY KEY,
      CHARACTERNAME VARCHAR(60) NOT NULL UNIQUE,
      LV            INT,
      EXP           INT CHECK ( EXP BETWEEN 0 AND 100 ),
      SKILLID       VARCHAR(8), --foreign key
      FOREIGN KEY ( USERID )
          REFERENCES USERS ( USERID )
              ON DELETE CASCADE,
      FOREIGN KEY ( SKILLID )
          REFERENCES SKILLS ( SKILLID )
              ON DELETE CASCADE
  );
  CREATE TABLE ABILITIES (
      CHARACTERID VARCHAR(14) UNIQUE, --foreign key
      SPEED       INT,
      LIFE        INT CHECK ( LIFE >= 3),
      COOLDOWN    INT,
      FOREIGN KEY ( CHARACTERID )
          REFERENCES CHARACTERS ( CHARACTERID )
              ON DELETE CASCADE
  );
  ...
  ```

  