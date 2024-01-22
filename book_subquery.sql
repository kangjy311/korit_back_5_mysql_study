# 서브쿼리

select 		#from 서브쿼리
	at.num,
    at.author_name
from
	(select 
		row_number() over(order by author_id desc) as num,
		author_id,
        author_name
	from 
		author_tb
	where
		author_name like '글%') at
where
	at.num > 10;


select		# publisher_name 총 갯수 옆에 출력1 (select 서브쿼리)호출: 컬럼 한 줄 마다 select 호출
	*,
    (select
		count(*)
	from
		publisher_tb) as total_count
from
	publisher_tb;
    
select		# publisher_tb  count 갯수
		count(*)
	from
		publisher_tb;

select		# publisher_name 총 갯수 옆에 출력2 (from 서브쿼리)조건식: select 두번만 호출. -> 이 방법을 써야 된다
	*
from
	publisher_tb pt
	left outer join (select count(*) as total_count from publisher_tb) pt2 on(1 = 1);
	
# 더 빠른 속도로 골라 쓰면 됨
select		# 데이터 수가 적을 때는 더 빠름
	*
from
	book_tb
where
	publisher_id in (select publisher_id from publisher_tb where publisher_name like '아%');
    
select		# join 테이블 다 비교 한후 where
	*
from
	book_tb bt
    left outer join publisher_tb pt on(pt.publisher_id = bt.publisher_id)
where
	pt.publisher_name like '아%';
    
select @@profiling;
show profiles;
set profiling = 1;

    