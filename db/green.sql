use green;

-- 관리자 정보 테이블
create table t_admin_info (
	ai_idx int auto_increment unique, 			-- 일련번호
    ai_id varchar(20) primary key, 				-- 아이디
    ai_pw varchar(20) not null, 				-- 비밀번호
    ai_name varchar(20) not null, 				-- 이름
    ai_use char(1) default 'y', 				-- 사용 여부
    ai_date datetime default now()				-- 등록일
);

-- 회원 정보 테이블
create table t_member_info (
	mi_id varchar(12) primary key, 				-- 회원 ID
    mi_pw varchar(12) not null, 				-- 비밀 번호
    mi_name varchar(20) not null, 				-- 이름
    mi_gender char(1) not null, 				-- 성별
    mi_birth char(10) not null, 				-- 생년월일
    mi_phone varchar(13) not null unique, 		-- 전화번호
    mi_email varchar(50) not null unique, 		-- 이메일
    mi_zip char(5) not null, 					-- 우편번호
    mi_addr1 varchar(50) not null, 				-- 주소1
    mi_addr2 varchar(50) not null, 				-- 주소2
    mi_point int default 0, 					-- 보유 포인트
    mi_joindate datetime default now(), 		-- 가입일
    mi_status char(1) default 'a'				-- 상태
);

-- 회원 포인트 내역 테이블
create table t_member_point (
	mp_idx int primary key auto_increment, 		-- 일련번호
    mi_id varchar(12), 							-- 회원 ID
    mp_su char(1) default 's', 					-- 사용 / 적립
    mp_point int default 0, 					-- 변경된 포인트
    mp_desc varchar(20) not null, 				-- 사유
    mp_detail varchar(20) default '', 			-- 내역 상세
    mp_date datetime default now(), 			-- 사용 / 적립 일
    mp_admin int default 0,						-- 관리자 번호
    constraint fk_member_point_mi_id foreign key (mi_id) references t_member_info (mi_id)
);

-- 회원 탈퇴 정보 테이블
create table t_member_status (
	ms_idx int primary key auto_increment, 		-- 일련번호
    mi_id varchar(12), 							-- 회원 ID
    ms_status char(1) default 'b', 				-- 상태
    ms_reason varchar(200) default '', 			-- 사유
    ms_self int default 0, 						-- 본인 여부
    ms_date datetime default now(), 			-- 일시
    constraint fk_member_status_mi_id foreign key (mi_id) references t_member_info (mi_id)
);

-- 상품 브랜드 테이블
create table t_product_brand (
	pb_id char(1) primary key, 					-- 브랜드 코드
    pb_name char(2) not null					-- 브랜드 이름
);

-- 상품 시리즈 테이블
create table t_product_series (
	ps_id char(3) primary key, 					-- 시리즈 코드
    pb_id char(1), 								-- 브랜드 코드
    ps_name char(5) not null, 					-- 시리즈 이름
    constraint fk_product_series_pb_id foreign key (pb_id) references t_product_brand (pb_id)
);

-- 상품 정보 테이블
create table t_product_info (
	pi_id char(5) primary key, 					-- 상품 ID
    pb_id char(1), 								-- 브랜드 코드
    ps_id char(3), 								-- 시리즈 코드
    pi_name varchar(50) not null unique, 		-- 모델 명
    pi_max int default 0, 						-- 최대 가격(buy)
    pi_min int default 0, 						-- 최소 가격(sell)
    pi_dc int default 0, 						-- 할인율
    pi_img1 varchar(50) not null, 				-- 상품 이미지1(B)
    pi_img2 varchar(50) not null, 				-- 상품 이미지2(W)
    pi_sale int default 0, 						-- 판매량
    pi_isview char(1) default 'n', 				-- 게시 여부
    pi_date datetime default now(), 			-- 등록일
    ai_idx int, 								-- 등록 관리자
    constraint fk_product_info_pb_id foreign key (pb_id) references t_product_brand (pb_id), 
    constraint fk_product_info_ps_id foreign key (ps_id) references t_product_series (ps_id), 
    constraint fk_product_info_ai_idx foreign key (ai_idx) references t_admin_info (ai_idx)
);

-- 상품 옵션 정보 테이블
create table t_product_option (
	po_idx int auto_increment primary key, 		-- 일련 번호
    pi_id char(5), 								-- 상품 ID
    po_color char(1) not null, 					-- 색상
    po_memory char(3) not null, 				-- 용량
    po_rank char(1) not null, 					-- 등급
    po_name varchar(20) not null, 				-- 옵션명
    po_inc int default 0, 						-- 증가 비율(sell)
    po_dec int default 0, 						-- 감소 비율(buy)
    po_stock int default 0, 					-- 재고량
    po_isview char(1) default 'n', 				-- 게시 여부
    constraint fk_product_option_pi_id foreign key (pi_id) references t_product_info (pi_id)
);

-- 장바구니 테이블
create table t_sell_cart (
	sc_idx int auto_increment primary key, 		-- 일련 번호
    mi_id varchar(12), 							-- 회원 ID
    pi_id char(5), 								-- 상품 ID
    po_idx int, 								-- 옵션 ID
    sc_cnt int default 0, 						-- 개수
    sc_date datetime default now(), 			-- 등록일
    constraint fk_sell_cart_mi_id foreign key (mi_id) references t_member_info (mi_id), 
    constraint fk_sell_cart_pi_id foreign key (pi_id) references t_product_info (pi_id), 
    constraint fk_sell_cart_po_idx foreign key (po_idx) references t_product_option (po_idx)
);

-- 구매(sell) 정보 테이블
create table t_sell_info (
	si_id char(10) primary key, 				-- 구매(sell) 번호
    mi_id varchar(12), 							-- 회원 ID
    si_name varchar(20) not null, 				-- 수취인 명
    si_phone varchar(13) not null, 				-- 배송지 전화번호
    si_zip char(5) not null, 					-- 배송지 우편번호
    si_addr1 varchar(50) not null, 				-- 배송지 주소1
    si_addr2 varchar(50) not null, 				-- 배송지 주소2
    si_memo varchar(200) default '', 			-- 배송 메모
    si_payment char(1) default 'a', 			-- 결제 수단
    si_pay int default 0, 						-- 결제액
    si_upoint int default 0, 					-- 사용 포인트
    si_spoint int default 0, 					-- 적립 포인트
    si_invoice varchar(50) default '', 			-- 송장 번호
    si_status char(1) default 'b', 				-- 구매(sell) 상태
    si_date datetime default now(), 			-- 구매(sell)일
    si_last datetime default now(), 			-- 최근 상태 변경일
    constraint fk_sell_info_mi_id foreign key (mi_id) references t_member_info (mi_id)
);

-- 구매(sell) 상세 정보 테이블
create table t_sell_detail (
	sd_idx int auto_increment primary key, 		-- 일련 번호
    si_id char(10), 							-- 구매(sell) 번호
    pi_id char(5), 								-- 상품 ID
    po_idx int, 								-- 옵션 ID
    sd_mname varchar(50) not null, 				-- 모델명
    sd_oname varchar(20) not null, 				-- 옵션명
    sd_img varchar(50) not null, 				-- 상품 이미지
    sd_cnt int default 0, 						-- 개수
    sd_price int default 0, 					-- 단가
    sd_dc int default 0, 						-- 할인율
    sd_cdate datetime, 							-- 구매(sell) 확정일
    constraint fk_sell_detail_si_id foreign key (si_id) references t_sell_info (si_id), 
    constraint fk_sell_detail_pi_id foreign key (pi_id) references t_product_info (pi_id), 
    constraint fk_sell_detail_po_idx foreign key (po_idx) references t_product_option (po_idx)
);

-- 판매(buy) 상세 정보 테이블
create table t_buy_info (
	bi_id char(10) primary key, 				-- 판매(buy) 번호
    mi_id varchar(12), 							-- 회원 ID
    pi_id char(5), 								-- 상품 ID
    bi_color char(1) not null, 					-- 색상
    bi_memory char(3) not null, 				-- 용량
    bi_rank char(1) default '', 				-- 등급
    bi_option int default 0, 					-- 옵션 ID
    bi_img1 varchar(50) not null, 				-- 사진1
    bi_img2 varchar(50) not null, 				-- 사진2
    bi_img3 varchar(50) not null, 				-- 사진3
    bi_img4 varchar(50) not null, 				-- 사진4
    bi_desc varchar(200) default '', 			-- 추가 정보
    bi_predict int default 0, 					-- 판매(buy) 예상 가격
    bi_pay int default 0, 						-- 최종 판매(buy) 가격
    bi_invoice varchar(50) default '', 			-- 송장 번호
    bi_bank varchar(5) default '', 				-- 은행
    bi_account varchar(30) default '', 			-- 계좌 번호
    bi_status char(1) default 'a', 				-- 판매(buy) 상태
    bi_date datetime default now(), 			-- 판매(buy) 등록일
    constraint fk_buy_info_mi_id foreign key (mi_id) references t_member_info (mi_id), 
    constraint fk_buy_info_pi_id foreign key (pi_id) references t_product_info (pi_id)
);

-- 공지사항 게시판 테이블
create table t_bbs_notice (
	bn_idx int primary key, 					-- 글 번호
    ai_idx int, 								-- 작성 관리자
    bn_title varchar(100) not null, 			-- 제목
    bn_img varchar(50) default '', 				-- 이미지
    bn_content text not null, 					-- 내용
    bn_read int default 0, 						-- 조회수
    bn_isview char(1) default 'n', 				-- 게시 여부
    bn_date datetime default now(), 			-- 작성일
    constraint fk_bbs_notice_ai_idx foreign key (ai_idx) references t_admin_info (ai_idx)
);

-- FAQ 게시판 테이블
create table t_bbs_question (
	bq_idx int primary key, 					-- 글 번호
    ai_idx int, 								-- 작성 관리자
    bq_question text not null, 					-- 질문 내용
    bq_answer text not null, 					-- 답변 내용
    bq_date datetime default now(), 			-- 질문 작성일
    bq_isview char(1) default 'n', 				-- 게시 여부
    constraint fk_bbs_question_ai_idx foreign key (ai_idx) references t_admin_info (ai_idx)
);

-- 이벤트 게시판 테이블
create table t_bbs_event (
	be_idx int primary key, 					-- 글 번호
    ai_idx int, 								-- 작성 관리자
    be_title varchar(100) not null, 			-- 이벤트 글 제목
    be_content text not null, 					-- 이벤트 글 내용
    be_img varchar(50) not null, 				-- 이벤트 사진
    be_read int default 0, 						-- 조회수
    be_isview char(1) default 'n', 				-- 게시 여부
    be_sdate date not null, 					-- 이벤트 시작일
    bd_edate date not null, 					-- 이벤트 종료일
    be_date datetime default now(), 			-- 이벤트 등록일
    constraint fk_bbs_event_ai_idx foreign key (ai_idx) references t_admin_info (ai_idx)
);

-- 리뷰 게시판 테이블
create table t_bbs_review (
	br_idx int unique, 							-- 글 번호
    mi_id varchar(12),				-- 회원 ID
    si_id char(10), 				-- 구매(sell) 번호
    pi_id char(5), 					-- 상품 ID
    po_idx int, 					-- 옵션 ID
    br_name varchar(100) not null, 				-- 모델 명 / 옵션 명
    br_title varchar(100) not null, 			-- 리뷰 제목
    br_content text not null, 					-- 리뷰 내용
    br_img varchar(50) not null, 				-- 상품 이미지
    br_read int default 0, 						-- 조회수
    br_date datetime default now(), 			-- 리뷰 작성일
    br_isdel char(1) default 'n', 				-- 삭제 여부
    constraint pk_bbs_review primary key (mi_id, si_id, pi_id, po_idx), 
    constraint fk_bbs_review_mi_id foreign key (mi_id) references t_member_info (mi_id), 
    constraint fk_bbs_review_si_id foreign key (si_id) references t_sell_info (si_id), 
    constraint fk_bbs_review_pi_id foreign key (pi_id) references t_product_info (pi_id), 
    constraint fk_bbs_review_po_idx foreign key (po_idx) references t_product_option (po_idx)
);

-- 자유 게시판 테이블
create table t_bbs_free (
	bf_idx int primary key, 					-- 글 번호
    mi_id varchar(12), 							-- 회원 ID
    bf_title varchar(100) not null, 			-- 제목
    bf_content text not null, 					-- 내용
    bf_img varchar(50) default '', 				-- 이미지
    bf_reply int default 0, 					-- 댓글 개수
    bf_read int default 0, 						-- 조회수
    bf_date datetime default now(), 			-- 글 작성일
    bf_isdel char(1) default 'n', 				-- 삭제 여부
    constraint fk_bbs_free_mi_id foreign key (mi_id) references t_member_info (mi_id)
);

-- 자유 게시판 댓글 테이블
create table t_bbs_free_reply (
	bfr_idx int auto_increment primary key, 	-- 댓글 번호
    bf_idx int, 								-- 게시글 번호
    mi_id varchar(12), 							-- 회원 ID
    bfr_content varchar(200) not null, 			-- 댓글 내용
    bfr_date datetime default now(), 			-- 작성일
    bfr_isdel char(1) default 'n', 				-- 삭제 여부
    constraint fk_bbs_free_reply_bf_idx foreign key (bf_idx) references t_bbs_free (bf_idx), 
    constraint fk_bbs_free_reply_mi_id foreign key (mi_id) references t_member_info (mi_id)
);

-- 1 : 1 문의 게시판 테이블
create table t_bbs_member_question (
	bmq_idx int primary key, 					-- 글 번호
    mi_id varchar(12), 							-- 회원 ID
    bmq_title varchar(100) not null, 			-- 질문 제목
    bmq_img varchar(50) default '', 			-- 이미지
    bmq_status char(1) default 'a', 			-- 상태
    bmq_content varchar(200) not null, 			-- 질문 내용
    bmq_date datetime default now(), 			-- 등록일
    ai_idx int default 0, 						-- 답변 관리자 ID
    bmq_answer varchar(200) default '', 		-- 답변 내용
    bmq_adate datetime, 						-- 답변 일자
    constraint fk_bbs_member_question_mi_id foreign key (mi_id) references t_member_info (mi_id)
);