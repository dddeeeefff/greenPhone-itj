use green;

insert into t_admin_info (ai_id, ai_pw, ai_name) values('test1','1234','관리자');
select * from t_admin_info;

insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_zip, mi_addr1, mi_addr2) 
values('client1','1234','김철수', '남', '2023-01-01', '010-1234-5678', 'a@a.com' ,'12345', '서울시 동작구 사당로', '29-3 305호');
select * from t_member_info;

insert into t_member_point (mi_id, mp_point, mp_desc) values('client1', 10000, '가입축하금');
select * from t_member_point;

insert into t_member_status (mi_id, ms_status, ms_reason) values('client1', 'b', '그냥 탈퇴함');
select * from t_member_status;

insert into t_product_brand(pb_id, pb_name) values('a', '애플');
insert into t_product_brand(pb_id, pb_name) values('s', '삼성');
select * from t_product_brand;

insert t_product_series(ps_id, pb_id, ps_name) values('a11', 'a', '11시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('a12', 'a', '12시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('a13', 'a', '13시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('a14', 'a', '14시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('s20', 's', '20시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('s21', 's', '21시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('s22', 's', '22시리즈');
insert t_product_series(ps_id, pb_id, ps_name) values('s23', 's', '23시리즈');
select * from t_product_series;

insert t_product_info(pi_id, pb_id, ps_id, pi_name, pi_max, pi_min, pi_dc, pi_img1, pi_img2, pi_img3, pi_img4, ai_idx) 
values('a1101', 'a', 'a11', '아이폰11', 800000, 500000, 10, 'a1101_1', 'a1101_2', 'a1101_3', 'a1101_4', 1);
select * from t_product_info;

insert into t_product_option(pi_id, po_color, po_memory, po_rank, po_name, po_inc, po_dec, po_stock)
values('a1101', 'b', 128, 's', '128GB/블랙/S', 20, 20, 180);
select * from t_product_option;

delete from t_sell_cart where sc_idx = 2;

select * from t_sell_cart;

insert into t_sell_cart (mi_id, pi_id, po_idx, sc_cnt) 
values ('test1', 's2103', 322, 1);

insert into t_sell_cart (mi_id, pi_id, po_idx, sc_cnt) 
values ('test1', 'a1302', 141, 2);

select a.*, b.pi_id, b.pi_name, b.pi_min, b.pi_dc, b.pi_img1, c.po_name, c.po_idx 
from t_sell_cart a, t_product_info b, t_product_option c 
where a.pi_id = b.pi_id and a.pi_id = c.pi_id and a.po_idx = c.po_idx and pi_isview = 'y' and a.mi_id = 'test1';

update t_sell_cart set sc_cnt = 3 where sc_idx = 1;

select * from t_sell_info;
select * from t_sell_detail;

select * from t_member_info where mi_id = 'test2';
select * from t_member_point where mi_id = 'test2';
select * from t_sell_info where si_id = 'as23022316';
select * from t_sell_detail where si_id = 'as23022316';

update t_sell_info set si_status = 'b' where si_id = 'as23022311';


select sum(bi_pay) from t_buy_info where year(now()) = year(bi_date);

select sum(si_pay) from t_sell_info where year(now()) = year(si_date) and si_status <> 'f';

update t_member_info set  mi_status = 'a' where mi_id = 'test1';

select * from t_bbs_notice;

update t_bbs_notice set ai_idx = '', bn_title = '', bn_img = '', bn_content = '' where bn_idx = '';	

-- update t_bbs_notice set bn_img = "notice_11.jpg" where bn_idx = 11;

insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "개인정보 약관 공지 안내드립니다.", "notice_1", "약관이 변경됬어용!", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "이벤트 당첨자 안내드립니다.", "notice_2", "사실은 당첨자가 없어용!", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "회원가입 이벤트 안내입니다.", "notice_3", "정해진 기간에만 가입시 1000 포인트가 적립됩니다.", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "불량 회원 제제 안내드립니다.", "notice_4", "위의 회원들은 이용정책 위반으로 서비스 이용이 제제되었습니다.", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "그린폰 창업 1주년을 맞았습니다.", "notice_5", "모두들 축하부탁드려용", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "최근 발생한 휴대폰 이슈에 대한 안내입니다.", "notice_6", "혹시 몰라서 비번을 1111로 설정했습니다.", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "그린폰은 환경을 생각하는 기업입니다.", "notice_7", "좀 더 환경을 생각하는 더나은 기업이 되도록 노력하겠습니다.", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "고객정보는 소중히 관리하고 있습니다.", "notice_8", "다들 걱정하지 마세용!!", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "유사 피싱사이트 주의 안내드립니다.", "notice_9", "개인정보를 탈취를 목적으로 하는 클론사이트 주의 부탁드립니다.", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "최근 택배사 파업으로 배송이 지연되고 있습니다.", "notice_10", "예정일보다 배송이 지연이 예상되므로 이해 부탁드립니다.", 0, "y");
insert into t_bbs_notice (ai_idx, bn_title, bn_img, bn_content, bn_read, bn_isview)
values(1, "사이트 이용정책 변경 안내입니다.", "notice_11", "정책이 변경됬어용", 0, "y");

