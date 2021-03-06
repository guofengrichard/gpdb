-- start_ignore
SET gp_create_table_random_default_distribution=off;
-- end_ignore
--
-- Create table
--
CREATE TABLE resync_co_compr_part_rle_type_1
        (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,
        a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int )  WITH (appendonly=true, orientation=column) distributed randomly
 Partition by list(a2) Subpartition by range(a1) subpartition template (default subpartition df_sp, start(1)  end(5000) every(1000), 
 COLUMN a2  ENCODING (compresstype=rle_type,compresslevel=1,blocksize=32768), 
 COLUMN a1 encoding (compresstype = quicklz),
 COLUMN a5 ENCODING (compresstype=quicklz,compresslevel=1, blocksize=32768),
 DEFAULT COLUMN ENCODING (compresstype=rle_type,compresslevel=1,blocksize=32768)) (partition p1 values('F'), partition p2 values ('M'));

-- 
-- Create Indexes
--
CREATE INDEX resync_co_compr_part_rle_type_1_idx_bitmap ON resync_co_compr_part_rle_type_1 USING bitmap (a1);

CREATE INDEX resync_co_compr_part_rle_type_1_idx_btree ON resync_co_compr_part_rle_type_1(a9);

--
-- Insert data to the table
--
INSERT INTO resync_co_compr_part_rle_type_1(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(1,20),'M',2011,'t','a','This is news of today: Deadlock between Republicans and Democrats over how best to reduce the U.S. deficit, and over what period, has blocked an agreement to allow the raising of the $14.3 trillion debt ceiling','2001-12-24 02:26:11','U.S. House of Representatives Speaker John Boehner, the top Republican in Congress who has put forward a deficit reduction plan to be voted on later on Thursday said he had no control over whether his bill would avert a credit downgrade.',generate_series(2490,2505),'2011-10-11','The Republican-controlled House is tentatively scheduled to vote on Boehner proposal this afternoon at around 6 p.m. EDT (2200 GMT). The main Republican vote counter in the House, Kevin McCarthy, would not say if there were enough votes to pass the bill.','WASHINGTON:House Speaker John Boehner says his plan mixing spending cuts in exchange for raising the nations $14.3 trillion debt limit is not perfect but is as large a step that a divided government can take that is doable and signable by President Barack Obama.The Ohio Republican says the measure is an honest and sincere attempt at compromise and was negotiated with Democrats last weekend and that passing it would end the ongoing debt crisis. The plan blends $900 billion-plus in spending cuts with a companion increase in the nations borrowing cap.','1234.56',323453,generate_series(3452,3462),7845,'0011','2005-07-16 01:51:15+1359','2001-12-13 01:51:15','((1,2),(0,3),(2,1))','((2,3)(4,5))','08:00:2b:01:02:03','1-2','Republicans had been working throughout the day Thursday to lock down support for their plan to raise the nations debt ceiling, even as Senate Democrats vowed to swiftly kill it if passed.','((2,3)(4,5))','(6,7)',11.222,'((4,5),7)',32,3214,'(1,0,2,3)','2010-02-21',43564,'$1,000.00','192.168.1','126.1.3.4','12:30:45','Johnson & Johnsons McNeil Consumer Healthcare announced the voluntary dosage reduction today. Labels will carry new dosing instructions this fall.The company says it will cut the maximum dosage of Regular Strength Tylenol and other acetaminophen-containing products in 2012.Acetaminophen is safe when used as directed, says Edwin Kuffner, MD, McNeil vice president of over-the-counter medical affairs. But, when too much is taken, it can cause liver damage.The action is intended to cut the risk of such accidental overdoses, the company says in a news release.','1','0',12,23);

INSERT INTO resync_co_compr_part_rle_type_1(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(500,510),'F',2010,'f','b','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child','2001-12-25 02:22:11','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child',generate_series(2500,2516),'2011-10-12','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child The type integer is the usual choice, as it offers the best balance between range, storage size, and performance The type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer ','1134.26',311353,generate_series(3982,3992),7885,'0101','2002-02-12 01:31:14+1344','2003-11-14 01:41:15','((1,1),(0,1),(1,1))','((2,1)(1,5))','08:00:2b:01:01:03','1-3','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child The types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges. The types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges. Attempts to store values outside of the allowed range will result in an errorThe types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges.','((6,5)(4,2))','(3,6)',12.233,'((5,4),2)',12,3114,'(1,1,0,3)','2010-03-21',43164,'$1,500.00','192.167.2','126.1.1.1','10:30:55','Parents and other family members are always welcome at Stratford. After the first two weeks ofschool','0','1',33,44);


--
-- Create table
--
CREATE TABLE resync_co_compr_part_rle_type_2
         (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,
         a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int )  WITH (appendonly=true, orientation=column) distributed randomly
 Partition by list(a2) Subpartition by range(a1) subpartition template (default subpartition df_sp, start(1)  end(5000) every(1000), 
 COLUMN a2  ENCODING (compresstype=rle_type,compresslevel=2,blocksize=32768), 
 COLUMN a1 encoding (compresstype = quicklz),
 COLUMN a5 ENCODING (compresstype=quicklz,compresslevel=1, blocksize=32768),
 DEFAULT COLUMN ENCODING (compresstype=rle_type,compresslevel=1,blocksize=32768)) (partition p1 values('F'), partition p2 values ('M'));

-- 
-- Create Indexes
--
CREATE INDEX resync_co_compr_part_rle_type_2_idx_bitmap ON resync_co_compr_part_rle_type_2 USING bitmap (a1);

CREATE INDEX resync_co_compr_part_rle_type_2_idx_btree ON resync_co_compr_part_rle_type_2(a9);

--
-- Insert data to the table
--
INSERT INTO resync_co_compr_part_rle_type_2(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(1,20),'M',2011,'t','a','This is news of today: Deadlock between Republicans and Democrats over how best to reduce the U.S. deficit, and over what period, has blocked an agreement to allow the raising of the $14.3 trillion debt ceiling','2001-12-24 02:26:11','U.S. House of Representatives Speaker John Boehner, the top Republican in Congress who has put forward a deficit reduction plan to be voted on later on Thursday said he had no control over whether his bill would avert a credit downgrade.',generate_series(2490,2505),'2011-10-11','The Republican-controlled House is tentatively scheduled to vote on Boehner proposal this afternoon at around 6 p.m. EDT (2200 GMT). The main Republican vote counter in the House, Kevin McCarthy, would not say if there were enough votes to pass the bill.','WASHINGTON:House Speaker John Boehner says his plan mixing spending cuts in exchange for raising the nations $14.3 trillion debt limit is not perfect but is as large a step that a divided government can take that is doable and signable by President Barack Obama.The Ohio Republican says the measure is an honest and sincere attempt at compromise and was negotiated with Democrats last weekend and that passing it would end the ongoing debt crisis. The plan blends $900 billion-plus in spending cuts with a companion increase in the nations borrowing cap.','1234.56',323453,generate_series(3452,3462),7845,'0011','2005-07-16 01:51:15+1359','2001-12-13 01:51:15','((1,2),(0,3),(2,1))','((2,3)(4,5))','08:00:2b:01:02:03','1-2','Republicans had been working throughout the day Thursday to lock down support for their plan to raise the nations debt ceiling, even as Senate Democrats vowed to swiftly kill it if passed.','((2,3)(4,5))','(6,7)',11.222,'((4,5),7)',32,3214,'(1,0,2,3)','2010-02-21',43564,'$1,000.00','192.168.1','126.1.3.4','12:30:45','Johnson & Johnsons McNeil Consumer Healthcare announced the voluntary dosage reduction today. Labels will carry new dosing instructions this fall.The company says it will cut the maximum dosage of Regular Strength Tylenol and other acetaminophen-containing products in 2012.Acetaminophen is safe when used as directed, says Edwin Kuffner, MD, McNeil vice president of over-the-counter medical affairs. But, when too much is taken, it can cause liver damage.The action is intended to cut the risk of such accidental overdoses, the company says in a news release.','1','0',12,23);

INSERT INTO resync_co_compr_part_rle_type_2(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(500,510),'F',2010,'f','b','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child','2001-12-25 02:22:11','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child',generate_series(2500,2516),'2011-10-12','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child The type integer is the usual choice, as it offers the best balance between range, storage size, and performance The type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer ','1134.26',311353,generate_series(3982,3992),7885,'0101','2002-02-12 01:31:14+1344','2003-11-14 01:41:15','((1,1),(0,1),(1,1))','((2,1)(1,5))','08:00:2b:01:01:03','1-3','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child The types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges. The types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges. Attempts to store values outside of the allowed range will result in an errorThe types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges.','((6,5)(4,2))','(3,6)',12.233,'((5,4),2)',12,3114,'(1,1,0,3)','2010-03-21',43164,'$1,500.00','192.167.2','126.1.1.1','10:30:55','Parents and other family members are always welcome at Stratford. After the first two weeks ofschool','0','1',33,44);


--
-- Create table
--
CREATE TABLE resync_co_compr_part_rle_type_3
        (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,
        a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int )  WITH (appendonly=true, orientation=column) distributed randomly
 Partition by list(a2) Subpartition by range(a1) subpartition template (default subpartition df_sp, start(1)  end(5000) every(1000), 
 COLUMN a2  ENCODING (compresstype=rle_type,compresslevel=3,blocksize=32768), 
 COLUMN a1 encoding (compresstype = quicklz),
 COLUMN a5 ENCODING (compresstype=quicklz,compresslevel=1, blocksize=32768),
 DEFAULT COLUMN ENCODING (compresstype=rle_type,compresslevel=1,blocksize=32768)) (partition p1 values('F'), partition p2 values ('M'));

-- 
-- Create Indexes
--
CREATE INDEX resync_co_compr_part_rle_type_3_idx_bitmap ON resync_co_compr_part_rle_type_3 USING bitmap (a1);

CREATE INDEX resync_co_compr_part_rle_type_3_idx_btree ON resync_co_compr_part_rle_type_3(a9);

--
-- Insert data to the table
--
INSERT INTO resync_co_compr_part_rle_type_3(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(1,20),'M',2011,'t','a','This is news of today: Deadlock between Republicans and Democrats over how best to reduce the U.S. deficit, and over what period, has blocked an agreement to allow the raising of the $14.3 trillion debt ceiling','2001-12-24 02:26:11','U.S. House of Representatives Speaker John Boehner, the top Republican in Congress who has put forward a deficit reduction plan to be voted on later on Thursday said he had no control over whether his bill would avert a credit downgrade.',generate_series(2490,2505),'2011-10-11','The Republican-controlled House is tentatively scheduled to vote on Boehner proposal this afternoon at around 6 p.m. EDT (2200 GMT). The main Republican vote counter in the House, Kevin McCarthy, would not say if there were enough votes to pass the bill.','WASHINGTON:House Speaker John Boehner says his plan mixing spending cuts in exchange for raising the nations $14.3 trillion debt limit is not perfect but is as large a step that a divided government can take that is doable and signable by President Barack Obama.The Ohio Republican says the measure is an honest and sincere attempt at compromise and was negotiated with Democrats last weekend and that passing it would end the ongoing debt crisis. The plan blends $900 billion-plus in spending cuts with a companion increase in the nations borrowing cap.','1234.56',323453,generate_series(3452,3462),7845,'0011','2005-07-16 01:51:15+1359','2001-12-13 01:51:15','((1,2),(0,3),(2,1))','((2,3)(4,5))','08:00:2b:01:02:03','1-2','Republicans had been working throughout the day Thursday to lock down support for their plan to raise the nations debt ceiling, even as Senate Democrats vowed to swiftly kill it if passed.','((2,3)(4,5))','(6,7)',11.222,'((4,5),7)',32,3214,'(1,0,2,3)','2010-02-21',43564,'$1,000.00','192.168.1','126.1.3.4','12:30:45','Johnson & Johnsons McNeil Consumer Healthcare announced the voluntary dosage reduction today. Labels will carry new dosing instructions this fall.The company says it will cut the maximum dosage of Regular Strength Tylenol and other acetaminophen-containing products in 2012.Acetaminophen is safe when used as directed, says Edwin Kuffner, MD, McNeil vice president of over-the-counter medical affairs. But, when too much is taken, it can cause liver damage.The action is intended to cut the risk of such accidental overdoses, the company says in a news release.','1','0',12,23);

INSERT INTO resync_co_compr_part_rle_type_3(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(500,510),'F',2010,'f','b','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child','2001-12-25 02:22:11','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child',generate_series(2500,2516),'2011-10-12','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child The type integer is the usual choice, as it offers the best balance between range, storage size, and performance The type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer is the usual choice, as it offers the best balance between range, storage size, and performanceThe type integer ','1134.26',311353,generate_series(3982,3992),7885,'0101','2002-02-12 01:31:14+1344','2003-11-14 01:41:15','((1,1),(0,1),(1,1))','((2,1)(1,5))','08:00:2b:01:01:03','1-3','Some students may need time to adjust to school.For most children, the adjustment is quick. Tears will usually disappear after Mommy and  Daddy leave the classroom. Do not plead with your child The types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges. The types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges. Attempts to store values outside of the allowed range will result in an errorThe types smallint, integer, and bigint store whole numbers, that is, numbers without fractional components, of various ranges.','((6,5)(4,2))','(3,6)',12.233,'((5,4),2)',12,3114,'(1,1,0,3)','2010-03-21',43164,'$1,500.00','192.167.2','126.1.1.1','10:30:55','Parents and other family members are always welcome at Stratford. After the first two weeks ofschool','0','1',33,44);



--
-- Create the tables to do the exchange partition
--

CREATE TABLE resync_exch_part3_compr_1 (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int) WITH (appendonly=true, orientation=column) distributed randomly;

INSERT INTO  resync_exch_part3_compr_1(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from resync_co_compr_part_rle_type_1 where  a1=10;

CREATE TABLE resync_exch_part3_compr_2 (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int) WITH (appendonly=true, orientation=column) distributed randomly;

INSERT INTO  resync_exch_part3_compr_2(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from resync_co_compr_part_rle_type_2 where  a1=10;

CREATE TABLE resync_exch_part3_compr_3 (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int) WITH (appendonly=true, orientation=column) distributed randomly;

INSERT INTO  resync_exch_part3_compr_3(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from resync_co_compr_part_rle_type_3 where  a1=10;


--sync1 table

--Alter table Add Partition 
ALTER TABLE sync1_co_compr_part_rle_type_6 add partition new_p values('C') ;

ALTER TABLE sync1_co_compr_part_rle_type_6 add default partition df_p ;

--Alter table exchange partition
ALTER TABLE sync1_co_compr_part_rle_type_6 alter partition p2 exchange partition FOR (RANK(1)) with table sync1_exch_part3_compr_6 ;

--Alter table split partition
ALTER TABLE sync1_co_compr_part_rle_type_6 alter partition p1 split partition FOR (RANK(1)) at(505) into (partition sync1_6_splita,partition sync1_6_splitb) ;

--Alter table Drop partition
ALTER TABLE sync1_co_compr_part_rle_type_6 drop partition new_p;
ALTER TABLE sync1_co_compr_part_rle_type_6 drop default partition;

INSERT INTO sync1_co_compr_part_rle_type_6(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from sync1_co_compr_part_rle_type_6 where  a1=500;

SELECT count(*) from sync1_co_compr_part_rle_type_6;

--Drop table 
DROP table sync1_co_compr_part_rle_type_6 cascade;   

DROP table sync1_exch_part3_compr_6 cascade;


--ck_sync1 table


--Alter table Add Partition 
ALTER TABLE ck_sync1_co_compr_part_rle_type_5 add partition new_p values('C') ;

ALTER TABLE ck_sync1_co_compr_part_rle_type_5 add default partition df_p ;

--Alter table exchange partition
ALTER TABLE ck_sync1_co_compr_part_rle_type_5 alter partition p2 exchange partition FOR (RANK(1)) with table ck_sync1_exch_part3_compr_5 ;

--Alter table split partition
ALTER TABLE ck_sync1_co_compr_part_rle_type_5 alter partition p1 split partition FOR (RANK(1)) at(505) into (partition ck_sync1_5_splita,partition ck_sync1_5_splitb) ;

--Alter table Drop partition
ALTER TABLE ck_sync1_co_compr_part_rle_type_5 drop partition new_p;
ALTER TABLE ck_sync1_co_compr_part_rle_type_5 drop default partition;

INSERT INTO ck_sync1_co_compr_part_rle_type_5(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from ck_sync1_co_compr_part_rle_type_5 where  a1=500;

SELECT count(*) from ck_sync1_co_compr_part_rle_type_5;

--Drop table 
DROP table ck_sync1_co_compr_part_rle_type_5 cascade;   

DROP table  ck_sync1_exch_part3_compr_5  cascade;


--ct table


--Alter table Add Partition 
ALTER TABLE ct_co_compr_part_rle_type_3 add partition new_p values('C') ;

ALTER TABLE ct_co_compr_part_rle_type_3 add default partition df_p ;

--Alter table exchange partition
ALTER TABLE ct_co_compr_part_rle_type_3 alter partition p2 exchange partition FOR (RANK(1)) with table ct_exch_part3_compr_3 ;

--Alter table split partition
ALTER TABLE ct_co_compr_part_rle_type_3 alter partition p1 split partition FOR (RANK(1)) at(505) into (partition ct_3_splita,partition ct_3_splitb) ;

--Alter table Drop partition
ALTER TABLE ct_co_compr_part_rle_type_3 drop partition new_p;
ALTER TABLE ct_co_compr_part_rle_type_3 drop default partition;

INSERT INTO ct_co_compr_part_rle_type_3(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from ct_co_compr_part_rle_type_3 where  a1=500;

SELECT count(*) from ct_co_compr_part_rle_type_3;

--Drop table 
DROP table ct_co_compr_part_rle_type_3 cascade;   

DROP table ct_exch_part3_compr_3  cascade;


--resync table


--Alter table Add Partition 
ALTER TABLE resync_co_compr_part_rle_type_1 add partition new_p values('C') ;

ALTER TABLE resync_co_compr_part_rle_type_1 add default partition df_p ;

--Alter table exchange partition
ALTER TABLE resync_co_compr_part_rle_type_1 alter partition p2 exchange partition FOR (RANK(1)) with table resync_exch_part3_compr_1 ;

--Alter table split partition
ALTER TABLE resync_co_compr_part_rle_type_1 alter partition p1 split partition FOR (RANK(1)) at(505) into (partition resync_1_splita,partition resync_1_splitb) ;

--Alter table Drop partition
ALTER TABLE resync_co_compr_part_rle_type_1 drop partition new_p;
ALTER TABLE resync_co_compr_part_rle_type_1 drop default partition;

INSERT INTO resync_co_compr_part_rle_type_1(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from resync_co_compr_part_rle_type_1 where  a1=500;

SELECT count(*) from resync_co_compr_part_rle_type_1;

--Drop table 
DROP table resync_co_compr_part_rle_type_1 cascade;  

DROP table resync_exch_part3_compr_1  cascade;
