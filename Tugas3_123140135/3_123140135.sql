--
-- PostgreSQL database dump
--

\restrict cElRmCl5RaMUddIwEXbCd4OhaQ7YHa2HCVmEaRyzIgdp77nytQ9ksiQrXnV0wx5

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-24 20:33:43

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

--
-- TOC entry 2 (class 3079 OID 24577)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5954 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 25666)
-- Name: fasilitas_publik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fasilitas_publik (
    id integer NOT NULL,
    nama character varying(100),
    jenis character varying(50),
    alamat text,
    geom public.geometry(Point,4326)
);


ALTER TABLE public.fasilitas_publik OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25665)
-- Name: fasilitas_publik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fasilitas_publik_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fasilitas_publik_id_seq OWNER TO postgres;

--
-- TOC entry 5955 (class 0 OID 0)
-- Dependencies: 225
-- Name: fasilitas_publik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fasilitas_publik_id_seq OWNED BY public.fasilitas_publik.id;


--
-- TOC entry 228 (class 1259 OID 25676)
-- Name: jalan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jalan (
    id integer NOT NULL,
    nama_jalan character varying(100),
    geom public.geometry(LineString,4326)
);


ALTER TABLE public.jalan OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25675)
-- Name: jalan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jalan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jalan_id_seq OWNER TO postgres;

--
-- TOC entry 5956 (class 0 OID 0)
-- Dependencies: 227
-- Name: jalan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jalan_id_seq OWNED BY public.jalan.id;


--
-- TOC entry 230 (class 1259 OID 25686)
-- Name: wilayah; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wilayah (
    id integer NOT NULL,
    nama_wilayah character varying(100),
    geom public.geometry(Polygon,4326)
);


ALTER TABLE public.wilayah OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25685)
-- Name: wilayah_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wilayah_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wilayah_id_seq OWNER TO postgres;

--
-- TOC entry 5957 (class 0 OID 0)
-- Dependencies: 229
-- Name: wilayah_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wilayah_id_seq OWNED BY public.wilayah.id;


--
-- TOC entry 5779 (class 2604 OID 25669)
-- Name: fasilitas_publik id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fasilitas_publik ALTER COLUMN id SET DEFAULT nextval('public.fasilitas_publik_id_seq'::regclass);


--
-- TOC entry 5780 (class 2604 OID 25679)
-- Name: jalan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jalan ALTER COLUMN id SET DEFAULT nextval('public.jalan_id_seq'::regclass);


--
-- TOC entry 5781 (class 2604 OID 25689)
-- Name: wilayah id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wilayah ALTER COLUMN id SET DEFAULT nextval('public.wilayah_id_seq'::regclass);


--
-- TOC entry 5944 (class 0 OID 25666)
-- Dependencies: 226
-- Data for Name: fasilitas_publik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fasilitas_publik (id, nama, jenis, alamat, geom) FROM stdin;
1	Mushola Al-Azzam	Ibadah	Jl. Lapas Raya	0101000020E6100000C803E0B02E545A408941001C8C6A15C0
2	SPORTERA ARENA	Olahraga	Jl. Lapas Raya	0101000020E61000001E1360441B545A4086B197E9B16A15C0
3	Indomaret Perum Pemda	Minimarket	Jl. Lapas Raya	0101000020E6100000A9850B602D545A4097E0C09CBD6915C0
4	Gereja Tyrannus Ministry	Ibadah	Jl. Lapas Raya	0101000020E61000002266A6DE32545A4060A91C77C86915C0
5	Apotek Way Huwi	Apotek	Jl. Lapas Raya	0101000020E61000002601B8AF41545A407232ADFBF36915C0
\.


--
-- TOC entry 5946 (class 0 OID 25676)
-- Dependencies: 228
-- Data for Name: jalan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jalan (id, nama_jalan, geom) FROM stdin;
2	Jl. Terusan Ryacudu	0102000020E6100000030000006D3E909192535A407FEDCA0D496F15C01D5AF3B70F545A40BF1E6A658A6D15C0A36300317A545A40BF8498ED7F6B15C0
1	Jl. Lapas Raya	0102000020E6100000060000000FC6B4E457545A40801982458D6915C02D7215A053545A405A9102FD956915C03756E03352545A40432112D3E16915C04F672C3D24545A402E25DF48EC6915C0A819B76213545A408B535FBC3A6A15C0168C9E27FE535A4090350BE5D56A15C0
3	Gg. Perwira	0102000020E610000008000000A098293C2F545A40AA578F60EB6915C062589E212F545A40EF368FEF746A15C05F51E28B2F545A40733CA67D4E6B15C062589E212F545A40EF368FEF746A15C0B98C69ED22545A4059EB4BB1926A15C0841C2F8223545A4071E517966B6B15C0B98C69ED22545A4059EB4BB1926A15C0A434D3DF0F545A40EB2FB1ACBD6A15C0
\.


--
-- TOC entry 5778 (class 0 OID 24896)
-- Dependencies: 221
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 5948 (class 0 OID 25686)
-- Dependencies: 230
-- Data for Name: wilayah; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wilayah (id, nama_wilayah, geom) FROM stdin;
1	Depan Indomaret	0103000020E610000001000000070000009591D6C72E545A40F5665004EC6915C00C6DC0BD2E545A40B0CF040F6C6A15C0EF5B77911A545A4066B201229B6A15C092385A2619545A40A875CAFE216A15C0C231E92521545A408716CB9C026A15C06A2B429828545A40E366272DF46915C09591D6C72E545A40F5665004EC6915C0
4	Gg Perwira	0103000020E6100000010000000F000000734E56C42F545A401786BE3BEA6915C0868275FB2F545A40F1676D29506B15C0191FD61D2F545A4003071B284F6B15C00452B7AA2E545A40D19E68D47B6A15C0CC4AB56C23545A40B410F9F8976A15C04C0FD4DF23545A4026A3B7B7676B15C0DBCDFD4D23545A40918FD0D26A6B15C05AA6A27C22545A40BECD0414996A15C0A9ADA9DB0F545A4095C6C57EC66A15C0DBADA9AE0F545A409B003819EF6A15C0BDA429DB17545A40C501CD190B6B15C097A4E9FC17545A40A36CF84E6A6B15C0E985697F33545A40D4188A1B5F6B15C06087E9B432545A405C5C8F60EB6915C0734E56C42F545A401786BE3BEA6915C0
\.


--
-- TOC entry 5958 (class 0 OID 0)
-- Dependencies: 225
-- Name: fasilitas_publik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fasilitas_publik_id_seq', 5, true);


--
-- TOC entry 5959 (class 0 OID 0)
-- Dependencies: 227
-- Name: jalan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jalan_id_seq', 3, true);


--
-- TOC entry 5960 (class 0 OID 0)
-- Dependencies: 229
-- Name: wilayah_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wilayah_id_seq', 4, true);


--
-- TOC entry 5786 (class 2606 OID 25674)
-- Name: fasilitas_publik fasilitas_publik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fasilitas_publik
    ADD CONSTRAINT fasilitas_publik_pkey PRIMARY KEY (id);


--
-- TOC entry 5788 (class 2606 OID 25684)
-- Name: jalan jalan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jalan
    ADD CONSTRAINT jalan_pkey PRIMARY KEY (id);


--
-- TOC entry 5790 (class 2606 OID 25694)
-- Name: wilayah wilayah_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wilayah
    ADD CONSTRAINT wilayah_pkey PRIMARY KEY (id);


-- Completed on 2026-02-24 20:33:45

--
-- PostgreSQL database dump complete
--

\unrestrict cElRmCl5RaMUddIwEXbCd4OhaQ7YHa2HCVmEaRyzIgdp77nytQ9ksiQrXnV0wx5

