IMPORT INTO bmsql_warehouse(w_id ,w_ytd ,w_tax ,w_name,w_street_1,w_street_2,w_city,w_state,w_zip) CSV DATA ('nodelocal://1/warehouse.csv') with nullif ='NULL';

IMPORT INTO bmsql_config(cfg_name, cfg_value) CSV DATA ('nodelocal://1/config.csv') with nullif ='NULL';

IMPORT INTO bmsql_history (hist_id ,h_c_id,h_c_d_id,h_c_w_id,h_d_id,h_w_id,h_date,h_amount,h_data) CSV DATA ('nodelocal://1/cust-hist.csv') with nullif ='NULL';

IMPORT INTO bmsql_customer(c_w_id,c_d_id,c_id,c_discount ,c_credit,c_last,c_first,c_credit_lim ,c_balance ,c_ytd_payment ,c_payment_cnt,c_delivery_cnt,c_street_1,c_street_2,c_city,c_state,c_zip,c_phone,c_since,c_middle,c_data) CSV DATA ('nodelocal://1/customer.csv') with nullif ='NULL';

IMPORT INTO bmsql_district(d_w_id,d_id,d_ytd,d_tax,d_next_o_id ,d_name,d_street_1 ,d_street_2 ,d_city ,d_state,d_zip) CSV DATA('nodelocal://1/district.csv') with nullif ='NULL';

IMPORT INTO bmsql_item(i_id ,i_name,i_price,i_data ,i_im_id) CSV DATA ('nodelocal://1/item.csv') with nullif = 'NULL';

IMPORT INTO bmsql_new_order(no_w_id,no_d_id,no_o_id) CSV DATA('nodelocal://1/new-order.csv') with nullif ='NULL';
IMPORT INTO bmsql_oorder(o_w_id ,o_d_id ,o_id ,o_c_id ,o_carrier_id ,o_ol_cnt ,o_all_local ,o_entry_d) CSV DATA('nodelocal://1/order.csv') with nullif ='NULL';

IMPORT INTO bmsql_stock (s_w_id  ,s_i_id ,s_quantity ,  s_ytd ,s_order_cnt  ,s_remote_cnt ,s_data ,s_dist_01,s_dist_02,s_dist_03,s_dist_04,s_dist_05,s_dist_06,s_dist_07,s_dist_08,s_dist_09,s_dist_10) CSV DATA('nodelocal://1/stock.csv') with nullif ='NULL';

IMPORT INTO bmsql_customer(c_w_id,c_d_id,c_id,c_discount ,c_credit,c_last,c_first,c_credit_lim ,c_balance ,c_ytd_payment ,c_payment_cnt,c_delivery_cnt,c_street_1,c_street_2,c_city,c_state,c_zip,c_phone,c_since,c_middle,c_data) CSV DATA ('nodelocal://1/customer.csv') with nullif ='NULL';

IMPORT INTO bmsql_order_line(ol_w_id,ol_d_id,ol_o_id,ol_number,ol_i_id,ol_delivery_d,ol_amount,ol_supply_w_id,ol_quantity,ol_dist_info) CSV DATA('nodelocal://1/order-line.csv') with nullif='NULL' ;
