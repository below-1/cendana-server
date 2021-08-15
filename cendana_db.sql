--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

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
-- Name: DelayType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DelayType" AS ENUM (
    'PAYABLE',
    'RECEIVABLE'
);


ALTER TYPE public."DelayType" OWNER TO postgres;

--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'OPEN',
    'SEALED'
);


ALTER TYPE public."OrderStatus" OWNER TO postgres;

--
-- Name: OrderType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderType" AS ENUM (
    'SALE',
    'BUY'
);


ALTER TYPE public."OrderType" OWNER TO postgres;

--
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
-- Name: Delay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Delay_id_seq" OWNED BY public."Delay".id;


--
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
-- Name: Opex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Opex_id_seq" OWNED BY public."Opex".id;


--
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
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItem" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "authorId" integer NOT NULL,
    "productId" integer NOT NULL,
    "stockItemId" integer NOT NULL,
    "orderId" integer NOT NULL,
    "buyPrice" numeric(65,30) NOT NULL,
    "sellPrice" numeric(65,30) NOT NULL,
    quantity integer NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    description text
);


ALTER TABLE public."OrderItem" OWNER TO postgres;

--
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
-- Name: OrderItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_id_seq" OWNED BY public."OrderItem".id;


--
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
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
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
-- Name: ProductCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductCategory_id_seq" OWNED BY public."ProductCategory".id;


--
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
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
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
-- Name: StockItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."StockItem_id_seq" OWNED BY public."StockItem".id;


--
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
-- Name: Tool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tool_id_seq" OWNED BY public."Tool".id;


--
-- Name: ToolsCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ToolsCategory" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE public."ToolsCategory" OWNER TO postgres;

--
-- Name: ToolsCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ToolsCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ToolsCategory_id_seq" OWNER TO postgres;

--
-- Name: ToolsCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ToolsCategory_id_seq" OWNED BY public."ToolsCategory".id;


--
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
    "toolId" integer
);


ALTER TABLE public."Transaction" OWNER TO postgres;

--
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
-- Name: Transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;


--
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
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _ProductToProductCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_ProductToProductCategory" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToProductCategory" OWNER TO postgres;

--
-- Name: Delay id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay" ALTER COLUMN id SET DEFAULT nextval('public."Delay_id_seq"'::regclass);


--
-- Name: Opex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Opex" ALTER COLUMN id SET DEFAULT nextval('public."Opex_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: OrderItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN id SET DEFAULT nextval('public."OrderItem_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: ProductCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory" ALTER COLUMN id SET DEFAULT nextval('public."ProductCategory_id_seq"'::regclass);


--
-- Name: StockItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem" ALTER COLUMN id SET DEFAULT nextval('public."StockItem_id_seq"'::regclass);


--
-- Name: Tool id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tool" ALTER COLUMN id SET DEFAULT nextval('public."Tool_id_seq"'::regclass);


--
-- Name: ToolsCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ToolsCategory" ALTER COLUMN id SET DEFAULT nextval('public."ToolsCategory_id_seq"'::regclass);


--
-- Name: Transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Delay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Delay" (id, "createdAt", "updatedAt", "authorId", type, "orderId", "dueDate", total, complete) FROM stdin;
1	2021-08-14 12:01:40.031	2021-08-14 12:01:40.032	206	RECEIVABLE	2	2021-09-08 12:01:39.747	156400.000000000000000000000000000000	f
\.


--
-- Data for Name: Opex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Opex" (id, "createdAt", "updatedAt", title, description) FROM stdin;
1	2021-08-14 06:00:11.018	2021-08-14 06:00:11.019	Contoh 1	\N
2	2021-08-14 06:00:17.184	2021-08-14 06:00:17.185	Contoh 2	\N
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, "createdAt", "updatedAt", "authorId", "targetUserId", "orderType", "orderStatus", "itemDiscount", tax, shipping, total, "subTotal", "grandTotal", discount, promo, description) FROM stdin;
1	2021-08-12 10:51:00	2021-08-12 10:52:49.002	206	203	BUY	SEALED	0.000000000000000000000000000000	0	0.000000000000000000000000000000	380000.000000000000000000000000000000	380000.000000000000000000000000000000	380000.000000000000000000000000000000	0	\N	Bagus
3	2021-08-14 07:15:00	2021-08-14 07:15:28.66	206	181	BUY	OPEN	0.000000000000000000000000000000	0	0.000000000000000000000000000000	1000000.000000000000000000000000000000	1000000.000000000000000000000000000000	1000000.000000000000000000000000000000	0	\N	Fighter
2	2021-08-12 11:00:00	2021-08-14 12:01:40.029	206	17	SALE	SEALED	0.000000000000000000000000000000	10	230000.000000000000000000000000000000	279400.000000000000000000000000000000	24000.000000000000000000000000000000	256400.000000000000000000000000000000	15	\N	Bagus
4	2021-08-14 12:18:00	2021-08-14 12:19:28.143	206	80	SALE	SEALED	0.000000000000000000000000000000	0	0.000000000000000000000000000000	48000.000000000000000000000000000000	48000.000000000000000000000000000000	48000.000000000000000000000000000000	0	\N	Good
5	2021-08-15 02:24:00	2021-08-15 02:25:05.948	206	75	SALE	SEALED	0.000000000000000000000000000000	0	0.000000000000000000000000000000	25000.000000000000000000000000000000	25000.000000000000000000000000000000	23750.000000000000000000000000000000	0	\N	Good
\.


--
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrderItem" (id, "createdAt", "updatedAt", "authorId", "productId", "stockItemId", "orderId", "buyPrice", "sellPrice", quantity, discount, description) FROM stdin;
9	2021-08-14 07:45:41.198	2021-08-14 07:45:41.2	206	50	1	2	12000.000000000000000000000000000000	24000.000000000000000000000000000000	1	0	
10	2021-08-14 12:19:16.813	2021-08-14 12:19:16.816	206	50	1	4	12000.000000000000000000000000000000	24000.000000000000000000000000000000	2	0	
11	2021-08-15 02:24:52.703	2021-08-15 02:24:52.706	206	50	1	5	12000.000000000000000000000000000000	25000.000000000000000000000000000000	1	5	Good
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" (id, "createdAt", "updatedAt", name, "buyPrice", "sellPrice", discount, available, sold, defect, returned, unit) FROM stdin;
1	2021-08-12 10:49:21.854	2021-08-12 10:49:21.855	Oklahoma	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
2	2021-08-12 10:49:22.244	2021-08-12 10:49:22.245	Card	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
3	2021-08-12 10:49:22.273	2021-08-12 10:49:22.275	Customer	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
4	2021-08-12 10:49:22.337	2021-08-12 10:49:22.338	Gorgeous	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
5	2021-08-12 10:49:22.373	2021-08-12 10:49:22.375	Customer	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
6	2021-08-12 10:49:22.393	2021-08-12 10:49:22.394	blue	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
7	2021-08-12 10:49:22.457	2021-08-12 10:49:22.458	bypassing	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
8	2021-08-12 10:49:22.482	2021-08-12 10:49:22.484	incentivize	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
9	2021-08-12 10:49:22.505	2021-08-12 10:49:22.506	PCI	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
10	2021-08-12 10:49:22.569	2021-08-12 10:49:22.57	database	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
11	2021-08-12 10:49:22.594	2021-08-12 10:49:22.595	Quetzal	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
12	2021-08-12 10:49:22.616	2021-08-12 10:49:22.617	firewall	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
13	2021-08-12 10:49:22.68	2021-08-12 10:49:22.681	Senior	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
14	2021-08-12 10:49:22.705	2021-08-12 10:49:22.706	Cocos	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
15	2021-08-12 10:49:22.74	2021-08-12 10:49:22.741	Pants	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
16	2021-08-12 10:49:22.8	2021-08-12 10:49:22.801	connecting	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
17	2021-08-12 10:49:22.816	2021-08-12 10:49:22.817	Bedfordshire	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
18	2021-08-12 10:49:22.838	2021-08-12 10:49:22.839	Proactive	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
19	2021-08-12 10:49:22.9	2021-08-12 10:49:22.901	navigating	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
20	2021-08-12 10:49:22.916	2021-08-12 10:49:22.918	Frozen	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
21	2021-08-12 10:49:22.942	2021-08-12 10:49:22.943	Concrete	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
22	2021-08-12 10:49:23.045	2021-08-12 10:49:23.046	Soap	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
23	2021-08-12 10:49:23.072	2021-08-12 10:49:23.073	virtual	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
24	2021-08-12 10:49:23.094	2021-08-12 10:49:23.095	content	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
25	2021-08-12 10:49:23.157	2021-08-12 10:49:23.158	card	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
26	2021-08-12 10:49:23.183	2021-08-12 10:49:23.184	Towels	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
27	2021-08-12 10:49:23.205	2021-08-12 10:49:23.206	deposit	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
28	2021-08-12 10:49:23.269	2021-08-12 10:49:23.27	Afghanistan	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
29	2021-08-12 10:49:23.294	2021-08-12 10:49:23.295	TCP	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
30	2021-08-12 10:49:23.315	2021-08-12 10:49:23.316	Savings	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
31	2021-08-12 10:49:23.38	2021-08-12 10:49:23.382	haptic	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
32	2021-08-12 10:49:23.404	2021-08-12 10:49:23.406	transmitting	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
33	2021-08-12 10:49:23.426	2021-08-12 10:49:23.428	Buckinghamshire	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
34	2021-08-12 10:49:23.489	2021-08-12 10:49:23.49	Security	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
35	2021-08-12 10:49:23.505	2021-08-12 10:49:23.506	matrix	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
36	2021-08-12 10:49:23.536	2021-08-12 10:49:23.537	Zambia	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
37	2021-08-12 10:49:23.601	2021-08-12 10:49:23.602	indexing	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
38	2021-08-12 10:49:23.627	2021-08-12 10:49:23.628	uniform	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
39	2021-08-12 10:49:23.649	2021-08-12 10:49:23.65	Assurance	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
40	2021-08-12 10:49:23.712	2021-08-12 10:49:23.714	Tennessee	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
41	2021-08-12 10:49:23.737	2021-08-12 10:49:23.739	embrace	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
42	2021-08-12 10:49:23.76	2021-08-12 10:49:23.761	orange	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
43	2021-08-12 10:49:23.824	2021-08-12 10:49:23.825	bypassing	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
44	2021-08-12 10:49:23.849	2021-08-12 10:49:23.85	TCP	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
46	2021-08-12 10:49:23.936	2021-08-12 10:49:23.937	Wyoming	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
48	2021-08-12 10:49:23.982	2021-08-12 10:49:23.983	convergence	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
49	2021-08-12 10:49:24.044	2021-08-12 10:49:24.045	Customer	0.000000000000000000000000000000	0.000000000000000000000000000000	0	0	0	0	0	pcs
47	2021-08-12 10:49:23.96	2021-08-12 10:49:23.961	port	13000.000000000000000000000000000000	24000.000000000000000000000000000000	0	10	0	0	0	pcs
45	2021-08-12 10:49:23.871	2021-08-12 10:49:23.872	Utah	13000.000000000000000000000000000000	23000.000000000000000000000000000000	0	10	0	0	0	pcs
50	2021-08-12 10:49:24.06	2021-08-12 10:49:24.061	synergize	12000.000000000000000000000000000000	24000.000000000000000000000000000000	0	6	3	0	0	pcs
\.


--
-- Data for Name: ProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProductCategory" (id, "createdAt", "updatedAt", title) FROM stdin;
1	2021-08-12 10:49:21.79	2021-08-12 10:49:21.791	Computer
2	2021-08-12 10:49:21.79	2021-08-12 10:49:21.791	Wisconsin
3	2021-08-12 10:49:21.79	2021-08-12 10:49:21.791	Soap
4	2021-08-12 10:49:21.79	2021-08-12 10:49:21.791	violet
5	2021-08-12 10:49:21.79	2021-08-12 10:49:21.791	Place
\.


--
-- Data for Name: StockItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."StockItem" (id, "createdAt", "updatedAt", "authorId", "productId", "orderId", "buyPrice", "sellPrice", discount, quantity, available, sold, defect, returned) FROM stdin;
2	2021-08-12 10:52:26.154	2021-08-12 10:52:26.155	206	47	1	13000.000000000000000000000000000000	24000.000000000000000000000000000000	0	10	10	0	0	0
3	2021-08-12 10:52:43.078	2021-08-12 10:52:43.08	206	45	1	13000.000000000000000000000000000000	23000.000000000000000000000000000000	0	10	10	0	0	0
4	2021-08-14 07:15:28.478	2021-08-14 07:15:28.48	206	48	3	50000.000000000000000000000000000000	55000.000000000000000000000000000000	0	20	20	0	0	0
1	2021-08-12 10:52:08.239	2021-08-12 10:52:08.24	206	50	1	12000.000000000000000000000000000000	24000.000000000000000000000000000000	0	10	6	3	0	0
\.


--
-- Data for Name: Tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Tool" (id, "createdAt", "updatedAt", title, description) FROM stdin;
1	2021-08-13 06:40:02.434	2021-08-13 06:40:02.435	Elektronik	
2	2021-08-13 06:40:35.454	2021-08-13 06:40:35.455	Transportasi	\N
\.


--
-- Data for Name: ToolsCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ToolsCategory" (id, "createdAt", "updatedAt", title) FROM stdin;
\.


--
-- Data for Name: Transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaction" (id, "createdAt", "updatedAt", "authorId", type, status, "paymentMethod", nominal, "orderId", "delayId", "opexId", "toolId") FROM stdin;
1	2021-08-12 10:52:49.002	2021-08-12 10:52:49.004	206	CREDIT	SUCCESS	CASH	380000.000000000000000000000000000000	1	\N	\N	\N
4	2021-08-14 06:05:00	2021-08-14 06:32:19.356	206	CREDIT	SUCCESS	ONLINE	64000.000000000000000000000000000000	\N	\N	1	\N
5	2021-08-14 06:47:00	2021-08-14 06:58:11.349	206	CREDIT	SUCCESS	ONLINE	120000.000000000000000000000000000000	\N	\N	\N	2
6	2021-08-14 12:01:40.03	2021-08-14 12:01:40.031	206	DEBIT	SUCCESS	ONLINE	100000.000000000000000000000000000000	2	\N	\N	\N
7	2021-08-14 12:19:28.143	2021-08-14 12:19:28.145	206	DEBIT	SUCCESS	CASH	48000.000000000000000000000000000000	4	\N	\N	\N
8	2021-08-15 02:25:05.948	2021-08-15 02:25:05.95	206	DEBIT	SUCCESS	CASH	23750.000000000000000000000000000000	5	\N	\N	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, username, password, role, address, mobile, email) FROM stdin;
1	Micah	Alessandra76	adminzero	ADMIN	\N	\N	\N
2	Aracely	Claud52	adminzero	ADMIN	\N	\N	\N
3	Scotty	Stephania11	adminzero	ADMIN	\N	\N	\N
4	Kris	Kaitlin_Hartmann45	adminzero	ADMIN	\N	\N	\N
5	Deron	Erika_Will4	adminzero	ADMIN	\N	\N	\N
6	Avery	\N	\N	CUSTOMER	\N	\N	\N
7	Estrella	\N	\N	CUSTOMER	\N	\N	\N
8	Imogene	\N	\N	CUSTOMER	\N	\N	\N
9	Dariana	\N	\N	CUSTOMER	\N	\N	\N
10	Therese	\N	\N	CUSTOMER	\N	\N	\N
11	Ford	\N	\N	CUSTOMER	\N	\N	\N
12	Dominique	\N	\N	CUSTOMER	\N	\N	\N
13	Emely	\N	\N	CUSTOMER	\N	\N	\N
14	Amparo	\N	\N	CUSTOMER	\N	\N	\N
15	Humberto	\N	\N	CUSTOMER	\N	\N	\N
16	Karlie	\N	\N	CUSTOMER	\N	\N	\N
17	Zachary	\N	\N	CUSTOMER	\N	\N	\N
18	Lily	\N	\N	CUSTOMER	\N	\N	\N
19	Wilhelmine	\N	\N	CUSTOMER	\N	\N	\N
20	Lon	\N	\N	CUSTOMER	\N	\N	\N
21	Rosalia	\N	\N	CUSTOMER	\N	\N	\N
22	Bret	\N	\N	CUSTOMER	\N	\N	\N
23	Isaias	\N	\N	CUSTOMER	\N	\N	\N
24	Oscar	\N	\N	CUSTOMER	\N	\N	\N
25	Nicole	\N	\N	CUSTOMER	\N	\N	\N
26	Aylin	\N	\N	CUSTOMER	\N	\N	\N
27	Ewell	\N	\N	CUSTOMER	\N	\N	\N
28	Eudora	\N	\N	CUSTOMER	\N	\N	\N
29	Kameron	\N	\N	CUSTOMER	\N	\N	\N
30	Tommie	\N	\N	CUSTOMER	\N	\N	\N
31	Moises	\N	\N	CUSTOMER	\N	\N	\N
32	Jeramie	\N	\N	CUSTOMER	\N	\N	\N
33	Kian	\N	\N	CUSTOMER	\N	\N	\N
34	Odie	\N	\N	CUSTOMER	\N	\N	\N
35	Leanne	\N	\N	CUSTOMER	\N	\N	\N
36	Emerald	\N	\N	CUSTOMER	\N	\N	\N
37	Kaia	\N	\N	CUSTOMER	\N	\N	\N
38	Rogers	\N	\N	CUSTOMER	\N	\N	\N
39	Kelley	\N	\N	CUSTOMER	\N	\N	\N
40	Leonard	\N	\N	CUSTOMER	\N	\N	\N
41	Vergie	\N	\N	CUSTOMER	\N	\N	\N
42	Myrtice	\N	\N	CUSTOMER	\N	\N	\N
43	Joesph	\N	\N	CUSTOMER	\N	\N	\N
44	Alisha	\N	\N	CUSTOMER	\N	\N	\N
45	Riley	\N	\N	CUSTOMER	\N	\N	\N
46	Alene	\N	\N	CUSTOMER	\N	\N	\N
47	Fanny	\N	\N	CUSTOMER	\N	\N	\N
48	Gage	\N	\N	CUSTOMER	\N	\N	\N
49	Claudine	\N	\N	CUSTOMER	\N	\N	\N
50	Haleigh	\N	\N	CUSTOMER	\N	\N	\N
51	Nolan	\N	\N	CUSTOMER	\N	\N	\N
52	Ignacio	\N	\N	CUSTOMER	\N	\N	\N
53	Helmer	\N	\N	CUSTOMER	\N	\N	\N
54	Muhammad	\N	\N	CUSTOMER	\N	\N	\N
55	Dixie	\N	\N	CUSTOMER	\N	\N	\N
56	Eriberto	\N	\N	CUSTOMER	\N	\N	\N
57	Lilyan	\N	\N	CUSTOMER	\N	\N	\N
58	Hudson	\N	\N	CUSTOMER	\N	\N	\N
59	Jarrett	\N	\N	CUSTOMER	\N	\N	\N
60	Sabryna	\N	\N	CUSTOMER	\N	\N	\N
61	Evalyn	\N	\N	CUSTOMER	\N	\N	\N
62	Sam	\N	\N	CUSTOMER	\N	\N	\N
63	Amely	\N	\N	CUSTOMER	\N	\N	\N
64	Anabel	\N	\N	CUSTOMER	\N	\N	\N
65	Shanelle	\N	\N	CUSTOMER	\N	\N	\N
66	Frederik	\N	\N	CUSTOMER	\N	\N	\N
67	Rhiannon	\N	\N	CUSTOMER	\N	\N	\N
68	Bertrand	\N	\N	CUSTOMER	\N	\N	\N
69	Mable	\N	\N	CUSTOMER	\N	\N	\N
70	Leland	\N	\N	CUSTOMER	\N	\N	\N
71	Kenneth	\N	\N	CUSTOMER	\N	\N	\N
72	Betty	\N	\N	CUSTOMER	\N	\N	\N
73	Santina	\N	\N	CUSTOMER	\N	\N	\N
74	Saige	\N	\N	CUSTOMER	\N	\N	\N
75	Sebastian	\N	\N	CUSTOMER	\N	\N	\N
76	Felipa	\N	\N	CUSTOMER	\N	\N	\N
77	Jackson	\N	\N	CUSTOMER	\N	\N	\N
78	Janessa	\N	\N	CUSTOMER	\N	\N	\N
79	Khalil	\N	\N	CUSTOMER	\N	\N	\N
80	Vernice	\N	\N	CUSTOMER	\N	\N	\N
81	Evalyn	\N	\N	CUSTOMER	\N	\N	\N
82	Paul	\N	\N	CUSTOMER	\N	\N	\N
83	Glenda	\N	\N	CUSTOMER	\N	\N	\N
84	Dulce	\N	\N	CUSTOMER	\N	\N	\N
85	Marilyne	\N	\N	CUSTOMER	\N	\N	\N
86	Gabe	\N	\N	CUSTOMER	\N	\N	\N
87	Brennan	\N	\N	CUSTOMER	\N	\N	\N
88	Merl	\N	\N	CUSTOMER	\N	\N	\N
89	Emmitt	\N	\N	CUSTOMER	\N	\N	\N
90	Clementina	\N	\N	CUSTOMER	\N	\N	\N
91	Rowland	\N	\N	CUSTOMER	\N	\N	\N
92	Chaim	\N	\N	CUSTOMER	\N	\N	\N
93	Blaise	\N	\N	CUSTOMER	\N	\N	\N
94	Fatima	\N	\N	CUSTOMER	\N	\N	\N
95	Myrtie	\N	\N	CUSTOMER	\N	\N	\N
96	Fanny	\N	\N	CUSTOMER	\N	\N	\N
97	Gavin	\N	\N	CUSTOMER	\N	\N	\N
98	Jairo	\N	\N	CUSTOMER	\N	\N	\N
99	Frankie	\N	\N	CUSTOMER	\N	\N	\N
100	Ian	\N	\N	CUSTOMER	\N	\N	\N
101	Brycen	\N	\N	CUSTOMER	\N	\N	\N
102	Vergie	\N	\N	CUSTOMER	\N	\N	\N
103	Ayla	\N	\N	CUSTOMER	\N	\N	\N
104	Oleta	\N	\N	CUSTOMER	\N	\N	\N
105	Destany	\N	\N	CUSTOMER	\N	\N	\N
106	Friesen, Zieme and Reinger	\N	\N	SUPPLIER	4925 Price Turnpike	\N	\N
107	McClure - Murazik	\N	\N	SUPPLIER	4561 Michele Fall	\N	\N
108	Hayes - Lubowitz	\N	\N	SUPPLIER	426 Purdy Expressway	\N	\N
109	Wiza - Wehner	\N	\N	SUPPLIER	0251 Renner Alley	\N	\N
110	Wuckert, Brakus and Ritchie	\N	\N	SUPPLIER	817 Satterfield Inlet	\N	\N
111	Larson, Terry and Christiansen	\N	\N	SUPPLIER	6759 Boehm Stravenue	\N	\N
112	Reichert, Carter and Dooley	\N	\N	SUPPLIER	1256 Elyssa Shoals	\N	\N
113	Hansen LLC	\N	\N	SUPPLIER	45318 Morar Course	\N	\N
114	Ritchie LLC	\N	\N	SUPPLIER	097 Kilback Throughway	\N	\N
115	Wisozk and Sons	\N	\N	SUPPLIER	104 Wallace Rest	\N	\N
116	Hauck - McKenzie	\N	\N	SUPPLIER	3994 Harvey Causeway	\N	\N
117	Kuhic and Sons	\N	\N	SUPPLIER	4326 Tromp Trail	\N	\N
118	Bode Group	\N	\N	SUPPLIER	5153 Jaden Row	\N	\N
119	Upton and Sons	\N	\N	SUPPLIER	0530 Langworth Glen	\N	\N
120	Gorczany, Erdman and Brakus	\N	\N	SUPPLIER	6163 Mohr Harbors	\N	\N
121	Goldner and Sons	\N	\N	SUPPLIER	311 Sadie Lock	\N	\N
122	Pacocha LLC	\N	\N	SUPPLIER	4264 Kessler Summit	\N	\N
123	Feil, Monahan and Zboncak	\N	\N	SUPPLIER	7405 Justina Route	\N	\N
124	Connelly and Sons	\N	\N	SUPPLIER	9161 Alvah Shoals	\N	\N
125	Nienow Inc	\N	\N	SUPPLIER	73524 Kiana Plains	\N	\N
126	Jakubowski LLC	\N	\N	SUPPLIER	814 Louvenia Haven	\N	\N
127	Leuschke - Hermiston	\N	\N	SUPPLIER	3257 Mittie Light	\N	\N
128	Yundt, Stamm and Schimmel	\N	\N	SUPPLIER	22655 Percy Freeway	\N	\N
129	Greenfelder - Ondricka	\N	\N	SUPPLIER	4183 Francis Ridges	\N	\N
130	Nikolaus Inc	\N	\N	SUPPLIER	026 Stamm Cliffs	\N	\N
131	Schiller - Hills	\N	\N	SUPPLIER	54502 Pamela Ranch	\N	\N
132	Hoeger - Douglas	\N	\N	SUPPLIER	4667 Breitenberg Ranch	\N	\N
133	Stoltenberg, Considine and O'Keefe	\N	\N	SUPPLIER	39788 Addie Valleys	\N	\N
134	Berge, Rutherford and Hagenes	\N	\N	SUPPLIER	77007 Mozelle Lake	\N	\N
135	Rippin, Greenholt and Rolfson	\N	\N	SUPPLIER	90120 Weissnat Tunnel	\N	\N
136	Pouros, Hudson and Cronin	\N	\N	SUPPLIER	89328 Eliza Loaf	\N	\N
137	Ebert - Ebert	\N	\N	SUPPLIER	795 Furman Oval	\N	\N
138	Dickens LLC	\N	\N	SUPPLIER	34787 Walsh Place	\N	\N
139	Sporer, Bosco and Ward	\N	\N	SUPPLIER	255 Carson Square	\N	\N
140	Hirthe - VonRueden	\N	\N	SUPPLIER	73212 Rita Oval	\N	\N
141	McDermott - Stehr	\N	\N	SUPPLIER	97276 Rory Freeway	\N	\N
142	Hilll Group	\N	\N	SUPPLIER	983 Jerald Shoal	\N	\N
143	Hagenes - Hackett	\N	\N	SUPPLIER	44073 Williamson Plaza	\N	\N
144	Greenholt - Ratke	\N	\N	SUPPLIER	79079 Lind Drive	\N	\N
145	Baumbach Inc	\N	\N	SUPPLIER	2265 Christop Pike	\N	\N
146	Upton - Johns	\N	\N	SUPPLIER	170 Earline Hill	\N	\N
147	Nicolas and Sons	\N	\N	SUPPLIER	5085 Gerhold Road	\N	\N
148	Bernier Group	\N	\N	SUPPLIER	4340 Elmore Ports	\N	\N
149	Tremblay - Hahn	\N	\N	SUPPLIER	884 Zoie Point	\N	\N
150	Daugherty - Veum	\N	\N	SUPPLIER	1785 Vivianne Street	\N	\N
151	Jenkins LLC	\N	\N	SUPPLIER	8582 Schulist Island	\N	\N
152	Windler Inc	\N	\N	SUPPLIER	3328 Schuster Flat	\N	\N
153	Steuber - Emard	\N	\N	SUPPLIER	5640 Schultz Vista	\N	\N
154	Treutel - Little	\N	\N	SUPPLIER	004 Torp Field	\N	\N
155	Heathcote LLC	\N	\N	SUPPLIER	343 Lorenzo Crest	\N	\N
156	Gleichner LLC	\N	\N	SUPPLIER	4230 Jacobi Avenue	\N	\N
157	Jacobi, Labadie and McGlynn	\N	\N	SUPPLIER	7583 Cornelius Ville	\N	\N
158	Weimann, Lakin and Kozey	\N	\N	SUPPLIER	809 Bednar Street	\N	\N
159	Torphy Group	\N	\N	SUPPLIER	4306 Adrianna Drive	\N	\N
160	Ortiz, Crooks and Bechtelar	\N	\N	SUPPLIER	213 Lue Center	\N	\N
161	Tromp Inc	\N	\N	SUPPLIER	654 Huels Centers	\N	\N
162	Conn - Kessler	\N	\N	SUPPLIER	6825 Rippin Isle	\N	\N
163	Boyer and Sons	\N	\N	SUPPLIER	0935 Lehner Row	\N	\N
164	Champlin, Nienow and Gerhold	\N	\N	SUPPLIER	8141 Lindgren Bridge	\N	\N
165	West - Langworth	\N	\N	SUPPLIER	727 Willms Cape	\N	\N
166	Torp Inc	\N	\N	SUPPLIER	22265 Muller Crossroad	\N	\N
167	Schimmel - Kunze	\N	\N	SUPPLIER	1215 Keagan Freeway	\N	\N
168	Weimann LLC	\N	\N	SUPPLIER	684 O'Kon Terrace	\N	\N
169	Ankunding - Boyer	\N	\N	SUPPLIER	6220 Bettie Manors	\N	\N
170	Huel Inc	\N	\N	SUPPLIER	673 Von Falls	\N	\N
171	Gutmann and Sons	\N	\N	SUPPLIER	87346 Yasmeen Gateway	\N	\N
172	Collier, Huels and Klocko	\N	\N	SUPPLIER	70240 Dicki Forges	\N	\N
173	Aufderhar and Sons	\N	\N	SUPPLIER	82420 Orville Ramp	\N	\N
174	Willms and Sons	\N	\N	SUPPLIER	6588 Dorian Way	\N	\N
175	Cassin Group	\N	\N	SUPPLIER	272 Gregory Terrace	\N	\N
176	Herman Group	\N	\N	SUPPLIER	356 Macejkovic Point	\N	\N
177	Gibson Group	\N	\N	SUPPLIER	935 Morissette Spurs	\N	\N
178	Moore LLC	\N	\N	SUPPLIER	67349 Simonis Avenue	\N	\N
179	Veum - Kub	\N	\N	SUPPLIER	28976 Kiehn Camp	\N	\N
180	Brekke, Bins and Raynor	\N	\N	SUPPLIER	98616 Audie Fords	\N	\N
181	Wintheiser LLC	\N	\N	SUPPLIER	819 Lueilwitz Road	\N	\N
182	Koepp, Breitenberg and Franecki	\N	\N	SUPPLIER	87353 Trantow Isle	\N	\N
183	Hartmann - Shields	\N	\N	SUPPLIER	025 Gerlach Points	\N	\N
184	Marks - Reichel	\N	\N	SUPPLIER	605 Schroeder Groves	\N	\N
185	Donnelly, Wisozk and Nitzsche	\N	\N	SUPPLIER	9835 Thompson Path	\N	\N
186	Larson, Barton and Erdman	\N	\N	SUPPLIER	2006 Kristin Ville	\N	\N
187	Nikolaus, Emmerich and O'Connell	\N	\N	SUPPLIER	5796 Armstrong Wall	\N	\N
188	McCullough, Ruecker and Lebsack	\N	\N	SUPPLIER	6577 Tillman Cove	\N	\N
189	Boyle Group	\N	\N	SUPPLIER	570 Beth Station	\N	\N
190	McDermott Group	\N	\N	SUPPLIER	9075 Andres Plain	\N	\N
191	Kreiger - Hyatt	\N	\N	SUPPLIER	28661 Cummings Island	\N	\N
192	Parker - Bednar	\N	\N	SUPPLIER	0311 Lucie Mount	\N	\N
193	Murray - Homenick	\N	\N	SUPPLIER	82270 Schuppe Trail	\N	\N
194	Wyman, Predovic and Okuneva	\N	\N	SUPPLIER	00770 Al Ridge	\N	\N
195	Schmidt - Rosenbaum	\N	\N	SUPPLIER	97116 Kirlin Flats	\N	\N
196	Hermiston and Sons	\N	\N	SUPPLIER	28419 Cleveland Ports	\N	\N
197	Murray and Sons	\N	\N	SUPPLIER	6867 Christop Parkway	\N	\N
198	Littel LLC	\N	\N	SUPPLIER	053 Stark Terrace	\N	\N
199	Gulgowski and Sons	\N	\N	SUPPLIER	89746 Larue Mountains	\N	\N
200	Kutch, Beahan and Rice	\N	\N	SUPPLIER	31265 Glover Islands	\N	\N
201	Stark, Hayes and Kirlin	\N	\N	SUPPLIER	48001 Hudson Locks	\N	\N
202	Toy, Kohler and Krajcik	\N	\N	SUPPLIER	79711 Rutherford Flat	\N	\N
203	Yundt and Sons	\N	\N	SUPPLIER	11023 Kub Wells	\N	\N
204	Waters, Fay and Feil	\N	\N	SUPPLIER	7718 Golden Coves	\N	\N
205	Quigley - Roob	\N	\N	SUPPLIER	38605 Williamson Valleys	\N	\N
206	Jordan Meta	adminzero	$2b$04$3xUzir1YMDPk7sxJUAWF9OX9y8QgavN1Z.p7UgJZ3Y0spG5Y7Pyum	ADMIN	\N	\N	\N
\.


--
-- Data for Name: _ProductToProductCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_ProductToProductCategory" ("A", "B") FROM stdin;
\.


--
-- Name: Delay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Delay_id_seq"', 1, true);


--
-- Name: Opex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Opex_id_seq"', 2, true);


--
-- Name: OrderItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_id_seq"', 11, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 5, true);


--
-- Name: ProductCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductCategory_id_seq"', 5, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 50, true);


--
-- Name: StockItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."StockItem_id_seq"', 4, true);


--
-- Name: Tool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tool_id_seq"', 2, true);


--
-- Name: ToolsCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ToolsCategory_id_seq"', 1, false);


--
-- Name: Transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaction_id_seq"', 8, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 206, true);


--
-- Name: Delay Delay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_pkey" PRIMARY KEY (id);


--
-- Name: Opex Opex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Opex"
    ADD CONSTRAINT "Opex_pkey" PRIMARY KEY (id);


--
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: ProductCategory ProductCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "ProductCategory_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: StockItem StockItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_pkey" PRIMARY KEY (id);


--
-- Name: Tool Tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tool"
    ADD CONSTRAINT "Tool_pkey" PRIMARY KEY (id);


--
-- Name: ToolsCategory ToolsCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ToolsCategory"
    ADD CONSTRAINT "ToolsCategory_pkey" PRIMARY KEY (id);


--
-- Name: Transaction Transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Delay_orderId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Delay_orderId_unique" ON public."Delay" USING btree ("orderId");


--
-- Name: Transaction_orderId_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Transaction_orderId_unique" ON public."Transaction" USING btree ("orderId");


--
-- Name: _ProductToProductCategory_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_ProductToProductCategory_AB_unique" ON public."_ProductToProductCategory" USING btree ("A", "B");


--
-- Name: _ProductToProductCategory_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_ProductToProductCategory_B_index" ON public."_ProductToProductCategory" USING btree ("B");


--
-- Name: Delay Delay_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Delay Delay_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Delay"
    ADD CONSTRAINT "Delay_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrderItem OrderItem_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrderItem OrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OrderItem OrderItem_stockItemId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_stockItemId_fkey" FOREIGN KEY ("stockItemId") REFERENCES public."StockItem"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order Order_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_targetUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_targetUserId_fkey" FOREIGN KEY ("targetUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: StockItem StockItem_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: StockItem StockItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: StockItem StockItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."StockItem"
    ADD CONSTRAINT "StockItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Transaction Transaction_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Transaction Transaction_delayId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_delayId_fkey" FOREIGN KEY ("delayId") REFERENCES public."Delay"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Transaction Transaction_opexId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_opexId_fkey" FOREIGN KEY ("opexId") REFERENCES public."Opex"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Transaction Transaction_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Transaction Transaction_toolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_toolId_fkey" FOREIGN KEY ("toolId") REFERENCES public."Tool"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProductToProductCategory _ProductToProductCategory_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToProductCategory"
    ADD CONSTRAINT "_ProductToProductCategory_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProductToProductCategory _ProductToProductCategory_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToProductCategory"
    ADD CONSTRAINT "_ProductToProductCategory_B_fkey" FOREIGN KEY ("B") REFERENCES public."ProductCategory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

