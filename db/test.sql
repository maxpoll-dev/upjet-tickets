--
-- PostgreSQL database dump
--

\restrict NIte9h9JMKfTF7IkyjTNXqZD7bZNDpwj8WKiV2Wcg0qDZQZeyjLfoBIc6Eo5LSk

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
1	7	1	2026-07-08 10:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
2	5	1	2026-07-08 14:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
3	9	1	2026-07-08 18:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
4	4	1	2026-07-08 22:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
5	9	2	2026-07-08 10:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
6	3	2	2026-07-08 14:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
7	5	2	2026-07-08 18:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
8	5	2	2026-07-08 22:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
9	3	3	2026-07-08 10:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
10	9	3	2026-07-08 14:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
11	9	3	2026-07-08 18:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
12	9	3	2026-07-08 22:00:00	1000	RUB	2026-07-08 13:18:26	2026-07-08 13:18:26
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.movies (id, title, created_at, updated_at) FROM stdin;
1	Начало	2026-07-08 13:18:26	2026-07-08 13:18:26
2	Матрица	2026-07-08 13:18:26	2026-07-08 13:18:26
3	Интерстеллар	2026-07-08 13:18:26	2026-07-08 13:18:26
4	Побег из Шоушенка	2026-07-08 13:18:26	2026-07-08 13:18:26
5	Форрест Гамп	2026-07-08 13:18:26	2026-07-08 13:18:26
6	Гладиатор	2026-07-08 13:18:26	2026-07-08 13:18:26
7	Крёстный отец	2026-07-08 13:18:26	2026-07-08 13:18:26
8	Бойцовский клуб	2026-07-08 13:18:26	2026-07-08 13:18:26
9	Зелёная миля	2026-07-08 13:18:26	2026-07-08 13:18:26
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, access_token, email, status, amount_total, currency, paid_at, expires_at, created_at, updated_at) FROM stdin;
1	K7N2TufrvtaJVO1u56QAaFm5uYGDXtNSZliClRlw	luella48@example.org	paid	7000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
2	WfOxR2P7uRElXjtYLPHFHiJbTHNxPEphvtIIrsAm	mark15@example.net	paid	10000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
3	5A0G4SmxQkpAl4HkstNeJZg8RFl6ofQ6rRf66DU8	jimmy43@example.com	paid	9000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
4	Yx9dTSsD9m3TKMNyMae5BfOIU3zgZ5LHgSotINq9	legros.jessy@example.org	paid	7000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
5	b7cDA4dxfByomlnusizL9xobvINLQXMCtzTT3oiQ	arlie.bartell@example.com	paid	4000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
6	aIiJjZmhftU7pHRgaoHgKEbUlyyDLXKbcIE3dy8v	oheidenreich@example.net	paid	2000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
7	xmJ3SCW19sQTuZRzGesE3u8NcTQMugGwoP7Y9oHB	mariane.lang@example.com	paid	7000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
8	dQiSQhiz4Jox5A2Zus4ObKONaqGex8hIUvLlk9z4	ian.carter@example.com	paid	7000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
9	8O3rDmegRpLq7xR1Rda9jWcy4lEvU4KOZwVKJohv	harber.rocky@example.com	paid	2000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
10	X03tZdKSgLFau6ZplGvvKQU7Xy6qYmIYjgiU6KGY	audrey.gutkowski@example.com	paid	4000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
11	VbDfWjODSzZLsKufRNbeX4B8A4mYE3I1OW0nPXzO	onie18@example.org	paid	7000	RUB	2026-07-08 13:18:26	\N	2026-07-08 13:18:26	2026-07-08 13:18:26
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms (id, name, created_at, updated_at) FROM stdin;
1	Зал большой	2026-07-08 13:18:26	2026-07-08 13:18:26
2	Зал средний	2026-07-08 13:18:26	2026-07-08 13:18:26
3	Зал малый	2026-07-08 13:18:26	2026-07-08 13:18:26
\.


--
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.seats (id, room_id, number, created_at, updated_at) FROM stdin;
1	1	1	2026-07-08 13:18:26	2026-07-08 13:18:26
2	1	2	2026-07-08 13:18:26	2026-07-08 13:18:26
3	1	3	2026-07-08 13:18:26	2026-07-08 13:18:26
4	1	4	2026-07-08 13:18:26	2026-07-08 13:18:26
5	1	5	2026-07-08 13:18:26	2026-07-08 13:18:26
6	1	6	2026-07-08 13:18:26	2026-07-08 13:18:26
7	1	7	2026-07-08 13:18:26	2026-07-08 13:18:26
8	1	8	2026-07-08 13:18:26	2026-07-08 13:18:26
9	1	9	2026-07-08 13:18:26	2026-07-08 13:18:26
10	1	10	2026-07-08 13:18:26	2026-07-08 13:18:26
11	2	1	2026-07-08 13:18:26	2026-07-08 13:18:26
12	2	2	2026-07-08 13:18:26	2026-07-08 13:18:26
13	2	3	2026-07-08 13:18:26	2026-07-08 13:18:26
14	2	4	2026-07-08 13:18:26	2026-07-08 13:18:26
15	2	5	2026-07-08 13:18:26	2026-07-08 13:18:26
16	2	6	2026-07-08 13:18:26	2026-07-08 13:18:26
17	2	7	2026-07-08 13:18:26	2026-07-08 13:18:26
18	2	8	2026-07-08 13:18:26	2026-07-08 13:18:26
19	2	9	2026-07-08 13:18:26	2026-07-08 13:18:26
20	2	10	2026-07-08 13:18:26	2026-07-08 13:18:26
21	3	1	2026-07-08 13:18:26	2026-07-08 13:18:26
22	3	2	2026-07-08 13:18:26	2026-07-08 13:18:26
23	3	3	2026-07-08 13:18:26	2026-07-08 13:18:26
24	3	4	2026-07-08 13:18:26	2026-07-08 13:18:26
25	3	5	2026-07-08 13:18:26	2026-07-08 13:18:26
26	3	6	2026-07-08 13:18:26	2026-07-08 13:18:26
27	3	7	2026-07-08 13:18:26	2026-07-08 13:18:26
28	3	8	2026-07-08 13:18:26	2026-07-08 13:18:26
29	3	9	2026-07-08 13:18:26	2026-07-08 13:18:26
30	3	10	2026-07-08 13:18:26	2026-07-08 13:18:26
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
1	1	1	2	2026-07-08 13:18:26	2026-07-08 13:18:26
2	1	1	3	2026-07-08 13:18:26	2026-07-08 13:18:26
3	1	1	5	2026-07-08 13:18:26	2026-07-08 13:18:26
4	1	1	6	2026-07-08 13:18:26	2026-07-08 13:18:26
5	1	1	7	2026-07-08 13:18:26	2026-07-08 13:18:26
6	1	1	8	2026-07-08 13:18:26	2026-07-08 13:18:26
7	1	1	10	2026-07-08 13:18:26	2026-07-08 13:18:26
8	2	2	1	2026-07-08 13:18:26	2026-07-08 13:18:26
9	2	2	2	2026-07-08 13:18:26	2026-07-08 13:18:26
10	2	2	3	2026-07-08 13:18:26	2026-07-08 13:18:26
11	2	2	4	2026-07-08 13:18:26	2026-07-08 13:18:26
12	2	2	5	2026-07-08 13:18:26	2026-07-08 13:18:26
13	2	2	6	2026-07-08 13:18:26	2026-07-08 13:18:26
14	2	2	7	2026-07-08 13:18:26	2026-07-08 13:18:26
15	2	2	8	2026-07-08 13:18:26	2026-07-08 13:18:26
16	2	2	9	2026-07-08 13:18:26	2026-07-08 13:18:26
17	2	2	10	2026-07-08 13:18:26	2026-07-08 13:18:26
18	3	3	1	2026-07-08 13:18:26	2026-07-08 13:18:26
19	3	3	2	2026-07-08 13:18:26	2026-07-08 13:18:26
20	3	3	3	2026-07-08 13:18:26	2026-07-08 13:18:26
21	3	3	4	2026-07-08 13:18:26	2026-07-08 13:18:26
22	3	3	5	2026-07-08 13:18:26	2026-07-08 13:18:26
23	3	3	6	2026-07-08 13:18:26	2026-07-08 13:18:26
24	3	3	8	2026-07-08 13:18:26	2026-07-08 13:18:26
25	3	3	9	2026-07-08 13:18:26	2026-07-08 13:18:26
26	3	3	10	2026-07-08 13:18:26	2026-07-08 13:18:26
27	4	4	1	2026-07-08 13:18:26	2026-07-08 13:18:26
28	4	4	3	2026-07-08 13:18:26	2026-07-08 13:18:26
29	4	4	5	2026-07-08 13:18:26	2026-07-08 13:18:26
30	4	4	6	2026-07-08 13:18:26	2026-07-08 13:18:26
31	4	4	8	2026-07-08 13:18:26	2026-07-08 13:18:26
32	4	4	9	2026-07-08 13:18:26	2026-07-08 13:18:26
33	4	4	10	2026-07-08 13:18:26	2026-07-08 13:18:26
34	5	6	11	2026-07-08 13:18:26	2026-07-08 13:18:26
35	5	6	15	2026-07-08 13:18:26	2026-07-08 13:18:26
36	5	6	17	2026-07-08 13:18:26	2026-07-08 13:18:26
37	5	6	20	2026-07-08 13:18:26	2026-07-08 13:18:26
38	6	7	17	2026-07-08 13:18:26	2026-07-08 13:18:26
39	6	7	18	2026-07-08 13:18:26	2026-07-08 13:18:26
40	7	8	12	2026-07-08 13:18:26	2026-07-08 13:18:26
41	7	8	13	2026-07-08 13:18:26	2026-07-08 13:18:26
42	7	8	14	2026-07-08 13:18:26	2026-07-08 13:18:26
43	7	8	15	2026-07-08 13:18:26	2026-07-08 13:18:26
44	7	8	17	2026-07-08 13:18:26	2026-07-08 13:18:26
45	7	8	19	2026-07-08 13:18:26	2026-07-08 13:18:26
46	7	8	20	2026-07-08 13:18:26	2026-07-08 13:18:26
47	8	9	21	2026-07-08 13:18:26	2026-07-08 13:18:26
48	8	9	22	2026-07-08 13:18:26	2026-07-08 13:18:26
49	8	9	23	2026-07-08 13:18:26	2026-07-08 13:18:26
50	8	9	27	2026-07-08 13:18:26	2026-07-08 13:18:26
51	8	9	28	2026-07-08 13:18:26	2026-07-08 13:18:26
52	8	9	29	2026-07-08 13:18:26	2026-07-08 13:18:26
53	8	9	30	2026-07-08 13:18:26	2026-07-08 13:18:26
54	9	10	21	2026-07-08 13:18:26	2026-07-08 13:18:26
55	9	10	27	2026-07-08 13:18:26	2026-07-08 13:18:26
56	10	11	24	2026-07-08 13:18:26	2026-07-08 13:18:26
57	10	11	26	2026-07-08 13:18:26	2026-07-08 13:18:26
58	10	11	29	2026-07-08 13:18:26	2026-07-08 13:18:26
59	10	11	30	2026-07-08 13:18:26	2026-07-08 13:18:26
60	11	12	21	2026-07-08 13:18:26	2026-07-08 13:18:26
61	11	12	22	2026-07-08 13:18:26	2026-07-08 13:18:26
62	11	12	23	2026-07-08 13:18:26	2026-07-08 13:18:26
63	11	12	24	2026-07-08 13:18:26	2026-07-08 13:18:26
64	11	12	27	2026-07-08 13:18:26	2026-07-08 13:18:26
65	11	12	28	2026-07-08 13:18:26	2026-07-08 13:18:26
66	11	12	30	2026-07-08 13:18:26	2026-07-08 13:18:26
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

SELECT pg_catalog.setval('public.movie_sessions_id_seq', 12, true);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.movies_id_seq', 9, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 11, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_id_seq', 3, true);


--
-- Name: seats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.seats_id_seq', 30, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tickets_id_seq', 66, true);


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

\unrestrict NIte9h9JMKfTF7IkyjTNXqZD7bZNDpwj8WKiV2Wcg0qDZQZeyjLfoBIc6Eo5LSk

