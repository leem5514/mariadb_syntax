-- dirty read 실습
-- 워크벤치에서 auto_commit 해제후 update 실행 -> commit x 상태
-- 터미널을 열어 select 했을 때 변경사항이 변경 되었는지 확인

-- phantom red 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 2번의 select가 이루어지고, 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 같은지 확인
START TRANSACTION
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 아래 insert 문 실행
insert into author(name, email) values('kim','kim@naver.com')

-- lost update 이슈를 해결하기 위한 공유 락(shared lock)
-- 워크벤치에서 아래 코드 실행
start transaction;
select post_count from author where id = 10 lock in share mode;
do sleep(15);
select post_count from author where id = 10 lock in share mode;
commit;
-- 터미널 환경에서 실행
select post_count from author where id = 10 lock in share mode;
update author set post_count=0 where id = 10;



-- 베타적 잠금 (exclusive lock) : select for update
-- select 부터 lock
start transaction;
select post_count from author where id = 10 for update;
do sleep(15);
select post_count from author where id = 10 for update;
commit;
-- 터미널 환경에서 실행
select post_count from author where id = 10 for update;
update author set post_count=0 where id = 10;


