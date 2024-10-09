--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Debian 14.9-1.pgdg120+1)
-- Dumped by pg_dump version 14.9 (Debian 14.9-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: todo
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    title character varying(100),
    description character varying(200),
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'Europe/Moscow'::text)
);


ALTER TABLE public.tasks OWNER TO todo;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: todo
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO todo;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: todo
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: todo
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: todo
--

COPY public.tasks (id, title, description, created_at) FROM stdin;
\.


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: todo
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: todo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

