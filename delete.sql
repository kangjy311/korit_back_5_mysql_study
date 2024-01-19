delete 		# 
from
	product_register_tb
where
	product_color_id = (select
							product_color_id
						from
							product_color_tb
						where
							product_color_name = 'Black');
                            
select
	*
from
	product_register_view;
						