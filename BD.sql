PGDMP     +                    z            mag    14.5    14.5 M    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16394    mag    DATABASE     `   CREATE DATABASE mag WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE mag;
                postgres    false                        3079    16395 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            ?           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            Y           1247    16406    age    DOMAIN     d   CREATE DOMAIN public.age AS integer
	CONSTRAINT age_client CHECK (((VALUE > 11) AND (VALUE < 81)));
    DROP DOMAIN public.age;
       public          postgres    false            ?           1247    16550    clients    TYPE     W   CREATE TYPE public.clients AS (
	name character varying,
	surname character varying
);
    DROP TYPE public.clients;
       public          postgres    false            ?           1247    16556 
   clienttype    TYPE     n   CREATE TYPE public.clienttype AS (
	id_client integer,
	name character varying,
	surname character varying
);
    DROP TYPE public.clienttype;
       public          postgres    false            ?           1247    16553    feedbacktype    TYPE     ?   CREATE TYPE public.feedbacktype AS (
	id_client integer,
	name character varying,
	surname character varying,
	date_visit date,
	id_services integer
);
    DROP TYPE public.feedbacktype;
       public          postgres    false            ?           1247    16559    specialisttype    TYPE     ?   CREATE TYPE public.specialisttype AS (
	id_specialist integer,
	name character varying,
	surname character varying,
	date_visit date,
	num_client integer
);
 !   DROP TYPE public.specialisttype;
       public          postgres    false            ]           1247    16409    status    DOMAIN     >   CREATE DOMAIN public.status AS character varying(3) NOT NULL;
    DROP DOMAIN public.status;
       public          postgres    false            ?            1255    16573    add_to_log()    FUNCTION     }  CREATE FUNCTION public.add_to_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    mstr varchar(30);
    astr varchar(100);
    retstr varchar(254);
BEGIN
    IF   TG_OP = 'INSERT' THEN
        astr = NEW.name;
        mstr := 'Добавлен новый специалист';
        retstr := mstr || astr;
        INSERT INTO logs(text,added) values (retstr,NOW());
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        astr = NEW.surname;
        mstr := 'Фамилия специалиста изменена';
        retstr := mstr || astr;
        INSERT INTO logs(text,added) values (retstr,NOW());
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        astr = OLD.name;
        mstr := 'Удален специалист ';
        retstr := mstr || astr;
        INSERT INTO logs(text,added) values (retstr,NOW());
        RETURN OLD;
    END IF;
END;
$$;
 #   DROP FUNCTION public.add_to_log();
       public          postgres    false            ?            1255    16562 !   clear_canceled(character varying)    FUNCTION     ?  CREATE FUNCTION public.clear_canceled(provision character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
  DECLARE num INTEGER :=0;
  BEGIN
    SELECT count(*) INTO num FROM public.visit WHERE provision_of_a_service = provision;
	IF 	num = 0 then RAISE NOTICE 'По запросу ничего не найдено'; RETURN 0; END IF;
    DELETE FROM public.visit WHERE provision_of_a_service = provision;
	RAISE NOTICE 'Удалено % строк', num; RETURN num; 
  END;
  
$$;
 B   DROP FUNCTION public.clear_canceled(provision character varying);
       public          postgres    false            ?            1255    16575    client_add_to_log()    FUNCTION     ?  CREATE FUNCTION public.client_add_to_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    mstr varchar(30);
    astr varchar(256);
    retstr varchar(254);
BEGIN
    IF TG_OP = 'DELETE' THEN
        astr = OLD.name|| OLD.surname ||OLD.permanence_status;
        mstr := 'Удален клиент: ';
        retstr := mstr || astr;
        INSERT INTO logs(text,added) values (retstr,NOW());
        RETURN OLD;
    END IF;
END;
$$;
 *   DROP FUNCTION public.client_add_to_log();
       public          postgres    false            ?            1255    16565    countspecialist(date, integer)    FUNCTION     ;  CREATE FUNCTION public.countspecialist(dat_visit date, id_spec integer) RETURNS public.specialisttype[]
    LANGUAGE plpgsql
    AS $$
  DECLARE num INTEGER :=0;
  
  DECLARE x public.visit;
  DECLARE spec specialistType[];
  DECLARE clien feedbackType[];
  DECLARE cou integer;
  BEGIN
    cou := (select count(id_client) FROM PUBLIC.VISIT where date_visit = dat_visit and id_specialist = id_spec
		GROUP by id_specialist );
		spec[0].id_specialist = id_spec;
		spec[0].num_client = cou;
	RAISE NOTICE 'Операция завершена'; 
  return spec;
  END;
 
$$;
 G   DROP FUNCTION public.countspecialist(dat_visit date, id_spec integer);
       public          postgres    false    924            ?            1255    16563    findclient(integer)    FUNCTION     ?  CREATE FUNCTION public.findclient(uid integer) RETURNS public.clienttype[]
    LANGUAGE plpgsql
    AS $$
  Declare num integer:=0;
  Declare x client;
  Declare res clientType[];
  begin
    for x in select * from client
	loop
	  if x.id_client = uid then
	    res[num].id_client = x.id_client;
		res[num].name = x.name;
		res[num].surname = x.surname;
		return res;
	  end if;
	end loop;
  end;
$$;
 .   DROP FUNCTION public.findclient(uid integer);
       public          postgres    false    921            ?            1255    16564    findwithfeedback()    FUNCTION       CREATE FUNCTION public.findwithfeedback() RETURNS public.feedbacktype[]
    LANGUAGE plpgsql
    AS $$
  DECLARE num INTEGER :=0;
  DECLARE x public.visit;
  DECLARE feedback feedbackType[];
  Declare clien clientType[];
  BEGIN
    FOR x  IN select * FROM PUBLIC.VISIT 
	loop
	  if x.custemer_feedback <> ' ' then 
	     clien := findClient(x.id_client); 
		 if clien[0] = null then 
		   raise exception 'Ничего не найдно';
		   return feedback;
		 end if;
	     feedback[num].id_client = clien[0].id_client;	 
		 feedback[num].name = clien[0].name;
		 feedback[num].surname = clien[0].surname;
		 feedback[num].date_visit = x.date_visit;
		 num = num +1;
	  end if;
  
	end loop;
	RAISE NOTICE 'Операция завершена'; 
  return feedback;
  END;
 
$$;
 )   DROP FUNCTION public.findwithfeedback();
       public          postgres    false    918            ?            1255    16561 /   freespec(date, time without time zone, integer)    FUNCTION     ?  CREATE FUNCTION public.freespec(data_visit date, time_ time without time zone, id_specialist integer) RETURNS text
    LANGUAGE plpgsql
    AS $$ 
 	DECLARE num INTEGER; 
    DECLARE x public.visit;
	DECLARE  s text;
	Begin
	num = 0;
	if id_specialist = NULL then
		Raise exception 'Поиск невозможен. Не указан специалист';
	end if;
	for x in SELECT * from public.visit
		loop	  
		  If x.id_specialist = id_specialist and  x.provision_of_a_service = 'Выполнено' and time_ > x.time then 
			s = 'Специалист '|| x.id_specialist ||' в это время был свободен';
		  end if;
		  return s;
		end loop;
    Return 'Специалисты были заняты в это время';
	end;
$$;
 e   DROP FUNCTION public.freespec(data_visit date, time_ time without time zone, id_specialist integer);
       public          postgres    false            ?            1255    16583    get_client(integer)    FUNCTION     )  CREATE FUNCTION public.get_client(uid integer) RETURNS TABLE(uiduser integer, username character varying, surnameuser character varying, phone numeric)
    LANGUAGE plpgsql
    AS $$
 begin
  return query select id_client, name,  surname, phone_number from client where id_client = uid;
 end;
$$;
 .   DROP FUNCTION public.get_client(uid integer);
       public          postgres    false            ?            1255    16560 #   permanenceclient(character varying)    FUNCTION     ?  CREATE FUNCTION public.permanenceclient(status character varying) RETURNS public.clients[]
    LANGUAGE plpgsql
    AS $$ 
 	DECLARE num INTEGER; 
    DECLARE x client;
	DECLARE  res clients[];
	Begin
	num = 0;
	for x in SELECT * from client

		loop	  
		  If x.permanence_status <> status then 
	  	
		  	res[NUM].name = x.name;
			res[NUM].surname = x.surname;
			NUM = NUM + 1;
		  end if;	  
		end loop;
    Return res;
	end;
$$;
 A   DROP FUNCTION public.permanenceclient(status character varying);
       public          postgres    false    915            ?            1255    16566    phonecontrol()    FUNCTION     ?   CREATE FUNCTION public.phonecontrol() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.phone_number < 0 THEN
       RAISE EXCEPTION 'Не введен номер телефона';
    END IF;

    RETURN NEW;
END;

$$;
 %   DROP FUNCTION public.phonecontrol();
       public          postgres    false            ?            1255    16410     price_increase(numeric, numeric)    FUNCTION     ?   CREATE FUNCTION public.price_increase(price numeric, cost_price numeric) RETURNS numeric
    LANGUAGE sql
    AS $$update servis 
SET price = price + 100.0000,
cost_price = cost_price + 100.0000;
select price from servis;$$;
 H   DROP FUNCTION public.price_increase(price numeric, cost_price numeric);
       public          postgres    false            ?            1255    16411    price_minus(numeric, numeric)    FUNCTION     ?   CREATE FUNCTION public.price_minus(price numeric, cost_price numeric) RETURNS numeric
    LANGUAGE sql
    AS $$update servis
set price=price-100.0000,
cost_price = cost_price - 100.0000;
select price from servis;$$;
 E   DROP FUNCTION public.price_minus(price numeric, cost_price numeric);
       public          postgres    false            ?            1255    16412    price_sorting(numeric, numeric)    FUNCTION     ?   CREATE FUNCTION public.price_sorting(price_start numeric, price_end numeric) RETURNS character varying
    LANGUAGE sql
    AS $$select title from servis where price between price_start and price_end;$$;
 L   DROP FUNCTION public.price_sorting(price_start numeric, price_end numeric);
       public          postgres    false            ?            1259    16413    position    TABLE     o   CREATE TABLE public."position" (
    id_position integer NOT NULL,
    title character varying(60) NOT NULL
);
    DROP TABLE public."position";
       public         heap    postgres    false            ?            1259    16416 
   specialist    TABLE     s  CREATE TABLE public.specialist (
    id_specialist integer NOT NULL,
    id_position integer NOT NULL,
    surname character varying(30) NOT NULL,
    name character varying(18) NOT NULL,
    patronymic character varying(25) NOT NULL,
    category character varying(18) NOT NULL,
    phone_number numeric(12,0) NOT NULL,
    the_address character varying(60) NOT NULL
);
    DROP TABLE public.specialist;
       public         heap    postgres    false            ?            1259    16419    about_specialist    VIEW     ?  CREATE VIEW public.about_specialist AS
 SELECT specialist.surname AS "Фамилия специалиста",
    specialist.name AS "Имя специалиста",
    specialist.patronymic AS "Отчество специалсита",
    specialist.category AS "Категория",
    "position".title AS "Должность"
   FROM (public.specialist
     JOIN public."position" ON (("position".id_position = specialist.id_specialist)));
 #   DROP VIEW public.about_specialist;
       public          postgres    false    211    211    211    211    211    210    210            ?            1259    16423    client    TABLE     2  CREATE TABLE public.client (
    id_client integer NOT NULL,
    surname character varying(30) NOT NULL,
    name character varying(20) NOT NULL,
    patronymic character varying(30) NOT NULL,
    date_of_birth date NOT NULL,
    phone_number numeric(12,0),
    permanence_status public.status NOT NULL
);
    DROP TABLE public.client;
       public         heap    postgres    false    861            ?            1259    16428    servis    TABLE       CREATE TABLE public.servis (
    id_services integer NOT NULL,
    id_service_groups integer NOT NULL,
    title character varying(60) NOT NULL,
    price numeric(19,4) NOT NULL,
    cost_price numeric(19,4) NOT NULL,
    description character varying(80) NOT NULL
);
    DROP TABLE public.servis;
       public         heap    postgres    false            ?            1259    16431    visit    TABLE     ?  CREATE TABLE public.visit (
    id_visit integer NOT NULL,
    id_services integer NOT NULL,
    id_specialist integer NOT NULL,
    date_visit date NOT NULL,
    "time" time without time zone NOT NULL,
    provision_of_a_service character varying(10) NOT NULL,
    custemer_feedback character varying(50),
    id_position integer NOT NULL,
    id_service_groups integer NOT NULL,
    id_client integer NOT NULL
);
    DROP TABLE public.visit;
       public         heap    postgres    false            ?            1259    16434    comment    VIEW     ?  CREATE VIEW public.comment AS
 SELECT client.surname AS "Фамилия",
    client.name AS "Имя",
    visit.date_visit AS "Дата посещения",
    servis.title AS "Услуга",
    visit.custemer_feedback AS "Комментарий"
   FROM ((public.visit
     JOIN public.client ON ((client.id_client = visit.id_client)))
     JOIN public.servis ON ((servis.id_services = visit.id_services)));
    DROP VIEW public.comment;
       public          postgres    false    213    215    215    215    215    214    214    213    213            ?            1259    16568    logs    TABLE     S   CREATE TABLE public.logs (
    text text,
    added timestamp without time zone
);
    DROP TABLE public.logs;
       public         heap    postgres    false            ?            1259    16439 	   on_client    VIEW     l  CREATE VIEW public.on_client AS
 SELECT client.id_client AS "ID",
    client.surname AS "Фамилия",
    client.name AS "Имя",
    client.patronymic AS "Отчество",
    client.date_of_birth AS "Дата рождения",
    client.phone_number AS "Контакты",
    client.permanence_status AS "Постоянство"
   FROM public.client;
    DROP VIEW public.on_client;
       public          postgres    false    213    213    213    213    213    213    213    861            ?            1259    16443    on_position    VIEW     ?   CREATE VIEW public.on_position AS
 SELECT "position".id_position AS "ID",
    "position".title AS "Должность"
   FROM public."position";
    DROP VIEW public.on_position;
       public          postgres    false    210    210            ?            1259    16447 	   on_servis    VIEW       CREATE VIEW public.on_servis AS
 SELECT servis.id_services AS "ID",
    servis.title AS "Услуга",
    servis.price AS "Цена",
    servis.cost_price AS "Себестоимость",
    servis.description AS "Описание"
   FROM public.servis;
    DROP VIEW public.on_servis;
       public          postgres    false    214    214    214    214    214            ?            1259    16451    servis_groups    TABLE     x   CREATE TABLE public.servis_groups (
    id_service_groups integer NOT NULL,
    title character varying(25) NOT NULL
);
 !   DROP TABLE public.servis_groups;
       public         heap    postgres    false            ?            1259    16454    on_servis_groups    VIEW     ?   CREATE VIEW public.on_servis_groups AS
 SELECT servis_groups.id_service_groups AS "ID",
    servis_groups.title AS "Группа услуг"
   FROM public.servis_groups;
 #   DROP VIEW public.on_servis_groups;
       public          postgres    false    220    220            ?            1259    16458    on_specialist    VIEW     t  CREATE VIEW public.on_specialist AS
 SELECT specialist.id_position AS "ID",
    specialist.surname AS "Фамилия",
    specialist.name AS "Имя",
    specialist.patronymic AS "Отчество",
    specialist.category AS "Категория",
    specialist.phone_number AS "Контакты",
    specialist.the_address AS "Адрес"
   FROM public.specialist;
     DROP VIEW public.on_specialist;
       public          postgres    false    211    211    211    211    211    211    211            ?            1259    16462    on_visit    VIEW     E  CREATE VIEW public.on_visit AS
 SELECT visit.id_visit AS "ID",
    visit.date_visit AS "Дата посещения",
    visit."time" AS "Время посещения",
    visit.provision_of_a_service AS "Выполнение услуги",
    visit.custemer_feedback AS "Отзыв клиента"
   FROM public.visit;
    DROP VIEW public.on_visit;
       public          postgres    false    215    215    215    215    215            ?            1259    16466    price_servis    VIEW     B  CREATE VIEW public.price_servis AS
 SELECT servis_groups.title AS "Группа услуг",
    servis.title AS "Название услуги",
    servis.cost_price AS "Себестоимость"
   FROM (public.servis_groups
     JOIN public.servis ON ((servis.id_service_groups = servis_groups.id_service_groups)));
    DROP VIEW public.price_servis;
       public          postgres    false    220    214    214    214    220            ?            1259    16470    responsibilities    TABLE     ?   CREATE TABLE public.responsibilities (
    id_service_groups_fk integer NOT NULL,
    id_position_fk integer NOT NULL,
    id_services_fk integer NOT NULL
);
 $   DROP TABLE public.responsibilities;
       public         heap    postgres    false            ?            1259    16473    visit_clients    VIEW       CREATE VIEW public.visit_clients AS
 SELECT client.surname AS "Фамилия клиента",
    client.name AS "Имя клиента",
    client.patronymic AS "Отчество клиента",
    visit.date_visit AS "Дата посещения",
    visit."time" AS "Время посещения",
    servis.title AS "Услуга",
    specialist.surname AS "Фамилия специалиста",
    specialist.name AS "Имя специалиста",
    specialist.patronymic AS "Отчество специалиста"
   FROM (((public.visit
     JOIN public.client ON ((client.id_client = visit.id_visit)))
     JOIN public.servis ON ((visit.id_services = servis.id_services)))
     JOIN public.specialist ON ((visit.id_specialist = specialist.id_specialist)));
     DROP VIEW public.visit_clients;
       public          postgres    false    213    213    211    211    211    211    214    215    215    215    215    215    213    213    214            |          0    16423    client 
   TABLE DATA           v   COPY public.client (id_client, surname, name, patronymic, date_of_birth, phone_number, permanence_status) FROM stdin;
    public          postgres    false    213   ?y       ?          0    16568    logs 
   TABLE DATA           +   COPY public.logs (text, added) FROM stdin;
    public          postgres    false    231   ?|       z          0    16413    position 
   TABLE DATA           8   COPY public."position" (id_position, title) FROM stdin;
    public          postgres    false    210   T}       ?          0    16470    responsibilities 
   TABLE DATA           `   COPY public.responsibilities (id_service_groups_fk, id_position_fk, id_services_fk) FROM stdin;
    public          postgres    false    225   9~       }          0    16428    servis 
   TABLE DATA           g   COPY public.servis (id_services, id_service_groups, title, price, cost_price, description) FROM stdin;
    public          postgres    false    214   ?~                 0    16451    servis_groups 
   TABLE DATA           A   COPY public.servis_groups (id_service_groups, title) FROM stdin;
    public          postgres    false    220   /?       {          0    16416 
   specialist 
   TABLE DATA           ?   COPY public.specialist (id_specialist, id_position, surname, name, patronymic, category, phone_number, the_address) FROM stdin;
    public          postgres    false    211   ??       ~          0    16431    visit 
   TABLE DATA           ?   COPY public.visit (id_visit, id_services, id_specialist, date_visit, "time", provision_of_a_service, custemer_feedback, id_position, id_service_groups, id_client) FROM stdin;
    public          postgres    false    215   ?       ?           2606    16479    client client_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            postgres    false    213            ?           2606    16481    position position_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id_position);
 B   ALTER TABLE ONLY public."position" DROP CONSTRAINT position_pkey;
       public            postgres    false    210            ?           2606    16483 &   responsibilities responsibilities_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.responsibilities
    ADD CONSTRAINT responsibilities_pkey PRIMARY KEY (id_service_groups_fk, id_position_fk, id_services_fk);
 P   ALTER TABLE ONLY public.responsibilities DROP CONSTRAINT responsibilities_pkey;
       public            postgres    false    225    225    225            ?           2606    16485     servis_groups servis_groups_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.servis_groups
    ADD CONSTRAINT servis_groups_pkey PRIMARY KEY (id_service_groups);
 J   ALTER TABLE ONLY public.servis_groups DROP CONSTRAINT servis_groups_pkey;
       public            postgres    false    220            ?           2606    16487    servis servis_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.servis
    ADD CONSTRAINT servis_pkey PRIMARY KEY (id_services);
 <   ALTER TABLE ONLY public.servis DROP CONSTRAINT servis_pkey;
       public            postgres    false    214            ?           2606    16489    specialist specialist_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.specialist
    ADD CONSTRAINT specialist_pkey PRIMARY KEY (id_specialist);
 D   ALTER TABLE ONLY public.specialist DROP CONSTRAINT specialist_pkey;
       public            postgres    false    211            ?           2606    16491    visit visit_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (id_visit);
 :   ALTER TABLE ONLY public.visit DROP CONSTRAINT visit_pkey;
       public            postgres    false    215            ?           1259    16492    fki_id_client_fk    INDEX     G   CREATE INDEX fki_id_client_fk ON public.visit USING btree (id_client);
 $   DROP INDEX public.fki_id_client_fk;
       public            postgres    false    215            ?           1259    16493    fki_id_position_fk    INDEX     K   CREATE INDEX fki_id_position_fk ON public.visit USING btree (id_position);
 &   DROP INDEX public.fki_id_position_fk;
       public            postgres    false    215            ?           1259    16494    fki_id_service_groups_fk    INDEX     X   CREATE INDEX fki_id_service_groups_fk ON public.servis USING btree (id_service_groups);
 ,   DROP INDEX public.fki_id_service_groups_fk;
       public            postgres    false    214            ?           1259    16495    fki_id_services_fk    INDEX     Y   CREATE INDEX fki_id_services_fk ON public.responsibilities USING btree (id_services_fk);
 &   DROP INDEX public.fki_id_services_fk;
       public            postgres    false    225            ?           1259    16496    fki_id_specialist_fk    INDEX     O   CREATE INDEX fki_id_specialist_fk ON public.visit USING btree (id_specialist);
 (   DROP INDEX public.fki_id_specialist_fk;
       public            postgres    false    215            ?           1259    16497    fki_ш    INDEX     F   CREATE INDEX "fki_ш" ON public.specialist USING btree (id_position);
    DROP INDEX public."fki_ш";
       public            postgres    false    211            ?           2620    16574 "   specialist changespecialisttrigger    TRIGGER     ?   CREATE TRIGGER changespecialisttrigger AFTER INSERT OR DELETE OR UPDATE ON public.specialist FOR EACH ROW EXECUTE FUNCTION public.add_to_log();
 ;   DROP TRIGGER changespecialisttrigger ON public.specialist;
       public          postgres    false    211    254            ?           2620    16576    client clientdeltrigger    TRIGGER     x   CREATE TRIGGER clientdeltrigger AFTER DELETE ON public.client FOR EACH ROW EXECUTE FUNCTION public.client_add_to_log();
 0   DROP TRIGGER clientdeltrigger ON public.client;
       public          postgres    false    213    255            ?           2620    16567    client nullphonetrigger    TRIGGER     t   CREATE TRIGGER nullphonetrigger BEFORE INSERT ON public.client FOR EACH ROW EXECUTE FUNCTION public.phonecontrol();
 0   DROP TRIGGER nullphonetrigger ON public.client;
       public          postgres    false    253    213            ?           2606    16498    visit id_client_fk    FK CONSTRAINT     {   ALTER TABLE ONLY public.visit
    ADD CONSTRAINT id_client_fk FOREIGN KEY (id_client) REFERENCES public.client(id_client);
 <   ALTER TABLE ONLY public.visit DROP CONSTRAINT id_client_fk;
       public          postgres    false    215    3274    213            ?           2606    16503    specialist id_position_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.specialist
    ADD CONSTRAINT id_position_fk FOREIGN KEY (id_position) REFERENCES public."position"(id_position);
 C   ALTER TABLE ONLY public.specialist DROP CONSTRAINT id_position_fk;
       public          postgres    false    3269    211    210            ?           2606    16508    visit id_position_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.visit
    ADD CONSTRAINT id_position_fk FOREIGN KEY (id_position) REFERENCES public."position"(id_position);
 >   ALTER TABLE ONLY public.visit DROP CONSTRAINT id_position_fk;
       public          postgres    false    215    210    3269            ?           2606    16513    responsibilities id_position_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.responsibilities
    ADD CONSTRAINT id_position_fk FOREIGN KEY (id_position_fk) REFERENCES public."position"(id_position);
 I   ALTER TABLE ONLY public.responsibilities DROP CONSTRAINT id_position_fk;
       public          postgres    false    3269    225    210            ?           2606    16518    servis id_service_groups_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.servis
    ADD CONSTRAINT id_service_groups_fk FOREIGN KEY (id_service_groups) REFERENCES public.servis_groups(id_service_groups);
 E   ALTER TABLE ONLY public.servis DROP CONSTRAINT id_service_groups_fk;
       public          postgres    false    3284    214    220            ?           2606    16523    visit id_service_groups_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.visit
    ADD CONSTRAINT id_service_groups_fk FOREIGN KEY (id_service_groups) REFERENCES public.servis_groups(id_service_groups);
 D   ALTER TABLE ONLY public.visit DROP CONSTRAINT id_service_groups_fk;
       public          postgres    false    3284    215    220            ?           2606    16528 %   responsibilities id_service_groups_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.responsibilities
    ADD CONSTRAINT id_service_groups_fk FOREIGN KEY (id_service_groups_fk) REFERENCES public.servis_groups(id_service_groups);
 O   ALTER TABLE ONLY public.responsibilities DROP CONSTRAINT id_service_groups_fk;
       public          postgres    false    225    220    3284            ?           2606    16533    visit id_services_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.visit
    ADD CONSTRAINT id_services_fk FOREIGN KEY (id_services) REFERENCES public.servis(id_services);
 >   ALTER TABLE ONLY public.visit DROP CONSTRAINT id_services_fk;
       public          postgres    false    214    3277    215            ?           2606    16538    responsibilities id_services_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.responsibilities
    ADD CONSTRAINT id_services_fk FOREIGN KEY (id_services_fk) REFERENCES public.servis(id_services);
 I   ALTER TABLE ONLY public.responsibilities DROP CONSTRAINT id_services_fk;
       public          postgres    false    214    3277    225            ?           2606    16543    visit id_specialist_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.visit
    ADD CONSTRAINT id_specialist_fk FOREIGN KEY (id_specialist) REFERENCES public.specialist(id_specialist);
 @   ALTER TABLE ONLY public.visit DROP CONSTRAINT id_specialist_fk;
       public          postgres    false    211    3272    215            |   ?  x????n1???S??l???y?nٖ+vm
????	?PX V?$??4?+\??^?/??Ԩ?cs????(zO?hA;????y???&?W??5??????TeȌ?LPEUz烱ک???h_??E<???*??= ???s??Ŕo?mt?????!w?[抮Y
??i?m?\??K?M|??ߐ]??U?-#?7Ԡ??y6q?N???۞7K?G?.?c????
Rf
?Bn????yE_P??tF^@Ǻ???;????VX?Y?/h??H????i9?]?Z?gܓT+?W76?Ъ?4?r???`s?Eb??,ADS?6v??he?L[?+?h?֙.??y"??L,?]+1??.Ԝ?T?ް??Q?+#]q`:-̐?R)?J?x !?B?6??e~???s<L??1??gX???!??P?򭍤?????;He??F?W???}~~b?V$??gIe=RYal?:??C?-aSS?e????]1{)ך??(?w???9%????m?2?%?HcY5?0(?"l?????5?5???h?o???@???a?]o[~?J?A܃?Q???(??z???۟?B?8f?P??9x?D?$'???z1?\???-
QW?l?????W?İ=?.?t)?*?<_?hg??C??!??0J?ڃq???????^??`?m??w?!?jͻ?6??F>???????${	?:??m?՛?j¹??????2???h?????Ǔ??/??L?      ?   ?   x?]???0?k<???;)?,? +?44?Y?DDʏ+?ۈK??ޏ??p?O$?X0 [dz?b????A.?_0J#-:9??H;?̅?*-Q!;&??`??kc??y?W)m??V7?z0???????}???}e????Y?      z   ?   x?m?ARAEםS?Z??p33?,XS??a????ύ?	,\???~?y?A??VZ#jY??T?C?Z?t??Ne??????=l	?ֲ?0?ѧZ???K^??D&هs??5?M???k???a?.ߴuY????S?rsIg????x??Ę??L(??s?cZ??????-?'?O?p?{9??s?9ye??=?Y??A?+??LOޟD?a??      ?   K   x?%?? !C?sR̎A@????XF.?q	?`Tu2????A?`Xuk`3?8?ł?X3???d??*6??_?~$???      }   ?  x??V?N?@=?~?????'?/9???m(Q??
!?????8????7?k;?Ej???ޙy?ޛ1?b ?o???5?IMb????2?/?T????q%?I?????^o???????L&U?4??????+?{?EǠ*??8t'?t?c????/S???"d?p{??G/B??ZUe?AI<??di]?1??R???]?8???T?7????úݵPB?w?8????T?'N?????S{F?מ89̌?؈?M??v-v??oD)???_:?&?gL˳
??nǸ??M???>?&?? ;?¶?SČ?dJ:,?9?Yw??y??Z??\{G%?I!?&\?Q??*?f???vZ?V??Kv?3R??L????va/?}(??8;????:lOH+=???????a??y`.???5S_??Z?????-?4x?!,c?K?]?3?B??	Z ?=6d˨?6?F 8/" l????VJ"k???S ??M??	????2GLÍ?S%??Tsmu?.ȟ?
?/??
Ip???&愘??k?ͩ?@?[2tE?ѧ5I?6??&Iw??:??$?J????NB?? 1QL?)U?͝??4<????(y@??"?|??.??AV??*?c4/t?M????'9?p?_?^b???X???7R??n6?>?0v????n?H?>?В_ډ?#?
??~e?>?????wsʝ=?nJ?G??1??
?I?杓H=??w??ɯ`^?9
L???l?+?w??2??<Ҭ?Nt~??r?{$???s?&??a???J???f??M??X?v?P?D9?Ϲz????7?6?Cv??? ?&G???,%????? ??o??5 ?[??&i@??'h? E?b???????cn/i6???f,???h_J???F         ?   x?e??1DcoW?j(??? ?Ѐ%0X?8Zx???&3ofv8???+.䆎ȓ??w?m???H\??q?H/?#?????{??E?"??߈???A?]??F??[?????*nm֟?ǟ??eax?      {   4  x??Tmn?@?={
 A??^?w?aH"?E??KQ?6Mժ?kNQ?+?ިoƦ?@l?^?Ǜ??ؒ%??????p????s.??rFa??{???%???Wa?!k	?F?	??0??ȇ>NR??ċA??\!o?Ғ?<???8????P?(?? N?#G|?u?4??_?a?w???p#?:Z{??????	?u?3r??????
,??p?n??-z?|?????'֥???$??T?g?I(????h??-?W?F??=?????9? $) ?n???¼?0??????0?/)??oØ????? X??l|b???g@Ļxh???)???)???O$W? ???C??L??>	?i?????N????b?#?5?Ǎ< ?Dz1߸7????*???k??;t?:]?~-???B]??N??MN??	?q??Yhmc????w??=]"?V[0??T1??ny{?F??-u?^t??a#?tC?Ձ?~?[??:g????????X??bq??o??O?AY`?$ui?-Ka?9/?Yc?NQ??X?x?}??????b#bϻ??h??ټc??rW      ~   9  x??T[n?0???B?O?z҇?	r???6??~?@O Rb;?|???:K)?؂=?????p?2J+?-??*?cy?rO|?????-?.??Ή???v???{??K???\?]?v?]?/Xj#~??;W!?w3p?!?Reo???-?VB?'l???6?
?-}??<?57??)C?ҙJ*?A??ѓ?D?ؙ??R?U?|?\???YB?*???yt?R?@??@??A????(?? ??uv??????Y ~w?e:???^??[?^?!?ăl(????L??Sɲ????VvdCK*??(??%P??ǸI?ʿ???p?????F@(Q???R?bT???H͵&m????????[X}????#???)'չtᤄ?Wͭ`o?aw\????폐?N?#?"???f?9??z?6???[g?????????S?Z㽉IR??????(<GNiUx??φ?*?rK|k?%DN?$??	?J?W?jH?tR???46???\o
??b?.?$?(??dbUb?E??+?E7^bl1!۠?Ʒ?G1??D?%?4?A??o&???D???ޛ     