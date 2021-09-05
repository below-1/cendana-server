--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

-- Started on 2021-09-05 15:25:08 WITA

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 650 (class 1247 OID 336962)
-- Name: DelayType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DelayType" AS ENUM (
    'PAYABLE',
    'RECEIVABLE'
);


ALTER TYPE public."DelayType" OWNER TO postgres;

--
-- TOC entry 647 (class 1247 OID 336956)
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'OPEN',
    'SEALED'
);


ALTER TYPE public."OrderStatus" OWNER TO postgres;

--
-- TOC entry 559 (class 1247 OID 336950)
-- Name: OrderType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderType" AS ENUM (
    'SALE',
    'BUY'
);


ALTER TYPE public."OrderType" OWNER TO postgres;

--
-- TOC entry 659 (class 1247 OID 336990)
-- Name: PaymentMethod; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PaymentMethod" AS ENUM (
    'OFFLINE',
    'CASH',
    'ON_DELIVERY',
    'CHEQUE_DRAFT',
    'WIRED',
    'ONLINE'
);


ALTER TYPE public."PaymentMethod" OWNER TO postgres;

--
-- TOC entry 556 (class 1247 OID 336941)
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'CUSTOMER',
    'SUPPLIER',
    'STAF'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- TOC entry 656 (class 1247 OID 336974)
-- Name: TransactionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TransactionStatus" AS ENUM (
    'NEW',
    'CANCELLED',
    'FAILED',
    'PENDING',
    'DECLINED',
    'REJECTED',
    'SUCCESS'
);


ALTER TYPE public."TransactionStatus" OWNER TO postgres;

--
-- TOC entry 653 (class 1247 OID 336968)
-- Name: TransactionType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TransactionType" AS ENUM (
    'DEBIT',
    'CREDIT'
);


ALTER TYPE public."TransactionType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 337091)
-- Name: Delay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Delay" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "authorId" integer NOT NULL,
    type public."DelayType" NOT NULL,
    "orderId" integer NOT NULL,
    "dueDate" timestamp(3) without time zone NOT NULL,
    total numeric(65,30) NOT NULL,
    complete boolean NOT NULL
);


ALTER TABLE public."Delay" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 337089)
-- Name: Delay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Delay_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Delay_id_seq" OWNER TO postgres;

--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 214
-- Name: Delay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Delay_id_seq" OWNED BY public."Delay".id;


--
-- TOC entry 219 (class 1259 OID 337109)
-- Name: Opex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Opex" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    title character varying(255) NOT NULL,
    description text
);


ALTER TABLE public."Opex" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 337107)
-- Name: Opex_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Opex_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Opex_id_seq" OWNER TO postgres;

--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 218
-- Name: Opex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Opex_id_seq" OWNED BY public."Opex".id;


--
-- TOC entry 213 (class 1259 OID 337072)
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "authorId" integer NOT NULL,
    "targetUserId" integer NOT NULL,
    "orderType" public."OrderType" NOT NULL,
    "orderStatus" public."OrderStatus" NOT NULL,
    "itemDiscount" numeric(65,30) DEFAULT 0 NOT NULL,
    tax integer DEFAULT 0 NOT NULL,
    shipping numeric(65,30) DEFAULT 0 NOT NULL,
    total numeric(65,30) DEFAULT 0 NOT NULL,
    "subTotal" numeric(65,30) DEFAULT 0 NOT NULL,
    "grandTotal" numeric(65,30) DEFAULT 0 NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    promo text,
    description text
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 337059)
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItem" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "authorId" integer NOT NULL,
    "productId" integer NOT NULL,
    "orderId" integer NOT NULL,
    "buyPrice" numeric(65,30) NOT NULL,
    "sellPrice" numeric(65,30) NOT NULL,
    quantity integer NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    description text
);


ALTER TABLE public."OrderItem" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 337057)
-- Name: OrderItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."OrderItem_id_seq" OWNER TO postgres;

--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 210
-- Name: OrderItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_id_seq" OWNED BY public."OrderItem".id;


--
-- TOC entry 212 (class 1259 OID 337070)
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq" OWNER TO postgres;

--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 212
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 207 (class 1259 OID 337025)
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    name character varying(255) NOT NULL,
    "buyPrice" numeric(65,30) DEFAULT 0 NOT NULL,
    "sellPrice" numeric(65,30) DEFAULT 0 NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    available integer DEFAULT 0 NOT NULL,
    sold integer DEFAULT 0 NOT NULL,
    defect integer DEFAULT 0 NOT NULL,
    returned integer DEFAULT 0 NOT NULL,
    unit text NOT NULL
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 337005)
-- Name: ProductCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductCategory" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE public."ProductCategory" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 337003)
-- Name: ProductCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductCategory_id_seq" OWNER TO postgres;

--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 202
-- Name: ProductCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductCategory_id_seq" OWNED BY public."ProductCategory".id;


--
-- TOC entry 206 (class 1259 OID 337023)
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Product_id_seq" OWNER TO postgres;

--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 206
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- TOC entry 209 (class 1259 OID 337044)
-- Name: StockItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."StockItem" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "authorId" integer NOT NULL,
    "productId" integer NOT NULL,
    "orderId" integer NOT NULL,
    "buyPrice" numeric(65,30) NOT NULL,
    "sellPrice" numeric(65,30) NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    available integer DEFAULT 0 NOT NULL,
    sold integer DEFAULT 0 NOT NULL,
    defect integer DEFAULT 0 NOT NULL,
    returned integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."StockItem" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 337042)
-- Name: StockItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."StockItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."StockItem_id_seq" OWNER TO postgres;

--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 208
-- Name: StockItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."StockItem_id_seq" OWNED BY public."StockItem".id;


--
-- TOC entry 221 (class 1259 OID 337121)
-- Name: Tool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tool" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    title character varying(255) NOT NULL,
    description text
);


ALTER TABLE public."Tool" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 337119)
-- Name: Tool_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tool_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tool_id_seq" OWNER TO postgres;

--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 220
-- Name: Tool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tool_id_seq" OWNED BY public."Tool".id;


--
-- TOC entry 217 (class 1259 OID 337100)
-- Name: Transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "authorId" integer NOT NULL,
    type public."TransactionType" NOT NULL,
    status public."TransactionStatus" NOT NULL,
    "paymentMethod" public."PaymentMethod" NOT NULL,
    nominal numeric(65,30) NOT NULL,
    "orderId" integer,
    "delayId" integer,
    "opexId" integer,
    "toolId" integer,
    description text
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 337098)
-- Name: Transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Transaction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Transaction_id_seq" OWNER TO postgres;

--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 216
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
-- TOC entry 205 (class 1259 OID 337014)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    username text,
    password text,
    role public."Role" NOT NULL,
    address text,
    mobile text,
    email text
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 337012)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO postgres;

--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 204
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 222 (class 1259 OID 337131)
-- Name: _ProductToProductCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_ProductToProductCategory" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToProductCategory" OWNER TO postgres;

--
-- TOC entry 2950 (class 2604 OID 337094)
-- Name: Delay id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay" ALTER COLUMN id SET DEFAULT nextval('public."Delay_id_seq"'::regclass);


--
-- TOC entry 2954 (class 2604 OID 337112)
-- Name: Opex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Opex" ALTER COLUMN id SET DEFAULT nextval('public."Opex_id_seq"'::regclass);


--
-- TOC entry 2941 (class 2604 OID 337075)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 2938 (class 2604 OID 337062)
-- Name: OrderItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN id SET DEFAULT nextval('public."OrderItem_id_seq"'::regclass);


--
-- TOC entry 2921 (class 2604 OID 337028)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 2918 (class 2604 OID 337008)
-- Name: ProductCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory" ALTER COLUMN id SET DEFAULT nextval('public."ProductCategory_id_seq"'::regclass);


--
-- TOC entry 2930 (class 2604 OID 337047)
-- Name: StockItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem" ALTER COLUMN id SET DEFAULT nextval('public."StockItem_id_seq"'::regclass);


--
-- TOC entry 2956 (class 2604 OID 337124)
-- Name: Tool id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tool" ALTER COLUMN id SET DEFAULT nextval('public."Tool_id_seq"'::regclass);


--
-- TOC entry 2952 (class 2604 OID 337103)
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- TOC entry 2920 (class 2604 OID 337017)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 3138 (class 0 OID 337091)
-- Dependencies: 215
-- Data for Name: Delay; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3142 (class 0 OID 337109)
-- Dependencies: 219
-- Data for Name: Opex; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Opex" VALUES (1, '2021-08-27 05:17:39.821', '2021-08-27 05:17:39.822', 'Pembayaran Ekspedisi', NULL);
INSERT INTO public."Opex" VALUES (2, '2021-08-27 05:17:46.737', '2021-08-27 05:17:46.738', 'Pembayaran PLN', NULL);
INSERT INTO public."Opex" VALUES (3, '2021-08-27 05:17:55.384', '2021-08-27 05:17:55.385', 'Pembayaran Bensin Kendaraan', NULL);
INSERT INTO public."Opex" VALUES (4, '2021-08-27 05:18:15.59', '2021-08-27 05:18:15.591', 'Pembayaran Lainnya', NULL);
INSERT INTO public."Opex" VALUES (5, '2021-08-27 05:18:27.994', '2021-08-27 05:18:27.996', 'Pembayaran Indihome', NULL);
INSERT INTO public."Opex" VALUES (6, '2021-08-27 05:18:35.048', '2021-08-27 05:18:35.049', 'Pembayaran Kartu Halo', NULL);
INSERT INTO public."Opex" VALUES (7, '2021-08-27 05:18:41.127', '2021-08-27 05:18:41.128', 'Pembayaran OVO', NULL);
INSERT INTO public."Opex" VALUES (8, '2021-08-27 05:18:50.032', '2021-08-27 05:18:50.033', 'Pembayaran Gaji Pegawai', NULL);
INSERT INTO public."Opex" VALUES (9, '2021-08-27 05:19:05.127', '2021-08-27 05:19:05.129', 'Pembayaran Kartu Kredit', NULL);
INSERT INTO public."Opex" VALUES (10, '2021-08-27 05:19:29.423', '2021-08-27 05:19:29.424', 'Pembayaran Servis Kendaraan', NULL);


--
-- TOC entry 3136 (class 0 OID 337072)
-- Dependencies: 213
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3134 (class 0 OID 337059)
-- Dependencies: 211
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3130 (class 0 OID 337025)
-- Dependencies: 207
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (1269, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'aceton heviny 35 ml', 1000.000000000000000000000000000000, 5000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1270, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'aceton heviny 60 ml', 2000.000000000000000000000000000000, 6000.000000000000000000000000000000, 0, 0, 72, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1271, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'ballpoint milton s-121', 8500.000000000000000000000000000000, 12500.000000000000000000000000000000, 0, 13, 7, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1272, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'body lotion heviny aloevera 600 ml', 12000.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1273, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'body lotion heviny bengkuang 600 ml', 12000.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1274, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'body lotion heviny green tea 600 ml', 12000.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1275, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'body lotion heviny rose 600 ml', 12000.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1276, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'body lotion heviny yogurt & goat milky 600 ml', 12000.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1277, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'cottonbuds cici bayi', 26000.000000000000000000000000000000, 30000.000000000000000000000000000000, 0, 10, 8, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1278, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'cottonbuds cici dewasa 045', 20000.000000000000000000000000000000, 24000.000000000000000000000000000000, 0, 13, 7, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1279, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny anti ketombe 250 gr', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1280, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny avocado 250 gram', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1281, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny ginseng 250 gram', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1282, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny kemiri 250 gr', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1283, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny lidah buaya 250 gr', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1284, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny spa avocado 250 gram', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1285, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny spa coconut 250 gram', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1286, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny spa emulsion milky 250 gram', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1287, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny spa papaya jasmine 250 gram', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1288, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'creambath heviny strawberry 250 gr', 9000.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1289, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'fitting test fukuta', 3000.000000000000000000000000000000, 7000.000000000000000000000000000000, 0, 21, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1290, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'fitting lampu kamar heroic he-4410', 2500.000000000000000000000000000000, 6500.000000000000000000000000000000, 0, 20, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1291, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'fitting gantung bulat superity', 0.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 60, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1292, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'fitting plafon okka', 0.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 12, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1293, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'fitting kombinasi', 2000.000000000000000000000000000000, 6000.000000000000000000000000000000, 0, 24, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1294, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gembok freeder 15 mm', 110000.000000000000000000000000000000, 114000.000000000000000000000000000000, 0, 0, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1295, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gembok frt 20 mm', 116000.000000000000000000000000000000, 120000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1296, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gembok frt 25 mm', 141000.000000000000000000000000000000, 145000.000000000000000000000000000000, 0, 2, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1297, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gembok frt 30 mm', 9750.000000000000000000000000000000, 13750.000000000000000000000000000000, 0, 6, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1298, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gembok majesty 40 mm', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1299, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gosok panci', 23000.000000000000000000000000000000, 27000.000000000000000000000000000000, 0, 68, 12, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1300, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 611 a', 68000.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, 0, 5, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1301, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 602 b', 62000.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1302, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 612 b', 86000.000000000000000000000000000000, 90000.000000000000000000000000000000, 0, 1, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1303, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 323 a', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 2, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1304, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 612 a', 86000.000000000000000000000000000000, 90000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1305, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 625 a', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1306, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 692 a', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1307, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku honaga 360 a', 95000.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 1, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1308, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting kuku 777 besar', 98000.000000000000000000000000000000, 102000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1309, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting m2000 besar hitam', 5500.000000000000000000000000000000, 9500.000000000000000000000000000000, 0, 24, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1310, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting m2000 kecil hitam', 2250.000000000000000000000000000000, 6250.000000000000000000000000000000, 0, 24, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1311, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting m2000 kecil renteng', 68000.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, 0, 3, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1312, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'gunting m2000 sedang hitam', 3500.000000000000000000000000000000, 7500.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1313, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask green tea 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1314, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny coconut 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1315, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny coconut 500 gram', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1316, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny coklat mint 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1317, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny ginseng 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1318, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny ginseng milky 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1319, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny green tea 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1320, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny papaya jasmine 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1321, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny strawberry 500 gr', 27000.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1322, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'hair mask heviny sun flower avocado 500 gr', 25000.000000000000000000000000000000, 29000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1323, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'isolasi bening kecil', 8000.000000000000000000000000000000, 12000.000000000000000000000000000000, 0, 12, 6, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1324, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'isolasi hitam kecil', 8000.000000000000000000000000000000, 12000.000000000000000000000000000000, 0, 12, 10, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1325, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'jarum tangan voxy', 44000.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 4, 1, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1326, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'jarum pentul', 16000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 5, 13, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1327, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'jinzu pepaya brightening soap 50 gr', 5500.000000000000000000000000000000, 9500.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1328, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kabel listrik nym 2 x 1,5 50 meter', 346000.000000000000000000000000000000, 350000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1329, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kabel rca 1 - 2', 1500.000000000000000000000000000000, 5500.000000000000000000000000000000, 0, 50, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1330, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kabel listrik monster 2 x 50 meter', 58500.000000000000000000000000000000, 62500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1331, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kabel listrik xrcom 2 x 30 meter', 43500.000000000000000000000000000000, 47500.000000000000000000000000000000, 0, 2, 1, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1332, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kabel listrik monster 2 x 80 meter', 73500.000000000000000000000000000000, 77500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1333, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kain pel sedang dynamic', 16000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 43, 81, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1334, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kain pel besar dynamic', 18500.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1335, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen ct 2000', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 1, 1, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1336, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen ct 500', 51000.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1337, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen ct 660', 95000.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1338, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen ct 712', 97500.000000000000000000000000000000, 101500.000000000000000000000000000000, 0, 1, 1, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1339, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen ct 720', 40500.000000000000000000000000000000, 44500.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1340, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen ct 9912', 64500.000000000000000000000000000000, 68500.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1341, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen sdc 612c', 121000.000000000000000000000000000000, 125000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1342, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kalkulator citizen sdc 868m', 95000.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1343, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kanebo speed-r', 16000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 36, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1344, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kapur ajaib bagus', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 35, 45, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1345, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'keran air hendso 1 / 2 dim', 14750.000000000000000000000000000000, 18750.000000000000000000000000000000, 0, 12, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1346, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'keran air hendso 3 / 4 dim', 16000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1347, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'keran air onda 3 / 4 dim', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1348, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'keran air tovo 3 / 4 dim', 17250.000000000000000000000000000000, 21250.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1349, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'kipas angin tangan hello kitty', 20000.000000000000000000000000000000, 24000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1350, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban bening besar', 8500.000000000000000000000000000000, 12500.000000000000000000000000000000, 0, 24, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1351, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban cokelat besar', 8500.000000000000000000000000000000, 12500.000000000000000000000000000000, 0, 30, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1352, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban bening opp', 6500.000000000000000000000000000000, 10500.000000000000000000000000000000, 0, 36, 42, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1353, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban cokelat opp', 6500.000000000000000000000000000000, 10500.000000000000000000000000000000, 0, 90, 30, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1354, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban hitam opp', 7000.000000000000000000000000000000, 11000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1355, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban hitam besar tebal', 11500.000000000000000000000000000000, 15500.000000000000000000000000000000, 0, 6, 30, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1356, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lakban kain 2 millenium', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 30, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1357, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu yazuho 2u 15 watt', 6000.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1358, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu yazuho 2u 18 watt', 6000.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1359, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu yazuho 2u 20 watt', 6000.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 36, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1360, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu led emergency flashycom - 5 watt', 61000.000000000000000000000000000000, 65000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1361, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu led emergency flashycom - 12 watt', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1362, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu led stark - 5 watt', 61000.000000000000000000000000000000, 65000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1363, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu led stark - 13 watt', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 12, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1364, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu pancaran 3u 25 watt', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 12, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1365, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu pancaran 3u 30 watt', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 12, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1366, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu pancaran 3u 35 watt', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 15, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1367, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu pancaran spiral 25 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 3, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1368, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu pancaran spiral 30 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 3, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1369, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu pancaran spiral 35 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 6, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1370, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu zentama spiral 25 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1371, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu zentama spiral 30 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1372, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu zentama spiral 35 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1373, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu ins ekonomis 2u 5 watt', 6000.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 27, 57, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1374, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu ins ekonomis 2u 7 watt', 6000.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 27, 57, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1375, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu maxxis spiral 25 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 27, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1376, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lampu maxxis spiral 35 watt', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 27, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1377, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lem castol sedang', 65000.000000000000000000000000000000, 69000.000000000000000000000000000000, 0, 20, 0, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1378, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lem castol mini', 56000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 11, 1, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1379, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lem g', 3500.000000000000000000000000000000, 7500.000000000000000000000000000000, 0, 49, 126, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1380, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lulur heviny brightening 250 gr', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1381, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lulur heviny coffe 250 gr', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1382, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lulur heviny green tea 250 gr', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1383, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lulur heviny madu susu 250 gr', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1384, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lulur heviny mutiara 250 gr', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1385, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'lulur heviny strawberry 250 gr', 11000.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1386, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'meteran frt transparan 3 meter', 7250.000000000000000000000000000000, 11250.000000000000000000000000000000, 0, 0, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1387, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'obeng test pen - kecil', 1500.000000000000000000000000000000, 5500.000000000000000000000000000000, 0, 0, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1388, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'paku tindis', 9500.000000000000000000000000000000, 13500.000000000000000000000000000000, 0, 15, 10, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1389, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pensil alis justmiss 311 - cokelat', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1390, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'peniti swan', 50000.000000000000000000000000000000, 54000.000000000000000000000000000000, 0, 5, 0, 0, 0, 'box');
INSERT INTO public."Product" VALUES (1391, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pinset motif', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1392, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pinset polos silver', 68000.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, 2, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1393, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pinset polos stainless', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1394, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pinset polos mas', 74000.000000000000000000000000000000, 78000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1395, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pinset jerawat kislene jarum', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1396, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pinset jerawat kislene bulat', 71000.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1397, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pisau cutter besar', 35000.000000000000000000000000000000, 39000.000000000000000000000000000000, 0, 7, 5, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1398, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'pisau cutter kecil', 32000.000000000000000000000000000000, 36000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1399, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'raket nyamuk sentosa', 43500.000000000000000000000000000000, 47500.000000000000000000000000000000, 0, 2, 13, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1400, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'raket nyamuk sivicom', 53500.000000000000000000000000000000, 57500.000000000000000000000000000000, 0, 3, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1401, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sapu panjang warna dynamic', 14750.000000000000000000000000000000, 18750.000000000000000000000000000000, 0, 12, 48, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1402, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sapu panjang warna hitam - dynamic', 18500.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 12, 15, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1403, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sapu panjang motif - dynamic', 20500.000000000000000000000000000000, 24500.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1404, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sapu panjang karet - dynamic', 19500.000000000000000000000000000000, 23500.000000000000000000000000000000, 0, 24, 9, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1405, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'senter push on fl1004', 16000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 25, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1406, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'shower cup jun da - putih', 56000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1407, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'shower cup motif - animal', 3500.000000000000000000000000000000, 7500.000000000000000000000000000000, 0, 0, 30, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1408, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier action', 51000.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1409, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier basic medium', 44000.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1410, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier basic soft', 44000.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1411, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier bobo classic', 38000.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1412, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier bobo junior', 89000.000000000000000000000000000000, 93000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1413, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier bobo travel', 95000.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 5, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1414, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier classic medium', 44000.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1415, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier classic soft', 44000.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1416, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier comfort medium', 38000.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 8, 5, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1417, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier comfort soft', 38000.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 5, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1418, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier deluxe', 51000.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 1, 3, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1419, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier superior', 51000.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 6, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1420, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier travel pack', 106000.000000000000000000000000000000, 110000.000000000000000000000000000000, 0, 7, 5, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1421, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat gigi premier twin plus', 116000.000000000000000000000000000000, 120000.000000000000000000000000000000, 0, 3, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1422, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat pakaian kayu', 35000.000000000000000000000000000000, 39000.000000000000000000000000000000, 0, 9, 5, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1423, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat pakaian plastik', 38000.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 10, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1424, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sikat sepatu kayu', 41000.000000000000000000000000000000, 45000.000000000000000000000000000000, 0, 2, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1425, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'silet goal', 48500.000000000000000000000000000000, 52500.000000000000000000000000000000, 0, 15, 6, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1426, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir kutu motif - cokelat', 47000.000000000000000000000000000000, 51000.000000000000000000000000000000, 0, 0, 5, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1427, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir gagang warna', 56000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 0, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1428, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir gagang loreng', 62000.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1429, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir gagang motif', 62000.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 2, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1430, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir gagang polos', 56000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1431, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir sasak 7413', -1000.000000000000000000000000000000, 3000.000000000000000000000000000000, 0, 12, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1432, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir rata 7414', -1000.000000000000000000000000000000, 3000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1433, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir rata warna', -1000.000000000000000000000000000000, 3000.000000000000000000000000000000, 0, 144, 3, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1434, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir saku 2005', -1500.000000000000000000000000000000, 2500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1435, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir saku 2006', -1500.000000000000000000000000000000, 2500.000000000000000000000000000000, 0, 36, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1436, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir saku loreng', 26000.000000000000000000000000000000, 30000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1437, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir segiempat loreng', 56000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1438, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir segiempat motif', 62000.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1439, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sisir semir hitam', 41000.000000000000000000000000000000, 45000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1440, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'spon cuci piring - segi', 23000.000000000000000000000000000000, 27000.000000000000000000000000000000, 0, 24, 11, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1441, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'spon cuci piring - warna', -1500.000000000000000000000000000000, 2500.000000000000000000000000000000, 0, 48, 66, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1442, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'spon bedak bulat', 21000.000000000000000000000000000000, 25000.000000000000000000000000000000, 0, 9, 3, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1443, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'spon bedak segi', 21000.000000000000000000000000000000, 25000.000000000000000000000000000000, 0, 9, 3, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (1444, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 981 - kayu', 104000.000000000000000000000000000000, 108000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1445, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 982 - kayu', 104000.000000000000000000000000000000, 108000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1446, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 984 - kayu', 104000.000000000000000000000000000000, 108000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1447, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 991 - kayu', 104000.000000000000000000000000000000, 108000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1448, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 801 - tembok', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1449, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 802 - tembok', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1450, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 804 - tembok', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1451, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'stop kontak 891 - tembok', 92000.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1452, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'steker over yaichi', 0.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 24, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1453, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'steker gepeng tris', 0.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 58, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1454, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'steker bulat', 2000.000000000000000000000000000000, 6000.000000000000000000000000000000, 0, 58, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1455, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sumbu kompor besar', 31000.000000000000000000000000000000, 35000.000000000000000000000000000000, 0, 2, 12, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1456, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'sumbu kompor kecil', 18500.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 30, 12, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (1457, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 3 lubang 3 meter', 14000.000000000000000000000000000000, 18000.000000000000000000000000000000, 0, 12, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1458, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 4 lubang 3 meter', 15000.000000000000000000000000000000, 19000.000000000000000000000000000000, 0, 12, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1459, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 5 lubang 3 meter', 16000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1460, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 3 lubang 5 meter', 17500.000000000000000000000000000000, 21500.000000000000000000000000000000, 0, 12, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1461, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 4 lubang 5 meter', 18500.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 12, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1462, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 5 lubang 5 meter', 19500.000000000000000000000000000000, 23500.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1463, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 3 lubang 1,5 meter', 17000.000000000000000000000000000000, 21000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1464, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 4 lubang 1,5 meter', 18000.000000000000000000000000000000, 22000.000000000000000000000000000000, 0, 0, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1465, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos sunfree 5 lubang 1,5 meter', 19000.000000000000000000000000000000, 23000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1466, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos 3 lubang tanpa kabel', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1467, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos 4 lubang tanpa kabel', 14500.000000000000000000000000000000, 18500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1468, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal polos 5 lubang tanpa kabel', 15500.000000000000000000000000000000, 19500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1469, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal tanpa kabel trm 3 lubang + switch', 18000.000000000000000000000000000000, 22000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1470, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna multicord 3 lubang 3 meter', 18000.000000000000000000000000000000, 22000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1471, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna multicord 4 lubang 3 meter', 19000.000000000000000000000000000000, 23000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1472, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna multicord 5 lubang 3 meter', 20000.000000000000000000000000000000, 24000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1473, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 3 lubang 1,5 meter', 12000.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 6, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1474, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 4 lubang 1,5 meter', 18500.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 6, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1475, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 5 lubang 1,5 meter', 15000.000000000000000000000000000000, 19000.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1476, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 6 lubang 1,5 meter', 14000.000000000000000000000000000000, 18000.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1477, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 3 lubang 5 meter', 24000.000000000000000000000000000000, 28000.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1478, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 4 lubang 5 meter', 25500.000000000000000000000000000000, 29500.000000000000000000000000000000, 0, 12, 3, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1479, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 5 lubang 5 meter', 26500.000000000000000000000000000000, 30500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1480, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 3 lubang tanpa kabel', 10500.000000000000000000000000000000, 14500.000000000000000000000000000000, 0, 9, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1481, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 4 lubang tanpa kabel', 11500.000000000000000000000000000000, 15500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1482, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 5 lubang tanpa kabel', 12500.000000000000000000000000000000, 16500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1483, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'terminal warna 6 lubang tanpa kabel', 13500.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (1484, '2021-09-05 15:15:12.736', '2021-09-05 15:15:12.736', 'thai pepaya lightening soap 50 gr', 4000.000000000000000000000000000000, 8000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');


--
-- TOC entry 3126 (class 0 OID 337005)
-- Dependencies: 203
-- Data for Name: ProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3132 (class 0 OID 337044)
-- Dependencies: 209
-- Data for Name: StockItem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3144 (class 0 OID 337121)
-- Dependencies: 221
-- Data for Name: Tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tool" VALUES (1, '2021-08-27 06:14:48.33', '2021-08-27 06:14:48.331', 'Peralatan Usaha', NULL);


--
-- TOC entry 3140 (class 0 OID 337100)
-- Dependencies: 217
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Transaction" VALUES (86, '2021-09-03 05:03:00', '2021-09-03 05:03:27.235', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 57000.000000000000000000000000000000, NULL, NULL, NULL, 1, NULL);
INSERT INTO public."Transaction" VALUES (87, '2021-09-03 05:07:00', '2021-09-03 05:07:40.291', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 10000.000000000000000000000000000000, NULL, NULL, NULL, 1, NULL);
INSERT INTO public."Transaction" VALUES (89, '2021-09-03 05:12:00', '2021-09-03 05:12:28.148', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, '');
INSERT INTO public."Transaction" VALUES (90, '2021-09-03 05:13:00', '2021-09-03 05:13:31.741', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 10000.000000000000000000000000000000, NULL, NULL, 3, NULL, '');
INSERT INTO public."Transaction" VALUES (88, '2021-09-03 05:08:00', '2021-09-05 05:35:44.741', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 70000.000000000000000000000000000000, NULL, NULL, NULL, 1, NULL);
INSERT INTO public."Transaction" VALUES (91, '2021-09-03 05:14:00', '2021-09-05 05:35:50.063', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 25000.000000000000000000000000000000, NULL, NULL, 3, NULL, '');


--
-- TOC entry 3128 (class 0 OID 337014)
-- Dependencies: 205
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES (2, 'Hana Cosmetic Surabaya', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (3, 'UD. Mitra Jaya Abadi', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (4, 'Sumber Mulia', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (5, 'Rukun Jaya Surabaya', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (6, 'Sukses Jaya Abadi', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (7, 'Bayu Anugerah Sentosa', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (8, 'PT. MUC', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (9, 'CV. Sinar Laut Timor Kupang', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (10, 'PT. Dynamic Mentari Indonesia', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (11, 'PT. Tiber Indonesia', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (12, 'Stardom Indonesia', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (13, 'PT. Gracindo Vitio Abadi', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (14, 'CV. Flexer Surya Jaya', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (15, 'Ahong Electronic', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (16, 'JBS Surabaya', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (17, 'PT. Malindo Cemerlang Utama', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (18, 'Robby Salesman', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (19, 'CV. Energi Cahaya Berkat', NULL, NULL, 'SUPPLIER', 'A', '', '');
INSERT INTO public."User" VALUES (20, 'AAAA', NULL, NULL, 'CUSTOMER', 'sdsd', '', '');
INSERT INTO public."User" VALUES (1, 'adminzero', 'adminzero', '$2b$04$uGmBLeKEGLDSZpesjKumBeLVt.lUFKGtDIXgyJi9TnBuFpu1E65au', 'ADMIN', NULL, NULL, NULL);


--
-- TOC entry 3145 (class 0 OID 337131)
-- Dependencies: 222
-- Data for Name: _ProductToProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 214
-- Name: Delay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Delay_id_seq"', 2, true);


--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 218
-- Name: Opex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Opex_id_seq"', 10, true);


--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 210
-- Name: OrderItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_id_seq"', 5, true);


--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 212
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 43, true);


--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 202
-- Name: ProductCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductCategory_id_seq"', 1, false);


--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 206
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 1484, true);


--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 208
-- Name: StockItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."StockItem_id_seq"', 50, true);


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 220
-- Name: Tool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tool_id_seq"', 1, true);


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 216
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 101, true);


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 204
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 21, true);


--
-- TOC entry 2972 (class 2606 OID 337097)
-- Name: Delay Delay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_pkey" PRIMARY KEY (id);


--
-- TOC entry 2977 (class 2606 OID 337118)
-- Name: Opex Opex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Opex"
    ADD CONSTRAINT "Opex_pkey" PRIMARY KEY (id);


--
-- TOC entry 2967 (class 2606 OID 337069)
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- TOC entry 2969 (class 2606 OID 337088)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 2959 (class 2606 OID 337011)
-- Name: ProductCategory ProductCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "ProductCategory_pkey" PRIMARY KEY (id);


--
-- TOC entry 2963 (class 2606 OID 337041)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 2965 (class 2606 OID 337056)
-- Name: StockItem StockItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_pkey" PRIMARY KEY (id);


--
-- TOC entry 2979 (class 2606 OID 337130)
-- Name: Tool Tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tool"
    ADD CONSTRAINT "Tool_pkey" PRIMARY KEY (id);


--
-- TOC entry 2975 (class 2606 OID 337106)
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- TOC entry 2961 (class 2606 OID 337022)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 2970 (class 1259 OID 337134)
-- Name: Delay_orderId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Delay_orderId_unique" ON public."Delay" USING btree ("orderId");


--
-- TOC entry 2973 (class 1259 OID 337135)
-- Name: Transaction_orderId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Transaction_orderId_unique" ON public."Transaction" USING btree ("orderId");


--
-- TOC entry 2980 (class 1259 OID 337136)
-- Name: _ProductToProductCategory_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_ProductToProductCategory_AB_unique" ON public."_ProductToProductCategory" USING btree ("A", "B");


--
-- TOC entry 2981 (class 1259 OID 337137)
-- Name: _ProductToProductCategory_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_ProductToProductCategory_B_index" ON public."_ProductToProductCategory" USING btree ("B");


--
-- TOC entry 2990 (class 2606 OID 337183)
-- Name: Delay Delay_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2991 (class 2606 OID 337188)
-- Name: Delay Delay_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2985 (class 2606 OID 337153)
-- Name: OrderItem OrderItem_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2987 (class 2606 OID 337168)
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2986 (class 2606 OID 337158)
-- Name: OrderItem OrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2988 (class 2606 OID 337173)
-- Name: Order Order_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2989 (class 2606 OID 337178)
-- Name: Order Order_targetUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_targetUserId_fkey" FOREIGN KEY ("targetUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2982 (class 2606 OID 337138)
-- Name: StockItem StockItem_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2984 (class 2606 OID 337148)
-- Name: StockItem StockItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2983 (class 2606 OID 337143)
-- Name: StockItem StockItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2992 (class 2606 OID 337193)
-- Name: Transaction Transaction_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2994 (class 2606 OID 337203)
-- Name: Transaction Transaction_delayId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_delayId_fkey" FOREIGN KEY ("delayId") REFERENCES public."Delay"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2995 (class 2606 OID 337208)
-- Name: Transaction Transaction_opexId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_opexId_fkey" FOREIGN KEY ("opexId") REFERENCES public."Opex"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2993 (class 2606 OID 337198)
-- Name: Transaction Transaction_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2996 (class 2606 OID 337213)
-- Name: Transaction Transaction_toolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_toolId_fkey" FOREIGN KEY ("toolId") REFERENCES public."Tool"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2997 (class 2606 OID 337218)
-- Name: _ProductToProductCategory _ProductToProductCategory_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToProductCategory"
    ADD CONSTRAINT "_ProductToProductCategory_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2998 (class 2606 OID 337223)
-- Name: _ProductToProductCategory _ProductToProductCategory_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToProductCategory"
    ADD CONSTRAINT "_ProductToProductCategory_B_fkey" FOREIGN KEY ("B") REFERENCES public."ProductCategory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2021-09-05 15:25:10 WITA

--
-- PostgreSQL database dump complete
--

