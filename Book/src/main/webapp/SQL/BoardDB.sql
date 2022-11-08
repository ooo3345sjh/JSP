# 날짜 : 2022/10/09
# 이름 : 서정현
# 내용 : JSP 웹 프로그래밍_제5장 데이터베이스

# DB 생성
create database `BoaboarddbrdDB`;

# DB 접근 가능 아이디 생성
create user 'board_tester'@'%' identified by '1234';
grant all privileges on `boarddb`.* to 'board_tester'@'%';

flush privileges;

# Member 테이블 생성
create table `Member`(
	`id` varchar(10) primary key,
    `pass` varchar(10) not null,
    `name` varchar(30) not null,
    `regidate` datetime not null default current_timestamp
);

# Board 테이블 생성
create table `Board`(
	`num` int primary key auto_increment,
    `title` varchar(200) not null,
    `content` varchar(2000) not null,
    `id` varchar(10) not null,
    `postdate` datetime not null default current_timestamp,
    `visitcount` tinyint,
    foreign key(`id`) references `Member`(`id`)
);

insert into `member`(`id`, `pass`, `name`) values ('musthave', '1234', '머스트해브');
insert into `board` (`title`, `content`, `id`, `postdate`, `visitcount`) values ('제목1입니다', '내용1입니다', 'musthave',now(), 0);

insert into `board` (`title`, `content`, `id`, `postdate`, `visitcount`) values ('지금은 봄입니다', '봄의왈츠', 'musthave',now(), 0);
insert into `board` (`title`, `content`, `id`, `postdate`, `visitcount`) values ('지금은 여름입니다', '여름향기', 'musthave',now(), 0);
insert into `board` (`title`, `content`, `id`, `postdate`, `visitcount`) values ('지금은 가을입니다', '가을동화', 'musthave',now(), 0);
insert into `board` (`title`, `content`, `id`, `postdate`, `visitcount`) values ('지금은 겨울입니다', '겨울연가', 'musthave',now(), 0);
insert into `board` (`title`, `content`, `id`, `postdate`, `visitcount`) VALUES ('지금은 10월입니다', '10월', 'musthave',now(), 0);
ALTER TABLE `board` AUTO_INCREMENT=1;

SELECT B.*, M.name
FROM `member` M
JOIN `board` B 
ON M.id = B.id
WHERE B.num=9;

insert into `board_article` (`title`, `content`, `uid`, `regip`, `rdate`) SELECT `title`, `content`, `uid`, `regip`, `rdate` FROM `board_article` ;



# myfile 테이블 생성
create table `myfile`(
	`idx` int primary key auto_increment,
   `name` VARCHAR(50) NOT null,
   `title` VARCHAR(200) NOT null,
   `cate` VARCHAR(30),
   `ofile` VARCHAR(100) NOT null,
   `sfile` VARCHAR(30) NOT null,
   `postdate` DATETIME default current_timestamp
);

# mvcboard 테이블 생성
create table `mvcboard`(
	`idx` int primary key auto_increment,
   `name` VARCHAR(50) NOT NULL,
   `title` VARCHAR(200) NOT NULL,
   `content` TEXT NOT NULL,
   `postdate` DATETIME default CURRENT_TIMESTAMP,
   `ofile` VARCHAR(200),
   `sfile` VARCHAR(30),
   `downcount` INT DEFAULT 0 NOT NULL,
   `pass` VARCHAR(50) NOT NULL,
   `visitcount` INT DEFAULT 0 NOT NULL 
);



insert into `mvcboard` SET 
				`name`='장보고',
				`title`='자료실 제목2 입니다.',
				`content`='내용',
				`pass`='1234';
insert into `mvcboard` SET 
				`name`='이순신',
				`title`='자료실 제목3 입니다.',
				`content`='내용',
				`pass`='1234';	
insert into `mvcboard` SET 
				`name`='강감찬',
				`title`='자료실 제목4 입니다.',
				`content`='내용',
				`pass`='1234';
insert into `mvcboard` SET 
				`name`='대조영',
				`title`='자료실 제목5 입니다.',
				`content`='내용',
				`pass`='1234';	
				
INSERT INTO `mvcboard` (`name`, `title`, `content`, `pass`) SELECT `name`, `title`, `content`, `pass`FROM `mvcboard`;		


SELECT b.* FROM 
(SELECT *, ROW_NUMBER() OVER(ORDER BY idx desc) rnum FROM `mvcboard`) b
WHERE rnum BETWEEN 1 AND 10; 

SELECT b.* FROM 
(SELECT *, ROW_NUMBER() OVER(ORDER BY idx desc) rnum FROM `mvcboard`) b
LIMIT 10, 10;

DELETE FROM `mvcboard` WHERE idx > 500;
 
