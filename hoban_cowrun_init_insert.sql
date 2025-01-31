-----------------DROP------------------

 DROP TABLE USERS CASCADE CONSTRAINTS;
 DROP TABLE ITEMS CASCADE CONSTRAINTS;
 DROP TABLE OWNS CASCADE CONSTRAINTS;
 DROP TABLE CHARACTERS CASCADE CONSTRAINTS;
 DROP TABLE ABILITIES CASCADE CONSTRAINTS;
 DROP TABLE SKILLS CASCADE CONSTRAINTS;
 DROP TABLE USES CASCADE CONSTRAINTS;
 DROP TABLE RECORDS CASCADE CONSTRAINTS;
 DROP TABLE MAPS CASCADE CONSTRAINTS;
 DROP TABLE BASES CASCADE CONSTRAINTS;
 DROP TABLE HURDLES CASCADE CONSTRAINTS;

----------------CREATE------------------

CREATE TABLE USERS (
    USERID   VARCHAR(14) PRIMARY KEY,
    PASSWORD VARCHAR(128) NOT NULL
);
CREATE TABLE ITEMS (
    ITEMID   VARCHAR(10) PRIMARY KEY,
    ITEMNAME VARCHAR(60) NOT NULL UNIQUE,
    ITEMIMG  VARCHAR(50) --img path
);
CREATE TABLE OWNS (
    USERID    VARCHAR(14), --foreign key
    ITEMID    VARCHAR(10), --foreign key
    ITEMCOUNT INT,
    FOREIGN KEY ( USERID )
        REFERENCES USERS ( USERID )
            ON DELETE CASCADE,
    FOREIGN KEY ( ITEMID )
        REFERENCES ITEMS ( ITEMID )
            ON DELETE CASCADE,
    PRIMARY KEY ( USERID, ITEMID )
);
CREATE TABLE SKILLS (
    SKILLID   VARCHAR(10) PRIMARY KEY,
    SKILLNAME VARCHAR(60) NOT NULL UNIQUE,
    SKILLIMG  VARCHAR(50), --img path
    DURATION  INT,
    COOLTIME  INT NOT NULL
);
CREATE TABLE CHARACTERS (
    USERID        VARCHAR(14), --foreign key
    CHARACTERID   VARCHAR(8) PRIMARY KEY,
    CHARACTERNAME VARCHAR(60) NOT NULL UNIQUE,
    LV            INT,
    EXP           INT CHECK ( EXP BETWEEN 0 AND 100 ),
    SKILLID       VARCHAR(10), --foreign key
    FOREIGN KEY ( USERID )
        REFERENCES USERS ( USERID )
            ON DELETE CASCADE,
    FOREIGN KEY ( SKILLID )
        REFERENCES SKILLS ( SKILLID )
            ON DELETE SET NULL
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
CREATE TABLE MAPS (
    MAPNO         VARCHAR(10) PRIMARY KEY,
    MAPNAME       VARCHAR(60) NOT NULL UNIQUE,
    BACKGROUNDIMG VARCHAR(50), --img path
    MAPSIZEX      INT NOT NULL,
    MAPSIZEY      INT NOT NULL,
    GOALX         INT NOT NULL,
    GOALY         INT NOT NULL,
    DIFFICULTY    INT NOT NULL
);
CREATE TABLE BASES (
    MAPNO     VARCHAR(10), --foreign key
    BASEID    VARCHAR(8) NOT NULL,
    POSITIONX INT NOT NULL,
    POSITIONY INT NOT NULL,
    OBJSIZEX  INT NOT NULL,
    OBJSIZEY  INT NOT NULL,
    OBJIMG    VARCHAR(50), --img path

    FOREIGN KEY ( MAPNO )
        REFERENCES MAPS ( MAPNO )
            ON DELETE CASCADE,
    PRIMARY KEY ( MAPNO, BASEID )
);
CREATE TABLE HURDLES (
    MAPNO     VARCHAR(10), --foreign key
    HURDLEID  VARCHAR(8) NOT NULL,
    POSITIONX INT NOT NULL,
    POSITIONY INT NOT NULL,
    OBJSIZEX  INT NOT NULL,
    OBJSIZEY  INT NOT NULL,
    OBJIMG    VARCHAR(50), --img path
    DAMAGE    INT,
    FOREIGN KEY ( MAPNO )
        REFERENCES MAPS ( MAPNO )
            ON DELETE CASCADE,
    PRIMARY KEY ( MAPNO, HURDLEID )
);
CREATE TABLE RECORDS (
    CHARACTERID VARCHAR(14), --foreign key
    MAPNO       VARCHAR(10), --foriegn key
    RECORDNO    INT PRIMARY KEY, --auto_increase
    CLEARTIME   INT,
    FOREIGN KEY ( CHARACTERID )
        REFERENCES CHARACTERS ( CHARACTERID )
            ON DELETE CASCADE,
    FOREIGN KEY ( MAPNO )
        REFERENCES MAPS ( MAPNO )
            ON DELETE CASCADE
);
DROP SEQUENCE RECORD_SEQ;
CREATE SEQUENCE RECORD_SEQ START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

----------------INSERT-----------------

--items
INSERT INTO items VALUES ('lifeUp', '결석 가능 횟수 회복', './img/item/lifeUp.png');
INSERT INTO items VALUES ('speedUp', '이동 속도 3 증가', './img/item/speedUp.png');
INSERT INTO items VALUES ('jumpUp20', '점프력 20% 증가', './img/item/jumpUp20.png');
INSERT INTO items VALUES ('jumpUp50', '점프력 50% 증가', './img/item/jumpUp50.png');
INSERT INTO items VALUES ('guard', '1회 방어', './img/item/guard.png');
INSERT INTO items VALUES ('coolDown', '쿨타임 20% 감소', './img/item/coolDown.png');

--skills
INSERT INTO skills VALUES ('smaller', '3초간 캐릭터 크기 50% 감소', './img/skill/smaller.png', 3, 8);
INSERT INTO skills VALUES ('dash', '짧게 앞으로 이동', './img/skill/dash.png', 0, 5);
INSERT INTO skills VALUES ('doublejump', '이단 점프', './img/skill/doublejump.png', 0, 5);
INSERT INTO skills VALUES ('lowgravity', '저중력', './img/skill/lowgravity.png', 3, 12);
INSERT INTO skills VALUES ('darksight', '2초간 무적', './img/skill/darksight.png', 2, 30);
INSERT INTO skills VALUES ('heal', '결석 가능 횟수 회복', './img/skill/heal.png', 0, 30);
INSERT INTO skills VALUES ('shield', '1회 방어', './img/skill/shield.png', 5, 20);

--users
INSERT INTO users VALUES ('kimjhyun0001', 'HoHKL7zxbqQ9zeuJLkCg+SBn2I2Hef0l4xYD71fyTtwBqLUQnrfWUYfq80PkGjQ2dXP/F0y8Bt95MMxb4K3GhA=='); --asdf1111
INSERT INTO users VALUES ('kimjhyun0002', '+SwrjzEmEZcaaJwWEnmavRevluOMxZv/udwMMTTPCOL0YYfdNbLvbZ2MijA0rjflgLK6DS8O27L9rNDJ7KsWIg=='); --asdf2222
INSERT INTO users VALUES ('kimjhyun0003', '8sfNalIQ22002cq8oSvEwqiKKJcJ5vPA8a2fSgJ4tH7As4q8KbN4I+0UpMHhEivneg3vkdrNfq+W/4y/LuOSHA=='); --asdf3333
INSERT INTO users VALUES ('kimjhyun0004', '0Jnj47aSSaO5k0OBKup+FTLERmWJbtOEEMk8t7SU9gDU3Mq4wVscdiAcY4GFyphb/YKCbKXUwMrb7a3eAiiwbQ=='); --asdf4444
INSERT INTO users VALUES ('kimjhyun0005', 'c7r/lb/GkP5QjbepjwodbMczVEewHrr7FuXJcLT3UydaYBl3qyghRU23QvgIZ4Xfu7FRARkursm+ILF+Ptpedw=='); --asdf5555
INSERT INTO users VALUES ('kimjhyun0006', 'gcL1+G8DtHpaLIw6oq8odEnW6uDtlIWdG3RjKiuiPP/OFzvp7oSUJGZ6ko8kzVGfpP9VafMrhsIgGdqjRCqkkQ=='); --asdf6666
INSERT INTO users VALUES ('kimjhyun0007', 'DRKMcFof77Tsd0Ds852cVuEQsLkfFhkkF7vuZRMLkkoNRvwyRmL5qwViCTBcIg3CgodfIz/BTOnDmQSnsSgcEg=='); --asdf7777
INSERT INTO users VALUES ('kimjhyun0008', 'AyV8mHG1tMCAWj7aPXO1xLR3S1rARneewnUB9gYthOBYfDpS0stdgCSXzCYOjr1RxT9xhERAsOhPBXFnbHpHMA=='); --asdf8888
INSERT INTO users VALUES ('kimjhyun0009', 'q6EXPnnATEtlUr2pmIbEMgOjD7O9/doHR5ox9guzkUUD3yrHaRLvIYUnEZmbDa9ZO7Leg6jFI33Xy1++DAKQmQ=='); --asdf9999
INSERT INTO users VALUES ('kimjhyun0010', 'yLaSdYm+nEMhj9K7pOcoHa/BuJWbrV6RUSWmr1xaabCtpfMhYGCCrMFvjHP4DeLaYtbg5Qf0JOlglyJ6SeT0OA=='); --asdf0000
INSERT INTO users VALUES ('kimjhyun0011', 'HoHKL7zxbqQ9zeuJLkCg+SBn2I2Hef0l4xYD71fyTtwBqLUQnrfWUYfq80PkGjQ2dXP/F0y8Bt95MMxb4K3GhA=='); --asdf1111
INSERT INTO users VALUES ('kimjhyun0012', '+SwrjzEmEZcaaJwWEnmavRevluOMxZv/udwMMTTPCOL0YYfdNbLvbZ2MijA0rjflgLK6DS8O27L9rNDJ7KsWIg=='); --asdf2222
INSERT INTO users VALUES ('kimjhyun0013', '8sfNalIQ22002cq8oSvEwqiKKJcJ5vPA8a2fSgJ4tH7As4q8KbN4I+0UpMHhEivneg3vkdrNfq+W/4y/LuOSHA=='); --asdf3333
INSERT INTO users VALUES ('kimjhyun0014', '0Jnj47aSSaO5k0OBKup+FTLERmWJbtOEEMk8t7SU9gDU3Mq4wVscdiAcY4GFyphb/YKCbKXUwMrb7a3eAiiwbQ=='); --asdf4444
INSERT INTO users VALUES ('kimjhyun0015', 'c7r/lb/GkP5QjbepjwodbMczVEewHrr7FuXJcLT3UydaYBl3qyghRU23QvgIZ4Xfu7FRARkursm+ILF+Ptpedw=='); --asdf5555
INSERT INTO users VALUES ('raipen01', '/8XyekTlL4C2iN+AFSY//ZwBNoUZIdSfJTWX3EYOh4S/EOIqkomgV6KmFY3+rJJ18E0ih7Geygi6dp7Quhwl/g=='); --qwerty11
INSERT INTO users VALUES ('raipen02', '3Tp1gf3jG48b8L+fSYNszrKUA/49dgey124IHLIgNXC47QAzN8B7W402jFXdJauA1/UuFBhAUcwc0n9HXw0lxQ=='); --qwerty22
INSERT INTO users VALUES ('raipen03', 'EzQ7XeTtfSzibHAbK7Tn3V33Te2rhEMM4lC/HWmjNKC1o/OU/GuuHB/5Wl6xwg8LgWo1x3sC0QCCYkxvx547Ng=='); --qwerty33
INSERT INTO users VALUES ('raipen04', 'zXbhzkRIkn0C+egN2qqH5kElYYS4fTAQsRruMs+xIqXNT90CaIXgLZ7kmkYEMi4rk3v6CcLC2y/8VIvx1zUqwA=='); --qwerty44
INSERT INTO users VALUES ('raipen05', 'F+tKgPRzycx7FfeU43P9+YSpJ7YgIF7IjW/OYi4uhif32eWob/VNDsyh3Tnop/N/RuHl9wQCgQlokRwAw0DQOQ=='); --qwerty55
INSERT INTO users VALUES ('raipen06', 'ZfLsgLgeLRnX6pOrHn9soJmFP8EPPBlgE+mM+CGWJvw8hYqK5JVmveLOjyMBod4Ulw84GFMuqD/fAQaCevnKhg=='); --qwerty66
INSERT INTO users VALUES ('raipen07', 'QNCHWy+MmH7F6BsMD+vkNvAqkhPQSoV8eKD2fnnxUZDOoO8PNm/CPMmxM+VKz0xP3DB1Bf/R3+qYvirZsyd5CQ=='); --qwerty77
INSERT INTO users VALUES ('raipen08', 'Sn8YhWy9B4kKnmu2eJ3a8fb9//xSsMisHS6OYXrw36DjKO8SkgrMPsFtqg3FGSFZrFzPViNJuokgW2RQ6CD8XA=='); --qwerty88
INSERT INTO users VALUES ('raipen09', 'nPs9oNQdqrmp6rEHOW5jvH43FgsL2vRAmpm/EVKJudqdXxLQ35ko2H3cT6EPb1ZHMP59ILgPPfZD//09EWzYLA=='); --qwerty99
INSERT INTO users VALUES ('raipen10', 'zig+eIqNocuSF26vU+Z8LbwORKmOKOkTWjcT/S0/rLO1H+vc1iMColHy8PInlwg3O1FccwGz0ar3RvDU52RPHQ=='); --qwerty00
INSERT INTO users VALUES ('raipen11', '/8XyekTlL4C2iN+AFSY//ZwBNoUZIdSfJTWX3EYOh4S/EOIqkomgV6KmFY3+rJJ18E0ih7Geygi6dp7Quhwl/g=='); --qwerty11
INSERT INTO users VALUES ('raipen12', '3Tp1gf3jG48b8L+fSYNszrKUA/49dgey124IHLIgNXC47QAzN8B7W402jFXdJauA1/UuFBhAUcwc0n9HXw0lxQ=='); --qwerty22
INSERT INTO users VALUES ('raipen13', 'EzQ7XeTtfSzibHAbK7Tn3V33Te2rhEMM4lC/HWmjNKC1o/OU/GuuHB/5Wl6xwg8LgWo1x3sC0QCCYkxvx547Ng=='); --qwerty33
INSERT INTO users VALUES ('raipen14', 'zXbhzkRIkn0C+egN2qqH5kElYYS4fTAQsRruMs+xIqXNT90CaIXgLZ7kmkYEMi4rk3v6CcLC2y/8VIvx1zUqwA=='); --qwerty44
INSERT INTO users VALUES ('raipen15', 'F+tKgPRzycx7FfeU43P9+YSpJ7YgIF7IjW/OYi4uhif32eWob/VNDsyh3Tnop/N/RuHl9wQCgQlokRwAw0DQOQ=='); --qwerty55
INSERT INTO users VALUES ('momnpa111', 'w+5trOC6DEnI056foLSAI3Vz1m/X/2PwafOJTje1GVOdRxQJ88EIX+6BWkxwgsnoF5vA9SCgtD2vrbTzf9hEKQ=='); --wasd111
INSERT INTO users VALUES ('momnpa222', 'uAsyi7btPhRgYy3PQAHE+l11msDGr07Ew3Xw83SLr2IjFc248lMR9A4aSSYwUiYseHnV6CWFWNV2lXek+oIvtg=='); --wasd222
INSERT INTO users VALUES ('momnpa333', 'lMeJVmEpOC5QHHa9c30jOP58vzkPfpYb18w533OZs0aX6ZUuxjDRdwhQovPPqpxOmbyQkPNwbSJZO4o6pGwVPQ=='); --wasd333
INSERT INTO users VALUES ('momnpa444', 'BHWBBgNkeRH7TMkKcPGf5oA1niaGWcMF0gDVy1i4JQfEiFoSqxzKUU5Tn3bAUl6CBY/cn7X/b/8PpTcpZ5k1Fw=='); --wasd444
INSERT INTO users VALUES ('momnpa555', 'eV52pW1Jm8GGiAdt7ljtp7vaOhxSZTHdlVgQHvmoN6IeQGnv4qu/v2kml6RaVytlZ1hz9YGOwDte2pu5E5KenA=='); --wasd555
INSERT INTO users VALUES ('momnpa666', 'ZAPzKdAYnHSMu/Y4G9ZcO1NpPYNrrw+SmX1UbVQwWC1b7zqv0fca6neK7lW8ZrcD+xIM5D0cRaumWSSGElR0tQ=='); --wasd666
INSERT INTO users VALUES ('momnpa777', '42rHlYLSMpjdgws3wRz0wSM00e8TtGBiBcFDfeA3rnwkNjyyhWadRV4lWU299BWux37kwuO/6TMEl5hLVbbKRg=='); --wasd777
INSERT INTO users VALUES ('momnpa888', '7rmonax7oXfz6dEVQYtC8tTVF540+gd0IWpjBJMzTxflSTf2Ai4YpS341dTnDwJ5gtPQSYIn84735i166/eg3g=='); --wasd888
INSERT INTO users VALUES ('momnpa999', 'vpHRhydJ6O7yyaTb+LzvUr3t9ftvSr5zZm9FLvfu7PkE6wO+FlYmI4zO8mdtsSkN12qj4e8khKQM3LL9AxOAUg=='); --wasd999
INSERT INTO users VALUES ('momnpa10', 'Em1bPVGih4G6LdPb7RoCxOoiiYsGYWJKxnu/nWOtkttgdZJkdOBlz2MrHP9+KIoAQP3CMy/jln3kbru/QYGrBw=='); --wasd000
INSERT INTO users VALUES ('momnpa11', 'w+5trOC6DEnI056foLSAI3Vz1m/X/2PwafOJTje1GVOdRxQJ88EIX+6BWkxwgsnoF5vA9SCgtD2vrbTzf9hEKQ=='); --wasd111
INSERT INTO users VALUES ('momnpa12', 'uAsyi7btPhRgYy3PQAHE+l11msDGr07Ew3Xw83SLr2IjFc248lMR9A4aSSYwUiYseHnV6CWFWNV2lXek+oIvtg=='); --wasd222
INSERT INTO users VALUES ('momnpa13', 'lMeJVmEpOC5QHHa9c30jOP58vzkPfpYb18w533OZs0aX6ZUuxjDRdwhQovPPqpxOmbyQkPNwbSJZO4o6pGwVPQ=='); --wasd333
INSERT INTO users VALUES ('momnpa14', 'BHWBBgNkeRH7TMkKcPGf5oA1niaGWcMF0gDVy1i4JQfEiFoSqxzKUU5Tn3bAUl6CBY/cn7X/b/8PpTcpZ5k1Fw=='); --wasd444
INSERT INTO users VALUES ('momnpa15', 'eV52pW1Jm8GGiAdt7ljtp7vaOhxSZTHdlVgQHvmoN6IeQGnv4qu/v2kml6RaVytlZ1hz9YGOwDte2pu5E5KenA=='); --wasd555
INSERT INTO users VALUES ('gamemanager1', '8uO+Sh1Bt5uC8+wxPyINfgHRcNyrfE2NmeQKY0/ze9G1CvdBNSEOtA2L8ccfCCEwIQ2LdQJlYS/NNbby1M5xzg=='); --cowrun
INSERT INTO users VALUES ('gamemanager2', '8uO+Sh1Bt5uC8+wxPyINfgHRcNyrfE2NmeQKY0/ze9G1CvdBNSEOtA2L8ccfCCEwIQ2LdQJlYS/NNbby1M5xzg=='); --cowrun
INSERT INTO users VALUES ('gamemanager3', '8uO+Sh1Bt5uC8+wxPyINfgHRcNyrfE2NmeQKY0/ze9G1CvdBNSEOtA2L8ccfCCEwIQ2LdQJlYS/NNbby1M5xzg=='); --cowrun
INSERT INTO users VALUES ('annonymous1', '4qMBvokwQ29sUbRyt5ra2Qkt006V4AH6dyYDyYe/L9gMyZ5F6UZYNdkwFe/StqgKbGMSriTEZCNJ66kxWmFDvg=='); --whoishe
INSERT INTO users VALUES ('annonymous2', 'dISPktQ/6o4JY97H1L6ENgMf65vLSsHUcWoux2lKN43Uyj/xcFFfuzThk9xJUZKHSNVNoty1IenXUov44zGOxg=='); --whoisshe

--owns
INSERT INTO owns VALUES ('kimjhyun0001', 'lifeUp', 3);
INSERT INTO owns VALUES ('kimjhyun0001', 'jumpUp20', 5);
INSERT INTO owns VALUES ('kimjhyun0001', 'guard', 2);
INSERT INTO owns VALUES ('kimjhyun0001', 'coolDown', 4);
INSERT INTO owns VALUES ('kimjhyun0002', 'lifeUp', 5);
INSERT INTO owns VALUES ('kimjhyun0003', 'speedUp', 1);
INSERT INTO owns VALUES ('kimjhyun0003', 'coolDown', 5);
INSERT INTO owns VALUES ('kimjhyun0003', 'guard', 2);
INSERT INTO owns VALUES ('kimjhyun0004', 'speedUp', 3);
INSERT INTO owns VALUES ('kimjhyun0006', 'guard', 12);
INSERT INTO owns VALUES ('kimjhyun0007', 'coolDown', 7);
INSERT INTO owns VALUES ('kimjhyun0008', 'lifeUp', 3);
INSERT INTO owns VALUES ('kimjhyun0010', 'lifeUp', 1);
INSERT INTO owns VALUES ('kimjhyun0010', 'speedUp', 1);
INSERT INTO owns VALUES ('kimjhyun0010', 'jumpUp20', 1);
INSERT INTO owns VALUES ('kimjhyun0010', 'jumpUp50', 1);
INSERT INTO owns VALUES ('kimjhyun0010', 'guard', 1);
INSERT INTO owns VALUES ('kimjhyun0010', 'coolDown', 1);
INSERT INTO owns VALUES ('kimjhyun0011', 'lifeUp', 4);
INSERT INTO owns VALUES ('kimjhyun0013', 'jumpUp20', 12);
INSERT INTO owns VALUES ('kimjhyun0013', 'jumpUp50', 9);
INSERT INTO owns VALUES ('kimjhyun0014', 'speedUp', 1);
INSERT INTO owns VALUES ('kimjhyun0014', 'guard', 3);
INSERT INTO owns VALUES ('kimjhyun0015', 'lifeUp', 19);
INSERT INTO owns VALUES ('kimjhyun0015', 'guard', 22);
INSERT INTO owns VALUES ('kimjhyun0015', 'speedUp', 7);
INSERT INTO owns VALUES ('raipen01', 'lifeUp', 6);
INSERT INTO owns VALUES ('raipen01', 'speedUp', 5);
INSERT INTO owns VALUES ('raipen01', 'jumpUp20', 8);
INSERT INTO owns VALUES ('raipen01', 'jumpUp50', 4);
INSERT INTO owns VALUES ('raipen01', 'guard', 23);
INSERT INTO owns VALUES ('raipen01', 'coolDown', 5);
INSERT INTO owns VALUES ('raipen02', 'lifeUp', 3);
INSERT INTO owns VALUES ('raipen03', 'guard', 5);
INSERT INTO owns VALUES ('raipen04', 'lifeUp', 3);
INSERT INTO owns VALUES ('raipen04', 'jumpUp50', 1);
INSERT INTO owns VALUES ('raipen05', 'lifeUp', 3);
INSERT INTO owns VALUES ('raipen05', 'jumpUp20', 4);
INSERT INTO owns VALUES ('raipen05', 'coolDown', 2);
INSERT INTO owns VALUES ('raipen06', 'speedUp', 1);
INSERT INTO owns VALUES ('raipen06', 'jumpUp20', 2);
INSERT INTO owns VALUES ('raipen07', 'coolDown', 2);
INSERT INTO owns VALUES ('raipen07', 'guard', 3);
INSERT INTO owns VALUES ('raipen08', 'speedUp', 2);
INSERT INTO owns VALUES ('raipen08', 'guard', 6);
INSERT INTO owns VALUES ('raipen09', 'lifeUp', 3);
INSERT INTO owns VALUES ('raipen09', 'jumpUp20', 3);
INSERT INTO owns VALUES ('raipen09', 'jumpUp50', 1);
INSERT INTO owns VALUES ('raipen09', 'guard', 4);
INSERT INTO owns VALUES ('raipen09', 'coolDown', 1);
INSERT INTO owns VALUES ('raipen11', 'speedUp', 1);
INSERT INTO owns VALUES ('raipen11', 'guard', 2);
INSERT INTO owns VALUES ('raipen13', 'guard', 12);
INSERT INTO owns VALUES ('raipen13', 'jumpUp50', 6);
INSERT INTO owns VALUES ('raipen14', 'speedUp', 18);
INSERT INTO owns VALUES ('raipen14', 'guard', 1);
INSERT INTO owns VALUES ('raipen15', 'jumpUp20', 3);
INSERT INTO owns VALUES ('raipen15', 'guard', 1);
INSERT INTO owns VALUES ('momnpa111', 'lifeUp', 7);
INSERT INTO owns VALUES ('momnpa111', 'speedUp', 1);
INSERT INTO owns VALUES ('momnpa111', 'jumpUp20', 11);
INSERT INTO owns VALUES ('momnpa111', 'jumpUp50', 8);
INSERT INTO owns VALUES ('momnpa111', 'guard', 6);
INSERT INTO owns VALUES ('momnpa222', 'coolDown', 3);
INSERT INTO owns VALUES ('momnpa333', 'lifeUp', 3);
INSERT INTO owns VALUES ('momnpa333', 'guard', 3);
INSERT INTO owns VALUES ('momnpa555', 'coolDown', 2);
INSERT INTO owns VALUES ('momnpa666', 'jumpUp50', 3);
INSERT INTO owns VALUES ('momnpa666', 'jumpUp20', 5);
INSERT INTO owns VALUES ('momnpa666', 'lifeUp', 14);
INSERT INTO owns VALUES ('momnpa666', 'speedUp', 1);
INSERT INTO owns VALUES ('momnpa777', 'lifeUp', 4);
INSERT INTO owns VALUES ('momnpa777', 'guard', 2);
INSERT INTO owns VALUES ('momnpa888', 'lifeUp', 5);
INSERT INTO owns VALUES ('momnpa888', 'speedUp', 1);
INSERT INTO owns VALUES ('momnpa888', 'jumpUp20', 5);
INSERT INTO owns VALUES ('momnpa888', 'guard', 5);
INSERT INTO owns VALUES ('momnpa888', 'coolDown', 5);
INSERT INTO owns VALUES ('momnpa999', 'lifeUp', 7);
INSERT INTO owns VALUES ('momnpa999', 'jumpUp50', 1);
INSERT INTO owns VALUES ('momnpa999', 'guard', 12);
INSERT INTO owns VALUES ('momnpa10', 'guard', 2);
INSERT INTO owns VALUES ('momnpa12', 'guard', 3);
INSERT INTO owns VALUES ('momnpa15', 'guard', 2);
INSERT INTO owns VALUES ('momnpa15', 'lifeUp', 1);
INSERT INTO owns VALUES ('momnpa15', 'jumpUp20', 6);
INSERT INTO owns VALUES ('momnpa15', 'jumpUp50', 1);

--characters
INSERT INTO characters VALUES ('kimjhyun0001', '00010001', '김진현1', 7, 50,'smaller');
INSERT INTO characters VALUES ('kimjhyun0001', '00010002', '호반우', 10, 10,'darksight');
INSERT INTO characters VALUES ('kimjhyun0001', '00010003', 'hobanCOW', 2, 30,'smaller');
INSERT INTO characters VALUES ('kimjhyun0001', '00010004', '김진현', 4, 25,'doublejump');
INSERT INTO characters VALUES ('kimjhyun0002', '00020001', 'kimjhyun', 3, 0,'dash');
INSERT INTO characters VALUES ('kimjhyun0002', '00020002', 'kimjhyun0002', 6, 90,'darksight');
INSERT INTO characters VALUES ('kimjhyun0002', '00020003', 'kimjh', 1, 0,'dash');
INSERT INTO characters VALUES ('kimjhyun0003', '00030001', '안녕하세요', 4, 0,'shield');
INSERT INTO characters VALUES ('kimjhyun0004', '00040001', '박지성', 8, 45,'shield');
INSERT INTO characters VALUES ('kimjhyun0004', '00040002', 'parkk', 3, 35,'lowgravity');
INSERT INTO characters VALUES ('kimjhyun0004', '00040003', 'jspark', 5, 95,'shield');
INSERT INTO characters VALUES ('kimjhyun0005', '00050001', '김연아', 9, 0,'darksight');
INSERT INTO characters VALUES ('kimjhyun0005', '00050002', 'Yuna', 2, 15,'lowgravity');
INSERT INTO characters VALUES ('kimjhyun0006', '00060001', '손흥민', 4, 50,'doublejump');
INSERT INTO characters VALUES ('kimjhyun0006', '00060002', 'hmSon', 2, 60,'shield');
INSERT INTO characters VALUES ('kimjhyun0006', '00060003', 'sony7', 8, 0,'shield');
INSERT INTO characters VALUES ('kimjhyun0006', '00060004', 'sooonie', 1, 5,'smaller');
INSERT INTO characters VALUES ('kimjhyun0007', '00070001', 'helloworld', 8, 5,'smaller');
INSERT INTO characters VALUES ('kimjhyun0008', '00080001', '비달바람', 3, 15,'dash');
INSERT INTO characters VALUES ('kimjhyun0008', '00080002', '이준섭1', 4, 15,'doublejump');
INSERT INTO characters VALUES ('kimjhyun0009', '00090001', '뾰족이', 7, 75,'doublejump');
INSERT INTO characters VALUES ('kimjhyun0009', '00090002', '뽀족이', 4, 15,'shield');
INSERT INTO characters VALUES ('kimjhyun0009', '00090003', '뾰죡이', 3, 0,'heal');
INSERT INTO characters VALUES ('kimjhyun0010', '00100001', '김김김', 2, 75,'darksight');
INSERT INTO characters VALUES ('kimjhyun0012', '00120001', 'wlsgusdl', 4, 55,'smaller');
INSERT INTO characters VALUES ('kimjhyun0013', '00130001', 'kjh0013', 3, 35,'darksight');
INSERT INTO characters VALUES ('kimjhyun0014', '00140001', '14번계정', 4, 45,'dash');
INSERT INTO characters VALUES ('kimjhyun0014', '00140002', '14번계정두번째', 2, 25,'shield');
INSERT INTO characters VALUES ('kimjhyun0015', '00150001', 'deft', 7, 50,'dash');
INSERT INTO characters VALUES ('raipen01', '01010001', '박지원', 9, 90,'dash');
INSERT INTO characters VALUES ('raipen01', '01010002', 'raipen', 3, 90,'lowgravity');
INSERT INTO characters VALUES ('raipen01', '01010003', '040404', 4, 05,'dash');
INSERT INTO characters VALUES ('raipen02', '01020001', '과탑', 10, 00,'heal');
INSERT INTO characters VALUES ('raipen03', '01030001', 'TOPPP', 3, 15,'shield');
INSERT INTO characters VALUES ('raipen04', '01040001', '추신수', 5, 15,'heal');
INSERT INTO characters VALUES ('raipen04', '01040002', '추추', 4, 40,'lowgravity');
INSERT INTO characters VALUES ('raipen05', '01050001', '김연경', 7, 80,'doublejump');
INSERT INTO characters VALUES ('raipen05', '01050002', '배구', 1, 20,'smaller');
INSERT INTO characters VALUES ('raipen05', '01050003', '식빵언니', 2, 20,'lowgravity');
INSERT INTO characters VALUES ('raipen06', '01060001', '아이유', 8, 15,'heal');
INSERT INTO characters VALUES ('raipen06', '01060002', '유애나', 4, 00,'shield');
INSERT INTO characters VALUES ('raipen07', '01070001', '헤이즈', 2, 75,'heal');
INSERT INTO characters VALUES ('raipen08', '01080001', 'giriboy', 5, 55,'dash');
INSERT INTO characters VALUES ('raipen09', '01090001', '카더가든', 7, 25,'lowgravity');
INSERT INTO characters VALUES ('raipen09', '01090002', 'carthegarden', 1, 35,'doublejump');
INSERT INTO characters VALUES ('raipen10', '01100001', '검정치마', 5, 85,'smaller');
INSERT INTO characters VALUES ('raipen10', '01100002', 'BLKSKT', 1, 15,'darksight');
INSERT INTO characters VALUES ('raipen12', '01120001', '정준일', 3, 0,'heal');
INSERT INTO characters VALUES ('raipen13', '01130001', '노을', 5, 5,'darksight');
INSERT INTO characters VALUES ('raipen14', '01140001', 'michael jordan', 9, 5,'darksight');
INSERT INTO characters VALUES ('raipen15', '01150001', 'michel jackson', 4, 65,'smaller');
INSERT INTO characters VALUES ('momnpa333', '02030001', '권다운', 9, 65,'doublejump');
INSERT INTO characters VALUES ('momnpa111', '02010001', '다운권', 2, 15,'dash');
INSERT INTO characters VALUES ('momnpa111', '02010002', '권권다운', 3, 65,'dash');
INSERT INTO characters VALUES ('momnpa222', '02020001', '아름다운', 8, 35,'shield');
INSERT INTO characters VALUES ('momnpa444', '02040001', '야다', 2, 0,'darksight');
INSERT INTO characters VALUES ('momnpa444', '02040002', '이미슬픈사랑', 5, 10,'doublejump');
INSERT INTO characters VALUES ('momnpa555', '02050001', '오오오오오', 5, 55,'doublejump');
INSERT INTO characters VALUES ('momnpa555', '02050002', '엘지', 4, 5,'lowgravity');
INSERT INTO characters VALUES ('momnpa555', '02050003', '삼성', 7, 10,'smaller');
INSERT INTO characters VALUES ('momnpa555', '02050004', 'apple', 5, 95,'smaller');
INSERT INTO characters VALUES ('momnpa666', '02060001', 'grace', 6, 95,'dash');
INSERT INTO characters VALUES ('momnpa777', '02070001', 'MCtheMax', 9, 5,'heal');
INSERT INTO characters VALUES ('momnpa777', '02070002', '박효신', 3, 15,'dash');
INSERT INTO characters VALUES ('momnpa777', '02070003', '이수', 4, 0,'doublejump');
INSERT INTO characters VALUES ('momnpa777', '02070004', '나얼', 7, 65,'lowgravity');
INSERT INTO characters VALUES ('momnpa777', '02070005', '김범수', 7, 75,'doublejump');
INSERT INTO characters VALUES ('momnpa777', '02070006', '혁오', 4, 55,'heal');
INSERT INTO characters VALUES ('momnpa888', '02080001', '조이', 1, 55,'heal');
INSERT INTO characters VALUES ('momnpa888', '02080002', 'Joy', 4, 5,'lowgravity');
INSERT INTO characters VALUES ('momnpa888', '02080003', 'JOE', 1, 0,'smaller');
INSERT INTO characters VALUES ('momnpa999', '02090001', '정승환', 3, 0,'smaller');
INSERT INTO characters VALUES ('momnpa10', '02100001', '토마토', 5, 0,'lowgravity');
INSERT INTO characters VALUES ('momnpa10', '02100002', 'tomato', 1, 5,'darksight');
INSERT INTO characters VALUES ('momnpa10', '02100003', 'TOM', 2, 30,'darksight');
INSERT INTO characters VALUES ('momnpa11', '02110001', 'billie eilish', 9, 15,'lowgravity');
INSERT INTO characters VALUES ('momnpa11', '02110002', 'adele', 5, 5,'shield');
INSERT INTO characters VALUES ('momnpa11', '02110003', 'sia', 1, 95,'lowgravity');
INSERT INTO characters VALUES ('momnpa12', '02120001', 'holland', 9, 95,'lowgravity');
INSERT INTO characters VALUES ('momnpa12', '02120004', 'kevin', 4, 55,'smaller');
INSERT INTO characters VALUES ('momnpa12', '02120002', 'kane', 3, 5,'darksight');
INSERT INTO characters VALUES ('momnpa12', '02120003', 'Harry kane', 1, 55,'doublejump');
INSERT INTO characters VALUES ('momnpa14', '02140001', 'Messi', 7, 55,'lowgravity');
INSERT INTO characters VALUES ('momnpa14', '02140002', 'Ronaldo', 10, 5,'darksight');
INSERT INTO characters VALUES ('momnpa15', '02150001', 'HELP', 3, 10,'heal');
INSERT INTO characters VALUES ('gamemanager1', '99010001', 'GM1', 10, 100,'shield');
INSERT INTO characters VALUES ('gamemanager2', '99020001', 'GM2', 10, 100,'shield');
INSERT INTO characters VALUES ('gamemanager3', '99030001', 'GM3', 10, 100,'heal');
INSERT INTO characters VALUES ('annonymous1', '05010001', 'whoishe?', 1, 0,'doublejump');
INSERT INTO characters VALUES ('annonymous2', '05020001', 'whoisshe?', 1, 0,'heal');

--ability
 --[characterid, speed(5~10), health(3~5), cooldown(0~5)]
INSERT INTO abilities VALUES ('00010001', 0, 3, 0);
INSERT INTO abilities VALUES ('00010002', 0, 3, 0);
INSERT INTO abilities VALUES ('00010003', 0, 3, 0);
INSERT INTO abilities VALUES ('00010004', 0, 3, 0);
INSERT INTO abilities VALUES ('00020001', 0, 3, 0);
INSERT INTO abilities VALUES ('00020002', 0, 3, 0);
INSERT INTO abilities VALUES ('00020003', 0, 3, 0);
INSERT INTO abilities VALUES ('00030001', 0, 3, 0);
INSERT INTO abilities VALUES ('00040001', 0, 3, 0);
INSERT INTO abilities VALUES ('00040002', 0, 3, 0);
INSERT INTO abilities VALUES ('00040003', 0, 3, 0);
INSERT INTO abilities VALUES ('00050001', 0, 3, 0);
INSERT INTO abilities VALUES ('00050002', 0, 3, 0);
INSERT INTO abilities VALUES ('00060001', 0, 3, 0);
INSERT INTO abilities VALUES ('00060002', 0, 3, 0);
INSERT INTO abilities VALUES ('00060003', 0, 3, 0);
INSERT INTO abilities VALUES ('00060004', 0, 3, 0);
INSERT INTO abilities VALUES ('00070001', 0, 3, 0);
INSERT INTO abilities VALUES ('00080001', 0, 3, 0);
INSERT INTO abilities VALUES ('00080002', 0, 3, 0);
INSERT INTO abilities VALUES ('00090001', 0, 3, 0);
INSERT INTO abilities VALUES ('00090002', 0, 3, 0);
INSERT INTO abilities VALUES ('00090003', 0, 3, 0);
INSERT INTO abilities VALUES ('00100001', 0, 3, 0);
INSERT INTO abilities VALUES ('00120001', 0, 3, 0);
INSERT INTO abilities VALUES ('00130001', 0, 3, 0);
INSERT INTO abilities VALUES ('00140001', 0, 3, 0);
INSERT INTO abilities VALUES ('00140002', 0, 3, 0);
INSERT INTO abilities VALUES ('00150001', 0, 3, 0);
INSERT INTO abilities VALUES ('01010001', 0, 3, 0);
INSERT INTO abilities VALUES ('01010002', 0, 3, 0);
INSERT INTO abilities VALUES ('01010003', 0, 3, 0);
INSERT INTO abilities VALUES ('01020001', 0, 3, 0);
INSERT INTO abilities VALUES ('01030001', 0, 3, 0);
INSERT INTO abilities VALUES ('01040001', 0, 3, 0);
INSERT INTO abilities VALUES ('01040002', 0, 3, 0);
INSERT INTO abilities VALUES ('01050001', 0, 3, 0);
INSERT INTO abilities VALUES ('01050002', 0, 3, 0);
INSERT INTO abilities VALUES ('01050003', 0, 3, 0);
INSERT INTO abilities VALUES ('01060001', 0, 3, 0);
INSERT INTO abilities VALUES ('01060002', 0, 3, 0);
INSERT INTO abilities VALUES ('01070001', 0, 3, 0);
INSERT INTO abilities VALUES ('01080001', 0, 3, 0);
INSERT INTO abilities VALUES ('01090001', 0, 3, 0);
INSERT INTO abilities VALUES ('01090002', 0, 3, 0);
INSERT INTO abilities VALUES ('01100001', 0, 3, 0);
INSERT INTO abilities VALUES ('01100002', 0, 3, 0);
INSERT INTO abilities VALUES ('01120001', 0, 3, 0);
INSERT INTO abilities VALUES ('01130001', 0, 3, 0);
INSERT INTO abilities VALUES ('01140001', 0, 3, 0);
INSERT INTO abilities VALUES ('01150001', 0, 3, 0);
INSERT INTO abilities VALUES ('02010001', 0, 3, 0);
INSERT INTO abilities VALUES ('02010002', 0, 3, 0);
INSERT INTO abilities VALUES ('02020001', 0, 3, 0);
INSERT INTO abilities VALUES ('02030001', 0, 3, 0);
INSERT INTO abilities VALUES ('02040001', 0, 3, 0);
INSERT INTO abilities VALUES ('02040002', 0, 3, 0);
INSERT INTO abilities VALUES ('02050001', 0, 3, 0);
INSERT INTO abilities VALUES ('02050002', 0, 3, 0);
INSERT INTO abilities VALUES ('02050003', 0, 3, 0);
INSERT INTO abilities VALUES ('02050004', 0, 3, 0);
INSERT INTO abilities VALUES ('02060001', 0, 3, 0);
INSERT INTO abilities VALUES ('02070001', 0, 3, 0);
INSERT INTO abilities VALUES ('02070002', 0, 3, 0);
INSERT INTO abilities VALUES ('02070003', 0, 3, 0);
INSERT INTO abilities VALUES ('02070004', 0, 3, 0);
INSERT INTO abilities VALUES ('02070005', 0, 3, 0);
INSERT INTO abilities VALUES ('02070006', 0, 3, 0);
INSERT INTO abilities VALUES ('02080001', 0, 3, 0);
INSERT INTO abilities VALUES ('02080002', 0, 3, 0);
INSERT INTO abilities VALUES ('02080003', 0, 3, 0);
INSERT INTO abilities VALUES ('02090001', 0, 3, 0);
INSERT INTO abilities VALUES ('02100001', 0, 3, 0);
INSERT INTO abilities VALUES ('02100002', 0, 3, 0);
INSERT INTO abilities VALUES ('02100003', 0, 3, 0);
INSERT INTO abilities VALUES ('02110001', 0, 3, 0);
INSERT INTO abilities VALUES ('02110002', 0, 3, 0);
INSERT INTO abilities VALUES ('02110003', 0, 3, 0);
INSERT INTO abilities VALUES ('02120001', 0, 3, 0);
INSERT INTO abilities VALUES ('02120002', 0, 3, 0);
INSERT INTO abilities VALUES ('02120003', 0, 3, 0);
INSERT INTO abilities VALUES ('02120004', 0, 3, 0);
INSERT INTO abilities VALUES ('02140001', 0, 3, 0);
INSERT INTO abilities VALUES ('02140002', 0, 3, 0);
INSERT INTO abilities VALUES ('02150001', 0, 3, 0);
INSERT INTO abilities VALUES ('99010001', 0, 3, 0);
INSERT INTO abilities VALUES ('99020001', 0, 3, 0);
INSERT INTO abilities VALUES ('99030001', 0, 3, 0);
INSERT INTO abilities VALUES ('05010001', 0, 3, 0);
INSERT INTO abilities VALUES ('05020001', 0, 3, 0);

Insert into maps values ('19980001','북문','./img/maps/ground01.png',150,35,147,4,2);
Insert into maps values ('19980002','일청담','./img/maps/ground02.png',100,35,98,2,4);
Insert into maps values ('19980003','백양로','./img/maps/ground03.png',100,35,98,31,5);
--Insert into maps values ('19980004','IT융복합공학관','./img/maps/ground04.png',920,880,900,800,8);
Insert into maps values ('19980009','튜토리얼','./img/maps/ground00.png',200,35,142,31,1);
 
INSERT INTO BASES  VALUES ('19980001', '1', 100, 5, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '2', 99, 7, 1, 9, 'black');
INSERT INTO BASES  VALUES ('19980001', '3', 100, 11, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '4', 96, 33, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '5', 99, 32, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '6', 101, 31, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '7', 102, 30, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '8', 103, 29, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '9', 104, 28, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '10', 105, 5, 1, 23, 'black');
INSERT INTO BASES  VALUES ('19980001', '11', 103, 23, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '12', 103, 15, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '13', 103, 7, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '14', 105, 5, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '15', 111, 0, 1, 12, 'black');
INSERT INTO BASES  VALUES ('19980001', '16', 111, 11, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '17', 117, 15, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '18', 110, 30, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '19', 115, 27, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '20', 115, 27, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '21', 119, 24, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '22', 119, 24, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '23', 123, 21, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '24', 123, 21, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '25', 128, 4, 1, 18, 'black');
INSERT INTO BASES  VALUES ('19980001', '26', 117, 7, 7, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '27', 123, 4, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '28', 123, 4, 18, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '29', 126, 17, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '30', 122, 30, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '31', 122, 30, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '32', 126, 26, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '33', 126, 26, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '34', 131, 22, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '35', 131, 22, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '36', 134, 18, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '37', 134, 18, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '38', 137, 14, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '39', 137, 14, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '40', 140, 10, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '41', 140, 10, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '42', 143, 6, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '43', 143, 6, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '44', 149, 0, 1, 35, 'black');
INSERT INTO BASES  VALUES ('19980001', '45', 5, 31, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '46', 12, 27, 7, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '47', 22, 25, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '48', 38, 33, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '49', 68, 9, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '50', 0, 34, 31, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '51', 30, 20, 1, 15, 'black');
INSERT INTO BASES  VALUES ('19980001', '52', 31, 20, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '53', 33, 21, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '54', 34, 25, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '55', 35, 24, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '56', 36, 23, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '57', 37, 22, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '58', 38, 21, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '59', 39, 20, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '60', 40, 21, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '61', 39, 24, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '62', 38, 25, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '63', 37, 26, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '64', 36, 27, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '65', 35, 28, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '66', 34, 29, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '67', 35, 30, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '68', 36, 31, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '69', 37, 32, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '70', 33, 32, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '71', 34, 32, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '72', 35, 33, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '73', 36, 34, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '74', 39, 34, 14, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '75', 52, 13, 1, 21, 'black');
INSERT INTO BASES  VALUES ('19980001', '76', 49, 31, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '77', 49, 23, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '78', 49, 16, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '79', 46, 20, 1, 11, 'black');
INSERT INTO BASES  VALUES ('19980001', '80', 47, 20, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '81', 47, 27, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '82', 47, 12, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '83', 46, 6, 1, 7, 'black');
INSERT INTO BASES  VALUES ('19980001', '84', 46, 6, 9, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '85', 55, 7, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '86', 56, 9, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '87', 57, 11, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '88', 58, 13, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '89', 59, 15, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '90', 60, 17, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '91', 61, 18, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '92', 62, 19, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '93', 63, 23, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '94', 64, 26, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '95', 65, 28, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '96', 66, 29, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '97', 53, 13, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '98', 54, 14, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '99', 55, 16, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '100', 56, 18, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '101', 57, 20, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '102', 58, 21, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '103', 59, 25, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '104', 60, 27, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '105', 61, 29, 1, 4, 'black');
INSERT INTO BASES  VALUES ('19980001', '106', 62, 32, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '107', 63, 33, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '108', 63, 34, 87, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '109', 67, 29, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '110', 67, 5, 1, 24, 'black');
INSERT INTO BASES  VALUES ('19980001', '111', 68, 22, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '112', 70, 13, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '113', 71, 27, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '114', 71, 31, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '115', 73, 5, 1, 27, 'black');
INSERT INTO BASES  VALUES ('19980001', '116', 71, 5, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '117', 72, 10, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '118', 72, 17, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '119', 71, 18, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '120', 78, 5, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '121', 79, 5, 1, 23, 'black');
INSERT INTO BASES  VALUES ('19980001', '122', 80, 27, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '123', 81, 29, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '124', 82, 30, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '125', 83, 31, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980001', '126', 84, 32, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '127', 85, 33, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '128', 85, 5, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '129', 85, 6, 1, 14, 'black');
INSERT INTO BASES  VALUES ('19980001', '130', 86, 20, 1, 7, 'black');
INSERT INTO BASES  VALUES ('19980001', '131', 86, 26, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '132', 90, 27, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '133', 95, 26, 7, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '134', 98, 23, 1, 3, 'black');
INSERT INTO BASES  VALUES ('19980001', '135', 99, 19, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980001', '136', 99, 19, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '137', 89, 5, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '138', 92, 5, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '139', 95, 5, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980001', '140', 97, 5, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '1', 46, 28, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '2', 14, 34, 50, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '3', 0, 33, 14, 2, 'black');
INSERT INTO BASES  VALUES ('19980002', '4', 16, 33, 8, 2, 'black');
INSERT INTO BASES  VALUES ('19980002', '5', 36, 33, 5, 2, 'black');
INSERT INTO BASES  VALUES ('19980002', '6', 53, 33, 47, 2, 'black');
INSERT INTO BASES  VALUES ('19980002', '7', 25, 30, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '8', 28, 28, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '9', 8, 28, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '10', 36, 28, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '11', 40, 28, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '12', 46, 48, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '13', 35, 29, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '14', 40, 29, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '15', 36, 30, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '16', 51, 30, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '17', 86, 30, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '18', 37, 31, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '19', 38, 32, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '20', 67, 26, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '21', 77, 26, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '22', 50, 24, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '23', 55, 23, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '24', 4, 23, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '25', 88, 23, 12, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '26', 20, 21, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '27', 62, 21, 7, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '28', 9, 20, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '29', 51, 19, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '30', 71, 19, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '31', 83, 19, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '32', 94, 19, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '33', 2, 17, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '34', 43, 16, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '35', 59, 16, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '36', 29, 15, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '37', 78, 15, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '38', 32, 14, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '39', 47, 14, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '40', 96, 14, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '41', 62, 13, 9, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '42', 21, 13, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '43', 7, 12, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '44', 38, 12, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '45', 15, 9, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '46', 78, 10, 5, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '47', 83, 9, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '48', 85, 8, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '49', 15, 9, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '50', 45, 8, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '51', 48, 7, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '52', 51, 6, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '53', 54, 5, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '54', 57, 4, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '55', 60, 3, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '56', 65, 6, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '57', 69, 7, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '58', 71, 8, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '59', 22, 6, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '60', 29, 6, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '61', 76, 5, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '62', 81, 4, 7, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '63', 91, 4, 9, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '64', 37, 22, 3, 3, 'black');
INSERT INTO BASES  VALUES ('19980002', '65', 36, 23, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '66', 38, 21, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '67', 40, 23, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '68', 38, 25, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980002', '69', 9, 25, 2, 3, 'brown');
INSERT INTO BASES  VALUES ('19980002', '70', 35, 3, 2, 3, 'brown');
INSERT INTO BASES  VALUES ('19980002', '71', 65, 10, 2, 3, 'brown');
INSERT INTO BASES  VALUES ('19980002', '72', 66, 30, 2, 3, 'brown');
INSERT INTO BASES  VALUES ('19980003', '1', 26, 34, 74, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '2', 0, 33, 26, 2, 'black');
INSERT INTO BASES  VALUES ('19980003', '3', 76, 33, 24, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '4', 37, 33, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '5', 49, 33, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '6', 61, 33, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '7', 27, 31, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '8', 37, 31, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '9', 40, 31, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '10', 52, 31, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '11', 63, 31, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '12', 66, 31, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '13', 49, 30, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '14', 4, 28, 4, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '15', 7, 24, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '16', 10, 21, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '17', 11, 17, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '18', 12, 15, 1, 7, 'black');
INSERT INTO BASES  VALUES ('19980003', '19', 13, 14, 1, 9, 'black');
INSERT INTO BASES  VALUES ('19980003', '20', 14, 12, 2, 21, 'black');
INSERT INTO BASES  VALUES ('19980003', '21', 16, 14, 6, 2, 'black');
INSERT INTO BASES  VALUES ('19980003', '22', 22, 15, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '23', 18, 16, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '24', 22, 16, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '25', 19, 17, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '26', 26, 27, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '27', 39, 27, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '28', 51, 27, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '29', 65, 27, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '30', 88, 26, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '31', 89, 29, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '32', 88, 22, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '33', 64, 23, 10, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '34', 51, 23, 9, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '35', 39, 23, 9, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '36', 26, 23, 9, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '37', 27, 19, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '38', 40, 19, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '39', 52, 19, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '40', 66, 19, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '41', 89, 18, 8, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '42', 90, 15, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '43', 67, 16, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '44', 53, 16, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '45', 41, 16, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '46', 28, 16, 6, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '47', 30, 14, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '48', 43, 14, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '49', 55, 14, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '50', 69, 14, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '51', 92, 13, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '52', 37, 18, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980003', '53', 50, 18, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980003', '54', 63, 18, 1, 2, 'black');
INSERT INTO BASES  VALUES ('19980003', '55', 37, 12, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980003', '56', 50, 12, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980003', '57', 63, 12, 1, 5, 'black');
INSERT INTO BASES  VALUES ('19980003', '58', 60, 11, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '59', 84, 10, 2, 22, 'black');
INSERT INTO BASES  VALUES ('19980003', '60', 86, 12, 1, 9, 'black');
INSERT INTO BASES  VALUES ('19980003', '61', 87, 13, 1, 7, 'black');
INSERT INTO BASES  VALUES ('19980003', '62', 78, 12, 6, 2, 'black');
INSERT INTO BASES  VALUES ('19980003', '63', 76, 13, 2, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '64', 77, 14, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '65', 81, 14, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '66', 78, 15, 3, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '67', 89, 0, 1, 12, 'black');
INSERT INTO BASES  VALUES ('19980003', '68', 99, 0, 1, 35, 'black');
INSERT INTO BASES  VALUES ('19980003', '69', 33, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '70', 39, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '71', 45, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '72', 51, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '73', 57, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '74', 63, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '75', 69, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '76', 75, 8, 1, 1, 'black');
INSERT INTO BASES  VALUES ('19980003', '77', 10, 11, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '78', 19, 28, 1, 2, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '79', 22, 24, 1, 2, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '80', 19, 16, 3, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '81', 78, 14, 3, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '82', 29, 10, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '83', 33, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '84', 39, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '85', 45, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '86', 51, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '87', 57, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '88', 63, 4, 1, 2, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '89', 69, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '90', 75, 4, 1, 2, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '91', 53, 5, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '92', 66, 5, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '93', 83, 2, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '94', 29, 10, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '95', 88, 6, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '96', 30, 32, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '97', 30, 28, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '98', 30, 24, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '99', 30, 20, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '100', 30, 17, 2, 1, 'brown');
INSERT INTO BASES  VALUES ('19980003', '101', 43, 17, 2, 1, 'brown');
INSERT INTO BASES  VALUES ('19980003', '102', 43, 20, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '103', 43, 24, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '104', 43, 28, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '105', 43, 32, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '106', 55, 32, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '107', 55, 28, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '108', 55, 24, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '109', 55, 20, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '110', 55, 17, 2, 1, 'brown');
INSERT INTO BASES  VALUES ('19980003', '111', 69, 17, 2, 1, 'brown');
INSERT INTO BASES  VALUES ('19980003', '112', 69, 20, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '113', 69, 24, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '114', 69, 28, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '115', 69, 32, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '116', 92, 31, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '117', 92, 27, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '118', 92, 23, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '119', 92, 19, 2, 2, 'brown');
INSERT INTO BASES  VALUES ('19980003', '120', 92, 16, 2, 1, 'brown');
INSERT INTO BASES  VALUES ('19980003', '121', 23, 0, 3, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '122', 22, 1, 3, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '123', 22, 2, 1, 4, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '124', 23, 4, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '125', 23, 5, 2, 2, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '126', 25, 6, 3, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '127', 27, 5, 2, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '128', 76, 20, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '129', 81, 19, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '130', 78, 24, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980003', '131', 81, 28, 1, 1, 'yellow');
INSERT INTO BASES  VALUES ('19980009','3',0,33,200,2,'black');
INSERT INTO BASES  VALUES ('19980009','4',47,23,45,10,'black');
INSERT INTO BASES  VALUES ('19980009','8',2,30,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','9',5,28,8,1,'black');
INSERT INTO BASES  VALUES ('19980009','10',15,26,6,1,'black');
INSERT INTO BASES  VALUES ('19980009','11',25,26,6,2,'black');
INSERT INTO BASES  VALUES ('19980009','12',32,25,4,1,'black');
INSERT INTO BASES  VALUES ('19980009','13',37,24,1,1,'black');
INSERT INTO BASES  VALUES ('19980009','14',40,23,6,2,'black');
INSERT INTO BASES  VALUES ('19980009','15',47,21,5,1,'black');
INSERT INTO BASES  VALUES ('19980009','16',53,20,6,2,'black');
INSERT INTO BASES  VALUES ('19980009','17',59,18,7,1,'black');
INSERT INTO BASES  VALUES ('19980009','18',63,17,3,1,'black');
INSERT INTO BASES  VALUES ('19980009','28',93,24,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','29',96,24,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','30',99,25,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','31',102,25,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','32',105,26,3,1,'black');
INSERT INTO BASES  VALUES ('19980009','33',109,27,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','34',112,27,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','35',115,28,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','36',118,28,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','37',121,29,3,1,'black');
INSERT INTO BASES  VALUES ('19980009','38',125,30,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','39',128,30,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','40',131,31,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','41',134,31,2,1,'black');
INSERT INTO BASES  VALUES ('19980009','42',137,32,3,1,'black');

INSERT INTO HURDLES  VALUES ('19980001', '1', 7, 30, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '2', 26, 18, 1, 1, 'red',2);
INSERT INTO HURDLES  VALUES ('19980001', '3', 88, 25, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '4', 91, 26, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '5', 94, 26, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '6', 97, 25, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '7', 110, 31, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '8', 112, 31, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '9', 114, 31, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '10', 111, 33, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '11', 113, 33, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980001', '12', 115, 33, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '1', 19, 32, 2, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '2', 58, 32, 3, 1, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '3', 72, 32, 2, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '4', 78, 32, 2, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '5', 87, 29, 2, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '6', 52, 23, 3, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '7', 20, 20, 5, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '8', 71, 18, 2, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '9', 49, 13, 1, 1, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '10', 9, 11, 2, 1, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '11', 17, 8, 1, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '12', 31, 5, 2, 1, 'red',1);
INSERT INTO HURDLES  VALUES ('19980002', '13', 34, 18, 1, 2, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '14', 38, 18, 1, 2, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '15', 42, 18, 1, 2, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '16', 35, 17, 3, 1, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '17', 39, 17, 3, 1, 'red',2);
INSERT INTO HURDLES  VALUES ('19980002', '18', 14, 33, 2, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '19', 24, 33, 12, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '20', 41, 33, 12, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '21', 27, 31, 1, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '22', 31, 31, 1, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '23', 28, 30, 3, 1, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '24', 45, 31, 1, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '25', 49, 31, 1, 2, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980002', '26', 46, 30, 3, 1, 'blue',2);
INSERT INTO HURDLES  VALUES ('19980003', '1', 29, 15, 4, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '2', 16, 12, 2, 2, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '3', 28, 18, 6, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '4', 27, 26, 8, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '5', 42, 15, 4, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '6', 40, 22, 8, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '7', 41, 30, 6, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '8', 52, 26, 8, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '9', 53, 18, 6, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '10', 68, 15, 4, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '11', 66, 22, 8, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '12', 67, 30, 6, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '13', 82, 10, 2, 2, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '14', 93, 8, 2, 2, '#ff00ea',5);
INSERT INTO HURDLES  VALUES ('19980003', '15', 91, 14, 4, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '16', 90, 17, 6, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '17', 89, 21, 8, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '18', 89, 25, 8, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '19', 90, 26, 6, 1, '#ff00ea',2);
INSERT INTO HURDLES  VALUES ('19980003', '20', 29, 15, 4, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '21', 27, 22, 8, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '22', 28, 30, 6, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '23', 40, 26, 8, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '24', 41, 18, 6, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '25', 54, 15, 4, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '26', 52, 22, 8, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '27', 53, 30, 6, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '28', 66, 26, 8, 1, '#ffa4f8',1);
INSERT INTO HURDLES  VALUES ('19980003', '29', 67, 18, 4, 1, '#ffa4f8',1);
INSERT INTO hurdles VALUES ('19980009', '1', 28, 31, 1, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '2', 28, 25, 1, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '3', 42, 22, 2, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '4', 55, 19, 2, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '5', 68, 21, 1, 2, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '6', 81, 21, 1, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '7', 96, 24, 1, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '8', 106, 25, 1, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '9', 122, 28, 1, 1, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '10', 110, 31, 1, 2, 'red', 1);
INSERT INTO hurdles VALUES ('19980009', '11', 68, 21, 1, 2, 'red', 1);

INSERT INTO records VALUES ('00020001', '19980003', RECORD_SEQ.NEXTVAL, 128287);
INSERT INTO records VALUES ('01140001', '19980009', RECORD_SEQ.NEXTVAL, 47751);
INSERT INTO records VALUES ('00020003', '19980009', RECORD_SEQ.NEXTVAL, 116344);
INSERT INTO records VALUES ('01080001', '19980003', RECORD_SEQ.NEXTVAL, 149241);
INSERT INTO records VALUES ('01150001', '19980002', RECORD_SEQ.NEXTVAL, 123112);
INSERT INTO records VALUES ('02080001', '19980003', RECORD_SEQ.NEXTVAL, 75125);
INSERT INTO records VALUES ('02030001', '19980003', RECORD_SEQ.NEXTVAL, 96891);
INSERT INTO records VALUES ('00120001', '19980009', RECORD_SEQ.NEXTVAL, 122556);
INSERT INTO records VALUES ('00060003', '19980001', RECORD_SEQ.NEXTVAL, 39282);
INSERT INTO records VALUES ('00080002', '19980009', RECORD_SEQ.NEXTVAL, 98862);
INSERT INTO records VALUES ('02060001', '19980001', RECORD_SEQ.NEXTVAL, 106283);
INSERT INTO records VALUES ('99010001', '19980009', RECORD_SEQ.NEXTVAL, 57882);
INSERT INTO records VALUES ('01060001', '19980001', RECORD_SEQ.NEXTVAL, 77636);
INSERT INTO records VALUES ('99020001', '19980002', RECORD_SEQ.NEXTVAL, 60653);
INSERT INTO records VALUES ('00020002', '19980009', RECORD_SEQ.NEXTVAL, 102324);
INSERT INTO records VALUES ('01070001', '19980001', RECORD_SEQ.NEXTVAL, 122258);
INSERT INTO records VALUES ('02070005', '19980001', RECORD_SEQ.NEXTVAL, 83370);
INSERT INTO records VALUES ('99030001', '19980001', RECORD_SEQ.NEXTVAL, 49592);
INSERT INTO records VALUES ('02110002', '19980009', RECORD_SEQ.NEXTVAL, 40949);
INSERT INTO records VALUES ('01010001', '19980001', RECORD_SEQ.NEXTVAL, 117482);
INSERT INTO records VALUES ('02090001', '19980003', RECORD_SEQ.NEXTVAL, 39240);
INSERT INTO records VALUES ('02120003', '19980002', RECORD_SEQ.NEXTVAL, 123086);
INSERT INTO records VALUES ('02070003', '19980009', RECORD_SEQ.NEXTVAL, 146453);
INSERT INTO records VALUES ('02100001', '19980009', RECORD_SEQ.NEXTVAL, 55878);
INSERT INTO records VALUES ('00090001', '19980002', RECORD_SEQ.NEXTVAL, 111916);
INSERT INTO records VALUES ('01050002', '19980001', RECORD_SEQ.NEXTVAL, 108966);
INSERT INTO records VALUES ('01020001', '19980001', RECORD_SEQ.NEXTVAL, 110139);
INSERT INTO records VALUES ('01120001', '19980002', RECORD_SEQ.NEXTVAL, 96530);
INSERT INTO records VALUES ('01010003', '19980003', RECORD_SEQ.NEXTVAL, 109984);
INSERT INTO records VALUES ('01100001', '19980001', RECORD_SEQ.NEXTVAL, 121660);
INSERT INTO records VALUES ('00090002', '19980001', RECORD_SEQ.NEXTVAL, 85623);
INSERT INTO records VALUES ('02040001', '19980009', RECORD_SEQ.NEXTVAL, 109807);
INSERT INTO records VALUES ('02010001', '19980002', RECORD_SEQ.NEXTVAL, 38650);
INSERT INTO records VALUES ('02020001', '19980002', RECORD_SEQ.NEXTVAL, 95655);
INSERT INTO records VALUES ('00150001', '19980003', RECORD_SEQ.NEXTVAL, 67523);
INSERT INTO records VALUES ('00040002', '19980003', RECORD_SEQ.NEXTVAL, 81292);
INSERT INTO records VALUES ('05020001', '19980001', RECORD_SEQ.NEXTVAL, 35405);
INSERT INTO records VALUES ('02050003', '19980002', RECORD_SEQ.NEXTVAL, 47471);
INSERT INTO records VALUES ('02140002', '19980002', RECORD_SEQ.NEXTVAL, 73852);
INSERT INTO records VALUES ('02050002', '19980001', RECORD_SEQ.NEXTVAL, 52694);
INSERT INTO records VALUES ('02050001', '19980009', RECORD_SEQ.NEXTVAL, 38029);
INSERT INTO records VALUES ('00010002', '19980003', RECORD_SEQ.NEXTVAL, 66677);
INSERT INTO records VALUES ('00060004', '19980009', RECORD_SEQ.NEXTVAL, 35838);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 98198);
INSERT INTO records VALUES ('02040002', '19980001', RECORD_SEQ.NEXTVAL, 105403);
INSERT INTO records VALUES ('05010001', '19980002', RECORD_SEQ.NEXTVAL, 92598);
INSERT INTO records VALUES ('00010004', '19980009', RECORD_SEQ.NEXTVAL, 70485);
INSERT INTO records VALUES ('02010002', '19980001', RECORD_SEQ.NEXTVAL, 110075);
INSERT INTO records VALUES ('02110001', '19980009', RECORD_SEQ.NEXTVAL, 84047);
INSERT INTO records VALUES ('00040001', '19980001', RECORD_SEQ.NEXTVAL, 35402);
INSERT INTO records VALUES ('01060002', '19980002', RECORD_SEQ.NEXTVAL, 44730);
INSERT INTO records VALUES ('02120002', '19980002', RECORD_SEQ.NEXTVAL, 30510);
INSERT INTO records VALUES ('01130001', '19980002', RECORD_SEQ.NEXTVAL, 147277);
INSERT INTO records VALUES ('00010003', '19980001', RECORD_SEQ.NEXTVAL, 52788);
INSERT INTO records VALUES ('01040001', '19980001', RECORD_SEQ.NEXTVAL, 66020);
INSERT INTO records VALUES ('00050001', '19980002', RECORD_SEQ.NEXTVAL, 111985);
INSERT INTO records VALUES ('02120001', '19980002', RECORD_SEQ.NEXTVAL, 99060);
INSERT INTO records VALUES ('00070001', '19980001', RECORD_SEQ.NEXTVAL, 112909);
INSERT INTO records VALUES ('02070004', '19980003', RECORD_SEQ.NEXTVAL, 36276);
INSERT INTO records VALUES ('01090002', '19980002', RECORD_SEQ.NEXTVAL, 65645);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 39599);
INSERT INTO records VALUES ('02100002', '19980001', RECORD_SEQ.NEXTVAL, 57953);
INSERT INTO records VALUES ('00010001', '19980009', RECORD_SEQ.NEXTVAL, 58425);
INSERT INTO records VALUES ('00060002', '19980002', RECORD_SEQ.NEXTVAL, 118372);
INSERT INTO records VALUES ('02080003', '19980003', RECORD_SEQ.NEXTVAL, 82394);
INSERT INTO records VALUES ('01010002', '19980002', RECORD_SEQ.NEXTVAL, 108309);
INSERT INTO records VALUES ('00130001', '19980002', RECORD_SEQ.NEXTVAL, 75423);
INSERT INTO records VALUES ('02070001', '19980003', RECORD_SEQ.NEXTVAL, 81268);
INSERT INTO records VALUES ('02050004', '19980009', RECORD_SEQ.NEXTVAL, 148505);
INSERT INTO records VALUES ('02070002', '19980001', RECORD_SEQ.NEXTVAL, 74920);
INSERT INTO records VALUES ('01100002', '19980003', RECORD_SEQ.NEXTVAL, 140097);
INSERT INTO records VALUES ('00140002', '19980002', RECORD_SEQ.NEXTVAL, 112991);
INSERT INTO records VALUES ('00060001', '19980001', RECORD_SEQ.NEXTVAL, 69526);
INSERT INTO records VALUES ('02140001', '19980009', RECORD_SEQ.NEXTVAL, 133893);
INSERT INTO records VALUES ('01040002', '19980003', RECORD_SEQ.NEXTVAL, 34041);
INSERT INTO records VALUES ('00080001', '19980002', RECORD_SEQ.NEXTVAL, 108298);
INSERT INTO records VALUES ('00030001', '19980001', RECORD_SEQ.NEXTVAL, 55161);
INSERT INTO records VALUES ('01030001', '19980009', RECORD_SEQ.NEXTVAL, 135792);
INSERT INTO records VALUES ('01050003', '19980002', RECORD_SEQ.NEXTVAL, 124724);
INSERT INTO records VALUES ('02150001', '19980003', RECORD_SEQ.NEXTVAL, 112609);
INSERT INTO records VALUES ('02110003', '19980001', RECORD_SEQ.NEXTVAL, 114460);
INSERT INTO records VALUES ('00100001', '19980001', RECORD_SEQ.NEXTVAL, 52515);
INSERT INTO records VALUES ('02100003', '19980009', RECORD_SEQ.NEXTVAL, 120309);
INSERT INTO records VALUES ('02080002', '19980009', RECORD_SEQ.NEXTVAL, 72764);
INSERT INTO records VALUES ('00090003', '19980002', RECORD_SEQ.NEXTVAL, 60658);
INSERT INTO records VALUES ('01090001', '19980009', RECORD_SEQ.NEXTVAL, 55043);
INSERT INTO records VALUES ('00050002', '19980003', RECORD_SEQ.NEXTVAL, 115651);
INSERT INTO records VALUES ('02120004', '19980009', RECORD_SEQ.NEXTVAL, 94976);
INSERT INTO records VALUES ('01050001', '19980001', RECORD_SEQ.NEXTVAL, 94231);
INSERT INTO records VALUES ('02070006', '19980001', RECORD_SEQ.NEXTVAL, 82215);
INSERT INTO records VALUES ('00140001', '19980001', RECORD_SEQ.NEXTVAL, 88136);
INSERT INTO records VALUES ('00040003', '19980002', RECORD_SEQ.NEXTVAL, 30614);
INSERT INTO records VALUES ('05020001', '19980003', RECORD_SEQ.NEXTVAL, 146595);
INSERT INTO records VALUES ('00130001', '19980003', RECORD_SEQ.NEXTVAL, 108819);
INSERT INTO records VALUES ('00070001', '19980003', RECORD_SEQ.NEXTVAL, 92064);
INSERT INTO records VALUES ('02110003', '19980009', RECORD_SEQ.NEXTVAL, 140047);
INSERT INTO records VALUES ('00010001', '19980001', RECORD_SEQ.NEXTVAL, 61052);
INSERT INTO records VALUES ('02120001', '19980001', RECORD_SEQ.NEXTVAL, 61628);
INSERT INTO records VALUES ('02110001', '19980002', RECORD_SEQ.NEXTVAL, 35920);
INSERT INTO records VALUES ('00140002', '19980001', RECORD_SEQ.NEXTVAL, 81060);
INSERT INTO records VALUES ('02050004', '19980002', RECORD_SEQ.NEXTVAL, 133502);
INSERT INTO records VALUES ('00020001', '19980003', RECORD_SEQ.NEXTVAL, 136890);
INSERT INTO records VALUES ('01150001', '19980003', RECORD_SEQ.NEXTVAL, 84866);
INSERT INTO records VALUES ('02140001', '19980003', RECORD_SEQ.NEXTVAL, 126126);
INSERT INTO records VALUES ('01030001', '19980003', RECORD_SEQ.NEXTVAL, 108936);
INSERT INTO records VALUES ('00040002', '19980009', RECORD_SEQ.NEXTVAL, 132700);
INSERT INTO records VALUES ('02080003', '19980003', RECORD_SEQ.NEXTVAL, 108815);
INSERT INTO records VALUES ('01060001', '19980009', RECORD_SEQ.NEXTVAL, 42124);
INSERT INTO records VALUES ('01010003', '19980001', RECORD_SEQ.NEXTVAL, 91051);
INSERT INTO records VALUES ('00120001', '19980002', RECORD_SEQ.NEXTVAL, 105263);
INSERT INTO records VALUES ('02070006', '19980002', RECORD_SEQ.NEXTVAL, 76733);
INSERT INTO records VALUES ('00090003', '19980009', RECORD_SEQ.NEXTVAL, 72509);
INSERT INTO records VALUES ('02060001', '19980009', RECORD_SEQ.NEXTVAL, 121653);
INSERT INTO records VALUES ('00150001', '19980003', RECORD_SEQ.NEXTVAL, 39561);
INSERT INTO records VALUES ('02120002', '19980003', RECORD_SEQ.NEXTVAL, 81957);
INSERT INTO records VALUES ('00090002', '19980002', RECORD_SEQ.NEXTVAL, 108167);
INSERT INTO records VALUES ('02070005', '19980009', RECORD_SEQ.NEXTVAL, 138866);
INSERT INTO records VALUES ('01090002', '19980001', RECORD_SEQ.NEXTVAL, 87167);
INSERT INTO records VALUES ('00060001', '19980003', RECORD_SEQ.NEXTVAL, 49303);
INSERT INTO records VALUES ('02100002', '19980001', RECORD_SEQ.NEXTVAL, 101051);
INSERT INTO records VALUES ('02110002', '19980003', RECORD_SEQ.NEXTVAL, 145677);
INSERT INTO records VALUES ('00060002', '19980009', RECORD_SEQ.NEXTVAL, 120289);
INSERT INTO records VALUES ('02120003', '19980001', RECORD_SEQ.NEXTVAL, 83247);
INSERT INTO records VALUES ('00080001', '19980003', RECORD_SEQ.NEXTVAL, 39556);
INSERT INTO records VALUES ('00090001', '19980002', RECORD_SEQ.NEXTVAL, 72858);
INSERT INTO records VALUES ('00010002', '19980002', RECORD_SEQ.NEXTVAL, 37402);
INSERT INTO records VALUES ('01100002', '19980002', RECORD_SEQ.NEXTVAL, 33699);
INSERT INTO records VALUES ('02050003', '19980003', RECORD_SEQ.NEXTVAL, 58677);
INSERT INTO records VALUES ('02050001', '19980002', RECORD_SEQ.NEXTVAL, 135946);
INSERT INTO records VALUES ('02020001', '19980009', RECORD_SEQ.NEXTVAL, 85817);
INSERT INTO records VALUES ('02150001', '19980002', RECORD_SEQ.NEXTVAL, 48027);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 141989);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 38131);
INSERT INTO records VALUES ('01130001', '19980001', RECORD_SEQ.NEXTVAL, 54286);
INSERT INTO records VALUES ('01070001', '19980003', RECORD_SEQ.NEXTVAL, 70949);
INSERT INTO records VALUES ('02040001', '19980001', RECORD_SEQ.NEXTVAL, 111341);
INSERT INTO records VALUES ('00080002', '19980003', RECORD_SEQ.NEXTVAL, 60629);
INSERT INTO records VALUES ('02090001', '19980001', RECORD_SEQ.NEXTVAL, 119559);
INSERT INTO records VALUES ('02070001', '19980009', RECORD_SEQ.NEXTVAL, 103846);
INSERT INTO records VALUES ('01040001', '19980001', RECORD_SEQ.NEXTVAL, 79633);
INSERT INTO records VALUES ('00120001', '19980001', RECORD_SEQ.NEXTVAL, 123720);
INSERT INTO records VALUES ('00010004', '19980002', RECORD_SEQ.NEXTVAL, 82159);
INSERT INTO records VALUES ('01050001', '19980009', RECORD_SEQ.NEXTVAL, 111447);
INSERT INTO records VALUES ('01030001', '19980009', RECORD_SEQ.NEXTVAL, 77164);
INSERT INTO records VALUES ('01010001', '19980009', RECORD_SEQ.NEXTVAL, 50911);
INSERT INTO records VALUES ('02110003', '19980002', RECORD_SEQ.NEXTVAL, 106486);
INSERT INTO records VALUES ('00090001', '19980009', RECORD_SEQ.NEXTVAL, 79721);
INSERT INTO records VALUES ('02010002', '19980003', RECORD_SEQ.NEXTVAL, 35400);
INSERT INTO records VALUES ('01010002', '19980001', RECORD_SEQ.NEXTVAL, 33192);
INSERT INTO records VALUES ('00090002', '19980002', RECORD_SEQ.NEXTVAL, 138900);
INSERT INTO records VALUES ('05010001', '19980009', RECORD_SEQ.NEXTVAL, 76178);
INSERT INTO records VALUES ('01050002', '19980001', RECORD_SEQ.NEXTVAL, 33994);
INSERT INTO records VALUES ('01100002', '19980009', RECORD_SEQ.NEXTVAL, 51187);
INSERT INTO records VALUES ('02070002', '19980001', RECORD_SEQ.NEXTVAL, 93891);
INSERT INTO records VALUES ('00030001', '19980009', RECORD_SEQ.NEXTVAL, 47419);
INSERT INTO records VALUES ('01100001', '19980003', RECORD_SEQ.NEXTVAL, 129963);
INSERT INTO records VALUES ('02020001', '19980003', RECORD_SEQ.NEXTVAL, 50277);
INSERT INTO records VALUES ('01010003', '19980009', RECORD_SEQ.NEXTVAL, 142174);
INSERT INTO records VALUES ('02120004', '19980002', RECORD_SEQ.NEXTVAL, 133011);
INSERT INTO records VALUES ('01020001', '19980009', RECORD_SEQ.NEXTVAL, 76395);
INSERT INTO records VALUES ('00130001', '19980003', RECORD_SEQ.NEXTVAL, 116293);
INSERT INTO records VALUES ('00060004', '19980001', RECORD_SEQ.NEXTVAL, 91163);
INSERT INTO records VALUES ('00100001', '19980002', RECORD_SEQ.NEXTVAL, 120774);
INSERT INTO records VALUES ('05020001', '19980003', RECORD_SEQ.NEXTVAL, 43878);
INSERT INTO records VALUES ('02050004', '19980002', RECORD_SEQ.NEXTVAL, 136447);
INSERT INTO records VALUES ('00150001', '19980001', RECORD_SEQ.NEXTVAL, 125641);
INSERT INTO records VALUES ('02150001', '19980001', RECORD_SEQ.NEXTVAL, 120394);
INSERT INTO records VALUES ('01050003', '19980009', RECORD_SEQ.NEXTVAL, 108380);
INSERT INTO records VALUES ('02100002', '19980002', RECORD_SEQ.NEXTVAL, 99523);
INSERT INTO records VALUES ('01080001', '19980001', RECORD_SEQ.NEXTVAL, 98805);
INSERT INTO records VALUES ('02140001', '19980001', RECORD_SEQ.NEXTVAL, 78387);
INSERT INTO records VALUES ('00050002', '19980002', RECORD_SEQ.NEXTVAL, 47911);
INSERT INTO records VALUES ('02040002', '19980002', RECORD_SEQ.NEXTVAL, 111818);
INSERT INTO records VALUES ('00050001', '19980002', RECORD_SEQ.NEXTVAL, 96529);
INSERT INTO records VALUES ('00040002', '19980001', RECORD_SEQ.NEXTVAL, 121156);
INSERT INTO records VALUES ('01040002', '19980001', RECORD_SEQ.NEXTVAL, 80095);
INSERT INTO records VALUES ('00060002', '19980002', RECORD_SEQ.NEXTVAL, 66214);
INSERT INTO records VALUES ('01090002', '19980002', RECORD_SEQ.NEXTVAL, 91477);
INSERT INTO records VALUES ('01150001', '19980003', RECORD_SEQ.NEXTVAL, 57547);
INSERT INTO records VALUES ('02070003', '19980001', RECORD_SEQ.NEXTVAL, 114669);
INSERT INTO records VALUES ('02050001', '19980003', RECORD_SEQ.NEXTVAL, 65398);
INSERT INTO records VALUES ('02120003', '19980003', RECORD_SEQ.NEXTVAL, 54598);
INSERT INTO records VALUES ('02030001', '19980003', RECORD_SEQ.NEXTVAL, 146928);
INSERT INTO records VALUES ('99020001', '19980009', RECORD_SEQ.NEXTVAL, 134627);
INSERT INTO records VALUES ('00140002', '19980003', RECORD_SEQ.NEXTVAL, 79138);
INSERT INTO records VALUES ('00020001', '19980003', RECORD_SEQ.NEXTVAL, 140025);
INSERT INTO records VALUES ('00080001', '19980002', RECORD_SEQ.NEXTVAL, 67620);
INSERT INTO records VALUES ('00010002', '19980002', RECORD_SEQ.NEXTVAL, 112639);
INSERT INTO records VALUES ('02070004', '19980001', RECORD_SEQ.NEXTVAL, 80837);
INSERT INTO records VALUES ('00010002', '19980003', RECORD_SEQ.NEXTVAL, 31742);
INSERT INTO records VALUES ('00060003', '19980001', RECORD_SEQ.NEXTVAL, 79567);
INSERT INTO records VALUES ('02120002', '19980003', RECORD_SEQ.NEXTVAL, 72833);
INSERT INTO records VALUES ('02080002', '19980001', RECORD_SEQ.NEXTVAL, 62440);
INSERT INTO records VALUES ('00020002', '19980002', RECORD_SEQ.NEXTVAL, 42279);
INSERT INTO records VALUES ('02010001', '19980009', RECORD_SEQ.NEXTVAL, 67686);
INSERT INTO records VALUES ('01070001', '19980002', RECORD_SEQ.NEXTVAL, 120181);
INSERT INTO records VALUES ('01140001', '19980003', RECORD_SEQ.NEXTVAL, 124463);
INSERT INTO records VALUES ('00070001', '19980002', RECORD_SEQ.NEXTVAL, 125130);
INSERT INTO records VALUES ('02050002', '19980003', RECORD_SEQ.NEXTVAL, 110471);
INSERT INTO records VALUES ('02120001', '19980002', RECORD_SEQ.NEXTVAL, 128465);
INSERT INTO records VALUES ('02060001', '19980009', RECORD_SEQ.NEXTVAL, 42191);
INSERT INTO records VALUES ('02050003', '19980001', RECORD_SEQ.NEXTVAL, 71753);
INSERT INTO records VALUES ('00010003', '19980009', RECORD_SEQ.NEXTVAL, 91402);
INSERT INTO records VALUES ('02070006', '19980001', RECORD_SEQ.NEXTVAL, 42318);
INSERT INTO records VALUES ('00020003', '19980002', RECORD_SEQ.NEXTVAL, 80512);
INSERT INTO records VALUES ('00040001', '19980001', RECORD_SEQ.NEXTVAL, 108599);
INSERT INTO records VALUES ('02100001', '19980001', RECORD_SEQ.NEXTVAL, 125736);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 124991);
INSERT INTO records VALUES ('00010001', '19980002', RECORD_SEQ.NEXTVAL, 42273);
INSERT INTO records VALUES ('01130001', '19980003', RECORD_SEQ.NEXTVAL, 110432);
INSERT INTO records VALUES ('01090001', '19980002', RECORD_SEQ.NEXTVAL, 42060);
INSERT INTO records VALUES ('02110001', '19980002', RECORD_SEQ.NEXTVAL, 126858);
INSERT INTO records VALUES ('02140002', '19980001', RECORD_SEQ.NEXTVAL, 88498);
INSERT INTO records VALUES ('00040002', '19980009', RECORD_SEQ.NEXTVAL, 148265);
INSERT INTO records VALUES ('02010002', '19980003', RECORD_SEQ.NEXTVAL, 119644);
INSERT INTO records VALUES ('05010001', '19980003', RECORD_SEQ.NEXTVAL, 54911);
INSERT INTO records VALUES ('01140001', '19980009', RECORD_SEQ.NEXTVAL, 43743);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 117767);
INSERT INTO records VALUES ('01070001', '19980002', RECORD_SEQ.NEXTVAL, 91361);
INSERT INTO records VALUES ('02050004', '19980003', RECORD_SEQ.NEXTVAL, 75482);
INSERT INTO records VALUES ('99020001', '19980001', RECORD_SEQ.NEXTVAL, 111142);
INSERT INTO records VALUES ('01050003', '19980009', RECORD_SEQ.NEXTVAL, 97739);
INSERT INTO records VALUES ('02010001', '19980009', RECORD_SEQ.NEXTVAL, 86384);
INSERT INTO records VALUES ('01100001', '19980009', RECORD_SEQ.NEXTVAL, 97453);
INSERT INTO records VALUES ('02100001', '19980009', RECORD_SEQ.NEXTVAL, 126226);
INSERT INTO records VALUES ('00090002', '19980009', RECORD_SEQ.NEXTVAL, 138029);
INSERT INTO records VALUES ('01040002', '19980001', RECORD_SEQ.NEXTVAL, 88291);
INSERT INTO records VALUES ('00130001', '19980002', RECORD_SEQ.NEXTVAL, 81977);
INSERT INTO records VALUES ('00030001', '19980009', RECORD_SEQ.NEXTVAL, 77479);
INSERT INTO records VALUES ('02110002', '19980003', RECORD_SEQ.NEXTVAL, 120869);
INSERT INTO records VALUES ('01020001', '19980003', RECORD_SEQ.NEXTVAL, 60098);
INSERT INTO records VALUES ('02070001', '19980003', RECORD_SEQ.NEXTVAL, 39936);
INSERT INTO records VALUES ('01060002', '19980009', RECORD_SEQ.NEXTVAL, 61410);
INSERT INTO records VALUES ('02050002', '19980003', RECORD_SEQ.NEXTVAL, 37090);
INSERT INTO records VALUES ('02100002', '19980001', RECORD_SEQ.NEXTVAL, 33615);
INSERT INTO records VALUES ('00140001', '19980003', RECORD_SEQ.NEXTVAL, 120215);
INSERT INTO records VALUES ('02080003', '19980009', RECORD_SEQ.NEXTVAL, 32714);
INSERT INTO records VALUES ('02120001', '19980002', RECORD_SEQ.NEXTVAL, 142004);
INSERT INTO records VALUES ('00060003', '19980003', RECORD_SEQ.NEXTVAL, 43622);
INSERT INTO records VALUES ('00010001', '19980002', RECORD_SEQ.NEXTVAL, 71732);
INSERT INTO records VALUES ('02140002', '19980003', RECORD_SEQ.NEXTVAL, 78933);
INSERT INTO records VALUES ('00040001', '19980001', RECORD_SEQ.NEXTVAL, 30589);
INSERT INTO records VALUES ('00140002', '19980001', RECORD_SEQ.NEXTVAL, 121559);
INSERT INTO records VALUES ('02110001', '19980001', RECORD_SEQ.NEXTVAL, 104205);
INSERT INTO records VALUES ('00090003', '19980009', RECORD_SEQ.NEXTVAL, 115904);
INSERT INTO records VALUES ('02140001', '19980002', RECORD_SEQ.NEXTVAL, 133808);
INSERT INTO records VALUES ('02140002', '19980001', RECORD_SEQ.NEXTVAL, 139813);
INSERT INTO records VALUES ('00070001', '19980002', RECORD_SEQ.NEXTVAL, 63813);
INSERT INTO records VALUES ('00080001', '19980002', RECORD_SEQ.NEXTVAL, 132138);
INSERT INTO records VALUES ('00140002', '19980001', RECORD_SEQ.NEXTVAL, 69209);
INSERT INTO records VALUES ('99010001', '19980009', RECORD_SEQ.NEXTVAL, 38098);
INSERT INTO records VALUES ('02070003', '19980001', RECORD_SEQ.NEXTVAL, 137250);
INSERT INTO records VALUES ('00010002', '19980001', RECORD_SEQ.NEXTVAL, 59334);
INSERT INTO records VALUES ('01090001', '19980001', RECORD_SEQ.NEXTVAL, 74616);
INSERT INTO records VALUES ('02070001', '19980001', RECORD_SEQ.NEXTVAL, 130655);
INSERT INTO records VALUES ('01010001', '19980009', RECORD_SEQ.NEXTVAL, 82541);
INSERT INTO records VALUES ('01010002', '19980002', RECORD_SEQ.NEXTVAL, 35414);
INSERT INTO records VALUES ('02120003', '19980001', RECORD_SEQ.NEXTVAL, 58262);
INSERT INTO records VALUES ('01050003', '19980003', RECORD_SEQ.NEXTVAL, 87197);
INSERT INTO records VALUES ('00040003', '19980003', RECORD_SEQ.NEXTVAL, 149961);
INSERT INTO records VALUES ('02040002', '19980009', RECORD_SEQ.NEXTVAL, 78025);
INSERT INTO records VALUES ('02070005', '19980002', RECORD_SEQ.NEXTVAL, 80435);
INSERT INTO records VALUES ('01070001', '19980002', RECORD_SEQ.NEXTVAL, 140921);
INSERT INTO records VALUES ('00010002', '19980002', RECORD_SEQ.NEXTVAL, 122286);
INSERT INTO records VALUES ('01140001', '19980003', RECORD_SEQ.NEXTVAL, 126627);
INSERT INTO records VALUES ('01060002', '19980001', RECORD_SEQ.NEXTVAL, 139649);
INSERT INTO records VALUES ('02100003', '19980001', RECORD_SEQ.NEXTVAL, 71730);
INSERT INTO records VALUES ('00060004', '19980002', RECORD_SEQ.NEXTVAL, 42712);
INSERT INTO records VALUES ('01030001', '19980001', RECORD_SEQ.NEXTVAL, 42327);
INSERT INTO records VALUES ('00040001', '19980009', RECORD_SEQ.NEXTVAL, 118024);
INSERT INTO records VALUES ('02150001', '19980009', RECORD_SEQ.NEXTVAL, 67881);
INSERT INTO records VALUES ('05020001', '19980009', RECORD_SEQ.NEXTVAL, 121950);
INSERT INTO records VALUES ('00040002', '19980003', RECORD_SEQ.NEXTVAL, 97862);
INSERT INTO records VALUES ('01130001', '19980003', RECORD_SEQ.NEXTVAL, 40736);
INSERT INTO records VALUES ('01040001', '19980001', RECORD_SEQ.NEXTVAL, 131989);
INSERT INTO records VALUES ('00090002', '19980002', RECORD_SEQ.NEXTVAL, 121672);
INSERT INTO records VALUES ('02080002', '19980002', RECORD_SEQ.NEXTVAL, 93784);
INSERT INTO records VALUES ('02020001', '19980002', RECORD_SEQ.NEXTVAL, 45850);
INSERT INTO records VALUES ('02050002', '19980001', RECORD_SEQ.NEXTVAL, 118068);
INSERT INTO records VALUES ('02120002', '19980009', RECORD_SEQ.NEXTVAL, 147019);
INSERT INTO records VALUES ('00150001', '19980003', RECORD_SEQ.NEXTVAL, 57282);
INSERT INTO records VALUES ('00090003', '19980009', RECORD_SEQ.NEXTVAL, 48322);
INSERT INTO records VALUES ('01050001', '19980003', RECORD_SEQ.NEXTVAL, 133711);
INSERT INTO records VALUES ('00010004', '19980009', RECORD_SEQ.NEXTVAL, 40479);
INSERT INTO records VALUES ('02110002', '19980003', RECORD_SEQ.NEXTVAL, 43947);
INSERT INTO records VALUES ('00060001', '19980009', RECORD_SEQ.NEXTVAL, 63147);
INSERT INTO records VALUES ('02040001', '19980003', RECORD_SEQ.NEXTVAL, 106850);
INSERT INTO records VALUES ('00080002', '19980001', RECORD_SEQ.NEXTVAL, 63724);
INSERT INTO records VALUES ('99020001', '19980009', RECORD_SEQ.NEXTVAL, 140463);
INSERT INTO records VALUES ('99030001', '19980003', RECORD_SEQ.NEXTVAL, 144919);
INSERT INTO records VALUES ('02100002', '19980009', RECORD_SEQ.NEXTVAL, 125438);
INSERT INTO records VALUES ('00020002', '19980002', RECORD_SEQ.NEXTVAL, 81775);
INSERT INTO records VALUES ('00020003', '19980009', RECORD_SEQ.NEXTVAL, 93295);
INSERT INTO records VALUES ('02060001', '19980003', RECORD_SEQ.NEXTVAL, 78646);
INSERT INTO records VALUES ('01150001', '19980009', RECORD_SEQ.NEXTVAL, 32810);
INSERT INTO records VALUES ('01020001', '19980001', RECORD_SEQ.NEXTVAL, 62695);
INSERT INTO records VALUES ('00060003', '19980009', RECORD_SEQ.NEXTVAL, 133258);
INSERT INTO records VALUES ('02010002', '19980009', RECORD_SEQ.NEXTVAL, 80489);
INSERT INTO records VALUES ('02110001', '19980001', RECORD_SEQ.NEXTVAL, 140965);
INSERT INTO records VALUES ('00090001', '19980001', RECORD_SEQ.NEXTVAL, 90282);

commit;