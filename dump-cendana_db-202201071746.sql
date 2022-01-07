--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

-- Started on 2022-01-07 17:46:38 WITA

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
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 658 (class 1247 OID 498254)
-- Name: DelayType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DelayType" AS ENUM (
    'PAYABLE',
    'RECEIVABLE'
);


ALTER TYPE public."DelayType" OWNER TO postgres;

--
-- TOC entry 655 (class 1247 OID 498248)
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'OPEN',
    'SEALED'
);


ALTER TYPE public."OrderStatus" OWNER TO postgres;

--
-- TOC entry 567 (class 1247 OID 498242)
-- Name: OrderType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderType" AS ENUM (
    'SALE',
    'BUY'
);


ALTER TYPE public."OrderType" OWNER TO postgres;

--
-- TOC entry 667 (class 1247 OID 498282)
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
-- TOC entry 564 (class 1247 OID 498233)
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
-- TOC entry 664 (class 1247 OID 498266)
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
-- TOC entry 661 (class 1247 OID 498260)
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
-- TOC entry 215 (class 1259 OID 498383)
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
-- TOC entry 214 (class 1259 OID 498381)
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
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 214
-- Name: Delay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Delay_id_seq" OWNED BY public."Delay".id;


--
-- TOC entry 224 (class 1259 OID 498436)
-- Name: EquityChange; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EquityChange" (
    id integer NOT NULL,
    "user" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."EquityChange" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 498434)
-- Name: EquityChange_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."EquityChange_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."EquityChange_id_seq" OWNER TO postgres;

--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 223
-- Name: EquityChange_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."EquityChange_id_seq" OWNED BY public."EquityChange".id;


--
-- TOC entry 229 (class 1259 OID 498468)
-- Name: FinanceReport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FinanceReport" (
    target timestamp(3) without time zone NOT NULL,
    "totalPenjualan" numeric(65,30),
    "hppAwal" numeric(65,30),
    "hppAkhir" numeric(65,30),
    hpp numeric(65,30),
    "labaKotor" numeric(65,30),
    opex numeric(65,30),
    "labaSebelumPajak" numeric(65,30),
    pajak numeric(65,30),
    "labaBersih" numeric(65,30),
    kas numeric(65,30),
    piutang numeric(65,30),
    persediaan numeric(65,30),
    "aktivaLancar" numeric(65,30),
    peralatan numeric(65,30),
    "akumulasiPeralatan" numeric(65,30),
    "aktivaTetap" numeric(65,30),
    passiva numeric(65,30),
    "utangDagang" numeric(65,30),
    "modalAwal" numeric(65,30),
    "modalAkhir" numeric(65,30),
    "totalRetur" numeric(65,30),
    "pembelianBarangDagang" numeric(65,30),
    "totalBiayaPengeluaran" numeric(65,30),
    "pajakUsaha" numeric(65,30),
    prive numeric(65,30),
    "kendaraanBaru" numeric(65,30),
    investasi numeric(65,30),
    "penambahanModalUsaha" numeric(65,30),
    roc numeric(65,30),
    "arusKasOperasional" numeric(65,30),
    "arusKasInvestasi" numeric(65,30)
);


ALTER TABLE public."FinanceReport" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 498458)
-- Name: Investment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Investment" (
    id integer NOT NULL,
    title text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    description text
);


ALTER TABLE public."Investment" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 498456)
-- Name: Investment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Investment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Investment_id_seq" OWNER TO postgres;

--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 227
-- Name: Investment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Investment_id_seq" OWNED BY public."Investment".id;


--
-- TOC entry 219 (class 1259 OID 498404)
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
-- TOC entry 218 (class 1259 OID 498402)
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
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 218
-- Name: Opex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Opex_id_seq" OWNED BY public."Opex".id;


--
-- TOC entry 213 (class 1259 OID 498364)
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
-- TOC entry 211 (class 1259 OID 498351)
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
-- TOC entry 210 (class 1259 OID 498349)
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
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 210
-- Name: OrderItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_id_seq" OWNED BY public."OrderItem".id;


--
-- TOC entry 212 (class 1259 OID 498362)
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
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 212
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 207 (class 1259 OID 498317)
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
-- TOC entry 203 (class 1259 OID 498297)
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
-- TOC entry 202 (class 1259 OID 498295)
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
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 202
-- Name: ProductCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductCategory_id_seq" OWNED BY public."ProductCategory".id;


--
-- TOC entry 206 (class 1259 OID 498315)
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
-- TOC entry 3218 (class 0 OID 0)
-- Dependencies: 206
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- TOC entry 226 (class 1259 OID 498448)
-- Name: RecordEquity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RecordEquity" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    nominal numeric(65,30) DEFAULT 0 NOT NULL
);


ALTER TABLE public."RecordEquity" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 498446)
-- Name: RecordEquity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."RecordEquity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."RecordEquity_id_seq" OWNER TO postgres;

--
-- TOC entry 3219 (class 0 OID 0)
-- Dependencies: 225
-- Name: RecordEquity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."RecordEquity_id_seq" OWNED BY public."RecordEquity".id;


--
-- TOC entry 222 (class 1259 OID 498426)
-- Name: RecordProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RecordProduct" (
    date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    hpp numeric(65,30) DEFAULT 0 NOT NULL,
    persediaan numeric(65,30) DEFAULT 0 NOT NULL
);


ALTER TABLE public."RecordProduct" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 498336)
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
-- TOC entry 208 (class 1259 OID 498334)
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
-- TOC entry 3220 (class 0 OID 0)
-- Dependencies: 208
-- Name: StockItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."StockItem_id_seq" OWNED BY public."StockItem".id;


--
-- TOC entry 221 (class 1259 OID 498416)
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
-- TOC entry 220 (class 1259 OID 498414)
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
-- TOC entry 3221 (class 0 OID 0)
-- Dependencies: 220
-- Name: Tool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tool_id_seq" OWNED BY public."Tool".id;


--
-- TOC entry 217 (class 1259 OID 498392)
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
    "equityChangeId" integer,
    "investmentId" integer,
    "pengembalianModalFlag" integer,
    description text
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 498390)
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
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 216
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
-- TOC entry 205 (class 1259 OID 498306)
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
-- TOC entry 204 (class 1259 OID 498304)
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
-- TOC entry 3223 (class 0 OID 0)
-- Dependencies: 204
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 230 (class 1259 OID 498473)
-- Name: _ProductToProductCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_ProductToProductCategory" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToProductCategory" OWNER TO postgres;

--
-- TOC entry 2978 (class 2604 OID 498386)
-- Name: Delay id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay" ALTER COLUMN id SET DEFAULT nextval('public."Delay_id_seq"'::regclass);


--
-- TOC entry 2989 (class 2604 OID 498439)
-- Name: EquityChange id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EquityChange" ALTER COLUMN id SET DEFAULT nextval('public."EquityChange_id_seq"'::regclass);


--
-- TOC entry 2994 (class 2604 OID 498461)
-- Name: Investment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Investment" ALTER COLUMN id SET DEFAULT nextval('public."Investment_id_seq"'::regclass);


--
-- TOC entry 2982 (class 2604 OID 498407)
-- Name: Opex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Opex" ALTER COLUMN id SET DEFAULT nextval('public."Opex_id_seq"'::regclass);


--
-- TOC entry 2969 (class 2604 OID 498367)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 2966 (class 2604 OID 498354)
-- Name: OrderItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN id SET DEFAULT nextval('public."OrderItem_id_seq"'::regclass);


--
-- TOC entry 2949 (class 2604 OID 498320)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 2946 (class 2604 OID 498300)
-- Name: ProductCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory" ALTER COLUMN id SET DEFAULT nextval('public."ProductCategory_id_seq"'::regclass);


--
-- TOC entry 2991 (class 2604 OID 498451)
-- Name: RecordEquity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecordEquity" ALTER COLUMN id SET DEFAULT nextval('public."RecordEquity_id_seq"'::regclass);


--
-- TOC entry 2958 (class 2604 OID 498339)
-- Name: StockItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem" ALTER COLUMN id SET DEFAULT nextval('public."StockItem_id_seq"'::regclass);


--
-- TOC entry 2984 (class 2604 OID 498419)
-- Name: Tool id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tool" ALTER COLUMN id SET DEFAULT nextval('public."Tool_id_seq"'::regclass);


--
-- TOC entry 2980 (class 2604 OID 498395)
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- TOC entry 2948 (class 2604 OID 498309)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 3189 (class 0 OID 498383)
-- Dependencies: 215
-- Data for Name: Delay; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3198 (class 0 OID 498436)
-- Dependencies: 224
-- Data for Name: EquityChange; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."EquityChange" VALUES (1, 'Admin Zero', '2015-01-14 00:00:00');


--
-- TOC entry 3203 (class 0 OID 498468)
-- Dependencies: 229
-- Data for Name: FinanceReport; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."FinanceReport" VALUES ('2021-01-30 16:00:00', 24168500.000000000000000000000000000000, 43462000.000000000000000000000000000000, 26473500.000000000000000000000000000000, 16988500.000000000000000000000000000000, 7180000.000000000000000000000000000000, 4040500.000000000000000000000000000000, 3139500.000000000000000000000000000000, 54000.000000000000000000000000000000, 3085500.000000000000000000000000000000, 20128000.000000000000000000000000000000, 0.000000000000000000000000000000, 26473500.000000000000000000000000000000, 50642000.000000000000000000000000000000, 124000.000000000000000000000000000000, 4000.000000000000000000000000000000, 120000.000000000000000000000000000000, 50762000.000000000000000000000000000000, 4598000.000000000000000000000000000000, 43078500.000000000000000000000000000000, 46164000.000000000000000000000000000000, 0.000000000000000000000000000000, 23777800.000000000000000000000000000000, 4040500.000000000000000000000000000000, NULL, 0.000000000000000000000000000000, NULL, 0.000000000000000000000000000000, NULL, 0.000000000000000000000000000000, -3703800.000000000000000000000000000000, 124000.000000000000000000000000000000);


--
-- TOC entry 3202 (class 0 OID 498458)
-- Dependencies: 228
-- Data for Name: Investment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3193 (class 0 OID 498404)
-- Dependencies: 219
-- Data for Name: Opex; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Opex" VALUES (1, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran Bensin Kendaraan', '');
INSERT INTO public."Opex" VALUES (2, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran BPJS Kesehatan', '');
INSERT INTO public."Opex" VALUES (3, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran Lainnya', '');
INSERT INTO public."Opex" VALUES (4, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran PDAM', '');
INSERT INTO public."Opex" VALUES (5, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran KIR Kendaran', '');
INSERT INTO public."Opex" VALUES (6, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran Ekspedisi', '');
INSERT INTO public."Opex" VALUES (7, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran Indihome', '');
INSERT INTO public."Opex" VALUES (8, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Service Kendaraan', '');
INSERT INTO public."Opex" VALUES (9, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran Listrik', '');
INSERT INTO public."Opex" VALUES (10, '2022-01-07 09:15:23.788', '2022-01-07 09:15:23.788', 'Pembayaran Gaji Pegawai', '');


--
-- TOC entry 3187 (class 0 OID 498364)
-- Dependencies: 213
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Order" VALUES (26, '2021-01-10 16:00:00', '2022-01-07 09:16:01.226', 1, 25, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 111000.000000000000000000000000000000, 111000.000000000000000000000000000000, 111000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (20, '2021-01-07 16:00:00', '2022-01-07 09:15:51.869', 1, 19, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 966000.000000000000000000000000000000, 966000.000000000000000000000000000000, 966000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (44, '2021-01-18 16:00:00', '2022-01-07 09:16:33.605', 1, 43, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 216000.000000000000000000000000000000, 216000.000000000000000000000000000000, 216000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (34, '2021-01-12 16:00:00', '2022-01-07 09:16:16.702', 1, 33, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 336000.000000000000000000000000000000, 336000.000000000000000000000000000000, 336000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (13, '2021-01-06 16:00:00', '2022-01-07 09:15:40.732', 1, 12, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 289500.000000000000000000000000000000, 289500.000000000000000000000000000000, 289500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (1, '2021-01-17 16:00:00', '2022-01-07 09:15:27.037', 1, 73, 'BUY', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 4348000.000000000000000000000000000000, 4348000.000000000000000000000000000000, 4348000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (2, '2021-01-28 16:00:00', '2022-01-07 09:15:27.607', 1, 74, 'BUY', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 250000.000000000000000000000000000000, 250000.000000000000000000000000000000, 250000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (3, '2021-01-04 16:00:00', '2022-01-07 09:15:28.333', 1, 2, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 39000.000000000000000000000000000000, 39000.000000000000000000000000000000, 39000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (41, '2021-01-14 16:00:00', '2022-01-07 09:16:29.248', 1, 40, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 267000.000000000000000000000000000000, 267000.000000000000000000000000000000, 267000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (14, '2021-01-06 16:00:00', '2022-01-07 09:15:41.431', 1, 13, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 38500.000000000000000000000000000000, 38500.000000000000000000000000000000, 38500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (4, '2021-01-04 16:00:00', '2022-01-07 09:15:29.4', 1, 3, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 184500.000000000000000000000000000000, 184500.000000000000000000000000000000, 184500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (5, '2021-01-04 16:00:00', '2022-01-07 09:15:29.918', 1, 4, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 90000.000000000000000000000000000000, 90000.000000000000000000000000000000, 90000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (54, '2021-01-22 16:00:00', '2022-01-07 09:16:46.62', 1, 53, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 630000.000000000000000000000000000000, 630000.000000000000000000000000000000, 630000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (6, '2021-01-04 16:00:00', '2022-01-07 09:15:30.381', 1, 5, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 60000.000000000000000000000000000000, 60000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (38, '2021-01-14 16:00:00', '2022-01-07 09:16:23.977', 1, 37, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 585000.000000000000000000000000000000, 585000.000000000000000000000000000000, 585000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (15, '2021-01-06 16:00:00', '2022-01-07 09:15:42.44', 1, 14, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 142000.000000000000000000000000000000, 142000.000000000000000000000000000000, 142000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (7, '2021-01-04 16:00:00', '2022-01-07 09:15:31.386', 1, 6, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 379500.000000000000000000000000000000, 379500.000000000000000000000000000000, 379500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (31, '2021-01-10 16:00:00', '2022-01-07 09:16:11.306', 1, 30, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 405000.000000000000000000000000000000, 405000.000000000000000000000000000000, 405000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (27, '2021-01-10 16:00:00', '2022-01-07 09:16:04.157', 1, 26, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 618500.000000000000000000000000000000, 618500.000000000000000000000000000000, 618500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (8, '2021-01-04 16:00:00', '2022-01-07 09:15:32.372', 1, 7, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 379500.000000000000000000000000000000, 379500.000000000000000000000000000000, 379500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (16, '2021-01-06 16:00:00', '2022-01-07 09:15:43.395', 1, 15, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 76000.000000000000000000000000000000, 76000.000000000000000000000000000000, 76000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (9, '2021-01-04 16:00:00', '2022-01-07 09:15:33.116', 1, 8, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 120000.000000000000000000000000000000, 120000.000000000000000000000000000000, 120000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (45, '2021-01-18 16:00:00', '2022-01-07 09:16:34.003', 1, 44, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 63000.000000000000000000000000000000, 63000.000000000000000000000000000000, 63000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (10, '2021-01-04 16:00:00', '2022-01-07 09:15:34.622', 1, 9, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 255000.000000000000000000000000000000, 255000.000000000000000000000000000000, 255000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (17, '2021-01-06 16:00:00', '2022-01-07 09:15:46.062', 1, 16, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 627000.000000000000000000000000000000, 627000.000000000000000000000000000000, 627000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (28, '2021-01-10 16:00:00', '2022-01-07 09:16:05.182', 1, 27, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 159000.000000000000000000000000000000, 159000.000000000000000000000000000000, 159000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (21, '2021-01-07 16:00:00', '2022-01-07 09:15:56.797', 1, 20, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 1227000.000000000000000000000000000000, 1227000.000000000000000000000000000000, 1227000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (18, '2021-01-07 16:00:00', '2022-01-07 09:15:47.324', 1, 17, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 276000.000000000000000000000000000000, 276000.000000000000000000000000000000, 276000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (11, '2021-01-04 16:00:00', '2022-01-07 09:15:37.096', 1, 10, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 446000.000000000000000000000000000000, 446000.000000000000000000000000000000, 446000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (35, '2021-01-12 16:00:00', '2022-01-07 09:16:18.963', 1, 34, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 606000.000000000000000000000000000000, 606000.000000000000000000000000000000, 606000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (19, '2021-01-07 16:00:00', '2022-01-07 09:15:47.827', 1, 18, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 159000.000000000000000000000000000000, 159000.000000000000000000000000000000, 159000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (22, '2021-01-10 16:00:00', '2022-01-07 09:15:57.284', 1, 21, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 120000.000000000000000000000000000000, 120000.000000000000000000000000000000, 120000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (12, '2021-01-04 16:00:00', '2022-01-07 09:15:38.346', 1, 11, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 774000.000000000000000000000000000000, 774000.000000000000000000000000000000, 774000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (42, '2021-01-14 16:00:00', '2022-01-07 09:16:30.447', 1, 41, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 165000.000000000000000000000000000000, 165000.000000000000000000000000000000, 165000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (32, '2021-01-10 16:00:00', '2022-01-07 09:16:13.099', 1, 31, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 376000.000000000000000000000000000000, 376000.000000000000000000000000000000, 376000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (36, '2021-01-12 16:00:00', '2022-01-07 09:16:19.387', 1, 35, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 216000.000000000000000000000000000000, 216000.000000000000000000000000000000, 216000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (23, '2021-01-10 16:00:00', '2022-01-07 09:15:58.907', 1, 22, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 292500.000000000000000000000000000000, 292500.000000000000000000000000000000, 292500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (29, '2021-01-10 16:00:00', '2022-01-07 09:16:07.009', 1, 28, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 388500.000000000000000000000000000000, 388500.000000000000000000000000000000, 388500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (24, '2021-01-10 16:00:00', '2022-01-07 09:15:59.382', 1, 23, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 40000.000000000000000000000000000000, 40000.000000000000000000000000000000, 40000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (25, '2021-01-10 16:00:00', '2022-01-07 09:16:00.201', 1, 24, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 255000.000000000000000000000000000000, 255000.000000000000000000000000000000, 255000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (39, '2021-01-14 16:00:00', '2022-01-07 09:16:25.55', 1, 38, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 597000.000000000000000000000000000000, 597000.000000000000000000000000000000, 597000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (37, '2021-01-12 16:00:00', '2022-01-07 09:16:20.879', 1, 36, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 415000.000000000000000000000000000000, 415000.000000000000000000000000000000, 415000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (48, '2021-01-18 16:00:00', '2022-01-07 09:16:37.613', 1, 47, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 362500.000000000000000000000000000000, 362500.000000000000000000000000000000, 362500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (30, '2021-01-10 16:00:00', '2022-01-07 09:16:09.166', 1, 29, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 285000.000000000000000000000000000000, 285000.000000000000000000000000000000, 285000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (33, '2021-01-12 16:00:00', '2022-01-07 09:16:15.707', 1, 32, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 563000.000000000000000000000000000000, 563000.000000000000000000000000000000, 563000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (46, '2021-01-18 16:00:00', '2022-01-07 09:16:34.977', 1, 45, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 87000.000000000000000000000000000000, 87000.000000000000000000000000000000, 87000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (40, '2021-01-14 16:00:00', '2022-01-07 09:16:27.207', 1, 39, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 198000.000000000000000000000000000000, 198000.000000000000000000000000000000, 198000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (43, '2021-01-18 16:00:00', '2022-01-07 09:16:32.294', 1, 42, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 442500.000000000000000000000000000000, 442500.000000000000000000000000000000, 442500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (47, '2021-01-18 16:00:00', '2022-01-07 09:16:35.374', 1, 46, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 45000.000000000000000000000000000000, 45000.000000000000000000000000000000, 45000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (58, '2021-01-22 16:00:00', '2022-01-07 09:16:51.583', 1, 57, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 620500.000000000000000000000000000000, 620500.000000000000000000000000000000, 620500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (50, '2021-01-19 16:00:00', '2022-01-07 09:16:40.772', 1, 43, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 321000.000000000000000000000000000000, 321000.000000000000000000000000000000, 321000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (55, '2021-01-22 16:00:00', '2022-01-07 09:16:47.293', 1, 54, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 108000.000000000000000000000000000000, 108000.000000000000000000000000000000, 108000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (49, '2021-01-18 16:00:00', '2022-01-07 09:16:38.796', 1, 48, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 170000.000000000000000000000000000000, 170000.000000000000000000000000000000, 170000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (53, '2021-01-22 16:00:00', '2022-01-07 09:16:45.929', 1, 52, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 367500.000000000000000000000000000000, 367500.000000000000000000000000000000, 367500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (57, '2021-01-22 16:00:00', '2022-01-07 09:16:49.204', 1, 56, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 72000.000000000000000000000000000000, 72000.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (52, '2021-01-19 16:00:00', '2022-01-07 09:16:44.512', 1, 51, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 982500.000000000000000000000000000000, 982500.000000000000000000000000000000, 982500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (51, '2021-01-19 16:00:00', '2022-01-07 09:16:41.807', 1, 50, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 265000.000000000000000000000000000000, 265000.000000000000000000000000000000, 265000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (56, '2021-01-22 16:00:00', '2022-01-07 09:16:48.478', 1, 55, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 186000.000000000000000000000000000000, 186000.000000000000000000000000000000, 186000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (60, '2021-01-24 16:00:00', '2022-01-07 09:16:53.678', 1, 59, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 333000.000000000000000000000000000000, 333000.000000000000000000000000000000, 333000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (59, '2021-01-24 16:00:00', '2022-01-07 09:16:52.455', 1, 58, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 630000.000000000000000000000000000000, 630000.000000000000000000000000000000, 630000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (61, '2021-01-24 16:00:00', '2022-01-07 09:16:54.813', 1, 60, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 261000.000000000000000000000000000000, 261000.000000000000000000000000000000, 261000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (62, '2021-01-24 16:00:00', '2022-01-07 09:16:55.488', 1, 52, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 60000.000000000000000000000000000000, 60000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (65, '2021-01-26 16:00:00', '2022-01-07 09:17:02.942', 1, 11, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 756500.000000000000000000000000000000, 756500.000000000000000000000000000000, 756500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (63, '2021-01-24 16:00:00', '2022-01-07 09:16:56.877', 1, 62, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 456500.000000000000000000000000000000, 456500.000000000000000000000000000000, 456500.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (64, '2021-01-26 16:00:00', '2022-01-07 09:16:59.899', 1, 9, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 649000.000000000000000000000000000000, 649000.000000000000000000000000000000, 649000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (66, '2021-01-26 16:00:00', '2022-01-07 09:17:06.011', 1, 65, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 717000.000000000000000000000000000000, 717000.000000000000000000000000000000, 717000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (67, '2021-01-26 16:00:00', '2022-01-07 09:17:06.963', 1, 66, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 105000.000000000000000000000000000000, 105000.000000000000000000000000000000, 105000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (68, '2021-01-26 16:00:00', '2022-01-07 09:17:09.707', 1, 67, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 462000.000000000000000000000000000000, 462000.000000000000000000000000000000, 462000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (69, '2021-01-26 16:00:00', '2022-01-07 09:17:12.107', 1, 68, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 540000.000000000000000000000000000000, 540000.000000000000000000000000000000, 540000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (70, '2021-01-28 16:00:00', '2022-01-07 09:17:13.524', 1, 69, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 361000.000000000000000000000000000000, 361000.000000000000000000000000000000, 361000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (71, '2021-01-28 16:00:00', '2022-01-07 09:17:15.361', 1, 70, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 312000.000000000000000000000000000000, 312000.000000000000000000000000000000, 312000.000000000000000000000000000000, 0, NULL, '');
INSERT INTO public."Order" VALUES (72, '2021-01-28 16:00:00', '2022-01-07 09:17:16.082', 1, 71, 'SALE', 'SEALED', 0.000000000000000000000000000000, 0, 0.000000000000000000000000000000, 60000.000000000000000000000000000000, 60000.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, NULL, '');


--
-- TOC entry 3185 (class 0 OID 498351)
-- Dependencies: 211
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."OrderItem" VALUES (1, '2022-01-07 09:15:27.93', '2022-01-07 09:15:27.932', 1, 129, 3, 38500.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (2, '2022-01-07 09:15:28.548', '2022-01-07 09:15:28.549', 1, 111, 4, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (3, '2022-01-07 09:15:28.82', '2022-01-07 09:15:28.822', 1, 171, 4, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (4, '2022-01-07 09:15:29.124', '2022-01-07 09:15:29.125', 1, 133, 4, 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (5, '2022-01-07 09:15:29.595', '2022-01-07 09:15:29.596', 1, 111, 5, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (6, '2022-01-07 09:15:30.099', '2022-01-07 09:15:30.101', 1, 65, 6, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (7, '2022-01-07 09:15:30.604', '2022-01-07 09:15:30.605', 1, 65, 7, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (8, '2022-01-07 09:15:30.832', '2022-01-07 09:15:30.833', 1, 135, 7, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (9, '2022-01-07 09:15:31.068', '2022-01-07 09:15:31.07', 1, 133, 7, 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (10, '2022-01-07 09:15:31.557', '2022-01-07 09:15:31.559', 1, 65, 8, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (11, '2022-01-07 09:15:31.803', '2022-01-07 09:15:31.805', 1, 135, 8, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (12, '2022-01-07 09:15:32.106', '2022-01-07 09:15:32.108', 1, 133, 8, 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (13, '2022-01-07 09:15:32.577', '2022-01-07 09:15:32.579', 1, 105, 9, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (14, '2022-01-07 09:15:32.855', '2022-01-07 09:15:32.857', 1, 106, 9, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (15, '2022-01-07 09:15:33.274', '2022-01-07 09:15:33.276', 1, 55, 10, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (16, '2022-01-07 09:15:33.571', '2022-01-07 09:15:33.573', 1, 82, 10, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (17, '2022-01-07 09:15:33.814', '2022-01-07 09:15:33.816', 1, 157, 10, 52000.000000000000000000000000000000, 52500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (18, '2022-01-07 09:15:34.297', '2022-01-07 09:15:34.299', 1, 154, 10, 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (19, '2022-01-07 09:15:34.799', '2022-01-07 09:15:34.801', 1, 58, 11, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (20, '2022-01-07 09:15:35.068', '2022-01-07 09:15:35.07', 1, 57, 11, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (21, '2022-01-07 09:15:35.368', '2022-01-07 09:15:35.369', 1, 43, 11, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (22, '2022-01-07 09:15:35.633', '2022-01-07 09:15:35.635', 1, 84, 11, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (23, '2022-01-07 09:15:35.934', '2022-01-07 09:15:35.936', 1, 85, 11, 5500.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (24, '2022-01-07 09:15:36.21', '2022-01-07 09:15:36.212', 1, 87, 11, 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (25, '2022-01-07 09:15:36.471', '2022-01-07 09:15:36.473', 1, 155, 11, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (26, '2022-01-07 09:15:36.749', '2022-01-07 09:15:36.751', 1, 187, 11, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (27, '2022-01-07 09:15:37.251', '2022-01-07 09:15:37.253', 1, 157, 12, 52000.000000000000000000000000000000, 52500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (28, '2022-01-07 09:15:37.516', '2022-01-07 09:15:37.518', 1, 135, 12, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (29, '2022-01-07 09:15:37.798', '2022-01-07 09:15:37.799', 1, 134, 12, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 9, 0, NULL);
INSERT INTO public."OrderItem" VALUES (30, '2022-01-07 09:15:38.058', '2022-01-07 09:15:38.059', 1, 133, 12, 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (31, '2022-01-07 09:15:38.575', '2022-01-07 09:15:38.577', 1, 96, 13, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (32, '2022-01-07 09:15:38.816', '2022-01-07 09:15:38.817', 1, 97, 13, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (33, '2022-01-07 09:15:39.07', '2022-01-07 09:15:39.072', 1, 98, 13, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (34, '2022-01-07 09:15:39.37', '2022-01-07 09:15:39.371', 1, 99, 13, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (35, '2022-01-07 09:15:39.612', '2022-01-07 09:15:39.613', 1, 100, 13, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (36, '2022-01-07 09:15:39.867', '2022-01-07 09:15:39.869', 1, 101, 13, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (37, '2022-01-07 09:15:40.198', '2022-01-07 09:15:40.2', 1, 120, 13, 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (38, '2022-01-07 09:15:40.452', '2022-01-07 09:15:40.453', 1, 171, 13, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (39, '2022-01-07 09:15:40.951', '2022-01-07 09:15:40.952', 1, 3, 14, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (40, '2022-01-07 09:15:41.185', '2022-01-07 09:15:41.187', 1, 120, 14, 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (41, '2022-01-07 09:15:41.638', '2022-01-07 09:15:41.64', 1, 2, 15, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (42, '2022-01-07 09:15:41.869', '2022-01-07 09:15:41.871', 1, 173, 15, 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (43, '2022-01-07 09:15:42.113', '2022-01-07 09:15:42.114', 1, 139, 15, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (44, '2022-01-07 09:15:42.634', '2022-01-07 09:15:42.635', 1, 10, 16, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (45, '2022-01-07 09:15:42.859', '2022-01-07 09:15:42.861', 1, 31, 16, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (46, '2022-01-07 09:15:43.15', '2022-01-07 09:15:43.151', 1, 174, 16, 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (47, '2022-01-07 09:15:43.558', '2022-01-07 09:15:43.559', 1, 65, 17, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (48, '2022-01-07 09:15:43.836', '2022-01-07 09:15:43.838', 1, 66, 17, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (49, '2022-01-07 09:15:44.071', '2022-01-07 09:15:44.073', 1, 135, 17, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (50, '2022-01-07 09:15:45.715', '2022-01-07 09:15:45.716', 1, 133, 17, 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (51, '2022-01-07 09:15:46.226', '2022-01-07 09:15:46.227', 1, 84, 18, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (52, '2022-01-07 09:15:46.462', '2022-01-07 09:15:46.464', 1, 87, 18, 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (53, '2022-01-07 09:15:46.778', '2022-01-07 09:15:46.779', 1, 105, 18, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (54, '2022-01-07 09:15:47.034', '2022-01-07 09:15:47.035', 1, 106, 18, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (55, '2022-01-07 09:15:47.547', '2022-01-07 09:15:47.548', 1, 188, 19, 26000.000000000000000000000000000000, 26500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (56, '2022-01-07 09:15:47.987', '2022-01-07 09:15:47.989', 1, 32, 20, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (57, '2022-01-07 09:15:48.286', '2022-01-07 09:15:48.287', 1, 36, 20, 89500.000000000000000000000000000000, 90000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (58, '2022-01-07 09:15:48.548', '2022-01-07 09:15:48.55', 1, 58, 20, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (59, '2022-01-07 09:15:48.784', '2022-01-07 09:15:48.786', 1, 123, 20, 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (60, '2022-01-07 09:15:49.098', '2022-01-07 09:15:49.1', 1, 124, 20, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (61, '2022-01-07 09:15:49.328', '2022-01-07 09:15:49.329', 1, 142, 20, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (62, '2022-01-07 09:15:49.564', '2022-01-07 09:15:49.565', 1, 141, 20, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (63, '2022-01-07 09:15:49.883', '2022-01-07 09:15:49.885', 1, 148, 20, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (64, '2022-01-07 09:15:50.154', '2022-01-07 09:15:50.155', 1, 149, 20, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (65, '2022-01-07 09:15:50.393', '2022-01-07 09:15:50.394', 1, 150, 20, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (66, '2022-01-07 09:15:50.738', '2022-01-07 09:15:50.739', 1, 152, 20, 109500.000000000000000000000000000000, 110000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (67, '2022-01-07 09:15:50.993', '2022-01-07 09:15:50.995', 1, 164, 20, 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 24, 0, NULL);
INSERT INTO public."OrderItem" VALUES (68, '2022-01-07 09:15:51.259', '2022-01-07 09:15:51.261', 1, 166, 20, 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (69, '2022-01-07 09:15:51.596', '2022-01-07 09:15:51.597', 1, 138, 20, 65500.000000000000000000000000000000, 60000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (70, '2022-01-07 09:15:52.082', '2022-01-07 09:15:52.084', 1, 2, 21, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 24, 0, NULL);
INSERT INTO public."OrderItem" VALUES (71, '2022-01-07 09:15:52.365', '2022-01-07 09:15:52.367', 1, 35, 21, 95500.000000000000000000000000000000, 96000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (72, '2022-01-07 09:15:52.595', '2022-01-07 09:15:52.597', 1, 32, 21, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (73, '2022-01-07 09:15:52.885', '2022-01-07 09:15:52.886', 1, 36, 21, 89500.000000000000000000000000000000, 90000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (74, '2022-01-07 09:15:53.171', '2022-01-07 09:15:53.172', 1, 141, 21, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (75, '2022-01-07 09:15:53.448', '2022-01-07 09:15:53.45', 1, 142, 21, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (76, '2022-01-07 09:15:53.68', '2022-01-07 09:15:53.682', 1, 148, 21, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (77, '2022-01-07 09:15:53.962', '2022-01-07 09:15:53.963', 1, 149, 21, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (78, '2022-01-07 09:15:54.218', '2022-01-07 09:15:54.22', 1, 150, 21, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (79, '2022-01-07 09:15:54.478', '2022-01-07 09:15:54.48', 1, 145, 21, 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (80, '2022-01-07 09:15:54.755', '2022-01-07 09:15:54.757', 1, 151, 21, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (81, '2022-01-07 09:15:54.998', '2022-01-07 09:15:55', 1, 152, 21, 109500.000000000000000000000000000000, 110000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (82, '2022-01-07 09:15:55.257', '2022-01-07 09:15:55.259', 1, 153, 21, 119500.000000000000000000000000000000, 120000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (83, '2022-01-07 09:15:55.539', '2022-01-07 09:15:55.541', 1, 164, 21, 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (84, '2022-01-07 09:15:55.8', '2022-01-07 09:15:55.802', 1, 162, 21, 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 24, 0, NULL);
INSERT INTO public."OrderItem" VALUES (85, '2022-01-07 09:15:56.135', '2022-01-07 09:15:56.137', 1, 173, 21, 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (86, '2022-01-07 09:15:56.474', '2022-01-07 09:15:56.475', 1, 174, 21, 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (87, '2022-01-07 09:15:56.987', '2022-01-07 09:15:56.988', 1, 65, 22, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (88, '2022-01-07 09:15:57.473', '2022-01-07 09:15:57.476', 1, 10, 23, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (89, '2022-01-07 09:15:57.73', '2022-01-07 09:15:57.732', 1, 29, 23, 13250.000000000000000000000000000000, 13750.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (90, '2022-01-07 09:15:58.102', '2022-01-07 09:15:58.103', 1, 84, 23, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (91, '2022-01-07 09:15:58.333', '2022-01-07 09:15:58.334', 1, 111, 23, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (92, '2022-01-07 09:15:58.581', '2022-01-07 09:15:58.583', 1, 119, 23, 5000.000000000000000000000000000000, 5500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (93, '2022-01-07 09:15:59.103', '2022-01-07 09:15:59.104', 1, 58, 24, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (94, '2022-01-07 09:15:59.621', '2022-01-07 09:15:59.623', 1, 66, 25, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (95, '2022-01-07 09:15:59.938', '2022-01-07 09:15:59.94', 1, 65, 25, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (96, '2022-01-07 09:16:00.398', '2022-01-07 09:16:00.399', 1, 22, 26, 6000.000000000000000000000000000000, 6500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (97, '2022-01-07 09:16:00.639', '2022-01-07 09:16:00.64', 1, 76, 26, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (98, '2022-01-07 09:16:00.896', '2022-01-07 09:16:00.897', 1, 120, 26, 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (99, '2022-01-07 09:16:01.392', '2022-01-07 09:16:01.393', 1, 25, 27, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (100, '2022-01-07 09:16:01.648', '2022-01-07 09:16:01.65', 1, 62, 27, 47000.000000000000000000000000000000, 47500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (101, '2022-01-07 09:16:01.94', '2022-01-07 09:16:01.941', 1, 67, 27, 107000.000000000000000000000000000000, 107500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (102, '2022-01-07 09:16:02.218', '2022-01-07 09:16:02.219', 1, 82, 27, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (103, '2022-01-07 09:16:02.47', '2022-01-07 09:16:02.472', 1, 87, 27, 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (104, '2022-01-07 09:16:02.776', '2022-01-07 09:16:02.778', 1, 56, 27, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (105, '2022-01-07 09:16:03.041', '2022-01-07 09:16:03.043', 1, 158, 27, 50500.000000000000000000000000000000, 51000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (106, '2022-01-07 09:16:03.325', '2022-01-07 09:16:03.326', 1, 120, 27, 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (107, '2022-01-07 09:16:03.625', '2022-01-07 09:16:03.627', 1, 142, 27, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (108, '2022-01-07 09:16:03.865', '2022-01-07 09:16:03.866', 1, 134, 27, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (109, '2022-01-07 09:16:04.373', '2022-01-07 09:16:04.375', 1, 76, 28, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (110, '2022-01-07 09:16:04.615', '2022-01-07 09:16:04.616', 1, 84, 28, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (111, '2022-01-07 09:16:04.863', '2022-01-07 09:16:04.864', 1, 158, 28, 50500.000000000000000000000000000000, 51000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (112, '2022-01-07 09:16:05.341', '2022-01-07 09:16:05.342', 1, 32, 29, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (113, '2022-01-07 09:16:05.62', '2022-01-07 09:16:05.621', 1, 56, 29, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (114, '2022-01-07 09:16:05.918', '2022-01-07 09:16:05.919', 1, 110, 29, 59500.000000000000000000000000000000, 60000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (115, '2022-01-07 09:16:06.178', '2022-01-07 09:16:06.179', 1, 111, 29, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (116, '2022-01-07 09:16:06.433', '2022-01-07 09:16:06.434', 1, 187, 29, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (117, '2022-01-07 09:16:06.734', '2022-01-07 09:16:06.736', 1, 65, 29, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (118, '2022-01-07 09:16:07.187', '2022-01-07 09:16:07.188', 1, 105, 30, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (119, '2022-01-07 09:16:07.449', '2022-01-07 09:16:07.451', 1, 106, 30, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (120, '2022-01-07 09:16:07.714', '2022-01-07 09:16:07.716', 1, 96, 30, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (121, '2022-01-07 09:16:07.954', '2022-01-07 09:16:07.955', 1, 97, 30, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (122, '2022-01-07 09:16:08.262', '2022-01-07 09:16:08.264', 1, 98, 30, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (123, '2022-01-07 09:16:08.535', '2022-01-07 09:16:08.537', 1, 129, 30, 38500.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (124, '2022-01-07 09:16:08.789', '2022-01-07 09:16:08.791', 1, 130, 30, 35500.000000000000000000000000000000, 36000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (125, '2022-01-07 09:16:09.321', '2022-01-07 09:16:09.323', 1, 105, 31, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (126, '2022-01-07 09:16:09.574', '2022-01-07 09:16:09.576', 1, 106, 31, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (127, '2022-01-07 09:16:09.845', '2022-01-07 09:16:09.847', 1, 96, 31, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (128, '2022-01-07 09:16:10.066', '2022-01-07 09:16:10.067', 1, 97, 31, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (129, '2022-01-07 09:16:10.284', '2022-01-07 09:16:10.288', 1, 98, 31, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (130, '2022-01-07 09:16:10.556', '2022-01-07 09:16:10.558', 1, 99, 31, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (131, '2022-01-07 09:16:10.784', '2022-01-07 09:16:10.785', 1, 100, 31, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (132, '2022-01-07 09:16:11.012', '2022-01-07 09:16:11.014', 1, 101, 31, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (133, '2022-01-07 09:16:11.467', '2022-01-07 09:16:11.468', 1, 31, 32, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (134, '2022-01-07 09:16:11.703', '2022-01-07 09:16:11.704', 1, 76, 32, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (135, '2022-01-07 09:16:11.986', '2022-01-07 09:16:11.988', 1, 147, 32, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (136, '2022-01-07 09:16:12.228', '2022-01-07 09:16:12.229', 1, 151, 32, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (137, '2022-01-07 09:16:12.452', '2022-01-07 09:16:12.454', 1, 154, 32, 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (138, '2022-01-07 09:16:12.732', '2022-01-07 09:16:12.733', 1, 171, 32, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (139, '2022-01-07 09:16:13.274', '2022-01-07 09:16:13.276', 1, 32, 33, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (140, '2022-01-07 09:16:13.567', '2022-01-07 09:16:13.569', 1, 39, 33, 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (141, '2022-01-07 09:16:13.821', '2022-01-07 09:16:13.823', 1, 58, 33, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (142, '2022-01-07 09:16:14.074', '2022-01-07 09:16:14.075', 1, 76, 33, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (143, '2022-01-07 09:16:14.377', '2022-01-07 09:16:14.379', 1, 160, 33, 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (144, '2022-01-07 09:16:14.651', '2022-01-07 09:16:14.653', 1, 168, 33, 59500.000000000000000000000000000000, 60000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (145, '2022-01-07 09:16:14.917', '2022-01-07 09:16:14.919', 1, 169, 33, 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (146, '2022-01-07 09:16:15.209', '2022-01-07 09:16:15.21', 1, 173, 33, 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (147, '2022-01-07 09:16:15.436', '2022-01-07 09:16:15.438', 1, 174, 33, 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (148, '2022-01-07 09:16:15.915', '2022-01-07 09:16:15.916', 1, 31, 34, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (149, '2022-01-07 09:16:16.166', '2022-01-07 09:16:16.167', 1, 171, 34, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (150, '2022-01-07 09:16:16.394', '2022-01-07 09:16:16.395', 1, 172, 34, 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 48, 0, NULL);
INSERT INTO public."OrderItem" VALUES (151, '2022-01-07 09:16:16.852', '2022-01-07 09:16:16.853', 1, 145, 35, 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (152, '2022-01-07 09:16:17.11', '2022-01-07 09:16:17.112', 1, 147, 35, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (153, '2022-01-07 09:16:17.389', '2022-01-07 09:16:17.391', 1, 148, 35, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (154, '2022-01-07 09:16:17.614', '2022-01-07 09:16:17.616', 1, 149, 35, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (155, '2022-01-07 09:16:17.861', '2022-01-07 09:16:17.863', 1, 150, 35, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (156, '2022-01-07 09:16:18.157', '2022-01-07 09:16:18.159', 1, 152, 35, 109500.000000000000000000000000000000, 110000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (157, '2022-01-07 09:16:18.375', '2022-01-07 09:16:18.377', 1, 153, 35, 119500.000000000000000000000000000000, 120000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (158, '2022-01-07 09:16:18.644', '2022-01-07 09:16:18.645', 1, 76, 35, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (159, '2022-01-07 09:16:19.134', '2022-01-07 09:16:19.136', 1, 2, 36, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 36, 0, NULL);
INSERT INTO public."OrderItem" VALUES (160, '2022-01-07 09:16:19.609', '2022-01-07 09:16:19.61', 1, 26, 37, 113500.000000000000000000000000000000, 114000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (161, '2022-01-07 09:16:19.833', '2022-01-07 09:16:19.834', 1, 28, 37, 144500.000000000000000000000000000000, 145000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (162, '2022-01-07 09:16:20.072', '2022-01-07 09:16:20.074', 1, 81, 37, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (163, '2022-01-07 09:16:20.341', '2022-01-07 09:16:20.343', 1, 119, 37, 5000.000000000000000000000000000000, 5500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (164, '2022-01-07 09:16:20.603', '2022-01-07 09:16:20.605', 1, 158, 37, 50500.000000000000000000000000000000, 51000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (165, '2022-01-07 09:16:21.098', '2022-01-07 09:16:21.099', 1, 77, 38, 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (166, '2022-01-07 09:16:21.333', '2022-01-07 09:16:21.335', 1, 105, 38, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (167, '2022-01-07 09:16:21.761', '2022-01-07 09:16:21.763', 1, 106, 38, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (168, '2022-01-07 09:16:22.041', '2022-01-07 09:16:22.043', 1, 96, 38, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (169, '2022-01-07 09:16:22.365', '2022-01-07 09:16:22.367', 1, 97, 38, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (170, '2022-01-07 09:16:22.609', '2022-01-07 09:16:22.61', 1, 98, 38, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (171, '2022-01-07 09:16:22.851', '2022-01-07 09:16:22.852', 1, 99, 38, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (172, '2022-01-07 09:16:23.13', '2022-01-07 09:16:23.132', 1, 100, 38, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (173, '2022-01-07 09:16:23.352', '2022-01-07 09:16:23.353', 1, 101, 38, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (174, '2022-01-07 09:16:23.621', '2022-01-07 09:16:23.623', 1, 118, 38, 10750.000000000000000000000000000000, 11250.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (175, '2022-01-07 09:16:24.177', '2022-01-07 09:16:24.178', 1, 99, 39, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (176, '2022-01-07 09:16:24.417', '2022-01-07 09:16:24.419', 1, 100, 39, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (177, '2022-01-07 09:16:24.729', '2022-01-07 09:16:24.73', 1, 101, 39, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (178, '2022-01-07 09:16:24.984', '2022-01-07 09:16:24.985', 1, 65, 39, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (179, '2022-01-07 09:16:25.229', '2022-01-07 09:16:25.231', 1, 135, 39, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (180, '2022-01-07 09:16:25.726', '2022-01-07 09:16:25.727', 1, 2, 40, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (181, '2022-01-07 09:16:25.957', '2022-01-07 09:16:25.959', 1, 76, 40, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (182, '2022-01-07 09:16:26.23', '2022-01-07 09:16:26.232', 1, 185, 40, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (183, '2022-01-07 09:16:26.465', '2022-01-07 09:16:26.467', 1, 184, 40, 950.000000000000000000000000000000, 4000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (184, '2022-01-07 09:16:26.835', '2022-01-07 09:16:26.837', 1, 179, 40, 7500.000000000000000000000000000000, 8000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (185, '2022-01-07 09:16:27.522', '2022-01-07 09:16:27.524', 1, 58, 41, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (186, '2022-01-07 09:16:27.8', '2022-01-07 09:16:27.802', 1, 159, 41, 65500.000000000000000000000000000000, 60000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (187, '2022-01-07 09:16:28.032', '2022-01-07 09:16:28.034', 1, 158, 41, 50500.000000000000000000000000000000, 51000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (188, '2022-01-07 09:16:28.419', '2022-01-07 09:16:28.42', 1, 162, 41, 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (189, '2022-01-07 09:16:28.747', '2022-01-07 09:16:28.749', 1, 138, 41, 65500.000000000000000000000000000000, 60000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (190, '2022-01-07 09:16:29.473', '2022-01-07 09:16:29.474', 1, 55, 42, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (191, '2022-01-07 09:16:29.756', '2022-01-07 09:16:29.757', 1, 84, 42, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (192, '2022-01-07 09:16:30.071', '2022-01-07 09:16:30.073', 1, 111, 42, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (193, '2022-01-07 09:16:30.63', '2022-01-07 09:16:30.631', 1, 23, 43, 2500.000000000000000000000000000000, 4000.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (194, '2022-01-07 09:16:30.885', '2022-01-07 09:16:30.886', 1, 82, 43, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (195, '2022-01-07 09:16:31.181', '2022-01-07 09:16:31.182', 1, 147, 43, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (196, '2022-01-07 09:16:31.446', '2022-01-07 09:16:31.448', 1, 148, 43, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (197, '2022-01-07 09:16:31.711', '2022-01-07 09:16:31.713', 1, 149, 43, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (198, '2022-01-07 09:16:32.009', '2022-01-07 09:16:32.01', 1, 187, 43, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 5, 0, NULL);
INSERT INTO public."OrderItem" VALUES (199, '2022-01-07 09:16:32.478', '2022-01-07 09:16:32.479', 1, 42, 44, 5750.000000000000000000000000000000, 6250.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (200, '2022-01-07 09:16:32.777', '2022-01-07 09:16:32.778', 1, 56, 44, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (201, '2022-01-07 09:16:33.027', '2022-01-07 09:16:33.029', 1, 111, 44, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (202, '2022-01-07 09:16:33.283', '2022-01-07 09:16:33.285', 1, 129, 44, 38500.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (203, '2022-01-07 09:16:33.751', '2022-01-07 09:16:33.753', 1, 84, 45, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (204, '2022-01-07 09:16:34.219', '2022-01-07 09:16:34.22', 1, 76, 46, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (205, '2022-01-07 09:16:34.465', '2022-01-07 09:16:34.467', 1, 111, 46, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (206, '2022-01-07 09:16:34.689', '2022-01-07 09:16:34.691', 1, 120, 46, 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (207, '2022-01-07 09:16:35.144', '2022-01-07 09:16:35.145', 1, 76, 47, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (208, '2022-01-07 09:16:35.574', '2022-01-07 09:16:35.576', 1, 10, 48, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (209, '2022-01-07 09:16:35.799', '2022-01-07 09:16:35.8', 1, 3, 48, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (210, '2022-01-07 09:16:36.041', '2022-01-07 09:16:36.043', 1, 105, 48, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (211, '2022-01-07 09:16:36.341', '2022-01-07 09:16:36.342', 1, 106, 48, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (212, '2022-01-07 09:16:36.572', '2022-01-07 09:16:36.574', 1, 96, 48, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (213, '2022-01-07 09:16:36.815', '2022-01-07 09:16:36.816', 1, 97, 48, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (214, '2022-01-07 09:16:37.106', '2022-01-07 09:16:37.108', 1, 98, 48, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (215, '2022-01-07 09:16:37.343', '2022-01-07 09:16:37.345', 1, 120, 48, 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (216, '2022-01-07 09:16:37.829', '2022-01-07 09:16:37.83', 1, 58, 49, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (217, '2022-01-07 09:16:38.057', '2022-01-07 09:16:38.059', 1, 121, 49, 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (218, '2022-01-07 09:16:38.286', '2022-01-07 09:16:38.288', 1, 129, 49, 38500.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (219, '2022-01-07 09:16:38.554', '2022-01-07 09:16:38.556', 1, 130, 49, 35500.000000000000000000000000000000, 36000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (220, '2022-01-07 09:16:38.961', '2022-01-07 09:16:38.963', 1, 31, 50, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (221, '2022-01-07 09:16:39.233', '2022-01-07 09:16:39.234', 1, 55, 50, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (222, '2022-01-07 09:16:39.522', '2022-01-07 09:16:39.524', 1, 56, 50, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (223, '2022-01-07 09:16:39.826', '2022-01-07 09:16:39.827', 1, 157, 50, 52000.000000000000000000000000000000, 52500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (224, '2022-01-07 09:16:40.134', '2022-01-07 09:16:40.136', 1, 65, 50, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (225, '2022-01-07 09:16:40.407', '2022-01-07 09:16:40.409', 1, 135, 50, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (226, '2022-01-07 09:16:41.002', '2022-01-07 09:16:41.003', 1, 28, 51, 144500.000000000000000000000000000000, 145000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (227, '2022-01-07 09:16:41.248', '2022-01-07 09:16:41.249', 1, 30, 51, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (228, '2022-01-07 09:16:41.497', '2022-01-07 09:16:41.498', 1, 76, 51, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (229, '2022-01-07 09:16:41.975', '2022-01-07 09:16:41.977', 1, 41, 52, 9000.000000000000000000000000000000, 9500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (230, '2022-01-07 09:16:42.247', '2022-01-07 09:16:42.248', 1, 3, 52, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (231, '2022-01-07 09:16:42.853', '2022-01-07 09:16:42.854', 1, 92, 52, 64500.000000000000000000000000000000, 65000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (232, '2022-01-07 09:16:43.219', '2022-01-07 09:16:43.221', 1, 95, 52, 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (233, '2022-01-07 09:16:43.456', '2022-01-07 09:16:43.458', 1, 185, 52, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (234, '2022-01-07 09:16:43.745', '2022-01-07 09:16:43.746', 1, 153, 52, 119500.000000000000000000000000000000, 120000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (235, '2022-01-07 09:16:43.962', '2022-01-07 09:16:43.963', 1, 197, 52, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (236, '2022-01-07 09:16:44.204', '2022-01-07 09:16:44.207', 1, 66, 52, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (237, '2022-01-07 09:16:44.707', '2022-01-07 09:16:44.708', 1, 85, 53, 5500.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (238, '2022-01-07 09:16:44.93', '2022-01-07 09:16:44.932', 1, 191, 53, 27000.000000000000000000000000000000, 27500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (239, '2022-01-07 09:16:45.189', '2022-01-07 09:16:45.191', 1, 195, 53, 21500.000000000000000000000000000000, 22000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (240, '2022-01-07 09:16:45.411', '2022-01-07 09:16:45.413', 1, 192, 53, 28000.000000000000000000000000000000, 28500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (241, '2022-01-07 09:16:45.645', '2022-01-07 09:16:45.647', 1, 136, 53, 23000.000000000000000000000000000000, 23500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (242, '2022-01-07 09:16:46.102', '2022-01-07 09:16:46.103', 1, 131, 54, 35000.000000000000000000000000000000, 47500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (243, '2022-01-07 09:16:46.331', '2022-01-07 09:16:46.333', 1, 132, 54, 45000.000000000000000000000000000000, 57500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (244, '2022-01-07 09:16:46.766', '2022-01-07 09:16:46.767', 1, 10, 55, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (245, '2022-01-07 09:16:46.993', '2022-01-07 09:16:46.995', 1, 9, 55, 29500.000000000000000000000000000000, 30000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (246, '2022-01-07 09:16:47.44', '2022-01-07 09:16:47.441', 1, 10, 56, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (247, '2022-01-07 09:16:47.696', '2022-01-07 09:16:47.698', 1, 105, 56, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (248, '2022-01-07 09:16:47.989', '2022-01-07 09:16:47.99', 1, 106, 56, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (249, '2022-01-07 09:16:48.218', '2022-01-07 09:16:48.22', 1, 148, 56, 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (251, '2022-01-07 09:16:48.931', '2022-01-07 09:16:48.932', 1, 111, 57, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (250, '2022-01-07 09:16:48.695', '2022-01-07 09:16:48.696', 1, 31, 57, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (252, '2022-01-07 09:16:49.429', '2022-01-07 09:16:49.431', 1, 188, 58, 26000.000000000000000000000000000000, 26500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (254, '2022-01-07 09:16:49.952', '2022-01-07 09:16:49.954', 1, 189, 58, 27000.000000000000000000000000000000, 27500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (256, '2022-01-07 09:16:50.467', '2022-01-07 09:16:50.469', 1, 204, 58, 21000.000000000000000000000000000000, 21500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (258, '2022-01-07 09:16:51.035', '2022-01-07 09:16:51.037', 1, 209, 58, 29000.000000000000000000000000000000, 29500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (260, '2022-01-07 09:16:51.796', '2022-01-07 09:16:51.798', 1, 131, 59, 35000.000000000000000000000000000000, 47500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (262, '2022-01-07 09:16:52.658', '2022-01-07 09:16:52.659', 1, 147, 60, 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (264, '2022-01-07 09:16:53.156', '2022-01-07 09:16:53.157', 1, 152, 60, 109500.000000000000000000000000000000, 110000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (266, '2022-01-07 09:16:53.829', '2022-01-07 09:16:53.831', 1, 76, 61, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (268, '2022-01-07 09:16:54.314', '2022-01-07 09:16:54.316', 1, 172, 61, 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (270, '2022-01-07 09:16:55.033', '2022-01-07 09:16:55.035', 1, 23, 62, 2500.000000000000000000000000000000, 4000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (272, '2022-01-07 09:16:55.691', '2022-01-07 09:16:55.692', 1, 43, 63, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (274, '2022-01-07 09:16:56.152', '2022-01-07 09:16:56.153', 1, 10, 63, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (276, '2022-01-07 09:16:56.632', '2022-01-07 09:16:56.634', 1, 186, 63, 34500.000000000000000000000000000000, 35000.000000000000000000000000000000, 5, 0, NULL);
INSERT INTO public."OrderItem" VALUES (278, '2022-01-07 09:16:57.295', '2022-01-07 09:16:57.296', 1, 85, 64, 5500.000000000000000000000000000000, 10500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (280, '2022-01-07 09:16:57.822', '2022-01-07 09:16:57.824', 1, 99, 64, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (282, '2022-01-07 09:16:58.301', '2022-01-07 09:16:58.302', 1, 101, 64, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (284, '2022-01-07 09:16:58.84', '2022-01-07 09:16:58.841', 1, 105, 64, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (286, '2022-01-07 09:16:59.384', '2022-01-07 09:16:59.386', 1, 157, 64, 52000.000000000000000000000000000000, 52500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (288, '2022-01-07 09:17:00.106', '2022-01-07 09:17:00.108', 1, 56, 65, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (290, '2022-01-07 09:17:00.574', '2022-01-07 09:17:00.576', 1, 157, 65, 52000.000000000000000000000000000000, 52500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (292, '2022-01-07 09:17:01.077', '2022-01-07 09:17:01.078', 1, 32, 65, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (294, '2022-01-07 09:17:01.579', '2022-01-07 09:17:01.58', 1, 22, 65, 6000.000000000000000000000000000000, 6500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (296, '2022-01-07 09:17:02.09', '2022-01-07 09:17:02.092', 1, 65, 65, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (298, '2022-01-07 09:17:03.175', '2022-01-07 09:17:03.177', 1, 31, 66, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (300, '2022-01-07 09:17:03.701', '2022-01-07 09:17:03.702', 1, 76, 66, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (302, '2022-01-07 09:17:04.152', '2022-01-07 09:17:04.154', 1, 100, 66, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (304, '2022-01-07 09:17:04.646', '2022-01-07 09:17:04.648', 1, 111, 66, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (306, '2022-01-07 09:17:05.193', '2022-01-07 09:17:05.194', 1, 171, 66, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (308, '2022-01-07 09:17:05.689', '2022-01-07 09:17:05.69', 1, 135, 66, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (310, '2022-01-07 09:17:06.4', '2022-01-07 09:17:06.402', 1, 106, 67, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (312, '2022-01-07 09:17:07.126', '2022-01-07 09:17:07.128', 1, 96, 68, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (314, '2022-01-07 09:17:07.646', '2022-01-07 09:17:07.647', 1, 98, 68, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (316, '2022-01-07 09:17:08.15', '2022-01-07 09:17:08.151', 1, 108, 68, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (318, '2022-01-07 09:17:08.597', '2022-01-07 09:17:08.6', 1, 100, 68, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (320, '2022-01-07 09:17:09.162', '2022-01-07 09:17:09.164', 1, 188, 68, 26000.000000000000000000000000000000, 26500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (322, '2022-01-07 09:17:09.858', '2022-01-07 09:17:09.86', 1, 3, 69, 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (324, '2022-01-07 09:17:10.357', '2022-01-07 09:17:10.359', 1, 31, 69, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (326, '2022-01-07 09:17:10.826', '2022-01-07 09:17:10.827', 1, 85, 69, 5500.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (328, '2022-01-07 09:17:11.315', '2022-01-07 09:17:11.316', 1, 111, 69, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (330, '2022-01-07 09:17:11.839', '2022-01-07 09:17:11.84', 1, 65, 69, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (332, '2022-01-07 09:17:12.61', '2022-01-07 09:17:12.611', 1, 158, 70, 50500.000000000000000000000000000000, 51000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (334, '2022-01-07 09:17:13.197', '2022-01-07 09:17:13.199', 1, 66, 70, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (336, '2022-01-07 09:17:13.981', '2022-01-07 09:17:13.982', 1, 105, 71, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (338, '2022-01-07 09:17:14.508', '2022-01-07 09:17:14.51', 1, 111, 71, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (340, '2022-01-07 09:17:15.062', '2022-01-07 09:17:15.063', 1, 154, 71, 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (342, '2022-01-07 09:17:15.829', '2022-01-07 09:17:15.83', 1, 172, 72, 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (253, '2022-01-07 09:16:49.692', '2022-01-07 09:16:49.693', 1, 191, 58, 27000.000000000000000000000000000000, 27500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (255, '2022-01-07 09:16:50.245', '2022-01-07 09:16:50.246', 1, 192, 58, 28000.000000000000000000000000000000, 28500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (257, '2022-01-07 09:16:50.747', '2022-01-07 09:16:50.748', 1, 205, 58, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (259, '2022-01-07 09:16:51.32', '2022-01-07 09:16:51.321', 1, 186, 58, 34500.000000000000000000000000000000, 35000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (261, '2022-01-07 09:16:52.027', '2022-01-07 09:16:52.029', 1, 132, 59, 45000.000000000000000000000000000000, 57500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (263, '2022-01-07 09:16:52.932', '2022-01-07 09:16:52.934', 1, 151, 60, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (265, '2022-01-07 09:16:53.421', '2022-01-07 09:16:53.423', 1, 153, 60, 119500.000000000000000000000000000000, 120000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (267, '2022-01-07 09:16:54.053', '2022-01-07 09:16:54.055', 1, 111, 61, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (269, '2022-01-07 09:16:54.535', '2022-01-07 09:16:54.536', 1, 136, 61, 23000.000000000000000000000000000000, 23500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (271, '2022-01-07 09:16:55.255', '2022-01-07 09:16:55.256', 1, 185, 62, 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (273, '2022-01-07 09:16:55.932', '2022-01-07 09:16:55.934', 1, 161, 63, 59500.000000000000000000000000000000, 60000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (275, '2022-01-07 09:16:56.409', '2022-01-07 09:16:56.41', 1, 70, 63, 101000.000000000000000000000000000000, 101500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (277, '2022-01-07 09:16:57.078', '2022-01-07 09:16:57.079', 1, 31, 64, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (279, '2022-01-07 09:16:57.546', '2022-01-07 09:16:57.548', 1, 111, 64, 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 12, 0, NULL);
INSERT INTO public."OrderItem" VALUES (281, '2022-01-07 09:16:58.062', '2022-01-07 09:16:58.064', 1, 100, 64, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (283, '2022-01-07 09:16:58.582', '2022-01-07 09:16:58.584', 1, 131, 64, 35000.000000000000000000000000000000, 47500.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (285, '2022-01-07 09:16:59.091', '2022-01-07 09:16:59.092', 1, 106, 64, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (287, '2022-01-07 09:16:59.63', '2022-01-07 09:16:59.632', 1, 171, 64, 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (289, '2022-01-07 09:17:00.331', '2022-01-07 09:17:00.332', 1, 87, 65, 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (291, '2022-01-07 09:17:00.838', '2022-01-07 09:17:00.839', 1, 186, 65, 34500.000000000000000000000000000000, 35000.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (293, '2022-01-07 09:17:01.306', '2022-01-07 09:17:01.308', 1, 76, 65, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (295, '2022-01-07 09:17:01.809', '2022-01-07 09:17:01.81', 1, 154, 65, 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (297, '2022-01-07 09:17:02.49', '2022-01-07 09:17:02.492', 1, 135, 65, 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (299, '2022-01-07 09:17:03.43', '2022-01-07 09:17:03.432', 1, 43, 66, 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (301, '2022-01-07 09:17:03.909', '2022-01-07 09:17:03.911', 1, 99, 66, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (303, '2022-01-07 09:17:04.425', '2022-01-07 09:17:04.426', 1, 101, 66, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 4, 0, NULL);
INSERT INTO public."OrderItem" VALUES (305, '2022-01-07 09:17:04.887', '2022-01-07 09:17:04.889', 1, 154, 66, 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (307, '2022-01-07 09:17:05.421', '2022-01-07 09:17:05.423', 1, 65, 66, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (309, '2022-01-07 09:17:06.187', '2022-01-07 09:17:06.188', 1, 105, 67, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (311, '2022-01-07 09:17:06.667', '2022-01-07 09:17:06.668', 1, 187, 67, 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (313, '2022-01-07 09:17:07.41', '2022-01-07 09:17:07.412', 1, 97, 68, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (315, '2022-01-07 09:17:07.876', '2022-01-07 09:17:07.878', 1, 107, 68, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (317, '2022-01-07 09:17:08.37', '2022-01-07 09:17:08.371', 1, 99, 68, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (319, '2022-01-07 09:17:08.913', '2022-01-07 09:17:08.915', 1, 101, 68, 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (321, '2022-01-07 09:17:09.399', '2022-01-07 09:17:09.4', 1, 191, 68, 27000.000000000000000000000000000000, 27500.000000000000000000000000000000, 3, 0, NULL);
INSERT INTO public."OrderItem" VALUES (323, '2022-01-07 09:17:10.094', '2022-01-07 09:17:10.096', 1, 56, 69, 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 2, 0, NULL);
INSERT INTO public."OrderItem" VALUES (325, '2022-01-07 09:17:10.594', '2022-01-07 09:17:10.596', 1, 84, 69, 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (327, '2022-01-07 09:17:11.095', '2022-01-07 09:17:11.097', 1, 87, 69, 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (329, '2022-01-07 09:17:11.55', '2022-01-07 09:17:11.551', 1, 186, 69, 34500.000000000000000000000000000000, 35000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (331, '2022-01-07 09:17:12.329', '2022-01-07 09:17:12.331', 1, 151, 70, 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (333, '2022-01-07 09:17:12.963', '2022-01-07 09:17:12.965', 1, 65, 70, 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (335, '2022-01-07 09:17:13.709', '2022-01-07 09:17:13.711', 1, 10, 71, 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (337, '2022-01-07 09:17:14.285', '2022-01-07 09:17:14.286', 1, 106, 71, 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 6, 0, NULL);
INSERT INTO public."OrderItem" VALUES (339, '2022-01-07 09:17:14.762', '2022-01-07 09:17:14.764', 1, 129, 71, 38500.000000000000000000000000000000, 39000.000000000000000000000000000000, 1, 0, NULL);
INSERT INTO public."OrderItem" VALUES (341, '2022-01-07 09:17:15.544', '2022-01-07 09:17:15.545', 1, 76, 72, 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 2, 0, NULL);


--
-- TOC entry 3181 (class 0 OID 498317)
-- Dependencies: 207
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (1, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'aceton heviny 35 ml', 4500.000000000000000000000000000000, 5000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (4, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'body lotion heviny aloevera 600 ml', 15500.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (5, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'body lotion heviny bengkuang 600 ml', 15500.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (6, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'body lotion heviny green tea 600 ml', 15500.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (7, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'body lotion heviny rose 600 ml', 15500.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (8, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'body lotion heviny yogurt & goat milky 600 ml', 15500.000000000000000000000000000000, 16000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (11, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny anti ketombe 250 gr', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (12, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny avocado 250 gram', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (13, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny ginseng 250 gram', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (14, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny kemiri 250 gr', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (15, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny lidah buaya 250 gr', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (16, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny spa avocado 250 gram', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (17, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny spa coconut 250 gram', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (18, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny spa emulsion milky 250 gram', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (19, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny spa papaya jasmine 250 gram', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (20, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'creambath heviny strawberry 250 gr', 12500.000000000000000000000000000000, 13000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (21, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'fitting test fukuta', 6500.000000000000000000000000000000, 7000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (24, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'fitting plafon okka', 3500.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (27, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gembok frt 20 mm', 119500.000000000000000000000000000000, 120000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (33, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 602 b', 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (34, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 612 b', 89500.000000000000000000000000000000, 90000.000000000000000000000000000000, 0, 4, 1, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (37, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 625 a', 95500.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (38, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 692 a', 95500.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (40, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku 777 besar', 101500.000000000000000000000000000000, 102000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (44, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting m2000 sedang hitam', 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (45, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask green tea 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (46, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny coconut 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (47, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny coconut 500 gram', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (48, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny coklat mint 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (49, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny ginseng 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (50, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny ginseng milky 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (51, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny green tea 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (52, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny papaya jasmine 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (53, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny strawberry 500 gr', 30500.000000000000000000000000000000, 31000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (54, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'hair mask heviny sun flower avocado 500 gr', 28500.000000000000000000000000000000, 29000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (59, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'jinzu pepaya brightening soap 50 gr', 9000.000000000000000000000000000000, 9500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (66, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kain pel besar dynamic', 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 0, 42, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (42, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting m2000 kecil hitam', 5750.000000000000000000000000000000, 6250.000000000000000000000000000000, 0, 12, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (26, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gembok freeder 15 mm', 113500.000000000000000000000000000000, 114000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (57, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'jarum tangan voxy', 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 4, 2, 0, 0, 'box');
INSERT INTO public."Product" VALUES (3, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'ballpoint milton s-121', 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 0, 0, 14, 0, 0, 'box');
INSERT INTO public."Product" VALUES (58, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'jarum pentul', 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 18, 24, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (31, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gosok panci', 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 0, 12, 24, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (28, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gembok frt 25 mm', 144500.000000000000000000000000000000, 145000.000000000000000000000000000000, 0, 3, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (43, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting m2000 kecil renteng', 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, 0, 6, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (29, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gembok frt 30 mm', 13250.000000000000000000000000000000, 13750.000000000000000000000000000000, 0, 6, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (25, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'fitting kombinasi', 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 0, 12, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (65, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kain pel sedang dynamic', 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 39, 162, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (55, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'isolasi bening kecil', 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 0, 6, 12, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (35, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 323 a', 95500.000000000000000000000000000000, 96000.000000000000000000000000000000, 0, 3, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (39, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 360 a', 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 3, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (36, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 612 a', 89500.000000000000000000000000000000, 90000.000000000000000000000000000000, 0, 2, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (62, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kabel listrik xrcom 2 x 30 meter', 47000.000000000000000000000000000000, 47500.000000000000000000000000000000, 0, 5, 2, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (30, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gembok majesty 40 mm', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (41, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting m2000 besar hitam', 9000.000000000000000000000000000000, 9500.000000000000000000000000000000, 0, 12, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (32, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'gunting kuku honaga 611 a', 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, 0, 10, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (2, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'aceton heviny 60 ml', 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 0, 0, 156, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (10, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'cottonbuds cici dewasa 045', 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 0, 1, 18, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (9, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'cottonbuds cici bayi', 29500.000000000000000000000000000000, 30000.000000000000000000000000000000, 0, 8, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (22, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'fitting lampu kamar heroic he-4410', 6000.000000000000000000000000000000, 6500.000000000000000000000000000000, 0, 6, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (56, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'isolasi hitam kecil', 11500.000000000000000000000000000000, 12000.000000000000000000000000000000, 0, 8, 20, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (68, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen ct 500', 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (69, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen ct 660', 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (71, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen ct 720', 44000.000000000000000000000000000000, 44500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (72, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen ct 9912', 124500.000000000000000000000000000000, 125000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (73, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen sdc 612c', 124500.000000000000000000000000000000, 125000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (74, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen sdc 868m', 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (75, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kanebo speed-r', 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (78, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'keran air hendso 3 / 4 dim', 19500.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (79, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'keran air onda 3 / 4 dim', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (80, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'keran air tovo 3 / 4 dim', 20750.000000000000000000000000000000, 21250.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (83, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban cokelat besar', 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 0, 12, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (86, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban hitam opp', 10500.000000000000000000000000000000, 11000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (88, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban kain 2 millenium', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (89, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu yazuho 2u 15 watt', 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (90, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu yazuho 2u 18 watt', 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (91, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu yazuho 2u 20 watt', 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (93, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu led emergency flashycom - 12 watt', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (94, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu led stark - 5 watt', 64500.000000000000000000000000000000, 65000.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (102, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu zentama spiral 25 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (103, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu zentama spiral 30 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (104, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu zentama spiral 35 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (109, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lem castol sedang', 68500.000000000000000000000000000000, 69000.000000000000000000000000000000, 0, 6, 0, 0, 0, 'box');
INSERT INTO public."Product" VALUES (112, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lulur heviny brightening 250 gr', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (113, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lulur heviny coffe 250 gr', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (114, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lulur heviny green tea 250 gr', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (115, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lulur heviny madu susu 250 gr', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (116, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lulur heviny mutiara 250 gr', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (117, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lulur heviny strawberry 250 gr', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (122, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'peniti swan', 53500.000000000000000000000000000000, 54000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'box');
INSERT INTO public."Product" VALUES (125, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pinset polos stainless', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (126, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pinset polos mas', 77500.000000000000000000000000000000, 78000.000000000000000000000000000000, 0, 1, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (127, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pinset jerawat kislene jarum', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (128, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pinset jerawat kislene bulat', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (70, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen ct 712', 101000.000000000000000000000000000000, 101500.000000000000000000000000000000, 0, 2, 2, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (123, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pinset motif', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (92, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu led emergency flashycom - 5 watt', 64500.000000000000000000000000000000, 65000.000000000000000000000000000000, 0, 1, 4, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (110, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lem castol mini', 59500.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 5, 2, 0, 0, 'box');
INSERT INTO public."Product" VALUES (124, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pinset polos silver', 71500.000000000000000000000000000000, 72000.000000000000000000000000000000, 0, 2, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (96, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu pancaran 3u 25 watt', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 18, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (81, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kipas angin tangan hello kitty', 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 0, 9, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (82, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban bening besar', 12000.000000000000000000000000000000, 12500.000000000000000000000000000000, 0, 12, 48, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (105, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu ins ekonomis 2u 5 watt', 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 43, 114, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (67, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kalkulator citizen ct 2000', 107000.000000000000000000000000000000, 107500.000000000000000000000000000000, 0, 0, 2, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (111, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lem g', 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 0, 124, 252, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (106, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu ins ekonomis 2u 7 watt', 9500.000000000000000000000000000000, 10000.000000000000000000000000000000, 0, 43, 114, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (119, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'obeng test pen - kecil', 5000.000000000000000000000000000000, 5500.000000000000000000000000000000, 0, 6, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (76, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kapur ajaib bagus', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 15, 90, 0, 0, 'box');
INSERT INTO public."Product" VALUES (77, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'keran air hendso 1 / 2 dim', 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 0, 6, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (121, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pensil alis justmiss 311 - cokelat', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (84, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban bening opp', 10000.000000000000000000000000000000, 10500.000000000000000000000000000000, 0, 18, 84, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (135, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sapu panjang motif - dynamic', 24000.000000000000000000000000000000, 24500.000000000000000000000000000000, 0, 0, 102, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (134, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sapu panjang warna hitam - dynamic', 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 9, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (130, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pisau cutter kecil', 35500.000000000000000000000000000000, 36000.000000000000000000000000000000, 0, 0, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (95, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu led stark - 13 watt', 74500.000000000000000000000000000000, 75000.000000000000000000000000000000, 0, 0, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (87, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban hitam besar tebal', 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 0, 30, 60, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (118, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'meteran frt transparan 3 meter', 10750.000000000000000000000000000000, 11250.000000000000000000000000000000, 0, 0, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (98, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu pancaran 3u 35 watt', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 24, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (108, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu maxxis spiral 35 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 9, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (97, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu pancaran 3u 30 watt', 14500.000000000000000000000000000000, 15000.000000000000000000000000000000, 0, 24, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (107, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu maxxis spiral 25 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 9, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (129, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'pisau cutter besar', 38500.000000000000000000000000000000, 39000.000000000000000000000000000000, 0, 5, 10, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (140, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier action', 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (143, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier bobo classic', 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (144, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier bobo junior', 92500.000000000000000000000000000000, 93000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (146, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier classic medium', 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (156, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat sepatu', 44500.000000000000000000000000000000, 45000.000000000000000000000000000000, 0, 2, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (163, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir rata 7414', 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (165, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir saku 2005', 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (167, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir saku loreng', 29500.000000000000000000000000000000, 30000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (170, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir semir hitam', 3250.000000000000000000000000000000, 3750.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (175, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 981 - kayu', 8500.000000000000000000000000000000, 9000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (176, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 982 - kayu', 8500.000000000000000000000000000000, 9000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (177, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 984 - kayu', 8500.000000000000000000000000000000, 9000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (178, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 991 - kayu', 8500.000000000000000000000000000000, 9000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (180, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 802 - tembok', 7500.000000000000000000000000000000, 8000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (181, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 804 - tembok', 7500.000000000000000000000000000000, 8000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (182, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 891 - tembok', 7500.000000000000000000000000000000, 8000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (183, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'steker over yaichi', 3500.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (190, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 5 lubang 3 meter', 28000.000000000000000000000000000000, 28500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (193, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 5 lubang 5 meter', 29000.000000000000000000000000000000, 29500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (194, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 3 lubang 1,5 meter', 20500.000000000000000000000000000000, 21000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (196, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 5 lubang 1,5 meter', 22500.000000000000000000000000000000, 23000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (198, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos 4 lubang tanpa kabel', 18000.000000000000000000000000000000, 18500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (199, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos 5 lubang tanpa kabel', 19000.000000000000000000000000000000, 19500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (200, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos 3 lubang 3 switch', 21500.000000000000000000000000000000, 22000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (201, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 3 lubang 3 meter', 21500.000000000000000000000000000000, 22000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (202, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 4 lubang 3 meter', 22500.000000000000000000000000000000, 23000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (155, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat pakaian plastik', 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 5, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (160, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir gagang motif', 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 2, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (168, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir segiempat loreng', 59500.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (136, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sapu panjang karet dynamic', 23000.000000000000000000000000000000, 23500.000000000000000000000000000000, 0, 3, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (185, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'steker bulat', 5500.000000000000000000000000000000, 6000.000000000000000000000000000000, 0, 42, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (139, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'shower cup motif - animal', 7000.000000000000000000000000000000, 7500.000000000000000000000000000000, 0, 24, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (142, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier basic soft', 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 1, 8, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (147, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier classic soft', 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 8, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (179, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'stop kontak 801 - tembok', 7500.000000000000000000000000000000, 8000.000000000000000000000000000000, 0, 0, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (157, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'silet goal', 52000.000000000000000000000000000000, 52500.000000000000000000000000000000, 0, 6, 12, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (154, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat pakaian kayu', 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 0, 7, 10, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (159, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir gagang loreng', 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (169, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir segiempat motif', 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (172, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'spon cuci piring - warna', 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 0, 18, 132, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (191, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 3 lubang 5 meter', 27000.000000000000000000000000000000, 27500.000000000000000000000000000000, 0, 3, 18, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (151, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier superior', 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 6, 8, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (171, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'spon cuci piring - segi', 26500.000000000000000000000000000000, 27000.000000000000000000000000000000, 0, 4, 22, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (145, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier bobo travel', 98500.000000000000000000000000000000, 99000.000000000000000000000000000000, 0, 3, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (173, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'spon bedak bulat', 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 0, 0, 6, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (174, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'spon bedak segi', 24500.000000000000000000000000000000, 25000.000000000000000000000000000000, 0, 0, 6, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (161, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir gagang polos', 59500.000000000000000000000000000000, 60000.000000000000000000000000000000, 0, 0, 2, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (150, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier deluxe', 54500.000000000000000000000000000000, 55000.000000000000000000000000000000, 0, 2, 6, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (195, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 4 lubang 1,5 meter', 21500.000000000000000000000000000000, 22000.000000000000000000000000000000, 0, 0, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (162, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir sasak 7413', 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 0, 6, 72, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (197, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos 3 lubang tanpa kabel', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (153, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier twin plus', 119500.000000000000000000000000000000, 120000.000000000000000000000000000000, 0, 6, 8, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (187, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sumbu kompor kecil', 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 12, 24, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (186, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sumbu kompor besar', 34500.000000000000000000000000000000, 35000.000000000000000000000000000000, 0, 12, 24, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (189, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 4 lubang 3 meter', 27000.000000000000000000000000000000, 27500.000000000000000000000000000000, 0, 6, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (158, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir kutu motif - cokelat', 50500.000000000000000000000000000000, 51000.000000000000000000000000000000, 0, 0, 10, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (192, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 4 lubang 5 meter', 28000.000000000000000000000000000000, 28500.000000000000000000000000000000, 0, 6, 12, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (188, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal polos sunfree 3 lubang 3 meter', 26000.000000000000000000000000000000, 26500.000000000000000000000000000000, 0, 12, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (203, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 5 lubang 3 meter', 23500.000000000000000000000000000000, 24000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (206, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 5 lubang 1,5 meter', 18500.000000000000000000000000000000, 19000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (207, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 6 lubang 1,5 meter', 17500.000000000000000000000000000000, 18000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (208, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 3 lubang 5 meter', 27500.000000000000000000000000000000, 28000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (210, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 5 lubang 5 meter', 30000.000000000000000000000000000000, 30500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (211, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 3 lubang tanpa kabel', 14000.000000000000000000000000000000, 14500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (212, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 4 lubang tanpa kabel', 15000.000000000000000000000000000000, 15500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (213, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 5 lubang tanpa kabel', 16000.000000000000000000000000000000, 16500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (214, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 6 lubang tanpa kabel', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (215, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'thai pepaya lightening soap 50 gr', 7500.000000000000000000000000000000, 8000.000000000000000000000000000000, 0, 0, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (60, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kabel putih nym 2 x 1,5 x 50 kawat', 255000.000000000000000000000000000000, 350000.000000000000000000000000000000, 0, 3, 0, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (63, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kabel transparan monster 2 x 50', 30000.000000000000000000000000000000, 62500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (64, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kabel transparan monster 2 x 80', 52000.000000000000000000000000000000, 77500.000000000000000000000000000000, 0, 6, 0, 0, 0, 'roll');
INSERT INTO public."Product" VALUES (61, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'kabel rca 1 - 2', 5000.000000000000000000000000000000, 5500.000000000000000000000000000000, 0, 50, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (137, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'senter push on fl1004', 15000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 25, 0, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (99, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu pancaran spiral 25 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 24, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (149, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier comfort soft', 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 6, 8, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (133, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sapu panjang warna dynamic', 18250.000000000000000000000000000000, 18750.000000000000000000000000000000, 0, 24, 84, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (166, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir saku 2006', 2000.000000000000000000000000000000, 2500.000000000000000000000000000000, 0, 60, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (141, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier basic medium', 47500.000000000000000000000000000000, 48000.000000000000000000000000000000, 0, 0, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (101, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu pancaran spiral 35 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 24, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (120, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'paku tindis', 13000.000000000000000000000000000000, 13500.000000000000000000000000000000, 0, 10, 20, 0, 0, 'box');
INSERT INTO public."Product" VALUES (85, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lakban cokelat opp', 5500.000000000000000000000000000000, 10500.000000000000000000000000000000, 0, 126, 60, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (164, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sisir rata warna', 2500.000000000000000000000000000000, 3000.000000000000000000000000000000, 0, 36, 72, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (148, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier comfort medium', 41500.000000000000000000000000000000, 42000.000000000000000000000000000000, 0, 5, 10, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (204, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 3 lubang 1,5 meter', 21000.000000000000000000000000000000, 21500.000000000000000000000000000000, 0, 6, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (209, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 4 lubang 5 meter', 29000.000000000000000000000000000000, 29500.000000000000000000000000000000, 0, 0, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (205, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'terminal warna 4 lubang 1,5 meter', 22000.000000000000000000000000000000, 22500.000000000000000000000000000000, 0, 6, 6, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (184, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'steker gepeng tris', 950.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 114, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (138, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'shower cup jun da - putih', 65500.000000000000000000000000000000, 66000.000000000000000000000000000000, 0, 0, 4, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (132, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'raket nyamuk sivicom', 45000.000000000000000000000000000000, 57500.000000000000000000000000000000, 0, 3, 24, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (152, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'sikat gigi premier travel pack', 109500.000000000000000000000000000000, 110000.000000000000000000000000000000, 0, 5, 10, 0, 0, 'lusin');
INSERT INTO public."Product" VALUES (23, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'fitting gantung bulat superity', 2500.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 144, 36, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (131, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'raket nyamuk sentosa', 35000.000000000000000000000000000000, 47500.000000000000000000000000000000, 0, 2, 26, 0, 0, 'pcs');
INSERT INTO public."Product" VALUES (100, '2022-01-07 17:15:23.422', '2022-01-07 17:15:23.422', 'lampu pancaran spiral 30 watt', 17000.000000000000000000000000000000, 17500.000000000000000000000000000000, 0, 24, 36, 0, 0, 'pcs');


--
-- TOC entry 3177 (class 0 OID 498297)
-- Dependencies: 203
-- Data for Name: ProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3200 (class 0 OID 498448)
-- Dependencies: 226
-- Data for Name: RecordEquity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."RecordEquity" VALUES (1, '2015-01-15 00:00:00', 43078500.000000000000000000000000000000);
INSERT INTO public."RecordEquity" VALUES (9, '2021-02-27 16:00:00', 46164000.000000000000000000000000000000);


--
-- TOC entry 3196 (class 0 OID 498426)
-- Dependencies: 222
-- Data for Name: RecordProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."RecordProduct" VALUES ('2021-01-01 00:00:00', 43462000.000000000000000000000000000000, 43462000.000000000000000000000000000000);
INSERT INTO public."RecordProduct" VALUES ('2021-01-31 00:00:00', 26473500.000000000000000000000000000000, 26473500.000000000000000000000000000000);


--
-- TOC entry 3183 (class 0 OID 498336)
-- Dependencies: 209
-- Data for Name: StockItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."StockItem" VALUES (1, '2022-01-07 09:15:24.169', '2022-01-07 09:15:24.17', 1, 23, 1, 2500.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 144, 144, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (2, '2022-01-07 09:15:24.45', '2022-01-07 09:15:24.452', 1, 60, 1, 255000.000000000000000000000000000000, 350000.000000000000000000000000000000, 0, 3, 3, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (3, '2022-01-07 09:15:24.756', '2022-01-07 09:15:24.757', 1, 63, 1, 30000.000000000000000000000000000000, 62500.000000000000000000000000000000, 0, 6, 6, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (4, '2022-01-07 09:15:25.061', '2022-01-07 09:15:25.062', 1, 64, 1, 52000.000000000000000000000000000000, 77500.000000000000000000000000000000, 0, 6, 6, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (5, '2022-01-07 09:15:25.329', '2022-01-07 09:15:25.33', 1, 61, 1, 5000.000000000000000000000000000000, 5500.000000000000000000000000000000, 0, 50, 50, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (6, '2022-01-07 09:15:25.574', '2022-01-07 09:15:25.575', 1, 85, 1, 5500.000000000000000000000000000000, 10500.000000000000000000000000000000, 0, 144, 144, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (7, '2022-01-07 09:15:25.844', '2022-01-07 09:15:25.845', 1, 131, 1, 35000.000000000000000000000000000000, 47500.000000000000000000000000000000, 0, 15, 15, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (8, '2022-01-07 09:15:26.127', '2022-01-07 09:15:26.128', 1, 132, 1, 45000.000000000000000000000000000000, 57500.000000000000000000000000000000, 0, 15, 15, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (9, '2022-01-07 09:15:26.45', '2022-01-07 09:15:26.452', 1, 137, 1, 15000.000000000000000000000000000000, 20000.000000000000000000000000000000, 0, 25, 25, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (10, '2022-01-07 09:15:26.703', '2022-01-07 09:15:26.704', 1, 184, 1, 950.000000000000000000000000000000, 4000.000000000000000000000000000000, 0, 120, 120, 0, 0, 0);
INSERT INTO public."StockItem" VALUES (11, '2022-01-07 09:15:27.247', '2022-01-07 09:15:27.248', 1, 154, 2, 25000.000000000000000000000000000000, 39000.000000000000000000000000000000, 0, 10, 10, 0, 0, 0);


--
-- TOC entry 3195 (class 0 OID 498416)
-- Dependencies: 221
-- Data for Name: Tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tool" VALUES (1, '2022-01-07 09:19:59.755', '2022-01-07 09:19:59.756', 'Peralatan Kantor', NULL);


--
-- TOC entry 3191 (class 0 OID 498392)
-- Dependencies: 217
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Transaction" VALUES (2, '2021-01-03 16:00:00', '2021-01-03 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (3, '2021-01-04 16:00:00', '2021-01-04 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (4, '2021-01-04 16:00:00', '2021-01-04 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (5, '2021-01-05 16:00:00', '2021-01-05 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (6, '2021-01-06 16:00:00', '2021-01-06 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (7, '2021-01-07 16:00:00', '2021-01-07 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (8, '2021-01-07 16:00:00', '2021-01-07 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (9, '2021-01-07 16:00:00', '2021-01-07 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 63000.000000000000000000000000000000, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (10, '2021-01-08 16:00:00', '2021-01-08 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 160000.000000000000000000000000000000, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (11, '2021-01-08 16:00:00', '2021-01-08 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (12, '2021-01-08 16:00:00', '2021-01-08 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 22500.000000000000000000000000000000, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (13, '2021-01-10 16:00:00', '2021-01-10 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (14, '2021-01-11 16:00:00', '2021-01-11 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (15, '2021-01-12 16:00:00', '2021-01-12 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (16, '2021-01-13 16:00:00', '2021-01-13 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (17, '2021-01-14 16:00:00', '2021-01-14 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (18, '2021-01-15 16:00:00', '2021-01-15 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (19, '2021-01-15 16:00:00', '2021-01-15 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (20, '2021-01-17 16:00:00', '2021-01-17 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (21, '2021-01-17 16:00:00', '2021-01-17 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 152500.000000000000000000000000000000, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (22, '2021-01-17 16:00:00', '2021-01-17 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 180000.000000000000000000000000000000, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (23, '2021-01-18 16:00:00', '2021-01-18 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (24, '2021-01-18 16:00:00', '2021-01-18 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (25, '2021-01-19 16:00:00', '2021-01-19 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 412500.000000000000000000000000000000, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (26, '2021-01-19 16:00:00', '2021-01-19 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (27, '2021-01-20 16:00:00', '2021-01-20 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (28, '2021-01-20 16:00:00', '2021-01-20 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 100000.000000000000000000000000000000, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (29, '2021-01-21 16:00:00', '2021-01-21 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (30, '2021-01-21 16:00:00', '2021-01-21 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (31, '2021-01-21 16:00:00', '2021-01-21 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 200000.000000000000000000000000000000, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (32, '2021-01-22 16:00:00', '2021-01-22 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (33, '2021-01-24 16:00:00', '2021-01-24 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (34, '2021-01-25 16:00:00', '2021-01-25 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (35, '2021-01-25 16:00:00', '2021-01-25 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 165000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (36, '2021-01-26 16:00:00', '2021-01-26 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (37, '2021-01-27 16:00:00', '2021-01-27 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (38, '2021-01-28 16:00:00', '2021-01-28 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 79000.000000000000000000000000000000, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (39, '2021-01-28 16:00:00', '2021-01-28 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (40, '2021-01-29 16:00:00', '2021-01-29 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 10000.000000000000000000000000000000, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (41, '2021-01-29 16:00:00', '2021-01-29 16:00:00', 1, 'CREDIT', 'SUCCESS', 'OFFLINE', 1286000.000000000000000000000000000000, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (42, '2021-01-17 16:00:00', '2022-01-07 09:15:27.038', 1, 'CREDIT', 'SUCCESS', 'CASH', 4348000.000000000000000000000000000000, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (43, '2021-01-28 16:00:00', '2022-01-07 09:15:27.608', 1, 'CREDIT', 'SUCCESS', 'CASH', 250000.000000000000000000000000000000, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (44, '2021-01-04 16:00:00', '2022-01-07 09:15:28.335', 1, 'DEBIT', 'SUCCESS', 'CASH', 39000.000000000000000000000000000000, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (45, '2021-01-04 16:00:00', '2022-01-07 09:15:29.401', 1, 'DEBIT', 'SUCCESS', 'CASH', 184500.000000000000000000000000000000, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (46, '2021-01-04 16:00:00', '2022-01-07 09:15:29.919', 1, 'DEBIT', 'SUCCESS', 'CASH', 90000.000000000000000000000000000000, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (47, '2021-01-04 16:00:00', '2022-01-07 09:15:30.382', 1, 'DEBIT', 'SUCCESS', 'CASH', 60000.000000000000000000000000000000, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (48, '2021-01-04 16:00:00', '2022-01-07 09:15:31.387', 1, 'DEBIT', 'SUCCESS', 'CASH', 379500.000000000000000000000000000000, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (49, '2021-01-04 16:00:00', '2022-01-07 09:15:32.373', 1, 'DEBIT', 'SUCCESS', 'CASH', 379500.000000000000000000000000000000, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (50, '2021-01-04 16:00:00', '2022-01-07 09:15:33.117', 1, 'DEBIT', 'SUCCESS', 'CASH', 120000.000000000000000000000000000000, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (51, '2021-01-04 16:00:00', '2022-01-07 09:15:34.623', 1, 'DEBIT', 'SUCCESS', 'CASH', 255000.000000000000000000000000000000, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (52, '2021-01-04 16:00:00', '2022-01-07 09:15:37.097', 1, 'DEBIT', 'SUCCESS', 'CASH', 446000.000000000000000000000000000000, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (53, '2021-01-04 16:00:00', '2022-01-07 09:15:38.347', 1, 'DEBIT', 'SUCCESS', 'CASH', 774000.000000000000000000000000000000, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (54, '2021-01-06 16:00:00', '2022-01-07 09:15:40.733', 1, 'DEBIT', 'SUCCESS', 'CASH', 289500.000000000000000000000000000000, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (55, '2021-01-06 16:00:00', '2022-01-07 09:15:41.432', 1, 'DEBIT', 'SUCCESS', 'CASH', 38500.000000000000000000000000000000, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (56, '2021-01-06 16:00:00', '2022-01-07 09:15:42.441', 1, 'DEBIT', 'SUCCESS', 'CASH', 142000.000000000000000000000000000000, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (57, '2021-01-06 16:00:00', '2022-01-07 09:15:43.397', 1, 'DEBIT', 'SUCCESS', 'CASH', 76000.000000000000000000000000000000, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (58, '2021-01-06 16:00:00', '2022-01-07 09:15:46.063', 1, 'DEBIT', 'SUCCESS', 'CASH', 627000.000000000000000000000000000000, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (59, '2021-01-07 16:00:00', '2022-01-07 09:15:47.325', 1, 'DEBIT', 'SUCCESS', 'CASH', 276000.000000000000000000000000000000, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (60, '2021-01-07 16:00:00', '2022-01-07 09:15:47.827', 1, 'DEBIT', 'SUCCESS', 'CASH', 159000.000000000000000000000000000000, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (61, '2021-01-07 16:00:00', '2022-01-07 09:15:51.87', 1, 'DEBIT', 'SUCCESS', 'CASH', 966000.000000000000000000000000000000, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (62, '2021-01-07 16:00:00', '2022-01-07 09:15:56.798', 1, 'DEBIT', 'SUCCESS', 'CASH', 1227000.000000000000000000000000000000, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (63, '2021-01-10 16:00:00', '2022-01-07 09:15:57.286', 1, 'DEBIT', 'SUCCESS', 'CASH', 120000.000000000000000000000000000000, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (64, '2021-01-10 16:00:00', '2022-01-07 09:15:58.908', 1, 'DEBIT', 'SUCCESS', 'CASH', 292500.000000000000000000000000000000, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (65, '2021-01-10 16:00:00', '2022-01-07 09:15:59.383', 1, 'DEBIT', 'SUCCESS', 'CASH', 40000.000000000000000000000000000000, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (66, '2021-01-10 16:00:00', '2022-01-07 09:16:00.202', 1, 'DEBIT', 'SUCCESS', 'CASH', 255000.000000000000000000000000000000, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (67, '2021-01-10 16:00:00', '2022-01-07 09:16:01.227', 1, 'DEBIT', 'SUCCESS', 'CASH', 111000.000000000000000000000000000000, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (68, '2021-01-10 16:00:00', '2022-01-07 09:16:04.158', 1, 'DEBIT', 'SUCCESS', 'CASH', 618500.000000000000000000000000000000, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (69, '2021-01-10 16:00:00', '2022-01-07 09:16:05.183', 1, 'DEBIT', 'SUCCESS', 'CASH', 159000.000000000000000000000000000000, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (70, '2021-01-10 16:00:00', '2022-01-07 09:16:07.01', 1, 'DEBIT', 'SUCCESS', 'CASH', 388500.000000000000000000000000000000, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (71, '2021-01-10 16:00:00', '2022-01-07 09:16:09.167', 1, 'DEBIT', 'SUCCESS', 'CASH', 285000.000000000000000000000000000000, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (72, '2021-01-10 16:00:00', '2022-01-07 09:16:11.307', 1, 'DEBIT', 'SUCCESS', 'CASH', 405000.000000000000000000000000000000, 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (73, '2021-01-10 16:00:00', '2022-01-07 09:16:13.1', 1, 'DEBIT', 'SUCCESS', 'CASH', 376000.000000000000000000000000000000, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (74, '2021-01-12 16:00:00', '2022-01-07 09:16:15.708', 1, 'DEBIT', 'SUCCESS', 'CASH', 563000.000000000000000000000000000000, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (75, '2021-01-12 16:00:00', '2022-01-07 09:16:16.703', 1, 'DEBIT', 'SUCCESS', 'CASH', 336000.000000000000000000000000000000, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (76, '2021-01-12 16:00:00', '2022-01-07 09:16:18.964', 1, 'DEBIT', 'SUCCESS', 'CASH', 606000.000000000000000000000000000000, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (77, '2021-01-12 16:00:00', '2022-01-07 09:16:19.388', 1, 'DEBIT', 'SUCCESS', 'CASH', 216000.000000000000000000000000000000, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (78, '2021-01-12 16:00:00', '2022-01-07 09:16:20.879', 1, 'DEBIT', 'SUCCESS', 'CASH', 415000.000000000000000000000000000000, 37, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (79, '2021-01-14 16:00:00', '2022-01-07 09:16:23.978', 1, 'DEBIT', 'SUCCESS', 'CASH', 585000.000000000000000000000000000000, 38, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (80, '2021-01-14 16:00:00', '2022-01-07 09:16:25.551', 1, 'DEBIT', 'SUCCESS', 'CASH', 597000.000000000000000000000000000000, 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (81, '2021-01-14 16:00:00', '2022-01-07 09:16:27.208', 1, 'DEBIT', 'SUCCESS', 'CASH', 198000.000000000000000000000000000000, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (82, '2021-01-14 16:00:00', '2022-01-07 09:16:29.248', 1, 'DEBIT', 'SUCCESS', 'CASH', 267000.000000000000000000000000000000, 41, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (83, '2021-01-14 16:00:00', '2022-01-07 09:16:30.448', 1, 'DEBIT', 'SUCCESS', 'CASH', 165000.000000000000000000000000000000, 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (84, '2021-01-18 16:00:00', '2022-01-07 09:16:32.295', 1, 'DEBIT', 'SUCCESS', 'CASH', 442500.000000000000000000000000000000, 43, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (85, '2021-01-18 16:00:00', '2022-01-07 09:16:33.606', 1, 'DEBIT', 'SUCCESS', 'CASH', 216000.000000000000000000000000000000, 44, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (86, '2021-01-18 16:00:00', '2022-01-07 09:16:34.005', 1, 'DEBIT', 'SUCCESS', 'CASH', 63000.000000000000000000000000000000, 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (87, '2021-01-18 16:00:00', '2022-01-07 09:16:34.977', 1, 'DEBIT', 'SUCCESS', 'CASH', 87000.000000000000000000000000000000, 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (88, '2021-01-18 16:00:00', '2022-01-07 09:16:35.375', 1, 'DEBIT', 'SUCCESS', 'CASH', 45000.000000000000000000000000000000, 47, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (89, '2021-01-18 16:00:00', '2022-01-07 09:16:37.614', 1, 'DEBIT', 'SUCCESS', 'CASH', 362500.000000000000000000000000000000, 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (90, '2021-01-18 16:00:00', '2022-01-07 09:16:38.797', 1, 'DEBIT', 'SUCCESS', 'CASH', 170000.000000000000000000000000000000, 49, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (91, '2021-01-19 16:00:00', '2022-01-07 09:16:40.773', 1, 'DEBIT', 'SUCCESS', 'CASH', 321000.000000000000000000000000000000, 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (94, '2021-01-22 16:00:00', '2022-01-07 09:16:45.931', 1, 'DEBIT', 'SUCCESS', 'CASH', 367500.000000000000000000000000000000, 53, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (95, '2021-01-22 16:00:00', '2022-01-07 09:16:46.62', 1, 'DEBIT', 'SUCCESS', 'CASH', 630000.000000000000000000000000000000, 54, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (96, '2021-01-22 16:00:00', '2022-01-07 09:16:47.294', 1, 'DEBIT', 'SUCCESS', 'CASH', 108000.000000000000000000000000000000, 55, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (97, '2021-01-22 16:00:00', '2022-01-07 09:16:48.482', 1, 'DEBIT', 'SUCCESS', 'CASH', 186000.000000000000000000000000000000, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (98, '2021-01-22 16:00:00', '2022-01-07 09:16:49.205', 1, 'DEBIT', 'SUCCESS', 'CASH', 72000.000000000000000000000000000000, 57, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (99, '2021-01-22 16:00:00', '2022-01-07 09:16:51.584', 1, 'DEBIT', 'SUCCESS', 'CASH', 620500.000000000000000000000000000000, 58, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (100, '2021-01-24 16:00:00', '2022-01-07 09:16:52.456', 1, 'DEBIT', 'SUCCESS', 'CASH', 630000.000000000000000000000000000000, 59, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (101, '2021-01-24 16:00:00', '2022-01-07 09:16:53.679', 1, 'DEBIT', 'SUCCESS', 'CASH', 333000.000000000000000000000000000000, 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (102, '2021-01-24 16:00:00', '2022-01-07 09:16:54.814', 1, 'DEBIT', 'SUCCESS', 'CASH', 261000.000000000000000000000000000000, 61, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (103, '2021-01-24 16:00:00', '2022-01-07 09:16:55.489', 1, 'DEBIT', 'SUCCESS', 'CASH', 60000.000000000000000000000000000000, 62, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (105, '2021-01-26 16:00:00', '2022-01-07 09:16:59.9', 1, 'DEBIT', 'SUCCESS', 'CASH', 649000.000000000000000000000000000000, 64, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (106, '2021-01-26 16:00:00', '2022-01-07 09:17:02.943', 1, 'DEBIT', 'SUCCESS', 'CASH', 756500.000000000000000000000000000000, 65, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (108, '2021-01-26 16:00:00', '2022-01-07 09:17:06.964', 1, 'DEBIT', 'SUCCESS', 'CASH', 105000.000000000000000000000000000000, 67, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (109, '2021-01-26 16:00:00', '2022-01-07 09:17:09.707', 1, 'DEBIT', 'SUCCESS', 'CASH', 462000.000000000000000000000000000000, 68, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (92, '2021-01-19 16:00:00', '2022-01-07 09:16:41.808', 1, 'DEBIT', 'SUCCESS', 'CASH', 265000.000000000000000000000000000000, 51, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (93, '2021-01-19 16:00:00', '2022-01-07 09:16:44.514', 1, 'DEBIT', 'SUCCESS', 'CASH', 982500.000000000000000000000000000000, 52, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (104, '2021-01-24 16:00:00', '2022-01-07 09:16:56.878', 1, 'DEBIT', 'SUCCESS', 'CASH', 456500.000000000000000000000000000000, 63, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (107, '2021-01-26 16:00:00', '2022-01-07 09:17:06.012', 1, 'DEBIT', 'SUCCESS', 'CASH', 717000.000000000000000000000000000000, 66, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (110, '2021-01-26 16:00:00', '2022-01-07 09:17:12.109', 1, 'DEBIT', 'SUCCESS', 'CASH', 540000.000000000000000000000000000000, 69, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (111, '2021-01-28 16:00:00', '2022-01-07 09:17:13.526', 1, 'DEBIT', 'SUCCESS', 'CASH', 361000.000000000000000000000000000000, 70, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (112, '2021-01-28 16:00:00', '2022-01-07 09:17:15.362', 1, 'DEBIT', 'SUCCESS', 'CASH', 312000.000000000000000000000000000000, 71, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (113, '2021-01-28 16:00:00', '2022-01-07 09:17:16.083', 1, 'DEBIT', 'SUCCESS', 'CASH', 60000.000000000000000000000000000000, 72, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public."Transaction" VALUES (1, '2015-01-14 00:00:00', '2015-01-14 00:00:00', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 43074500.000000000000000000000000000000, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'Penambahan modal');
INSERT INTO public."Transaction" VALUES (114, '2021-01-12 16:00:00', '2022-01-07 09:20:59.383', 1, 'CREDIT', 'SUCCESS', 'ONLINE', 124000.000000000000000000000000000000, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL);


--
-- TOC entry 3179 (class 0 OID 498306)
-- Dependencies: 205
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES (1, 'adminzero', 'adminzero', '$2b$04$68M.gtbmmBsGq6fu/KUHzeikFjXovxq6Q30UguZFuCclsF.fm9B1m', 'ADMIN', NULL, NULL, NULL);
INSERT INTO public."User" VALUES (2, 'Ks.Hasna', NULL, NULL, 'CUSTOMER', 'Jl.Nangka - Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (3, 'Ks.Rahmadani', NULL, NULL, 'CUSTOMER', 'Jl.Nangka - Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (4, 'Ks.Awal', NULL, NULL, 'CUSTOMER', 'Jl.Bunga Jati - Kelapa Lima', NULL, NULL);
INSERT INTO public."User" VALUES (5, 'Ks.Naldy', NULL, NULL, 'CUSTOMER', 'Jl.TDM V - TDM V', NULL, NULL);
INSERT INTO public."User" VALUES (6, 'Ks. Azam Cell', NULL, NULL, 'CUSTOMER', 'Noelbaki', NULL, NULL);
INSERT INTO public."User" VALUES (7, 'Ks. Adrian Cell', NULL, NULL, 'CUSTOMER', 'Jl.Farmasi - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (8, 'Ks.Noval', NULL, NULL, 'CUSTOMER', 'Jl.Timor Raya Km.7 - Oesapa', NULL, NULL);
INSERT INTO public."User" VALUES (9, 'Ks.Bilkis', NULL, NULL, 'CUSTOMER', 'Jl.Pulau Indah - Kelapa Lima', NULL, NULL);
INSERT INTO public."User" VALUES (10, 'Ks.Susan', NULL, NULL, 'CUSTOMER', 'Jl.Lubang Jati - Manutapen', NULL, NULL);
INSERT INTO public."User" VALUES (11, 'Ks.Risky', NULL, NULL, 'CUSTOMER', 'Jurusan Gereja Eden Nisbaki - Manutapen', NULL, NULL);
INSERT INTO public."User" VALUES (12, 'Ks.Saldi', NULL, NULL, 'CUSTOMER', 'Jl.Sukun 1 - Oepura', NULL, NULL);
INSERT INTO public."User" VALUES (13, 'Ks. Amin', NULL, NULL, 'CUSTOMER', 'Depan IndoSablon - Belakang Pasar Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (14, 'Tk.Tirta Mas', NULL, NULL, 'CUSTOMER', 'Jl.Fetor Funay - BTN', NULL, NULL);
INSERT INTO public."User" VALUES (15, 'Ks.Bintang', NULL, NULL, 'CUSTOMER', 'Jl.Pemuda - Kuanino', NULL, NULL);
INSERT INTO public."User" VALUES (16, 'Ks.Tahar Dua', NULL, NULL, 'CUSTOMER', 'Jl.Pemuda - Kuanino', NULL, NULL);
INSERT INTO public."User" VALUES (17, 'Ks.Putra Tunggal', NULL, NULL, 'CUSTOMER', 'Jl.Bhakti Karang - Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (18, 'Ks.Wahyu', NULL, NULL, 'CUSTOMER', 'Jl.El Tari 3 - Penfui', NULL, NULL);
INSERT INTO public."User" VALUES (19, 'Best Mart', NULL, NULL, 'CUSTOMER', 'Jl.Timor Raya Km.9 - Oesapa', NULL, NULL);
INSERT INTO public."User" VALUES (20, 'King Mart', NULL, NULL, 'CUSTOMER', 'Jl.Adisucipto - Penfui', NULL, NULL);
INSERT INTO public."User" VALUES (21, 'Ks.Andi', NULL, NULL, 'CUSTOMER', 'Jl.Timor Raya - Tuapukan', NULL, NULL);
INSERT INTO public."User" VALUES (22, 'Ks.A''an', NULL, NULL, 'CUSTOMER', 'Jl.Timor Raya - Babau', NULL, NULL);
INSERT INTO public."User" VALUES (23, 'Ks.Nursyafika', NULL, NULL, 'CUSTOMER', 'Jurusan Wira Aji - Naibonat', NULL, NULL);
INSERT INTO public."User" VALUES (24, 'Ks.Ridwan', NULL, NULL, 'CUSTOMER', 'Jurusan Kantor Bupati - Naibonat', NULL, NULL);
INSERT INTO public."User" VALUES (25, 'Ks.Akbar', NULL, NULL, 'CUSTOMER', 'Depan Pertamina - Naibonat', NULL, NULL);
INSERT INTO public."User" VALUES (26, 'Ks.Kirana', NULL, NULL, 'CUSTOMER', 'Jurusan Pertamina - Naibonat', NULL, NULL);
INSERT INTO public."User" VALUES (27, 'Ks.Lima Utama', NULL, NULL, 'CUSTOMER', 'Belakang Polresta - Walikota', NULL, NULL);
INSERT INTO public."User" VALUES (28, 'Ks.Cahaya Ismail', NULL, NULL, 'CUSTOMER', 'Jl.Nusantara - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (29, 'Ks.Putra - Putri', NULL, NULL, 'CUSTOMER', 'Jurusan Anugerah Mandiri - Jalur 40', NULL, NULL);
INSERT INTO public."User" VALUES (30, 'Ks.Putra - Putri Dua', NULL, NULL, 'CUSTOMER', 'Jurusan SMA Negeri 6 - Sikumana', NULL, NULL);
INSERT INTO public."User" VALUES (31, 'Aquarius Mart', NULL, NULL, 'CUSTOMER', 'Jl.Timor Raya Km.9 - Oesapa', NULL, NULL);
INSERT INTO public."User" VALUES (32, 'Marina Mart', NULL, NULL, 'CUSTOMER', 'Jl.Piet A.Tallo - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (33, '911 Mart', NULL, NULL, 'CUSTOMER', 'Jl.El Tari 3 - Penfui', NULL, NULL);
INSERT INTO public."User" VALUES (34, 'Top Mart', NULL, NULL, 'CUSTOMER', 'Jl.Jendral Sudirman - Kuanino', NULL, NULL);
INSERT INTO public."User" VALUES (35, 'Tk. Firmansyah', NULL, NULL, 'CUSTOMER', 'Jl.Piet A.Tallo - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (36, 'Ks.Lima - Lima', NULL, NULL, 'CUSTOMER', 'Jl.Taebenu - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (37, 'Ks. Gracia', NULL, NULL, 'CUSTOMER', 'Jl. Nasipanaf - Penfui', NULL, NULL);
INSERT INTO public."User" VALUES (38, 'Bukit Bangunan', NULL, NULL, 'CUSTOMER', 'Jl.H.R Koroh - Sikumana', NULL, NULL);
INSERT INTO public."User" VALUES (39, 'Ks.Kitinaubina', NULL, NULL, 'CUSTOMER', 'Jl.Nangka - Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (40, 'Tk.Alta Indah', NULL, NULL, 'CUSTOMER', 'Jl.Pahlawan - Namosain', NULL, NULL);
INSERT INTO public."User" VALUES (41, 'Ks.Radit', NULL, NULL, 'CUSTOMER', 'Jl.Alfons Nisnoni - Airnona', NULL, NULL);
INSERT INTO public."User" VALUES (42, 'Ks.Waru', NULL, NULL, 'CUSTOMER', 'Jl.Timor Raya - Pasir Panjang', NULL, NULL);
INSERT INTO public."User" VALUES (43, 'Ks.Sifatuo', NULL, NULL, 'CUSTOMER', 'Jl. Hans Kapitan - Kelapa Lima', NULL, NULL);
INSERT INTO public."User" VALUES (44, 'Ks.Nirma', NULL, NULL, 'CUSTOMER', 'Jl.Hans Kapitan - Kelapa Lima', NULL, NULL);
INSERT INTO public."User" VALUES (45, 'Tirosa Mart', NULL, NULL, 'CUSTOMER', 'Jl.Biknoi - Naikoten', NULL, NULL);
INSERT INTO public."User" VALUES (46, 'Ks.Rafqi', NULL, NULL, 'CUSTOMER', 'Jl.Alfons Nisnoni - Batuplat', NULL, NULL);
INSERT INTO public."User" VALUES (47, 'Ks.Aqila', NULL, NULL, 'CUSTOMER', 'Jl. Jambu - Manulai 2', NULL, NULL);
INSERT INTO public."User" VALUES (48, 'Ks.Lisda', NULL, NULL, 'CUSTOMER', 'Jurusan SMA Negeri 6 - Sikumana', NULL, NULL);
INSERT INTO public."User" VALUES (49, 'Ks.Sifatuo', NULL, NULL, 'CUSTOMER', 'Jl.Bhakti Karang - Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (50, 'Ks.Kembar', NULL, NULL, 'CUSTOMER', 'Jl.Bundaran PU - Oebufu', NULL, NULL);
INSERT INTO public."User" VALUES (51, 'Bengkel Paparisa', NULL, NULL, 'CUSTOMER', 'Jl.H.R Koroh - Sikumana', NULL, NULL);
INSERT INTO public."User" VALUES (52, 'Ks.Three - F', NULL, NULL, 'CUSTOMER', 'Jl.Jendral Sudirman - Kuanino', NULL, NULL);
INSERT INTO public."User" VALUES (53, 'Tiara Mart', NULL, NULL, 'CUSTOMER', 'Jl.Piet A.Tallo - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (54, 'Ks.Amin', NULL, NULL, 'CUSTOMER', 'Depan IndoSablon - Belakang Pasar Oebobo', NULL, NULL);
INSERT INTO public."User" VALUES (55, 'Ks.Nadine 1', NULL, NULL, 'CUSTOMER', 'Jurusan JP Home Stay - Liliba', NULL, NULL);
INSERT INTO public."User" VALUES (56, 'Ks.Christin Cell', NULL, NULL, 'CUSTOMER', 'Jl.Kejora - Jurusan RM.Telaga Opa Oepoi', NULL, NULL);
INSERT INTO public."User" VALUES (57, 'Ks.Irfan Jaya', NULL, NULL, 'CUSTOMER', 'Jurusan Susteran Fioretti - Penfui', NULL, NULL);
INSERT INTO public."User" VALUES (58, 'UD.Shinta', NULL, NULL, 'CUSTOMER', 'Jl.H.R Koroh - Sikumana', NULL, NULL);
INSERT INTO public."User" VALUES (59, 'UD.Keagungan', NULL, NULL, 'CUSTOMER', 'Jl.Oematan - Walikota', NULL, NULL);
INSERT INTO public."User" VALUES (60, 'Ks.Sani Jaya', NULL, NULL, 'CUSTOMER', 'Jurusan Fatukoa - Jalur 40', NULL, NULL);
INSERT INTO public."User" VALUES (61, 'Ks.Three - F', NULL, NULL, 'CUSTOMER', 'Jl.Jendral Sudirman - Kuanino', NULL, NULL);
INSERT INTO public."User" VALUES (62, 'Ks.Mira', NULL, NULL, 'CUSTOMER', 'Jl.El Tari 3 - Penfui', NULL, NULL);
INSERT INTO public."User" VALUES (63, 'Ks.Bilkis', NULL, NULL, 'CUSTOMER', 'Jl.Pulau Indah - Kelapa Lima', NULL, NULL);
INSERT INTO public."User" VALUES (64, 'Ks.Risky', NULL, NULL, 'CUSTOMER', 'Jurusan Gereja Eden Nisbaki - Manutapen', NULL, NULL);
INSERT INTO public."User" VALUES (65, 'Ks.Adiyasta', NULL, NULL, 'CUSTOMER', 'Jl.Lubang Jati - Manutapen', NULL, NULL);
INSERT INTO public."User" VALUES (66, 'Ks.Arni', NULL, NULL, 'CUSTOMER', 'Jl.TDM II - TDM II', NULL, NULL);
INSERT INTO public."User" VALUES (67, 'Flobamor Mart', NULL, NULL, 'CUSTOMER', 'Jurusan TDM II A - TDM II', NULL, NULL);
INSERT INTO public."User" VALUES (68, 'Ks.Ridho', NULL, NULL, 'CUSTOMER', 'Jurusan Jembatan Pohon Duri - Oesapa', NULL, NULL);
INSERT INTO public."User" VALUES (69, 'Ks.Nirwana', NULL, NULL, 'CUSTOMER', 'Jl.Bajawa (SMK N 4) - Oepoi', NULL, NULL);
INSERT INTO public."User" VALUES (70, 'Ks.Nona', NULL, NULL, 'CUSTOMER', 'Jl.Pemuda - Kuanino', NULL, NULL);
INSERT INTO public."User" VALUES (71, 'Ks.Gala Mahesa', NULL, NULL, 'CUSTOMER', 'Jl.Oe''ekam - Sikumana', NULL, NULL);
INSERT INTO public."User" VALUES (72, 'PT. Mentari Dynamic Indonesia', NULL, NULL, 'SUPPLIER', 'A', '0124', NULL);
INSERT INTO public."User" VALUES (73, 'Sukses Jaya Abadi', NULL, NULL, 'SUPPLIER', 'A', '0124', NULL);
INSERT INTO public."User" VALUES (74, 'CV. Sinar Laut Timor Kupang', NULL, NULL, 'SUPPLIER', 'B', '0233', NULL);


--
-- TOC entry 3204 (class 0 OID 498473)
-- Dependencies: 230
-- Data for Name: _ProductToProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 214
-- Name: Delay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Delay_id_seq"', 1, false);


--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 223
-- Name: EquityChange_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."EquityChange_id_seq"', 1, false);


--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 227
-- Name: Investment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Investment_id_seq"', 1, false);


--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 218
-- Name: Opex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Opex_id_seq"', 1, false);


--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 210
-- Name: OrderItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_id_seq"', 342, true);


--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 212
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 72, true);


--
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 202
-- Name: ProductCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductCategory_id_seq"', 1, false);


--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 206
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 215, true);


--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 225
-- Name: RecordEquity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RecordEquity_id_seq"', 9, true);


--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 208
-- Name: StockItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."StockItem_id_seq"', 11, true);


--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 220
-- Name: Tool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tool_id_seq"', 1, true);


--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 216
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 114, true);


--
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 204
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 74, true);


--
-- TOC entry 3010 (class 2606 OID 498389)
-- Name: Delay Delay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_pkey" PRIMARY KEY (id);


--
-- TOC entry 3022 (class 2606 OID 498445)
-- Name: EquityChange EquityChange_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EquityChange"
    ADD CONSTRAINT "EquityChange_pkey" PRIMARY KEY (id);


--
-- TOC entry 3028 (class 2606 OID 498472)
-- Name: FinanceReport FinanceReport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FinanceReport"
    ADD CONSTRAINT "FinanceReport_pkey" PRIMARY KEY (target);


--
-- TOC entry 3026 (class 2606 OID 498467)
-- Name: Investment Investment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Investment"
    ADD CONSTRAINT "Investment_pkey" PRIMARY KEY (id);


--
-- TOC entry 3016 (class 2606 OID 498413)
-- Name: Opex Opex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Opex"
    ADD CONSTRAINT "Opex_pkey" PRIMARY KEY (id);


--
-- TOC entry 3005 (class 2606 OID 498361)
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- TOC entry 3007 (class 2606 OID 498380)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 2997 (class 2606 OID 498303)
-- Name: ProductCategory ProductCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "ProductCategory_pkey" PRIMARY KEY (id);


--
-- TOC entry 3001 (class 2606 OID 498333)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 3024 (class 2606 OID 498455)
-- Name: RecordEquity RecordEquity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecordEquity"
    ADD CONSTRAINT "RecordEquity_pkey" PRIMARY KEY (id);


--
-- TOC entry 3020 (class 2606 OID 498433)
-- Name: RecordProduct RecordProduct_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecordProduct"
    ADD CONSTRAINT "RecordProduct_pkey" PRIMARY KEY (date);


--
-- TOC entry 3003 (class 2606 OID 498348)
-- Name: StockItem StockItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_pkey" PRIMARY KEY (id);


--
-- TOC entry 3018 (class 2606 OID 498425)
-- Name: Tool Tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tool"
    ADD CONSTRAINT "Tool_pkey" PRIMARY KEY (id);


--
-- TOC entry 3014 (class 2606 OID 498401)
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- TOC entry 2999 (class 2606 OID 498314)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3008 (class 1259 OID 498476)
-- Name: Delay_orderId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Delay_orderId_unique" ON public."Delay" USING btree ("orderId");


--
-- TOC entry 3011 (class 1259 OID 498478)
-- Name: Transaction_equityChangeId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Transaction_equityChangeId_unique" ON public."Transaction" USING btree ("equityChangeId");


--
-- TOC entry 3012 (class 1259 OID 498477)
-- Name: Transaction_orderId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Transaction_orderId_unique" ON public."Transaction" USING btree ("orderId");


--
-- TOC entry 3029 (class 1259 OID 498479)
-- Name: _ProductToProductCategory_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_ProductToProductCategory_AB_unique" ON public."_ProductToProductCategory" USING btree ("A", "B");


--
-- TOC entry 3030 (class 1259 OID 498480)
-- Name: _ProductToProductCategory_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_ProductToProductCategory_B_index" ON public."_ProductToProductCategory" USING btree ("B");


--
-- TOC entry 3039 (class 2606 OID 498521)
-- Name: Delay Delay_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3040 (class 2606 OID 498526)
-- Name: Delay Delay_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3034 (class 2606 OID 498496)
-- Name: OrderItem OrderItem_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3036 (class 2606 OID 498506)
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3035 (class 2606 OID 498501)
-- Name: OrderItem OrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3037 (class 2606 OID 498511)
-- Name: Order Order_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3038 (class 2606 OID 498516)
-- Name: Order Order_targetUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_targetUserId_fkey" FOREIGN KEY ("targetUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3031 (class 2606 OID 498481)
-- Name: StockItem StockItem_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3033 (class 2606 OID 498491)
-- Name: StockItem StockItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3032 (class 2606 OID 498486)
-- Name: StockItem StockItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3041 (class 2606 OID 498531)
-- Name: Transaction Transaction_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3043 (class 2606 OID 498541)
-- Name: Transaction Transaction_delayId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_delayId_fkey" FOREIGN KEY ("delayId") REFERENCES public."Delay"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3046 (class 2606 OID 498556)
-- Name: Transaction Transaction_equityChangeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_equityChangeId_fkey" FOREIGN KEY ("equityChangeId") REFERENCES public."EquityChange"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3047 (class 2606 OID 498561)
-- Name: Transaction Transaction_investmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_investmentId_fkey" FOREIGN KEY ("investmentId") REFERENCES public."Investment"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3044 (class 2606 OID 498546)
-- Name: Transaction Transaction_opexId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_opexId_fkey" FOREIGN KEY ("opexId") REFERENCES public."Opex"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3042 (class 2606 OID 498536)
-- Name: Transaction Transaction_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3045 (class 2606 OID 498551)
-- Name: Transaction Transaction_toolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_toolId_fkey" FOREIGN KEY ("toolId") REFERENCES public."Tool"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3048 (class 2606 OID 498566)
-- Name: _ProductToProductCategory _ProductToProductCategory_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToProductCategory"
    ADD CONSTRAINT "_ProductToProductCategory_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3049 (class 2606 OID 498571)
-- Name: _ProductToProductCategory _ProductToProductCategory_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToProductCategory"
    ADD CONSTRAINT "_ProductToProductCategory_B_fkey" FOREIGN KEY ("B") REFERENCES public."ProductCategory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2022-01-07 17:46:40 WITA

--
-- PostgreSQL database dump complete
--

