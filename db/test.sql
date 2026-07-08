--
-- PostgreSQL database dump
--

\restrict xB4jS11bB19wwaVAj4i2t5fnRWGZeJfzZBuz5Gad9Z1RGzj14GqMcHgVGvsWjpO

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

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

ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_seat_id_foreign;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_order_id_foreign;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_movie_session_id_foreign;
ALTER TABLE IF EXISTS ONLY public.seats DROP CONSTRAINT IF EXISTS seats_room_id_foreign;
ALTER TABLE IF EXISTS ONLY public.movie_sessions DROP CONSTRAINT IF EXISTS movie_sessions_room_id_foreign;
ALTER TABLE IF EXISTS ONLY public.movie_sessions DROP CONSTRAINT IF EXISTS movie_sessions_movie_id_foreign;
DROP INDEX IF EXISTS public.sessions_user_id_index;
DROP INDEX IF EXISTS public.sessions_last_activity_index;
DROP INDEX IF EXISTS public.jobs_queue_index;
DROP INDEX IF EXISTS public.failed_jobs_connection_queue_failed_at_index;
DROP INDEX IF EXISTS public.cache_locks_expiration_index;
DROP INDEX IF EXISTS public.cache_expiration_index;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_pkey;
ALTER TABLE IF EXISTS ONLY public.tickets DROP CONSTRAINT IF EXISTS tickets_movie_session_id_seat_id_unique;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.seats DROP CONSTRAINT IF EXISTS seats_room_id_number_unique;
ALTER TABLE IF EXISTS ONLY public.seats DROP CONSTRAINT IF EXISTS seats_pkey;
ALTER TABLE IF EXISTS ONLY public.rooms DROP CONSTRAINT IF EXISTS rooms_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_access_token_unique;
ALTER TABLE IF EXISTS ONLY public.movies DROP CONSTRAINT IF EXISTS movies_pkey;
ALTER TABLE IF EXISTS ONLY public.movie_sessions DROP CONSTRAINT IF EXISTS movie_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.jobs DROP CONSTRAINT IF EXISTS jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.job_batches DROP CONSTRAINT IF EXISTS job_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_uuid_unique;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.cache DROP CONSTRAINT IF EXISTS cache_pkey;
ALTER TABLE IF EXISTS ONLY public.cache_locks DROP CONSTRAINT IF EXISTS cache_locks_pkey;
ALTER TABLE IF EXISTS public.tickets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.seats ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.rooms ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.movies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.movie_sessions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.failed_jobs ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.tickets_id_seq;
DROP TABLE IF EXISTS public.tickets;
DROP TABLE IF EXISTS public.sessions;
DROP SEQUENCE IF EXISTS public.seats_id_seq;
DROP TABLE IF EXISTS public.seats;
DROP SEQUENCE IF EXISTS public.rooms_id_seq;
DROP TABLE IF EXISTS public.rooms;
DROP SEQUENCE IF EXISTS public.orders_id_seq;
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public.movies_id_seq;
DROP TABLE IF EXISTS public.movies;
DROP SEQUENCE IF EXISTS public.movie_sessions_id_seq;
DROP TABLE IF EXISTS public.movie_sessions;
DROP SEQUENCE IF EXISTS public.migrations_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.jobs_id_seq;
DROP TABLE IF EXISTS public.jobs;
DROP TABLE IF EXISTS public.job_batches;
DROP SEQUENCE IF EXISTS public.failed_jobs_id_seq;
DROP TABLE IF EXISTS public.failed_jobs;
DROP TABLE IF EXISTS public.cache_locks;
DROP TABLE IF EXISTS public.cache;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection character varying(255) NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: movie_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movie_sessions (
    id bigint NOT NULL,
    movie_id bigint NOT NULL,
    room_id bigint NOT NULL,
    starts_at timestamp(0) without time zone NOT NULL,
    price integer NOT NULL,
    currency character varying(3) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: movie_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movie_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: movie_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movie_sessions_id_seq OWNED BY public.movie_sessions.id;


--
-- Name: movies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movies (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    access_token character varying(64) NOT NULL,
    email character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    amount_total integer NOT NULL,
    currency character varying(3) NOT NULL,
    paid_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: seats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seats (
    id bigint NOT NULL,
    room_id bigint NOT NULL,
    number integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: seats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seats_id_seq OWNED BY public.seats.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tickets (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    movie_session_id bigint NOT NULL,
    seat_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: movie_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie_sessions ALTER COLUMN id SET DEFAULT nextval('public.movie_sessions_id_seq'::regclass);


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: seats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seats ALTER COLUMN id SET DEFAULT nextval('public.seats_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_sessions_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_07_05_170000_create_orders_table	1
5	2026_07_05_170002_create_movies_table	1
6	2026_07_05_170003_create_rooms_table	1
7	2026_07_05_170004_create_seats_table	1
8	2026_07_05_170005_create_movie_sessions_table	1
9	2026_07_05_170006_create_tickets_table	1
\.


--
-- Data for Name: movie_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.movie_sessions (id, movie_id, room_id, starts_at, price, currency, created_at, updated_at) FROM stdin;
1	2	1	2026-07-07 10:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
2	9	1	2026-07-07 14:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
3	7	1	2026-07-07 18:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
4	3	1	2026-07-07 22:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
5	5	2	2026-07-07 10:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
6	1	2	2026-07-07 14:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
7	8	2	2026-07-07 18:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
8	6	2	2026-07-07 22:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
9	3	3	2026-07-07 10:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
10	4	3	2026-07-07 14:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
11	3	3	2026-07-07 18:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
12	9	3	2026-07-07 22:00:00	1000	RUB	2026-07-07 07:36:42	2026-07-07 07:36:42
13	16	4	2026-07-08 10:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
14	11	4	2026-07-08 14:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
15	17	4	2026-07-08 18:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
16	13	4	2026-07-08 22:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
17	13	5	2026-07-08 10:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
18	10	5	2026-07-08 14:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
19	14	5	2026-07-08 18:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
20	16	5	2026-07-08 22:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
21	17	6	2026-07-08 10:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
22	13	6	2026-07-08 14:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
23	15	6	2026-07-08 18:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
24	18	6	2026-07-08 22:00:00	1000	RUB	2026-07-08 12:50:22	2026-07-08 12:50:22
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.movies (id, title, created_at, updated_at) FROM stdin;
1	Начало	2026-07-07 07:36:42	2026-07-07 07:36:42
2	Матрица	2026-07-07 07:36:42	2026-07-07 07:36:42
3	Интерстеллар	2026-07-07 07:36:42	2026-07-07 07:36:42
4	Побег из Шоушенка	2026-07-07 07:36:42	2026-07-07 07:36:42
5	Форрест Гамп	2026-07-07 07:36:42	2026-07-07 07:36:42
6	Гладиатор	2026-07-07 07:36:42	2026-07-07 07:36:42
7	Крёстный отец	2026-07-07 07:36:42	2026-07-07 07:36:42
8	Бойцовский клуб	2026-07-07 07:36:42	2026-07-07 07:36:42
9	Зелёная миля	2026-07-07 07:36:42	2026-07-07 07:36:42
10	Начало	2026-07-08 12:50:22	2026-07-08 12:50:22
11	Матрица	2026-07-08 12:50:22	2026-07-08 12:50:22
12	Интерстеллар	2026-07-08 12:50:22	2026-07-08 12:50:22
13	Побег из Шоушенка	2026-07-08 12:50:22	2026-07-08 12:50:22
14	Форрест Гамп	2026-07-08 12:50:22	2026-07-08 12:50:22
15	Гладиатор	2026-07-08 12:50:22	2026-07-08 12:50:22
16	Крёстный отец	2026-07-08 12:50:22	2026-07-08 12:50:22
17	Бойцовский клуб	2026-07-08 12:50:22	2026-07-08 12:50:22
18	Зелёная миля	2026-07-08 12:50:22	2026-07-08 12:50:22
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, access_token, email, status, amount_total, currency, paid_at, expires_at, created_at, updated_at) FROM stdin;
1	iLlo6LR5kNsMwLF8VYHh07gvTcjzhOdF1A4VWTPn	schimmel.gavin@example.org	paid	9000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
2	1fAJbUrAWBD2DqGV3XBKFrhJ6YM0PKLry7asyp8f	dschaden@example.net	paid	4000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
3	5WMPiQ0oMIUi0QUz18OJmzt3OKtg4oGxslayYb0m	simeon.effertz@example.net	paid	8000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
4	0bzBWJgBtCAC6grCmWfMQQmISoKIg8F9natMwn7G	orie89@example.net	paid	2000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
5	ffEUc6zwMDFadCM6qMNluCLpf79dg3X5zgpxyLfO	monique93@example.com	paid	5000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
6	B9DxoPtoxUHh69rwwg77blJk3Cn2onBQ2ILi1zrK	dasia77@example.net	paid	9000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
7	4P4eYmeCzhYh198C4oyCFZeEA4IB9V03Ckmj4nWE	alan14@example.org	paid	1000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
8	54yKQO7seOT8Y5PUzHPUNWRCn426rQWm4sJMZ421	alphonso.mertz@example.org	paid	10000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
9	dnRXbjaDCjOOmtuZIvRD4qPcZxNwVdLYiz1cUfiF	joan.dickinson@example.net	paid	6000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
10	V5cwnS93u03uDGwoVS6XWu42p99pLtQEnlKtTKlH	cgutmann@example.org	paid	5000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
11	dKOEvmJDTDXPyU1GKyGUnKP4IU93lKvwGiS8YmSb	orn.bella@example.com	paid	9000	RUB	2026-07-07 07:36:42	\N	2026-07-07 07:36:42	2026-07-07 07:36:42
12	71ZoYDeT5vlx7ViL0Y7jMdeZDN1MuKpcXz4mpQEH	mekhi69@example.com	paid	6000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
13	pEnzuGLRPyLSZlRxX6vh12o06TLPpA1F6jbBIoDX	cayla.bailey@example.net	paid	6000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
14	aKJx9qy3bRVbv3uonS1M96H9lu9iMDB2l9E6W0W9	nigel.daniel@example.com	paid	2000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
15	NDGhhs1fPwW95cyvU9e9l8atjGvndBjASvP76xxP	cassin.otilia@example.com	paid	9000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
16	BdjQT2Q5j5xIjQCCAvdWIDaEgQku1Ua0xnSYfmZ7	xrohan@example.org	paid	9000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
17	MPl7y2Op0KbwMeSRYH5RMvC6IXTyoGQL2slGyLse	lindgren.bridgette@example.net	paid	5000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
18	iWm96tW1VIvff6eS40anWNVuKso3fAC5UXYc0VDF	austen05@example.org	paid	6000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
19	SxrO6AclxpvJoECeR4ldRam0ltXrMNRs0ntExiDs	mark.auer@example.org	paid	10000	RUB	2026-07-08 12:50:22	\N	2026-07-08 12:50:22	2026-07-08 12:50:22
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms (id, name, created_at, updated_at) FROM stdin;
1	Зал большой	2026-07-07 07:36:42	2026-07-07 07:36:42
2	Зал средний	2026-07-07 07:36:42	2026-07-07 07:36:42
3	Зал малый	2026-07-07 07:36:42	2026-07-07 07:36:42
4	Зал большой	2026-07-08 12:50:22	2026-07-08 12:50:22
5	Зал средний	2026-07-08 12:50:22	2026-07-08 12:50:22
6	Зал малый	2026-07-08 12:50:22	2026-07-08 12:50:22
\.


--
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.seats (id, room_id, number, created_at, updated_at) FROM stdin;
1	1	1	2026-07-07 07:36:42	2026-07-07 07:36:42
2	1	2	2026-07-07 07:36:42	2026-07-07 07:36:42
3	1	3	2026-07-07 07:36:42	2026-07-07 07:36:42
4	1	4	2026-07-07 07:36:42	2026-07-07 07:36:42
5	1	5	2026-07-07 07:36:42	2026-07-07 07:36:42
6	1	6	2026-07-07 07:36:42	2026-07-07 07:36:42
7	1	7	2026-07-07 07:36:42	2026-07-07 07:36:42
8	1	8	2026-07-07 07:36:42	2026-07-07 07:36:42
9	1	9	2026-07-07 07:36:42	2026-07-07 07:36:42
10	1	10	2026-07-07 07:36:42	2026-07-07 07:36:42
11	2	1	2026-07-07 07:36:42	2026-07-07 07:36:42
12	2	2	2026-07-07 07:36:42	2026-07-07 07:36:42
13	2	3	2026-07-07 07:36:42	2026-07-07 07:36:42
14	2	4	2026-07-07 07:36:42	2026-07-07 07:36:42
15	2	5	2026-07-07 07:36:42	2026-07-07 07:36:42
16	2	6	2026-07-07 07:36:42	2026-07-07 07:36:42
17	2	7	2026-07-07 07:36:42	2026-07-07 07:36:42
18	2	8	2026-07-07 07:36:42	2026-07-07 07:36:42
19	2	9	2026-07-07 07:36:42	2026-07-07 07:36:42
20	2	10	2026-07-07 07:36:42	2026-07-07 07:36:42
21	3	1	2026-07-07 07:36:42	2026-07-07 07:36:42
22	3	2	2026-07-07 07:36:42	2026-07-07 07:36:42
23	3	3	2026-07-07 07:36:42	2026-07-07 07:36:42
24	3	4	2026-07-07 07:36:42	2026-07-07 07:36:42
25	3	5	2026-07-07 07:36:42	2026-07-07 07:36:42
26	3	6	2026-07-07 07:36:42	2026-07-07 07:36:42
27	3	7	2026-07-07 07:36:42	2026-07-07 07:36:42
28	3	8	2026-07-07 07:36:42	2026-07-07 07:36:42
29	3	9	2026-07-07 07:36:42	2026-07-07 07:36:42
30	3	10	2026-07-07 07:36:42	2026-07-07 07:36:42
31	4	1	2026-07-08 12:50:22	2026-07-08 12:50:22
32	4	2	2026-07-08 12:50:22	2026-07-08 12:50:22
33	4	3	2026-07-08 12:50:22	2026-07-08 12:50:22
34	4	4	2026-07-08 12:50:22	2026-07-08 12:50:22
35	4	5	2026-07-08 12:50:22	2026-07-08 12:50:22
36	4	6	2026-07-08 12:50:22	2026-07-08 12:50:22
37	4	7	2026-07-08 12:50:22	2026-07-08 12:50:22
38	4	8	2026-07-08 12:50:22	2026-07-08 12:50:22
39	4	9	2026-07-08 12:50:22	2026-07-08 12:50:22
40	4	10	2026-07-08 12:50:22	2026-07-08 12:50:22
41	5	1	2026-07-08 12:50:22	2026-07-08 12:50:22
42	5	2	2026-07-08 12:50:22	2026-07-08 12:50:22
43	5	3	2026-07-08 12:50:22	2026-07-08 12:50:22
44	5	4	2026-07-08 12:50:22	2026-07-08 12:50:22
45	5	5	2026-07-08 12:50:22	2026-07-08 12:50:22
46	5	6	2026-07-08 12:50:22	2026-07-08 12:50:22
47	5	7	2026-07-08 12:50:22	2026-07-08 12:50:22
48	5	8	2026-07-08 12:50:22	2026-07-08 12:50:22
49	5	9	2026-07-08 12:50:22	2026-07-08 12:50:22
50	5	10	2026-07-08 12:50:22	2026-07-08 12:50:22
51	6	1	2026-07-08 12:50:22	2026-07-08 12:50:22
52	6	2	2026-07-08 12:50:22	2026-07-08 12:50:22
53	6	3	2026-07-08 12:50:22	2026-07-08 12:50:22
54	6	4	2026-07-08 12:50:22	2026-07-08 12:50:22
55	6	5	2026-07-08 12:50:22	2026-07-08 12:50:22
56	6	6	2026-07-08 12:50:22	2026-07-08 12:50:22
57	6	7	2026-07-08 12:50:22	2026-07-08 12:50:22
58	6	8	2026-07-08 12:50:22	2026-07-08 12:50:22
59	6	9	2026-07-08 12:50:22	2026-07-08 12:50:22
60	6	10	2026-07-08 12:50:22	2026-07-08 12:50:22
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tickets (id, order_id, movie_session_id, seat_id, created_at, updated_at) FROM stdin;
1	1	1	1	2026-07-07 07:36:42	2026-07-07 07:36:42
2	1	1	2	2026-07-07 07:36:42	2026-07-07 07:36:42
3	1	1	3	2026-07-07 07:36:42	2026-07-07 07:36:42
4	1	1	4	2026-07-07 07:36:42	2026-07-07 07:36:42
5	1	1	6	2026-07-07 07:36:42	2026-07-07 07:36:42
6	1	1	7	2026-07-07 07:36:42	2026-07-07 07:36:42
7	1	1	8	2026-07-07 07:36:42	2026-07-07 07:36:42
8	1	1	9	2026-07-07 07:36:42	2026-07-07 07:36:42
9	1	1	10	2026-07-07 07:36:42	2026-07-07 07:36:42
10	2	2	2	2026-07-07 07:36:42	2026-07-07 07:36:42
11	2	2	4	2026-07-07 07:36:42	2026-07-07 07:36:42
12	2	2	7	2026-07-07 07:36:42	2026-07-07 07:36:42
13	2	2	8	2026-07-07 07:36:42	2026-07-07 07:36:42
14	3	3	1	2026-07-07 07:36:42	2026-07-07 07:36:42
15	3	3	2	2026-07-07 07:36:42	2026-07-07 07:36:42
16	3	3	3	2026-07-07 07:36:42	2026-07-07 07:36:42
17	3	3	5	2026-07-07 07:36:42	2026-07-07 07:36:42
18	3	3	6	2026-07-07 07:36:42	2026-07-07 07:36:42
19	3	3	7	2026-07-07 07:36:42	2026-07-07 07:36:42
20	3	3	8	2026-07-07 07:36:42	2026-07-07 07:36:42
21	3	3	9	2026-07-07 07:36:42	2026-07-07 07:36:42
22	4	4	5	2026-07-07 07:36:42	2026-07-07 07:36:42
23	4	4	8	2026-07-07 07:36:42	2026-07-07 07:36:42
24	5	5	11	2026-07-07 07:36:42	2026-07-07 07:36:42
25	5	5	14	2026-07-07 07:36:42	2026-07-07 07:36:42
26	5	5	16	2026-07-07 07:36:42	2026-07-07 07:36:42
27	5	5	17	2026-07-07 07:36:42	2026-07-07 07:36:42
28	5	5	20	2026-07-07 07:36:42	2026-07-07 07:36:42
29	6	6	11	2026-07-07 07:36:42	2026-07-07 07:36:42
30	6	6	12	2026-07-07 07:36:42	2026-07-07 07:36:42
31	6	6	14	2026-07-07 07:36:42	2026-07-07 07:36:42
32	6	6	15	2026-07-07 07:36:42	2026-07-07 07:36:42
33	6	6	16	2026-07-07 07:36:42	2026-07-07 07:36:42
34	6	6	17	2026-07-07 07:36:42	2026-07-07 07:36:42
35	6	6	18	2026-07-07 07:36:42	2026-07-07 07:36:42
36	6	6	19	2026-07-07 07:36:42	2026-07-07 07:36:42
37	6	6	20	2026-07-07 07:36:42	2026-07-07 07:36:42
38	7	7	15	2026-07-07 07:36:42	2026-07-07 07:36:42
39	8	9	21	2026-07-07 07:36:42	2026-07-07 07:36:42
40	8	9	22	2026-07-07 07:36:42	2026-07-07 07:36:42
41	8	9	23	2026-07-07 07:36:42	2026-07-07 07:36:42
42	8	9	24	2026-07-07 07:36:42	2026-07-07 07:36:42
43	8	9	25	2026-07-07 07:36:42	2026-07-07 07:36:42
44	8	9	26	2026-07-07 07:36:42	2026-07-07 07:36:42
45	8	9	27	2026-07-07 07:36:42	2026-07-07 07:36:42
46	8	9	28	2026-07-07 07:36:42	2026-07-07 07:36:42
47	8	9	29	2026-07-07 07:36:42	2026-07-07 07:36:42
48	8	9	30	2026-07-07 07:36:42	2026-07-07 07:36:42
49	9	10	23	2026-07-07 07:36:42	2026-07-07 07:36:42
50	9	10	24	2026-07-07 07:36:42	2026-07-07 07:36:42
51	9	10	25	2026-07-07 07:36:42	2026-07-07 07:36:42
52	9	10	26	2026-07-07 07:36:42	2026-07-07 07:36:42
53	9	10	27	2026-07-07 07:36:42	2026-07-07 07:36:42
54	9	10	29	2026-07-07 07:36:42	2026-07-07 07:36:42
55	10	11	21	2026-07-07 07:36:42	2026-07-07 07:36:42
56	10	11	22	2026-07-07 07:36:42	2026-07-07 07:36:42
57	10	11	23	2026-07-07 07:36:42	2026-07-07 07:36:42
58	10	11	25	2026-07-07 07:36:42	2026-07-07 07:36:42
59	10	11	28	2026-07-07 07:36:42	2026-07-07 07:36:42
60	11	12	21	2026-07-07 07:36:42	2026-07-07 07:36:42
61	11	12	22	2026-07-07 07:36:42	2026-07-07 07:36:42
62	11	12	23	2026-07-07 07:36:42	2026-07-07 07:36:42
63	11	12	24	2026-07-07 07:36:42	2026-07-07 07:36:42
64	11	12	25	2026-07-07 07:36:42	2026-07-07 07:36:42
65	11	12	26	2026-07-07 07:36:42	2026-07-07 07:36:42
66	11	12	27	2026-07-07 07:36:42	2026-07-07 07:36:42
67	11	12	28	2026-07-07 07:36:42	2026-07-07 07:36:42
68	11	12	30	2026-07-07 07:36:42	2026-07-07 07:36:42
69	12	13	31	2026-07-08 12:50:22	2026-07-08 12:50:22
70	12	13	32	2026-07-08 12:50:22	2026-07-08 12:50:22
71	12	13	35	2026-07-08 12:50:22	2026-07-08 12:50:22
72	12	13	36	2026-07-08 12:50:22	2026-07-08 12:50:22
73	12	13	37	2026-07-08 12:50:22	2026-07-08 12:50:22
74	12	13	39	2026-07-08 12:50:22	2026-07-08 12:50:22
75	13	15	31	2026-07-08 12:50:22	2026-07-08 12:50:22
76	13	15	35	2026-07-08 12:50:22	2026-07-08 12:50:22
77	13	15	37	2026-07-08 12:50:22	2026-07-08 12:50:22
78	13	15	38	2026-07-08 12:50:22	2026-07-08 12:50:22
79	13	15	39	2026-07-08 12:50:22	2026-07-08 12:50:22
80	13	15	40	2026-07-08 12:50:22	2026-07-08 12:50:22
81	14	16	33	2026-07-08 12:50:22	2026-07-08 12:50:22
82	14	16	36	2026-07-08 12:50:22	2026-07-08 12:50:22
83	15	17	41	2026-07-08 12:50:22	2026-07-08 12:50:22
84	15	17	42	2026-07-08 12:50:22	2026-07-08 12:50:22
85	15	17	44	2026-07-08 12:50:22	2026-07-08 12:50:22
86	15	17	45	2026-07-08 12:50:22	2026-07-08 12:50:22
87	15	17	46	2026-07-08 12:50:22	2026-07-08 12:50:22
88	15	17	47	2026-07-08 12:50:22	2026-07-08 12:50:22
89	15	17	48	2026-07-08 12:50:22	2026-07-08 12:50:22
90	15	17	49	2026-07-08 12:50:22	2026-07-08 12:50:22
91	15	17	50	2026-07-08 12:50:22	2026-07-08 12:50:22
92	16	18	41	2026-07-08 12:50:22	2026-07-08 12:50:22
93	16	18	42	2026-07-08 12:50:22	2026-07-08 12:50:22
94	16	18	43	2026-07-08 12:50:22	2026-07-08 12:50:22
95	16	18	44	2026-07-08 12:50:22	2026-07-08 12:50:22
96	16	18	45	2026-07-08 12:50:22	2026-07-08 12:50:22
97	16	18	47	2026-07-08 12:50:22	2026-07-08 12:50:22
98	16	18	48	2026-07-08 12:50:22	2026-07-08 12:50:22
99	16	18	49	2026-07-08 12:50:22	2026-07-08 12:50:22
100	16	18	50	2026-07-08 12:50:22	2026-07-08 12:50:22
101	17	19	41	2026-07-08 12:50:22	2026-07-08 12:50:22
102	17	19	44	2026-07-08 12:50:22	2026-07-08 12:50:22
103	17	19	47	2026-07-08 12:50:22	2026-07-08 12:50:22
104	17	19	48	2026-07-08 12:50:22	2026-07-08 12:50:22
105	17	19	49	2026-07-08 12:50:22	2026-07-08 12:50:22
106	18	20	42	2026-07-08 12:50:22	2026-07-08 12:50:22
107	18	20	45	2026-07-08 12:50:22	2026-07-08 12:50:22
108	18	20	46	2026-07-08 12:50:22	2026-07-08 12:50:22
109	18	20	48	2026-07-08 12:50:22	2026-07-08 12:50:22
110	18	20	49	2026-07-08 12:50:22	2026-07-08 12:50:22
111	18	20	50	2026-07-08 12:50:22	2026-07-08 12:50:22
112	19	21	51	2026-07-08 12:50:22	2026-07-08 12:50:22
113	19	21	52	2026-07-08 12:50:22	2026-07-08 12:50:22
114	19	21	53	2026-07-08 12:50:22	2026-07-08 12:50:22
115	19	21	54	2026-07-08 12:50:22	2026-07-08 12:50:22
116	19	21	55	2026-07-08 12:50:22	2026-07-08 12:50:22
117	19	21	56	2026-07-08 12:50:22	2026-07-08 12:50:22
118	19	21	57	2026-07-08 12:50:22	2026-07-08 12:50:22
119	19	21	58	2026-07-08 12:50:22	2026-07-08 12:50:22
120	19	21	59	2026-07-08 12:50:22	2026-07-08 12:50:22
121	19	21	60	2026-07-08 12:50:22	2026-07-08 12:50:22
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 9, true);


--
-- Name: movie_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.movie_sessions_id_seq', 24, true);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.movies_id_seq', 18, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 19, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_id_seq', 6, true);


--
-- Name: seats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.seats_id_seq', 60, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tickets_id_seq', 121, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: movie_sessions movie_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie_sessions
    ADD CONSTRAINT movie_sessions_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: orders orders_access_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_access_token_unique UNIQUE (access_token);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (id);


--
-- Name: seats seats_room_id_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_room_id_number_unique UNIQUE (room_id, number);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_movie_session_id_seat_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_movie_session_id_seat_id_unique UNIQUE (movie_session_id, seat_id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: failed_jobs_connection_queue_failed_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX failed_jobs_connection_queue_failed_at_index ON public.failed_jobs USING btree (connection, queue, failed_at);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: movie_sessions movie_sessions_movie_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie_sessions
    ADD CONSTRAINT movie_sessions_movie_id_foreign FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT;


--
-- Name: movie_sessions movie_sessions_room_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie_sessions
    ADD CONSTRAINT movie_sessions_room_id_foreign FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE RESTRICT;


--
-- Name: seats seats_room_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_room_id_foreign FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE RESTRICT;


--
-- Name: tickets tickets_movie_session_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_movie_session_id_foreign FOREIGN KEY (movie_session_id) REFERENCES public.movie_sessions(id) ON DELETE RESTRICT;


--
-- Name: tickets tickets_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE RESTRICT;


--
-- Name: tickets tickets_seat_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_seat_id_foreign FOREIGN KEY (seat_id) REFERENCES public.seats(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict xB4jS11bB19wwaVAj4i2t5fnRWGZeJfzZBuz5Gad9Z1RGzj14GqMcHgVGvsWjpO

