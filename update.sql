# product_color에 navy -> green

# 새로운 라인 추가 insert , 값 추가 update

update product_color_tb		#(from)
set product_color_name = 'Green'
where
	product_color_name = 'Navy';

# 한번에 업데이트 case when _ then _ else _ end
update product_color_tb
set 
	product_color_name_kor = case 
		when product_color_name = 'Black' then '블랙'
		when product_color_name = 'White' then '화이트'
		when product_color_name = 'Green' then '그린'
	end;