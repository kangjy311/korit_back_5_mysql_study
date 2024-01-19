create view product_register_view as 	# view 자주쓰는거 가상테이블로 만듬
SELECT 
	prt.product_register_id,
    prt.product_id,
    pt.product_name,
    pt.product_price,
    prt.product_size_id,
    pst.product_size_name,
    prt.product_color_id,
    pct.product_color_name
FROM 
   product_register_tb prt	# 테이블 'as' 생략 가능
   left outer join product_tb pt on(pt.product_id = prt.product_id)
   left outer join product_size_tb as pst on(pst.product_size_id = prt.product_size_id)
   left outer join product_color_tb as pct on(pct.product_color_id = prt.product_color_id);
   
   # 정규화된 테이블 합치는 방법 
   # left outer join	 on (조건식 : 조건이 참일 때 테이블을 합친다)
   
SELECT 
    prt.product_size_id,
    pst.product_size_name,
    count(prt.product_size_id) as count
FROM 
   product_register_tb prt	# 테이블 'as' 생략 가능
   left outer join product_tb pt on(pt.product_id = prt.product_id)
   left outer join product_size_tb as pst on(pst.product_size_id = prt.product_size_id)
   left outer join product_color_tb as pct on(pct.product_color_id = prt.product_color_id)
group by
	prt.product_size_id,
    pst.product_size_name
order by
	prt.product_size_id;
    
select
	product_size_id,
    product_size_name,
    count(product_size_id) as product_size_count
from
	product_register_view 
group by
	product_size_id,
    product_size_name
;