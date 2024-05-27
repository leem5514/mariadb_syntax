# redis 설치
sudo apt-get install redis-server
# 버전확인
redis-server --version

# redis 접속
# cli : commandline interface
redis-cli
# redis 종료
exit -> 탈출!

# redis 0~15번까지의 database 구성
# 데이터베이스 번택
select 번호(0번디폴트)

# 데이터베이스 내 모든 키 조회
keys *

# 일반 string 자료구조
# key:value 값 세팅
# 키 값은 중복되면 안됨
SET key(키값) value(값)
SET test_key1 test_value1
SET user:email:1 honggildong@naver.com
# SET 할 떄 키 값이 이미 존재하면 덮어쓰기 되는것이 기본
# 맵 저장소에서 KEY값은 유일하게 관리가 되므로
# nx : Not Exist
SET user:email:1 honggildong2@naver.com nx
# ex(만료시간-초단위) - ttl(time to live)
SET user:email:2 hong2@naver.com ex 20


# get을 통해 value겂 얻기
get test_key1

# 특정 key 삭제
del user:email:1

# 현재 데이터베이스 모든 key 값 삭제
flushdb 

# 좋아요 기능 구현
rdb -> 동시성이슈 -> lock 걸기 -> 성능하락
# 싱글스레드 && 인메모리기반(성능)

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 #특정 key 값의 value을 1만큼 증가

decr likes:posting:1 #특정 key 값의 value을 1만큼 감소
get likes:posting:1

# 재고 기능 구현
set product:1:stock 100 
decr product:1:stock
get product:1:stock
# bash쉘을 활용하여 재고감소 프로그램 작성

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

# list
# redis의 list는 java의 deque와 같은 구조 즉, double-ended queue구조

# 데이터 왼쪽 삽입
LPUSH [key] [value1]
# 데이터 오른쪽 삽입
RPUSH [key] [value2]
# 데이터 왼쪽부터 꺼내기
LPOP [key]
# 데이터 오른쪽부터 꺼내기
RPOP [key]

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3
lpop hongildongs        # 꺼내서 아에 없애버림

# 꺼내서 없애는게 아니라,  보기만
lrange hongildongs -1 -1
lrange hongildongs 0 0

# 데이터 개수 조회
llen key
llen hongildongs
# list의 요소 조회시에는 범위지정
lrange hongildongs 0 -1   # 처음부터 끝까지
lrange hongildongs start end    # start 부터 end까지 
# TTL 적용
expire hongildongs 30
# TTL 조회
ttl hongildongs

# pop과 push을 동시
RPOPLPUSH A리스트 B리스트

# 최근 방문한 페이지
# 5개 정도 데이터 PUSH
# 최근 방문한 페이지 3개 정도만 보여주는
rpush mypages page1
rpush mypages page2
rpush mypages page3
rpush mypages page4
rpush mypages page5
lrange mypages 2 -1

# 위 방문 페이지 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지 출력
# 다시 앞으로가기 누르면 앞으로간 페이지 출력
rpush forwards page1
rpush forwards page2
rpush forwards page3
rpush forwards page4
lrange mypages -1 -1
rpoplpush forwards backwards


# set 자료구조
# set 자료구조에 맴버추가
sadd members member1
sadd members member2
sadd members membee1

# set 조회
smembers members

# set에서 맴버 삭제
srem members member2
# set 맴버 개수 반환
scard members
# 특정 맴버가 set 안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 user1
sadd visit:2024-05-27 user2
sadd visit:2024-05-27 user3
sadd visit:2024-05-27 user4

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4
# score 기준 오름차순 정렬
zrange zmembers 0 -1
# score 기준 내림차순 정렬
zrevrange zmembers 0 -1
# zset 삭제
zrem zmemberes member2
# 해당 맴버가 몇번재 값인지 제시
zrank zmembers member2

# 어떤 목적으로 사용될 수 있을까용?
# 최근 본 상품목록 => sorted set(zset) 을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192425 apple
zadd recent:products 192430 banana
zrevrange recent:products 0 3

# hashes 
# 해당 자료구조에서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hget product:1 price
# 모든 객체값 get
hgetall product:1
# 특정 요소값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가 / 감소
hincrby broduct:1 stock -5
hget product:1 stock

