drop trigger if exists change_mi_status;
delimiter $$
create trigger change_mi_status after insert on t_member_status for each row
	begin
		declare uid varchar(12);
        set uid = new.mi_id;
		update t_member_info set mi_status = 'b' where mi_id = uid;
    end $$
delimiter ;
drop view v_product_info_index_new;
drop view v_product_info_index_sale;
drop view v_product_info_index_dc;
create view v_product_info_index_new as select pi_id, pi_img1, pi_name, pi_min, pi_date from t_product_info where pi_isview = 'y' order by pi_date desc limit 0, 8;
select * from v_product_info_index_new;
create view v_product_info_index_sale as select pi_id, pi_img1, pi_name, pi_min, pi_sale from t_product_info where pi_isview = 'y' order by pi_sale desc limit 0, 8;
select * from v_product_info_index_sale;
create view v_product_info_index_dc as select pi_id, pi_img1, pi_name, pi_min, pi_dc from t_product_info where pi_isview = 'y' and pi_dc > 0 order by pi_dc desc limit 0, 8;
select * from v_product_info_index_dc;
create view v_bbs_review_index as select br_idx, br_img, br_date from t_bbs_review where br_isdel = 'n' order by br_date desc;
select * from v_bbs_review_index;

select pi_id, pi_img1, pi_name, pi_min, pi_date from t_product_info where pi_isview = 'y' order by pi_date desc limit 0, 8;
select pi_id, pi_img1, pi_name, pi_min, pi_sale from t_product_info where pi_isview = 'y' order by pi_sale desc limit 0, 8;
select pi_id, pi_img1, pi_name, pi_min, pi_dc from t_product_info where pi_isview = 'y' and pi_dc > 0 order by pi_dc desc limit 0, 8;

select * from t_member_info;
select * from t_member_point;
drop procedure if exists sp_join_member;
delimiter $$
create procedure sp_join_member (IN miid varchar(12), mipw varchar(12), miname varchar(20), migender char(1), mibirth char(10), miphone varchar(13), miemail varchar(50), 
								mizip char(5), miaddr1 varchar(50), miaddr2 varchar(50), OUT result int)
begin
	declare cnt int default 0;
    insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_zip, mi_addr1, mi_addr2, mi_point) values (miid, mipw, miname, migender, mibirth, miphone, miemail, mizip, miaddr1, miaddr2, 10000);
    select count(*) into cnt from t_member_info where mi_id = miid;
    set result = cnt;
    set cnt = 0;
    insert into t_member_point (mi_id, mp_point, mp_desc) values (miid, 10000, '가입 축하금');
    select count(*) into cnt from t_member_point where mi_id = miid and mp_desc = '가입 축하금';
    set result = result + cnt;
end $$
delimiter ;
call sp_join_member('test2', '12345', 'john', '남', '2012-12-23', '010-9999-9999', 'test@test.com', '12345', '서울시 강남구 서초동', '123-66', @result);
select @result as result;