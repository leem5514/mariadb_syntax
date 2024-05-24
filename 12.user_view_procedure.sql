-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- '%'는 원격 포함 anywhere 접속
create user 'test1'@'localhost' identified by '4321';

-- 사용자에게 select 권한 부여
grant select on board.author to 'test1'@'localhost';

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';


-- 환경설정을 변경 후 확정
flush privileges;

-- test1으로 로그인 후에
select * from board.author;

-- 권한 조회
show grants for 'test1'@'localhost';

-- 사용자 계정 삭제
drop user 'test1'@'localhost';

-- view
-- view 생성
create view author_for_marketing_team as
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- view 권한 부여
grant select on board.author_for_marketing_team TO 'test1'@'localhost';

-- view 변경(대체)
create or replace view author_for_marketing_team as select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;

-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN 
    select 'hello world';
END
// DELIMITER ;

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
DROP procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN 
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

-- 게시글 1건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255))
BEGIN 
    select * from post where author_id = 저자id and title = 제목;
END
// DELIMITER ;

call 게시글단건조회(저자id,title);

-- 글쓰기 : title, contents, author_id
DELIMITER //
CREATE PROCEDURE 글쓰기(in authorId int, in contentsInput varchar(3000), in titleInput varchar(255))
BEGIN 
    insert into post(author_id, contents, title) values (authorId , contentsInput , titleInput);
END
// DELIMITER ;

call 게시글단건조회(,,)

-- 글쓰기 : title, contents, email
DELIMITER //
CREATE PROCEDURE 글쓰기2(in titleInput varchar(255), in contentsInput varchar(3000), in emailInput varchar(255))
BEGIN
    declare authorId int;           -- 변수 선언
    select id into authorId from author where email = emailInput;   -- select 구문에서 into 변수를 넣어서 실행
    insert into post(title, contents, author_id) values (titleInput , contentsInput , authorId);
END
// DELIMITER ;

-- sql에서 문자열 합치기 concat('hello', 'world');
-- 글 상세조회 : input 값이 postId
-- title, contents, '홍길동' + '님'
DELIMITER //
CREATE PROCEDURE 글상세조회(in postId int)
BEGIN
    declare authorName varchar(255);
    
    select name into authorName from author where id = (select author_id from post where id = postId);
    set authorName = concat(authorName, '님');
    select title, contents, authorName from post where id = postId;
END
// DELIMITER ;


-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개 이상 100개 미만이면 중수입니다.
-- 그 외는 초보입니다.
-- input 값 : email
DELIMITER //
CREATE PROCEDURE 등급조회(in emailInput varchar(255))
BEGIN
    declare authorId varchar(255);
    declare count int;
    select id into authorId from author where email=emailInput;
    select count(*) into count from post where author_id = authorId;
    IF count >= 100 THEN select '고수입니다';
    ELSEIF count >=10 && count < 100 THEN select '중수입니다';
    ELSE select'초보입니다';
    END IF;
END 
// DELIMITER ;


-- 반복을 통해 post 대량 생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요'
DELIMITER //
CREATE PROCEDURE 글도배(in count int)
BEGIN
    DECLARE countValue INT DEFAULT 1;
    -- set countValue = 0;
    WHILE countValue < count DO;
    insert into post(title) values('hello')
        set countValue = countValue+1;
    END WHILE;
END
// DELIMITER ;

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant execute on board.글도배 to 'test1'@'localhost';




