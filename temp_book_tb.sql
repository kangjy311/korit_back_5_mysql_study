insert into author_tb
SELECT 
	0,
	author
FROM 
	db_study.temp_book_tb
group by
	author
order by
	author;
    
select
	*
from
	author_tb;
    
insert into publisher_tb(publisher_name)
select
	0,
	publisher
from 
	temp_book_tb
group by
	publisher
order by
	publisher;
    
select
	*
from
	publisher_tb;


#
insert into book_tb
select
	0,
	book_name
from 
	temp_book_tb
group by
	book_name
order by
	book_name;

#
insert into book_tb
select
	0,
    tbt.book_name,
    at.author_id,
    pt.publisher_id
from
	temp_book_tb tbt
    left outer join author_tb at on(at.author_name = tbt.author)
    left outer join publisher_tb pt on(pt.publisher_name = tbt.publisher)
group by	
	tbt.book_name,
    at.author_id,
    pt.publisher_id
order by
	book_name,
    author_id,
    publisher_id;
    
insert into book_register_tb
select
	0,
	tbt.book_code,
	bt2.book_id,
    tbt.loans_count
from
	temp_book_tb tbt
    # left outer join book_tb bt on(bt.book_name = tbt.book_name) 		# book_tb에 book_id
    left outer join (select 
						bt.book_id,
						bt.book_name,
                        at.author_name,
                        pt.publisher_name
					from 
						book_tb bt 
						left outer join author_tb at on(at.author_id = bt.author_id)
                        left outer join publisher_tb pt on(pt.publisher_id  = bt.publisher_id)) bt2		
	on(bt2.book_name = tbt.book_name and bt2.author_name = tbt.author and bt2.publisher_name = tbt.publisher);
    
select
	brt.book_register_id,
    brt.book_code,
    brt.book_id,
    bt.book_name,
    bt.author_id,
    at.author_name,
    bt.publisher_id,
    pt.publisher_name,
    brt.loans_count
from 
	book_register_tb brt 
    left outer join book_tb bt on(bt.book_id = brt.book_id)
    left outer join author_tb at on(at.author_id = bt.author_id)
    left outer join publisher_tb pt on(pt.publisher_id = bt.publisher_id);
    
select
	rank() over(partition by publisher_id order by publisher_id, sum(brt.loans_count) desc), 	# partition by : select할 때 그룹을 묶어줌
	row_number() over(partition by publisher_id order by publisher_id, sum(brt.loans_count) desc), 		# row_number : 매칭시킬때 씀 
    brt.book_id,
    bt.book_name,
    bt.author_id,
    at.author_name,
    bt.publisher_id,
    pt.publisher_name,
    sum(brt.loans_count) as total_loans_count
from 
	book_register_tb brt 
    left outer join book_tb bt on(bt.book_id = brt.book_id)
    left outer join author_tb at on(at.author_id = bt.author_id)
    left outer join publisher_tb pt on(pt.publisher_id = bt.publisher_id)
group by
	brt.book_id,
    bt.author_id,
    bt.publisher_id;
    
select		
	*
from
	(select
		rank() over(partition by publisher_id order by publisher_id, sum(brt.loans_count) desc) as rank_num, 	
		row_number() over(partition by publisher_id order by publisher_id, sum(brt.loans_count) desc) as row_num,
		brt.book_id,
		bt.book_name,
		bt.author_id,
		at.author_name,
		bt.publisher_id,
		pt.publisher_name,
		sum(brt.loans_count) as total_loans_count
	from 
		book_register_tb brt 
		left outer join book_tb bt on(bt.book_id = brt.book_id)
		left outer join author_tb at on(at.author_id = bt.author_id)
		left outer join publisher_tb pt on(pt.publisher_id = bt.publisher_id)
	group by
		brt.book_id,
		bt.author_id,
		bt.publisher_id) temp_book_register_tb		# 서브쿼리로 테이블 참조할 때 as 달아야됨
where
	temp_book_register_tb.row_num = 1;
    
# 서브쿼리 : where ,select 는 컬럼 1개 , from 여러개의 결과 