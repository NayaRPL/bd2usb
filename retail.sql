Microsoft Windows [Version 10.0.22000.1455]
(c) Microsoft Corporation. All rights reserved.

C:\Users\LENOVO>cd "C:\Program Files\PostgreSQL\14\bin"

C:\Program Files\PostgreSQL\14\bin>psql -U postgres -h
psql: option requires an argument -- h
Try "psql --help" for more information.

C:\Program Files\PostgreSQL\14\bin>psql -U postgres -h
psql: option requires an argument -- h
Try "psql --help" for more information.

C:\Program Files\PostgreSQL\14\bin>psql -U postgres -h localhost
Password for user postgres:
psql (14.7)
WARNING: Console code page (437) differs from Windows code page (1252)
         8-bit characters might not work correctly. See psql reference
         page "Notes for Windows users" for details.
Type "help" for help.

postgres=# \list
                                             List of databases
   Name    |  Owner   | Encoding |        Collate         |         Ctype          |   Access privileges
-----------+----------+----------+------------------------+------------------------+-----------------------
 postgres  | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 |
 template0 | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 | =c/postgres          +
           |          |          |                        |                        | postgres=CTc/postgres
 template1 | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 | =c/postgres          +
           |          |          |                        |                        | postgres=CTc/postgres
(3 rows)


postgres=# create database retail;
CREATE DATABASE
postgres=# \list
                                             List of databases
   Name    |  Owner   | Encoding |        Collate         |         Ctype          |   Access privileges
-----------+----------+----------+------------------------+------------------------+-----------------------
 postgres  | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 |
 retail    | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 |
 template0 | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 | =c/postgres          +
           |          |          |                        |                        | postgres=CTc/postgres
 template1 | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 | =c/postgres          +
           |          |          |                        |                        | postgres=CTc/postgres
(4 rows)


retail=# create table karyawan (id_karyawan integer primary key,nama_kar varchar(50), alamat varchar(50),no_telp varchar(14));
CREATE TABLE
retail=# \d barang;
Did not find any relation named "barang".
retail=# \d karyawan;
                       Table "public.karyawan"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 id_karyawan | integer               |           | not null |
 nama_kar    | character varying(50) |           |          |
 alamat      | character varying(50) |           |          |
 no_telp     | character varying(14) |           |          |
Indexes:
    "karyawan_pkey" PRIMARY KEY, btree (id_karyawan)


retail=# create table costomer (id_cust integer primary key,id_karyawan integer ,nama_cust varchar(50), alamat varchar(50), no_telp varchar(14),FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan));
CREATE TABLE
retail=# \d costomer;
                       Table "public.costomer"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 id_cust     | integer               |           | not null |
 id_karyawan | integer               |           |          |
 nama_cust   | character varying(50) |           |          |
 alamat      | character varying(50) |           |          |
 no_telp     | character varying(14) |           |          |
Indexes:
    "costomer_pkey" PRIMARY KEY, btree (id_cust)
Foreign-key constraints:
    "costomer_id_karyawan_fkey" FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)

retail=# \d karyawan;
                       Table "public.karyawan"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 id_karyawan | integer               |           | not null |
 nama_kar    | character varying(50) |           |          |
 alamat      | character varying(50) |           |          |
 no_telp     | character varying(14) |           |          |
Indexes:
    "karyawan_pkey" PRIMARY KEY, btree (id_karyawan)
Referenced by:
    TABLE "costomer" CONSTRAINT "costomer_id_karyawan_fkey" FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)


retail=# create table barang (kode_barang varchar(20) primary key,nama_barang varchar(50),stok_barang integer,harga_jual integer, harga_beli integer);
CREATE TABLE
retail=# \d barang;
                        Table "public.barang"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 kode_barang | character varying(20) |           | not null |
 nama_barang | character varying(50) |           |          |
 stok_barang | integer               |           |          |
 harga_jual  | integer               |           |          |
 harga_beli  | integer               |           |          |
Indexes:
    "barang_pkey" PRIMARY KEY, btree (kode_barang)


retail=# create table transaksi (id_beli varchar(20) primary key,id_cust integer,tgl_beli date ,kode_barang varchar(20), total_barang integer,total_jual integer,FOREIGN KEY(id_cust) REFERENCES costomer (id_cust),FOREIGN KEY(kode_barang) REFERENCES barang (kode_barang));
CREATE TABLE
retail=# \d transaksi;
                       Table "public.transaksi"
    Column    |         Type          | Collation | Nullable | Default
--------------+-----------------------+-----------+----------+---------
 id_beli      | character varying(20) |           | not null |
 id_cust      | integer               |           |          |
 tgl_beli     | date                  |           |          |
 kode_barang  | character varying(20) |           |          |
 total_barang | integer               |           |          |
 total_jual   | integer               |           |          |
Indexes:
    "transaksi_pkey" PRIMARY KEY, btree (id_beli)
Foreign-key constraints:
    "transaksi_id_cust_fkey" FOREIGN KEY (id_cust) REFERENCES costomer(id_cust)
    "transaksi_kode_barang_fkey" FOREIGN KEY (kode_barang) REFERENCES barang(kode_barang)


retail=# insert into karyawan(id_karyawan,nama_kar,alamat,no_telp) values (126228,'Iksan','Polewali','085921254662'),(126229,'Anwar','Polewali','08592125466'),(126226,'Lisa','Tande','085923254662'),(127228,'dina','tande','085931254662'),(136228,'Fika','majene','085921274662');
INSERT 0 5
retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat  |   no_telp
-------------+----------+----------+--------------
      126228 | Iksan    | Polewali | 085921254662
      126229 | Anwar    | Polewali | 08592125466
      126226 | Lisa     | Tande    | 085923254662
      127228 | dina     | tande    | 085931254662
      136228 | Fika     | majene   | 085921274662
(5 rows)


retail=# insert into karyawan(id_karyawan,nama_kar,alamat,no_telp) values (126218,'lina','makassar','081921254662'),(126239,'dia','Polewali','08594125466'),(126246,'tika','majene','085923254662'),(127258,'salsa','tande','085931254662'),(136268,'nina','polewali','085921274662');
INSERT 0 5
retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat  |   no_telp
-------------+----------+----------+--------------
      126228 | Iksan    | Polewali | 085921254662
      126229 | Anwar    | Polewali | 08592125466
      126226 | Lisa     | Tande    | 085923254662
      127228 | dina     | tande    | 085931254662
      136228 | Fika     | majene   | 085921274662
      126218 | lina     | makassar | 081921254662
      126239 | dia      | Polewali | 08594125466
      126246 | tika     | majene   | 085923254662
      127258 | salsa    | tande    | 085931254662
      136268 | nina     | polewali | 085921274662
(10 rows)

retail=# insert into karyawan(id_karyawan,nama_kar,alamat,no_telp) values (126278,'Luna','makassar','085921254662'),(126289,'dian','mamuju','08592125466'),(126296,'tila','tinambung','085921254662'),(127208,'andre','tande','085931254662'),(136118,'mita','majene','085921274662');
INSERT 0 5
retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat   |   no_telp
-------------+----------+-----------+--------------
      126228 | Iksan    | Polewali  | 085921254662
      126229 | Anwar    | Polewali  | 08592125466
      126226 | Lisa     | Tande     | 085923254662
      127228 | dina     | tande     | 085931254662
      136228 | Fika     | majene    | 085921274662
      126218 | lina     | makassar  | 081921254662
      126239 | dia      | Polewali  | 08594125466
      126246 | tika     | majene    | 085923254662
      127258 | salsa    | tande     | 085931254662
      136268 | nina     | polewali  | 085921274662
      126278 | Luna     | makassar  | 085921254662
      126289 | dian     | mamuju    | 08592125466
      126296 | tila     | tinambung | 085921254662
      127208 | andre    | tande     | 085931254662
      136118 | mita     | majene    | 085921274662
(15 rows)


retail=# insert into karyawan(id_karyawan,nama_kar,alamat,no_telp) values (126128,'irfan','majene','081920254662'),(126139,'herliana','majene','08194125466'),(126146,'taslim','tande','085921254662'),(127158,'ulvi','mamuju','081931254662'),(136168,'dinda','polewali','085921274662');
INSERT 0 5
retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat   |   no_telp
-------------+----------+-----------+--------------
      126228 | Iksan    | Polewali  | 085921254662
      126229 | Anwar    | Polewali  | 08592125466
      126226 | Lisa     | Tande     | 085923254662
      127228 | dina     | tande     | 085931254662
      136228 | Fika     | majene    | 085921274662
      126218 | lina     | makassar  | 081921254662
      126239 | dia      | Polewali  | 08594125466
      126246 | tika     | majene    | 085923254662
      127258 | salsa    | tande     | 085931254662
      136268 | nina     | polewali  | 085921274662
      126278 | Luna     | makassar  | 085921254662
      126289 | dian     | mamuju    | 08592125466
      126296 | tila     | tinambung | 085921254662
      127208 | andre    | tande     | 085931254662
      136118 | mita     | majene    | 085921274662
      126128 | irfan    | majene    | 081920254662
      126139 | herliana | majene    | 08194125466
      126146 | taslim   | tande     | 085921254662
      127158 | ulvi     | mamuju    | 081931254662
      136168 | dinda    | polewali  | 085921274662
(20 rows)
retail=# insert into karyawan(id_karyawan,nama_kar,alamat,no_telp) values (126178,'chair','polewali','081920154662'),(126189,'wati','majene','08194125166'),(126196,'vidya','tande','085921454662'),(127108,'kifli','mamuju','081921254662'),(136318,'idawati','polewali','085921274662');
INSERT 0 5
retail=# insert into karyawan(id_karyawan,nama_kar,alamat,no_telp) values (126170,'yanti','polewali','081920154662'),(126180,'nurul','majene','08194125166'),(126190,'cahaya','tinambung','085941454662'),(127100,'andi','tande','081921254662'),(136310,'anggun','majene','085921274662');
INSERT 0 5
retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat   |   no_telp
-------------+----------+-----------+--------------
      126228 | Iksan    | Polewali  | 085921254662
      126229 | Anwar    | Polewali  | 08592125466
      126226 | Lisa     | Tande     | 085923254662
      127228 | dina     | tande     | 085931254662
      136228 | Fika     | majene    | 085921274662
      126218 | lina     | makassar  | 081921254662
      126239 | dia      | Polewali  | 08594125466
      126246 | tika     | majene    | 085923254662
      127258 | salsa    | tande     | 085931254662
      136268 | nina     | polewali  | 085921274662
      126278 | Luna     | makassar  | 085921254662
      126289 | dian     | mamuju    | 08592125466
      126296 | tila     | tinambung | 085921254662
      127208 | andre    | tande     | 085931254662
      136118 | mita     | majene    | 085921274662
      126128 | irfan    | majene    | 081920254662
      126139 | herliana | majene    | 08194125466
      126146 | taslim   | tande     | 085921254662
      127158 | ulvi     | mamuju    | 081931254662
      136168 | dinda    | polewali  | 085921274662
      126178 | chair    | polewali  | 081920154662
      126189 | wati     | majene    | 08194125166
      126196 | vidya    | tande     | 085921454662
      127108 | kifli    | mamuju    | 081921254662
      136318 | idawati  | polewali  | 085921274662
      126170 | yanti    | polewali  | 081920154662
      126180 | nurul    | majene    | 08194125166
      126190 | cahaya   | tinambung | 085941454662
      127100 | andi     | tande     | 081921254662
      136310 | anggun   | majene    | 085921274662
(30 rows)

retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat   |   no_telp
-------------+----------+-----------+--------------
      126228 | Iksan    | Polewali  | 085921254662
      126229 | Anwar    | Polewali  | 08592125466
      126226 | Lisa     | Tande     | 085923254662
      127228 | dina     | tande     | 085931254662
      136228 | Fika     | majene    | 085921274662
      126218 | lina     | makassar  | 081921254662
      126239 | dia      | Polewali  | 08594125466
      126246 | tika     | majene    | 085923254662
      127258 | salsa    | tande     | 085931254662
      136268 | nina     | polewali  | 085921274662
      126278 | Luna     | makassar  | 085921254662
      126289 | dian     | mamuju    | 08592125466
      126296 | tila     | tinambung | 085921254662
      127208 | andre    | tande     | 085931254662
      136118 | mita     | majene    | 085921274662
      126128 | irfan    | majene    | 081920254662
      126139 | herliana | majene    | 08194125466
      126146 | taslim   | tande     | 085921254662
      127158 | ulvi     | mamuju    | 081931254662
      136168 | dinda    | polewali  | 085921274662
      126178 | chair    | polewali  | 081920154662
      126189 | wati     | majene    | 08194125166
      126196 | vidya    | tande     | 085921454662
      127108 | kifli    | mamuju    | 081921254662
      136318 | idawati  | polewali  | 085921274662
      126170 | yanti    | polewali  | 081920154662
      126180 | nurul    | majene    | 08194125166
      126190 | cahaya   | tinambung | 085941454662
      127100 | andi     | tande     | 081921254662
      136310 | anggun   | majene    | 085921274662
(30 rows)


retail=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | barang    | table | postgres
 public | costomer  | table | postgres
 public | karyawan  | table | postgres
 public | transaksi | table | postgres
(4 rows)


retail=# \d costomer;
                       Table "public.costomer"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 id_cust     | integer               |           | not null |
 id_karyawan | integer               |           |          |
 nama_cust   | character varying(50) |           |          |
 alamat      | character varying(50) |           |          |
 no_telp     | character varying(14) |           |          |
Indexes:
    "costomer_pkey" PRIMARY KEY, btree (id_cust)
Foreign-key constraints:
    "costomer_id_karyawan_fkey" FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)
Referenced by:
    TABLE "transaksi" CONSTRAINT "transaksi_id_cust_fkey" FOREIGN KEY (id_cust) REFERENCES costomer(id_cust)


retail=# insert into costomer (id_cust,id_karyawan,nama_cust,alamat,no_telp) values(1,126228,'Nurul Inayah','Majene','082312011590'),
retail-# insert into costomer (id_cust,id_karyawan,nama_cust,alamat,no_telp) values(1,126228,'Nurul Inayah','Majene','082312011590');
retail=# select * from karyawan;
 id_karyawan | nama_kar |  alamat   |   no_telp
-------------+----------+-----------+--------------
      126228 | Iksan    | Polewali  | 085921254662
      126229 | Anwar    | Polewali  | 08592125466
      126226 | Lisa     | Tande     | 085923254662
      127228 | dina     | tande     | 085931254662
      136228 | Fika     | majene    | 085921274662
      126218 | lina     | makassar  | 081921254662
      126239 | dia      | Polewali  | 08594125466
      126246 | tika     | majene    | 085923254662
      127258 | salsa    | tande     | 085931254662
      136268 | nina     | polewali  | 085921274662
      126278 | Luna     | makassar  | 085921254662
      126289 | dian     | mamuju    | 08592125466
      126296 | tila     | tinambung | 085921254662
      127208 | andre    | tande     | 085931254662
      136118 | mita     | majene    | 085921274662
      126128 | irfan    | majene    | 081920254662
      126139 | herliana | majene    | 08194125466
      126146 | taslim   | tande     | 085921254662
      127158 | ulvi     | mamuju    | 081931254662
      136168 | dinda    | polewali  | 085921274662
      126178 | chair    | polewali  | 081920154662
      126189 | wati     | majene    | 08194125166
      126196 | vidya    | tande     | 085921454662
      127108 | kifli    | mamuju    | 081921254662
      136318 | idawati  | polewali  | 085921274662
      126170 | yanti    | polewali  | 081920154662
      126180 | nurul    | majene    | 08194125166
      126190 | cahaya   | tinambung | 085941454662
      127100 | andi     | tande     | 081921254662
      136310 | anggun   | majene    | 085921274662
(30 rows)


retail=# insert into costomer (id_cust,id_karyawan,nama_cust,alamat,no_telp) values(1,136268,'Nurul Inayah','Majene','082312011590'),(2, 126189,'Siti Nurhalizah','Majene','082312021590'),(3, 126189,'Awaluddin','Tande','081312011590'),(4,136318,'Nurmadina','Tinambung','082332011590'),(5,136318,'Nurlina','Polewali','08231211590');
INSERT 0 5
retail=# insert into costomer (id_cust,id_karyawan,nama_cust,alamat,no_telp) values(6,126170,'Siti Lutfiah','Majene','082312011590'),(7, 126189,'Siti','Polewali','082312021590'),(8,127108,'Sukma','Tande','081312011590'),(9,127108,'Nurmadina','Tinambung','082332011590'),(10,127108,'anggun','Polewali','08231211590');
INSERT 0 5
retail=# insert into costomer (id_cust,id_karyawan,nama_cust,alamat,no_telp) values(11,126170,'Elisa','Polewali','082312011590'),(12, 126189,'Fitra','Polewali','082312021590'),(13,127108,'IdaWati','Tande','081312011590'),(14,127108,'hendrik','Tinambung','082332011590'),(15,127108,'Elda','Polewali','08231211590');
INSERT 0 5
retail=# insert into costomer (id_cust,id_karyawan,nama_cust,alamat,no_telp) values(26,126170,'andi','makassar','082312041590'),(27, 126189,'nanda','Majene','082312021590'),(28,136310,'akmal','Majene','081312011590'),(29,136310,'Nopri','Tinambung','082332011590'),(30, 126190,'Ibnu','Polewali','08231211590');
INSERT 0 5
retail=# select * from costomer;
 id_cust | id_karyawan |    nama_cust    |  alamat   |   no_telp
---------+-------------+-----------------+-----------+--------------
       1 |      136268 | Nurul Inayah    | Majene    | 082312011590
       2 |      126189 | Siti Nurhalizah | Majene    | 082312021590
       3 |      126189 | Awaluddin       | Tande     | 081312011590
       4 |      136318 | Nurmadina       | Tinambung | 082332011590
       5 |      136318 | Nurlina         | Polewali  | 08231211590
       6 |      126170 | Siti Lutfiah    | Majene    | 082312011590
       7 |      126189 | Siti            | Polewali  | 082312021590
       8 |      127108 | Sukma           | Tande     | 081312011590
       9 |      127108 | Nurmadina       | Tinambung | 082332011590
      10 |      127108 | anggun          | Polewali  | 08231211590
      11 |      126170 | Elisa           | Polewali  | 082312011590
      12 |      126189 | Fitra           | Polewali  | 082312021590
      13 |      127108 | IdaWati         | Tande     | 081312011590
      14 |      127108 | hendrik         | Tinambung | 082332011590
      15 |      127108 | Elda            | Polewali  | 08231211590
      16 |      126170 | Sukmawati       | Polewali  | 082312041590
      17 |      126189 | Febi            | Majene    | 082312021590
      18 |      136318 | Taslim          | Majene    | 081312011590
      19 |      136310 | Kifli           | Tinambung | 082332011590
      20 |      126190 | Tafsir          | Polewali  | 08231211590
      21 |      126170 | mawati          | Polewali  | 082312041590
      22 |      126189 | ebi             | Majene    | 082312021590
      23 |      136310 | lim             | Majene    | 081312011590
      24 |      136310 | Kili            | Tinambung | 082332011590
      25 |      126190 | Tasir           | Polewali  | 08231211590
      26 |      126170 | andi            | makassar  | 082312041590
      27 |      126189 | nanda           | Majene    | 082312021590
      28 |      136310 | akmal           | Majene    | 081312011590
      29 |      136310 | Nopri           | Tinambung | 082332011590
      30 |      126190 | Ibnu            | Polewali  | 08231211590
(30 rows)


retail=# \d barang;
                        Table "public.barang"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 kode_barang | character varying(20) |           | not null |
 nama_barang | character varying(50) |           |          |
 stok_barang | integer               |           |          |
 harga_jual  | integer               |           |          |
 harga_beli  | integer               |           |          |
Indexes:
    "barang_pkey" PRIMARY KEY, btree (kode_barang)
Referenced by:
    TABLE "transaksi" CONSTRAINT "transaksi_kode_barang_fkey" FOREIGN KEY (kode_barang) REFERENCES barang(kode_barang)


retail=# insert into barang (kode_barang,nama_barang,stok_barang,harga_jual,harga_beli) values ('DD1','buku_jurnal',5,25000,23000),('DD2','buku_kuintansi',10,5000,2000),('DD3','kertas_karton',10,3000,15000),('DD4','tempat_pensil',5,25000,23000),('DD5','gunting',3,5000,3000);
INSERT 0 5
retail=# insert into barang (kode_barang,nama_barang,stok_barang,harga_jual,harga_beli) values ('DD6','buku_gambar',10,5000,2000),('DD7','lem_fox',7,7000,5000),('DD8','klip_tembak',5,25000,20000),('DD9','Binder',5,5000,3000),('DD10','mading',10,5000,2000);
INSERT 0 5
retail=# insert into barang (kode_barang,nama_barang,stok_barang,harga_jual,harga_beli) values ('DD11','sticky_note',7,12000,8000),('DD12','lem',5,12000,10000),('DD13','Penggaris',5,5000,3000),('DD14','eraser',10,5000,2000),('DD15','pensil_warna',7,7000,5000);
INSERT 0 5
retail=# insert into barang (kode_barang,nama_barang,stok_barang,harga_jual,harga_beli) values ('DD16','Stella',8,12000,8000),('DD17','botol',5,10000,6000),('DD18','Colokan',5,12000,10000),('DD19','StopKontak',10,5000,2000),('DD20','pensil',7,7000,5000);
INSERT 0 5
retail=# insert into barang (kode_barang,nama_barang,stok_barang,harga_jual,harga_beli) values ('DD21','Kursi',20,50000,35000),('DD22','meja',5,50000,40000),('DD23','Polpen',5,5000,2000),('DD24','Kaca',10,12000,7000),('DD25','sendok',12,5000,2000);
INSERT 0 5
retail=# insert into barang (kode_barang,nama_barang,stok_barang,harga_jual,harga_beli) values ('DD26','',20,50000,35000),('DD27','meja',5,50000,40000),('DD28','Polpen',5,5000,2000),('DD29','Kaca',10,12000,7000),('DD30','sendok',12,5000,2000);
INSERT 0 5
retail=# \d barang;
                        Table "public.barang"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 kode_barang | character varying(20) |           | not null |
 nama_barang | character varying(50) |           |          |
 stok_barang | integer               |           |          |
 harga_jual  | integer               |           |          |
 harga_beli  | integer               |           |          |
Indexes:
    "barang_pkey" PRIMARY KEY, btree (kode_barang)
Referenced by:
    TABLE "transaksi" CONSTRAINT "transaksi_kode_barang_fkey" FOREIGN KEY (kode_barang) REFERENCES barang(kode_barang)


retail=# select * from barang;
 kode_barang |  nama_barang   | stok_barang | harga_jual | harga_beli
-------------+----------------+-------------+------------+------------
 DD1         | buku_jurnal    |           5 |      25000 |      23000
 DD2         | buku_kuintansi |          10 |       5000 |       2000
 DD3         | kertas_karton  |          10 |       3000 |      15000
 DD4         | tempat_pensil  |           5 |      25000 |      23000
 DD5         | gunting        |           3 |       5000 |       3000
 DD6         | buku_gambar    |          10 |       5000 |       2000
 DD7         | lem_fox        |           7 |       7000 |       5000
 DD8         | klip_tembak    |           5 |      25000 |      20000
 DD9         | Binder         |           5 |       5000 |       3000
 DD10        | mading         |          10 |       5000 |       2000
 DD11        | sticky_note    |           7 |      12000 |       8000
 DD12        | lem            |           5 |      12000 |      10000
 DD13        | Penggaris      |           5 |       5000 |       3000
 DD14        | eraser         |          10 |       5000 |       2000
 DD15        | pensil_warna   |           7 |       7000 |       5000
 DD16        | Stella         |           8 |      12000 |       8000
 DD17        | botol          |           5 |      10000 |       6000
 DD18        | Colokan        |           5 |      12000 |      10000
 DD19        | StopKontak     |          10 |       5000 |       2000
 DD20        | pensil         |           7 |       7000 |       5000
 DD21        | Kursi          |          20 |      50000 |      35000
 DD22        | meja           |           5 |      50000 |      40000
 DD23        | Polpen         |           5 |       5000 |       2000
 DD24        | Kaca           |          10 |      12000 |       7000
 DD25        | sendok         |          12 |       5000 |       2000
 DD26        |                |          20 |      50000 |      35000
 DD27        | meja           |           5 |      50000 |      40000
 DD28        | Polpen         |           5 |       5000 |       2000
 DD29        | Kaca           |          10 |      12000 |       7000
 DD30        | sendok         |          12 |       5000 |       2000
(30 rows)


retail=# insert into transaksi(id_beli,id_cust,tgl_beli,kode_barang,total_barang,total_jual) values ('TR1',1,now(),'DD1',2,10000),('TR2',2,now(),'DD2',2,10000),('TR3',1,now(),'DD3',2,10000),('TR4',1,now(),'DD4',2,10000),('TR5',1,now(),'DD3',2,10000),('TR6',1,now(),'DD5',2,10000),('TR7',1,now(),'DD7',2,10000),('TR8',1,now(),'DD10',2,10000),('TR9',1,now(),'DD2',2,10000),('TR10',1,now(),'DD8',2,10000);
INSERT 0 10
retail=# insert into transaksi(id_beli,id_cust,tgl_beli,kode_barang,total_barang,total_jual) values ('TR11',5,now(),'DD1',2,10000),('TR12',2,now(),'DD5',2,10000),('TR13',1,now(),'DD4',2,10000),('TR14',1,now(),'DD4',2,10000),('TR15',1,now(),'DD3',2,10000),('TR16',1,now(),'DD6',2,10000),('TR17',1,now(),'DD7',2,10000),('TR18',1,now(),'DD11',2,10000),('TR19',1,now(),'DD4',2,10000),('TR20',1,now(),'DD8',2,10000);
INSERT 0 10
retail=# insert into transaksi(id_beli,id_cust,tgl_beli,kode_barang,total_barang,total_jual) values ('TR21',5,now(),'DD6',2,10000),('TR22',2,now(),'DD7',2,10000),('TR23',1,now(),'DD4',2,10000),('TR24',1,now(),'DD4',2,10000),('TR25',1,now(),'DD3',2,10000),('TR26',1,now(),'DD6',2,10000),('TR27',1,now(),'DD1',2,10000),('TR28',1,now(),'DD21',2,10000),('TR29',1,now(),'DD4',2,10000),('TR30',1,now(),'DD3',2,10000);
INSERT 0 10
retail=# select * from transaksi;
 id_beli | id_cust |  tgl_beli  | kode_barang | total_barang | total_jual
---------+---------+------------+-------------+--------------+------------
 TR1     |       1 | 2023-02-20 | DD1         |            2 |      10000
 TR2     |       2 | 2023-02-20 | DD2         |            2 |      10000
 TR3     |       1 | 2023-02-20 | DD3         |            2 |      10000
 TR4     |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR5     |       1 | 2023-02-20 | DD3         |            2 |      10000
 TR6     |       1 | 2023-02-20 | DD5         |            2 |      10000
 TR7     |       1 | 2023-02-20 | DD7         |            2 |      10000
 TR8     |       1 | 2023-02-20 | DD10        |            2 |      10000
 TR9     |       1 | 2023-02-20 | DD2         |            2 |      10000
 TR10    |       1 | 2023-02-20 | DD8         |            2 |      10000
 TR11    |       5 | 2023-02-20 | DD1         |            2 |      10000
 TR12    |       2 | 2023-02-20 | DD5         |            2 |      10000
 TR13    |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR14    |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR15    |       1 | 2023-02-20 | DD3         |            2 |      10000
 TR16    |       1 | 2023-02-20 | DD6         |            2 |      10000
 TR17    |       1 | 2023-02-20 | DD7         |            2 |      10000
 TR18    |       1 | 2023-02-20 | DD11        |            2 |      10000
 TR19    |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR20    |       1 | 2023-02-20 | DD8         |            2 |      10000
 TR21    |       5 | 2023-02-20 | DD6         |            2 |      10000
 TR22    |       2 | 2023-02-20 | DD7         |            2 |      10000
 TR23    |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR24    |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR25    |       1 | 2023-02-20 | DD3         |            2 |      10000
 TR26    |       1 | 2023-02-20 | DD6         |            2 |      10000
 TR27    |       1 | 2023-02-20 | DD1         |            2 |      10000
 TR28    |       1 | 2023-02-20 | DD21        |            2 |      10000
 TR29    |       1 | 2023-02-20 | DD4         |            2 |      10000
 TR30    |       1 | 2023-02-20 | DD3         |            2 |      10000
(30 rows)


retail=# create table DetailPembelian (id_beli varchar(20) , kode_barang varchar(20),FOREIGN KEY (id_beli) REFERENCES transaksi,FOREIGN KEY (id_beli) REFERENCES transaksi);
CREATE TABLE
retail=# \d DetailPembelian;
                    Table "public.detailpembelian"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 id_beli     | character varying(20) |           |          |
 kode_barang | character varying(20) |           |          |
Foreign-key constraints:
    "detailpembelian_id_beli_fkey" FOREIGN KEY (id_beli) REFERENCES transaksi(id_beli)
    "detailpembelian_id_beli_fkey1" FOREIGN KEY (id_beli) REFERENCES transaksi(id_beli)


retail=# insert into DetailPembelian (id_beli,kode_barang) values ('TR1','DD1'),('TR2','DD2'),('TR3','DD3'),('TR4','DD4'),('TR5','DD5'),('TR6','DD5'),('TR7','DD7'),('TR8','DD10'),('TR9','DD2'),('TR10','DD8'),('TR11','DD1'),('TR12','DD5'),('TR13','DD4'),('TR15','DD3'),('TR16','DD6'),('TR17','DD7'),('TR19','DD4'),('TR20','DD8'),('TR21','DD6'),('TR22','DD7'),('TR23','DD4'),('TR24','DD4'),('TR25','DD3'),('TR26','DD6'),('TR27','DD1'),('TR28','DD1'),('TR29','DD4'),('TR30','DD3');
INSERT 0 28
retail=# select * from DetailPembelian;
 id_beli | kode_barang
---------+-------------
 TR1     | DD1
 TR2     | DD2
 TR3     | DD3
 TR4     | DD4
 TR5     | DD5
 TR6     | DD5
 TR7     | DD7
 TR8     | DD10
 TR9     | DD2
 TR10    | DD8
 TR11    | DD1
 TR12    | DD5
 TR13    | DD4
 TR15    | DD3
 TR16    | DD6
 TR17    | DD7
 TR19    | DD4
 TR20    | DD8
 TR21    | DD6
 TR22    | DD7
 TR23    | DD4
 TR24    | DD4
 TR25    | DD3
 TR26    | DD6
 TR27    | DD1
 TR28    | DD1
 TR29    | DD4
 TR30    | DD3
(28 rows)


retail=# insert into DetailPembelian (id_beli,kode_barang) values ('TR14','DD4'),('TR18','DD11');
INSERT 0 2
retail=# select * from DetailPembelian;
 id_beli | kode_barang
---------+-------------
 TR1     | DD1
 TR2     | DD2
 TR3     | DD3
 TR4     | DD4
 TR5     | DD5
 TR6     | DD5
 TR7     | DD7
 TR8     | DD10
 TR9     | DD2
 TR10    | DD8
 TR11    | DD1
 TR12    | DD5
 TR13    | DD4
 TR15    | DD3
 TR16    | DD6
 TR17    | DD7
 TR19    | DD4
 TR20    | DD8
 TR21    | DD6
 TR22    | DD7
 TR23    | DD4
 TR24    | DD4
 TR25    | DD3
 TR26    | DD6
 TR27    | DD1
 TR28    | DD1
 TR29    | DD4
 TR30    | DD3
 TR14    | DD4
 TR18    | DD11 