--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auto (
    id integer NOT NULL,
    fornitore character varying(200) NOT NULL,
    modello character varying(500) NOT NULL,
    anno integer,
    prezzo double precision,
    colore character varying(200),
    targa character varying(20),
    chilometraggio integer,
    data_importazione timestamp without time zone
);


ALTER TABLE public.auto OWNER TO postgres;

--
-- Name: auto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auto_id_seq OWNER TO postgres;

--
-- Name: auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auto_id_seq OWNED BY public.auto.id;


--
-- Name: import_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_log (
    id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    "timestamp" timestamp without time zone,
    records_imported integer,
    success boolean,
    error_message text
);


ALTER TABLE public.import_log OWNER TO postgres;

--
-- Name: import_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.import_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.import_log_id_seq OWNER TO postgres;

--
-- Name: import_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.import_log_id_seq OWNED BY public.import_log.id;


--
-- Name: auto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto ALTER COLUMN id SET DEFAULT nextval('public.auto_id_seq'::regclass);


--
-- Name: import_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_log ALTER COLUMN id SET DEFAULT nextval('public.import_log_id_seq'::regclass);


--
-- Data for Name: auto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auto (id, fornitore, modello, anno, prezzo, colore, targa, chilometraggio, data_importazione) FROM stdin;
1320	Alpina	500 Bev Hatchback My24 500e -320 Berlina	\N	26900	Nero Cinema (pastello)	GV952MP	\N	2025-03-25 22:17:20.303299
1321	Alpina	500 Hatchback My23 500 1.0 70Cv Hybrid	\N	16200	Verde Rugiada	RJJ57398	\N	2025-03-25 22:17:20.307006
1322	Alpina	500 Hatchback My23 500 1.0 70Cv Hybrid	\N	16200	Verde Rugiada	RJJ41011	\N	2025-03-25 22:17:20.308177
1323	Alpina	500 My24 500 1.0 70 Cv Hybrid	\N	14700	Nero Vesuvio	GV016GR	11593	2025-03-25 22:17:20.308992
1324	Alpina	500 My24 500 1.0 70 Cv Hybrid	\N	\N	NERO CARBONIO	GV273KG	20436	2025-03-25 22:17:20.30996
1325	Alpina	500 My24 500 1.0 70 Cv Hybrid	\N	14900	Verde Rugiada	GV736KH	13545	2025-03-25 22:17:20.311531
1326	Alpina	500 My24 500 1.0 70 Cv Hybrid	\N	\N	Blu dipinto di blu	GT227ZM	17461	2025-03-25 22:17:20.312782
1327	Alpina	500 My24 500 1.0 70 Cv Hybrid	\N	14700	Nero Vesuvio	GV772KG	15719	2025-03-25 22:17:20.313786
1328	Alpina	500 My24 500 1.0 70 Cv Hybrid	\N	14700	Nero Vesuvio	GT294ZK	18124	2025-03-25 22:17:20.314634
1329	Alpina	500 My24 500 1.0 70 Cv HybridDolcevita	\N	15500	Rosso Passione	GT255NW	9562	2025-03-25 22:17:20.315432
1330	Alpina	5008 1.5 bluehdi Allure Pack s&s 130cv eat8	\N	27900	BLUE CELEBES	GP961FA	19317	2025-03-25 22:17:20.316567
1331	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	\N	BIANCO CALDO	GV082NX	14094	2025-03-25 22:17:20.31805
1332	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	15900	BIANCO CALDO	GT383ZK	11360	2025-03-25 22:17:20.319161
1333	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	\N	Nero Vesuvio	GV074NX	13353	2025-03-25 22:17:20.320026
1334	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	15900	BIANCO NEVE	GV755NN	15832	2025-03-25 22:17:20.320814
1335	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	15900	Blu dipinto di blu	GV933EZ	13335	2025-03-25 22:17:20.321605
1336	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	\N	Nero Vesuvio	GV915NP	13013	2025-03-25 22:17:20.323128
1337	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	\N	Nero Vesuvio	GT142ZK	20100	2025-03-25 22:17:20.324179
1338	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid	\N	17200	BIANCO NEVE	GV302FA	9419	2025-03-25 22:17:20.325354
1339	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid Dolcevita	\N	17200	BIANCO CALDO	GT295NV	9277	2025-03-25 22:17:20.326388
1340	Alpina	500c My24 500 Cabrio 1.0 70 CvHybrid Dolcevita	\N	17200	Blu dipinto di blu	GT893NT	11042	2025-03-25 22:17:20.327346
1341	Alpina	500e 500e Turismo	\N	29900	Poison Blue	GM231YW	\N	2025-03-25 22:17:20.32861
1342	Alpina	500x Dolcevita My22 1.5 Hybrid130cv Dct Cross Dolcevita	\N	24900	Bianco Gelato (pastello)	GL342MC	\N	2025-03-25 22:17:20.330185
1343	Alpina	595 & 695 My23 595 1.4 Turbo T-Jet 165cv	\N	21900	Nero Vesuvio	GV907NW	10804	2025-03-25 22:17:20.331227
1344	Alpina	600 1.2 Hybrid 100cv	\N	23800	Nero Cinema (pastello)	GV080MN	\N	2025-03-25 22:17:20.332236
1345	Alpina	600 1.2 Hybrid 100cv	\N	23800	Nero Cinema (pastello)	GT361KB	\N	2025-03-25 22:17:20.333078
1346	Alpina	600 600e - La Prima	\N	29900	Arancio sole d'Italia	GR039MP	6099	2025-03-25 22:17:20.333933
1347	Alpina	600 600e - La Prima	\N	29900	Arancio sole d'Italia	GR739MR	\N	2025-03-25 22:17:20.335398
1348	Alpina	600 600e - Red	\N	24900	Rosso Passione	GR958MP	\N	2025-03-25 22:17:20.336636
1349	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	Sabbia Terra d'Italia 	GV951MP	\N	2025-03-25 22:17:20.337708
1350	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	Sabbia Terra d'Italia 	GV950MP	\N	2025-03-25 22:17:20.33852
1351	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	Nero Cinema (pastello)	GV972MP	\N	2025-03-25 22:17:20.339302
1352	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	Nero Cinema (pastello)	GV963MP	\N	2025-03-25 22:17:20.340312
1353	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	BIANCO CALDO	GV965MP	\N	2025-03-25 22:17:20.342125
1354	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	BIANCO CALDO	GV968MP	\N	2025-03-25 22:17:20.343236
1355	Alpina	600 Hybrid My25 600 1.2 Hybrid100cv	\N	23800	Verde Mare	GV966MP	\N	2025-03-25 22:17:20.344198
1356	Alpina	600 La Prima Hybrid 100cv	\N	25900	Verde Mare	GT012KA	\N	2025-03-25 22:17:20.345049
1357	Alpina	Avenger Bev Avenger Summit 100% Elettrica	\N	29900	Granite + tetto nero	GR810MP	\N	2025-03-25 22:17:20.345924
1358	Alpina	Avenger Bev Avenger Summit 100% Elettrica	\N	29900	Sun+tetto Volcano	GR809MP	\N	2025-03-25 22:17:20.347688
1359	Alpina	Avenger Bev Avenger Summit 100% Elettrica	\N	35900	Sun+tetto Volcano	GR147MR	0	2025-03-25 22:17:20.34891
1360	Alpina	Avenger Bev Avenger Summit 100% Elettrica	\N	29900	Sun+tetto Volcano	GR104MR	\N	2025-03-25 22:17:20.349723
1361	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GW289PC	\N	2025-03-25 22:17:20.350503
1362	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Granite	GT695KB	\N	2025-03-25 22:17:20.351293
1363	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GT498KB	\N	2025-03-25 22:17:20.352368
1364	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Granite	GT512KB	\N	2025-03-25 22:17:20.353812
1365	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Solid Black	GW279PC	\N	2025-03-25 22:17:20.354777
1366	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GW288PC	\N	2025-03-25 22:17:20.35559
1367	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	22900	Solid Black	GT308KB	\N	2025-03-25 22:17:20.356404
1368	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Stone	GW273PC	\N	2025-03-25 22:17:20.357224
1369	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GW285PC	\N	2025-03-25 22:17:20.358038
1370	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GT511KB	\N	2025-03-25 22:17:20.359878
1371	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Granite	GT497KB	\N	2025-03-25 22:17:20.361262
1372	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Stone	GW275PC	\N	2025-03-25 22:17:20.362247
1373	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Granite	GT696KB	\N	2025-03-25 22:17:20.363056
1374	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GW287PC	\N	2025-03-25 22:17:20.363854
1375	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	SNOW	GW282PC	\N	2025-03-25 22:17:20.365178
1376	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Solid Black	GW286PC	\N	2025-03-25 22:17:20.366637
1377	Alpina	Avenger Ice My24 Avenger Altitude 1.2 100cv	\N	23900	Solid Black	GW280PC	\N	2025-03-25 22:17:20.367536
1378	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Granite	GV856MP	\N	2025-03-25 22:17:20.368323
1379	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Solid Black	GV882MP	\N	2025-03-25 22:17:20.369101
1380	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21000	Solid Black	GV633MN	\N	2025-03-25 22:17:20.369876
1381	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Granite	GV852MP	\N	2025-03-25 22:17:20.371395
1382	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	RUBY	GV866MP	\N	2025-03-25 22:17:20.372791
1383	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	RUBY	GV869MP	\N	2025-03-25 22:17:20.373701
1384	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21000	Stone	GV871MN	\N	2025-03-25 22:17:20.374495
1385	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Solid Black	GV881MP	\N	2025-03-25 22:17:20.37529
1386	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	Stone	GV870MP	\N	2025-03-25 22:17:20.376068
1387	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Stone	GV854MP	\N	2025-03-25 22:17:20.377383
1388	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Solid Black	GV859MP	\N	2025-03-25 22:17:20.378679
1389	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Granite	GV872MP	\N	2025-03-25 22:17:20.379619
1390	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21000	Stone	GV885MP	\N	2025-03-25 22:17:20.380523
1391	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Granite	GV878MP	\N	2025-03-25 22:17:20.38133
1392	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	Granite	GV865MP	\N	2025-03-25 22:17:20.38212
1393	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	Solid Black	GV871MP	\N	2025-03-25 22:17:20.38348
1394	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Stone	GV858MP	\N	2025-03-25 22:17:20.384909
1395	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	20500	RUBY	GV581MN	\N	2025-03-25 22:17:20.385826
1396	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21000	Stone	GV892MN	\N	2025-03-25 22:17:20.386618
1397	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Solid Black	GV876MP	\N	2025-03-25 22:17:20.387394
1398	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	SNOW	GV850MP	\N	2025-03-25 22:17:20.388191
1399	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	SNOW	GV851MP	\N	2025-03-25 22:17:20.389585
1400	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23100	RUBY	GW297PC	\N	2025-03-25 22:17:20.390924
1401	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Stone	GV877MP	\N	2025-03-25 22:17:20.391718
1402	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	SNOW	GV857MP	\N	2025-03-25 22:17:20.392515
1403	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	SNOW	GV830MP	\N	2025-03-25 22:17:20.393334
1404	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	Stone	GV884MP	\N	2025-03-25 22:17:20.394125
1405	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21000	Stone	GV870MN	\N	2025-03-25 22:17:20.395397
1406	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Solid Black	GV849MP	\N	2025-03-25 22:17:20.39665
1407	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Granite	GV861MP	\N	2025-03-25 22:17:20.397687
1408	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	RUBY	GV873MP	\N	2025-03-25 22:17:20.398609
1409	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	23150	Granite	GV879MP	\N	2025-03-25 22:17:20.399389
1410	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Stone	GV862MP	\N	2025-03-25 22:17:20.40016
1411	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	22900	Stone	GV875MP	\N	2025-03-25 22:17:20.401203
1412	Alpina	Avenger Ice My24 Avenger Longitude 1.2 100cv	\N	21900	Granite	GV883MP	\N	2025-03-25 22:17:20.402734
1413	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	SNOW	RJL36550	\N	2025-03-25 22:17:20.403806
1414	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL36611	\N	2025-03-25 22:17:20.404676
1415	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL36702	\N	2025-03-25 22:17:20.405453
1416	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Granite	GV483MM	\N	2025-03-25 22:17:20.406239
1417	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Solid Black	RJL27370	\N	2025-03-25 22:17:20.407326
1418	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL36596	\N	2025-03-25 22:17:20.40874
1419	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Stone con Tetto Volcano	GT500KB	\N	2025-03-25 22:17:20.409686
1420	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	BIANCO NEVE	RJL30582	\N	2025-03-25 22:17:20.410461
1421	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL26939	\N	2025-03-25 22:17:20.411244
1422	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Solid Black	RJL23676	\N	2025-03-25 22:17:20.41202
1423	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Solid Black	RJL25654	\N	2025-03-25 22:17:20.412954
1424	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Solid Black	RJL23646	\N	2025-03-25 22:17:20.414497
1425	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL27042	\N	2025-03-25 22:17:20.415701
1426	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Stone	GV885MN	\N	2025-03-25 22:17:20.416693
1427	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Solid Black	RJL23301	\N	2025-03-25 22:17:20.417535
1428	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL36732	\N	2025-03-25 22:17:20.418337
1429	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL26926	\N	2025-03-25 22:17:20.419428
1430	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Stone	GV891MN	\N	2025-03-25 22:17:20.4209
1431	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Solid Black	RJL28094	\N	2025-03-25 22:17:20.42189
1432	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL36537	\N	2025-03-25 22:17:20.422667
1433	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Granite	GV482MM	\N	2025-03-25 22:17:20.423437
1434	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Stone	GV460MM	\N	2025-03-25 22:17:20.424266
1435	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25900	Granite	RJL27041	\N	2025-03-25 22:17:20.425456
1436	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	25500	Stone	GV462MM	\N	2025-03-25 22:17:20.426743
1437	Alpina	Avenger Ice My24 Avenger Summit 1.2 100cv	\N	26900	Granite	GV883MN	\N	2025-03-25 22:17:20.427592
1438	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW283PC	\N	2025-03-25 22:17:20.428365
1439	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW293PC	\N	2025-03-25 22:17:20.429134
1440	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Stone	GW277PC	\N	2025-03-25 22:17:20.429904
1441	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW300PC	\N	2025-03-25 22:17:20.430756
1442	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW274PC	\N	2025-03-25 22:17:20.432278
1443	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Stone	GW296PC	\N	2025-03-25 22:17:20.433559
1444	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW284PC	\N	2025-03-25 22:17:20.434569
1445	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW291PC	\N	2025-03-25 22:17:20.435398
1446	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW353PC	\N	2025-03-25 22:17:20.436184
1447	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW281PC	\N	2025-03-25 22:17:20.437144
1448	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW385PC	\N	2025-03-25 22:17:20.438571
1449	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW298PC	\N	2025-03-25 22:17:20.439841
1450	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Stone	GW276PC	\N	2025-03-25 22:17:20.440843
1451	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW290PC	\N	2025-03-25 22:17:20.441912
1452	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW294PC	\N	2025-03-25 22:17:20.44273
1453	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW295PC	\N	2025-03-25 22:17:20.444068
1454	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW302PC	\N	2025-03-25 22:17:20.445366
1455	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW278PC	\N	2025-03-25 22:17:20.446299
1456	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Granite	GW299PC	\N	2025-03-25 22:17:20.447107
1457	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Solid Black	GW301PC	\N	2025-03-25 22:17:20.447891
1458	Alpina	Avenger Ice My25 Avenger Longitude 1.2 100cv	\N	23100	Stone	GW292PC	\N	2025-03-25 22:17:20.448727
1459	Alpina	Avenger Mhev Avenger Altitude1.2 100cv Dct Mhev	\N	27900	SNOW	GV812MP	\N	2025-03-25 22:17:20.450185
1460	Alpina	Avenger Mhev Avenger Altitude1.2 100cv Dct Mhev	\N	27900	SNOW	GV811MP	\N	2025-03-25 22:17:20.451566
1461	Alpina	Avenger Mhev Avenger Longitude1.2 100cv Dct Mhev	\N	25900	Stone	GV630MM	\N	2025-03-25 22:17:20.452573
1462	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Solid Black	GW315PC	\N	2025-03-25 22:17:20.453425
1463	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Solid Black	GW307PC	\N	2025-03-25 22:17:20.454217
1464	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Solid Black	GW310PC	\N	2025-03-25 22:17:20.455027
1465	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Solid Black	GW309PC	\N	2025-03-25 22:17:20.456377
1466	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Stone	GW308PC	\N	2025-03-25 22:17:20.457681
1467	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Granite	GW312PC	\N	2025-03-25 22:17:20.458499
1468	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Granite	GW313PC	\N	2025-03-25 22:17:20.459286
1469	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Granite	GW311PC	\N	2025-03-25 22:17:20.460068
1470	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Granite	GW314PC	\N	2025-03-25 22:17:20.460844
1471	Alpina	Avenger Mhev My25 Avenger Summit 1.2 100cv Dct Mhev	\N	28900	Granite	GW316PC	\N	2025-03-25 22:17:20.462116
1472	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	31900	Solid Black	GT817CC	\N	2025-03-25 22:17:20.463524
1473	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	32500	Blue shade	GV873MN	\N	2025-03-25 22:17:20.464424
1474	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	32500	Solid Black	GV872MN	\N	2025-03-25 22:17:20.465215
1475	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	32500	Alpine White	GV887MN	\N	2025-03-25 22:17:20.465989
1476	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	33800	Alpine White	GW143PC	\N	2025-03-25 22:17:20.466762
1477	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	33800	Alpine White	GW144PC	\N	2025-03-25 22:17:20.468022
1478	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	31900	Blue shade	GT815CC	\N	2025-03-25 22:17:20.469294
1479	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	35900	Alpine White	GT324KB	\N	2025-03-25 22:17:20.470469
1480	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	35900	Graphite Grey	GT350KB	\N	2025-03-25 22:17:20.47152
1481	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	33900	Graphite Grey	GW317PC	\N	2025-03-25 22:17:20.472365
1482	Alpina	Compass E-Hybrid My24 Altitude1.5 Turbo T4 E-Hybrid 130cv Fw	\N	31900	Graphite Grey	GT769CB	\N	2025-03-25 22:17:20.473176
1483	Alpina	Compass My23 Limited 1.6 Diesel 130hp Mt Fwd E6.4	\N	33900	Graphite Grey	GT613KB	\N	2025-03-25 22:17:20.474978
1484	Alpina	Compass PHEV 1.3 Turbo 190cv 4xe At6 Limited S2	\N	25900	Solid Black	GJ067YK	13350	2025-03-25 22:17:20.475985
1485	Alpina	Compass PHEV 1.3 Turbo 190cv 4xe At6 Limited S2	\N	25900	Blue shade	GK552ZB	24060	2025-03-25 22:17:20.476782
1486	Alpina	Compass PHEV 1.3 Turbo T4 4xe AT6 190cv Night Eagle	\N	32900	Solid Black	GP782WB	\N	2025-03-25 22:17:20.477587
1487	Alpina	Compass PHEV 1.3 Turbo T4 4xe AT6 190cv Night Eagle	\N	32900	Graphite Grey	GR152MR	\N	2025-03-25 22:17:20.47836
1488	Alpina	Compass Plug-In Hybrid My22 Upland 1.3 Turbo T4 Phev 4xe At6	\N	40900	Matter Azur con tetto nero	GT512KA	\N	2025-03-25 22:17:20.479135
1489	Alpina	Compass Plug-In Hybrid My25 North Star 1.3 Turbo T4 Phev 4xe	\N	40450	Techno Green + tetto nero	GW258PC	\N	2025-03-25 22:17:20.480588
1490	Alpina	Corsa 1.2 Elegance s&s 100cv	\N	12900	GRIS ALUMINIUM	GK041KP	29621	2025-03-25 22:17:20.481911
1491	Alpina	DELIVER 9 VAN L3H3 N1 (FWD) STANDARD MY22	\N	29900	WHITE	GV313MN	\N	2025-03-25 22:17:20.482803
1492	Alpina	DELIVER 9 VAN L3H3 N1 (FWD) STANDARD MY22	\N	29900	WHITE	GV314MN	\N	2025-03-25 22:17:20.483582
1493	Alpina	DELIVER 9 VAN L3H3 N1 (FWD) STANDARD MY22	\N	29900	WHITE	GV315MN	\N	2025-03-25 22:17:20.484354
1494	Alpina	DELIVER 9 VAN L3H3 N1 (FWD) STANDARD MY22	\N	29900	WHITE	GT432KB	\N	2025-03-25 22:17:20.485136
1495	Alpina	Doblò Serie 2 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	24600	BIANCO PASTELLO	GV628MN	\N	2025-03-25 22:17:20.486774
1496	Alpina	Doblò Serie 2 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	27400	BIANCO PASTELLO	GT409KB	\N	2025-03-25 22:17:20.488465
1497	Alpina	Doblò Serie 2 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	23900	GRIGIO CHIARO METALIZZATO	GV454MM	10	2025-03-25 22:17:20.489735
1498	Alpina	Doblò Serie 2 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	24300	BIANCO PASTELLO	GV109MN	\N	2025-03-25 22:17:20.490679
1499	Alpina	Doblò Serie 2 Van Ch1 1.5 Bluehdi 130cv Mt6	\N	26100	BIANCO PASTELLO	GV866MN	\N	2025-03-25 22:17:20.491756
1500	Alpina	Doblò Serie 2 Van Ch1 1.5 Bluehdi 130cv Mt6	\N	26100	BIANCO PASTELLO	GV863MN	\N	2025-03-25 22:17:20.493364
1501	Alpina	Doblò Serie 3 Crew Cab 1.5 Bluehdi 100cv Mt6	\N	30100	GRIGIO CHIARO METALIZZATO	GV808MP	\N	2025-03-25 22:17:20.494404
1502	Alpina	Doblò Serie 3 Crew Cab 1.5 Bluehdi 100cv Mt6	\N	30100	BIANCO PASTELLO	GV809MP	\N	2025-03-25 22:17:20.495193
1503	Alpina	Doblò Serie 3 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	24800	BIANCO PASTELLO	GW121PC	\N	2025-03-25 22:17:20.49597
1504	Alpina	Doblò Serie 3 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	23900	BIANCO PASTELLO	GV937MN	\N	2025-03-25 22:17:20.496764
1505	Alpina	Doblò Serie 3 Van Ch1 1.5 Bluehdi 100cv Mt6	\N	23900	BIANCO PASTELLO	GV936MN	\N	2025-03-25 22:17:20.497853
1506	Alpina	DR 3.0  1.5 BZ/GPL	\N	0	INK BLACK	GW306PC	\N	2025-03-25 22:17:20.49958
1507	Alpina	Ducato Serie 2 Furgone Lastrato 35q Mh2 140cv 2.2 Multijet 3	\N	37000	BIANCO PASTELLO	GV213MM	\N	2025-03-25 22:17:20.500513
1508	Alpina	Ducato Series 9 Furgone Lastrato 35q Mh2 140cv 2.2 Multijet 	\N	37900	BIANCO PASTELLO	GT313CC	\N	2025-03-25 22:17:20.501287
1509	Alpina	EVO 6 1.5 TGDI (gpl)	\N	29500	Jade Green	GV575MN	\N	2025-03-25 22:17:20.502071
1510	Alpina	Evo Cross 4 2.0 Turbo Diesel Doppia Cabina 4x4	\N	27500	RED	GV275MN	\N	2025-03-25 22:17:20.502889
1511	Alpina	Giulia My24 Diesel 210 Cv Tributo Italiano	\N	54900	Bianco Alfa	GT536KB	\N	2025-03-25 22:17:20.503849
1512	Alpina	Gladiator My23 Overland 3.0 Ds264cv At8	\N	62900	Sting Gray	GV106MN	\N	2025-03-25 22:17:20.505361
1513	Alpina	Grand Cherokee Plug-In HybridMy24 424 Summit Reserve 2.0 4xe	\N	82900	Midnight Skycon con tetto nero	R8577380	\N	2025-03-25 22:17:20.506353
1514	Alpina	HS ICE 1.5T DCT COMFORT	\N	18990	Medal Silver	GN259YL	21926	2025-03-25 22:17:20.507367
1515	Alpina	MG HS 1.5T DCT 2WD LUX LHD	\N	\N	SILVER	GT262XG	11610	2025-03-25 22:17:20.508194
1516	Alpina	MG HS 1.5T DCT 2WD LUX LHD	\N	\N	WHITE	GT259XG	28199	2025-03-25 22:17:20.508997
1517	Alpina	MG HS 1.5T MT 2WD COM LHD	\N	\N	Black	GS665JK	24442	2025-03-25 22:17:20.510009
1518	Alpina	MG HS 1.5T MT 2WD COM LHD	\N	21900	WHITE	GT518KB	\N	2025-03-25 22:17:20.511556
1519	Alpina	MG HS 1.5T MT COM 2WD	\N	18500	WHITE	GN014FN	21255	2025-03-25 22:17:20.512557
1520	Alpina	MG HS 1.5T MT DEL 2WD	\N	\N	WHITE	GS667JK	17342	2025-03-25 22:17:20.513366
1521	Alpina	MG NEW HS PHEV LUX	\N	34900	Hampstead grey	GV112MN	\N	2025-03-25 22:17:20.514331
1522	Alpina	MG ZS 1.0T 6MT LUXURY	\N	\N	WHITE	GN791EL	30281	2025-03-25 22:17:20.515145
1523	Alpina	MG ZS 1.0T 6MT LUXURY	\N	\N	Silver	GN113YL	29740	2025-03-25 22:17:20.516156
1524	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW029PC	\N	2025-03-25 22:17:20.517761
1525	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW045PC	\N	2025-03-25 22:17:20.51866
1526	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW040PC	\N	2025-03-25 22:17:20.51945
1527	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW046PC	\N	2025-03-25 22:17:20.520227
1528	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW057PC	\N	2025-03-25 22:17:20.521002
1529	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW044PC	\N	2025-03-25 22:17:20.522083
1530	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16500	White	GW008PC	\N	2025-03-25 22:17:20.52347
1531	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW049PC	\N	2025-03-25 22:17:20.524727
1532	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW027PC	\N	2025-03-25 22:17:20.525782
1533	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW026PC	\N	2025-03-25 22:17:20.526756
1534	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW020PC	\N	2025-03-25 22:17:20.527697
1535	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW017PC	\N	2025-03-25 22:17:20.52902
1536	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW019PC	\N	2025-03-25 22:17:20.530192
1537	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW033PC	\N	2025-03-25 22:17:20.531008
1538	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW010PC	\N	2025-03-25 22:17:20.531784
1539	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW007PC	\N	2025-03-25 22:17:20.532562
1540	Alpina	MG ZS 1.5L MT 2WD COM LHD	\N	16600	White	GW030PC	\N	2025-03-25 22:17:20.533527
1541	Alpina	MG ZS 1.5L MT 2WD LUX LHD 360 Camera DARK Dover	\N	17700	White	GW022PC	\N	2025-03-25 22:17:20.535922
1542	Alpina	MG ZS 1.5L MT 2WD LUX LHD 360 Camera DARK Dover	\N	17700	White	GW018PC	\N	2025-03-25 22:17:20.536927
1543	Alpina	MG ZS 1.5L MT 2WD LUX LHD 360 Camera DARK Dover	\N	17700	White	GW025PC	\N	2025-03-25 22:17:20.537766
1544	Alpina	MG ZS 1.5L MT 2WD LUX LHD 360 Camera DARK Dover	\N	17700	White	GW016PC	\N	2025-03-25 22:17:20.538588
1545	Alpina	MG ZS 1.5L MT 2WD LUX LHD 360 Camera DARK Dover	\N	17700	White	GW015PC	\N	2025-03-25 22:17:20.539383
1546	Alpina	MG ZS 1.5L MT 2WD LUX LHD 360 Camera DARK Dover	\N	17700	White	GW013PC	\N	2025-03-25 22:17:20.540508
1547	Alpina	MG3 Hybrid+ COM    Cosmic Silver	\N	19600	Cosmic Silver	GV787MN	\N	2025-03-25 22:17:20.542206
1548	Alpina	MG3 Hybrid+ COM   Pebble Black 	\N	19600	Pebble Black	GV791MN	\N	2025-03-25 22:17:20.543491
1549	Alpina	MG3 Hybrid+ COM   Pebble Black 	\N	19600	Pebble Black	GV896MN	\N	2025-03-25 22:17:20.544421
1550	Alpina	MG3 Hybrid+ COM  Dover White	\N	19300	Dover White	GV786MN	\N	2025-03-25 22:17:20.545228
1551	Alpina	MG3 Hybrid+ COM  Dover White	\N	19300	Dover White	GV782MN	\N	2025-03-25 22:17:20.546183
1552	Alpina	MG3 Hybrid+ LUX	\N	21800	Dover White	GV206MM	\N	2025-03-25 22:17:20.547795
1553	Alpina	MG3 Hybrid+ LUX COSMIC SILVER	\N	21800	Cosmic Silver	GT743KB	\N	2025-03-25 22:17:20.548934
1554	Alpina	MG4 EV 51kwh STD 2WD	\N	23500	WHITE	GV796MP	\N	2025-03-25 22:17:20.549871
1555	Alpina	MG4 STD      Andes Grey	\N	23500	Andes Grey	GV799MP	\N	2025-03-25 22:17:20.550675
1556	Alpina	new dr 5.0 s3 1.5T CVT (gpl)	\N	23900	WHITE	GV176MN	\N	2025-03-25 22:17:20.551464
1557	Alpina	NEW DR 5.0 UNICA 1.5 BZ/GPL	\N	19900	SILVER	GT549CC	\N	2025-03-25 22:17:20.552362
1558	Alpina	NEW Dr 6.0 1.6 TB/GPL DCT GDI	\N	0	SILVER	GW305PC	\N	2025-03-25 22:17:20.553848
1559	Alpina	NEW EVO4 1.6	\N	16500	WHITE	GV938MM	\N	2025-03-25 22:17:20.55485
1560	Alpina	NIRO 1.6 MY25 HEV GPL EVOLUTION * Conver. GPL	\N	32500	AURORA BLACK PEARL	GY081CW	\N	2025-03-25 22:17:20.555761
1561	Alpina	NIRO 1.6 MY25 HEV GPL STYLE	\N	30900	INTERSTELLAR GREY 	GV894MM	\N	2025-03-25 22:17:20.556937
1562	Alpina	NIRO EV BUSINESS	\N	29900	CLEAR WHITE	GW289EF	\N	2025-03-25 22:17:20.557842
1563	Alpina	Nuova 500 Hatchback My23 La Nuova 500 - 320 Berlina	\N	19900	Mineral GREY	GM451YW	\N	2025-03-25 22:17:20.55909
1564	Alpina	Nuova 500 Hatchback My23 La Nuova 500 - 320 Berlina	\N	19900	Nero Cinema (pastello)	GR952MP	10	2025-03-25 22:17:20.560463
1565	Alpina	Nuova Ypsilon Ibrida Nuova Ypsilon 1.2 100cv Ibrida	\N	23900	ORO	GV835MN	\N	2025-03-25 22:17:20.561516
1566	Alpina	Nuova Ypsilon Ibrida Nuova Ypsilon 1.2 100cv Ibrida	\N	24900	Blu Lancia con Tetto Nero	GV830MN	\N	2025-03-25 22:17:20.562562
1567	Alpina	Nuova Ypsilon Ibrida Nuova Ypsilon 1.2 100cv Ibrida	\N	24600	Verde rugiada	GV969MM	\N	2025-03-25 22:17:20.563486
1568	Alpina	Nuova Ypsilon Ibrida Nuova Ypsilon 1.2 100cv Ibrida	\N	24900	Blu Lancia con Tetto Nero	GV974MM	\N	2025-03-25 22:17:20.564447
1569	Alpina	Nuova Ypsilon Ibrida Nuova Ypsilon 1.2 100cv Ibrida	\N	24900	Grigio Granito	GV975MM	\N	2025-03-25 22:17:20.566273
1570	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	27900	Verde rugiada	GV829MN	\N	2025-03-25 22:17:20.567353
1571	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	27200	Grigio Granito	GV833MN	\N	2025-03-25 22:17:20.568279
1572	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	24603	Nero Ardesia	GV827MN	\N	2025-03-25 22:17:20.569075
1573	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	24323	Grigio Granito	GV832MN	\N	2025-03-25 22:17:20.569862
1574	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	25900	Vernice Oro con Tetto Nero	GT105KA	\N	2025-03-25 22:17:20.571305
1575	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	26900	Vernice verde Giada Tetto nero	GT106KA	\N	2025-03-25 22:17:20.57264
1576	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	28800	Vernice Oro con Tetto Nero	GT612KB	\N	2025-03-25 22:17:20.573465
1577	Alpina	Nuova Ypsilon Ibrida Ypsilon Lx 1.2 100cv Ibrida	\N	27250	Blu Lancia con Tetto Nero	GV972MM	\N	2025-03-25 22:17:20.574247
1578	Alpina	Nuova Ypsilon Ypsilon Lx 100%Elettrica 156cv	\N	34900	Nero Ardesia	GV456NW	\N	2025-03-25 22:17:20.575026
1579	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	16200	Bianco Gelato (pastello)	GV754MN	\N	2025-03-25 22:17:20.575825
1580	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Bianco Gelato (pastello)	GV999MN	\N	2025-03-25 22:17:20.577455
1581	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Bianco Gelato (pastello)	GV979MN	\N	2025-03-25 22:17:20.57892
1582	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Bianco Gelato (pastello)	GV988MN	\N	2025-03-25 22:17:20.579983
1583	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Bianco Gelato (pastello)	GV993MN	\N	2025-03-25 22:17:20.581088
1584	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Bianco Gelato (pastello)	GV981MN	\N	2025-03-25 22:17:20.581883
1585	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Nero Cinema (pastello)	GV982MN	\N	2025-03-25 22:17:20.583271
1586	Alpina	Panda 1.0 70cv Hybrid PandinaStock	\N	15900	Nero Cinema (pastello)	GV992MN	\N	2025-03-25 22:17:20.584713
1587	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Nero Cinema (pastello)	GV007MN	\N	2025-03-25 22:17:20.58576
1588	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Nero Cinema (pastello)	GV016MN	\N	2025-03-25 22:17:20.586906
1589	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV213MN	\N	2025-03-25 22:17:20.587824
1590	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV670MN	\N	2025-03-25 22:17:20.588767
1591	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV648MN	\N	2025-03-25 22:17:20.590298
1592	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV673MN	\N	2025-03-25 22:17:20.591557
1593	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV664MN	\N	2025-03-25 22:17:20.592413
1594	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV690MN	\N	2025-03-25 22:17:20.593204
1595	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV687MN	\N	2025-03-25 22:17:20.593991
1596	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV697MN	\N	2025-03-25 22:17:20.595517
1597	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV701MN	\N	2025-03-25 22:17:20.597075
1598	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV695MN	\N	2025-03-25 22:17:20.598581
1599	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV693MN	\N	2025-03-25 22:17:20.599645
1600	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Rosso Passione (pastello)	GV792MN	\N	2025-03-25 22:17:20.600819
1601	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Blu Italia (metallizzato)	GV799MN	\N	2025-03-25 22:17:20.602449
1602	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV798MN	\N	2025-03-25 22:17:20.603595
1603	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV797MN	\N	2025-03-25 22:17:20.604488
1604	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV796MN	\N	2025-03-25 22:17:20.605299
1605	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV810MN	\N	2025-03-25 22:17:20.606107
1606	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV794MN	\N	2025-03-25 22:17:20.607345
1607	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Rosso Passione (pastello)	GV795MN	\N	2025-03-25 22:17:20.608764
1608	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Blu Italia (metallizzato)	GV958MN	\N	2025-03-25 22:17:20.609758
1609	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14200	Blu Italia (metallizzato)	GV954MN	\N	2025-03-25 22:17:20.610597
1610	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	12500	Giallo Sole (pastello)	GW402GL	\N	2025-03-25 22:17:20.611413
1611	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Rosso Passione (pastello)	GV960MN	\N	2025-03-25 22:17:20.612234
1612	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV971MN	\N	2025-03-25 22:17:20.613668
1613	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV940MN	\N	2025-03-25 22:17:20.614889
1614	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14600	Nero Cinema (pastello)	GW115PC	\N	2025-03-25 22:17:20.61599
1615	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14600	Nero Cinema (pastello)	GW114PC	\N	2025-03-25 22:17:20.616953
1616	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Blu Italia (metallizzato)	GV945MN	\N	2025-03-25 22:17:20.61786
1617	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14200	Blu Italia (metallizzato)	GV942MN	\N	2025-03-25 22:17:20.618748
1618	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV962MN	\N	2025-03-25 22:17:20.620202
1619	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13950	Bianco Gelato (pastello)	GV939MN	\N	2025-03-25 22:17:20.621359
1620	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Bianco Gelato (pastello)	GV946MN	\N	2025-03-25 22:17:20.622261
1621	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Bianco Gelato (pastello)	GV087MN	\N	2025-03-25 22:17:20.623176
1622	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Nero Cinema (pastello)	GV093MN	\N	2025-03-25 22:17:20.62397
1623	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Nero Cinema (pastello)	GV052MN	\N	2025-03-25 22:17:20.62492
1624	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Bianco Gelato (pastello)	GV017MN	\N	2025-03-25 22:17:20.62636
1625	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Bianco Gelato (pastello)	GV059MN	\N	2025-03-25 22:17:20.627503
1626	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14090	Nero Cinema (pastello)	GV964MP	\N	2025-03-25 22:17:20.628458
1627	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Nero Cinema (pastello)	GV003MN	\N	2025-03-25 22:17:20.629254
1628	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV807MN	\N	2025-03-25 22:17:20.630039
1629	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV805MN	\N	2025-03-25 22:17:20.631078
1630	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV804MN	\N	2025-03-25 22:17:20.632703
1631	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Bianco Gelato (pastello)	GV801MN	\N	2025-03-25 22:17:20.633774
1632	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	14000	Blu Italia (metallizzato)	GV808MN	\N	2025-03-25 22:17:20.634801
1633	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV679MN	\N	2025-03-25 22:17:20.635789
1634	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV672MN	\N	2025-03-25 22:17:20.636584
1635	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13900	Nero Cinema (pastello)	GV658MN	\N	2025-03-25 22:17:20.637965
1636	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Blu Italia (metallizzato)	GV098MN	\N	2025-03-25 22:17:20.639336
1637	Alpina	Panda con ADAS 1.0 70cv Hybrid	\N	13500	Bianco Gelato (pastello)	GV048MN	\N	2025-03-25 22:17:20.640207
1638	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GT783DB	10060	2025-03-25 22:17:20.64103
1639	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GS226XB	21235	2025-03-25 22:17:20.641855
1640	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Rosso Alfa	GT993HH	16844	2025-03-25 22:17:20.642656
1641	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GT562HH	14367	2025-03-25 22:17:20.643898
1642	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14400	Rosso Alfa	GS119YH	23983	2025-03-25 22:17:20.645129
1643	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GS252XB	21484	2025-03-25 22:17:20.646
1644	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	13300	Bianco Gelato (pastello)	GT732FT	20516	2025-03-25 22:17:20.646814
1645	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GT335HJ	16373	2025-03-25 22:17:20.647607
1646	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GT695DB	14832	2025-03-25 22:17:20.648394
1647	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GT084HJ	21850	2025-03-25 22:17:20.649278
1648	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Rosso Passione (pastello)	GT261HH	11000	2025-03-25 22:17:20.650789
1649	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Blu Misano	GT350ZL	13490	2025-03-25 22:17:20.651914
1650	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GT686HH	14061	2025-03-25 22:17:20.652851
1651	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Blu Misano	GV084EY	14320	2025-03-25 22:17:20.653672
1652	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Blu Misano	GT191ZM	15492	2025-03-25 22:17:20.654498
1653	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Bianco Gelato (pastello)	GS346XB	17759	2025-03-25 22:17:20.655625
1654	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Verde Foresta (metallizzato)	GT918NT	16864	2025-03-25 22:17:20.657488
1655	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Verde Foresta (metallizzato)	GV108EY	13421	2025-03-25 22:17:20.658536
1656	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Rosso Alfa	GS587YE	15864	2025-03-25 22:17:20.659415
1657	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Rosso Alfa	GS446XB	19089	2025-03-25 22:17:20.660231
1658	Alpina	Panda My24 1.0 70cv Hybrid Cross	\N	14500	Blu Misano	GT323ZM	13793	2025-03-25 22:17:20.66106
1659	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV956MP	\N	2025-03-25 22:17:20.66238
1660	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GV816MP	\N	2025-03-25 22:17:20.663658
1661	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GV973MP	\N	2025-03-25 22:17:20.664586
1662	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	13900	Nero Cinema (pastello)	GV954MP	\N	2025-03-25 22:17:20.665385
1663	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GW338PC	\N	2025-03-25 22:17:20.66618
1664	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GW371PC	\N	2025-03-25 22:17:20.666972
1665	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GW378PC	\N	2025-03-25 22:17:20.66839
1666	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GW375PC	\N	2025-03-25 22:17:20.66967
1667	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GW326PC	\N	2025-03-25 22:17:20.670826
1668	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GW349PC	\N	2025-03-25 22:17:20.671726
1669	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GW400PC	\N	2025-03-25 22:17:20.672555
1670	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GW380PC	\N	2025-03-25 22:17:20.673705
1671	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GW391PC	\N	2025-03-25 22:17:20.675187
1672	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW416PC	\N	2025-03-25 22:17:20.676369
1673	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW389PC	\N	2025-03-25 22:17:20.67717
1674	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW348PC	\N	2025-03-25 22:17:20.677977
1675	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW347PC	\N	2025-03-25 22:17:20.678768
1676	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW404PC	\N	2025-03-25 22:17:20.679746
1677	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW364PC	\N	2025-03-25 22:17:20.681178
1678	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW410PC	\N	2025-03-25 22:17:20.682092
1679	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW345PC	\N	2025-03-25 22:17:20.682895
1680	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW304PC	\N	2025-03-25 22:17:20.683687
1681	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW367PC	\N	2025-03-25 22:17:20.684621
1682	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW408PC	\N	2025-03-25 22:17:20.685509
1683	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW393PC	\N	2025-03-25 22:17:20.686975
1684	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW362PC	\N	2025-03-25 22:17:20.688213
1685	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW381PC	\N	2025-03-25 22:17:20.689273
1686	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW355PC	\N	2025-03-25 22:17:20.690236
1687	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW358PC	\N	2025-03-25 22:17:20.69116
1688	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW329PC	\N	2025-03-25 22:17:20.692656
1689	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW396PC	\N	2025-03-25 22:17:20.694079
1690	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW321PC	\N	2025-03-25 22:17:20.695126
1691	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW075PC	\N	2025-03-25 22:17:20.695957
1692	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW076PC	\N	2025-03-25 22:17:20.696771
1693	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW322PC	\N	2025-03-25 22:17:20.697696
1694	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW074PC	\N	2025-03-25 22:17:20.699343
1695	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW360PC	\N	2025-03-25 22:17:20.700411
1696	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW330PC	\N	2025-03-25 22:17:20.701249
1697	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW303PC	\N	2025-03-25 22:17:20.702087
1698	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GW343PC	\N	2025-03-25 22:17:20.702896
1699	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW352PC	\N	2025-03-25 22:17:20.703931
1700	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW397PC	\N	2025-03-25 22:17:20.705325
1701	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW394PC	\N	2025-03-25 22:17:20.706313
1702	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW320PC	\N	2025-03-25 22:17:20.707356
1703	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GW324PC	\N	2025-03-25 22:17:20.708194
1704	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GW319PC	\N	2025-03-25 22:17:20.709007
1705	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14250	Nero Cinema (pastello)	GV823MP	\N	2025-03-25 22:17:20.710079
1706	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14250	Nero Cinema (pastello)	GV960MP	\N	2025-03-25 22:17:20.711518
1707	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14250	Blu Italia (metallizzato)	GV818MP	\N	2025-03-25 22:17:20.712591
1708	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14250	Blu Italia (metallizzato)	GV962MP	\N	2025-03-25 22:17:20.71343
1709	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14250	Blu Italia (metallizzato)	GV911MP	\N	2025-03-25 22:17:20.714247
1710	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14250	Nero Cinema (pastello)	GV838MP	\N	2025-03-25 22:17:20.71506
1711	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14380	Nero Cinema (pastello)	GV928MP	\N	2025-03-25 22:17:20.716002
1712	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14380	Nero Cinema (pastello)	GV933MP	\N	2025-03-25 22:17:20.717439
1713	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14380	Nero Cinema (pastello)	GV945MP	\N	2025-03-25 22:17:20.71841
1714	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Bianco Gelato (pastello)	GV947MP	\N	2025-03-25 22:17:20.719234
1715	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Blu Italia (metallizzato)	GV944MP	\N	2025-03-25 22:17:20.720098
1716	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Blu Italia (metallizzato)	GV940MP	\N	2025-03-25 22:17:20.720915
1717	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV938MP	\N	2025-03-25 22:17:20.721756
1718	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV931MP	\N	2025-03-25 22:17:20.723162
1719	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Blu Italia (metallizzato)	GV924MP	\N	2025-03-25 22:17:20.724217
1720	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV929MP	\N	2025-03-25 22:17:20.725307
1721	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV820MP	\N	2025-03-25 22:17:20.726402
1722	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV840MP	\N	2025-03-25 22:17:20.727262
1723	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV912MP	\N	2025-03-25 22:17:20.728531
1724	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV892MP	\N	2025-03-25 22:17:20.730325
1725	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV906MP	\N	2025-03-25 22:17:20.73128
1726	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV914MP	\N	2025-03-25 22:17:20.73208
1727	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV824MP	\N	2025-03-25 22:17:20.732893
1728	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV842MP	\N	2025-03-25 22:17:20.733699
1729	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV828MP	\N	2025-03-25 22:17:20.736016
1730	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV845MP	\N	2025-03-25 22:17:20.737474
1731	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV847MP	\N	2025-03-25 22:17:20.738523
1732	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV887MP	\N	2025-03-25 22:17:20.739762
1733	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV848MP	\N	2025-03-25 22:17:20.741231
1734	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV900MP	\N	2025-03-25 22:17:20.742867
1735	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV826MP	\N	2025-03-25 22:17:20.743985
1736	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV886MP	\N	2025-03-25 22:17:20.744874
1737	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV831MP	\N	2025-03-25 22:17:20.745687
1738	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GV937MP	\N	2025-03-25 22:17:20.746892
1739	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Rosso Passione (pastello)	GV833MP	\N	2025-03-25 22:17:20.748277
1740	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14220	Nero Cinema (pastello)	GV829MP	\N	2025-03-25 22:17:20.749221
1741	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV946MP	\N	2025-03-25 22:17:20.75004
1742	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV974MP	\N	2025-03-25 22:17:20.750858
1743	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV917MP	\N	2025-03-25 22:17:20.751724
1744	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV953MP	\N	2025-03-25 22:17:20.752899
1745	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV923MP	\N	2025-03-25 22:17:20.754124
1746	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV903MP	\N	2025-03-25 22:17:20.754961
1747	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV934MP	\N	2025-03-25 22:17:20.755769
1748	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV932MP	\N	2025-03-25 22:17:20.756581
1749	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GV815MP	\N	2025-03-25 22:17:20.757384
1750	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV949MP	\N	2025-03-25 22:17:20.75832
1751	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Rosso Passione (pastello)	GV957MP	\N	2025-03-25 22:17:20.759751
1752	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV941MP	\N	2025-03-25 22:17:20.760868
1753	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV916MP	\N	2025-03-25 22:17:20.76205
1754	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	13900	Nero Cinema (pastello)	GV942MP	\N	2025-03-25 22:17:20.76298
1755	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV943MP	\N	2025-03-25 22:17:20.763796
1756	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV955MP	\N	2025-03-25 22:17:20.765173
1757	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV918MP	\N	2025-03-25 22:17:20.766479
1758	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV925MP	\N	2025-03-25 22:17:20.767327
1759	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV959MP	\N	2025-03-25 22:17:20.768169
1760	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV920MP	\N	2025-03-25 22:17:20.768973
1761	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV813MP	\N	2025-03-25 22:17:20.769772
1762	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV921MP	\N	2025-03-25 22:17:20.771263
1763	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV948MP	\N	2025-03-25 22:17:20.772435
1764	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV969MP	\N	2025-03-25 22:17:20.773266
1765	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV836MP	\N	2025-03-25 22:17:20.77409
1766	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Nero Cinema (pastello)	GV936MP	\N	2025-03-25 22:17:20.774898
1767	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV975MP	\N	2025-03-25 22:17:20.775711
1768	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV837MP	\N	2025-03-25 22:17:20.776713
1769	Alpina	Panda My25 1.0 70cv Hybrid Panda	\N	14600	Blu Italia (metallizzato)	GV930MP	\N	2025-03-25 22:17:20.778222
1770	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW412PC	\N	2025-03-25 22:17:20.779393
1771	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Nero Cinema (pastello)	GV971MP	\N	2025-03-25 22:17:20.780302
1772	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV894MP	\N	2025-03-25 22:17:20.781149
1773	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV814MP	\N	2025-03-25 22:17:20.78199
1774	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV901MP	\N	2025-03-25 22:17:20.783237
1775	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW406PC	\N	2025-03-25 22:17:20.784466
1776	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW417PC	\N	2025-03-25 22:17:20.785358
1777	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV902MP	\N	2025-03-25 22:17:20.786178
1778	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV890MP	\N	2025-03-25 22:17:20.786998
1779	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW401PC	\N	2025-03-25 22:17:20.787808
1780	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV827MP	\N	2025-03-25 22:17:20.788989
1781	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV909MP	\N	2025-03-25 22:17:20.790703
1782	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV893MP	\N	2025-03-25 22:17:20.791655
1783	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Rosso Passione (pastello)	GV835MP	\N	2025-03-25 22:17:20.792479
1784	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV834MP	\N	2025-03-25 22:17:20.79329
1785	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV895MP	\N	2025-03-25 22:17:20.794101
1786	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW419PC	\N	2025-03-25 22:17:20.795439
1787	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW414PC	\N	2025-03-25 22:17:20.796814
1788	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV825MP	\N	2025-03-25 22:17:20.797794
1789	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV821MP	\N	2025-03-25 22:17:20.798651
1790	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW402PC	\N	2025-03-25 22:17:20.79958
1791	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW413PC	\N	2025-03-25 22:17:20.800435
1792	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW405PC	\N	2025-03-25 22:17:20.802141
1793	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV904MP	\N	2025-03-25 22:17:20.803191
1794	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV907MP	\N	2025-03-25 22:17:20.804201
1795	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW369PC	\N	2025-03-25 22:17:20.805046
1796	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Blu Italia (metallizzato)	GV832MP	\N	2025-03-25 22:17:20.805865
1797	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW420PC	\N	2025-03-25 22:17:20.806743
1798	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW425PC	\N	2025-03-25 22:17:20.808293
1799	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW418PC	\N	2025-03-25 22:17:20.809235
1800	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW411PC	\N	2025-03-25 22:17:20.810049
1801	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Bianco Gelato (pastello)	GW365PC	\N	2025-03-25 22:17:20.810859
1802	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW415PC	\N	2025-03-25 22:17:20.811872
1803	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Verde Foresta (metallizzato)	GW325PC	\N	2025-03-25 22:17:20.812911
1804	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW407PC	\N	2025-03-25 22:17:20.814543
1805	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW423PC	\N	2025-03-25 22:17:20.815817
1806	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW350PC	\N	2025-03-25 22:17:20.816755
1807	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW357PC	\N	2025-03-25 22:17:20.817593
1808	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW361PC	\N	2025-03-25 22:17:20.818523
1809	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW341PC	\N	2025-03-25 22:17:20.820397
1810	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW346PC	\N	2025-03-25 22:17:20.821495
1811	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW392PC	\N	2025-03-25 22:17:20.82235
1812	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW335PC	\N	2025-03-25 22:17:20.823197
1813	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW373PC	\N	2025-03-25 22:17:20.824047
1814	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW388PC	\N	2025-03-25 22:17:20.825094
1815	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16500	Bianco Gelato (pastello)	GV694MP	\N	2025-03-25 22:17:20.826893
1816	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW331PC	\N	2025-03-25 22:17:20.827981
1817	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW339PC	\N	2025-03-25 22:17:20.829097
1818	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW333PC	\N	2025-03-25 22:17:20.829996
1819	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW421PC	\N	2025-03-25 22:17:20.830965
1820	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW359PC	\N	2025-03-25 22:17:20.832494
1821	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW328PC	\N	2025-03-25 22:17:20.833629
1822	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW351PC	\N	2025-03-25 22:17:20.834571
1823	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW354PC	\N	2025-03-25 22:17:20.835414
1824	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW336PC	\N	2025-03-25 22:17:20.83623
1825	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW377PC	\N	2025-03-25 22:17:20.837364
1826	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW368PC	\N	2025-03-25 22:17:20.839253
1827	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW344PC	\N	2025-03-25 22:17:20.840139
1828	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW379PC	\N	2025-03-25 22:17:20.841218
1829	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW390PC	\N	2025-03-25 22:17:20.842144
1830	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW386PC	\N	2025-03-25 22:17:20.843241
1831	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW370PC	\N	2025-03-25 22:17:20.844893
1832	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW382PC	\N	2025-03-25 22:17:20.845977
1833	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW332PC	\N	2025-03-25 22:17:20.846952
1834	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW334PC	\N	2025-03-25 22:17:20.847923
1835	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW372PC	\N	2025-03-25 22:17:20.848948
1836	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW337PC	\N	2025-03-25 22:17:20.850642
1837	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW383PC	\N	2025-03-25 22:17:20.851825
1838	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Nero Cinema (pastello)	GW342PC	\N	2025-03-25 22:17:20.85291
1839	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW366PC	\N	2025-03-25 22:17:20.854042
1840	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW384PC	\N	2025-03-25 22:17:20.855067
1841	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW376PC	\N	2025-03-25 22:17:20.856939
1842	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW363PC	\N	2025-03-25 22:17:20.858211
1843	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW340PC	\N	2025-03-25 22:17:20.859121
1844	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW424PC	\N	2025-03-25 22:17:20.859949
1845	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW422PC	\N	2025-03-25 22:17:20.860808
1846	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW403PC	\N	2025-03-25 22:17:20.862797
1847	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16200	Giallo Sole (pastello)	GW409PC	\N	2025-03-25 22:17:20.864179
1848	Alpina	Panda My25 1.0 70cv Hybrid Pandina	\N	16900	Rosso Passione (pastello)	GW374PC	\N	2025-03-25 22:17:20.865139
1849	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV319MN	\N	2025-03-25 22:17:20.865976
1850	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV505MN	\N	2025-03-25 22:17:20.866796
1851	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV330MN	\N	2025-03-25 22:17:20.867955
1852	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV324MN	\N	2025-03-25 22:17:20.869411
1853	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV318MN	\N	2025-03-25 22:17:20.870326
1854	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV323MN	\N	2025-03-25 22:17:20.871451
1855	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV300MN	\N	2025-03-25 22:17:20.872709
1856	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	15900	Giallo Sole (pastello)	GV340MN	\N	2025-03-25 22:17:20.87418
1857	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	16500	Nero Cinema (pastello)	GV748MN	\N	2025-03-25 22:17:20.875512
1858	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	16800	Nero Cinema (pastello)	GV752MN	\N	2025-03-25 22:17:20.87636
1859	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	16500	Nero Cinema (pastello)	GV751MN	\N	2025-03-25 22:17:20.87729
1860	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	16500	Nero Cinema (pastello)	GV653MP	\N	2025-03-25 22:17:20.87825
1861	Alpina	Pandina Cross 1.0 70cv Hybrid 	\N	16500	Nero Cinema (pastello)	GV336MM	\N	2025-03-25 22:17:20.879587
1862	Alpina	PICANTO PE2 MY25 1.0 URBAN PACK TT	\N	15500	INTERSTELLAR GREY 	GW150AM	5000	2025-03-25 22:17:20.881303
1863	Alpina	PICANTO PE2 MY25 1.0 URBAN PACK TT	\N	15900	SPORTY BLUE 	GW218EF	3332	2025-03-25 22:17:20.882322
1864	Alpina	POLO 5P 1.0 EVO 80CV FLEET EDITION	\N	19700	ASCOT GREY	RU125704	\N	2025-03-25 22:17:20.883206
1865	Alpina	PROCEED MY25 1.5 TGDI MH DCT GT-LINE	\N	28900	DARK PENTA METAL	GY873VN	\N	2025-03-25 22:17:20.884039
1866	Alpina	Renegade E-Hybrid My23 Limited1.5 Turbo T4 E-Hybrid 130cv Fw	\N	23900	Solid Black	GN126LE	13821	2025-03-25 22:17:20.884864
1867	Alpina	Renegade E-Hybrid My24 Altitude 1.5 Turbo T4 E-Hybrid 130cv 	\N	28900	Solid Black	GT348KB	\N	2025-03-25 22:17:20.886163
1868	Alpina	Renegade E-Hybrid My24 Altitude 1.5 Turbo T4 E-Hybrid 130cv 	\N	29900	Blue shade	GT349KB	\N	2025-03-25 22:17:20.887665
1869	Alpina	Renegade E-Hybrid My24 Summit1.5 Turbo T4 E-Hybrid 130cv Fwd	\N	29900	Blue Shade con tetto nero	GT305CC	\N	2025-03-25 22:17:20.88865
1870	Alpina	Renegade E-Hybrid My24 Summit1.5 Turbo T4 E-Hybrid 130cv Fwd	\N	29900	Alpine White con tetto nero	GV025MN	\N	2025-03-25 22:17:20.889578
1871	Alpina	Scudo Serie 2 Van  L2h1 1.5 Bluehdi 120cv Mt6	\N	33500	BIANCO PASTELLO	GT465KB	\N	2025-03-25 22:17:20.890417
1872	Alpina	Scudo Serie 2 Van  L2h1 1.5 Bluehdi 120cv Mt6	\N	33500	BIANCO PASTELLO	GT466KB	\N	2025-03-25 22:17:20.891242
1873	Alpina	Scudo Serie 2 Van  L2h1 1.5 Bluehdi 120cv Mt6	\N	31900	BIANCO PASTELLO	GV108MN	\N	2025-03-25 22:17:20.892748
1874	Alpina	Scudo Serie 2 Van  L2h1 2.0 Bluehdi 145cv Mt6 No S&S	\N	33500	BIANCO PASTELLO	GV453MM	\N	2025-03-25 22:17:20.893926
1875	Alpina	SPORTAGE MY25 1.6 DS MH DCT AWD GTL SPT	\N	36657	Experience green	GX085KD	\N	2025-03-25 22:17:20.894806
1876	Alpina	SPORTAGE MY25 1.6 HEV STYLE TT	\N	32900	Experience green	GY872VN	\N	2025-03-25 22:17:20.895622
1877	Alpina	SPORTAGE MY25 1.6 TGDI MH BUSINESS	\N	28012	CASSA WHITE	GX211PF	\N	2025-03-25 22:17:20.896437
1878	Alpina	SPORTAGE MY25 1.6 TGDI MH BUSINESS	\N	28012	CASSA WHITE	GX213PF	\N	2025-03-25 22:17:20.897263
1879	Alpina	SPORTAGE MY25 1.6 TGDI MH BUSINESS	\N	28012	CASSA WHITE	GX212PF	\N	2025-03-25 22:17:20.899035
1880	Alpina	Stelvio My23 2.2 Turbo Diesel210 Cv Awd Competizione	\N	57900	Grigio Moonlight Opaco	GT370KB	10	2025-03-25 22:17:20.900381
1881	Alpina	Stonic 1.0 t-gdi mhev Style 100cv imt	\N	14900	PERENNIAL GREY 	GK146DR	24500	2025-03-25 22:17:20.901387
1882	Alpina	STONIC MY25 1.0 MH URBAN	\N	19500	CLEAR WHITE	GY871VN	\N	2025-03-25 22:17:20.902208
1883	Alpina	Tipo Hatchback My23 1.6 130cvDs Hb Tipo	\N	22500	BLU ISTAMBUL 	GW270PC	\N	2025-03-25 22:17:20.903014
1884	Alpina	Tipo Hatchback My23 1.6 130cvDs Hb Tipo	\N	22500	BLU ISTAMBUL 	GW272PC	\N	2025-03-25 22:17:20.904089
1885	Alpina	Tipo Hatchback My23 1.6 130cvDs Hb Tipo	\N	22500	ARANCIO PAPRIKA	GW271PC	\N	2025-03-25 22:17:20.90569
1886	Alpina	Tipo My24 1.5 Hybrid 130cv DctHb Tipo	\N	19900	Nero Cinema (metallizzato)	GR081MR	\N	2025-03-25 22:17:20.906731
1887	Alpina	Tipo My24 1.5 Hybrid 130cv DctHb Tipo	\N	22900	BIANCO pastello	GT685KA	10	2025-03-25 22:17:20.907781
1888	Alpina	Tipo My24 1.5 Hybrid 130cv DctHb Tipo	\N	21900	BLU Kianos	GT686KA	\N	2025-03-25 22:17:20.908638
1889	Alpina	Tonale Hybrid 160cv Speciale	\N	39900	Grigio Vesuvio	GV263MN	\N	2025-03-25 22:17:20.909787
1890	Alpina	Tonale MY24 Diesel 130CV Sprint	\N	37900	Blu Misano	GV249MN	\N	2025-03-25 22:17:20.911471
1891	Alpina	Tonale MY24 Diesel 130CV Sprint	\N	39200	Blu Misano	GV934MN	\N	2025-03-25 22:17:20.912628
1892	Alpina	Tonale MY24 Diesel 130CV Sprint	\N	39200	Grigio Vesuvio	GV935MN	\N	2025-03-25 22:17:20.913513
1893	Alpina	Tonale My24 Hybrid 160cv Sprint	\N	40800	Blu Misano	GV760MN	\N	2025-03-25 22:17:20.914354
1894	Alpina	Tonale My24 Hybrid 160cv Tributo Italiano	\N	44900	Verde Montreal con Tetto Nero	GT726KB	\N	2025-03-25 22:17:20.915172
1895	Alpina	Tonale My24 Hybrid 160cv Tributo Italiano	\N	44900	Verde Montreal con Tetto Nero	GT727KB	\N	2025-03-25 22:17:20.916326
1896	Alpina	TOPOLINO	\N	8000	VERDE VITA	XB7643	\N	2025-03-25 22:17:20.917823
1897	Alpina	Wrangler Plug-In Hybrid My23 Sahara 2.0 4xe Phev 380cv At8	\N	65900	Sting Gray	GR947MP	\N	2025-03-25 22:17:20.918846
1898	Alpina	XCEED PE 1.5 TGDI MH BUSINESS	\N	23900	BLACK PEARL	GW275AM	\N	2025-03-25 22:17:20.919692
1899	Alpina	XCEED PE MY25 1.0 GPL BUSINESS * Conver. GPL	\N	24500	DARK PENTA METAL	GY868VN	\N	2025-03-25 22:17:20.920522
1900	Alpina	Ypsilon 1.0 70cv Hybrid Gold S4	\N	13900	ROSSO ARGILLA	GP818MA	21739	2025-03-25 22:17:20.921348
1901	Alpina	Ypsilon My23 1.0 Firefly 70 CvStart&Stop Hybrid Gold	\N	13500	Blu Elegante	GN881WM	22956	2025-03-25 22:17:20.922838
1902	Alpina	Ypsilon My23 1.0 Firefly 70 CvStart&Stop Hybrid Gold	\N	13500	GRIGIO PIETRA	GN353LE	21786	2025-03-25 22:17:20.924255
1903	Alpina	Ypsilon My23 1.0 Firefly 70 CvStart&Stop Hybrid Gold	\N	13500	NERO CARBONIO	GN325LE	16195	2025-03-25 22:17:20.92542
1904	Alpina	Ypsilon My23 1.0 Firefly 70 CvStart&Stop Hybrid Gold	\N	13500	NERO VULCANO	GP925BS	21506	2025-03-25 22:17:20.926467
1905	Alpina	Ypsilon My23 1.0 Firefly 70 CvStart&Stop Hybrid Gold	\N	13500	BIANCO NEVE	GN131WT	22644	2025-03-25 22:17:20.927366
1906	Alpina	ZS 1.0T 6AT LUXURY	\N	\N	DARK RED	GS041ML	15831	2025-03-25 22:17:20.928837
1907	Alpina	ZS 1.0T 6AT LUXURY - SILVER	\N	\N	Silver	GS004ML	16311	2025-03-25 22:17:20.930092
1908	Alpina	ZS 1.0T 6MT LUXURY - SILVER	\N	15300	Silver	GN779RA	33678	2025-03-25 22:17:20.931056
1909	Alpina	ZS 1.5L 5MT COMFORT - WHITE	\N	\N	White	GV949KB	11298	2025-03-25 22:17:20.931933
1910	Alpina	ZS 1.5L 5MT COMFORT - WHITE	\N	\N	White	GV964KB	12903	2025-03-25 22:17:20.932757
1911	Alpina	ZS 1.5L 5MT COMFORT - WHITE	\N	\N	White	GV006RC	13081	2025-03-25 22:17:20.933574
1912	Alpina	ZS 1.5L 5MT LUXURY - BLACK	\N	\N	Black	GV626ES	16743	2025-03-25 22:17:20.934854
1913	Alpina	ZS 1.5L 5MT LUXURY - BLACK	\N	\N	Black	GS605VB	19189	2025-03-25 22:17:20.936068
1914	Alpina	ZS 1.5L 5MT LUXURY - BLACK	\N	\N	Black	GS138NW	28768	2025-03-25 22:17:20.936968
1915	Alpina	ZS 1.5L 5MT LUXURY - SILVER	\N	\N	Silver	GS255JK	24914	2025-03-25 22:17:20.937795
1916	Alpina	ZS 1.5L 5MT LUXURY - SILVER	\N	\N	Silver	GS238JK	19932	2025-03-25 22:17:20.938611
1917	Alpina	ZS 1.5L 5MT LUXURY - WHITE	\N	\N	White	GS481JK	26101	2025-03-25 22:17:20.939421
1918	Alpina	ZS 1.5L 5MT LUXURY - WHITE	\N	\N	White	GS950JJ	17988	2025-03-25 22:17:20.940867
1919	Alpina	ZS 1.5L 5MT LUXURY - WHITE	\N	\N	White	GP361NW	32520	2025-03-25 22:17:20.942312
\.


--
-- Data for Name: import_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_log (id, file_name, "timestamp", records_imported, success, error_message) FROM stdin;
1	alpina.xls	2025-03-24 21:11:09.269107	0	t	\N
2	alpina.xls	2025-03-24 21:19:48.712268	600	t	\N
3	alpina.xls	2025-03-24 21:26:51.509555	600	t	\N
4	alpina.xls	2025-03-24 21:33:10.781449	600	t	\N
5	alpina.xls	2025-03-25 21:51:47.214523	600	t	\N
6	alpina.xls	2025-03-25 21:54:37.040751	600	t	\N
7	alpina.xls	2025-03-25 22:17:20.944303	600	t	\N
\.


--
-- Name: auto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auto_id_seq', 1919, true);


--
-- Name: import_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_log_id_seq', 7, true);


--
-- Name: auto auto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto
    ADD CONSTRAINT auto_pkey PRIMARY KEY (id);


--
-- Name: import_log import_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_log
    ADD CONSTRAINT import_log_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

