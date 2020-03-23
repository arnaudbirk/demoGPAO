--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: gpao_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gpao_version() RETURNS numeric
    LANGUAGE sql IMMUTABLE
    AS $$select 1.9$$;


ALTER FUNCTION public.gpao_version() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bloc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bloc (
    id integer NOT NULL,
    nom character varying,
    status character varying(10),
    priorite integer,
    idchantier integer
);


ALTER TABLE public.bloc OWNER TO postgres;

--
-- Name: bloc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bloc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bloc_id_seq OWNER TO postgres;

--
-- Name: bloc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE bloc_id_seq OWNED BY bloc.id;


--
-- Name: chantier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE chantier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chantier_id_seq OWNER TO postgres;

--
-- Name: chantier; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE chantier (
    id integer DEFAULT nextval('chantier_id_seq'::regclass) NOT NULL,
    nom character varying,
    priorite integer
);


ALTER TABLE public.chantier OWNER TO postgres;

--
-- Name: dependance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dependance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependance_id_seq OWNER TO postgres;

--
-- Name: dependancebloc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dependancebloc (
    id integer NOT NULL,
    idbloc integer,
    idblocdependant integer,
    niveau character varying,
    status character varying
);


ALTER TABLE public.dependancebloc OWNER TO postgres;

--
-- Name: dependancebloc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dependancebloc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependancebloc_id_seq OWNER TO postgres;

--
-- Name: dependancebloc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dependancebloc_id_seq OWNED BY dependancebloc.id;


--
-- Name: dependancejob; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dependancejob (
    id integer DEFAULT nextval('dependance_id_seq'::regclass) NOT NULL,
    idjob integer,
    idjobdependant integer,
    niveau character varying(15),
    status character varying(5)
);


ALTER TABLE public.dependancejob OWNER TO postgres;

--
-- Name: infolot; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE infolot (
    id integer NOT NULL,
    cle character varying NOT NULL,
    valeur character varying NOT NULL,
    idlot integer NOT NULL
);


ALTER TABLE public.infolot OWNER TO postgres;

--
-- Name: infolot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE infolot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.infolot_id_seq OWNER TO postgres;

--
-- Name: infolot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE infolot_id_seq OWNED BY infolot.id;


--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_id_seq OWNER TO postgres;

--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE job (
    id integer DEFAULT nextval('job_id_seq'::regclass) NOT NULL,
    type character varying(30),
    nom character varying,
    priorite integer,
    commande character varying,
    status character varying(20),
    ressource character varying(50),
    coderetour integer,
    message character varying,
    datedebut timestamp without time zone,
    duree integer,
    idlot integer,
    manuel boolean
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: lock; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lock (
    id integer NOT NULL,
    idlot integer,
    idlotlocked integer,
    status boolean
);


ALTER TABLE public.lock OWNER TO postgres;

--
-- Name: lock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lock_id_seq OWNER TO postgres;

--
-- Name: lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lock_id_seq OWNED BY lock.id;


--
-- Name: lot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lot_id_seq OWNER TO postgres;

--
-- Name: lot; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lot (
    id integer DEFAULT nextval('lot_id_seq'::regclass) NOT NULL,
    nom character varying,
    status character varying(10),
    duree integer,
    ressource character varying(50),
    alerte character varying DEFAULT ''::character varying,
    nbjobtodo integer,
    nbjobinprocess integer,
    nbjobdone integer,
    nbjobfailed integer,
    validation character varying(20),
    reflotpred integer DEFAULT (-1),
    reflotnext integer DEFAULT (-1),
    type character varying(20),
    idbloc integer,
    manuel boolean
);


ALTER TABLE public.lot OWNER TO postgres;

--
-- Name: param; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE param (
    id integer NOT NULL,
    cle character varying NOT NULL,
    valeur character varying NOT NULL,
    type integer NOT NULL,
    idchantier integer NOT NULL
);


ALTER TABLE public.param OWNER TO postgres;

--
-- Name: param_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE param_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.param_id_seq OWNER TO postgres;

--
-- Name: param_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE param_id_seq OWNED BY param.id;


--
-- Name: ressource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ressource (
    nom character varying NOT NULL,
    version character varying,
    nbth integer,
    nbthmax integer,
    nbthoptimal integer,
    status character varying,
    espace integer,
    commande character varying,
    uuid character varying,
    lastconnection timestamp without time zone,
    description character varying
);


ALTER TABLE public.ressource OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bloc ALTER COLUMN id SET DEFAULT nextval('bloc_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependancebloc ALTER COLUMN id SET DEFAULT nextval('dependancebloc_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY infolot ALTER COLUMN id SET DEFAULT nextval('infolot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lock ALTER COLUMN id SET DEFAULT nextval('lock_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY param ALTER COLUMN id SET DEFAULT nextval('param_id_seq'::regclass);


--
-- Name: bloc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bloc
    ADD CONSTRAINT bloc_pkey PRIMARY KEY (id);


--
-- Name: chantier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY chantier
    ADD CONSTRAINT chantier_pkey PRIMARY KEY (id);


--
-- Name: dependance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dependancejob
    ADD CONSTRAINT dependance_pkey PRIMARY KEY (id);


--
-- Name: dependancebloc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dependancebloc
    ADD CONSTRAINT dependancebloc_pkey PRIMARY KEY (id);


--
-- Name: infolot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY infolot
    ADD CONSTRAINT infolot_pkey PRIMARY KEY (id);


--
-- Name: job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lock
    ADD CONSTRAINT lock_pkey PRIMARY KEY (id);


--
-- Name: lot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lot
    ADD CONSTRAINT lot_pkey PRIMARY KEY (id);


--
-- Name: param_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY param
    ADD CONSTRAINT param_pkey PRIMARY KEY (id);


--
-- Name: ressource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ressource
    ADD CONSTRAINT ressource_pkey PRIMARY KEY (nom);


--
-- Name: status_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX status_idx ON job USING btree (status);


--
-- Name: fk_idbloc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependancebloc
    ADD CONSTRAINT fk_idbloc FOREIGN KEY (idbloc) REFERENCES bloc(id) MATCH FULL;


--
-- Name: fk_idbloc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lot
    ADD CONSTRAINT fk_idbloc FOREIGN KEY (idbloc) REFERENCES bloc(id) MATCH FULL;


--
-- Name: fk_idblocdependant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependancebloc
    ADD CONSTRAINT fk_idblocdependant FOREIGN KEY (idblocdependant) REFERENCES bloc(id) MATCH FULL;


--
-- Name: fk_idchantier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bloc
    ADD CONSTRAINT fk_idchantier FOREIGN KEY (idchantier) REFERENCES chantier(id);


--
-- Name: fk_idchantier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY param
    ADD CONSTRAINT fk_idchantier FOREIGN KEY (idchantier) REFERENCES chantier(id) MATCH FULL;


--
-- Name: fk_idlot; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY infolot
    ADD CONSTRAINT fk_idlot FOREIGN KEY (idlot) REFERENCES lot(id) MATCH FULL;


--
-- Name: fk_idlot; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lock
    ADD CONSTRAINT fk_idlot FOREIGN KEY (idlot) REFERENCES lot(id) MATCH FULL;


--
-- Name: fk_idlotlocked; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lock
    ADD CONSTRAINT fk_idlotlocked FOREIGN KEY (idlotlocked) REFERENCES lot(id) MATCH FULL;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

