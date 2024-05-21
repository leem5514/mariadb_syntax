-- 흐름제어 : case문,
SELECT 컬럼1 ,컬럼2, 컬럼3
CASE 컬럼4
    WHEN [비교값1] THEN 결과값1
    WHEN [비교값2] THEN 결과값2
    ELSE [결과값3]
END
FROM 테이블명;

-- POST 테이블에서 1번 user은 first author, 2번 user은 second author
SELECT id, title, contents,
    CASE author_id
        WHEN 1 THEN 'first author'
        WHEN 2 THEN 'second author'
        ELSE 'others'
    END
FROM post;

-- (실습) author_id가 있으면 그대로 출력, else author_id가 없으면 '익명사용자'로 출력되도록 post table 조회
SELECT id, title, contents,
    CASE author_id
        WHEN author_id is null THEN  '익명사용자'
        ELSE author_id
    END as author_id
FROM post;

-- 위 CASE 문을 IFNULL 구문으로 변환
select id, title, contents, 
    IFNULL(author_id ,'익명사용자')
FROM post;

-- IF문 구문으로 변환
select id, title, contents, 
    IF(author_id IS NULL '익명사용자', author_id)
FROM post;

-- 조건에 부합하는 중고거래 상태 조회

-- 12세 이하인 여자 환자 목록 출력
SELECT PT_NAME,	PT_NO, GEND_CD,	AGE	TLNO,
    IFNULL(TLNO , 'NONE')
FROM PATIENT WHERE PATIENT.AGE <= 12 && GEND_CD = 'W' ORDER BY AGE DESC, PT_NAME ASC;



