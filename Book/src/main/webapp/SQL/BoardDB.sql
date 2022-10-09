# 날짜 : 2022/10/09
# 이름 : 서정현
# 내용 : JSP 웹 프로그래밍_제5장 데이터베이스

# DB 생성
create database `BoardDB`;

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
