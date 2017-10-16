-- Very basic approach for using this function. you can add it as a cte and automate the where clause with rn <= sample_size

select anly_work_tbls.sample_size_calc(count(*),99,1) as sample_size
from TABLE_WITH_ALL_DATA; -- This returns the sample size you need

select customer_id, 
       last_order_date,
       count_order,
       avg_amount
from (
  select  customer_id, 
          last_order_date,
          count_order,
          avg_amount,
          random,
          row_number() over(order by random) as rn
    from TABLE_WITH_ALL_DATA
  ) a
  where rn <= b.sample_size 
;
