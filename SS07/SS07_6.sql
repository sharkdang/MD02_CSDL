use ss07;


create index idx_search_status_orderdate
on orders (status,order_date);