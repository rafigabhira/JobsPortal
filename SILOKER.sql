/*Catatan : Insert Online Course dulu, baru HISTORY_OC
*/

CREATE SCHEMA SILOKER;

SET SEARCH_PATH TO SILOKER;

CREATE TABLE company (
    no_akta character varying(20) NOT NULL,
    namacompany character varying(100) NOT NULL,
    no_telp character varying(12) NOT NULL,
    nama_jalan character varying(100) NOT NULL,
    provinsi character varying(30) NOT NULL,
    kota character varying(30) NOT NULL,
    kodepos character(5) NOT NULL,
    deskripsi text,
    verified_by character varying(20)
);

CREATE TABLE history_oc (
    course_id character(6) NOT NULL,
    username character varying(20) NOT NULL,
    score_test integer DEFAULT 0,
    keaktifan integer DEFAULT 0
);

CREATE TABLE kategori (
    nomor_kategori character(2) NOT NULL,
    nama_kategori character varying(100) NOT NULL
);

CREATE TABLE lowongan (
    lowongan_id character(6) NOT NULL,
    namalowongan character varying(100) NOT NULL,
    tgl_buka timestamp without time zone NOT NULL,
    tgl_tutup timestamp without time zone NOT NULL,
    company character varying(20) NOT NULL
);

CREATE TABLE online_course (
    course_id character(6) NOT NULL,
    namacourse character varying(100) NOT NULL,
    max_peserta integer NOT NULL,
    tgl_mulai timestamp without time zone NOT NULL,
    tgl_akhir timestamp without time zone NOT NULL,
    tgl_awal_daftar timestamp without time zone NOT NULL,
    tgl_akhir_daftar timestamp without time zone NOT NULL,
    kategori character(2) NOT NULL,
    penyedia character varying(20) NOT NULL,
    pembuat character varying(20) NOT NULL,
    jml_peserta integer DEFAULT 0
);

CREATE TABLE pelamaran (
    username character varying(20) NOT NULL,
    lowongan_id character(6) NOT NULL,
    posisi_id character(2) NOT NULL,
    status smallint,
    user_rating numeric(10,1)
);

CREATE TABLE pengguna_admin (
    username character varying(20) NOT NULL,
    password character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    no_ktp character(16) NOT NULL,
    tgl_lahir timestamp without time zone NOT NULL,
    no_hp character varying(12) NOT NULL,
    nama_jalan character varying(100) NOT NULL,
    provinsi character varying(30) NOT NULL,
    kota character varying(30) NOT NULL,
    kodepos character(5) NOT NULL,
    flagadmincompany boolean,
    company_pendaftar character varying(20)
);

CREATE TABLE pengguna_userumum (
    username character varying(20) NOT NULL,
    password character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    no_ktp character(16) NOT NULL,
    tgl_lahir timestamp without time zone NOT NULL,
    no_hp character varying(12) NOT NULL,
    nama_jalan character varying(100) NOT NULL,
    provinsi character varying(30) NOT NULL,
    kota character varying(30) NOT NULL,
    kodepos character(5) NOT NULL,
    cv text
);

CREATE TABLE posisi (
    lowongan_id character(6) NOT NULL,
    posisi_id character(2) NOT NULL,
    namaposisi character varying(100) NOT NULL,
    gaji numeric(10,2) NOT NULL,
    email_hrd character varying(50) NOT NULL,
    max_jml_penerima integer NOT NULL,
    jml_penerima_saatini integer DEFAULT 0
);

CREATE TABLE posisi_kualifikasi (
    lowongan_id character(6) NOT NULL,
    posisi_id character(2) NOT NULL,
    kualifikasi character varying(30) NOT NULL
);


CREATE OR REPLACE FUNCTION jumlah_penerima()
RETURNS trigger AS
$$
    DECLARE
    BEGIN
        IF(TG_OP='UPDATE') THEN
            IF(NEW.status=2) THEN
            UPDATE POSISI SET jml_penerima_saatini=jml_penerima_saatini+1
            WHERE lowongan_id=NEW.lowongan_id AND posisi_id=NEW.posisi_id ;
            END IF;
        RETURN NEW; 
        ELSIF(TG_OP='DELETE') THEN
        UPDATE POSISI SET jml_penerima_saatini=jml_penerima_saatini-1
        WHERE lowongan_id=NEW.lowongan_id AND posisi_id=NEW.posisi_id ;
        RETURN OLD; 
        END IF; 
    END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER trg_jumlah_penerima
AFTER UPDATE OR DELETE
ON PELAMARAN
for each row
EXECUTE PROCEDURE jumlah_penerima();



CREATE OR REPLACE FUNCTION jumlah_peserta()
RETURNS trigger AS
$$
        
    BEGIN

        IF(TG_OP='INSERT') THEN
        UPDATE ONLINE_COURSE SET jml_peserta=jml_peserta+1
        WHERE course_id=NEW.course_id;
        RETURN NEW;     
        
        ELSIF(TG_OP='DELETE') THEN
        UPDATE ONLINE_COURSE SET jml_peserta=jml_peserta-1
        WHERE course_id=OLD.course_id;
        RETURN OLD;     

        END IF; 
    END;

$$
LANGUAGE plpgsql;


CREATE TRIGGER trg_jumlah_peserta
AFTER INSERT OR DELETE
ON HISTORY_OC 
for each row
EXECUTE PROCEDURE jumlah_peserta();





INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('384-40-6377','Quamba','971-699-8501','Hooker','Oregon','Portland',97240,'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('340-61-3544','Brainsphere','540-990-1041','Express','Virginia','Roanoke',24034,'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('414-27-2181','Pixoboo','214-856-1457','Milwaukee','Texas','Dallas',75277,'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('514-70-0333','Blognation','701-862-8288','Ramsey','North Dakota','Bismarck',58505,'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('418-96-9133','Kazu','609-795-9454','Dorton','New Jersey','Trenton',8619,'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('167-24-5605','Zoomdog','210-419-9482','Farwell','Texas','San Antonio',78210,'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('396-52-0288','Voonyx','951-601-8021','Lakewood','California','Moreno Valley',92555,'Vestibulum ac est lacinia nisi venenatis tristique.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('515-12-2198','Quimm','504-765-4237','Welch','Louisiana','New Orleans',70142,'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('650-27-6894','Roodel','713-986-8642','Toban','Texas','Houston',77281,'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('227-72-0289','Edgeblab','713-864-5900','Elmside','Texas','Houston',77030,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('637-56-9343','Skyble','513-175-7033','Hoffman','Ohio','Cincinnati',45203,'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('718-88-0458','Skipfire','915-434-9837','Dexter','Texas','El Paso',79911,'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('379-89-0856','Tekfly','256-668-7957','Jackson','Alabama','Huntsville',35810,'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('805-29-1670','Linkbridge','260-794-4224','Debra','Indiana','Fort Wayne',46857,'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('302-90-4925','Buzzbean','865-814-2356','John Wall','Tennessee','Knoxville',37914,'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('288-27-7529','Zoovu','317-699-3501','Pleasure','Indiana','Indianapolis',46207,'Pellentesque ultrices mattis odio. Donec vitae nisi.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('361-67-7046','Yozio','405-567-0868','Logan','Oklahoma','Oklahoma City',73119,'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('680-76-6512','Oloo','408-821-9159','Schiller','California','San Jose',95118,'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('457-74-5223','Realblab','713-229-4557','Fordem','Texas','Houston',77271,'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('642-20-3885','Izio','901-310-4977','Russell','Tennessee','Memphis',38136,'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('681-07-5701','Bubblebox','352-577-0841','Sage','Florida','Spring Hill',34611,'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('851-14-6629','Eazzy','570-838-1440','Westerfield','Pennsylvania','Scranton',18505,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('303-93-5712','Jaxnation','907-458-8864','Washington','Alaska','Anchorage',99517,'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('446-82-1076','Yacero','334-874-7824','Little Fleur','Alabama','Montgomery',36177,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('653-27-4682','BlogXS','703-686-3620','Claremont','District of Columbia','Washington',20041,'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('604-54-1691','Jayo','804-803-0328','Larry','Virginia','Richmond',23237,'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('260-11-1705','Flipstorm','901-504-0715','Bartillon','Tennessee','Memphis',38131,'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('697-49-6068','Nlounge','914-951-4176','Goodland','New York','Yonkers',10705,'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('536-27-2956','Photolist','309-316-8984','Old Gate','Illinois','Carol Stream',60351,'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('272-97-6693','Meezzy','727-176-3389','Express','Florida','Clearwater',34629,'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('374-44-5115','Twitterwire','951-916-3936','Pierstorff','California','Corona',92878,'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('497-51-4605','Plajo','405-115-2525','Glendale','Oklahoma','Oklahoma City',73129,'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('334-55-3748','Vipe','225-400-6720','Sycamore','Louisiana','Baton Rouge',70810,'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('390-73-6823','Devbug','786-850-6861','Mayfield','Florida','Miami',33147,'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('799-23-8294','Jayo','423-403-1981','Namekagon','Tennessee','Chattanooga',37450,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('781-81-2233','Eayo','727-928-5999','Hovde','Florida','Saint Petersburg',33705,'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('700-52-8901','Edgeify','304-157-7435','Pawling','West Virginia','Charleston',25362,'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('243-75-7555','BlogXS','253-243-3475','Old Gate','Washington','Tacoma',98411,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('558-13-8046','Oyoba','772-697-9631','Loftsgordon','Florida','Port Saint Lucie',34985,'Nulla ut erat id mauris vulputate elementum.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('386-89-0847','Yadel','478-358-2909','Dunning','Georgia','Macon',31217,'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('404-36-4730','Jayo','775-703-4513','Norway Maple','Nevada','Carson City',89714,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('762-69-5432','Meemm','402-496-7488','Fuller','Nebraska','Lincoln',68583,'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('337-79-7379','Vitz','314-874-8103','Fairfield','Missouri','Saint Louis',63104,'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('375-99-5648','Jaxnation','860-249-6516','Fremont','Connecticut','Hartford',6120,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('178-98-9566','Bubbletube','303-299-8137','Service','Colorado','Denver',80204,'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('223-21-1692','Buzzshare','410-297-7206','Merry','Maryland','Baltimore',21275,'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('537-65-4967','Yoveo','515-838-1146','Center','Iowa','Des Moines',50330,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.','bmurch2');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('290-77-7839','Shufflester','865-250-4684','Shelley','Tennessee','Knoxville',37914,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.','wgilman0');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('329-80-2426','Yakijo','317-696-9083','Meadow Vale','Indiana','Indianapolis',46221,'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.','lvickarman1');
INSERT INTO COMPANY(no_akta,namaCompany,no_telp,nama_jalan,provinsi,kota,kodepos,deskripsi,verified_by) VALUES ('103-27-8109','Voomm','859-620-5465','Graceland','Kentucky','Lexington',40524,'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.','bmurch2');





INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('60', 'Health');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('40', 'Scrience');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('87', 'Engineering');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('39', 'Law');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('71', 'Computer');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('20', 'Medical');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('62', 'Finance');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('16', 'Psychology');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('31', 'Politics');
INSERT INTO KATEGORI(nomor_kategori, nama_kategori) VALUES ('54', 'Culture');





INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2079KU', 'Sales', '2017-12-17', '2018-02-18', '384-40-6377');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2054VJ', 'Research and Development', '2017-11-09', '2018-02-17', '340-61-3544');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3810YN', 'Accounting', '2017-12-18', '2018-01-16', '414-27-2181');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9877GF', 'Human Resources', '2017-12-28', '2018-01-29', '514-70-0333');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9557IH', 'Business Development', '2017-10-09', '2018-01-20', '418-96-9133');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9707IX', 'Accounting', '2017-09-09', '2018-02-03', '384-40-6377');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2143JI', 'Engineering', '2017-10-29', '2018-01-20', '340-61-3544');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5210OP', 'Engineering', '2017-10-12', '2018-01-13', '414-27-2181');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4373BY', 'Business Development', '2017-10-06', '2018-02-19', '514-70-0333');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8590SI', 'Research and Development', '2017-10-15', '2018-01-30', '418-96-9133');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1398GK', 'Accounting', '2017-11-20', '2018-01-17', '167-24-5605');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8243ER', 'Engineering', '2017-11-10', '2018-01-23', '396-52-0288');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0698GA', 'Product Management', '2017-12-11', '2018-02-06', '515-12-2198');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1618AD', 'Marketing', '2017-12-22', '2018-02-17', '650-27-6894');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0993SA', 'Marketing', '2017-12-26', '2018-01-07', '227-72-0289');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6245RC', 'Human Resources', '2017-11-07', '2018-03-13', '637-56-9343');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5856ZC', 'Engineering', '2017-09-26', '2018-01-26', '718-88-0458');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4278UD', 'Legal', '2017-10-03', '2018-01-12', '379-89-0856');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1826SN', 'Legal', '2017-09-25', '2018-01-23', '805-29-1670');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5401KI', 'Marketing', '2017-12-15', '2018-02-05', '302-90-4925');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0951VY', 'Legal', '2017-10-14', '2018-01-29', '288-27-7529');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9289AC', 'Sales', '2017-12-21', '2018-01-21', '361-67-7046');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6671CC', 'Accounting', '2017-12-07', '2018-01-12', '680-76-6512');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2525EV', 'Services', '2017-10-14', '2018-02-28', '457-74-5223');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9054PS', 'Marketing', '2017-09-24', '2018-01-29', '642-20-3885');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3335XI', 'Accounting', '2017-12-12', '2018-03-27', '681-07-5701');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7532PD', 'Research and Development', '2017-12-11', '2018-02-06', '851-14-6629');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7425IK', 'Legal', '2017-10-16', '2018-01-02', '303-93-5712');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2860CJ', 'Accounting', '2017-12-30', '2018-03-07', '446-82-1076');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3214EX', 'Legal', '2017-12-23', '2018-02-26', '653-27-4682');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7689QR', 'Accounting', '2017-09-29', '2018-03-07', '604-54-1691');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8985TH', 'Support', '2017-12-13', '2018-03-16', '260-11-1705');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5644PX', 'Sales', '2017-10-08', '2018-01-05', '697-49-6068');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8479DQ', 'Human Resources', '2017-11-13', '2018-01-15', '536-27-2956');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1036VC', 'Engineering', '2017-09-29', '2018-02-15', '272-97-6693');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3033TA', 'Legal', '2017-09-09', '2018-03-24', '374-44-5115');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1469RM', 'Services', '2017-12-09', '2018-03-15', '497-51-4605');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6360RW', 'Support', '2017-09-03', '2018-02-23', '334-55-3748');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3980CK', 'Marketing', '2017-11-13', '2018-02-09', '390-73-6823');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4362YW', 'Human Resources', '2017-09-16', '2018-03-02', '799-23-8294');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6570VI', 'Training', '2017-10-30', '2018-02-27', '781-81-2233');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9807PF', 'Sales', '2017-09-16', '2018-03-26', '700-52-8901');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5003RC', 'Training', '2017-09-07', '2018-03-08', '243-75-7555');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2463FN', 'Services', '2017-11-02', '2018-03-09', '558-13-8046');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1875PJ', 'Services', '2017-09-03', '2018-02-09', '386-89-0847');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3409ML', 'Support', '2017-09-10', '2018-03-05', '404-36-4730');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7624TE', 'Services', '2017-10-24', '2018-03-09', '762-69-5432');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0363OC', 'Engineering', '2017-09-05', '2018-02-17', '337-79-7379');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6727ZF', 'Support', '2017-12-06', '2018-02-21', '375-99-5648');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6734OY', 'Sales', '2017-11-08', '2018-03-18', '178-98-9566');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2166MA', 'Engineering', '2017-11-09', '2018-03-02', '223-21-1692');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3555UI', 'Accounting', '2017-12-19', '2018-02-14', '537-65-4967');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5823AR', 'Product Management', '2017-11-01', '2018-03-13', '290-77-7839');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9330FF', 'Support', '2017-12-15', '2018-02-21', '329-80-2426');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4937ZN', 'Sales', '2017-11-19', '2018-03-28', '103-27-8109');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4143KX', 'Business Development', '2017-10-06', '2018-02-03', '681-07-5701');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6515EG', 'Marketing', '2017-10-06', '2018-01-12', '851-14-6629');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4259WD', 'Marketing', '2017-10-15', '2018-01-18', '303-93-5712');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1187PN', 'Engineering', '2017-09-17', '2018-01-30', '446-82-1076');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0758QL', 'Research and Development', '2017-12-01', '2018-03-15', '653-27-4682');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1234ZI', 'Product Management', '2017-09-01', '2018-03-12', '604-54-1691');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4856OW', 'Product Management', '2017-12-12', '2018-02-15', '260-11-1705');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2161CZ', 'Research and Development', '2017-12-28', '2018-02-22', '697-49-6068');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7164KW', 'Product Management', '2017-12-26', '2018-03-29', '536-27-2956');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6958ER', 'Engineering', '2017-12-20', '2018-01-11', '272-97-6693');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1507XO', 'Research and Development', '2017-10-01', '2018-01-07', '374-44-5115');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2309FU', 'Product Management', '2017-10-06', '2018-01-30', '497-51-4605');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1280OV', 'Sales', '2017-12-17', '2018-01-23', '334-55-3748');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7300RZ', 'Marketing', '2017-09-23', '2018-02-10', '390-73-6823');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6105MA', 'Legal', '2017-11-04', '2018-01-30', '799-23-8294');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2292OW', 'Support', '2017-12-06', '2018-01-12', '781-81-2233');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0093MY', 'Marketing', '2017-10-29', '2018-03-23', '700-52-8901');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3279LB', 'Product Management', '2017-11-21', '2018-03-19', '243-75-7555');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1095HB', 'Accounting', '2017-10-30', '2018-01-12', '558-13-8046');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8008DQ', 'Support', '2017-12-26', '2018-02-11', '386-89-0847');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1727VR', 'Marketing', '2017-12-15', '2018-02-04', '404-36-4730');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6837KV', 'Services', '2017-10-20', '2018-01-09', '762-69-5432');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1754IP', 'Support', '2017-10-30', '2018-02-03', '337-79-7379');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4886XC', 'Accounting', '2017-09-04', '2018-02-04', '375-99-5648');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1788EY', 'Support', '2017-11-01', '2018-01-19', '384-40-6377');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8558TG', 'Marketing', '2017-10-24', '2018-02-27', '340-61-3544');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0119VU', 'Engineering', '2017-10-10', '2018-03-15', '414-27-2181');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2674GV', 'Sales', '2017-12-09', '2018-03-28', '514-70-0333');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0967MT', 'Accounting', '2017-11-09', '2018-01-27', '418-96-9133');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3423IM', 'Services', '2017-10-25', '2018-02-13', '167-24-5605');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6344VF', 'Sales', '2017-10-27', '2018-01-24', '396-52-0288');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8148RO', 'Marketing', '2017-12-17', '2018-03-29', '515-12-2198');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7169KV', 'Product Management', '2017-12-01', '2018-01-22', '650-27-6894');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0702ZT', 'Human Resources', '2017-12-16', '2018-01-23', '227-72-0289');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1643BR', 'Accounting', '2017-11-12', '2018-01-24', '637-56-9343');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7435CC', 'Business Development', '2017-11-27', '2018-02-22', '718-88-0458');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8989CF', 'Engineering', '2017-12-02', '2018-01-23', '379-89-0856');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8399MV', 'Human Resources', '2017-11-07', '2018-02-12', '805-29-1670');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3719AX', 'Services', '2017-10-01', '2018-01-28', '302-90-4925');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3333VM', 'Support', '2017-11-01', '2018-01-29', '288-27-7529');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0138PA', 'Sales', '2017-09-07', '2018-01-31', '361-67-7046');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8100TU', 'Engineering', '2017-10-01', '2018-01-06', '680-76-6512');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8918WF', 'Support', '2017-10-24', '2018-02-09', '457-74-5223');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0483LO', 'Support', '2017-11-01', '2018-02-18', '642-20-3885');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6996II', 'Human Resources', '2017-09-12', '2018-01-11', '681-07-5701');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0903WH', 'Research and Development', '2017-11-11', '2018-02-06', '851-14-6629');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7057VA', 'Engineering', '2017-09-30', '2018-01-30', '303-93-5712');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8894ZS', 'Sales', '2017-10-17', '2018-01-01', '446-82-1076');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7646TH', 'Support', '2017-11-05', '2018-01-31', '653-27-4682');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8237JP', 'Support', '2017-12-30', '2018-01-05', '604-54-1691');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6253NX', 'Research and Development', '2017-12-19', '2018-03-24', '260-11-1705');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4526HG', 'Accounting', '2017-12-13', '2018-01-31', '697-49-6068');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7052UJ', 'Engineering', '2017-09-30', '2018-01-22', '536-27-2956');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3371ML', 'Engineering', '2017-09-30', '2018-01-04', '272-97-6693');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8023DQ', 'Training', '2017-10-29', '2018-01-17', '374-44-5115');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0308XC', 'Human Resources', '2017-10-18', '2018-01-20', '497-51-4605');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2686PD', 'Accounting', '2017-10-18', '2018-03-01', '334-55-3748');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6461WL', 'Accounting', '2017-12-15', '2018-02-03', '390-73-6823');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7239CP', 'Human Resources', '2017-12-28', '2018-02-15', '799-23-8294');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9777EA', 'Business Development', '2017-12-14', '2018-01-20', '781-81-2233');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8858TB', 'Product Management', '2017-10-05', '2018-01-23', '700-52-8901');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1950DN', 'Legal', '2017-11-15', '2018-02-06', '243-75-7555');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3473KF', 'Sales', '2017-09-07', '2018-03-11', '558-13-8046');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9771SH', 'Product Management', '2017-11-13', '2018-01-07', '386-89-0847');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8201GR', 'Sales', '2017-12-08', '2018-01-01', '404-36-4730');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4654LK', 'Training', '2017-12-16', '2018-01-10', '762-69-5432');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0744OP', 'Sales', '2017-10-21', '2018-01-03', '337-79-7379');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('3695MO', 'Marketing', '2017-10-26', '2018-03-16', '375-99-5648');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1888HP', 'Training', '2017-11-12', '2018-01-18', '178-98-9566');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5954QJ', 'Training', '2017-11-08', '2018-03-13', '223-21-1692');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4805BI', 'Support', '2017-10-26', '2018-02-17', '537-65-4967');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8511AF', 'Sales', '2017-10-16', '2018-02-07', '290-77-7839');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2975EQ', 'Business Development', '2017-10-19', '2018-02-13', '329-80-2426');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6969LC', 'Research and Development', '2017-12-02', '2018-01-27', '103-27-8109');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1565VX', 'Product Management', '2017-12-24', '2018-02-19', '851-14-6629');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4742VE', 'Sales', '2017-09-16', '2018-02-09', '303-93-5712');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9826XL', 'Research and Development', '2017-12-23', '2018-02-18', '446-82-1076');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4191FJ', 'Engineering', '2017-12-17', '2018-02-02', '653-27-4682');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6451VT', 'Services', '2017-11-25', '2018-01-16', '604-54-1691');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7056ZH', 'Research and Development', '2017-10-11', '2018-01-15', '260-11-1705');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8208BQ', 'Human Resources', '2017-11-27', '2018-02-26', '697-49-6068');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('9746UI', 'Training', '2017-12-03', '2018-02-06', '536-27-2956');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5493UL', 'Services', '2017-10-30', '2018-03-17', '272-97-6693');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('7738DN', 'Business Development', '2017-11-09', '2018-01-29', '374-44-5115');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6702PZ', 'Sales', '2017-09-08', '2018-03-30', '497-51-4605');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('2259OC', 'Business Development', '2017-09-08', '2018-03-28', '334-55-3748');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8925IV', 'Engineering', '2017-09-09', '2018-02-17', '390-73-6823');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('5879VI', 'Business Development', '2017-11-16', '2018-03-21', '799-23-8294');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1073GP', 'Sales', '2017-12-26', '2018-03-12', '781-81-2233');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('4967IW', 'Support', '2017-11-13', '2018-01-23', '700-52-8901');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('1030FG', 'Engineering', '2017-10-05', '2018-03-03', '243-75-7555');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8393RA', 'Business Development', '2017-10-02', '2018-02-06', '558-13-8046');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('6458VD', 'Legal', '2017-10-15', '2018-01-08', '386-89-0847');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('8591GP', 'Training', '2017-11-25', '2018-01-29', '404-36-4730');
INSERT INTO LOWONGAN(lowongan_id, namaLowongan, tgl_buka, tgl_tutup, company) VALUES ('0789LQ', 'Business Development', '2017-09-28', '2018-01-25', '762-69-5432');





INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('27KD51', 'RCS Master Control', '33', '2018-2-12', '2018-10-14', '2017-11-15', '2018-1-7', '60', '384-40-6377', 'blawles3', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('04NK50', 'Ambulatory Care', '44', '2018-4-28', '2018-10-1', '2017-11-17', '2018-1-5', '40', '340-61-3544', 'jtick4', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('89LZ88', 'Urban Regeneration', '33', '2017-10-13', '2018-10-8', '2017-12-16', '2018-2-6', '87', '414-27-2181', 'hvon5', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('78EV40', 'NFC', '43', '2017-5-5', '2018-10-6', '2017-12-20', '2018-1-19', '39', '514-70-0333', 'vbolino6', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('60DN47', 'PMB', '34', '2017-6-27', '2018-10-10', '2017-12-10', '2018-2-1', '71', '418-96-9133', 'cfenner7', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('36IU86', 'CCNP', '49', '2017-8-7', '2018-10-16', '2017-12-11', '2018-2-18', '20', '167-24-5605', 'clonsbrough8', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('18YI92', 'DCS', '40', '2017-7-26', '2018-10-7', '2017-12-26', '2018-2-23', '62', '396-52-0288', 'fberetta9', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('10MQ58', 'EBSCO', '49', '2017-6-19', '2018-10-19', '2017-11-1', '2018-2-19', '16', '515-12-2198', 'dpawelkea', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('48NH19', 'Myofascial', '30', '2017-10-10', '2018-10-18', '2017-12-28', '2018-2-26', '31', '650-27-6894', 'atrimmillb', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('35NW46', 'PMI', '34', '2017-6-20', '2018-10-10', '2017-12-8', '2018-2-3', '54', '227-72-0289', 'ggentricc', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('49JI40', 'IKE', '22', '2018-2-1', '2018-10-13', '2017-12-22', '2018-2-27', '60', '637-56-9343', 'kmayersd', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('32VN37', 'Knowledge Sharing', '36', '2017-6-10', '2018-10-23', '2017-11-15', '2018-2-16', '40', '718-88-0458', 'cskirvanee', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('67VG08', 'WCSF', '50', '2018-1-18', '2018-10-5', '2017-11-3', '2018-2-15', '87', '379-89-0856', 'fweichf', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('97LR47', 'VMI Programs', '50', '2017-6-10', '2018-10-25', '2017-12-23', '2018-1-22', '39', '805-29-1670', 'cwasielg', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('51UE51', 'RFLP', '31', '2017-7-18', '2018-10-8', '2017-12-7', '2018-2-27', '71', '302-90-4925', 'gcrookstonh', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('68XA75', 'DWR', '41', '2017-12-8', '2018-10-25', '2017-11-1', '2018-2-27', '20', '288-27-7529', 'fsti', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('05FB15', 'LPN', '42', '2017-12-18', '2018-10-9', '2017-12-22', '2018-1-2', '62', '361-67-7046', 'grappj', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('07ZZ36', 'iLife', '26', '2017-4-10', '2018-10-20', '2017-11-24', '2018-2-26', '16', '680-76-6512', 'spinchink', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('31UP74', 'Cashiering', '46', '2017-10-30', '2018-10-20', '2017-11-29', '2018-1-8', '31', '457-74-5223', 'jmeacheml', 0);
INSERT INTO ONLINE_COURSE(course_id, namaCourse, max_peserta, tgl_mulai, tgl_akhir, tgl_awal_daftar, tgl_akhir_daftar, kategori, penyedia, pembuat, jml_peserta) VALUES 
('29EW63', 'Durable Medical Equipment', '50', '2018-1-16', '2018-10-21', '2017-11-24', '2018-1-16', '54', '642-20-3885', 'thingeleym', 0);





INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','eklassman0',49,7);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','cjohannesson1',40,62);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','pwebber2',42,24);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','cknightley3',12,76);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','cwitling4',82,39);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','sfulks5',25,91);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','csollars6',52,14);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','cneem7',52,66);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','cedess8',81,72);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','ekollas9',59,97);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','gebbinga',85,32);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','vshoubridgeb',54,76);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','eforsdykec',53,55);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','cbinderd',8,1);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','jserjeante',79,92);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','brobothamf',100,17);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','nburtwistleg',0,27);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','cbutsonh',67,37);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','hjeacocki',10,22);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','rtoplissj',47,2);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','fleasork',50,11);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','ecarlettl',23,88);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','mduncombem',78,46);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','wgisbournn',13,24);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','tgandleyo',77,66);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','doakenfallp',90,6);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','jcarlssonq',54,33);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','bakriggr',33,55);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','estientons',3,69);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','peayrst',5,73);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','blemmeru',84,19);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','tpavlatav',28,59);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','gohingertyw',77,9);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','wmerringtonx',5,73);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','sgogiey',84,51);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','blusherz',93,21);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','aloxly10',51,37);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','tdefont11',6,8);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','tfranklen12',59,43);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','naykroyd13',35,48);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','npalley14',47,0);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','cfaulkner15',96,4);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','nbrill16',42,78);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','aewington17',89,23);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','bmichelin18',0,86);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','abreckenridge19',15,19);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','mdorsay1a',40,35);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','sstiggers1b',0,74);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','ewands1c',53,13);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','kbolduc1d',69,15);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','ccorzor1e',93,93);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','clowthian1f',96,95);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','cprettyjohn1g',3,89);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','nshurville1h',2,89);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','bgrocott1i',3,70);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','ovawton1j',68,77);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','lcomrie1k',94,81);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','sgerding1l',33,75);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','ryuryaev1m',42,53);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','estirling1n',31,13);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','bsirmond1o',31,63);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','darblaster1p',10,47);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','ksambath1q',64,94);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','bollin1r',90,11);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','gorneblow1s',32,84);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','ifozzard1t',10,5);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','shrinchenko1u',70,0);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','atarbin1v',97,84);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','acheston1w',17,74);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','ndrinnan1x',55,91);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','vhabens1y',34,1);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','eeby1z',16,38);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','dlower20',99,30);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','mannetts21',1,71);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','kshowt22',80,37);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','sdobrowlski23',50,35);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','zpiscot24',95,11);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','edurbridge25',91,31);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','ydumblton26',64,57);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','askittrell27',81,40);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','ibrackenridge28',64,37);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','mcowap29',68,84);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','rwhorf2a',6,16);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','ebolino2b',93,29);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','pbruhke2c',69,2);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','kstrewther2d',54,43);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','lbernardi2e',20,66);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','bdewick2f',35,21);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','ugemlbett2g',53,11);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','rspreadbury2h',73,42);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','lmatczak2i',1,56);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','cgreenmon2j',85,53);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','jmcginley2k',18,54);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','bimort2l',25,99);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','atatam2m',35,68);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','ajorger2n',13,12);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','lbowen2o',38,24);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','myockley2p',51,97);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','bdarbey2q',82,0);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','raubery2r',52,2);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','sgaythwaite2s',7,62);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','vbortol2t',77,25);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','adebney2u',7,67);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','egalgey2v',47,41);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','dmyrtle2w',60,73);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','khastilow2x',57,4);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','awalasik2y',89,25);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','atsarovic2z',47,78);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','amathely30',12,34);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','charraway31',22,83);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','gdalling32',46,63);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','asaiger33',8,73);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','lfitzpayn34',6,55);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','opedrol35',73,13);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','egayther36',30,32);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','jdayce37',27,3);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','sstute38',70,42);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','fvakhrushin39',23,47);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','hrevens3a',24,57);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','ofishe3b',76,51);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','rstanislaw3c',45,44);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','cpettifer3d',13,87);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','bcroci3e',27,55);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','sjohnsey3f',82,25);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','sfrankcombe3g',49,37);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','ghiers3h',70,51);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','bkilleen3i',69,60);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','thatchell3j',5,84);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','sharrowell3k',16,60);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','cteulier3l',31,40);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','lmcgready3m',67,60);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','nmoogan3n',83,81);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','mdecent3o',94,27);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','aboole3p',68,53);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','tprettejohns3q',46,97);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','cschneidar3r',52,8);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','adener3s',18,71);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','nspeeks3t',58,83);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','mmenauteau3u',32,24);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','fklimus3v',59,7);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','cmaycock3w',43,77);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','nsplevin3x',99,28);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','blabba3y',17,36);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','efido3z',61,44);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','ckearton40',13,8);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','dcallender41',26,98);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','mgorvin42',20,34);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','ffall43',1,16);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','ngarman44',21,23);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','iclementel45',18,98);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','eklassman0',37,1);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','cjohannesson1',68,23);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','pwebber2',87,61);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','cknightley3',63,22);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','cwitling4',54,2);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','sfulks5',7,2);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','csollars6',40,71);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','cneem7',68,47);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','cedess8',0,9);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','ekollas9',80,76);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','gebbinga',41,99);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','vshoubridgeb',1,49);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','eforsdykec',1,8);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','cbinderd',97,98);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','jserjeante',26,56);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','brobothamf',46,12);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','nburtwistleg',24,18);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','cbutsonh',38,100);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','hjeacocki',27,96);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','rtoplissj',76,98);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','fleasork',55,66);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','ecarlettl',88,79);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','mduncombem',37,77);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','wgisbournn',71,82);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','tgandleyo',61,53);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','doakenfallp',8,30);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','jcarlssonq',29,41);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','bakriggr',99,50);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','estientons',48,42);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','peayrst',11,79);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('27KD51','blemmeru',59,6);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('04NK50','tpavlatav',47,50);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('89LZ88','gohingertyw',95,35);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('78EV40','wmerringtonx',90,87);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('60DN47','sgogiey',18,19);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('36IU86','blusherz',72,49);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('18YI92','aloxly10',5,23);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('10MQ58','tdefont11',54,3);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('48NH19','tfranklen12',62,47);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('35NW46','naykroyd13',64,77);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('49JI40','npalley14',9,55);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('32VN37','cfaulkner15',12,6);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('67VG08','nbrill16',75,77);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('97LR47','aewington17',16,35);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('51UE51','bmichelin18',26,63);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('68XA75','abreckenridge19',44,31);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('05FB15','mdorsay1a',13,31);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('07ZZ36','sstiggers1b',53,66);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('31UP74','ewands1c',97,69);
INSERT INTO HISTORY_OC (course_id, username, score_test, keaktifan) VALUES ('29EW63','kbolduc1d',56,93);





INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('eklassman0', '2079KU', 'AX', '3', '1.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cjohannesson1', '2054VJ', 'DC', '4', '1.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('pwebber2', '3810YN', 'VH', '2', '6.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cknightley3', '9877GF', 'EI', '4', '3.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cwitling4', '9557IH', 'VI', '2', '8.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sfulks5', '9707IX', 'BW', '1', '2.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('csollars6', '2143JI', 'ML', '4', '8.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cneem7', '5210OP', 'NW', '4', '6.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cedess8', '4373BY', 'BK', '4', '6.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ekollas9', '8590SI', 'HY', '2', '2.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('gebbinga', '1398GK', 'SE', '2', '8.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('vshoubridgeb', '8243ER', 'ZX', '3', '7.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('eforsdykec', '0698GA', 'OK', '4', '3.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cbinderd', '1618AD', 'NW', '1', '2.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('jserjeante', '0993SA', 'YC', '3', '1.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('brobothamf', '6245RC', 'EX', '4', '7.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nburtwistleg', '5856ZC', 'RI', '3', '4.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cbutsonh', '4278UD', 'RU', '1', '1.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('hjeacocki', '1826SN', 'DE', '2', '2.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('rtoplissj', '5401KI', 'JD', '4', '9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('fleasork', '0951VY', 'KN', '3', '9.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ecarlettl', '9289AC', 'BB', '2', '1.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mduncombem', '6671CC', 'HA', '1', '6.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('wgisbournn', '2525EV', 'IY', '1', '4.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tgandleyo', '9054PS', 'PR', '1', '7.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('doakenfallp', '3335XI', 'VS', '3', '8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('jcarlssonq', '7532PD', 'US', '2', '9.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bakriggr', '7425IK', 'BV', '3', '7.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('estientons', '2860CJ', 'GB', '1', '5.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('peayrst', '3214EX', 'KU', '3', '8.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('blemmeru', '7689QR', 'XH', '1', '2.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tpavlatav', '8985TH', 'PX', '4', '2.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('gohingertyw', '5644PX', 'PE', '2', '2.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('wmerringtonx', '8479DQ', 'BL', '3', '3.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sgogiey', '1036VC', 'JM', '2', '9.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('blusherz', '3033TA', 'QD', '2', '9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('aloxly10', '1469RM', 'PJ', '1', '7.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tdefont11', '6360RW', 'JB', '1', '3.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tfranklen12', '3980CK', 'KZ', '1', '9.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('naykroyd13', '4362YW', 'FG', '3', '9.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('npalley14', '6570VI', 'NJ', '4', '6.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cfaulkner15', '9807PF', 'KU', '2', '7.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nbrill16', '5003RC', 'VV', '3', '1.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('aewington17', '2463FN', 'IW', '1', '9.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bmichelin18', '1875PJ', 'DH', '2', '7.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('abreckenridge19', '3409ML', 'UB', '4', '6.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mdorsay1a', '7624TE', 'MJ', '4', '2.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sstiggers1b', '0363OC', 'LD', '2', '1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ewands1c', '6727ZF', 'EQ', '3', '6.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('kbolduc1d', '6734OY', 'HY', '3', '4.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ccorzor1e', '2166MA', 'FF', '3', '2.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('clowthian1f', '3555UI', 'XI', '2', '1.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cprettyjohn1g', '5823AR', 'TJ', '2', '7.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nshurville1h', '9330FF', 'ON', '1', '3.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bgrocott1i', '4937ZN', 'XY', '1', '7.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ovawton1j', '4143KX', 'DA', '3', '2.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('lcomrie1k', '6515EG', 'YY', '1', '3.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sgerding1l', '4259WD', 'UC', '1', '5.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ryuryaev1m', '1187PN', 'ZH', '2', '6.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('estirling1n', '0758QL', 'SP', '2', '9.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bsirmond1o', '1234ZI', 'QO', '2', '6.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('darblaster1p', '4856OW', 'DN', '4', '4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ksambath1q', '2161CZ', 'WH', '4', '5.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bollin1r', '7164KW', 'GD', '3', '9.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('gorneblow1s', '6958ER', 'AV', '2', '7.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ifozzard1t', '1507XO', 'QU', '3', '3.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('shrinchenko1u', '2309FU', 'PY', '1', '7.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('atarbin1v', '1280OV', 'ZK', '2', '8.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('acheston1w', '7300RZ', 'IP', '4', '2.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ndrinnan1x', '6105MA', 'US', '2', '5.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('vhabens1y', '2292OW', 'SL', '4', '7.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('eeby1z', '0093MY', 'TI', '1', '4.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('dlower20', '3279LB', 'FV', '4', '1.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mannetts21', '1095HB', 'BL', '3', '1.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('kshowt22', '8008DQ', 'ET', '2', '4.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sdobrowlski23', '1727VR', 'BS', '3', '6.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('zpiscot24', '6837KV', 'PS', '1', '6.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('edurbridge25', '1754IP', 'WQ', '1', '1.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ydumblton26', '4886XC', 'LD', '3', '4.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('askittrell27', '1788EY', 'CW', '4', '5.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ibrackenridge28', '8558TG', 'SA', '3', '2.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mcowap29', '0119VU', 'HK', '4', '7.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('rwhorf2a', '2674GV', 'UI', '1', '7.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ebolino2b', '0967MT', 'JU', '2', '1.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('pbruhke2c', '3423IM', 'GO', '4', '4.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('kstrewther2d', '6344VF', 'KZ', '3', '2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('lbernardi2e', '8148RO', 'WQ', '2', '2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bdewick2f', '7169KV', 'UT', '4', '5.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ugemlbett2g', '0702ZT', 'YM', '4', '5.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('rspreadbury2h', '1643BR', 'JG', '1', '7.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('lmatczak2i', '7435CC', 'AK', '1', '9.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cgreenmon2j', '8989CF', 'IZ', '4', '4.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('jmcginley2k', '8399MV', 'UU', '3', '1.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bimort2l', '3719AX', 'NZ', '3', '6.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('atatam2m', '3333VM', 'NT', '4', '8.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ajorger2n', '0138PA', 'IU', '2', '3.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('lbowen2o', '8100TU', 'AV', '2', '8.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('myockley2p', '8918WF', 'UU', '4', '9.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bdarbey2q', '0483LO', 'YI', '1', '1.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('raubery2r', '6996II', 'AE', '1', '6.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sgaythwaite2s', '0903WH', 'QH', '4', '2.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('vbortol2t', '7057VA', 'IO', '4', '5.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('adebney2u', '8894ZS', 'TH', '1', '8.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('egalgey2v', '7646TH', 'FN', '4', '4.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('dmyrtle2w', '8237JP', 'SC', '1', '6.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('khastilow2x', '6253NX', 'CV', '3', '2.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('awalasik2y', '4526HG', 'DU', '3', '2.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('atsarovic2z', '7052UJ', 'QF', '4', '4.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('amathely30', '3371ML', 'QS', '2', '2.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('charraway31', '8023DQ', 'TZ', '1', '9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('gdalling32', '0308XC', 'FZ', '1', '8.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('asaiger33', '2686PD', 'ES', '3', '5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('lfitzpayn34', '6461WL', 'IG', '3', '6.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('opedrol35', '7239CP', 'GN', '4', '3.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('egayther36', '9777EA', 'EF', '4', '4.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('jdayce37', '8858TB', 'UQ', '2', '9.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sstute38', '1950DN', 'HG', '1', '3.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('fvakhrushin39', '3473KF', 'FV', '3', '2.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('hrevens3a', '9771SH', 'WC', '2', '2.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ofishe3b', '8201GR', 'FT', '3', '9.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('rstanislaw3c', '4654LK', 'KG', '4', '2.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cpettifer3d', '0744OP', 'BP', '3', '6.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bcroci3e', '3695MO', 'BP', '2', '4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sjohnsey3f', '1888HP', 'TT', '4', '8.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sfrankcombe3g', '5954QJ', 'QW', '3', '4.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ghiers3h', '4805BI', 'SE', '3', '6.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bkilleen3i', '8511AF', 'AX', '3', '10');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('thatchell3j', '2975EQ', 'FH', '2', '8.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sharrowell3k', '6969LC', 'IF', '3', '8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cteulier3l', '1565VX', 'JB', '4', '5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('lmcgready3m', '4742VE', 'GM', '4', '6.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nmoogan3n', '9826XL', 'CQ', '2', '1.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mdecent3o', '4191FJ', 'NB', '4', '9.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('aboole3p', '6451VT', 'RZ', '2', '4.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tprettejohns3q', '7056ZH', 'ST', '2', '6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cschneidar3r', '8208BQ', 'PL', '1', '9.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('adener3s', '9746UI', 'SF', '2', '3.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nspeeks3t', '5493UL', 'OD', '3', '2.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mmenauteau3u', '7738DN', 'FS', '1', '2.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('fklimus3v', '6702PZ', 'ZW', '3', '5.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cmaycock3w', '2259OC', 'YB', '2', '9.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nsplevin3x', '8925IV', 'DL', '2', '10');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('blabba3y', '5879VI', 'PU', '2', '7.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('efido3z', '1073GP', 'WQ', '3', '4.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ckearton40', '4967IW', 'QD', '4', '7.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('dcallender41', '1030FG', 'EF', '1', '9.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mgorvin42', '8393RA', 'JN', '3', '6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ffall43', '6458VD', 'JZ', '3', '9.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ngarman44', '8591GP', 'ET', '3', '7.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('iclementel45', '0789LQ', 'IB', '3', '4.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ewands1c', '2079KU', 'AX', '2', '9.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('kbolduc1d', '2054VJ', 'DC', '1', '4.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ckearton40', '3810YN', 'VH', '1', '2.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('iclementel45', '9877GF', 'EI', '2', '1.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('pwebber2', '9557IH', 'VI', '4', '2.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cknightley3', '9707IX', 'BW', '1', '9.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cwitling4', '2143JI', 'ML', '1', '8.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sfulks5', '5210OP', 'NW', '2', '7.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('csollars6', '4373BY', 'BK', '3', '7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cneem7', '8590SI', 'HY', '1', '1.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cedess8', '1398GK', 'SE', '1', '3.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ekollas9', '8243ER', 'ZX', '2', '5.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('gebbinga', '0698GA', 'OK', '1', '6.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('vshoubridgeb', '1618AD', 'NW', '1', '4.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('eforsdykec', '0993SA', 'YC', '3', '6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cbinderd', '6245RC', 'EX', '2', '1.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('jserjeante', '5856ZC', 'RI', '4', '8.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('brobothamf', '4278UD', 'RU', '2', '1.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nburtwistleg', '1826SN', 'DE', '3', '8.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cbutsonh', '5401KI', 'JD', '2', '6.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('hjeacocki', '0951VY', 'KN', '3', '4.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('rtoplissj', '9289AC', 'BB', '2', '4.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('fleasork', '6671CC', 'HA', '1', '7.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('ecarlettl', '2525EV', 'IY', '4', '7.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mduncombem', '9054PS', 'PR', '1', '3.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('wgisbournn', '3335XI', 'VS', '4', '5.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tgandleyo', '7532PD', 'US', '3', '1.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('doakenfallp', '7425IK', 'BV', '2', '3.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('jcarlssonq', '2860CJ', 'GB', '2', '4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bakriggr', '3214EX', 'KU', '3', '1.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('estientons', '7689QR', 'XH', '2', '2.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('peayrst', '8985TH', 'PX', '2', '1.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('blemmeru', '5644PX', 'PE', '4', '4.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tpavlatav', '8479DQ', 'BL', '1', '3.9');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('gohingertyw', '1036VC', 'JM', '2', '4.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('wmerringtonx', '3033TA', 'QD', '2', '3.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sgogiey', '1469RM', 'PJ', '1', '2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('blusherz', '6360RW', 'JB', '4', '5.4');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('aloxly10', '3980CK', 'KZ', '3', '3.8');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tdefont11', '4362YW', 'FG', '1', '7.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('tfranklen12', '6570VI', 'NJ', '3', '3.1');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('naykroyd13', '9807PF', 'KU', '1', '9.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('npalley14', '5003RC', 'VV', '4', '7.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('cfaulkner15', '2463FN', 'IW', '2', '8.3');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('nbrill16', '1875PJ', 'DH', '3', '3.7');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('aewington17', '3409ML', 'UB', '3', '6.5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('bmichelin18', '7624TE', 'MJ', '1', '1.6');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('abreckenridge19', '0363OC', 'LD', '2', '5');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('mdorsay1a', '6727ZF', 'EQ', '1', '4.2');
INSERT INTO PELAMARAN(username, lowongan_id, posisi_id, status, user_rating) VALUES ('sstiggers1b', '6734OY', 'HY', '1', '9.4');





INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('wgilman0','wtARXZZxW','Waly Gilman','810-03-3459','1999-06-10 00:00:00','636-378-0603','Lerdahl','Missouri','Saint Louis',63126,'False',NULL);
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('lvickarman1','DociR8JL','Leopold Vickarman','704-59-4197','1999-05-02 00:00:00','770-417-4259','Delladonna','Georgia','Marietta',30061,'False',NULL);
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('bmurch2','xCLR73ugC','Brigitta Murch','706-97-6216','1999-01-22 00:00:00','919-768-8928','Hagan','North Carolina','Raleigh',27626,'False',NULL);
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('blawles3','xKqdYzBj','Barbey Lawles','860-35-1051','1996-12-07 00:00:00','713-374-7791','Badeau','Texas','Houston',77201,'True','384-40-6377');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('jtick4','vhv9Ke5qd','Jacki Tick','606-31-4785','1999-05-05 00:00:00','281-488-5505','Darwin','Texas','Houston',77035,'True','340-61-3544');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('hvon5','uvhc8n2T','Hedwig Von Hindenburg','685-94-0126','1999-03-06 00:00:00','214-360-6986','Cambridge','Texas','Dallas',75265,'True','414-27-2181');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('vbolino6','JqcBQu','Violette Bolino','450-50-6162','1999-11-22 00:00:00','712-478-0973','Valley Edge','Iowa','Sioux City',51110,'True','514-70-0333');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('cfenner7','oYMo2sO9PGmV','Carlye Fenner','305-50-4558','1999-09-23 00:00:00','409-427-8871','Crowley','Texas','Galveston',77554,'True','418-96-9133');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('clonsbrough8','vySS6g','Catlaina Lonsbrough','614-89-6292','1998-11-28 00:00:00','803-549-3485','Karstens','South Carolina','Columbia',29240,'True','167-24-5605');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('fberetta9','3C4Yn2ueR','Florenza Beretta','638-73-5316','1997-12-29 00:00:00','212-828-2303','Pennsylvania','New York','New York City',10090,'True','396-52-0288');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('dpawelkea','Jb9HDWNw','Derry Pawelke','248-37-4518','1998-02-16 00:00:00','323-489-2381','Montana','California','Los Angeles',90065,'True','515-12-2198');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('atrimmillb','bmCZMkNc2','Aleta Trimmill','781-86-0096','1998-06-03 00:00:00','334-577-7022','Claremont','Alabama','Montgomery',36195,'True','650-27-6894');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('ggentricc','qYDtQa04','Granville Gentric','896-76-5395','1998-11-19 00:00:00','520-628-4406','Dayton','Arizona','Tucson',85715,'True','227-72-0289');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('kmayersd','p95VfN0L','Ketti Mayers','600-49-6598','1998-11-25 00:00:00','708-426-4352','Warner','Illinois','Chicago',60604,'True','637-56-9343');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('cskirvanee','LaQOs5tjRgBL','Caty Skirvane','322-97-9939','1998-05-06 00:00:00','650-635-0537','Rusk','California','Mountain View',94042,'True','718-88-0458');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('fweichf','DQiwWl4','Francyne Weich','622-25-2924','1998-01-15 00:00:00','863-512-5966','Arizona','Florida','Lakeland',33805,'True','379-89-0856');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('cwasielg','cpUhbftl','Chen Wasiel','277-83-7446','1994-03-07 00:00:00','916-281-3069','Columbus','California','Sacramento',95828,'True','805-29-1670');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('gcrookstonh','0p4KYFkUa','Giovanna Crookston','489-85-0812','1994-03-06 00:00:00','414-607-7360','Westerfield','Wisconsin','Milwaukee',53285,'True','302-90-4925');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('fsti','vJHJt79mz','Franciskus St Angel','662-79-3182','1994-03-31 00:00:00','479-138-9430','Haas','Arkansas','Fort Smith',72916,'True','288-27-7529');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('grappj','2Ar6s5','Gwenny Rapp','778-83-8060','1994-03-12 00:00:00','315-174-0427','Pennsylvania','New York','Syracuse',13210,'True','361-67-7046');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('spinchink','yIqf2HznLIvc','Sheelagh Pinchin','550-01-1096','1994-10-25 00:00:00','310-658-7067','Hollow Ridge','California','Santa Monica',90410,'True','680-76-6512');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('jmeacheml','2zvzptOZaJ','Jobina Meachem','384-54-9623','1994-06-27 00:00:00','936-808-1186','Ridge Oak','Texas','Conroe',77305,'True','457-74-5223');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('thingeleym','6ZChwBsOV','Timoteo Hingeley','445-31-8763','1994-02-08 00:00:00','318-729-5386','Paget','Louisiana','Monroe',71208,'True','642-20-3885');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('tsothebyn','B3diEhb5','Trever Sotheby','120-33-9354','1998-02-28 00:00:00','321-426-8914','American Ash','Florida','Melbourne',32919,'True','681-07-5701');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('sdeggo','ZXY0OxnIOz2','Saunderson Degg','524-65-6805','1998-01-01 00:00:00','304-584-4240','Reinke','West Virginia','Huntington',25716,'True','851-14-6629');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('ktuitep','1XxS4SWCXTc','Kellyann Tuite','276-80-6572','1998-10-05 00:00:00','941-938-2602','Mariners Cove','Florida','Punta Gorda',33982,'True','303-93-5712');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('ljamiesonq','of9Hs2Eo5LcI','Lauraine Jamieson','528-50-0125','1998-08-07 00:00:00','915-992-3078','Coleman','Texas','El Paso',88541,'True','446-82-1076');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('moldmanr','ZLkzNJsY','Mathew Oldman','725-96-1503','1995-10-15 00:00:00','214-770-3376','Northridge','Texas','Dallas',75387,'True','653-27-4682');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('shodgess','EamnMX','Sande Hodges','489-25-5589','1995-02-13 00:00:00','501-668-2175','Logan','Arkansas','North Little Rock',72199,'True','604-54-1691');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('cperfordt','hckbqFr','Celie Perford','172-51-5346','1997-11-29 00:00:00','314-317-2719','Crowley','Missouri','Saint Louis',63169,'True','260-11-1705');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('nscrutonu','Ope1Ea9eWB','Nisse Scruton','745-28-0572','1995-10-22 00:00:00','517-523-3781','8th','Michigan','Lansing',48919,'True','697-49-6068');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('nhumfreyv','UIdf9gDZOo','Nertie Humfrey','410-12-6605','1995-01-15 00:00:00','786-858-7222','Randy','Florida','Miami',33245,'True','536-27-2956');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('mmushetw','y4U5zpw','Maurits Mushet','778-64-6005','1995-02-16 00:00:00','765-526-2775','Montana','Indiana','Anderson',46015,'True','272-97-6693');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('ogrewcockx','EyERr70KWw7','Opal Grewcock','388-22-0397','1995-02-27 00:00:00','971-136-1681','Melrose','Oregon','Portland',97271,'True','374-44-5115');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('lgonety','6Ah7yTfSHEXx','Libbey Gonet','557-08-6626','1995-09-16 00:00:00','912-429-4086','Riverside','Georgia','Savannah',31410,'True','497-51-4605');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('bevaz','o4PaiOOD','Britni Eva','677-47-2806','1998-05-25 00:00:00','203-778-6040','Anzinger','Connecticut','New Haven',6505,'True','334-55-3748');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('dhargie10','olhjcT7c','Danyette Hargie','405-65-8367','1998-01-27 00:00:00','209-340-9296','Kennedy','California','Stockton',95205,'True','390-73-6823');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('cledes11','WYWXLanMW','Ciel Ledes','500-56-8025','1998-02-28 00:00:00','602-441-9689','Kenwood','Arizona','Phoenix',85015,'True','799-23-8294');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('ckneale12','p18Tnoo','Cori Kneale','621-23-6628','1998-02-22 00:00:00','704-197-9709','Artisan','North Carolina','Charlotte',28235,'True','781-81-2233');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('drosier13','rgCJwto','Davin Rosier','522-79-1791','1998-10-01 00:00:00','714-732-9448','North','California','Irvine',92717,'True','700-52-8901');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('rkenna14','lV8UkV6XmLS','Rosalyn Kenna','220-21-8726','1995-12-23 00:00:00','720-790-2079','Talisman','Colorado','Denver',80228,'True','243-75-7555');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('jcacacie15','fAcQ5MCX','Josie Cacacie','145-27-4822','1998-04-06 00:00:00','313-610-6210','Grover','Michigan','Detroit',48232,'True','558-13-8046');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('mpitceathly16','BArryPx','Mona Pitceathly','529-37-8239','1997-12-22 00:00:00','304-511-2639','Birchwood','West Virginia','Huntington',25711,'True','386-89-0847');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('madhams17','Cs3zbA70J2','Merci Adhams','693-95-9247','1999-12-04 00:00:00','361-426-8141','Raven','Texas','Corpus Christi',78405,'True','404-36-4730');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('lbearn18','Mn2N50HCR02G','Lauren Bearn','576-98-6918','1997-08-28 00:00:00','505-880-7988','Loeprich','New Mexico','Albuquerque',87195,'True','762-69-5432');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('cbizzey19','dKTqtRg0f','Cleon Bizzey','349-89-1427','1997-04-09 00:00:00','571-796-8212','Hayes','Virginia','Merrifield',22119,'True','337-79-7379');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('jghest1a','PKRwob','Jacquenetta Ghest','784-03-8560','1997-01-23 00:00:00','651-509-2879','Eagan','Minnesota','Minneapolis',55402,'True','375-99-5648');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('hsimionescu1b','vvsbPx','Howey Simionescu','235-84-9940','1997-09-21 00:00:00','916-397-3116','North','California','Sacramento',95894,'True','178-98-9566');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('aowbrick1c','i5Z3Kv','Andrea Owbrick','530-42-8095','1997-08-21 00:00:00','336-146-0257','Roxbury','North Carolina','Winston Salem',27105,'True','223-21-1692');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('pmarc1d','htgFenD','Pier Marc','896-05-0337','1997-05-01 00:00:00','646-124-0926','3rd','New York','New York City',10099,'True','537-65-4967');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('jcolthurst1e','uo5f9HjzxPh','Jarrett Colthurst','885-51-8899','1997-08-30 00:00:00','540-168-9079','Steensland','Virginia','Roanoke',24014,'True','290-77-7839');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('pbircher1f','UWv4dzehWnRa','Pandora Bircher','841-31-2369','1997-01-30 00:00:00','719-408-1237','Harbort','Colorado','Colorado Springs',80995,'True','329-80-2426');
INSERT INTO PENGGUNA_ADMIN (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,flagAdminCompany,company_pendaftar) VALUES ('mholme1g','TKbXvYW','Marita Holme','611-96-7385','1998-08-06 00:00:00','951-933-3330','Cambridge','California','Corona',92883,'True','103-27-8109');





INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('eklassman0','ZRr5Sw','Edeline Klassman','657-21-5899','1997-07-16 00:00:00',81399599312,'Caliangt','Massachusetts','Lynn',1905,'http://indiatimes.com/eu/massa.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cjohannesson1','6A3og8','Correna Johannesson','861-64-9016','1997-07-26 00:00:00',81399599313,'Cascade','Oklahoma','Oklahoma City',73179,'https://businessinsider.com/consectetuer/eget/rutrum/at/lorem/integer/tincidunt.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('pwebber2','bQ66gEvFNH','Parnell Webber','847-19-8424','1996-12-05 00:00:00',81399599314,'Fulton','Florida','Port Charlotte',33954,'http://trellian.com/eget/eleifend/luctus.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cknightley3','FIeB88AS34','Christiane Knightley','614-10-7534','1997-11-13 00:00:00',81399599315,'East','Georgia','Atlanta',30336,'https://go.com/consectetuer/adipiscing/elit/proin/risus.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cwitling4','40SqulE','Clemmy Witling','327-66-0142','1997-05-21 00:00:00',81399599316,'Forest Dale','New Jersey','Trenton',8608,'http://wunderground.com/sed/interdum/venenatis.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sfulks5','s0tNEx26','Shaylynn Fulks','869-06-0185','1997-07-13 00:00:00',81399599317,'Briar Crest','Texas','Houston',77218,'https://hexun.com/quam/sollicitudin/vitae.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('csollars6','gNJloqg0','Clifford Sollars','585-64-1894','1997-02-08 00:00:00',81399599318,'Pierstorff','Virginia','Arlington',22212,'http://china.com.cn/rutrum/at/lorem.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cneem7','gj17q0','Courtenay Neem','328-28-3128','1997-04-08 00:00:00',81399599319,'Shasta','Washington','Seattle',98109,'https://java.com/malesuada/in/imperdiet/et/commodo/vulputate/justo.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cedess8','PcjX87YMi','Christy Edess','313-96-6131','1997-05-13 00:00:00',81399599320,'Hanson','Florida','Miami',33134,'https://washingtonpost.com/quam/fringilla/rhoncus.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ekollas9','CD1hM7u','Ellsworth Kollas','143-07-1109','1997-06-19 00:00:00',81399599321,'Brentwood','Florida','Fort Lauderdale',33345,'https://wikia.com/habitasse/platea/dictumst.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('gebbinga','RVamwuFm8bRM','Garey Ebbing','676-06-2484','1997-04-22 00:00:00',81399599322,'Mandrake','California','San Diego',92121,'http://scribd.com/in/faucibus/orci/luctus.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('vshoubridgeb','ZtZT2s','Victoria Shoubridge','665-83-8657','1997-07-04 00:00:00',81399599323,'Pierstorff','Florida','Orlando',32803,'https://blogs.com/ac/est/lacinia.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('eforsdykec','z4sib7cYCvu7','Evvy Forsdyke','229-93-9614','1997-11-07 00:00:00',81399599324,'Buell','Texas','Dallas',75216,'https://simplemachines.org/erat.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cbinderd','arEniV1kZ','Cosetta Binder','700-22-1383','1995-10-10 00:00:00',81399599325,'Village Green','California','San Bernardino',92405,'https://psu.edu/nunc/viverra/dapibus.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('jserjeante','W1aO5dX','Jaynell Serjeant','273-19-6314','1995-03-25 00:00:00',81399599326,'Rigney','New York','Brooklyn',11231,'https://nba.com/ligula/sit/amet.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('brobothamf','zVHXAmYkSdld','Barr Robotham','833-35-5026','1995-07-29 00:00:00',81399599327,'Tennyson','North Carolina','Raleigh',27615,'https://blogspot.com/pellentesque/at/nulla.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('nburtwistleg','OQmRNyQDyG','Neely Burtwistle','199-61-0871','1995-04-17 00:00:00',81399599328,'Village Green','Illinois','East Saint Louis',62205,'https://com.com/lectus/suspendisse/potenti/in/eleifend.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cbutsonh','Uy9UlLJhK9Q','Corney Butson','231-67-5926','1995-04-01 00:00:00',81399599329,'Upham','New Jersey','Trenton',8603,'https://stanford.edu/curae/mauris/viverra/diam/vitae/quam.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('hjeacocki','bqhllBpAn','Hal Jeacock','410-51-0995','1995-03-04 00:00:00',81399599330,'Starling','Texas','Dallas',75353,'https://epa.gov/lacus/morbi/quis/tortor/id.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('rtoplissj','MWA2Omo','Roseline Topliss','605-56-9990','1995-02-01 00:00:00',81399599331,'Mccormick','Ohio','Mansfield',44905,'https://jalbum.net/scelerisque/mauris/sit/amet.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('fleasork','x4LFbmDA','Fremont Leasor','362-25-7703','1995-01-18 00:00:00',81399599332,'Reinke','Texas','Waco',76711,'https://feedburner.com/pede/ac/diam/cras/pellentesque/volutpat.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ecarlettl','k5zsKvGwbcbk','Elysha Carlett','387-37-3208','1996-12-21 00:00:00',81399599333,'Hallows','California','Los Angeles',90060,'http://huffingtonpost.com/aliquam/quis/turpis/eget.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mduncombem','dcbxrmF94E','Michal Duncombe','140-45-6786','1997-03-13 00:00:00',81399599334,'Macpherson','California','San Jose',95118,'https://guardian.co.uk/nec/euismod/scelerisque/quam.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('wgisbournn','6MJmdWE9v','Wye Gisbourn','249-08-3965','1997-11-04 00:00:00',81399599335,'Colorado','California','Orange',92862,'http://ihg.com/integer.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('tgandleyo','BGsOvYdFciz','Tomasina Gandley','187-51-3848','1997-11-04 00:00:00',81399599336,'Canary','Alabama','Mobile',36689,'http://admin.ch/ultricies/eu/nibh/quisque/id.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('doakenfallp','xxTWlSWjelG','Delmore Oakenfall','553-79-4691','1997-02-14 00:00:00',81399599337,'Katie','New Jersey','Paterson',7505,'https://netvibes.com/at/nibh/in.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('jcarlssonq','cvqhuIXnb','Jemima Carlsson','360-76-1594','1997-03-18 00:00:00',81399599338,'Service','Ohio','Toledo',43656,'https://amazon.de/libero/quis/orci/nullam/molestie/nibh/in.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bakriggr','Sj84uFBbJhCc','Barnie Akrigg','183-55-5213','1997-01-24 00:00:00',81399599339,'2nd','Virginia','Roanoke',24024,'https://cpanel.net/dis/parturient/montes/nascetur/ridiculus/mus.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('estientons','Vz18GvG','Ealasaid Stienton','400-06-6315','1995-06-19 00:00:00',81399599340,'Larry','New Mexico','Albuquerque',87190,'http://quantcast.com/tempor.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('peayrst','sYMRywvJAKIr','Pandora Eayrs','560-95-9871','1996-12-13 00:00:00',81399599341,'Fulton','Virginia','Reston',22096,'https://squidoo.com/lorem/vitae/mattis/nibh/ligula.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('blemmeru','nn9Wqll','Brand Lemmer','721-11-2270','1995-01-27 00:00:00',81399599342,'West','Ohio','Dayton',45490,'http://ed.gov/cubilia/curae/nulla/dapibus/dolor.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('tpavlatav','NLone9H5','Tadio Pavlata','542-57-7919','1995-01-01 00:00:00',81399599343,'Erie','California','Fresno',93750,'http://dell.com/lorem/ipsum/dolor/sit/amet/consectetuer/adipiscing.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('gohingertyw','nCg206j','Giulia O''Hingerty','282-90-1295','1997-06-20 00:00:00',81399599344,'Lotheville','Texas','Waco',76711,'http://tinyurl.com/libero/convallis/eget/eleifend/luctus/ultricies.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('wmerringtonx','jb9i0P','Walsh Merrington','514-26-8375','1997-04-10 00:00:00',81399599345,'Bultman','New York','New York City',10090,'http://ucoz.com/libero/rutrum.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sgogiey','YY5ODVAugq','Sonny Gogie','765-31-3092','1997-02-06 00:00:00',81399599346,'Hanover','Washington','Tacoma',98424,'https://soup.io/odio/elementum/eu/interdum/eu.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('blusherz','rogv6d','Barron Lusher','730-84-0438','1997-09-03 00:00:00',81399599347,'Elmside','California','Irvine',92710,'https://twitter.com/mus/vivamus/vestibulum.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('aloxly10','oyX2Fd3Wv','Annelise Loxly','413-52-2894','1994-06-08 00:00:00',81399599348,'Derek','Michigan','Lansing',48930,'http://weather.com/porttitor/pede/justo.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('tdefont11','WXq5Ktq','Tracey Defont','651-30-1060','1994-10-22 00:00:00',81399599349,'Starling','Missouri','Kansas City',64193,'https://pcworld.com/feugiat/non/pretium/quis/lectus/suspendisse.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('tfranklen12','wwmzAait1myw','Tommi Franklen','200-83-2569','1994-10-28 00:00:00',81399599350,'Ludington','Missouri','Saint Louis',63121,'https://psu.edu/platea/dictumst/morbi/vestibulum/velit/id/pretium.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('naykroyd13','WYTwP78Zhbry','Nathaniel Aykroyd','801-63-1570','1994-09-21 00:00:00',81399599351,'Springview','Tennessee','Memphis',38104,'http://reuters.com/vel/nulla/eget/eros.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('npalley14','aUOoe1','Nell Palley','412-69-9511','1994-10-06 00:00:00',81399599352,'Mifflin','Kansas','Kansas City',66112,'https://drupal.org/etiam/pretium/iaculis/justo/in/hac/habitasse.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cfaulkner15','FvACNdDJG','Creight Faulkner','586-04-9131','1996-12-04 00:00:00',81399599353,'Monterey','New York','Albany',12222,'http://imageshack.us/in.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('nbrill16','Dz1ESYU','Noak Brill','355-14-3213','1997-03-08 00:00:00',81399599354,'Jana','Kentucky','Louisville',40266,'https://altervista.org/mauris/enim/leo/rhoncus/sed/vestibulum.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('aewington17','JP7pEA1JMwEC','Audrye Ewington','779-24-5338','1997-10-12 00:00:00',81399599355,'Declaration','California','Pasadena',91117,'http://studiopress.com/morbi/vestibulum/velit/id/pretium.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bmichelin18','QRIFjTj','Bernita Michelin','299-65-9011','1997-03-30 00:00:00',81399599356,'Westridge','Alabama','Gadsden',35905,'https://gravatar.com/augue/vestibulum/rutrum.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('abreckenridge19','E76RT8VBGkA','Addy Breckenridge','111-65-4399','1997-04-25 00:00:00',81399599357,'Parkside','Washington','Seattle',98140,'http://nsw.gov.au/integer/ac/leo/pellentesque.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mdorsay1a','rnTMkr','Myrtie D''Orsay','763-53-5022','1996-04-18 00:00:00',81399599358,'Blackbird','Arizona','Phoenix',85005,'http://topsy.com/metus/aenean.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sstiggers1b','k7nfV3NntraT','Sheridan Stiggers','849-27-5037','1996-08-13 00:00:00',81399599359,'Summerview','Ohio','Cleveland',44185,'http://berkeley.edu/amet/diam.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ewands1c','zbVMMGFfcEjb','Edouard Wands','264-20-0458','1996-09-26 00:00:00',81399599360,'Cottonwood','Connecticut','Waterbury',6705,'https://naver.com/aenean/fermentum/donec/ut/mauris/eget/massa.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('kbolduc1d','wmtvIyTz','Kacey Bolduc','106-79-8771','1996-09-12 00:00:00',81399599361,'Anzinger','Virginia','Roanoke',24034,'http://intel.com/nunc/viverra/dapibus/nulla/suscipit/ligula.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ccorzor1e','aqtyF4bxB','Corabella Corzor','319-04-1266','1996-12-08 00:00:00',81399599362,'Ohio','California','Fresno',93794,'https://sfgate.com/at/velit/vivamus/vel/nulla/eget.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('clowthian1f','Ye5KHj','Cairistiona Lowthian','605-92-9097','1996-03-12 00:00:00',81399599363,'Victoria','Kentucky','London',40745,'https://wikia.com/consequat/lectus/in.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cprettyjohn1g','UhTGVlrG2fsc','Cliff Prettyjohn','588-44-0649','1997-10-03 00:00:00',81399599364,'Packers','New York','New York City',10045,'http://whitehouse.gov/convallis/morbi/odio/odio/elementum.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('nshurville1h','sdjsVospMD','Nissy Shurville','843-70-7488','1997-05-04 00:00:00',81399599365,'Fallview','North Carolina','Greensboro',27415,'http://narod.ru/phasellus/sit/amet/erat.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bgrocott1i','z3eYTMNBIkzo','Bride Grocott','606-04-3962','1997-08-20 00:00:00',81399599366,'Sunfield','California','San Jose',95128,'http://bandcamp.com/eros/viverra/eget/congue/eget/semper/rutrum.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ovawton1j','20vH4KW5HcAn','Ogdan Vawton','520-95-1227','1997-03-25 00:00:00',81399599367,'Chinook','Florida','Miami',33153,'http://cdc.gov/porttitor/pede/justo/eu.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('lcomrie1k','eEwRaKY','Laney Comrie','596-79-8741','1997-11-24 00:00:00',81399599368,'Chinook','Texas','Dallas',75231,'https://wunderground.com/quisque/porta/volutpat.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sgerding1l','CzeYqf2ht','Sarena Gerding','619-83-8472','1994-10-10 00:00:00',81399599369,'Forster','New York','Brooklyn',11241,'http://yellowpages.com/at/velit/vivamus/vel/nulla.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ryuryaev1m','nZhcMOw','Robinson Yuryaev','332-53-8058','1994-10-16 00:00:00',81399599370,'Shoshone','Illinois','Evanston',60208,'http://microsoft.com/praesent/id/massa/id/nisl/venenatis/lacinia.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('estirling1n','1aYGR3jqBRiq','Elvis Stirling','120-60-9429','1994-10-31 00:00:00',81399599371,'Rowland','Pennsylvania','Pittsburgh',15205,'https://slashdot.org/maecenas/tincidunt/lacus/at/velit/vivamus.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bsirmond1o','YcRaEO8E2t12','Berri Sirmond','849-81-3766','1994-01-23 00:00:00',81399599372,'Sutherland','Louisiana','Metairie',70033,'https://cpanel.net/ultrices/vel/augue/vestibulum/ante/ipsum.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('darblaster1p','552xxJ','Danyelle Arblaster','233-19-2592','1994-01-13 00:00:00',81399599373,'Dayton','Pennsylvania','Philadelphia',19151,'https://mtv.com/vel/nulla.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ksambath1q','zNCNUJcXW','Krissy Sambath','694-16-5789','1994-06-10 00:00:00',81399599374,'Crowley','Oklahoma','Tulsa',74156,'http://blinklist.com/ante/vel.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bollin1r','BiSpkRa4fmK5','Bobinette Ollin','346-83-7176','1996-07-18 00:00:00',81399599375,'Evergreen','California','Fullerton',92640,'https://msu.edu/ut/rhoncus/aliquet/pulvinar/sed.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('gorneblow1s','HSUbrZ','Ginger Orneblow','333-96-5367','1996-08-28 00:00:00',81399599376,'Derek','Michigan','Grand Rapids',49510,'http://netvibes.com/nulla/facilisi.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ifozzard1t','ER92dyvG','Inness Fozzard','573-82-9839','1996-03-28 00:00:00',81399599377,'Southridge','Mississippi','Meridian',39305,'http://vistaprint.com/mi/nulla.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('shrinchenko1u','zI4INzI5CwP','Sher Hrinchenko','529-23-7485','1995-09-24 00:00:00',81399599378,'Hallows','West Virginia','Huntington',25711,'https://uiuc.edu/eget/rutrum/at/lorem/integer.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('atarbin1v','GfLroNXu','Aluin Tarbin','359-56-0170','1995-07-06 00:00:00',81399599379,'Reindahl','Louisiana','New Orleans',70179,'https://who.int/odio/donec/vitae/nisi/nam.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('acheston1w','9LWctSFNs','Antone Cheston','814-19-1469','1995-02-19 00:00:00',81399599380,'Donald','West Virginia','Charleston',25331,'http://paginegialle.it/orci/mauris/lacinia/sapien.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ndrinnan1x','o2h8h70d','Ned Drinnan','432-84-8276','1995-07-15 00:00:00',81399599381,'Kim','New York','Buffalo',14276,'http://boston.com/sit/amet/sapien/dignissim/vestibulum/vestibulum/ante.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('vhabens1y','U0n6A1j','Veriee Habens','227-27-4907','1995-07-06 00:00:00',81399599382,'Sunfield','Texas','Mesquite',75185,'https://sourceforge.net/lobortis.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('eeby1z','eDpGelbD','Ellwood Eby','847-87-8182','1995-10-15 00:00:00',81399599383,'Buhler','Pennsylvania','Pittsburgh',15261,'http://bloglovin.com/turpis.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('dlower20','BYnPti7Yw','Deborah Lower','141-51-9555','1995-08-15 00:00:00',81399599384,'Moland','New Jersey','New Brunswick',8922,'https://wiley.com/sapien/cum/sociis/natoque.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mannetts21','QKsj1a','Marquita Annetts','655-87-2686','1997-01-08 00:00:00',81399599385,'Walton','Minnesota','Monticello',55565,'http://feedburner.com/turpis/elementum.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('kshowt22','KmHyWA8W6','Kellyann Showt','225-16-3115','1997-10-07 00:00:00',81399599386,'Stephen','California','Los Angeles',90040,'http://msu.edu/venenatis/turpis/enim/blandit/mi.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sdobrowlski23','OENDoLtQRVXn','Staci Dobrowlski','226-44-3746','1997-10-26 00:00:00',81399599387,'Luster','New York','Port Washington',11054,'https://webmd.com/erat/vestibulum/sed/magna.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('zpiscot24','oBshhWsmHvcY','Zaria Piscot','328-77-8059','1997-05-31 00:00:00',81399599388,'Manufacturers','Montana','Billings',59112,'https://nydailynews.com/eget.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('edurbridge25','nuCbNp1M','Ellsworth Durbridge','194-02-3443','1997-10-12 00:00:00',81399599389,'Northport','Missouri','Kansas City',64190,'https://last.fm/a/nibh/in/quis/justo.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ydumblton26','pENBtep','Yorker Dumblton','582-54-6767','1997-05-25 00:00:00',81399599390,'Mendota','Ohio','Cleveland',44111,'https://blogs.com/nec/euismod/scelerisque/quam/turpis/adipiscing/lorem.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('askittrell27','6F08Jjibs','Adore Skittrell','299-30-5210','1997-03-20 00:00:00',81399599391,'Buell','Pennsylvania','Bethlehem',18018,'http://xrea.com/tincidunt/in.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ibrackenridge28','nG9FIeuKYBQ','Inness Brackenridge','693-16-9163','1997-04-21 00:00:00',81399599392,'Homewood','California','Santa Monica',90410,'http://telegraph.co.uk/vel/enim/sit.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mcowap29','xZrPSkDHFmD','Marya Cowap','408-28-9049','1997-04-20 00:00:00',81399599393,'Rutledge','Minnesota','Duluth',55811,'https://pcworld.com/quisque/porta/volutpat/erat.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('rwhorf2a','xSbCKz','Ricardo Whorf','237-85-6810','1997-02-09 00:00:00',81399599394,'Mendota','Washington','Tacoma',98417,'http://ed.gov/tristique.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ebolino2b','647HiHThr9wg','Emera Bolino','239-22-5954','1997-02-02 00:00:00',81399599395,'Oak','Michigan','Grand Rapids',49518,'http://mlb.com/phasellus/id.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('pbruhke2c','c9IyEJ1leuA','Pauli Bruhke','359-09-6493','1997-09-19 00:00:00',81399599396,'Morrow','Oklahoma','Oklahoma City',73152,'http://diigo.com/tortor/duis/mattis/egestas/metus.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('kstrewther2d','tqB0ARVoN','Klemens Strewther','275-96-2205','1997-01-12 00:00:00',81399599397,'Hoepker','Michigan','Saginaw',48604,'http://mashable.com/nulla/tellus/in/sagittis.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('lbernardi2e','MYVkr3ZPkC','Lura Bernardi','595-33-6522','1997-04-13 00:00:00',81399599398,'Tomscot','California','Pasadena',91117,'http://comsenz.com/ridiculus/mus/etiam.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bdewick2f','jwFfCvRYe49N','Brnaby Dewick','629-17-9127','1997-07-23 00:00:00',81399599399,'Rigney','Texas','Tyler',75710,'http://uol.com.br/curae/donec/pharetra/magna/vestibulum.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ugemlbett2g','KR0wxWq','Ulrikaumeko Gemlbett','533-13-7144','1997-08-24 00:00:00',81399599400,'Farwell','New York','Jamaica',11431,'http://dyndns.org/turpis/elementum/ligula/vehicula/consequat/morbi/a.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('rspreadbury2h','laSAUkxsyg','Rich Spreadbury','555-77-7967','1997-07-27 00:00:00',81399599401,'Arapahoe','Pennsylvania','Erie',16534,'http://sina.com.cn/in/sagittis.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('lmatczak2i','zv14Kcy','Lane Matczak','528-27-7845','1997-01-19 00:00:00',81399599402,'Farragut','California','Long Beach',90847,'http://fema.gov/sollicitudin/mi/sit/amet/lobortis/sapien/sapien.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cgreenmon2j','nhANXv9E','Chrystel Greenmon','775-67-2140','1997-02-25 00:00:00',81399599403,'Golden Leaf','Georgia','Marietta',30066,'https://microsoft.com/convallis/morbi/odio/odio/elementum/eu.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('jmcginley2k','Yh77KWx','Jemmy McGinley','567-04-1878','1997-07-18 00:00:00',81399599404,'Kenwood','Hawaii','Honolulu',96820,'https://creativecommons.org/vestibulum/eget/vulputate/ut/ultrices.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bimort2l','AJ9yGVCimo7','Babara Imort','174-21-6819','1997-08-03 00:00:00',81399599405,'Chive','Georgia','Augusta',30905,'https://php.net/nibh/quisque/id/justo/sit/amet.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('atatam2m','GfAOabmV3','Alick Tatam','670-57-4400','1997-01-02 00:00:00',81399599406,'Mariners Cove','Florida','Fort Pierce',34949,'http://icio.us/amet.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ajorger2n','rfN4ZG','Alene Jorger','109-59-8944','1997-08-22 00:00:00',81399599407,'Hallows','New York','Buffalo',14233,'https://sciencedaily.com/morbi/quis/tortor/id/nulla/ultrices.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('lbowen2o','E9CJSi1U','Lorette Bowen','765-53-4509','1997-07-16 00:00:00',81399599408,'Sheridan','Michigan','Lansing',48956,'http://t.co/donec/ut/dolor/morbi/vel/lectus/in.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('myockley2p','tgBvAtB','Margette Yockley','557-85-7731','1997-06-01 00:00:00',81399599409,'Becker','Missouri','Saint Louis',63131,'http://columbia.edu/vitae/quam/suspendisse/potenti.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bdarbey2q','3HGRYSNF','Brigida Darbey','772-31-9443','1997-03-11 00:00:00',81399599410,'Service','Texas','Amarillo',79116,'https://eepurl.com/in/hac/habitasse/platea/dictumst/morbi/vestibulum.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('raubery2r','rFzBnuepwR','Ronny Aubery','770-86-6923','1996-12-28 00:00:00',81399599411,'Maple','Florida','Fort Lauderdale',33305,'https://tinyurl.com/amet/diam/in.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sgaythwaite2s','1tHxeVJjKUS','Shell Gaythwaite','727-97-2552','1997-03-03 00:00:00',81399599412,'Karstens','Rhode Island','Providence',2905,'https://furl.net/sagittis/sapien/cum/sociis/natoque.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('vbortol2t','rfv8rmLMMLeh','Venus Bortol','709-04-7080','1997-03-17 00:00:00',81399599413,'Vernon','New York','Buffalo',14269,'https://soup.io/nibh.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('adebney2u','GxEmFsk8o26A','Athena Debney','457-88-4250','1997-02-06 00:00:00',81399599414,'Bluejay','Florida','Orlando',32819,'https://cdc.gov/vestibulum/ante/ipsum/primis/in.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('egalgey2v','MK1wkw8N8','Eulalie Galgey','164-15-8774','1997-02-25 00:00:00',81399599415,'Clarendon','New Mexico','Albuquerque',87180,'http://e-recht24.de/rhoncus/aliquet/pulvinar/sed/nisl.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('dmyrtle2w','9vaTwj0n1','Douglas Myrtle','793-52-3156','1996-12-27 00:00:00',81399599416,'Green','New York','New York City',10110,'https://technorati.com/rutrum/nulla/tellus/in/sagittis/dui.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('khastilow2x','7LbfSt7b','Kenton Hastilow','358-99-9364','1997-07-31 00:00:00',81399599417,'Twin Pines','Pennsylvania','Harrisburg',17126,'https://photobucket.com/id/turpis/integer/aliquet/massa/id.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('awalasik2y','PsyDeICT2wtt','Annabel Walasik','208-84-7891','1997-05-08 00:00:00',81399599418,'Ilene','Michigan','Flint',48555,'http://usnews.com/bibendum/morbi.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('atsarovic2z','dpx2LWwQcVON','Amelie Tsarovic','611-72-9344','1997-02-20 00:00:00',81399599419,'Dahle','California','Fullerton',92640,'http://posterous.com/in/consequat/ut/nulla/sed/accumsan.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('amathely30','PQXaluOQeK','Allison Mathely','612-35-3435','1997-09-04 00:00:00',81399599420,'Holmberg','Oklahoma','Tulsa',74126,'http://t-online.de/faucibus/accumsan/odio/curabitur/convallis.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('charraway31','CVuhlnR','Caitrin Harraway','708-76-2180','1997-10-19 00:00:00',81399599421,'Surrey','Missouri','Saint Louis',63131,'http://bloomberg.com/pulvinar/sed/nisl/nunc.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('gdalling32','dYToDZzg9e4h','Gisele Dalling','169-92-2478','1997-07-20 00:00:00',81399599422,'Eagle Crest','Missouri','Kansas City',64125,'https://google.co.jp/lacus/curabitur.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('asaiger33','VI1KIsaWq4k','Artus Saiger','129-46-3432','1997-02-18 00:00:00',81399599423,'Hazelcrest','Indiana','Crawfordsville',47937,'http://eventbrite.com/in/libero/ut/massa/volutpat/convallis.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('lfitzpayn34','D1J97wVygFy','Lanni Fitzpayn','550-73-2991','1997-10-21 00:00:00',81399599424,'Swallow','Minnesota','Minneapolis',55436,'http://webnode.com/sem/mauris/laoreet/ut/rhoncus/aliquet/pulvinar.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('opedrol35','AzBirtBZhHM','Oswell Pedrol','223-04-0423','1997-04-18 00:00:00',81399599425,'Ridge Oak','California','Los Angeles',90094,'https://youtube.com/fringilla/rhoncus/mauris.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('egayther36','BEamfKUtip','Elva Gayther','532-50-4926','1997-03-24 00:00:00',81399599426,'Loftsgordon','Florida','Fort Myers',33994,'http://indiegogo.com/morbi/quis.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('jdayce37','TfKvtdoKV2','Jamal Dayce','204-97-8962','1997-05-16 00:00:00',81399599427,'Kedzie','Texas','Fort Worth',76192,'http://bizjournals.com/elit/ac.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sstute38','6qCGGmPqKW','Sawyer Stute','453-04-3002','1997-07-17 00:00:00',81399599428,'Jay','Iowa','Des Moines',50330,'https://va.gov/commodo/vulputate.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('fvakhrushin39','1ipROVTe4w','Fabian Vakhrushin','393-34-9211','1996-12-22 00:00:00',81399599429,'Sundown','Massachusetts','Newton',2458,'http://ehow.com/ut/erat/curabitur/gravida/nisi.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('hrevens3a','TV3qN2JuonUS','Hamid Revens','557-86-4923','1997-03-15 00:00:00',81399599430,'Warner','Texas','San Antonio',78230,'https://opera.com/sed/justo/pellentesque.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ofishe3b','ozpw4UJDlf5e','Olin Fishe','559-53-4375','1997-08-07 00:00:00',81399599431,'Sage','Iowa','Des Moines',50347,'https://addthis.com/cubilia/curae/duis.jsp');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('rstanislaw3c','4xuLjd5Kq','Raviv Stanislaw','788-56-5552','1997-10-16 00:00:00',81399599432,'Badeau','Texas','Dallas',75353,'http://patch.com/nulla/pede/ullamcorper/augue.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cpettifer3d','ux90HZ','Collie Pettifer','740-66-5071','1997-09-30 00:00:00',81399599433,'Grasskamp','Florida','Pompano Beach',33069,'http://ucla.edu/et.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bcroci3e','yXVKvC25','Beatrice Croci','339-70-4855','1998-02-06 00:00:00',81399599434,'Bonner','Wisconsin','Madison',53726,'https://marketwatch.com/in/porttitor.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sjohnsey3f','r0ayNve','Susy Johnsey','307-56-9240','1998-02-24 00:00:00',81399599435,'School','Illinois','Carol Stream',60351,'http://altervista.org/ultrices.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sfrankcombe3g','rJFtqJyx','Sheila Frankcombe','223-19-9876','1998-05-29 00:00:00',81399599436,'Claremont','Texas','Houston',77015,'https://jalbum.net/quis/lectus/suspendisse/potenti/in/eleifend.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ghiers3h','w9Q2GE4Do','Glad Hiers','112-31-1395','1998-09-04 00:00:00',81399599437,'Cambridge','New York','Brooklyn',11254,'http://wordpress.org/ut/volutpat/sapien/arcu/sed.png');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('bkilleen3i','A2UVhHxd','Bianka Killeen','819-56-3525','1998-09-04 00:00:00',81399599438,'Forster','California','Sunnyvale',94089,'http://smh.com.au/sapien/urna/pretium/nisl/ut/volutpat.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('thatchell3j','D56R2dFZSrB','Tracey Hatchell','447-83-7164','1998-06-25 00:00:00',81399599439,'Hermina','Texas','Dallas',75226,'http://ucoz.com/ut/tellus/nulla/ut/erat/id/mauris.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('sharrowell3k','LLq3vt','Sergeant Harrowell','261-57-3950','1998-06-17 00:00:00',81399599440,'Knutson','Oklahoma','Norman',73071,'http://booking.com/morbi/vestibulum/velit/id/pretium.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cteulier3l','VWepTUsN6','Conney Teulier','777-52-0816','1998-08-17 00:00:00',81399599441,'Hoard','Arizona','Glendale',85305,'https://springer.com/amet/diam/in.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('lmcgready3m','juhGcDJ8JV','Lovell McGready','405-05-9326','1998-11-05 00:00:00',81399599442,'Columbus','Illinois','Bloomington',61709,'http://ow.ly/vivamus.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('nmoogan3n','xNvmzL','Nellie Moogan','665-36-3097','1998-01-15 00:00:00',81399599443,'Mendota','New Mexico','Santa Fe',87592,'http://state.gov/id/luctus/nec/molestie/sed/justo/pellentesque.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mdecent3o','yKbQnrXrwGO','Marwin Decent','121-78-7599','1998-09-12 00:00:00',81399599444,'Mariners Cove','Massachusetts','Cambridge',2142,'https://flavors.me/mauris/ullamcorper/purus/sit/amet/nulla/quisque.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('aboole3p','EgNRRdQ','Adriana Boole','250-22-6080','1998-07-11 00:00:00',81399599445,'Northridge','Missouri','Kansas City',64114,'http://dell.com/mus/etiam/vel/augue/vestibulum.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('tprettejohns3q','gBsJAv','Tori Prettejohns','844-13-9046','1998-04-13 00:00:00',81399599446,'Old Shore','Texas','Dallas',75231,'https://de.vu/nunc/nisl/duis/bibendum/felis.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cschneidar3r','XTBeCH','Cherish Schneidar','216-33-8469','1998-05-07 00:00:00',81399599447,'Superior','California','Los Angeles',90071,'http://flavors.me/in/libero/ut.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('adener3s','qVtvoj7ES','Arlen Dener','240-32-9885','1998-11-12 00:00:00',81399599448,'8th','Tennessee','Nashville',37220,'https://prnewswire.com/at/ipsum/ac/tellus.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('nspeeks3t','yvQPfvToRUJ','Nita Speeks','538-13-2513','1997-09-30 00:00:00',81399599449,'Meadow Vale','Texas','Austin',78789,'https://godaddy.com/sapien/urna/pretium/nisl/ut.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mmenauteau3u','pKpJHlFdde3','Myrle Menauteau','271-83-8559','1997-09-24 00:00:00',81399599450,'Jenifer','California','San Francisco',94177,'http://nydailynews.com/augue/luctus.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('fklimus3v','WokoaC','Florida Klimus','491-64-1832','1997-07-25 00:00:00',81399599451,'Scott','Texas','Houston',77030,'http://arizona.edu/nunc/purus/phasellus/in.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('cmaycock3w','tzNrgfFY','Celestyna Maycock','229-36-2308','1997-09-21 00:00:00',81399599452,'Maple Wood','New York','Brooklyn',11210,'http://blogtalkradio.com/nam.html');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('nsplevin3x','DzY6Ue','Nappie Splevin','165-24-6286','1997-07-25 00:00:00',81399599453,'Elmside','New York','Staten Island',10310,'https://bandcamp.com/platea/dictumst/morbi/vestibulum/velit/id/pretium.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('blabba3y','RCZmVuC','Bret Labba','238-18-2746','1997-10-17 00:00:00',81399599454,'Prairie Rose','Florida','Boca Raton',33499,'http://globo.com/velit/nec/nisi/vulputate/nonummy.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('efido3z','kcPSfbNqhy','Ekaterina Fido','295-98-0740','1997-04-01 00:00:00',81399599455,'Eliot','Missouri','Kansas City',64130,'https://i2i.jp/aliquet/maecenas/leo/odio/condimentum.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ckearton40','pJJlY5Qkr56','Chariot Kearton','665-86-1557','1997-08-16 00:00:00',81399599456,'Carpenter','Missouri','Kansas City',64136,'https://theglobeandmail.com/venenatis.js');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('dcallender41','g2sAOL3L5','Dani Callender','731-32-3168','1997-04-11 00:00:00',81399599457,'Golf Course','Massachusetts','Boston',2109,'http://prnewswire.com/nascetur/ridiculus/mus/etiam/vel/augue.jpg');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('mgorvin42','ndAzt3iI','Mair Gorvin','670-70-0381','1997-01-06 00:00:00',81399599458,'Morrow','California','Fresno',93721,'http://de.vu/luctus/ultricies.xml');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ffall43','Gqos83W','Flo Fall','482-16-0954','1997-01-06 00:00:00',81399599459,'Brentwood','Illinois','Springfield',62764,'http://nba.com/lacinia/erat/vestibulum/sed.json');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('ngarman44','OUOnQ27','Norene Garman','455-40-7055','1997-03-04 00:00:00',81399599460,'Eastwood','California','Santa Ana',92725,'http://lycos.com/consectetuer/eget/rutrum.aspx');
INSERT INTO PENGGUNA_USERUMUM (username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('iclementel45','fbnzwv','Imogen Clementel','554-92-4798','1997-10-12 00:00:00',81399599461,'Sage','North Carolina','Raleigh',27615,'https://digg.com/congue/risus.json');





INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2079KU','AX','Tax Accountant',12100000,'abeyne0@indiatimes.com',57,3);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2054VJ','DC','Associate Professor',12200000,'sperrigo1@4shared.com',37,59);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3810YN','VH','Human Resources Assistant I',12300000,'tryley2@amazon.co.uk',55,8);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9877GF','EI','Design Engineer',12400000,'bclawson3@sfgate.com',34,35);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9557IH','VI','Payment Adjustment Coordinator',12500000,'ghane4@zimbio.com',30,16);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9707IX','BW','Engineer I',12600000,'cgiannasi5@hatena.ne.jp',52,22);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2143JI','ML','Registered Nurse',12700000,'fhanscome6@about.me',49,21);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5210OP','NW','Food Chemist',12800000,'bpyrton7@elegantthemes.com',53,31);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4373BY','BK','Accounting Assistant IV',12900000,'jvila8@ehow.com',34,9);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8590SI','HY','General Manager',13000000,'ageldard9@stanford.edu',53,59);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1398GK','SE','Safety Technician IV',13100000,'kfranzinia@noaa.gov',34,25);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8243ER','ZX','Automation Specialist II',13200000,'gmeeseb@cnn.com',47,36);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0698GA','OK','Assistant Manager',13300000,'trucklessec@furl.net',48,58);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1618AD','NW','Professor',13400000,'bfrostd@networksolutions.com',42,13);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0993SA','YC','Account Executive',13500000,'tribeiroe@cafepress.com',38,30);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6245RC','EX','Human Resources Assistant II',13600000,'ebowlandsf@example.com',58,8);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5856ZC','RI','Quality Engineer',13700000,'plorenzg@fastcompany.com',54,21);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4278UD','RU','Senior Cost Accountant',13800000,'sshimonih@cbslocal.com',59,2);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1826SN','DE','Staff Accountant III',13900000,'hlagneauxi@nature.com',33,15);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5401KI','JD','Food Chemist',14000000,'lburgerj@oakley.com',59,57);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0951VY','KN','Compensation Analyst',14100000,'svibertk@simplemachines.org',34,34);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9289AC','BB','Office Assistant III',14200000,'adeboyl@va.gov',59,34);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6671CC','HA','Software Consultant',14300000,'cpembridgem@ucoz.com',30,2);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2525EV','IY','Systems Administrator III',14400000,'nmacascaidhn@tamu.edu',56,60);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9054PS','PR','Environmental Tech',14500000,'sscourgeo@posterous.com',43,24);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3335XI','VS','Director of Sales',14600000,'wfoxleyp@answers.com',33,26);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7532PD','US','Operator',14700000,'bdaughteryq@google.co.uk',58,39);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7425IK','BV','Editor',14800000,'adaveleyr@msn.com',43,29);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2860CJ','GB','Product Engineer',14900000,'uchallisss@microsoft.com',47,45);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3214EX','KU','Human Resources Assistant I',15000000,'lfetherstont@tuttocitta.it',52,28);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7689QR','XH','Administrative Officer',15100000,'rmachanu@unicef.org',60,7);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8985TH','PX','Food Chemist',15200000,'lablev@purevolume.com',30,30);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5644PX','PE','Senior Financial Analyst',15300000,'rblakesleew@cyberchimps.com',38,25);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8479DQ','BL','Automation Specialist III',15400000,'jtadmanx@latimes.com',41,42);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1036VC','JM','Software Engineer III',15500000,'bramptony@miitbeian.gov.cn',34,56);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3033TA','QD','Automation Specialist II',15600000,'sdoddemeedez@liveinternet.ru',31,19);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1469RM','PJ','Marketing Manager',15700000,'sdavson10@cloudflare.com',38,28);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6360RW','JB','Research Nurse',15800000,'jchambers11@cbc.ca',53,25);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3980CK','KZ','Community Outreach Specialist',15900000,'twilkennson12@tumblr.com',33,1);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4362YW','FG','Help Desk Technician',16000000,'rtomney13@csmonitor.com',58,8);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6570VI','NJ','Developer III',16100000,'mfathers14@de.vu',32,21);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9807PF','KU','Registered Nurse',16200000,'rmacgowing15@opera.com',58,58);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5003RC','VV','Office Assistant III',16300000,'fthomazet16@angelfire.com',50,58);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2463FN','IW','Senior Sales Associate',16400000,'eglisane17@google.cn',46,38);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1875PJ','DH','Business Systems Development Analyst',16500000,'bgethyn18@cbsnews.com',59,60);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3409ML','UB','Clinical Specialist',16600000,'gkimbury19@patch.com',40,47);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7624TE','MJ','Staff Scientist',16700000,'tchidgey1a@pbs.org',53,54);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0363OC','LD','Research Assistant II',16800000,'jpues1b@twitpic.com',45,32);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6727ZF','EQ','Marketing Assistant',16900000,'fhenrie1c@google.ca',32,10);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6734OY','HY','Clinical Specialist',17000000,'ktrotton1d@github.com',34,24);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2166MA','FF','Teacher',17100000,'bflecknoe1e@jalbum.net',47,35);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3555UI','XI','Internal Auditor',17200000,'lpacitti1f@china.com.cn',37,12);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5823AR','TJ','Information Systems Manager',17300000,'cgarron1g@dailymail.co.uk',37,34);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9330FF','ON','Senior Editor',17400000,'cmanthorpe1h@jigsy.com',57,38);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4937ZN','XY','Actuary',17500000,'cmorena1i@gravatar.com',45,9);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4143KX','DA','Structural Analysis Engineer',17600000,'ksvanetti1j@arstechnica.com',54,4);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6515EG','YY','Geological Engineer',17700000,'kgrumble1k@digg.com',57,10);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4259WD','UC','Senior Quality Engineer',17800000,'vtwycross1l@webnode.com',41,4);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1187PN','ZH','Actuary',17900000,'lmotte1m@addtoany.com',46,14);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0758QL','SP','Budget/Accounting Analyst I',18000000,'bchatres1n@oaic.gov.au',32,19);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1234ZI','QO','Recruiter',18100000,'skohnert1o@deviantart.com',51,37);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4856OW','DN','Environmental Specialist',18200000,'adomenc1p@lulu.com',52,17);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2161CZ','WH','Assistant Professor',18300000,'eferschke1q@reverbnation.com',30,16);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7164KW','GD','Senior Developer',18400000,'cdallman1r@illinois.edu',40,36);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6958ER','AV','Help Desk Operator',18500000,'kromanelli1s@bandcamp.com',59,54);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1507XO','QU','Dental Hygienist',18600000,'taloshikin1t@com.com',46,31);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2309FU','PY','Account Executive',18700000,'mandretti1u@nytimes.com',46,12);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1280OV','ZK','Nurse',18800000,'lsinclaire1v@weibo.com',32,29);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7300RZ','IP','Research Associate',18900000,'mfrowing1w@bigcartel.com',52,26);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6105MA','US','Assistant Manager',19000000,'alowton1x@typepad.com',54,7);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2292OW','SL','Staff Accountant I',19100000,'sgatty1y@chicagotribune.com',32,15);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0093MY','TI','Database Administrator II',19200000,'mtoretta1z@intel.com',57,32);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3279LB','FV','Financial Advisor',19300000,'lwindrus20@deliciousdays.com',43,54);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1095HB','BL','Senior Developer',19400000,'rbuttle21@eventbrite.com',55,55);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8008DQ','ET','Staff Accountant II',19500000,'ffilchakov22@github.io',32,19);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1727VR','BS','Electrical Engineer',19600000,'gbear23@alibaba.com',49,4);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6837KV','PS','Project Manager',19700000,'dleinweber24@joomla.org',33,44);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1754IP','WQ','Software Engineer IV',19800000,'hhembling25@blogspot.com',60,8);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4886XC','LD','Accountant II',19900000,'mfraschetti26@dell.com',49,40);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1788EY','CW','Graphic Designer',20000000,'smateos27@fastcompany.com',35,44);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8558TG','SA','Physical Therapy Assistant',20100000,'lcolledge28@home.pl',45,42);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0119VU','HK','Geological Engineer',20200000,'sbuttle29@mit.edu',31,33);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2674GV','UI','Senior Sales Associate',20300000,'nbettam2a@imdb.com',51,29);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0967MT','JU','Business Systems Development Analyst',20400000,'dcann2b@archive.org',47,43);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3423IM','GO','Design Engineer',20500000,'aosselton2c@chron.com',51,42);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6344VF','KZ','Web Designer IV',20600000,'ibleibaum2d@gmpg.org',43,0);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8148RO','WQ','Chemical Engineer',20700000,'splues2e@howstuffworks.com',57,23);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7169KV','UT','Programmer I',20800000,'mtwigg2f@t.co',41,16);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0702ZT','YM','Teacher',20900000,'cmoxson2g@chronoengine.com',47,50);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1643BR','JG','Data Coordiator',21000000,'kmerali2h@hugedomains.com',56,36);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7435CC','AK','Staff Scientist',21100000,'ccodman2i@npr.org',45,11);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8989CF','IZ','Automation Specialist I',21200000,'ycalveley2j@pen.io',49,14);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8399MV','UU','Sales Representative',21300000,'glaurisch2k@geocities.com',59,54);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3719AX','NZ','Desktop Support Technician',21400000,'epickering2l@about.com',35,36);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3333VM','NT','Help Desk Operator',21500000,'jsporrij2m@zdnet.com',46,41);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0138PA','IU','Web Developer I',21600000,'gfilippo2n@sina.com.cn',41,60);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8100TU','AV','Office Assistant I',21700000,'spaliser2o@slate.com',50,4);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8918WF','UU','Registered Nurse',21800000,'irose2p@washingtonpost.com',55,49);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0483LO','YI','Research Nurse',21900000,'sgentzsch2q@comsenz.com',33,48);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6996II','AE','Project Manager',22000000,'estenet2r@qq.com',31,32);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0903WH','QH','Biostatistician IV',22100000,'swallbutton2s@amazonaws.com',48,29);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7057VA','IO','VP Quality Control',22200000,'estannard2t@seattletimes.com',45,48);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8894ZS','TH','Quality Control Specialist',22300000,'danglin2u@deviantart.com',34,32);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7646TH','FN','Pharmacist',22400000,'kdurtnall2v@nymag.com',34,18);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8237JP','SC','Engineer I',22500000,'swroath2w@jalbum.net',36,41);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6253NX','CV','GIS Technical Architect',22600000,'remes2x@desdev.cn',32,58);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4526HG','DU','Accounting Assistant III',22700000,'pglassman2y@yolasite.com',58,21);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7052UJ','QF','Internal Auditor',22800000,'jallman2z@com.com',58,42);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3371ML','QS','Research Nurse',22900000,'cgenny30@usa.gov',42,3);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8023DQ','TZ','Quality Control Specialist',23000000,'gnorcliffe31@pbs.org',46,44);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0308XC','FZ','Human Resources Assistant II',23100000,'klarvor32@youtube.com',45,12);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2686PD','ES','Nuclear Power Engineer',23200000,'tjurczyk33@altervista.org',35,24);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6461WL','IG','Marketing Manager',23300000,'rshopcott34@house.gov',59,10);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7239CP','GN','Health Coach I',23400000,'lbaukham35@webnode.com',36,22);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9777EA','EF','Human Resources Manager',23500000,'ehaslin36@psu.edu',57,30);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8858TB','UQ','Help Desk Technician',23600000,'wfarfalameev37@aol.com',59,37);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1950DN','HG','Geological Engineer',23700000,'eanselmi38@smugmug.com',56,6);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3473KF','FV','Librarian',23800000,'nflieg39@macromedia.com',54,14);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9771SH','WC','Biostatistician I',23900000,'slamminam3a@gravatar.com',40,59);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8201GR','FT','Librarian',24000000,'csmithson3b@studiopress.com',55,50);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4654LK','KG','Help Desk Operator',24100000,'ffairham3c@hc360.com',47,48);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0744OP','BP','Clinical Specialist',24200000,'cbails3d@bravesites.com',58,22);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('3695MO','BP','Senior Cost Accountant',24300000,'egrindle3e@howstuffworks.com',30,44);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1888HP','TT','Editor',24400000,'mgwillym3f@ft.com',33,46);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5954QJ','QW','Financial Advisor',24500000,'lelfleet3g@bloglines.com',33,57);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4805BI','SE','Pharmacist',24600000,'isiverns3h@goo.ne.jp',33,42);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8511AF','AX','Software Test Engineer II',24700000,'nmoyce3i@blinklist.com',34,9);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2975EQ','FH','Chemical Engineer',24800000,'cverissimo3j@addthis.com',43,7);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6969LC','IF','General Manager',24900000,'asupple3k@java.com',37,16);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1565VX','JB','Accountant IV',25000000,'kmagor3l@freewebs.com',51,29);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4742VE','GM','Junior Executive',25100000,'pmcterlagh3m@upenn.edu',43,19);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9826XL','CQ','Electrical Engineer',25200000,'dmussett3n@ycombinator.com',47,44);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4191FJ','NB','Nuclear Power Engineer',25300000,'ibravington3o@google.com.br',43,36);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6451VT','RZ','Product Engineer',25400000,'lbolwell3p@seattletimes.com',37,52);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7056ZH','ST','Senior Cost Accountant',25500000,'hyakunkin3q@latimes.com',43,48);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8208BQ','PL','GIS Technical Architect',25600000,'kbrosh3r@umich.edu',34,23);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('9746UI','SF','Design Engineer',25700000,'eivanin3s@dailymotion.com',53,9);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5493UL','OD','Actuary',25800000,'gvonnassau3t@buzzfeed.com',43,49);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('7738DN','FS','Software Consultant',25900000,'pportail3u@unblog.fr',55,53);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6702PZ','ZW','Compensation Analyst',26000000,'twyldbore3v@ebay.co.uk',37,37);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('2259OC','YB','Account Executive',26100000,'mheinssen3w@pinterest.com',55,0);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8925IV','DL','Information Systems Manager',26200000,'eegleton3x@paypal.com',59,58);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('5879VI','PU','Sales Representative',26300000,'srandell3y@furl.net',55,51);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1073GP','WQ','Electrical Engineer',26400000,'dherreran3z@ucoz.com',57,25);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('4967IW','QD','Web Developer II',26500000,'jyakunin40@ucla.edu',45,9);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('1030FG','EF','Accounting Assistant II',26600000,'mmacfall41@surveymonkey.com',41,10);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8393RA','JN','Desktop Support Technician',26700000,'amacneely42@huffingtonpost.com',43,34);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('6458VD','JZ','Assistant Manager',26800000,'bkernock43@hatena.ne.jp',41,23);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('8591GP','ET','Speech Pathologist',26900000,'kohone44@dagondesign.com',37,28);
INSERT INTO POSISI (lowongan_id, posisi_id, namaPosisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatIni) VALUES ('0789LQ','IB','Electrical Engineer',27000000,'creddlesden45@fda.gov',47,3);





INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2079KU', 'AX', 'http://1688.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2054VJ', 'DC', 'http://discuz.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3810YN', 'VH', 'https://xinhuanet.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9877GF', 'EI', 'http://sakura.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9557IH', 'VI', 'http://digg.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9707IX', 'BW', 'http://icq.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2143JI', 'ML', 'http://digg.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5210OP', 'NW', 'https://stanford.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4373BY', 'BK', 'https://va.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8590SI', 'HY', 'http://taobao.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1398GK', 'SE', 'http://princeton.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8243ER', 'ZX', 'http://sciencedaily.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0698GA', 'OK', 'https://seattletimes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1618AD', 'NW', 'http://123-reg.co.uk');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0993SA', 'YC', 'https://deliciousdays.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6245RC', 'EX', 'http://ucoz.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5856ZC', 'RI', 'http://google.com.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4278UD', 'RU', 'http://prlog.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1826SN', 'DE', 'http://storify.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5401KI', 'JD', 'https://google.pl');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0951VY', 'KN', 'http://biblegateway.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9289AC', 'BB', 'http://phpbb.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6671CC', 'HA', 'https://istockphoto.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2525EV', 'IY', 'http://google.cn');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9054PS', 'PR', 'https://boston.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3335XI', 'VS', 'http://slashdot.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7532PD', 'US', 'https://archive.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7425IK', 'BV', 'https://boston.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2860CJ', 'GB', 'http://posterous.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3214EX', 'KU', 'http://mapy.cz');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7689QR', 'XH', 'http://pinterest.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8985TH', 'PX', 'http://jigsy.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5644PX', 'PE', 'https://webs.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8479DQ', 'BL', 'https://merriam-webster.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1036VC', 'JM', 'http://wikipedia.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3033TA', 'QD', 'http://netvibes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1469RM', 'PJ', 'http://topsy.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6360RW', 'JB', 'http://ebay.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3980CK', 'KZ', 'https://tripadvisor.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4362YW', 'FG', 'http://youtu.be');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6570VI', 'NJ', 'http://prlog.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9807PF', 'KU', 'http://sakura.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5003RC', 'VV', 'https://goodreads.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2463FN', 'IW', 'http://newsvine.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1875PJ', 'DH', 'https://nymag.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3409ML', 'UB', 'http://shareasale.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7624TE', 'MJ', 'http://shop-pro.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0363OC', 'LD', 'http://digg.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6727ZF', 'EQ', 'http://myspace.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6734OY', 'HY', 'https://hostgator.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2166MA', 'FF', 'https://blinklist.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3555UI', 'XI', 'https://lycos.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5823AR', 'TJ', 'https://yahoo.co.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9330FF', 'ON', 'http://archive.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4937ZN', 'XY', 'http://cnet.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4143KX', 'DA', 'http://livejournal.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6515EG', 'YY', 'http://edublogs.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4259WD', 'UC', 'http://dropbox.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1187PN', 'ZH', 'https://youtu.be');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0758QL', 'SP', 'https://nps.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1234ZI', 'QO', 'http://cdc.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4856OW', 'DN', 'http://vk.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2161CZ', 'WH', 'https://youtu.be');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7164KW', 'GD', 'https://auda.org.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6958ER', 'AV', 'https://studiopress.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1507XO', 'QU', 'http://myspace.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2309FU', 'PY', 'https://utexas.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1280OV', 'ZK', 'http://ezinearticles.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7300RZ', 'IP', 'http://instagram.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6105MA', 'US', 'http://w3.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2292OW', 'SL', 'https://drupal.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0093MY', 'TI', 'https://japanpost.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3279LB', 'FV', 'https://house.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1095HB', 'BL', 'http://sourceforge.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8008DQ', 'ET', 'http://google.cn');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1727VR', 'BS', 'http://flickr.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6837KV', 'PS', 'http://techcrunch.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1754IP', 'WQ', 'https://shop-pro.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4886XC', 'LD', 'https://toplist.cz');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1788EY', 'CW', 'https://columbia.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8558TG', 'SA', 'http://myspace.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0119VU', 'HK', 'https://tuttocitta.it');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2674GV', 'UI', 'http://aboutads.info');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0967MT', 'JU', 'http://cafepress.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3423IM', 'GO', 'http://wordpress.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6344VF', 'KZ', 'https://auda.org.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8148RO', 'WQ', 'http://arizona.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7169KV', 'UT', 'https://newsvine.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0702ZT', 'YM', 'http://bing.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1643BR', 'JG', 'https://fema.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7435CC', 'AK', 'http://unicef.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8989CF', 'IZ', 'https://chicagotribune.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8399MV', 'UU', 'http://ftc.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3719AX', 'NZ', 'https://oracle.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3333VM', 'NT', 'http://tuttocitta.it');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0138PA', 'IU', 'http://cornell.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8100TU', 'AV', 'http://unesco.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8918WF', 'UU', 'http://privacy.gov.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0483LO', 'YI', 'https://livejournal.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6996II', 'AE', 'https://dot.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0903WH', 'QH', 'https://pen.io');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7057VA', 'IO', 'http://disqus.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8894ZS', 'TH', 'http://csmonitor.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7646TH', 'FN', 'https://twitpic.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8237JP', 'SC', 'http://networkadvertising.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6253NX', 'CV', 'http://nature.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4526HG', 'DU', 'https://privacy.gov.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7052UJ', 'QF', 'https://so-net.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3371ML', 'QS', 'https://jiathis.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8023DQ', 'TZ', 'http://blinklist.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0308XC', 'FZ', 'http://artisteer.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2686PD', 'ES', 'http://prweb.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6461WL', 'IG', 'http://oracle.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7239CP', 'GN', 'https://comcast.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9777EA', 'EF', 'https://trellian.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8858TB', 'UQ', 'https://berkeley.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1950DN', 'HG', 'http://mtv.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3473KF', 'FV', 'https://wikia.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9771SH', 'WC', 'https://buzzfeed.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8201GR', 'FT', 'http://bloomberg.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4654LK', 'KG', 'https://techcrunch.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0744OP', 'BP', 'http://shinystat.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3695MO', 'BP', 'https://discovery.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1888HP', 'TT', 'https://amazon.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5954QJ', 'QW', 'http://instagram.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4805BI', 'SE', 'https://sitemeter.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8511AF', 'AX', 'https://usnews.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2975EQ', 'FH', 'http://wisc.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6969LC', 'IF', 'https://blogs.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1565VX', 'JB', 'http://springer.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4742VE', 'GM', 'http://dedecms.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9826XL', 'CQ', 'http://discuz.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4191FJ', 'NB', 'https://slate.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6451VT', 'RZ', 'http://jiathis.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7056ZH', 'ST', 'http://surveymonkey.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8208BQ', 'PL', 'http://edublogs.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9746UI', 'SF', 'https://mail.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5493UL', 'OD', 'https://psu.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7738DN', 'FS', 'http://nytimes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6702PZ', 'ZW', 'https://umn.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2259OC', 'YB', 'https://narod.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8925IV', 'DL', 'http://unblog.fr');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5879VI', 'PU', 'http://amazonaws.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1073GP', 'WQ', 'https://nationalgeographic.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4967IW', 'QD', 'https://netvibes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1030FG', 'EF', 'http://netlog.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8393RA', 'JN', 'http://cisco.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6458VD', 'JZ', 'https://twitpic.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8591GP', 'ET', 'https://loc.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0789LQ', 'IB', 'http://icq.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2079KU', 'AX', 'https://comsenz.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2054VJ', 'DC', 'http://opera.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3810YN', 'VH', 'http://scribd.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9877GF', 'EI', 'https://auda.org.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9557IH', 'VI', 'https://so-net.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9707IX', 'BW', 'https://webmd.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2143JI', 'ML', 'http://youtu.be');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5210OP', 'NW', 'http://baidu.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4373BY', 'BK', 'http://bandcamp.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8590SI', 'HY', 'https://hugedomains.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1398GK', 'SE', 'http://oakley.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8243ER', 'ZX', 'https://dion.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0698GA', 'OK', 'http://dedecms.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1618AD', 'NW', 'http://cargocollective.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0993SA', 'YC', 'https://exblog.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6245RC', 'EX', 'https://diigo.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5856ZC', 'RI', 'http://discovery.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4278UD', 'RU', 'http://oracle.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1826SN', 'DE', 'http://google.co.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5401KI', 'JD', 'https://cbslocal.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0951VY', 'KN', 'https://mit.edu');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9289AC', 'BB', 'http://webmd.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6671CC', 'HA', 'http://yelp.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2525EV', 'IY', 'https://ovh.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9054PS', 'PR', 'http://sciencedirect.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3335XI', 'VS', 'http://fastcompany.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7532PD', 'US', 'https://mashable.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7425IK', 'BV', 'https://skyrock.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2860CJ', 'GB', 'https://unblog.fr');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3214EX', 'KU', 'http://unesco.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7689QR', 'XH', 'https://ifeng.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8985TH', 'PX', 'http://oakley.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5644PX', 'PE', 'https://nytimes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8479DQ', 'BL', 'https://sphinn.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1036VC', 'JM', 'https://hhs.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3033TA', 'QD', 'https://slideshare.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1469RM', 'PJ', 'https://bravesites.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6360RW', 'JB', 'https://hud.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3980CK', 'KZ', 'https://symantec.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4362YW', 'FG', 'http://macromedia.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6570VI', 'NJ', 'https://yahoo.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9807PF', 'KU', 'http://google.com.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5003RC', 'VV', 'https://sogou.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2463FN', 'IW', 'http://usatoday.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1875PJ', 'DH', 'http://nifty.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3409ML', 'UB', 'http://hatena.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7624TE', 'MJ', 'http://hubpages.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0363OC', 'LD', 'http://elegantthemes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6727ZF', 'EQ', 'https://twitpic.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6734OY', 'HY', 'https://unicef.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2166MA', 'FF', 'http://latimes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3555UI', 'XI', 'https://nbcnews.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5823AR', 'TJ', 'http://mediafire.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9330FF', 'ON', 'http://reuters.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4937ZN', 'XY', 'http://bizjournals.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4143KX', 'DA', 'http://bbb.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6515EG', 'YY', 'https://miitbeian.gov.cn');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4259WD', 'UC', 'http://sciencedaily.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1187PN', 'ZH', 'https://odnoklassniki.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0758QL', 'SP', 'https://hatena.ne.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1234ZI', 'QO', 'http://weather.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4856OW', 'DN', 'https://yelp.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2161CZ', 'WH', 'http://nymag.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7164KW', 'GD', 'http://techcrunch.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6958ER', 'AV', 'https://slideshare.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1507XO', 'QU', 'http://cafepress.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2309FU', 'PY', 'http://cbslocal.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1280OV', 'ZK', 'https://mapy.cz');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7300RZ', 'IP', 'http://redcross.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6105MA', 'US', 'http://globo.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2292OW', 'SL', 'https://google.fr');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0093MY', 'TI', 'https://cbc.ca');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3279LB', 'FV', 'http://webs.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1095HB', 'BL', 'http://msn.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8008DQ', 'ET', 'https://mysql.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1727VR', 'BS', 'https://squidoo.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6837KV', 'PS', 'https://dmoz.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1754IP', 'WQ', 'https://t.co');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4886XC', 'LD', 'https://dagondesign.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1788EY', 'CW', 'http://dropbox.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8558TG', 'SA', 'https://icq.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0119VU', 'HK', 'https://gizmodo.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2674GV', 'UI', 'http://yandex.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0967MT', 'JU', 'http://cdc.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3423IM', 'GO', 'http://tinyurl.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6344VF', 'KZ', 'https://vkontakte.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8148RO', 'WQ', 'http://oracle.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7169KV', 'UT', 'http://rakuten.co.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0702ZT', 'YM', 'https://house.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1643BR', 'JG', 'http://themeforest.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7435CC', 'AK', 'http://blog.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8989CF', 'IZ', 'http://a8.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8399MV', 'UU', 'http://bizjournals.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3719AX', 'NZ', 'http://smugmug.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3333VM', 'NT', 'http://clickbank.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0138PA', 'IU', 'https://vinaora.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8100TU', 'AV', 'https://google.pl');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8918WF', 'UU', 'http://businessinsider.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0483LO', 'YI', 'http://networksolutions.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6996II', 'AE', 'http://wunderground.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0903WH', 'QH', 'http://youtube.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7057VA', 'IO', 'https://sciencedaily.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8894ZS', 'TH', 'https://nytimes.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7646TH', 'FN', 'https://php.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8237JP', 'SC', 'https://meetup.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6253NX', 'CV', 'http://ucoz.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4526HG', 'DU', 'http://nasa.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7052UJ', 'QF', 'http://oaic.gov.au');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3371ML', 'QS', 'https://tripod.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8023DQ', 'TZ', 'https://zimbio.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0308XC', 'FZ', 'https://baidu.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2686PD', 'ES', 'https://answers.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6461WL', 'IG', 'https://ovh.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7239CP', 'GN', 'https://telegraph.co.uk');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9777EA', 'EF', 'http://merriam-webster.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8858TB', 'UQ', 'http://ted.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1950DN', 'HG', 'http://jimdo.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3473KF', 'FV', 'https://google.ca');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9771SH', 'WC', 'https://sohu.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8201GR', 'FT', 'https://dyndns.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4654LK', 'KG', 'https://slideshare.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0744OP', 'BP', 'http://sourceforge.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('3695MO', 'BP', 'https://tinyurl.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1888HP', 'TT', 'http://jugem.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5954QJ', 'QW', 'https://exblog.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4805BI', 'SE', 'https://miibeian.gov.cn');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8511AF', 'AX', 'http://myspace.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2975EQ', 'FH', 'https://webmd.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6969LC', 'IF', 'http://yellowpages.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1565VX', 'JB', 'https://w3.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4742VE', 'GM', 'https://mail.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9826XL', 'CQ', 'https://webs.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4191FJ', 'NB', 'https://ow.ly');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6451VT', 'RZ', 'https://omniture.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7056ZH', 'ST', 'http://nhs.uk');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8208BQ', 'PL', 'http://twitter.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('9746UI', 'SF', 'https://moonfruit.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5493UL', 'OD', 'http://house.gov');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('7738DN', 'FS', 'http://microsoft.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6702PZ', 'ZW', 'http://google.ru');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('2259OC', 'YB', 'http://dedecms.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8925IV', 'DL', 'http://i2i.jp');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('5879VI', 'PU', 'http://un.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1073GP', 'WQ', 'https://php.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('4967IW', 'QD', 'https://archive.org');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('1030FG', 'EF', 'http://php.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8393RA', 'JN', 'http://google.ca');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('6458VD', 'JZ', 'http://theglobeandmail.com');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('8591GP', 'ET', 'http://ovh.net');
INSERT INTO POSISI_KUALIFIKASI(lowongan_id, posisi_id, kualifikasi) VALUES ('0789LQ', 'IB', 'https://eventbrite.com');




ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (no_akta);

ALTER TABLE ONLY history_oc
    ADD CONSTRAINT history_oc_pkey PRIMARY KEY (course_id, username);

ALTER TABLE ONLY kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (nomor_kategori);

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_pkey PRIMARY KEY (lowongan_id);

ALTER TABLE ONLY online_course
    ADD CONSTRAINT online_course_pkey PRIMARY KEY (course_id);

ALTER TABLE ONLY pelamaran
    ADD CONSTRAINT pelamaran_pkey PRIMARY KEY (username, lowongan_id, posisi_id);

ALTER TABLE ONLY pengguna_admin
    ADD CONSTRAINT pengguna_admin_no_ktp_key UNIQUE (no_ktp);

ALTER TABLE ONLY pengguna_admin
    ADD CONSTRAINT pengguna_admin_pkey PRIMARY KEY (username);

ALTER TABLE ONLY pengguna_userumum
    ADD CONSTRAINT pengguna_userumum_no_ktp_key UNIQUE (no_ktp);

ALTER TABLE ONLY pengguna_userumum
    ADD CONSTRAINT pengguna_userumum_pkey PRIMARY KEY (username);

ALTER TABLE ONLY posisi_kualifikasi
    ADD CONSTRAINT posisi_kualifikasi_pkey PRIMARY KEY (lowongan_id, posisi_id, kualifikasi);

ALTER TABLE ONLY posisi
    ADD CONSTRAINT posisi_pkey PRIMARY KEY (lowongan_id, posisi_id);



ALTER TABLE ONLY company
    ADD CONSTRAINT company_verified_by_fkey FOREIGN KEY (verified_by) REFERENCES pengguna_admin(username) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY history_oc
    ADD CONSTRAINT history_oc_course_id_fkey FOREIGN KEY (course_id) REFERENCES online_course(course_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY history_oc
    ADD CONSTRAINT history_oc_username_fkey FOREIGN KEY (username) REFERENCES pengguna_userumum(username) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_company_fkey FOREIGN KEY (company) REFERENCES company(no_akta) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY online_course
    ADD CONSTRAINT online_course_kategori_fkey FOREIGN KEY (kategori) REFERENCES kategori(nomor_kategori) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY online_course
    ADD CONSTRAINT online_course_pembuat_fkey FOREIGN KEY (pembuat) REFERENCES pengguna_admin(username) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY online_course
    ADD CONSTRAINT online_course_penyedia_fkey FOREIGN KEY (penyedia) REFERENCES company(no_akta) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY pelamaran
    ADD CONSTRAINT pelamaran_lowongan_id_fkey FOREIGN KEY (lowongan_id, posisi_id) REFERENCES posisi(lowongan_id, posisi_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY pelamaran
    ADD CONSTRAINT pelamaran_username_fkey FOREIGN KEY (username) REFERENCES pengguna_userumum(username) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY pengguna_admin
    ADD CONSTRAINT pengguna_admin_company_pendaftar_fkey FOREIGN KEY (company_pendaftar) REFERENCES company(no_akta) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY posisi_kualifikasi
    ADD CONSTRAINT posisi_kualifikasi_lowongan_id_fkey FOREIGN KEY (lowongan_id, posisi_id) REFERENCES posisi(lowongan_id, posisi_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY posisi
    ADD CONSTRAINT posisi_lowongan_id_fkey FOREIGN KEY (lowongan_id) REFERENCES lowongan(lowongan_id) ON UPDATE CASCADE ON DELETE CASCADE;



