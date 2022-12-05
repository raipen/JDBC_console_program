# Team6 Phase 4: 호반우 RUN

## 제출물 실행 및 사용방법

### 1. 윈도우10, 윈도우11

tomcat 8.5 서버와 oracle JDBC 드라이브가 준비되었다는 가정하에 서술하였다.

1. ```Team6-Phase4.zip ```압축파일에 있는 ```hoban_cowrun_init_insert.sql```을 oracle 데이터베이스에 커밋한다

2. eclipse IDE에서 UTF-8 문자셋으로 실행한다.

   1. Window->Preferences 메뉴에 들어가서
   2. General->Content Types 항목에서 Text 선택 후 맨 밑에 Default encoding 란에 ```UTF-8```이라 쓰고 Update
   3. General->Editors->Spelling 항목에서 Encoding을 ```UTF-8```로 설정
   4. Preferences 창의 좌상단 검색란에 "encoding"을 검색하고 나오는 모든 항목을 ```UTF-8```로 변경

3. ```src/main/java/DAO/DAO.java```파일에서 다음 항목들을 접속하고자 하는 데이터베이스 주소와 사용자이름, 비밀번호로 변경한다.

   ```Java
   private final String URL = "jdbc:oracle:thin:@localhost:1600:xe";
   private final String USER_ID ="hoban";
   private final String USER_PASSWD ="cowrun";
   ```

4. 만약 자동으로 라이브러리를 인식하지 못한다면

   1. 프로젝트를 우클릭해서 build path 클릭
   2. Libraries>Classpath 에 Add External JARs... 클릭
   3. ```src/main/webapp/WEB-INF/lib```폴더에 있는 ```json-simple-1.1.1.jar```추가

5. ```src/main/webapp/WEB-INF/index.jsp``` 을 Run 한다.

### 2. 우분투 22.04.1 LTS

jdk와 tomcat이 설치되어 있고, oracle DBMS가 준비된 상태라는 전제하에 서술

1. ```Team6-Phase4.zip ```압축파일에 있는 ```hoban_cowrun_init_insert.sql```을 oracle 데이터베이스에 커밋한다

2. ```src/main/java/DAO/DAO.java```파일에서 다음 항목들을 접속하고자 하는 데이터베이스 주소와 사용자이름, 비밀번호로 변경한다.

   ```Java
   private final String URL = "jdbc:oracle:thin:@localhost:1600:xe";
   private final String USER_ID ="hoban";
   private final String USER_PASSWD ="cowrun";
   ```

3. 윈도우 이클립스에서 컴파일 후 프로젝트를 Export 하여 ```Team6-Phase4.war```파일로 만든다.

4. ```Team6-Phase4.war```파일을 ```tomcat 설치폴더/wepapp/ROOT/```폴더로 복사

5. 해당폴더에서 ```jar xvf Team6-Phase4.war```명령어로 압축해제

6. ```tomcat 설치폴더/bin/``` 폴더에서 ```shutdown.sh``` 실행, ```startup.sh``` 실행

7. 만약 db와 연결이 안 된다면 

   ```shell
   톰캣 bin 폴더에서
   vim setenv.sh
   아래 내용 저장
   #!/bin/bash
   export CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF8 -Duser.timezone=GMT+9"
   
   저장 후
   sudo chmod +x setenv.sh
   ./setenv.sh
   한 후에 shutdown.sh
   startup.sh
   ```



## 기능 설명

### 0. 프로그램 컨셉

호반우가 수업에 출석하기 위해, 교내를 뛰어다니며 목표지점까지 도달하는 게임입니다.

결석 가능 횟수 == Life이며, Life가 0이 되면 F를 받아 재수강을 해야한다는 컨셉입니다.

각 유저는 여러 호반우를 키우며 각 호반우의 능력을 업그레이드하고 아이템과 스킬을 사용하여 게임을 클리어 할 수 있습니다.

클리어 정보는 기록되어 더 빠르게 클리어하도록 경쟁하는 시스템입니다.

### 1. 로그인 및 회원가입

* ID와 PW를 입력받아 PW를 SHA-512로 암호화하여 저장된 DB의 사용자 정보와 비교
* 로그인 성공시 쿠키에 ID와 암호화된 PW 저장
* 쿠키를 이용하여 각 페이지에서 로그인 되어있는 상태인지 확인함
* 회원가입시 ID와 PW를 입력 받아 존재하지않는 ID면 ID와 SHA-512로 암호화된 PW를 DB에 저장
* 로그인 시 일반 유저는 유저 메인페이지로, 관리자는 GM(Game Manager) 메인페이지로 이동

### 2. 유저 메인페이지

* 접속 시 쿠키값을 DB와 비교하여, 올바르게 로그인된 사용자인지 검사: 아니라면 로그인 페이지로 이동

* PW 변경: 현재 PW와 새로운 PW를 입력받아, 현재 PW가 일치하면 새로운 PW를  SHA-512로 암호화하여 DB에 update
* 회원탈퇴: PW를 입력받아 DB의 데이터와 비교후 일치하면 유저 계정 삭제
* 로그아웃: 쿠키값을 삭제하고 로그인페이지로 이동
* 캐릭터 생성: 캐릭터 이름을 입력하고, 스킬을 선택하고 생성버튼을 누르면, DB에 새로운 캐릭터 생성
  * DB에 저장되는 캐릭터 ID는 중복되지 않는 새로운 값으로 할당
  * DB에 저장되는 초기값 Lv: 1, Exp: 0, Speed: 0, Life: 3, coolDown: 0로 설정
* 사용자가 보유한 모든 캐릭터를 DB에서 가져와서 화면 중앙에 보여줌
  * 캐릭터 선택시 오른쪽에 DB에서 가져온 캐릭터의 상세 정보가 뜸
    * Level 만큼의 스탯을 Speed, Life, coolDown 어빌리티에 투자하여 기본 능력을 향상시킬 수 있다.
    * 플레이 버튼: 맵 선택 페이지로 이동
    * 삭제버튼: 해당 캐릭터를 DB에서 삭제한다

### 3. 맵 선택 페이지

* 접속 시 쿠키값을 DB와 비교하여, 올바르게 로그인 된 사용자인지, 올바른 캐릭터인지 검사: 아니라면 각각 로그인페이지, 유저메인페이지로 이동
* 상단엔 선택된 캐릭터에 대한 정보를 DB에서 가져와 출력
  * Level 만큼의 스탯을 Speed, Life, coolDown 어빌리티에 투자하여 기본 능력을 향상시킬 수 있다.
  * 캐릭터 선택을 다시 할 수 있도록 유저메인페이지 이동 버튼
* DB에서 전체 맵을 난이도 순서대로 가져와서 표시
  * 각 맵의 이름과 난이도 표시
  * 랭킹
    * 클릭시 DB에서 해당 맵을 클리어한 모든 기록을, 클리어시간이 빠른 순서대로 가져와서 보여준다.
  * 플레이
    * 게임 페이지로 이동

### 4. 게임 페이지

* 접속 시 쿠키값을 DB와 비교하여, 올바르게 로그인 된 사용자인지, 올바른 캐릭터인지 검사: 아니라면 각각 로그인페이지, 유저메인페이지로 이동
  * DB에 존재하지 않는 MapNo가 파라미터로 넘어올 경우, 맵 선택 페이지로 이동
* DB에서 유저 정보와 캐릭터 정보, 맵 정보를 가지고 옴
  * 유저가 가진 모든 아이템을 DB에서 불러와서 화면에 이미지 및 사용가능한 개수 표시
  * DB에서 가져온 캐릭터의 Speed, Life, coolDown 어빌리티, 사용 스킬, 레벨, 경험치를 기반으로 움직이는 캐릭터 구현
  * DB에서 가져온 맵 정보를 토대로 게임 맵 구현
* 1초에 60프레임씩, 매 프레임마다 새로 게임 화면을 그리며 playtime 상승
* 좌상단에 남은 Life 표기
* 우상단에 현재 playTime 표기
* 하단 skill 아이콘 구현, 스킬 사용시 남은 쿨타임 비율 만큼 회색으로 반투명하게 변함
* 하단 item 아이콘 구현, 사용 키와 남은 아이템 개수 표기
  * 아이템 사용 시, DB에 가지고 있는 아이템 개수 -1 업데이트
* 하단 중앙에 현재 플레이중인 캐릭터의 다양한 상세 정보 표기
* 우측에  조작 가이드(스페이스바:점프, 화살표) 표기, 해당 키를 누를 시, 회색으로 눌렸다는 것을 표기
* 구현된 스킬
  * smaller	3초간 캐릭터 크기 50% 감소
  * dash	짧게 앞으로 이동
  * doublejump	이단 점프
  * lowgravity	저중력
  * darksight	2초간 무적
  * heal	결석 가능 횟수 회복
  * shield	1회 방어
* 구현된 아이템
  * lifeUp	결석 가능 횟수 회복
  * speedUp	이동 속도 3 증가
  * jumpUp20	점프력 20% 증가
  * jumpUp50	점프력 50% 증가
  * guard	1회 방어
  * coolDown	쿨타임 20% 감소
* 캐릭터를 조작하여, 캐릭터가 발판을 밟고 파란색 골인 지점까지 가는 것이 목표인 게임
  * 빨간색에 닿을 경우, Life 감소
  * Life가 0이 될 경우, 클리어 실패
    * 경험치 5 획득 => DB에 반영
    * 낮은 확률로 아이템획득 =>  DB에 반영
  * 파란색 골인 지점에 도달할 경우, 클리어
    * 클리어 시간이 DB에 기록됨
    * 높은 확률로 아이템 획득 => DB에 반영
  * 재수강하기 버튼: 재시도
  * 나가기: 맵 선택 페이지로 이동

### 5. 관리자 메인 페이지

* 접속시 쿠키의 정보와 DB의 정보를 대조하여 관리자가 맞는지 확인, 아니라면 로그인 페이지로 이동
* 유저 관리 버튼: 유저 관리 페이지로 이동
* 통계 자료 버튼: 통계 페이지로 이동
* 로그아웃 버튼: 쿠키 정보 삭제 후 로그인 페이지로 이동

### 6. 유저 관리 페이지

* 왼쪽에 DB에서 가져온 모든 유저의 목록을 표시
* 유저목록 클릭시 오른쪽에 해당 유저에 대한 정보를 DB에서 가져와서 표시
  * 비밀번호 변경: 기존 비밀 번호를 몰라도 강제로 변경시켜 DB에 반영할 수 있다.
  * 계정 삭제: 해당 계정을 DB에서 지워버릴 수 있다.
  * 해당유저가 가진 모든 아이템 목록이 DB에서 조회된다.
  * 해당 유저가 가진 모든 캐릭터 목록이 DB에서 조회된다.
* 각 캐릭터 선택 시
  * 해당 캐릭터의 능력치들이 DB에서 조회된다.
  * 해당 캐릭터의 Lv과 exp를 수정하여 DB에 반영할 수 있는 메뉴
  * 해당 캐릭터의 클리어 기록을 DB에서 조회할 수 있는 메뉴
  * 해당 캐릭터를 DB에서 삭제할 수 있는 메뉴

### 7. 통계 자료 페이지

* DB에서 다음 정보들을 상세하게 검색해서 table 형식으로 보여준다
  * 전체 클리어 기록 조회
  * 원하는 계정의 클리어 기록 조회
  * 각 스킬별 클리어 기록 조회
  * 목숨 n개로 m초 이내에 클리어한 기록 조회
  * x 맵의 모든 발판 조회
  * n초 이내로 클리어한 기록이 있는 맵 조회
  * 데미지가 n이상이거나 크기가 x*y이상인 위험한 장애물 조회



## 기능 구현

**DAO(Data Access Object)**와 **DTO(Data Transfer Object)**를 이용하여 Java에서 좀 더 편하게 데이터베이스를 관리할 수 있게 구성하였고, apis 폴더 안에 있는 jsp들에서 각 DAO의 메서드들을 호출하여 DB에서 원하는 결과만 쉽게 받아올 수 있게 구현했습니다.

DB에 쿼리문을 요청하는 기능들 중 일부는 DB의 무결성과 일관성을 위하여 SERIALIZABLE TRANSACTION을 사용하였습니다.

사용한 이유와 기능은 다음과 같습니다

```sql
# 아이템 사용 및 획득이 동시에 일어나는 경우: 아이템의 개수가 정확하게 기록되지 않는 오류 발생 가능
-> ITEMCOUNT를 UPDATE하는 내용을 SERIALIZABLE TRANSACTION으로 만들어 해결
code res
- hobanu_run_web_game/src/main/java/DAO/ItemDAO.java: addItem 메서드
- hobanu_run_web_game/src/main/java/DAO/ItemDAO.java: useItem 메서드

# 빠른속도로 ABILITY를 올릴 경우: ABILITY 증가 중 일부가 누락될 수 있음
-> ABILITY를 UPDATE하는 내용을 SERIALIZABLE TRANSACTION으로 만들어서 해결함
code res - hobanu_run_web_game/src/main/java/DAO/CharacterDAO.java: upgradeAbility 메서드
```



## 실행 시 유의사항

* 회원가입 시 **아이디**는 영어와 숫자만 가능합니다. 한글이나 특수문자가 들어갈 경우 정상적인 작동이 안 됩니다.
* 관리자 계정은 gamemanager1 ~ gamemanager3이고, 비밀번호는 모두 cowrun 입니다.
* 회원가입시 gamemanager로 시작하는 아이디는 사용할 수 없습니다.



## Application 제작환경

* OS: Windows 10, Ubuntu 22.04.1 LTS
* DBMS: oracle-xe-11g
* Language: JDK 11
* IDE: eclipse IDE for Enterprise Java and Web Developers - 2021-09
* Server: apache-tomcat-8.5.83

