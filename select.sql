select * from student_tb;
# *의 의미는 전체 컬럼

select 
	student_id, 
    name,
    age
from 
	student_tb 
where 
	not name = '김준일'
    and name = '김준이';

select
	*
from
	student_tb
where
	name in ('김준일', '김준이');
    
select
	*
from
	student_tb
where
	student_id in (1, 2, 3);
    
truncate table student_tb;

/*
	10명의 학생 정보 추가
    김도균 27 부산 금정구
    김도훈 25 부산 부산진구
    김범수 33 부산 금정구
    김상현 26 부산 남구 
    이재영 26 부산 서구
    이정찬 29 부산 부산진구
    이지언 26 부산 동래구
    이편원 30 경남남도 양산시
	전주환 30 부산 부산진구
    심재원 29 부산 남구
*/

insert into student_tb
	(name, age, address) 
values
    ('김도균', 27, '부산 금정구'),
    ('김도훈', 25, '부산 부산진구'),
    ('김범수', 33, '부산 금정구'),
    ('김상현', 26, '부산 남구'),
    ('이재영', 29, '부산 서구'),
    ('이정찬', 26, '부산 부산진구'),
    ('이지언', 29, '부산 동래구'),
    ('이편원', 30, '경남남도 양산시'),
    ('전주환', 30, '부산 부산진구'),
    ('심재원', 29, '부산 남구');
    
select
	*
from
	student_tb;
    
select
	*
from
	student_tb
where
	age between 20 and 29;		#between : 이상 이하
    
select
	*
from
	student_tb
where
	age > 29
    and age < 40;
    
select
	*
from
	student_tb
where
	name like '이%원%';		#김씨들만 골라내면 like '김%'(글자수 상관없음), '김__' (글자수 맞아야 함)   / '%원' 원으로 끝남 / '%김%' 중간에 김이 들어간다
    
select
	*
from
	student_tb
where
	name like '%도%' 
    or name like '%원';
    
# 집계 (그룹화)  		#  from -> where(그룹 묶기전에 조건식) -> group by -> having(그룹시킨 이후에 조건식) -> select -> order by (정렬)
select
	name,
	address,
	count(*) as address_count 
from
	student_tb
group by	# 
	#name,
	address
having
	address_count >= 2  #count(*) >= 2
order by	# 오름차순 ,  desc 내림차순
	address_count desc,	
    address desc;
    
select
	1 as a,
    2 as b,
    3 as c
    


    
    
    