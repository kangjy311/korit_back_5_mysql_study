set @count = 0;

call p_sum(10, 20, @result, @count); 	# call : procedures 호출 

select
	@count;