--
-- PostgreSQL database dump
--

\restrict 3ohZmmv1Xl07u3eK86moV7meOBUuaOYaaUoGYUQfQIjRGl60Qm3tsJDY9sjXW5U

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-17 21:46:27

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
1	Jl. Lapas Raya	0102000020E610000003000000AEC6EABF3E545A40952C8BC9E36915C0CF7C90792F545A400F15B0ECE06915C0E18419591B545A40917BCF250A6A15C0
2	Jl. Terusan Ryacudu	0102000020E6100000030000006D3E909192535A407FEDCA0D496F15C01D5AF3B70F545A40BF1E6A658A6D15C0A36300317A545A40BF8498ED7F6B15C0
3	Gg. Perwira	0102000020E61000000300000027EF70332F545A405CDB3EF2EE6915C0BE8C694E2F545A406CC1EEC5756A15C0CB8827B016545A40E13C9128AD6A15C0
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
1	Gg Perwira 1	0103000020E61000000100000004000000AD4972492F545A40E0B4B33EED6915C01124297E2E545A409B1DD4BB736A15C0DB55A4892F545A4038595E714F6B15C0AD4972492F545A40E0B4B33EED6915C0
4	Gg Perwira 2	0103000020E61000000100000004000000A8BEC3342E545A40EA5618DA766A15C01651950823545A40128EA1649C6A15C03666D51710545A406E3A4AE5BB6A15C0A8BEC3342E545A40EA5618DA766A15C0
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


-- Completed on 2026-02-17 21:46:29

--
-- PostgreSQL database dump complete
--

\unrestrict 3ohZmmv1Xl07u3eK86moV7meOBUuaOYaaUoGYUQfQIjRGl60Qm3tsJDY9sjXW5U

