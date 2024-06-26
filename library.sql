insert into category_tb(category_name, create_date, update_date)
select
    카테고리,
    now(),
    now()
from
	book_sample_tb
group by
	카테고리;
    
insert into book_type_tb(book_type_name, create_date, update_date)
select
	형식,
	now(),
	now()
from	
	book_sample_tb
group by
	형식;

insert into book_tb(
	book_name, 
    author_name, 
    publisher_name, 
    isbn, 
    book_type_id, 
    category_id, 
    cover_img_url
)        
select
	도서명,
    저자명,
    출판사,
    isbn,
    형식,
    카테고리,
    표지url
from
	book_sample_tb;
    
update
	book_tb bt
    left outer join book_type_tb btt on(btt.book_type_name = bt.book_type_id)
    left outer join category_tb ct on(ct.category_name = bt.category_id)
set
	bt.book_type_id = btt.book_type_id,
    bt.category_id = ct.category_id;
    
# isbn 빈칸 null로 채우기
update
	book_tb
set
	isbn = nullif(isbn, "");
 
 
 -- 
 insert into role_tb
 values
 (0, "ROLE_TEMPORARY_USER", "임시사용자", now(), now()),
 (0, "ROLE_USER", "사용자", now(), now()),
 (0, "ROLE_ADMIN", "관리자", now(), now());
 
 update
	book_tb
set
	create_date = now(),
    update_date =- now()
 
 
 