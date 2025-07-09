--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18
-- Dumped by pg_dump version 14.18 (Homebrew)

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
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_permissions OWNER TO strapi;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_id_seq OWNER TO strapi;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);


ALTER TABLE public.admin_permissions_role_links OWNER TO strapi;

--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_role_links_id_seq OWNER TO strapi;

--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_roles OWNER TO strapi;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_roles_id_seq OWNER TO strapi;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.admin_users OWNER TO strapi;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO strapi;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.admin_users_roles_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_order double precision,
    user_order double precision
);


ALTER TABLE public.admin_users_roles_links OWNER TO strapi;

--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.admin_users_roles_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_roles_links_id_seq OWNER TO strapi;

--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;


--
-- Name: components_a_external_videos; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_external_videos (
    id integer NOT NULL,
    url character varying(255),
    caption character varying(255)
);


ALTER TABLE public.components_a_external_videos OWNER TO strapi;

--
-- Name: components_a_external_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_external_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_external_videos_id_seq OWNER TO strapi;

--
-- Name: components_a_external_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_external_videos_id_seq OWNED BY public.components_a_external_videos.id;


--
-- Name: components_a_pagebreakers; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_pagebreakers (
    id integer NOT NULL,
    backbutton boolean,
    nextbutton boolean
);


ALTER TABLE public.components_a_pagebreakers OWNER TO strapi;

--
-- Name: components_a_pagebreakers_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_pagebreakers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_pagebreakers_id_seq OWNER TO strapi;

--
-- Name: components_a_pagebreakers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_pagebreakers_id_seq OWNED BY public.components_a_pagebreakers.id;


--
-- Name: components_a_quizzes; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_quizzes (
    id integer NOT NULL,
    question character varying(255),
    options jsonb,
    answer character varying(255),
    explanation character varying(255)
);


ALTER TABLE public.components_a_quizzes OWNER TO strapi;

--
-- Name: components_a_quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_quizzes_id_seq OWNER TO strapi;

--
-- Name: components_a_quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_quizzes_id_seq OWNED BY public.components_a_quizzes.id;


--
-- Name: components_a_sent_refs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_sent_refs (
    id integer NOT NULL
);


ALTER TABLE public.components_a_sent_refs OWNER TO strapi;

--
-- Name: components_a_sent_refs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_sent_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_sent_refs_id_seq OWNER TO strapi;

--
-- Name: components_a_sent_refs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_sent_refs_id_seq OWNED BY public.components_a_sent_refs.id;


--
-- Name: components_a_sent_refs_sentence_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_sent_refs_sentence_links (
    id integer NOT NULL,
    sent_ref_id integer,
    sentence_id integer
);


ALTER TABLE public.components_a_sent_refs_sentence_links OWNER TO strapi;

--
-- Name: components_a_sent_refs_sentence_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_sent_refs_sentence_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_sent_refs_sentence_links_id_seq OWNER TO strapi;

--
-- Name: components_a_sent_refs_sentence_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_sent_refs_sentence_links_id_seq OWNED BY public.components_a_sent_refs_sentence_links.id;


--
-- Name: components_a_taglists; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_taglists (
    id integer NOT NULL,
    tag character varying(255)
);


ALTER TABLE public.components_a_taglists OWNER TO strapi;

--
-- Name: components_a_taglists_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_taglists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_taglists_id_seq OWNER TO strapi;

--
-- Name: components_a_taglists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_taglists_id_seq OWNED BY public.components_a_taglists.id;


--
-- Name: components_a_user_sent_refs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_user_sent_refs (
    id integer NOT NULL
);


ALTER TABLE public.components_a_user_sent_refs OWNER TO strapi;

--
-- Name: components_a_user_sent_refs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_user_sent_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_user_sent_refs_id_seq OWNER TO strapi;

--
-- Name: components_a_user_sent_refs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_user_sent_refs_id_seq OWNED BY public.components_a_user_sent_refs.id;


--
-- Name: components_a_user_sent_refs_user_sentence_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_user_sent_refs_user_sentence_links (
    id integer NOT NULL,
    user_sent_ref_id integer,
    user_sentence_id integer
);


ALTER TABLE public.components_a_user_sent_refs_user_sentence_links OWNER TO strapi;

--
-- Name: components_a_user_sent_refs_user_sentence_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_user_sent_refs_user_sentence_links_id_seq OWNER TO strapi;

--
-- Name: components_a_user_sent_refs_user_sentence_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq OWNED BY public.components_a_user_sent_refs_user_sentence_links.id;


--
-- Name: components_a_user_word_refs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_user_word_refs (
    id integer NOT NULL
);


ALTER TABLE public.components_a_user_word_refs OWNER TO strapi;

--
-- Name: components_a_user_word_refs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_user_word_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_user_word_refs_id_seq OWNER TO strapi;

--
-- Name: components_a_user_word_refs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_user_word_refs_id_seq OWNED BY public.components_a_user_word_refs.id;


--
-- Name: components_a_user_word_refs_user_word_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_user_word_refs_user_word_links (
    id integer NOT NULL,
    user_word_ref_id integer,
    user_word_id integer
);


ALTER TABLE public.components_a_user_word_refs_user_word_links OWNER TO strapi;

--
-- Name: components_a_user_word_refs_user_word_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_user_word_refs_user_word_links_id_seq OWNER TO strapi;

--
-- Name: components_a_user_word_refs_user_word_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq OWNED BY public.components_a_user_word_refs_user_word_links.id;


--
-- Name: components_a_verb_metas; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_verb_metas (
    id integer NOT NULL,
    simple_past character varying(255),
    past_participle character varying(255),
    present_participle character varying(255),
    thirdperson_singular character varying(255),
    auxiliary_verb character varying(255),
    conjugations jsonb
);


ALTER TABLE public.components_a_verb_metas OWNER TO strapi;

--
-- Name: components_a_verb_metas_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_verb_metas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_verb_metas_id_seq OWNER TO strapi;

--
-- Name: components_a_verb_metas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_verb_metas_id_seq OWNED BY public.components_a_verb_metas.id;


--
-- Name: components_a_videos; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_videos (
    id integer NOT NULL
);


ALTER TABLE public.components_a_videos OWNER TO strapi;

--
-- Name: components_a_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_videos_id_seq OWNER TO strapi;

--
-- Name: components_a_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_videos_id_seq OWNED BY public.components_a_videos.id;


--
-- Name: components_a_word_refs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_word_refs (
    id integer NOT NULL
);


ALTER TABLE public.components_a_word_refs OWNER TO strapi;

--
-- Name: components_a_word_refs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_word_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_word_refs_id_seq OWNER TO strapi;

--
-- Name: components_a_word_refs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_word_refs_id_seq OWNED BY public.components_a_word_refs.id;


--
-- Name: components_a_word_refs_word_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.components_a_word_refs_word_links (
    id integer NOT NULL,
    word_ref_id integer,
    word_id integer
);


ALTER TABLE public.components_a_word_refs_word_links OWNER TO strapi;

--
-- Name: components_a_word_refs_word_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.components_a_word_refs_word_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_a_word_refs_word_links_id_seq OWNER TO strapi;

--
-- Name: components_a_word_refs_word_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.components_a_word_refs_word_links_id_seq OWNED BY public.components_a_word_refs_word_links.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files (
    id integer NOT NULL,
    name character varying(255),
    alternative_text character varying(255),
    caption character varying(255),
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url character varying(255),
    preview_url character varying(255),
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.files OWNER TO strapi;

--
-- Name: files_folder_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files_folder_links (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_order double precision
);


ALTER TABLE public.files_folder_links OWNER TO strapi;

--
-- Name: files_folder_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_folder_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_folder_links_id_seq OWNER TO strapi;

--
-- Name: files_folder_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_id_seq OWNER TO strapi;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_morphs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.files_related_morphs (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.files_related_morphs OWNER TO strapi;

--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.files_related_morphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_related_morphs_id_seq OWNER TO strapi;

--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;


--
-- Name: flashcards; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.flashcards (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    last_reviewed_at timestamp(6) without time zone,
    is_remembered boolean,
    correct_streak integer,
    wrong_streak integer
);


ALTER TABLE public.flashcards OWNER TO strapi;

--
-- Name: flashcards_components; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.flashcards_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.flashcards_components OWNER TO strapi;

--
-- Name: flashcards_components_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.flashcards_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_components_id_seq OWNER TO strapi;

--
-- Name: flashcards_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.flashcards_components_id_seq OWNED BY public.flashcards_components.id;


--
-- Name: flashcards_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.flashcards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_id_seq OWNER TO strapi;

--
-- Name: flashcards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;


--
-- Name: flashcards_lesson_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.flashcards_lesson_links (
    id integer NOT NULL,
    flashcard_id integer,
    lesson_id integer,
    flashcard_order double precision
);


ALTER TABLE public.flashcards_lesson_links OWNER TO strapi;

--
-- Name: flashcards_lesson_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.flashcards_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_lesson_links_id_seq OWNER TO strapi;

--
-- Name: flashcards_lesson_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.flashcards_lesson_links_id_seq OWNED BY public.flashcards_lesson_links.id;


--
-- Name: flashcards_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.flashcards_localizations_links (
    id integer NOT NULL,
    flashcard_id integer,
    inv_flashcard_id integer,
    flashcard_order double precision
);


ALTER TABLE public.flashcards_localizations_links OWNER TO strapi;

--
-- Name: flashcards_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.flashcards_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_localizations_links_id_seq OWNER TO strapi;

--
-- Name: flashcards_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.flashcards_localizations_links_id_seq OWNED BY public.flashcards_localizations_links.id;


--
-- Name: flashcards_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.flashcards_user_links (
    id integer NOT NULL,
    flashcard_id integer,
    user_id integer,
    flashcard_order double precision
);


ALTER TABLE public.flashcards_user_links OWNER TO strapi;

--
-- Name: flashcards_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.flashcards_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_user_links_id_seq OWNER TO strapi;

--
-- Name: flashcards_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.flashcards_user_links_id_seq OWNED BY public.flashcards_user_links.id;


--
-- Name: flashcards_vocapage_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.flashcards_vocapage_links (
    id integer NOT NULL,
    flashcard_id integer,
    vocapage_id integer,
    flashcard_order double precision
);


ALTER TABLE public.flashcards_vocapage_links OWNER TO strapi;

--
-- Name: flashcards_vocapage_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.flashcards_vocapage_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_vocapage_links_id_seq OWNER TO strapi;

--
-- Name: flashcards_vocapage_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.flashcards_vocapage_links_id_seq OWNED BY public.flashcards_vocapage_links.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.i18n_locale OWNER TO strapi;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i18n_locale_id_seq OWNER TO strapi;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: lessonlevels; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.lessonlevels (
    id integer NOT NULL,
    level character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    description character varying(255)
);


ALTER TABLE public.lessonlevels OWNER TO strapi;

--
-- Name: lessonlevels_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.lessonlevels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessonlevels_id_seq OWNER TO strapi;

--
-- Name: lessonlevels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.lessonlevels_id_seq OWNED BY public.lessonlevels.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    title character varying(255),
    slug character varying(255),
    description character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.lessons OWNER TO strapi;

--
-- Name: lessons_components; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.lessons_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.lessons_components OWNER TO strapi;

--
-- Name: lessons_components_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.lessons_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_components_id_seq OWNER TO strapi;

--
-- Name: lessons_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.lessons_components_id_seq OWNED BY public.lessons_components.id;


--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_id_seq OWNER TO strapi;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: lessons_lessonlevel_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.lessons_lessonlevel_links (
    id integer NOT NULL,
    lesson_id integer,
    lessonlevel_id integer,
    lesson_order double precision
);


ALTER TABLE public.lessons_lessonlevel_links OWNER TO strapi;

--
-- Name: lessons_lessonlevel_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.lessons_lessonlevel_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_lessonlevel_links_id_seq OWNER TO strapi;

--
-- Name: lessons_lessonlevel_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.lessons_lessonlevel_links_id_seq OWNED BY public.lessons_lessonlevel_links.id;


--
-- Name: lessons_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.lessons_localizations_links (
    id integer NOT NULL,
    lesson_id integer,
    inv_lesson_id integer,
    lesson_order double precision
);


ALTER TABLE public.lessons_localizations_links OWNER TO strapi;

--
-- Name: lessons_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.lessons_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_localizations_links_id_seq OWNER TO strapi;

--
-- Name: lessons_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.lessons_localizations_links_id_seq OWNED BY public.lessons_localizations_links.id;


--
-- Name: lessons_unit_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.lessons_unit_links (
    id integer NOT NULL,
    lesson_id integer,
    unit_id integer,
    lesson_order double precision
);


ALTER TABLE public.lessons_unit_links OWNER TO strapi;

--
-- Name: lessons_unit_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.lessons_unit_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_unit_links_id_seq OWNER TO strapi;

--
-- Name: lessons_unit_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.lessons_unit_links_id_seq OWNED BY public.lessons_unit_links.id;


--
-- Name: review_tires; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.review_tires (
    id integer NOT NULL,
    tier character varying(255),
    min_streak integer,
    max_streak integer,
    cooldown_hours integer,
    demote_bar integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.review_tires OWNER TO strapi;

--
-- Name: review_tires_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.review_tires_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.review_tires_id_seq OWNER TO strapi;

--
-- Name: review_tires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.review_tires_id_seq OWNED BY public.review_tires.id;


--
-- Name: review_tires_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.review_tires_localizations_links (
    id integer NOT NULL,
    review_tire_id integer,
    inv_review_tire_id integer,
    review_tire_order double precision
);


ALTER TABLE public.review_tires_localizations_links OWNER TO strapi;

--
-- Name: review_tires_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.review_tires_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.review_tires_localizations_links_id_seq OWNER TO strapi;

--
-- Name: review_tires_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.review_tires_localizations_links_id_seq OWNED BY public.review_tires_localizations_links.id;


--
-- Name: reviewlogs; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.reviewlogs (
    id integer NOT NULL,
    level character varying(255),
    result character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    reviewed_at timestamp(6) without time zone
);


ALTER TABLE public.reviewlogs OWNER TO strapi;

--
-- Name: reviewlogs_flashcard_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.reviewlogs_flashcard_links (
    id integer NOT NULL,
    reviewlog_id integer,
    flashcard_id integer,
    reviewlog_order double precision
);


ALTER TABLE public.reviewlogs_flashcard_links OWNER TO strapi;

--
-- Name: reviewlogs_flashcard_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.reviewlogs_flashcard_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviewlogs_flashcard_links_id_seq OWNER TO strapi;

--
-- Name: reviewlogs_flashcard_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.reviewlogs_flashcard_links_id_seq OWNED BY public.reviewlogs_flashcard_links.id;


--
-- Name: reviewlogs_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.reviewlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviewlogs_id_seq OWNER TO strapi;

--
-- Name: reviewlogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.reviewlogs_id_seq OWNED BY public.reviewlogs.id;


--
-- Name: reviewlogs_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.reviewlogs_user_links (
    id integer NOT NULL,
    reviewlog_id integer,
    user_id integer,
    reviewlog_order double precision
);


ALTER TABLE public.reviewlogs_user_links OWNER TO strapi;

--
-- Name: reviewlogs_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.reviewlogs_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviewlogs_user_links_id_seq OWNER TO strapi;

--
-- Name: reviewlogs_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.reviewlogs_user_links_id_seq OWNED BY public.reviewlogs_user_links.id;


--
-- Name: sections; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sections (
    id integer NOT NULL,
    title character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.sections OWNER TO strapi;

--
-- Name: sections_components; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sections_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.sections_components OWNER TO strapi;

--
-- Name: sections_components_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sections_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_components_id_seq OWNER TO strapi;

--
-- Name: sections_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sections_components_id_seq OWNED BY public.sections_components.id;


--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_id_seq OWNER TO strapi;

--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;


--
-- Name: sections_lesson_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sections_lesson_links (
    id integer NOT NULL,
    section_id integer,
    lesson_id integer,
    section_order double precision
);


ALTER TABLE public.sections_lesson_links OWNER TO strapi;

--
-- Name: sections_lesson_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sections_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_lesson_links_id_seq OWNER TO strapi;

--
-- Name: sections_lesson_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sections_lesson_links_id_seq OWNED BY public.sections_lesson_links.id;


--
-- Name: sections_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sections_localizations_links (
    id integer NOT NULL,
    section_id integer,
    inv_section_id integer,
    section_order double precision
);


ALTER TABLE public.sections_localizations_links OWNER TO strapi;

--
-- Name: sections_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sections_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_localizations_links_id_seq OWNER TO strapi;

--
-- Name: sections_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sections_localizations_links_id_seq OWNED BY public.sections_localizations_links.id;


--
-- Name: sentences; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sentences (
    id integer NOT NULL,
    title character varying(255),
    instruction character varying(255),
    base_text character varying(255),
    target_text character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    register character varying(255),
    exam_base jsonb,
    exam_target jsonb
);


ALTER TABLE public.sentences OWNER TO strapi;

--
-- Name: sentences_components; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sentences_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.sentences_components OWNER TO strapi;

--
-- Name: sentences_components_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sentences_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentences_components_id_seq OWNER TO strapi;

--
-- Name: sentences_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sentences_components_id_seq OWNED BY public.sentences_components.id;


--
-- Name: sentences_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentences_id_seq OWNER TO strapi;

--
-- Name: sentences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;


--
-- Name: sentences_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.sentences_localizations_links (
    id integer NOT NULL,
    sentence_id integer,
    inv_sentence_id integer,
    sentence_order double precision
);


ALTER TABLE public.sentences_localizations_links OWNER TO strapi;

--
-- Name: sentences_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sentences_localizations_links_id_seq OWNER TO strapi;

--
-- Name: sentences_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.sentences_localizations_links_id_seq OWNED BY public.sentences_localizations_links.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_api_token_permissions OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_id_seq OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_token_permissions_token_links (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_order double precision
);


ALTER TABLE public.strapi_api_token_permissions_token_links OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_token_links_id_seq OWNER TO strapi;

--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_api_tokens OWNER TO strapi;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_tokens_id_seq OWNER TO strapi;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.strapi_core_store_settings OWNER TO strapi;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_core_store_settings_id_seq OWNER TO strapi;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


ALTER TABLE public.strapi_database_schema OWNER TO strapi;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_database_schema_id_seq OWNER TO strapi;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations OWNER TO strapi;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_id_seq OWNER TO strapi;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_transfer_token_permissions OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_token_permissions_token_links (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_order double precision
);


ALTER TABLE public.strapi_transfer_token_permissions_token_links OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_token_links_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_transfer_tokens OWNER TO strapi;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_tokens_id_seq OWNER TO strapi;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_webhooks_id_seq OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.units (
    id integer NOT NULL,
    title character varying(255),
    slug character varying(255),
    description character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.units OWNER TO strapi;

--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_id_seq OWNER TO strapi;

--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: units_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.units_localizations_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer,
    unit_order double precision
);


ALTER TABLE public.units_localizations_links OWNER TO strapi;

--
-- Name: units_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.units_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_localizations_links_id_seq OWNER TO strapi;

--
-- Name: units_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.units_localizations_links_id_seq OWNED BY public.units_localizations_links.id;


--
-- Name: units_precondition_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.units_precondition_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer
);


ALTER TABLE public.units_precondition_links OWNER TO strapi;

--
-- Name: units_precondition_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.units_precondition_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_precondition_links_id_seq OWNER TO strapi;

--
-- Name: units_precondition_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.units_precondition_links_id_seq OWNED BY public.units_precondition_links.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_permissions OWNER TO strapi;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_id_seq OWNER TO strapi;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);


ALTER TABLE public.up_permissions_role_links OWNER TO strapi;

--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_role_links_id_seq OWNER TO strapi;

--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_roles OWNER TO strapi;

--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_roles_id_seq OWNER TO strapi;

--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.up_users OWNER TO strapi;

--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_id_seq OWNER TO strapi;

--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_role_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.up_users_role_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_order double precision
);


ALTER TABLE public.up_users_role_links OWNER TO strapi;

--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.up_users_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_role_links_id_seq OWNER TO strapi;

--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.upload_folders OWNER TO strapi;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_id_seq OWNER TO strapi;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_folders_parent_links (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_order double precision
);


ALTER TABLE public.upload_folders_parent_links OWNER TO strapi;

--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_folders_parent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_parent_links_id_seq OWNER TO strapi;

--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_profiles (
    id integer NOT NULL,
    telephone character varying(255),
    base_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.user_profiles OWNER TO strapi;

--
-- Name: user_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profiles_id_seq OWNER TO strapi;

--
-- Name: user_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;


--
-- Name: user_profiles_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_profiles_user_links (
    id integer NOT NULL,
    user_profile_id integer,
    user_id integer
);


ALTER TABLE public.user_profiles_user_links OWNER TO strapi;

--
-- Name: user_profiles_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_profiles_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profiles_user_links_id_seq OWNER TO strapi;

--
-- Name: user_profiles_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_profiles_user_links_id_seq OWNED BY public.user_profiles_user_links.id;


--
-- Name: user_sentences; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_sentences (
    id integer NOT NULL,
    target_text character varying(255),
    base_text character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.user_sentences OWNER TO strapi;

--
-- Name: user_sentences_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_sentences_id_seq OWNER TO strapi;

--
-- Name: user_sentences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_sentences_id_seq OWNED BY public.user_sentences.id;


--
-- Name: user_sentences_lesson_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_sentences_lesson_links (
    id integer NOT NULL,
    user_sentence_id integer,
    lesson_id integer,
    user_sentence_order double precision
);


ALTER TABLE public.user_sentences_lesson_links OWNER TO strapi;

--
-- Name: user_sentences_lesson_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_sentences_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_sentences_lesson_links_id_seq OWNER TO strapi;

--
-- Name: user_sentences_lesson_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_sentences_lesson_links_id_seq OWNED BY public.user_sentences_lesson_links.id;


--
-- Name: user_sentences_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_sentences_localizations_links (
    id integer NOT NULL,
    user_sentence_id integer,
    inv_user_sentence_id integer,
    user_sentence_order double precision
);


ALTER TABLE public.user_sentences_localizations_links OWNER TO strapi;

--
-- Name: user_sentences_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_sentences_localizations_links_id_seq OWNER TO strapi;

--
-- Name: user_sentences_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_sentences_localizations_links_id_seq OWNED BY public.user_sentences_localizations_links.id;


--
-- Name: user_sentences_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_sentences_user_links (
    id integer NOT NULL,
    user_sentence_id integer,
    user_id integer,
    user_sentence_order double precision
);


ALTER TABLE public.user_sentences_user_links OWNER TO strapi;

--
-- Name: user_sentences_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_sentences_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_sentences_user_links_id_seq OWNER TO strapi;

--
-- Name: user_sentences_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_sentences_user_links_id_seq OWNED BY public.user_sentences_user_links.id;


--
-- Name: user_words; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_words (
    id integer NOT NULL,
    base_text character varying(255),
    part_of_speech character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    target_text character varying(255),
    exam_base jsonb,
    exam_target jsonb
);


ALTER TABLE public.user_words OWNER TO strapi;

--
-- Name: user_words_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_words_id_seq OWNER TO strapi;

--
-- Name: user_words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_words_id_seq OWNED BY public.user_words.id;


--
-- Name: user_words_lesson_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_words_lesson_links (
    id integer NOT NULL,
    user_word_id integer,
    lesson_id integer,
    user_word_order double precision
);


ALTER TABLE public.user_words_lesson_links OWNER TO strapi;

--
-- Name: user_words_lesson_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_words_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_words_lesson_links_id_seq OWNER TO strapi;

--
-- Name: user_words_lesson_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_words_lesson_links_id_seq OWNED BY public.user_words_lesson_links.id;


--
-- Name: user_words_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_words_localizations_links (
    id integer NOT NULL,
    user_word_id integer,
    inv_user_word_id integer,
    user_word_order double precision
);


ALTER TABLE public.user_words_localizations_links OWNER TO strapi;

--
-- Name: user_words_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_words_localizations_links_id_seq OWNER TO strapi;

--
-- Name: user_words_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_words_localizations_links_id_seq OWNED BY public.user_words_localizations_links.id;


--
-- Name: user_words_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.user_words_user_links (
    id integer NOT NULL,
    user_word_id integer,
    user_id integer,
    user_word_order double precision
);


ALTER TABLE public.user_words_user_links OWNER TO strapi;

--
-- Name: user_words_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.user_words_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_words_user_links_id_seq OWNER TO strapi;

--
-- Name: user_words_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.user_words_user_links_id_seq OWNED BY public.user_words_user_links.id;


--
-- Name: vbsettings; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.vbsettings (
    id integer NOT NULL,
    words_per_page integer,
    interval_1 numeric(10,2),
    interval_2 numeric(10,2),
    interval_3 numeric(10,2),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.vbsettings OWNER TO strapi;

--
-- Name: vbsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.vbsettings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vbsettings_id_seq OWNER TO strapi;

--
-- Name: vbsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.vbsettings_id_seq OWNED BY public.vbsettings.id;


--
-- Name: vbsettings_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.vbsettings_user_links (
    id integer NOT NULL,
    vbsetting_id integer,
    user_id integer
);


ALTER TABLE public.vbsettings_user_links OWNER TO strapi;

--
-- Name: vbsettings_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.vbsettings_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vbsettings_user_links_id_seq OWNER TO strapi;

--
-- Name: vbsettings_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.vbsettings_user_links_id_seq OWNED BY public.vbsettings_user_links.id;


--
-- Name: vocabooks; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.vocabooks (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.vocabooks OWNER TO strapi;

--
-- Name: vocabooks_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.vocabooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vocabooks_id_seq OWNER TO strapi;

--
-- Name: vocabooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.vocabooks_id_seq OWNED BY public.vocabooks.id;


--
-- Name: vocabooks_user_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.vocabooks_user_links (
    id integer NOT NULL,
    vocabook_id integer,
    user_id integer
);


ALTER TABLE public.vocabooks_user_links OWNER TO strapi;

--
-- Name: vocabooks_user_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.vocabooks_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vocabooks_user_links_id_seq OWNER TO strapi;

--
-- Name: vocabooks_user_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.vocabooks_user_links_id_seq OWNED BY public.vocabooks_user_links.id;


--
-- Name: vocapages; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.vocapages (
    id integer NOT NULL,
    title character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.vocapages OWNER TO strapi;

--
-- Name: vocapages_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.vocapages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vocapages_id_seq OWNER TO strapi;

--
-- Name: vocapages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.vocapages_id_seq OWNED BY public.vocapages.id;


--
-- Name: vocapages_vocabook_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.vocapages_vocabook_links (
    id integer NOT NULL,
    vocapage_id integer,
    vocabook_id integer,
    vocapage_order double precision
);


ALTER TABLE public.vocapages_vocabook_links OWNER TO strapi;

--
-- Name: vocapages_vocabook_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.vocapages_vocabook_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vocapages_vocabook_links_id_seq OWNER TO strapi;

--
-- Name: vocapages_vocabook_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.vocapages_vocabook_links_id_seq OWNED BY public.vocapages_vocabook_links.id;


--
-- Name: words; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.words (
    id integer NOT NULL,
    word character varying(255),
    base_text character varying(255),
    instruction character varying(255),
    part_of_speech character varying(255),
    gender character varying(255),
    article character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    register character varying(255),
    exam_base jsonb,
    exam_target jsonb
);


ALTER TABLE public.words OWNER TO strapi;

--
-- Name: words_components; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.words_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.words_components OWNER TO strapi;

--
-- Name: words_components_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.words_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.words_components_id_seq OWNER TO strapi;

--
-- Name: words_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.words_components_id_seq OWNED BY public.words_components.id;


--
-- Name: words_example_sentences_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.words_example_sentences_links (
    id integer NOT NULL,
    word_id integer,
    sentence_id integer,
    sentence_order double precision,
    word_order double precision
);


ALTER TABLE public.words_example_sentences_links OWNER TO strapi;

--
-- Name: words_example_sentences_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.words_example_sentences_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.words_example_sentences_links_id_seq OWNER TO strapi;

--
-- Name: words_example_sentences_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.words_example_sentences_links_id_seq OWNED BY public.words_example_sentences_links.id;


--
-- Name: words_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.words_id_seq OWNER TO strapi;

--
-- Name: words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;


--
-- Name: words_localizations_links; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.words_localizations_links (
    id integer NOT NULL,
    word_id integer,
    inv_word_id integer,
    word_order double precision
);


ALTER TABLE public.words_localizations_links OWNER TO strapi;

--
-- Name: words_localizations_links_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.words_localizations_links_id_seq OWNER TO strapi;

--
-- Name: words_localizations_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.words_localizations_links_id_seq OWNED BY public.words_localizations_links.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);


--
-- Name: components_a_external_videos id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_external_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_external_videos_id_seq'::regclass);


--
-- Name: components_a_pagebreakers id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_pagebreakers ALTER COLUMN id SET DEFAULT nextval('public.components_a_pagebreakers_id_seq'::regclass);


--
-- Name: components_a_quizzes id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_quizzes ALTER COLUMN id SET DEFAULT nextval('public.components_a_quizzes_id_seq'::regclass);


--
-- Name: components_a_sent_refs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_id_seq'::regclass);


--
-- Name: components_a_sent_refs_sentence_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_sentence_links_id_seq'::regclass);


--
-- Name: components_a_taglists id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_taglists ALTER COLUMN id SET DEFAULT nextval('public.components_a_taglists_id_seq'::regclass);


--
-- Name: components_a_user_sent_refs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_id_seq'::regclass);


--
-- Name: components_a_user_sent_refs_user_sentence_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_user_sentence_links_id_seq'::regclass);


--
-- Name: components_a_user_word_refs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_id_seq'::regclass);


--
-- Name: components_a_user_word_refs_user_word_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_user_word_links_id_seq'::regclass);


--
-- Name: components_a_verb_metas id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_verb_metas ALTER COLUMN id SET DEFAULT nextval('public.components_a_verb_metas_id_seq'::regclass);


--
-- Name: components_a_videos id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_videos_id_seq'::regclass);


--
-- Name: components_a_word_refs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_id_seq'::regclass);


--
-- Name: components_a_word_refs_word_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_word_links_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);


--
-- Name: files_related_morphs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);


--
-- Name: flashcards id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);


--
-- Name: flashcards_components id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_components ALTER COLUMN id SET DEFAULT nextval('public.flashcards_components_id_seq'::regclass);


--
-- Name: flashcards_lesson_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_lesson_links_id_seq'::regclass);


--
-- Name: flashcards_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_localizations_links_id_seq'::regclass);


--
-- Name: flashcards_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_user_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_user_links_id_seq'::regclass);


--
-- Name: flashcards_vocapage_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_vocapage_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_vocapage_links_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: lessonlevels id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessonlevels ALTER COLUMN id SET DEFAULT nextval('public.lessonlevels_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: lessons_components id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_components ALTER COLUMN id SET DEFAULT nextval('public.lessons_components_id_seq'::regclass);


--
-- Name: lessons_lessonlevel_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_lessonlevel_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_lessonlevel_links_id_seq'::regclass);


--
-- Name: lessons_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_localizations_links_id_seq'::regclass);


--
-- Name: lessons_unit_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_unit_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_unit_links_id_seq'::regclass);


--
-- Name: review_tires id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires ALTER COLUMN id SET DEFAULT nextval('public.review_tires_id_seq'::regclass);


--
-- Name: review_tires_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.review_tires_localizations_links_id_seq'::regclass);


--
-- Name: reviewlogs id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_id_seq'::regclass);


--
-- Name: reviewlogs_flashcard_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_flashcard_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_flashcard_links_id_seq'::regclass);


--
-- Name: reviewlogs_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_user_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_user_links_id_seq'::regclass);


--
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);


--
-- Name: sections_components id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_components ALTER COLUMN id SET DEFAULT nextval('public.sections_components_id_seq'::regclass);


--
-- Name: sections_lesson_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.sections_lesson_links_id_seq'::regclass);


--
-- Name: sections_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sections_localizations_links_id_seq'::regclass);


--
-- Name: sentences id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);


--
-- Name: sentences_components id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_components ALTER COLUMN id SET DEFAULT nextval('public.sentences_components_id_seq'::regclass);


--
-- Name: sentences_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sentences_localizations_links_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Name: units_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.units_localizations_links_id_seq'::regclass);


--
-- Name: units_precondition_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_precondition_links ALTER COLUMN id SET DEFAULT nextval('public.units_precondition_links_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_role_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);


--
-- Name: user_profiles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);


--
-- Name: user_profiles_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_user_links_id_seq'::regclass);


--
-- Name: user_sentences id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_id_seq'::regclass);


--
-- Name: user_sentences_lesson_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_lesson_links_id_seq'::regclass);


--
-- Name: user_sentences_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_localizations_links_id_seq'::regclass);


--
-- Name: user_sentences_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_user_links_id_seq'::regclass);


--
-- Name: user_words id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words ALTER COLUMN id SET DEFAULT nextval('public.user_words_id_seq'::regclass);


--
-- Name: user_words_lesson_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_lesson_links_id_seq'::regclass);


--
-- Name: user_words_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_localizations_links_id_seq'::regclass);


--
-- Name: user_words_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_user_links_id_seq'::regclass);


--
-- Name: vbsettings id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings ALTER COLUMN id SET DEFAULT nextval('public.vbsettings_id_seq'::regclass);


--
-- Name: vbsettings_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings_user_links ALTER COLUMN id SET DEFAULT nextval('public.vbsettings_user_links_id_seq'::regclass);


--
-- Name: vocabooks id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks ALTER COLUMN id SET DEFAULT nextval('public.vocabooks_id_seq'::regclass);


--
-- Name: vocabooks_user_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks_user_links ALTER COLUMN id SET DEFAULT nextval('public.vocabooks_user_links_id_seq'::regclass);


--
-- Name: vocapages id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages ALTER COLUMN id SET DEFAULT nextval('public.vocapages_id_seq'::regclass);


--
-- Name: vocapages_vocabook_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages_vocabook_links ALTER COLUMN id SET DEFAULT nextval('public.vocapages_vocabook_links_id_seq'::regclass);


--
-- Name: words id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);


--
-- Name: words_components id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_components ALTER COLUMN id SET DEFAULT nextval('public.words_components_id_seq'::regclass);


--
-- Name: words_example_sentences_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_example_sentences_links ALTER COLUMN id SET DEFAULT nextval('public.words_example_sentences_links_id_seq'::regclass);


--
-- Name: words_localizations_links id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.words_localizations_links_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	plugin::upload.read	{}	\N	{}	[]	2025-06-23 17:47:31.614	2025-06-23 17:47:31.614	\N	\N
2	plugin::upload.configure-view	{}	\N	{}	[]	2025-06-23 17:47:31.791	2025-06-23 17:47:31.791	\N	\N
3	plugin::upload.assets.create	{}	\N	{}	[]	2025-06-23 17:47:31.97	2025-06-23 17:47:31.97	\N	\N
4	plugin::upload.assets.update	{}	\N	{}	[]	2025-06-23 17:47:32.153	2025-06-23 17:47:32.153	\N	\N
5	plugin::upload.assets.download	{}	\N	{}	[]	2025-06-23 17:47:32.337	2025-06-23 17:47:32.337	\N	\N
6	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-06-23 17:47:32.495	2025-06-23 17:47:32.495	\N	\N
7	plugin::upload.read	{}	\N	{}	["admin::is-creator"]	2025-06-23 17:47:32.676	2025-06-23 17:47:32.676	\N	\N
8	plugin::upload.configure-view	{}	\N	{}	[]	2025-06-23 17:47:32.856	2025-06-23 17:47:32.856	\N	\N
9	plugin::upload.assets.create	{}	\N	{}	[]	2025-06-23 17:47:33.033	2025-06-23 17:47:33.033	\N	\N
10	plugin::upload.assets.update	{}	\N	{}	["admin::is-creator"]	2025-06-23 17:47:33.215	2025-06-23 17:47:33.215	\N	\N
11	plugin::upload.assets.download	{}	\N	{}	[]	2025-06-23 17:47:33.398	2025-06-23 17:47:33.398	\N	\N
12	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-06-23 17:47:33.584	2025-06-23 17:47:33.584	\N	\N
16	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2025-06-23 17:47:34.462	2025-06-23 17:47:34.462	\N	\N
17	plugin::content-manager.single-types.configure-view	{}	\N	{}	[]	2025-06-23 17:47:34.645	2025-06-23 17:47:34.645	\N	\N
18	plugin::content-manager.collection-types.configure-view	{}	\N	{}	[]	2025-06-23 17:47:34.827	2025-06-23 17:47:34.827	\N	\N
19	plugin::content-manager.components.configure-layout	{}	\N	{}	[]	2025-06-23 17:47:35.018	2025-06-23 17:47:35.018	\N	\N
20	plugin::content-type-builder.read	{}	\N	{}	[]	2025-06-23 17:47:35.213	2025-06-23 17:47:35.213	\N	\N
21	plugin::email.settings.read	{}	\N	{}	[]	2025-06-23 17:47:35.392	2025-06-23 17:47:35.392	\N	\N
22	plugin::upload.read	{}	\N	{}	[]	2025-06-23 17:47:35.574	2025-06-23 17:47:35.574	\N	\N
23	plugin::upload.assets.create	{}	\N	{}	[]	2025-06-23 17:47:35.755	2025-06-23 17:47:35.755	\N	\N
24	plugin::upload.assets.update	{}	\N	{}	[]	2025-06-23 17:47:35.937	2025-06-23 17:47:35.937	\N	\N
25	plugin::upload.assets.download	{}	\N	{}	[]	2025-06-23 17:47:36.118	2025-06-23 17:47:36.118	\N	\N
26	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-06-23 17:47:36.296	2025-06-23 17:47:36.296	\N	\N
27	plugin::upload.configure-view	{}	\N	{}	[]	2025-06-23 17:47:36.471	2025-06-23 17:47:36.471	\N	\N
28	plugin::upload.settings.read	{}	\N	{}	[]	2025-06-23 17:47:36.651	2025-06-23 17:47:36.651	\N	\N
29	plugin::users-permissions.roles.create	{}	\N	{}	[]	2025-06-23 17:47:36.833	2025-06-23 17:47:36.833	\N	\N
30	plugin::users-permissions.roles.read	{}	\N	{}	[]	2025-06-23 17:47:37.013	2025-06-23 17:47:37.013	\N	\N
31	plugin::users-permissions.roles.update	{}	\N	{}	[]	2025-06-23 17:47:37.192	2025-06-23 17:47:37.192	\N	\N
32	plugin::users-permissions.roles.delete	{}	\N	{}	[]	2025-06-23 17:47:37.372	2025-06-23 17:47:37.372	\N	\N
33	plugin::users-permissions.providers.read	{}	\N	{}	[]	2025-06-23 17:47:37.539	2025-06-23 17:47:37.539	\N	\N
34	plugin::users-permissions.providers.update	{}	\N	{}	[]	2025-06-23 17:47:37.719	2025-06-23 17:47:37.719	\N	\N
35	plugin::users-permissions.email-templates.read	{}	\N	{}	[]	2025-06-23 17:47:37.898	2025-06-23 17:47:37.898	\N	\N
36	plugin::users-permissions.email-templates.update	{}	\N	{}	[]	2025-06-23 17:47:38.082	2025-06-23 17:47:38.082	\N	\N
37	plugin::users-permissions.advanced-settings.read	{}	\N	{}	[]	2025-06-23 17:47:38.268	2025-06-23 17:47:38.268	\N	\N
38	plugin::users-permissions.advanced-settings.update	{}	\N	{}	[]	2025-06-23 17:47:38.45	2025-06-23 17:47:38.45	\N	\N
39	plugin::i18n.locale.create	{}	\N	{}	[]	2025-06-23 17:47:38.638	2025-06-23 17:47:38.638	\N	\N
40	plugin::i18n.locale.read	{}	\N	{}	[]	2025-06-23 17:47:38.82	2025-06-23 17:47:38.82	\N	\N
41	plugin::i18n.locale.update	{}	\N	{}	[]	2025-06-23 17:47:39.001	2025-06-23 17:47:39.001	\N	\N
42	plugin::i18n.locale.delete	{}	\N	{}	[]	2025-06-23 17:47:39.188	2025-06-23 17:47:39.188	\N	\N
43	admin::marketplace.read	{}	\N	{}	[]	2025-06-23 17:47:39.369	2025-06-23 17:47:39.369	\N	\N
44	admin::webhooks.create	{}	\N	{}	[]	2025-06-23 17:47:39.557	2025-06-23 17:47:39.557	\N	\N
45	admin::webhooks.read	{}	\N	{}	[]	2025-06-23 17:47:39.739	2025-06-23 17:47:39.739	\N	\N
46	admin::webhooks.update	{}	\N	{}	[]	2025-06-23 17:47:39.929	2025-06-23 17:47:39.929	\N	\N
47	admin::webhooks.delete	{}	\N	{}	[]	2025-06-23 17:47:40.11	2025-06-23 17:47:40.11	\N	\N
48	admin::users.create	{}	\N	{}	[]	2025-06-23 17:47:40.29	2025-06-23 17:47:40.29	\N	\N
49	admin::users.read	{}	\N	{}	[]	2025-06-23 17:47:40.471	2025-06-23 17:47:40.471	\N	\N
50	admin::users.update	{}	\N	{}	[]	2025-06-23 17:47:40.653	2025-06-23 17:47:40.653	\N	\N
51	admin::users.delete	{}	\N	{}	[]	2025-06-23 17:47:40.839	2025-06-23 17:47:40.839	\N	\N
52	admin::roles.create	{}	\N	{}	[]	2025-06-23 17:47:41.02	2025-06-23 17:47:41.02	\N	\N
53	admin::roles.read	{}	\N	{}	[]	2025-06-23 17:47:41.201	2025-06-23 17:47:41.201	\N	\N
54	admin::roles.update	{}	\N	{}	[]	2025-06-23 17:47:41.383	2025-06-23 17:47:41.383	\N	\N
55	admin::roles.delete	{}	\N	{}	[]	2025-06-23 17:47:41.566	2025-06-23 17:47:41.566	\N	\N
56	admin::api-tokens.access	{}	\N	{}	[]	2025-06-23 17:47:41.748	2025-06-23 17:47:41.748	\N	\N
57	admin::api-tokens.create	{}	\N	{}	[]	2025-06-23 17:47:41.934	2025-06-23 17:47:41.934	\N	\N
58	admin::api-tokens.read	{}	\N	{}	[]	2025-06-23 17:47:42.118	2025-06-23 17:47:42.118	\N	\N
59	admin::api-tokens.update	{}	\N	{}	[]	2025-06-23 17:47:42.3	2025-06-23 17:47:42.3	\N	\N
60	admin::api-tokens.regenerate	{}	\N	{}	[]	2025-06-23 17:47:42.504	2025-06-23 17:47:42.504	\N	\N
61	admin::api-tokens.delete	{}	\N	{}	[]	2025-06-23 17:47:42.674	2025-06-23 17:47:42.674	\N	\N
62	admin::project-settings.update	{}	\N	{}	[]	2025-06-23 17:47:42.854	2025-06-23 17:47:42.854	\N	\N
63	admin::project-settings.read	{}	\N	{}	[]	2025-06-23 17:47:43.035	2025-06-23 17:47:43.035	\N	\N
64	admin::transfer.tokens.access	{}	\N	{}	[]	2025-06-23 17:47:43.212	2025-06-23 17:47:43.212	\N	\N
65	admin::transfer.tokens.create	{}	\N	{}	[]	2025-06-23 17:47:43.395	2025-06-23 17:47:43.395	\N	\N
66	admin::transfer.tokens.read	{}	\N	{}	[]	2025-06-23 17:47:43.574	2025-06-23 17:47:43.574	\N	\N
67	admin::transfer.tokens.update	{}	\N	{}	[]	2025-06-23 17:47:43.768	2025-06-23 17:47:43.768	\N	\N
68	admin::transfer.tokens.regenerate	{}	\N	{}	[]	2025-06-23 17:47:43.949	2025-06-23 17:47:43.949	\N	\N
69	admin::transfer.tokens.delete	{}	\N	{}	[]	2025-06-23 17:47:44.141	2025-06-23 17:47:44.141	\N	\N
214	plugin::content-manager.explorer.create	{}	api::unit.unit	{"fields": ["title", "slug", "description", "order", "lessons", "precondition", "unlocks"], "locales": ["en"]}	[]	2025-06-28 21:36:22.846	2025-06-28 21:36:22.846	\N	\N
215	plugin::content-manager.explorer.read	{}	api::unit.unit	{"fields": ["title", "slug", "description", "order", "lessons", "precondition", "unlocks"], "locales": ["en"]}	[]	2025-06-28 21:36:23.03	2025-06-28 21:36:23.03	\N	\N
216	plugin::content-manager.explorer.update	{}	api::unit.unit	{"fields": ["title", "slug", "description", "order", "lessons", "precondition", "unlocks"], "locales": ["en"]}	[]	2025-06-28 21:36:23.211	2025-06-28 21:36:23.211	\N	\N
73	plugin::content-manager.explorer.delete	{}	api::unit.unit	{"locales": ["en"]}	[]	2025-06-23 20:42:41.13	2025-06-23 20:42:41.13	\N	\N
97	plugin::content-manager.explorer.delete	{}	api::sentence.sentence	{"locales": ["en"]}	[]	2025-06-23 20:51:21.567	2025-06-23 20:51:21.567	\N	\N
107	plugin::content-manager.explorer.delete	{}	api::word.word	{"locales": ["en"]}	[]	2025-06-23 21:12:34.201	2025-06-23 21:12:34.201	\N	\N
114	plugin::content-manager.explorer.delete	{}	api::lessonlevel.lessonlevel	{}	[]	2025-06-23 21:56:05.952	2025-06-23 21:56:05.952	\N	\N
134	plugin::content-manager.explorer.create	{}	api::lessonlevel.lessonlevel	{"fields": ["level", "description", "lessons"]}	[]	2025-06-24 00:19:07.424	2025-06-24 00:19:07.424	\N	\N
137	plugin::content-manager.explorer.read	{}	api::lessonlevel.lessonlevel	{"fields": ["level", "description", "lessons"]}	[]	2025-06-24 00:19:07.973	2025-06-24 00:19:07.973	\N	\N
140	plugin::content-manager.explorer.update	{}	api::lessonlevel.lessonlevel	{"fields": ["level", "description", "lessons"]}	[]	2025-06-24 00:19:08.519	2025-06-24 00:19:08.519	\N	\N
142	plugin::content-manager.explorer.delete	{}	api::lesson.lesson	{"locales": ["en"]}	[]	2025-06-24 00:19:09.02	2025-06-24 00:19:09.02	\N	\N
144	plugin::content-manager.explorer.create	{}	api::section.section	{"fields": ["title", "lesson", "order", "components"], "locales": ["en"]}	[]	2025-06-24 00:22:59.43	2025-06-24 00:22:59.43	\N	\N
146	plugin::content-manager.explorer.read	{}	api::section.section	{"fields": ["title", "lesson", "order", "components"], "locales": ["en"]}	[]	2025-06-24 00:22:59.782	2025-06-24 00:22:59.782	\N	\N
148	plugin::content-manager.explorer.update	{}	api::section.section	{"fields": ["title", "lesson", "order", "components"], "locales": ["en"]}	[]	2025-06-24 00:23:00.121	2025-06-24 00:23:00.121	\N	\N
149	plugin::content-manager.explorer.delete	{}	api::section.section	{"locales": ["en"]}	[]	2025-06-24 00:23:00.301	2025-06-24 00:23:00.301	\N	\N
156	plugin::content-manager.explorer.delete	{}	api::user-word.user-word	{"locales": ["en"]}	[]	2025-06-24 00:29:39.556	2025-06-24 00:29:39.556	\N	\N
315	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "flashcards", "reviewlogs", "user_profile", "user_words", "user_sentences", "vocabook", "vbsetting"]}	[]	2025-07-08 22:18:20.08	2025-07-08 22:18:20.08	\N	\N
316	plugin::content-manager.explorer.create	{}	api::vbsetting.vbsetting	{"fields": ["user", "wordsPerPage", "interval1", "interval2", "interval3"]}	[]	2025-07-08 22:18:20.265	2025-07-08 22:18:20.265	\N	\N
317	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "flashcards", "reviewlogs", "user_profile", "user_words", "user_sentences", "vocabook", "vbsetting"]}	[]	2025-07-08 22:18:20.45	2025-07-08 22:18:20.45	\N	\N
318	plugin::content-manager.explorer.read	{}	api::vbsetting.vbsetting	{"fields": ["user", "wordsPerPage", "interval1", "interval2", "interval3"]}	[]	2025-07-08 22:18:20.632	2025-07-08 22:18:20.632	\N	\N
319	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "flashcards", "reviewlogs", "user_profile", "user_words", "user_sentences", "vocabook", "vbsetting"]}	[]	2025-07-08 22:18:20.814	2025-07-08 22:18:20.814	\N	\N
320	plugin::content-manager.explorer.update	{}	api::vbsetting.vbsetting	{"fields": ["user", "wordsPerPage", "interval1", "interval2", "interval3"]}	[]	2025-07-08 22:18:21.001	2025-07-08 22:18:21.001	\N	\N
172	plugin::content-manager.explorer.delete	{}	api::user-sentence.user-sentence	{"locales": ["en"]}	[]	2025-06-24 00:33:42.436	2025-06-24 00:33:42.436	\N	\N
182	plugin::content-manager.explorer.delete	{}	api::flashcard.flashcard	{"locales": ["en"]}	[]	2025-06-26 23:58:50.836	2025-06-26 23:58:50.836	\N	\N
321	plugin::content-manager.explorer.delete	{}	api::vbsetting.vbsetting	{}	[]	2025-07-08 22:18:21.196	2025-07-08 22:18:21.196	\N	\N
195	plugin::content-manager.explorer.delete	{}	api::reviewlog.reviewlog	{}	[]	2025-06-28 13:06:40.586	2025-06-28 13:06:40.586	\N	\N
208	plugin::content-manager.explorer.create	{}	api::lesson.lesson	{"fields": ["title", "slug", "description", "order", "tags.tag", "lessonlevel", "sections", "user_words", "user_sentences", "flashcards", "unit"], "locales": ["en"]}	[]	2025-06-28 21:34:32.789	2025-06-28 21:34:32.789	\N	\N
210	plugin::content-manager.explorer.read	{}	api::lesson.lesson	{"fields": ["title", "slug", "description", "order", "tags.tag", "lessonlevel", "sections", "user_words", "user_sentences", "flashcards", "unit"], "locales": ["en"]}	[]	2025-06-28 21:34:33.169	2025-06-28 21:34:33.169	\N	\N
212	plugin::content-manager.explorer.update	{}	api::lesson.lesson	{"fields": ["title", "slug", "description", "order", "tags.tag", "lessonlevel", "sections", "user_words", "user_sentences", "flashcards", "unit"], "locales": ["en"]}	[]	2025-06-28 21:34:33.66	2025-06-28 21:34:33.66	\N	\N
269	plugin::content-manager.explorer.update	{}	api::user-sentence.user-sentence	{"fields": ["user", "target_text", "base_text", "lesson"], "locales": ["en"]}	[]	2025-07-01 22:57:34.777	2025-07-01 22:57:34.777	\N	\N
286	plugin::content-manager.explorer.delete	{}	api::vocapage.vocapage	{}	[]	2025-07-06 11:13:58.644	2025-07-06 11:13:58.644	\N	\N
291	plugin::content-manager.explorer.read	{}	api::vocapage.vocapage	{"fields": ["title", "order", "vocabook", "flashcards"]}	[]	2025-07-06 22:49:35.93	2025-07-06 22:49:35.93	\N	\N
292	plugin::content-manager.explorer.update	{}	api::vocapage.vocapage	{"fields": ["title", "order", "vocabook", "flashcards"]}	[]	2025-07-06 22:49:36.105	2025-07-06 22:49:36.105	\N	\N
295	plugin::content-manager.explorer.update	{}	api::user-word.user-word	{"fields": ["user", "target_text", "base_text", "part_of_speech", "lesson", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:14:38.484	2025-07-07 08:14:38.484	\N	\N
303	plugin::content-manager.explorer.read	{}	api::vocabook.vocabook	{"fields": ["title", "user", "vocapages"]}	[]	2025-07-07 08:41:54.812	2025-07-07 08:41:54.812	\N	\N
304	plugin::content-manager.explorer.update	{}	api::vocabook.vocabook	{"fields": ["title", "user", "vocapages"]}	[]	2025-07-07 08:41:54.992	2025-07-07 08:41:54.992	\N	\N
305	plugin::content-manager.explorer.delete	{}	api::vocabook.vocabook	{}	[]	2025-07-07 08:41:55.175	2025-07-07 08:41:55.175	\N	\N
223	plugin::content-manager.explorer.create	{}	api::review-tire.review-tire	{"fields": ["tier", "min_streak", "max_streak", "cooldown_hours", "demote_bar"], "locales": ["en"]}	[]	2025-06-30 17:34:26.351	2025-06-30 17:34:26.351	\N	\N
224	plugin::content-manager.explorer.read	{}	api::review-tire.review-tire	{"fields": ["tier", "min_streak", "max_streak", "cooldown_hours", "demote_bar"], "locales": ["en"]}	[]	2025-06-30 17:34:26.531	2025-06-30 17:34:26.531	\N	\N
225	plugin::content-manager.explorer.update	{}	api::review-tire.review-tire	{"fields": ["tier", "min_streak", "max_streak", "cooldown_hours", "demote_bar"], "locales": ["en"]}	[]	2025-06-30 17:34:26.705	2025-06-30 17:34:26.705	\N	\N
226	plugin::content-manager.explorer.delete	{}	api::review-tire.review-tire	{"locales": ["en"]}	[]	2025-06-30 17:34:26.881	2025-06-30 17:34:26.881	\N	\N
236	plugin::content-manager.explorer.create	{}	api::reviewlog.reviewlog	{"fields": ["user", "reviewed_at", "level", "result", "flashcard"]}	[]	2025-06-30 22:19:36.813	2025-06-30 22:19:36.813	\N	\N
237	plugin::content-manager.explorer.read	{}	api::reviewlog.reviewlog	{"fields": ["user", "reviewed_at", "level", "result", "flashcard"]}	[]	2025-06-30 22:19:37.011	2025-06-30 22:19:37.011	\N	\N
238	plugin::content-manager.explorer.update	{}	api::reviewlog.reviewlog	{"fields": ["user", "reviewed_at", "level", "result", "flashcard"]}	[]	2025-06-30 22:19:37.189	2025-06-30 22:19:37.189	\N	\N
245	plugin::content-manager.explorer.delete	{}	api::user-profile.user-profile	{}	[]	2025-07-01 11:10:40.682	2025-07-01 11:10:40.682	\N	\N
265	plugin::content-manager.explorer.create	{}	api::user-sentence.user-sentence	{"fields": ["user", "target_text", "base_text", "lesson"], "locales": ["en"]}	[]	2025-07-01 22:57:34.079	2025-07-01 22:57:34.079	\N	\N
267	plugin::content-manager.explorer.read	{}	api::user-sentence.user-sentence	{"fields": ["user", "target_text", "base_text", "lesson"], "locales": ["en"]}	[]	2025-07-01 22:57:34.43	2025-07-01 22:57:34.43	\N	\N
290	plugin::content-manager.explorer.create	{}	api::vocapage.vocapage	{"fields": ["title", "order", "vocabook", "flashcards"]}	[]	2025-07-06 22:49:35.75	2025-07-06 22:49:35.75	\N	\N
293	plugin::content-manager.explorer.create	{}	api::user-word.user-word	{"fields": ["user", "target_text", "base_text", "part_of_speech", "lesson", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:14:38.122	2025-07-07 08:14:38.122	\N	\N
294	plugin::content-manager.explorer.read	{}	api::user-word.user-word	{"fields": ["user", "target_text", "base_text", "part_of_speech", "lesson", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:14:38.303	2025-07-07 08:14:38.303	\N	\N
296	plugin::content-manager.explorer.create	{}	api::word.word	{"fields": ["word", "base_text", "instruction", "part_of_speech", "gender", "article", "audio", "tags.tag", "example_sentences", "verb_meta.simple_past", "verb_meta.past_participle", "verb_meta.present_participle", "verb_meta.thirdperson_singular", "verb_meta.auxiliary_verb", "verb_meta.conjugations", "register", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:16:11.362	2025-07-07 08:16:11.362	\N	\N
297	plugin::content-manager.explorer.read	{}	api::word.word	{"fields": ["word", "base_text", "instruction", "part_of_speech", "gender", "article", "audio", "tags.tag", "example_sentences", "verb_meta.simple_past", "verb_meta.past_participle", "verb_meta.present_participle", "verb_meta.thirdperson_singular", "verb_meta.auxiliary_verb", "verb_meta.conjugations", "register", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:16:11.542	2025-07-07 08:16:11.542	\N	\N
298	plugin::content-manager.explorer.update	{}	api::word.word	{"fields": ["word", "base_text", "instruction", "part_of_speech", "gender", "article", "audio", "tags.tag", "example_sentences", "verb_meta.simple_past", "verb_meta.past_participle", "verb_meta.present_participle", "verb_meta.thirdperson_singular", "verb_meta.auxiliary_verb", "verb_meta.conjugations", "register", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:16:11.717	2025-07-07 08:16:11.717	\N	\N
299	plugin::content-manager.explorer.create	{}	api::sentence.sentence	{"fields": ["title", "instruction", "base_text", "target_text", "target_audio", "tags.tag", "words", "register", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:16:56.25	2025-07-07 08:16:56.25	\N	\N
300	plugin::content-manager.explorer.read	{}	api::sentence.sentence	{"fields": ["title", "instruction", "base_text", "target_text", "target_audio", "tags.tag", "words", "register", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:16:56.436	2025-07-07 08:16:56.436	\N	\N
301	plugin::content-manager.explorer.update	{}	api::sentence.sentence	{"fields": ["title", "instruction", "base_text", "target_text", "target_audio", "tags.tag", "words", "register", "exam_base", "exam_target"], "locales": ["en"]}	[]	2025-07-07 08:16:56.622	2025-07-07 08:16:56.622	\N	\N
302	plugin::content-manager.explorer.create	{}	api::vocabook.vocabook	{"fields": ["title", "user", "vocapages"]}	[]	2025-07-07 08:41:54.631	2025-07-07 08:41:54.631	\N	\N
306	plugin::content-manager.explorer.create	{}	api::flashcard.flashcard	{"fields": ["user", "content", "last_reviewed_at", "lesson", "correct_streak", "wrong_streak", "is_remembered", "reviewlogs", "vocapage"], "locales": ["en"]}	[]	2025-07-07 15:47:01.443	2025-07-07 15:47:01.443	\N	\N
307	plugin::content-manager.explorer.read	{}	api::flashcard.flashcard	{"fields": ["user", "content", "last_reviewed_at", "lesson", "correct_streak", "wrong_streak", "is_remembered", "reviewlogs", "vocapage"], "locales": ["en"]}	[]	2025-07-07 15:47:01.621	2025-07-07 15:47:01.621	\N	\N
308	plugin::content-manager.explorer.update	{}	api::flashcard.flashcard	{"fields": ["user", "content", "last_reviewed_at", "lesson", "correct_streak", "wrong_streak", "is_remembered", "reviewlogs", "vocapage"], "locales": ["en"]}	[]	2025-07-07 15:47:01.798	2025-07-07 15:47:01.798	\N	\N
312	plugin::content-manager.explorer.create	{}	api::user-profile.user-profile	{"fields": ["user", "telephone", "baseLanguage"]}	[]	2025-07-08 22:11:55.483	2025-07-08 22:11:55.483	\N	\N
313	plugin::content-manager.explorer.read	{}	api::user-profile.user-profile	{"fields": ["user", "telephone", "baseLanguage"]}	[]	2025-07-08 22:11:55.65	2025-07-08 22:11:55.65	\N	\N
314	plugin::content-manager.explorer.update	{}	api::user-profile.user-profile	{"fields": ["user", "telephone", "baseLanguage"]}	[]	2025-07-08 22:11:55.824	2025-07-08 22:11:55.824	\N	\N
\.


--
-- Data for Name: admin_permissions_role_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
1	1	2	1
2	2	2	2
3	3	2	3
4	4	2	4
5	5	2	5
6	6	2	6
7	7	3	1
8	8	3	2
9	9	3	3
10	10	3	4
11	11	3	5
12	12	3	6
16	16	1	4
17	17	1	5
18	18	1	6
19	19	1	7
20	20	1	8
21	21	1	9
22	22	1	10
23	23	1	11
24	24	1	12
25	25	1	13
26	26	1	14
27	27	1	15
28	28	1	16
29	29	1	17
30	30	1	18
31	31	1	19
32	32	1	20
33	33	1	21
34	34	1	22
35	35	1	23
36	36	1	24
37	37	1	25
38	38	1	26
39	39	1	27
40	40	1	28
41	41	1	29
42	42	1	30
43	43	1	31
44	44	1	32
45	45	1	33
46	46	1	34
47	47	1	35
48	48	1	36
49	49	1	37
50	50	1	38
51	51	1	39
52	52	1	40
53	53	1	41
54	54	1	42
55	55	1	43
56	56	1	44
57	57	1	45
58	58	1	46
59	59	1	47
60	60	1	48
61	61	1	49
62	62	1	50
63	63	1	51
64	64	1	52
65	65	1	53
66	66	1	54
67	67	1	55
68	68	1	56
69	69	1	57
73	73	1	61
182	182	1	143
315	315	1	256
316	316	1	257
317	317	1	258
195	195	1	153
318	318	1	259
319	319	1	260
320	320	1	261
321	321	1	262
97	97	1	79
107	107	1	86
208	208	1	160
210	210	1	162
114	114	1	93
212	212	1	164
214	214	1	165
215	215	1	166
216	216	1	167
134	134	1	95
137	137	1	98
140	140	1	101
142	142	1	103
144	144	1	105
146	146	1	107
148	148	1	109
149	149	1	110
156	156	1	117
172	172	1	133
223	223	1	174
224	224	1	175
225	225	1	176
226	226	1	177
236	236	1	183
237	237	1	184
238	238	1	185
245	245	1	192
265	265	1	212
267	267	1	214
269	269	1	216
286	286	1	233
290	290	1	234
291	291	1	235
292	292	1	236
293	293	1	237
294	294	1	238
295	295	1	239
296	296	1	240
297	297	1	241
298	298	1	242
299	299	1	243
300	300	1	244
301	301	1	245
302	302	1	246
303	303	1	247
304	304	1	248
305	305	1	249
306	306	1	250
307	307	1	251
308	308	1	252
312	312	1	253
313	313	1	254
314	314	1	255
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2025-06-23 17:47:31.167	2025-06-23 17:47:31.167	\N	\N
2	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2025-06-23 17:47:31.342	2025-06-23 17:47:31.342	\N	\N
3	Author	strapi-author	Authors can manage the content they have created.	2025-06-23 17:47:31.49	2025-06-23 17:47:31.49	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	admin	\N	\N	juntjtang@gmail.com	$2a$10$W/oaDMaR7y5Axa0Qmgd/GeGqB2qHDAcIxfy8dGNUmq6Ui3TCRLx9.	7a89489b3298573bc415b3341c1d4a1035556d3e	\N	t	f	\N	2025-06-23 17:50:32.916	2025-07-06 01:04:15.244	\N	\N
\.


--
-- Data for Name: admin_users_roles_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
1	1	1	1	1
\.


--
-- Data for Name: components_a_external_videos; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_external_videos (id, url, caption) FROM stdin;
\.


--
-- Data for Name: components_a_pagebreakers; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_pagebreakers (id, backbutton, nextbutton) FROM stdin;
\.


--
-- Data for Name: components_a_quizzes; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_quizzes (id, question, options, answer, explanation) FROM stdin;
\.


--
-- Data for Name: components_a_sent_refs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_sent_refs (id) FROM stdin;
1
\.


--
-- Data for Name: components_a_sent_refs_sentence_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_sent_refs_sentence_links (id, sent_ref_id, sentence_id) FROM stdin;
1	1	2
\.


--
-- Data for Name: components_a_taglists; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_taglists (id, tag) FROM stdin;
2	do
1	verb
\.


--
-- Data for Name: components_a_user_sent_refs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_user_sent_refs (id) FROM stdin;
1
\.


--
-- Data for Name: components_a_user_sent_refs_user_sentence_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_user_sent_refs_user_sentence_links (id, user_sent_ref_id, user_sentence_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: components_a_user_word_refs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_user_word_refs (id) FROM stdin;
1
2
11
10
9
8
7
6
5
4
3
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
\.


--
-- Data for Name: components_a_user_word_refs_user_word_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_user_word_refs_user_word_links (id, user_word_ref_id, user_word_id) FROM stdin;
1	1	1
2	2	2
3	3	15
4	4	16
5	5	17
6	6	18
7	7	19
8	8	20
9	9	21
10	10	22
11	11	23
12	12	24
13	13	25
14	14	26
15	15	27
16	16	28
17	17	29
18	18	30
19	19	31
20	20	32
21	21	33
22	22	34
23	23	35
24	24	36
25	25	37
26	26	38
27	27	39
28	28	40
29	29	41
30	30	42
31	31	43
32	32	44
33	33	45
34	35	33
35	34	38
36	36	46
37	37	47
38	38	48
39	39	49
40	40	50
41	41	51
42	42	52
43	43	53
44	44	54
45	45	55
46	46	56
47	47	57
48	48	58
49	49	59
50	50	60
51	51	61
52	52	62
53	53	63
54	54	64
55	55	65
56	56	66
57	57	67
58	58	68
59	59	69
60	60	70
61	61	71
62	62	72
63	63	73
64	64	74
65	65	75
66	66	76
67	67	77
68	68	78
69	69	79
70	70	80
71	71	81
72	72	82
73	73	83
74	74	84
75	75	85
76	76	86
77	77	87
78	78	88
79	79	89
80	80	90
81	81	91
82	82	92
83	83	93
84	84	94
85	85	95
86	86	96
87	87	97
88	88	98
89	89	99
90	90	100
91	91	101
92	92	102
93	93	103
94	94	104
95	95	105
96	96	106
97	97	107
98	98	108
99	99	109
100	100	110
101	101	111
102	102	112
103	103	113
104	104	114
105	105	115
106	106	116
107	107	117
108	108	118
109	109	119
110	110	120
111	111	121
112	112	122
113	113	123
114	114	124
115	115	125
116	116	126
117	117	127
118	118	128
119	119	129
120	120	130
121	121	131
122	122	132
123	123	133
124	124	134
125	125	135
126	126	136
127	127	137
\.


--
-- Data for Name: components_a_verb_metas; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_verb_metas (id, simple_past, past_participle, present_participle, thirdperson_singular, auxiliary_verb, conjugations) FROM stdin;
1	did	done	doing	does	have	\N
\.


--
-- Data for Name: components_a_videos; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_videos (id) FROM stdin;
\.


--
-- Data for Name: components_a_word_refs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_word_refs (id) FROM stdin;
2
1
3
4
\.


--
-- Data for Name: components_a_word_refs_word_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.components_a_word_refs_word_links (id, word_ref_id, word_id) FROM stdin;
1	2	1
2	1	2
3	3	2
4	4	3
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: files_folder_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
\.


--
-- Data for Name: files_related_morphs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
\.


--
-- Data for Name: flashcards; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.flashcards (id, created_at, updated_at, created_by_id, updated_by_id, locale, last_reviewed_at, is_remembered, correct_streak, wrong_streak) FROM stdin;
26	2025-07-02 14:06:51.25	2025-07-03 00:10:56.321	\N	\N	en	2025-07-03 00:10:56.154	f	2	0
27	2025-07-02 14:07:30.586	2025-07-03 00:10:58.554	\N	\N	en	2025-07-03 00:10:58.372	f	1	1
28	2025-07-02 14:18:58.472	2025-07-03 00:11:00.844	\N	\N	en	2025-07-03 00:11:00.663	f	2	0
29	2025-07-02 14:39:06.405	2025-07-03 00:19:06.001	\N	\N	en	2025-07-03 00:19:05.825	f	2	0
30	2025-07-02 20:55:27.94	2025-07-03 00:19:14.881	\N	\N	en	2025-07-03 00:19:14.696	f	1	1
15	2025-07-02 00:49:19.437	2025-07-03 00:19:41.7	\N	\N	en	2025-07-03 00:19:41.519	f	2	1
14	2025-07-02 00:46:03.056	2025-07-03 00:19:54.903	\N	1	en	2025-07-03 00:19:54.721	f	3	0
33	2025-07-06 00:30:36.668	2025-07-06 20:49:25.656	\N	\N	en	2025-07-06 20:49:25.462	f	1	0
31	2025-07-03 00:33:13	2025-07-06 21:14:21.543	\N	\N	en	2025-07-06 21:14:21.352	f	1	0
32	2025-07-03 00:34:21.477	2025-07-06 21:14:23.683	\N	\N	en	2025-07-06 21:14:23.498	f	1	0
34	2025-07-06 00:31:27.887	2025-07-06 21:18:27.363	\N	\N	en	2025-07-06 21:18:27.181	f	1	0
35	2025-07-06 00:54:28.143	2025-07-06 21:18:29.085	\N	\N	en	2025-07-06 21:18:28.915	f	1	0
36	2025-07-06 00:54:53.245	2025-07-06 21:26:32.621	\N	\N	en	2025-07-06 21:26:32.362	f	1	0
37	2025-07-06 01:19:02.38	2025-07-06 21:26:35.846	\N	\N	en	2025-07-06 21:26:35.668	f	0	1
13	2025-07-02 00:43:22.852	2025-07-06 21:26:37.79	\N	1	en	2025-07-06 21:26:37.622	f	3	0
20	2025-07-02 12:15:22.24	2025-07-02 23:36:23.781	\N	\N	en	2025-06-22 23:36:23.602	f	1	1
21	2025-07-02 12:32:50.67	2025-07-02 23:36:25.448	\N	\N	en	2025-06-22 23:36:25.275	f	1	1
12	2025-07-02 00:27:11.407	2025-07-06 21:26:40.615	\N	1	en	2025-07-06 21:26:40.437	f	3	0
11	2025-07-02 00:19:46.977	2025-07-06 21:26:42.279	\N	1	en	2025-07-06 21:26:42.11	f	2	0
10	2025-07-02 00:19:27.722	2025-07-06 21:26:43.8	\N	1	en	2025-07-06 21:26:43.632	f	2	0
9	2025-07-02 00:18:17.982	2025-07-06 21:26:53.946	\N	1	en	2025-07-06 21:26:53.778	f	3	0
8	2025-07-02 00:16:17.349	2025-07-06 21:26:56.655	\N	1	en	2025-07-06 21:26:56.484	f	2	0
16	2025-07-02 10:04:23.193	2025-07-06 21:26:58.124	\N	\N	en	2025-07-06 21:26:57.954	f	2	0
38	2025-07-06 21:28:53.219	2025-07-06 21:50:03.169	\N	\N	en	2025-07-06 21:50:02.988	f	1	0
39	2025-07-06 21:49:40.573	2025-07-06 21:50:05.236	\N	\N	en	2025-07-06 21:50:05.056	f	0	1
17	2025-07-02 10:16:30.841	2025-07-06 21:50:06.542	\N	\N	en	2025-07-06 21:50:06.373	f	3	0
18	2025-07-02 10:31:41.445	2025-07-06 21:50:07.863	\N	\N	en	2025-07-06 21:50:07.674	f	2	0
19	2025-07-02 10:32:16.142	2025-07-06 21:50:09.939	\N	\N	en	2025-07-06 21:50:09.757	f	2	0
40	2025-07-07 14:25:52.939	2025-07-07 14:25:52.939	\N	\N	en	\N	f	0	0
41	2025-07-07 14:40:25.851	2025-07-07 14:40:25.851	\N	\N	en	\N	f	0	0
42	2025-07-07 14:43:19.693	2025-07-07 14:43:19.693	\N	\N	en	\N	f	0	0
43	2025-07-07 15:07:10.695	2025-07-07 15:07:11.485	\N	\N	en	\N	f	0	0
44	2025-07-07 15:27:52.291	2025-07-07 15:27:52.742	\N	\N	en	\N	f	0	0
22	2025-07-02 12:37:06.574	2025-07-02 23:36:26.918	\N	\N	en	2025-06-22 23:36:26.747	f	1	1
45	2025-07-07 15:34:26.509	2025-07-07 15:34:26.957	\N	\N	en	\N	f	0	0
46	2025-07-07 15:37:09.202	2025-07-07 15:37:09.639	\N	\N	en	\N	f	0	0
23	2025-07-02 12:40:13.5	2025-07-02 23:36:27.78	\N	\N	en	2025-06-22 23:36:27.621	f	2	0
24	2025-07-02 12:46:07.357	2025-07-02 23:36:29.445	\N	\N	en	2025-06-22 23:36:29.277	f	1	1
25	2025-07-02 12:59:39.843	2025-07-02 23:36:33.103	\N	\N	en	2025-06-22 23:36:32.934	f	2	0
6	2025-07-01 01:10:08.461	2025-07-02 23:36:34.579	1	1	en	2025-06-22 23:36:34.41	f	3	0
4	2025-06-28 22:37:44.743	2025-07-02 23:36:35.637	1	1	en	2025-06-22 23:36:35.467	f	3	0
3	2025-06-28 22:05:43.533	2025-07-02 23:36:37.7	1	1	en	2025-06-22 23:36:37.53	f	3	0
7	2025-07-02 00:08:15.505	2025-07-02 23:40:07.719	\N	1	en	2025-06-22 23:40:07.554	f	1	1
2	2025-06-28 22:05:15.739	2025-07-02 23:44:57.863	1	1	en	2025-06-22 23:44:57.68	f	0	1
50	2025-07-07 15:56:13.37	2025-07-07 15:56:13.814	\N	\N	en	\N	f	0	0
51	2025-07-07 15:57:47.635	2025-07-07 15:57:48.078	\N	\N	en	\N	f	0	0
52	2025-07-07 16:50:32.835	2025-07-07 16:50:32.835	\N	\N	en	\N	f	0	0
53	2025-07-07 16:55:22.4	2025-07-07 16:55:22.4	\N	\N	en	\N	f	0	0
54	2025-07-07 16:59:13.186	2025-07-07 16:59:13.186	\N	\N	en	\N	f	0	0
55	2025-07-07 17:07:18.436	2025-07-07 17:07:18.436	\N	\N	en	\N	f	0	0
56	2025-07-07 17:19:23.797	2025-07-07 17:19:23.797	\N	\N	en	\N	f	0	0
57	2025-07-07 17:32:54.674	2025-07-07 17:32:58.398	\N	\N	en	\N	f	0	0
58	2025-07-07 17:36:38.724	2025-07-07 17:36:39.464	\N	\N	en	\N	f	0	0
59	2025-07-07 17:45:53.697	2025-07-07 17:45:57.052	\N	\N	en	\N	f	0	0
5	2025-06-29 00:21:56.157	2025-07-03 00:01:20.851	1	1	en	2025-07-03 00:01:20.688	f	4	0
1	2025-06-27 09:06:57.998	2025-07-03 00:10:49.637	1	1	en	2025-07-03 00:10:49.446	f	6	1
47	2025-07-07 15:48:22.237	2025-07-07 15:48:22.838	\N	\N	en	\N	f	0	0
48	2025-07-07 15:49:16.501	2025-07-07 15:49:16.978	\N	\N	en	\N	f	0	0
60	2025-07-07 17:54:28.269	2025-07-07 17:54:32.047	\N	\N	en	\N	f	0	0
61	2025-07-07 17:54:29.235	2025-07-07 17:54:32.262	\N	\N	en	\N	f	0	0
62	2025-07-07 17:54:30.398	2025-07-07 17:54:35.589	\N	\N	en	\N	f	0	0
63	2025-07-07 17:54:31.344	2025-07-07 17:54:35.662	\N	\N	en	\N	f	0	0
64	2025-07-07 23:47:04.406	2025-07-07 23:47:08.241	\N	\N	en	\N	f	0	0
65	2025-07-07 23:47:05.401	2025-07-07 23:47:08.812	\N	\N	en	\N	f	0	0
67	2025-07-07 23:47:07.271	2025-07-07 23:47:11.822	\N	\N	en	\N	f	0	0
66	2025-07-07 23:47:06.321	2025-07-07 23:47:12.292	\N	\N	en	\N	f	0	0
69	2025-07-07 23:47:09.191	2025-07-07 23:47:15.295	\N	\N	en	\N	f	0	0
68	2025-07-07 23:47:08.243	2025-07-07 23:47:15.541	\N	\N	en	\N	f	0	0
70	2025-07-07 23:47:10.186	2025-07-07 23:47:21.131	\N	\N	en	\N	f	0	0
71	2025-07-08 00:08:52.693	2025-07-08 00:08:57.325	\N	\N	en	\N	f	0	0
72	2025-07-08 00:08:53.728	2025-07-08 00:08:58.295	\N	\N	en	\N	f	0	0
74	2025-07-08 00:08:55.672	2025-07-08 00:09:01.157	\N	\N	en	\N	f	0	0
73	2025-07-08 00:08:54.748	2025-07-08 00:09:01.742	\N	\N	en	\N	f	0	0
75	2025-07-08 00:08:56.675	2025-07-08 00:09:03.915	\N	\N	en	\N	f	0	0
76	2025-07-08 00:08:57.685	2025-07-08 00:09:04.773	\N	\N	en	\N	f	0	0
77	2025-07-08 00:08:58.657	2025-07-08 00:09:06.908	\N	\N	en	\N	f	0	0
78	2025-07-08 00:08:59.591	2025-07-08 00:09:07.533	\N	\N	en	\N	f	0	0
79	2025-07-08 00:09:00.52	2025-07-08 00:09:10.092	\N	\N	en	\N	f	0	0
80	2025-07-08 00:09:01.463	2025-07-08 00:09:10.247	\N	\N	en	\N	f	0	0
81	2025-07-08 00:09:02.399	2025-07-08 00:09:13.244	\N	\N	en	\N	f	0	0
82	2025-07-08 00:09:03.438	2025-07-08 00:09:13.574	\N	\N	en	\N	f	0	0
83	2025-07-08 00:09:04.462	2025-07-08 00:09:17.006	\N	\N	en	\N	f	0	0
84	2025-07-08 00:09:05.412	2025-07-08 00:09:17.314	\N	\N	en	\N	f	0	0
85	2025-07-08 00:09:27.594	2025-07-08 00:09:30.192	\N	\N	en	\N	f	0	0
86	2025-07-08 00:09:28.558	2025-07-08 00:09:31.985	\N	\N	en	\N	f	0	0
87	2025-07-08 00:09:29.548	2025-07-08 00:09:33.242	\N	\N	en	\N	f	0	0
88	2025-07-08 00:09:30.443	2025-07-08 00:09:35.648	\N	\N	en	\N	f	0	0
89	2025-07-08 00:09:31.381	2025-07-08 00:09:36.134	\N	\N	en	\N	f	0	0
90	2025-07-08 00:09:32.353	2025-07-08 00:09:38.907	\N	\N	en	\N	f	0	0
92	2025-07-08 00:09:34.248	2025-07-08 00:09:41.594	\N	\N	en	\N	f	0	0
93	2025-07-08 00:09:35.199	2025-07-08 00:09:42.916	\N	\N	en	\N	f	0	0
49	2025-07-07 15:52:20.828	2025-07-08 20:53:38.368	\N	\N	en	2025-07-08 20:53:38.172	f	1	0
91	2025-07-08 00:09:33.304	2025-07-08 00:09:38.64	\N	\N	en	\N	f	0	0
94	2025-07-08 00:09:36.192	2025-07-08 00:09:44.994	\N	\N	en	\N	f	0	0
95	2025-07-08 00:09:37.112	2025-07-08 00:09:45.561	\N	\N	en	\N	f	0	0
96	2025-07-08 00:09:38.039	2025-07-08 00:09:47.417	\N	\N	en	\N	f	0	0
97	2025-07-08 00:09:39.008	2025-07-08 00:09:48.059	\N	\N	en	\N	f	0	0
98	2025-07-08 00:09:39.931	2025-07-08 00:09:50.957	\N	\N	en	\N	f	0	0
99	2025-07-08 00:10:41.741	2025-07-08 00:10:44.706	\N	\N	en	\N	f	0	0
100	2025-07-08 00:13:06.936	2025-07-08 00:13:10.387	\N	\N	en	\N	f	0	0
101	2025-07-08 00:13:07.875	2025-07-08 00:13:11.52	\N	\N	en	\N	f	0	0
102	2025-07-08 00:13:08.835	2025-07-08 00:13:12.949	\N	\N	en	\N	f	0	0
103	2025-07-08 00:13:09.818	2025-07-08 00:13:15.06	\N	\N	en	\N	f	0	0
104	2025-07-08 00:13:10.828	2025-07-08 00:13:15.802	\N	\N	en	\N	f	0	0
105	2025-07-08 00:13:11.798	2025-07-08 00:13:18.317	\N	\N	en	\N	f	0	0
106	2025-07-08 00:13:12.757	2025-07-08 00:13:19.502	\N	\N	en	\N	f	0	0
107	2025-07-08 00:13:13.738	2025-07-08 00:13:21.075	\N	\N	en	\N	f	0	0
108	2025-07-08 00:13:14.691	2025-07-08 00:13:23.911	\N	\N	en	\N	f	0	0
109	2025-07-08 00:13:15.642	2025-07-08 00:13:24.091	\N	\N	en	\N	f	0	0
110	2025-07-08 00:13:16.602	2025-07-08 00:13:27.223	\N	\N	en	\N	f	0	0
111	2025-07-08 00:13:17.575	2025-07-08 00:13:27.591	\N	\N	en	\N	f	0	0
112	2025-07-08 00:13:18.591	2025-07-08 00:13:30.354	\N	\N	en	\N	f	0	0
113	2025-07-08 00:13:19.565	2025-07-08 00:13:30.746	\N	\N	en	\N	f	0	0
114	2025-07-08 00:13:20.543	2025-07-08 00:13:33.224	\N	\N	en	\N	f	0	0
115	2025-07-08 00:13:21.48	2025-07-08 00:13:34.852	\N	\N	en	\N	f	0	0
116	2025-07-08 00:13:22.44	2025-07-08 00:13:36.812	\N	\N	en	\N	f	0	0
117	2025-07-08 00:13:23.373	2025-07-08 00:13:37.467	\N	\N	en	\N	f	0	0
118	2025-07-08 00:13:24.412	2025-07-08 00:13:39.982	\N	\N	en	\N	f	0	0
119	2025-07-08 00:13:25.381	2025-07-08 00:13:41.376	\N	\N	en	\N	f	0	0
120	2025-07-08 00:13:26.375	2025-07-08 00:13:43.96	\N	\N	en	\N	f	0	0
121	2025-07-08 00:13:27.288	2025-07-08 00:13:44.774	\N	\N	en	\N	f	0	0
123	2025-07-08 00:13:29.164	2025-07-08 00:13:48.355	\N	\N	en	\N	f	0	0
122	2025-07-08 00:13:28.193	2025-07-08 00:13:48.984	\N	\N	en	\N	f	0	0
124	2025-07-08 00:13:30.091	2025-07-08 00:13:52.591	\N	\N	en	\N	f	0	0
125	2025-07-08 00:13:31.045	2025-07-08 00:13:52.968	\N	\N	en	\N	f	0	0
126	2025-07-08 00:13:32.037	2025-07-08 00:13:55.483	\N	\N	en	\N	f	0	0
127	2025-07-08 00:13:32.974	2025-07-08 00:13:56.168	\N	\N	en	\N	f	0	0
128	2025-07-08 00:13:33.977	2025-07-08 00:13:58.355	\N	\N	en	\N	f	0	0
129	2025-07-08 00:13:34.946	2025-07-08 00:13:59.534	\N	\N	en	\N	f	0	0
\.


--
-- Data for Name: flashcards_components; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.flashcards_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
36	1	1	a.user-word-ref	content	1
37	3	3	a.word-ref	content	1
38	4	1	a.sent-ref	content	1
39	5	4	a.word-ref	content	1
40	6	2	a.user-word-ref	content	1
49	15	11	a.user-word-ref	content	1
50	14	10	a.user-word-ref	content	1
51	13	9	a.user-word-ref	content	1
52	12	8	a.user-word-ref	content	1
53	11	7	a.user-word-ref	content	1
54	10	6	a.user-word-ref	content	1
55	9	5	a.user-word-ref	content	1
56	8	4	a.user-word-ref	content	1
57	7	3	a.user-word-ref	content	1
58	16	12	a.user-word-ref	content	1
59	17	13	a.user-word-ref	content	1
60	18	14	a.user-word-ref	content	1
61	19	15	a.user-word-ref	content	1
62	20	16	a.user-word-ref	content	1
63	21	17	a.user-word-ref	content	1
64	22	18	a.user-word-ref	content	1
65	23	19	a.user-word-ref	content	1
66	24	20	a.user-word-ref	content	1
67	25	21	a.user-word-ref	content	1
68	26	22	a.user-word-ref	content	1
69	27	23	a.user-word-ref	content	1
70	28	24	a.user-word-ref	content	1
71	29	25	a.user-word-ref	content	1
72	30	26	a.user-word-ref	content	1
74	2	1	a.user-sent-ref	content	1
75	31	27	a.user-word-ref	content	1
76	32	28	a.user-word-ref	content	1
77	33	29	a.user-word-ref	content	1
78	34	30	a.user-word-ref	content	1
79	35	31	a.user-word-ref	content	1
80	36	32	a.user-word-ref	content	1
81	37	33	a.user-word-ref	content	1
82	38	36	a.user-word-ref	content	1
83	39	37	a.user-word-ref	content	1
84	40	38	a.user-word-ref	content	1
85	41	39	a.user-word-ref	content	1
86	42	40	a.user-word-ref	content	1
87	43	41	a.user-word-ref	content	1
88	44	42	a.user-word-ref	content	1
89	45	43	a.user-word-ref	content	1
90	46	44	a.user-word-ref	content	1
91	47	45	a.user-word-ref	content	1
92	48	46	a.user-word-ref	content	1
93	49	47	a.user-word-ref	content	1
94	50	48	a.user-word-ref	content	1
95	51	49	a.user-word-ref	content	1
96	52	50	a.user-word-ref	content	1
97	53	51	a.user-word-ref	content	1
98	54	52	a.user-word-ref	content	1
99	55	53	a.user-word-ref	content	1
100	56	54	a.user-word-ref	content	1
101	57	55	a.user-word-ref	content	1
102	58	56	a.user-word-ref	content	1
103	59	57	a.user-word-ref	content	1
104	60	58	a.user-word-ref	content	1
105	61	59	a.user-word-ref	content	1
106	62	60	a.user-word-ref	content	1
107	63	61	a.user-word-ref	content	1
108	64	62	a.user-word-ref	content	1
109	65	63	a.user-word-ref	content	1
110	66	64	a.user-word-ref	content	1
111	67	65	a.user-word-ref	content	1
112	68	66	a.user-word-ref	content	1
113	69	67	a.user-word-ref	content	1
114	70	68	a.user-word-ref	content	1
115	71	69	a.user-word-ref	content	1
116	72	70	a.user-word-ref	content	1
117	73	71	a.user-word-ref	content	1
118	74	72	a.user-word-ref	content	1
119	75	73	a.user-word-ref	content	1
120	76	74	a.user-word-ref	content	1
121	77	75	a.user-word-ref	content	1
122	78	76	a.user-word-ref	content	1
123	79	77	a.user-word-ref	content	1
124	80	78	a.user-word-ref	content	1
125	81	79	a.user-word-ref	content	1
126	82	80	a.user-word-ref	content	1
127	83	81	a.user-word-ref	content	1
128	84	82	a.user-word-ref	content	1
129	85	83	a.user-word-ref	content	1
130	86	84	a.user-word-ref	content	1
131	87	85	a.user-word-ref	content	1
132	88	86	a.user-word-ref	content	1
133	89	87	a.user-word-ref	content	1
134	90	88	a.user-word-ref	content	1
135	91	89	a.user-word-ref	content	1
136	92	90	a.user-word-ref	content	1
137	93	91	a.user-word-ref	content	1
138	94	92	a.user-word-ref	content	1
139	95	93	a.user-word-ref	content	1
140	96	94	a.user-word-ref	content	1
141	97	95	a.user-word-ref	content	1
142	98	96	a.user-word-ref	content	1
143	99	97	a.user-word-ref	content	1
144	100	98	a.user-word-ref	content	1
145	101	99	a.user-word-ref	content	1
146	102	100	a.user-word-ref	content	1
147	103	101	a.user-word-ref	content	1
148	104	102	a.user-word-ref	content	1
149	105	103	a.user-word-ref	content	1
150	106	104	a.user-word-ref	content	1
151	107	105	a.user-word-ref	content	1
152	108	106	a.user-word-ref	content	1
153	109	107	a.user-word-ref	content	1
154	110	108	a.user-word-ref	content	1
155	111	109	a.user-word-ref	content	1
156	112	110	a.user-word-ref	content	1
157	113	111	a.user-word-ref	content	1
158	114	112	a.user-word-ref	content	1
159	115	113	a.user-word-ref	content	1
161	117	115	a.user-word-ref	content	1
162	118	116	a.user-word-ref	content	1
163	119	117	a.user-word-ref	content	1
164	120	118	a.user-word-ref	content	1
165	121	119	a.user-word-ref	content	1
168	124	122	a.user-word-ref	content	1
169	125	123	a.user-word-ref	content	1
171	127	125	a.user-word-ref	content	1
172	128	126	a.user-word-ref	content	1
173	129	127	a.user-word-ref	content	1
160	116	114	a.user-word-ref	content	1
166	122	120	a.user-word-ref	content	1
167	123	121	a.user-word-ref	content	1
170	126	124	a.user-word-ref	content	1
\.


--
-- Data for Name: flashcards_lesson_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.flashcards_lesson_links (id, flashcard_id, lesson_id, flashcard_order) FROM stdin;
1	5	1	1
\.


--
-- Data for Name: flashcards_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.flashcards_localizations_links (id, flashcard_id, inv_flashcard_id, flashcard_order) FROM stdin;
\.


--
-- Data for Name: flashcards_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.flashcards_user_links (id, flashcard_id, user_id, flashcard_order) FROM stdin;
2	1	8	1
3	2	8	2
4	3	8	3
5	4	8	4
6	5	8	5
7	6	8	6
8	7	8	7
9	8	8	8
10	9	8	9
11	10	8	10
12	11	8	11
13	12	8	12
14	13	8	13
15	14	8	14
16	15	8	15
17	16	8	16
18	17	8	17
19	18	8	18
20	19	8	19
21	20	8	20
22	21	8	21
23	22	8	22
24	23	8	23
25	24	8	24
26	25	8	25
27	26	8	26
28	27	8	27
29	28	8	28
30	29	8	29
31	30	8	30
32	31	8	31
33	32	8	32
34	33	8	33
35	34	8	34
36	35	8	35
37	36	8	36
38	37	8	37
39	38	8	38
40	39	8	39
41	40	8	40
42	41	29	1
43	42	8	41
44	43	8	42
45	44	8	43
46	45	8	44
47	46	30	1
48	47	30	2
49	48	30	3
50	49	30	4
51	50	30	5
52	51	30	6
53	52	30	7
54	53	30	8
55	54	30	9
56	55	30	10
57	56	30	11
58	57	30	12
59	58	30	13
60	59	30	14
61	60	30	15
62	61	30	16
63	62	30	17
64	63	30	18
65	64	30	19
66	65	30	20
67	66	30	21
68	67	30	22
69	68	30	23
70	69	30	24
71	70	30	25
72	71	30	26
73	72	30	27
74	73	30	28
75	74	30	29
76	75	30	30
77	76	30	31
78	77	30	32
79	78	30	33
80	79	30	34
81	80	30	35
82	81	30	36
83	82	30	37
84	83	30	38
85	84	30	39
86	85	30	40
87	86	30	41
88	87	30	42
89	88	30	43
90	89	30	44
91	90	30	45
92	91	30	46
93	92	30	47
94	93	30	48
95	94	30	49
96	95	30	50
97	96	30	51
98	97	30	52
99	98	30	53
100	99	30	54
101	100	30	55
102	101	30	56
103	102	30	57
104	103	30	58
105	104	30	59
106	105	30	60
107	106	30	61
108	107	30	62
109	108	30	63
110	109	30	64
111	110	30	65
112	111	30	66
113	112	30	67
114	113	30	68
115	114	30	69
116	115	30	70
117	116	30	71
118	117	30	72
119	118	30	73
120	119	30	74
121	120	30	75
122	121	30	76
123	122	30	77
124	123	30	78
125	124	30	79
126	125	30	80
127	126	30	81
128	127	30	82
129	128	30	83
130	129	30	84
\.


--
-- Data for Name: flashcards_vocapage_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.flashcards_vocapage_links (id, flashcard_id, vocapage_id, flashcard_order) FROM stdin;
1	47	4	1
2	48	4	2
3	49	4	3
4	50	4	4
5	51	4	5
6	57	4	6
7	58	4	7
8	59	4	8
9	60	4	9
10	61	4	10
11	62	4	11
12	63	4	12
13	64	4	13
14	65	4	14
15	67	4	15
16	66	4	16
17	69	4	17
18	68	4	18
19	70	4	19
20	71	4	20
21	72	4	21
22	74	4	22
23	73	4	23
24	75	4	24
25	76	4	25
26	77	4	26
27	78	4	27
28	79	4	28
29	80	4	29
112	90	5	23
113	89	5	22
62	113	4	62
63	114	4	63
64	115	4	64
65	116	4	65
66	117	4	66
67	118	4	67
68	119	4	68
84	124	1	9
86	122	1	8
87	121	1	7
88	120	1	6
79	129	1	5
80	128	1	4
81	127	1	3
82	126	1	2
83	125	1	1
102	100	1	19
103	99	1	18
104	98	1	17
105	97	1	16
106	96	1	15
107	95	1	14
108	94	1	13
109	93	1	12
110	92	1	11
111	91	1	10
114	88	5	21
115	87	5	20
116	86	5	19
117	85	5	18
118	84	5	17
119	83	5	16
120	82	5	15
121	81	5	14
89	123	5	4
90	112	5	3
91	111	5	2
92	110	5	1
93	109	5	13
94	108	5	12
95	107	5	11
96	106	5	10
97	105	5	9
98	104	5	8
99	103	5	7
100	102	5	6
101	101	5	5
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	English (en)	en	2025-06-23 17:47:30.813	2025-06-23 17:47:30.813	\N	\N
\.


--
-- Data for Name: lessonlevels; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.lessonlevels (id, level, created_at, updated_at, created_by_id, updated_by_id, description) FROM stdin;
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.lessons (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
1	Lesson 1 Hello	lesson-1-hello	\N	1	2025-06-24 00:39:20.695	2025-06-24 00:39:20.695	1	1	en
\.


--
-- Data for Name: lessons_components; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.lessons_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
\.


--
-- Data for Name: lessons_lessonlevel_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.lessons_lessonlevel_links (id, lesson_id, lessonlevel_id, lesson_order) FROM stdin;
\.


--
-- Data for Name: lessons_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.lessons_localizations_links (id, lesson_id, inv_lesson_id, lesson_order) FROM stdin;
\.


--
-- Data for Name: lessons_unit_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.lessons_unit_links (id, lesson_id, unit_id, lesson_order) FROM stdin;
\.


--
-- Data for Name: review_tires; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.review_tires (id, tier, min_streak, max_streak, cooldown_hours, demote_bar, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
2	warmup	4	6	24	2	2025-06-30 17:35:20.03	2025-06-30 17:35:20.03	1	1	en
3	weekly	7	8	168	2	2025-06-30 17:35:38.495	2025-06-30 17:35:38.495	1	1	en
4	monthly	9	10	720	2	2025-06-30 17:35:55.31	2025-06-30 17:35:55.31	1	1	en
5	remembered	11	10000000	1000000	1	2025-06-30 17:36:31.912	2025-06-30 17:36:31.912	1	1	en
1	new	0	3	6	2	2025-06-30 17:35:06.322	2025-07-01 09:47:07.983	1	1	en
\.


--
-- Data for Name: review_tires_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.review_tires_localizations_links (id, review_tire_id, inv_review_tire_id, review_tire_order) FROM stdin;
\.


--
-- Data for Name: reviewlogs; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.reviewlogs (id, level, result, created_at, updated_at, created_by_id, updated_by_id, reviewed_at) FROM stdin;
1	\N	correct	2025-06-29 23:45:39.181	2025-06-29 23:45:39.181	\N	\N	\N
2	\N	wrong	2025-06-29 23:46:42.33	2025-06-29 23:46:42.33	\N	\N	\N
3	\N	correct	2025-06-30 00:33:54.595	2025-06-30 00:33:54.595	\N	\N	\N
4	\N	correct	2025-06-30 00:33:58.297	2025-06-30 00:33:58.297	\N	\N	\N
5	\N	correct	2025-06-30 00:34:09.456	2025-06-30 00:34:09.456	\N	\N	\N
6	\N	correct	2025-06-30 00:38:15.343	2025-06-30 00:38:15.343	\N	\N	\N
7	\N	correct	2025-06-30 00:38:24.05	2025-06-30 00:38:24.05	\N	\N	\N
8	\N	correct	2025-06-30 00:38:55.671	2025-06-30 00:38:55.671	\N	\N	\N
9	\N	correct	2025-06-30 01:05:41.325	2025-06-30 01:05:41.325	\N	\N	\N
10	\N	correct	2025-06-30 01:05:44.002	2025-06-30 01:05:44.002	\N	\N	\N
11	\N	correct	2025-06-30 01:05:48.899	2025-06-30 01:05:48.899	\N	\N	\N
12	\N	correct	2025-06-30 01:05:50.211	2025-06-30 01:05:50.211	\N	\N	\N
13	\N	correct	2025-06-30 01:05:51.145	2025-06-30 01:05:51.145	\N	\N	\N
14	\N	wrong	2025-06-30 01:05:52.263	2025-06-30 01:05:52.263	\N	\N	\N
15	\N	wrong	2025-06-30 01:05:53.213	2025-06-30 01:05:53.213	\N	\N	\N
16	\N	correct	2025-06-30 14:39:14.638	2025-06-30 14:39:14.638	\N	\N	\N
17	\N	correct	2025-06-30 14:40:09.248	2025-06-30 14:40:09.248	\N	\N	\N
18	\N	correct	2025-06-30 14:41:05.651	2025-06-30 14:41:05.651	\N	\N	\N
19	\N	correct	2025-06-30 17:40:55.016	2025-06-30 17:40:55.016	\N	\N	\N
20	daily	correct	2025-06-30 17:59:47.599	2025-06-30 17:59:47.599	\N	\N	\N
21	daily	correct	2025-06-30 18:00:16.89	2025-06-30 18:00:16.89	\N	\N	\N
22	daily	correct	2025-06-30 18:01:31.731	2025-06-30 18:01:31.731	\N	\N	\N
23	daily	wrong	2025-06-30 18:03:48.8	2025-06-30 18:03:48.8	\N	\N	\N
24	daily	wrong	2025-06-30 18:06:02.147	2025-06-30 18:06:02.147	\N	\N	\N
25	monthly	wrong	2025-06-30 18:07:09.735	2025-06-30 18:07:09.735	\N	\N	\N
26	weekly	correct	2025-06-30 18:07:36.32	2025-06-30 18:07:36.32	\N	\N	\N
27	weekly	correct	2025-06-30 18:08:09.637	2025-06-30 18:08:09.637	\N	\N	\N
28	weekly	correct	2025-06-30 18:10:15.203	2025-06-30 18:10:15.203	\N	\N	\N
29	weekly	correct	2025-06-30 22:11:07.976	2025-06-30 22:11:07.976	\N	\N	\N
30	weekly	correct	2025-06-30 22:11:40.566	2025-06-30 22:11:40.566	\N	\N	\N
31	weekly	correct	2025-06-30 22:23:20.279	2025-06-30 22:23:20.279	\N	\N	2025-06-30 22:23:20.279
32	weekly	correct	2025-06-30 22:24:12.152	2025-06-30 22:24:12.152	\N	\N	2025-06-30 22:24:12.151
33	\N	correct	2025-06-30 22:25:07.108	2025-06-30 22:25:07.108	\N	\N	\N
34	daily	correct	2025-06-30 23:22:26.417	2025-06-30 23:22:26.417	\N	\N	2025-06-30 23:22:26.416
35	daily	wrong	2025-06-30 23:22:35.349	2025-06-30 23:22:35.349	\N	\N	2025-06-30 23:22:35.349
36	daily	correct	2025-06-30 23:22:43.093	2025-06-30 23:22:43.093	\N	\N	2025-06-30 23:22:43.093
37	daily	wrong	2025-06-30 23:22:45.247	2025-06-30 23:22:45.247	\N	\N	2025-06-30 23:22:45.247
38	weekly	correct	2025-06-30 23:22:46.885	2025-06-30 23:22:46.885	\N	\N	2025-06-30 23:22:46.884
39	daily	correct	2025-06-30 23:24:57.039	2025-06-30 23:24:57.039	\N	\N	2025-06-30 23:24:57.038
40	daily	correct	2025-06-30 23:25:14.963	2025-06-30 23:25:14.963	\N	\N	2025-06-30 23:25:14.962
41	daily	correct	2025-06-30 23:25:25.102	2025-06-30 23:25:25.102	\N	\N	2025-06-30 23:25:25.102
42	daily	correct	2025-06-30 23:25:32.216	2025-06-30 23:25:32.216	\N	\N	2025-06-30 23:25:32.215
43	daily	correct	2025-06-30 23:25:38.957	2025-06-30 23:25:38.957	\N	\N	2025-06-30 23:25:38.956
44	daily	correct	2025-06-30 23:26:47.159	2025-06-30 23:26:47.159	\N	\N	2025-06-30 23:26:47.158
45	daily	correct	2025-06-30 23:27:02.771	2025-06-30 23:27:02.771	\N	\N	2025-06-30 23:27:02.771
46	daily	correct	2025-06-30 23:27:04.955	2025-06-30 23:27:04.955	\N	\N	2025-06-30 23:27:04.955
47	daily	wrong	2025-06-30 23:27:07.798	2025-06-30 23:27:07.798	\N	\N	2025-06-30 23:27:07.798
48	daily	correct	2025-06-30 23:27:09.315	2025-06-30 23:27:09.315	\N	\N	2025-06-30 23:27:09.315
49	weekly	wrong	2025-06-30 23:30:00.633	2025-06-30 23:30:00.633	\N	\N	2025-06-30 23:30:00.633
50	\N	wrong	2025-06-30 23:30:01.952	2025-06-30 23:30:01.952	\N	\N	2025-06-30 23:30:01.952
51	daily	wrong	2025-06-30 23:30:02.626	2025-06-30 23:30:02.626	\N	\N	2025-06-30 23:30:02.626
52	daily	wrong	2025-06-30 23:30:03.264	2025-06-30 23:30:03.264	\N	\N	2025-06-30 23:30:03.263
53	monthly	wrong	2025-06-30 23:30:03.974	2025-06-30 23:30:03.974	\N	\N	2025-06-30 23:30:03.974
54	\N	wrong	2025-06-30 23:30:39.645	2025-06-30 23:30:39.645	\N	\N	2025-06-30 23:30:39.645
55	\N	wrong	2025-06-30 23:32:06.414	2025-06-30 23:32:06.414	\N	\N	2025-06-30 23:32:06.414
56	weekly	wrong	2025-06-30 23:32:07.63	2025-06-30 23:32:07.63	\N	\N	2025-06-30 23:32:07.629
57	daily	wrong	2025-06-30 23:32:08.286	2025-06-30 23:32:08.286	\N	\N	2025-06-30 23:32:08.286
58	daily	wrong	2025-06-30 23:32:08.972	2025-06-30 23:32:08.972	\N	\N	2025-06-30 23:32:08.972
59	monthly	wrong	2025-06-30 23:32:12.579	2025-06-30 23:32:12.579	\N	\N	2025-06-30 23:32:12.579
60	daily	wrong	2025-06-30 23:34:43.089	2025-06-30 23:34:43.089	\N	\N	2025-06-30 23:34:43.088
61	monthly	wrong	2025-06-30 23:34:51.69	2025-06-30 23:34:51.69	\N	\N	2025-06-30 23:34:51.69
62	\N	wrong	2025-06-30 23:34:59.041	2025-06-30 23:34:59.041	\N	\N	2025-06-30 23:34:59.041
63	daily	wrong	2025-06-30 23:35:08.125	2025-06-30 23:35:08.125	\N	\N	2025-06-30 23:35:08.125
64	daily	wrong	2025-06-30 23:35:14.882	2025-06-30 23:35:14.882	\N	\N	2025-06-30 23:35:14.882
65	new	correct	2025-07-01 10:13:35.578	2025-07-01 10:13:35.578	\N	\N	2025-07-01 10:13:35.576
66	weekly	wrong	2025-07-01 10:13:38.141	2025-07-01 10:13:38.141	\N	\N	2025-07-01 10:13:38.14
67	new	correct	2025-07-01 10:18:23.901	2025-07-01 10:18:23.901	\N	\N	2025-07-01 10:18:23.9
68	warmup	correct	2025-07-01 10:18:26.614	2025-07-01 10:18:26.614	\N	\N	2025-07-01 10:18:26.614
69	new	correct	2025-07-01 10:18:28.044	2025-07-01 10:18:28.044	\N	\N	2025-07-01 10:18:28.043
70	new	correct	2025-07-02 13:59:57.093	2025-07-02 13:59:57.093	\N	\N	2025-07-02 13:59:57.093
71	new	correct	2025-07-02 14:00:00.441	2025-07-02 14:00:00.441	\N	\N	2025-07-02 14:00:00.441
72	new	correct	2025-07-02 14:00:04.155	2025-07-02 14:00:04.155	\N	\N	2025-07-02 14:00:04.155
73	new	correct	2025-07-02 14:00:06.958	2025-07-02 14:00:06.958	\N	\N	2025-07-02 14:00:06.958
74	new	correct	2025-07-02 14:00:09.129	2025-07-02 14:00:09.129	\N	\N	2025-07-02 14:00:09.129
75	new	correct	2025-07-02 14:00:11.255	2025-07-02 14:00:11.255	\N	\N	2025-07-02 14:00:11.255
76	new	correct	2025-07-02 14:00:14.148	2025-07-02 14:00:14.148	\N	\N	2025-07-02 14:00:14.148
77	new	correct	2025-07-02 14:00:16.387	2025-07-02 14:00:16.387	\N	\N	2025-07-02 14:00:16.386
78	new	correct	2025-07-02 14:00:18.3	2025-07-02 14:00:18.3	\N	\N	2025-07-02 14:00:18.3
79	new	correct	2025-07-02 14:00:20.175	2025-07-02 14:00:20.175	\N	\N	2025-07-02 14:00:20.174
80	new	correct	2025-07-02 14:00:22.421	2025-07-02 14:00:22.421	\N	\N	2025-07-02 14:00:22.421
81	new	correct	2025-07-02 14:00:24.658	2025-07-02 14:00:24.658	\N	\N	2025-07-02 14:00:24.658
82	new	correct	2025-07-02 14:00:29.974	2025-07-02 14:00:29.974	\N	\N	2025-07-02 14:00:29.974
83	new	correct	2025-07-02 14:00:32.501	2025-07-02 14:00:32.501	\N	\N	2025-07-02 14:00:32.501
84	new	correct	2025-07-02 14:00:34.919	2025-07-02 14:00:34.919	\N	\N	2025-07-02 14:00:34.919
85	new	correct	2025-07-02 14:00:37.402	2025-07-02 14:00:37.402	\N	\N	2025-07-02 14:00:37.402
86	new	correct	2025-07-02 14:00:38.909	2025-07-02 14:00:38.909	\N	\N	2025-07-02 14:00:38.909
87	new	correct	2025-07-02 14:00:41.104	2025-07-02 14:00:41.104	\N	\N	2025-07-02 14:00:41.104
88	new	correct	2025-07-02 14:00:43.215	2025-07-02 14:00:43.215	\N	\N	2025-07-02 14:00:43.215
89	new	correct	2025-07-02 14:00:45.289	2025-07-02 14:00:45.289	\N	\N	2025-07-02 14:00:45.289
90	new	correct	2025-07-02 14:00:47.883	2025-07-02 14:00:47.883	\N	\N	2025-07-02 14:00:47.883
91	warmup	correct	2025-07-02 14:00:49.719	2025-07-02 14:00:49.719	\N	\N	2025-07-02 14:00:49.719
92	new	correct	2025-07-02 14:00:52.216	2025-07-02 14:00:52.216	\N	\N	2025-07-02 14:00:52.215
93	new	correct	2025-07-02 23:35:49.368	2025-07-02 23:35:49.368	\N	\N	2025-07-02 23:35:49.368
94	new	correct	2025-07-02 23:35:52.72	2025-07-02 23:35:52.72	\N	\N	2025-07-02 23:35:52.72
95	new	correct	2025-07-02 23:35:54.934	2025-07-02 23:35:54.934	\N	\N	2025-07-02 23:35:54.933
96	new	correct	2025-07-02 23:35:57.195	2025-07-02 23:35:57.195	\N	\N	2025-07-02 23:35:57.195
97	new	correct	2025-07-02 23:35:59.482	2025-07-02 23:35:59.482	\N	\N	2025-07-02 23:35:59.482
98	new	correct	2025-07-02 23:36:01.717	2025-07-02 23:36:01.717	\N	\N	2025-07-02 23:36:01.716
99	new	correct	2025-07-02 23:36:03.703	2025-07-02 23:36:03.703	\N	\N	2025-07-02 23:36:03.702
100	new	correct	2025-07-02 23:36:06.268	2025-07-02 23:36:06.268	\N	\N	2025-07-02 23:36:06.268
101	new	correct	2025-07-02 23:36:09.239	2025-07-02 23:36:09.239	\N	\N	2025-07-02 23:36:09.239
102	new	wrong	2025-07-02 23:36:10.407	2025-07-02 23:36:10.407	\N	\N	2025-07-02 23:36:10.407
103	new	wrong	2025-07-02 23:36:12.458	2025-07-02 23:36:12.458	\N	\N	2025-07-02 23:36:12.458
104	new	correct	2025-07-02 23:36:13.96	2025-07-02 23:36:13.96	\N	\N	2025-07-02 23:36:13.96
105	new	wrong	2025-07-02 23:36:16.053	2025-07-02 23:36:16.053	\N	\N	2025-07-02 23:36:16.053
106	new	wrong	2025-07-02 23:36:16.129	2025-07-02 23:36:16.129	\N	\N	2025-07-02 23:36:16.129
107	new	wrong	2025-07-02 23:36:17.438	2025-07-02 23:36:17.438	\N	\N	2025-07-02 23:36:17.438
108	new	correct	2025-07-02 23:36:18.742	2025-07-02 23:36:18.742	\N	\N	2025-07-02 23:36:18.741
109	new	wrong	2025-07-02 23:36:19.575	2025-07-02 23:36:19.575	\N	\N	2025-07-02 23:36:19.575
110	new	wrong	2025-07-02 23:36:21.772	2025-07-02 23:36:21.772	\N	\N	2025-07-02 23:36:21.772
111	new	wrong	2025-07-02 23:36:23.602	2025-07-02 23:36:23.602	\N	\N	2025-07-02 23:36:23.602
112	new	wrong	2025-07-02 23:36:25.275	2025-07-02 23:36:25.275	\N	\N	2025-07-02 23:36:25.275
113	new	wrong	2025-07-02 23:36:26.747	2025-07-02 23:36:26.747	\N	\N	2025-07-02 23:36:26.747
114	new	correct	2025-07-02 23:36:27.621	2025-07-02 23:36:27.621	\N	\N	2025-07-02 23:36:27.621
115	new	wrong	2025-07-02 23:36:29.277	2025-07-02 23:36:29.277	\N	\N	2025-07-02 23:36:29.277
116	new	correct	2025-07-02 23:36:32.934	2025-07-02 23:36:32.934	\N	\N	2025-07-02 23:36:32.934
117	new	correct	2025-07-02 23:36:34.41	2025-07-02 23:36:34.41	\N	\N	2025-07-02 23:36:34.41
118	new	correct	2025-07-02 23:36:35.468	2025-07-02 23:36:35.468	\N	\N	2025-07-02 23:36:35.467
119	new	correct	2025-07-02 23:36:37.53	2025-07-02 23:36:37.53	\N	\N	2025-07-02 23:36:37.53
120	new	wrong	2025-07-02 23:40:07.554	2025-07-02 23:40:07.554	\N	\N	2025-07-02 23:40:07.554
121	new	wrong	2025-07-02 23:44:57.68	2025-07-02 23:44:57.68	\N	\N	2025-07-02 23:44:57.68
122	new	wrong	2025-07-02 23:45:05.15	2025-07-02 23:45:05.15	\N	\N	2025-07-02 23:45:05.15
123	weekly	wrong	2025-07-03 00:01:20.688	2025-07-03 00:01:20.688	\N	\N	2025-07-03 00:01:20.688
124	warmup	wrong	2025-07-03 00:10:49.446	2025-07-03 00:10:49.446	\N	\N	2025-07-03 00:10:49.446
125	new	correct	2025-07-03 00:10:56.154	2025-07-03 00:10:56.154	\N	\N	2025-07-03 00:10:56.154
126	new	wrong	2025-07-03 00:10:58.372	2025-07-03 00:10:58.372	\N	\N	2025-07-03 00:10:58.372
127	new	correct	2025-07-03 00:11:00.663	2025-07-03 00:11:00.663	\N	\N	2025-07-03 00:11:00.663
128	new	correct	2025-07-03 00:19:05.825	2025-07-03 00:19:05.825	\N	\N	2025-07-03 00:19:05.825
129	new	wrong	2025-07-03 00:19:14.696	2025-07-03 00:19:14.696	\N	\N	2025-07-03 00:19:14.696
130	new	wrong	2025-07-03 00:19:41.519	2025-07-03 00:19:41.519	\N	\N	2025-07-03 00:19:41.519
131	new	correct	2025-07-03 00:19:54.721	2025-07-03 00:19:54.721	\N	\N	2025-07-03 00:19:54.721
132	new	correct	2025-07-06 20:49:25.462	2025-07-06 20:49:25.462	\N	\N	2025-07-06 20:49:25.462
133	new	correct	2025-07-06 20:49:33.798	2025-07-06 20:49:33.798	\N	\N	2025-07-06 20:49:33.797
134	new	correct	2025-07-06 21:14:21.354	2025-07-06 21:14:21.354	\N	\N	2025-07-06 21:14:21.352
135	new	correct	2025-07-06 21:14:23.499	2025-07-06 21:14:23.499	\N	\N	2025-07-06 21:14:23.498
136	new	correct	2025-07-06 21:18:27.181	2025-07-06 21:18:27.181	\N	\N	2025-07-06 21:18:27.181
137	new	correct	2025-07-06 21:18:28.915	2025-07-06 21:18:28.915	\N	\N	2025-07-06 21:18:28.915
138	new	correct	2025-07-06 21:26:32.362	2025-07-06 21:26:32.362	\N	\N	2025-07-06 21:26:32.362
139	new	wrong	2025-07-06 21:26:35.668	2025-07-06 21:26:35.668	\N	\N	2025-07-06 21:26:35.668
140	new	correct	2025-07-06 21:26:37.623	2025-07-06 21:26:37.623	\N	\N	2025-07-06 21:26:37.622
141	new	correct	2025-07-06 21:26:40.438	2025-07-06 21:26:40.438	\N	\N	2025-07-06 21:26:40.437
142	new	correct	2025-07-06 21:26:42.11	2025-07-06 21:26:42.11	\N	\N	2025-07-06 21:26:42.11
143	new	correct	2025-07-06 21:26:43.632	2025-07-06 21:26:43.632	\N	\N	2025-07-06 21:26:43.632
144	new	correct	2025-07-06 21:26:53.779	2025-07-06 21:26:53.779	\N	\N	2025-07-06 21:26:53.778
145	new	correct	2025-07-06 21:26:56.484	2025-07-06 21:26:56.484	\N	\N	2025-07-06 21:26:56.484
146	new	correct	2025-07-06 21:26:57.954	2025-07-06 21:26:57.954	\N	\N	2025-07-06 21:26:57.954
147	new	correct	2025-07-06 21:50:02.988	2025-07-06 21:50:02.988	\N	\N	2025-07-06 21:50:02.988
148	new	wrong	2025-07-06 21:50:05.056	2025-07-06 21:50:05.056	\N	\N	2025-07-06 21:50:05.056
149	new	correct	2025-07-06 21:50:06.373	2025-07-06 21:50:06.373	\N	\N	2025-07-06 21:50:06.373
150	new	correct	2025-07-06 21:50:07.674	2025-07-06 21:50:07.674	\N	\N	2025-07-06 21:50:07.674
151	new	correct	2025-07-06 21:50:09.757	2025-07-06 21:50:09.757	\N	\N	2025-07-06 21:50:09.757
152	new	correct	2025-07-08 20:53:38.174	2025-07-08 20:53:38.174	\N	\N	2025-07-08 20:53:38.172
\.


--
-- Data for Name: reviewlogs_flashcard_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.reviewlogs_flashcard_links (id, reviewlog_id, flashcard_id, reviewlog_order) FROM stdin;
1	28	2	1
2	29	2	2
3	30	2	3
4	31	2	4
5	32	2	5
6	33	3	1
7	34	3	2
8	35	4	1
9	36	5	1
10	37	1	1
11	38	2	6
12	39	2	7
13	40	3	3
14	41	5	2
15	42	1	2
16	43	4	2
17	44	2	8
18	45	3	4
19	46	5	3
20	47	1	3
21	48	4	3
22	49	1	4
23	50	2	9
24	51	3	5
25	52	4	4
26	53	5	4
27	54	2	10
28	55	2	11
29	56	1	5
30	57	3	6
31	58	4	5
32	59	5	5
33	60	3	7
34	61	5	6
35	62	2	12
36	63	1	6
37	64	4	6
38	65	6	1
39	66	5	7
40	67	4	7
41	68	1	7
42	69	3	8
43	70	15	1
44	71	14	1
45	72	13	1
46	73	12	1
47	74	11	1
48	75	10	1
49	76	9	1
50	77	8	1
51	78	7	1
52	79	16	1
53	80	17	1
54	81	18	1
55	82	19	1
56	83	20	1
57	84	21	1
58	85	22	1
59	86	23	1
60	87	24	1
61	88	25	1
62	89	6	2
63	90	4	8
64	91	1	8
65	92	3	9
66	93	26	1
67	94	27	1
68	95	28	1
69	96	29	1
70	97	30	1
71	98	15	2
72	99	14	2
73	100	13	2
74	101	12	2
75	102	11	2
76	103	10	2
77	104	9	2
78	105	8	2
79	106	8	2
80	107	16	2
81	108	17	2
82	109	18	2
83	110	19	2
84	111	20	2
85	112	21	2
86	113	22	2
87	114	23	2
88	115	24	2
89	116	25	2
90	117	6	3
91	118	4	9
92	119	3	10
93	120	7	2
94	121	2	13
95	122	2	14
96	123	5	8
97	124	1	9
98	125	26	2
99	126	27	2
100	127	28	2
101	128	29	2
102	129	30	2
103	130	15	3
104	131	14	3
105	132	33	1
106	133	33	2
107	134	31	1
108	135	32	1
109	136	34	1
110	137	35	1
111	138	36	1
112	139	37	1
113	140	13	3
114	141	12	3
115	142	11	3
116	143	10	3
117	144	9	3
118	145	8	3
119	146	16	3
120	147	38	1
121	148	39	1
122	149	17	3
123	150	18	3
124	151	19	3
125	152	49	1
\.


--
-- Data for Name: reviewlogs_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.reviewlogs_user_links (id, reviewlog_id, user_id, reviewlog_order) FROM stdin;
1	1	8	1
2	2	8	2
3	3	8	3
4	4	8	4
5	5	8	5
6	6	8	6
7	7	8	7
8	8	8	8
9	9	8	9
10	10	8	10
11	11	8	11
12	12	8	12
13	13	8	13
14	14	8	14
15	15	8	15
16	16	8	16
17	17	8	17
18	18	8	18
19	19	8	19
20	20	8	20
21	21	8	21
22	22	8	22
23	23	8	23
24	24	8	24
25	25	8	25
26	26	8	26
27	27	8	27
28	28	8	28
29	29	8	29
30	30	8	30
31	31	8	31
32	32	8	32
33	33	8	33
34	34	8	34
35	35	8	35
36	36	8	36
37	37	8	37
38	38	8	38
39	39	8	39
40	40	8	40
41	41	8	41
42	42	8	42
43	43	8	43
44	44	8	44
45	45	8	45
46	46	8	46
47	47	8	47
48	48	8	48
49	49	8	49
50	50	8	50
51	51	8	51
52	52	8	52
53	53	8	53
54	54	8	54
55	55	8	55
56	56	8	56
57	57	8	57
58	58	8	58
59	59	8	59
60	60	8	60
61	61	8	61
62	62	8	62
63	63	8	63
64	64	8	64
65	65	8	65
66	66	8	66
67	67	8	67
68	68	8	68
69	69	8	69
70	70	8	70
71	71	8	71
72	72	8	72
73	73	8	73
74	74	8	74
75	75	8	75
76	76	8	76
77	77	8	77
78	78	8	78
79	79	8	79
80	80	8	80
81	81	8	81
82	82	8	82
83	83	8	83
84	84	8	84
85	85	8	85
86	86	8	86
87	87	8	87
88	88	8	88
89	89	8	89
90	90	8	90
91	91	8	91
92	92	8	92
93	93	8	93
94	94	8	94
95	95	8	95
96	96	8	96
97	97	8	97
98	98	8	98
99	99	8	99
100	100	8	100
101	101	8	101
102	102	8	102
103	103	8	103
104	104	8	104
105	105	8	105
106	106	8	105
107	107	8	106
108	108	8	107
109	109	8	108
110	110	8	109
111	111	8	110
112	112	8	111
113	113	8	112
114	114	8	113
115	115	8	114
116	116	8	115
117	117	8	116
118	118	8	117
119	119	8	118
120	120	8	119
121	121	8	120
122	122	8	121
123	123	8	122
124	124	8	123
125	125	8	124
126	126	8	125
127	127	8	126
128	128	8	127
129	129	8	128
130	130	8	129
131	131	8	130
132	132	8	131
133	133	8	132
134	134	8	133
135	135	8	134
136	136	8	135
137	137	8	136
138	138	8	137
139	139	8	138
140	140	8	139
141	141	8	140
142	142	8	141
143	143	8	142
144	144	8	143
145	145	8	144
146	146	8	145
147	147	8	146
148	148	8	147
149	149	8	148
150	150	8	149
151	151	8	150
152	152	30	1
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sections (id, title, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
2	Practice 1	2	2025-06-24 00:41:06.392	2025-06-24 00:41:06.392	1	1	en
3	Practice 2	3	2025-06-24 00:41:22.976	2025-06-24 00:41:22.976	1	1	en
1	Section 1 Greeting Dialoge	1	2025-06-24 00:40:06.784	2025-06-24 00:43:54.9	1	1	en
\.


--
-- Data for Name: sections_components; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sections_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
1	1	2	a.word-ref	components	1
2	1	1	a.word-ref	components	2
\.


--
-- Data for Name: sections_lesson_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sections_lesson_links (id, section_id, lesson_id, section_order) FROM stdin;
1	1	1	1
2	2	1	2
3	3	1	3
\.


--
-- Data for Name: sections_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sections_localizations_links (id, section_id, inv_section_id, section_order) FROM stdin;
\.


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sentences (id, title, instruction, base_text, target_text, created_at, updated_at, created_by_id, updated_by_id, locale, register, exam_base, exam_target) FROM stdin;
1	\N	用英语怎么说：	我喜欢你。	I like you	2025-06-28 22:03:43.91	2025-06-29 10:44:54.332	1	1	en	Neutral	\N	\N
2	\N	用英语怎么说	早上好！	Good morning!	2025-06-28 22:04:31.989	2025-06-29 10:45:08.197	1	1	en	Neutral	\N	\N
\.


--
-- Data for Name: sentences_components; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sentences_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
\.


--
-- Data for Name: sentences_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.sentences_localizations_links (id, sentence_id, inv_sentence_id, sentence_order) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
3	plugin_content_manager_configuration_content_types::admin::api-token	{"uid":"admin::api-token","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"lastUsedAt","size":6},{"name":"permissions","size":6}],[{"name":"expiresAt","size":6},{"name":"lifespan","size":4}]]}}	object	\N	\N
2	plugin_content_manager_configuration_content_types::admin::transfer-token	{"uid":"admin::transfer-token","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]}}	object	\N	\N
4	plugin_content_manager_configuration_content_types::admin::permission	{"uid":"admin::permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]}}	object	\N	\N
5	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"uid":"admin::api-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
6	plugin_content_manager_configuration_content_types::admin::role	{"uid":"admin::role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]}}	object	\N	\N
7	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"uid":"plugin::upload.folder","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]}}	object	\N	\N
8	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"uid":"admin::transfer-token-permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]}}	object	\N	\N
9	plugin_content_manager_configuration_content_types::admin::user	{"uid":"admin::user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]}}	object	\N	\N
13	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"uid":"plugin::users-permissions.role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]}}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"uid":"plugin::users-permissions.permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]}}	object	\N	\N
36	plugin_content_manager_configuration_content_types::api::lessonlevel.lessonlevel	{"uid":"api::lessonlevel.lessonlevel","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"level","defaultSortBy":"level","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"level":{"edit":{"label":"level","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"level","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"lessons":{"edit":{"label":"lessons","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"lessons","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","level","createdAt","updatedAt"],"edit":[[{"name":"level","size":6},{"name":"description","size":6}],[{"name":"lessons","size":6}]]}}	object	\N	\N
16	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object	\N	\N
18	plugin_users-permissions_grant	{"email":{"enabled":true,"icon":"envelope"},"discord":{"enabled":false,"icon":"discord","key":"","secret":"","callback":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"enabled":false,"icon":"facebook-square","key":"","secret":"","callback":"api/auth/facebook/callback","scope":["email"]},"google":{"enabled":false,"icon":"google","key":"","secret":"","callback":"api/auth/google/callback","scope":["email"]},"github":{"enabled":false,"icon":"github","key":"","secret":"","callback":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"enabled":false,"icon":"windows","key":"","secret":"","callback":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"enabled":false,"icon":"twitter","key":"","secret":"","callback":"api/auth/twitter/callback"},"instagram":{"enabled":false,"icon":"instagram","key":"","secret":"","callback":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"enabled":false,"icon":"vk","key":"","secret":"","callback":"api/auth/vk/callback","scope":["email"]},"twitch":{"enabled":false,"icon":"twitch","key":"","secret":"","callback":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"enabled":false,"icon":"linkedin","key":"","secret":"","callback":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"enabled":false,"icon":"aws","key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"enabled":false,"icon":"reddit","key":"","secret":"","state":true,"callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"enabled":false,"icon":"","key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"enabled":false,"icon":"book","key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"enabled":false,"icon":"","key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]}}	object	\N	\N
19	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
20	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
27	plugin_content_manager_configuration_components::a.taglist	{"uid":"a.taglist","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"tag","defaultSortBy":"tag","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"tag":{"edit":{"label":"tag","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tag","searchable":true,"sortable":true}}},"layouts":{"list":["id","tag"],"edit":[[{"name":"tag","size":6}]]},"isComponent":true}	object	\N	\N
15	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":true}	object	\N	\N
37	plugin_content_manager_configuration_content_types::api::lesson.lesson	{"uid":"api::lesson.lesson","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"tags":{"edit":{"label":"tags","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tags","searchable":false,"sortable":false}},"lessonlevel":{"edit":{"label":"lessonlevel","description":"","placeholder":"","visible":true,"editable":true,"mainField":"level"},"list":{"label":"lessonlevel","searchable":true,"sortable":true}},"sections":{"edit":{"label":"sections","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"sections","searchable":false,"sortable":false}},"user_words":{"edit":{"label":"user_words","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"user_words","searchable":false,"sortable":false}},"user_sentences":{"edit":{"label":"user_sentences","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"user_sentences","searchable":false,"sortable":false}},"flashcards":{"edit":{"label":"flashcards","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"flashcards","searchable":false,"sortable":false}},"unit":{"edit":{"label":"unit","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"unit","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","slug","unit"],"edit":[[{"name":"title","size":6},{"name":"slug","size":6}],[{"name":"description","size":6}],[{"name":"order","size":4}],[{"name":"tags","size":12}],[{"name":"lessonlevel","size":6},{"name":"sections","size":6}],[{"name":"user_words","size":6},{"name":"user_sentences","size":6}],[{"name":"flashcards","size":6},{"name":"unit","size":6}]]}}	object	\N	\N
17	plugin_upload_metrics	{"weeklySchedule":"28 29 19 * * 1","lastWeeklyUpdate":1751941768200}	object	\N	\N
14	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"uid":"plugin::i18n.locale","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]}}	object	\N	\N
21	plugin_i18n_default_locale	"en"	string	\N	\N
38	plugin_content_manager_configuration_content_types::api::section.section	{"uid":"api::section.section","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"lesson":{"edit":{"label":"lesson","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"lesson","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"components":{"edit":{"label":"components","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"components","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","lesson","order"],"edit":[[{"name":"title","size":6},{"name":"lesson","size":6}],[{"name":"order","size":4}],[{"name":"components","size":12}]]}}	object	\N	\N
23	plugin_content_manager_configuration_content_types::api::unit.unit	{"uid":"api::unit.unit","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"lessons":{"edit":{"label":"lessons","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"lessons","searchable":false,"sortable":false}},"precondition":{"edit":{"label":"precondition","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"precondition","searchable":true,"sortable":true}},"unlocks":{"edit":{"label":"unlocks","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"unlocks","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","slug","description"],"edit":[[{"name":"title","size":6},{"name":"slug","size":6}],[{"name":"description","size":6},{"name":"order","size":4}],[{"name":"lessons","size":6},{"name":"precondition","size":6}],[{"name":"unlocks","size":6}]]}}	object	\N	\N
42	plugin_content_manager_configuration_components::a.user-sent-ref	{"uid":"a.user-sent-ref","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"user_sentence":{"edit":{"label":"user_sentence","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"user_sentence","searchable":true,"sortable":true}}},"layouts":{"list":["id","user_sentence"],"edit":[[{"name":"user_sentence","size":6}]]},"isComponent":true}	object	\N	\N
40	plugin_content_manager_configuration_content_types::api::user-sentence.user-sentence	{"uid":"api::user-sentence.user-sentence","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"target_text","defaultSortBy":"target_text","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"target_text":{"edit":{"label":"target_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"target_text","searchable":true,"sortable":true}},"base_text":{"edit":{"label":"base_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"base_text","searchable":true,"sortable":true}},"lesson":{"edit":{"label":"lesson","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"lesson","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","target_text","base_text","user"],"edit":[[{"name":"target_text","size":6}],[{"name":"base_text","size":6},{"name":"lesson","size":6}],[{"name":"user","size":6}]]}}	object	\N	\N
41	plugin_content_manager_configuration_components::a.user-word-ref	{"uid":"a.user-word-ref","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"user_word":{"edit":{"label":"user_word","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"user_word","searchable":true,"sortable":true}}},"layouts":{"list":["id","user_word"],"edit":[[{"name":"user_word","size":6}]]},"isComponent":true}	object	\N	\N
1	strapi_content_types_schema	{"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"admin::permission","plugin":"admin","globalId":"AdminPermission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"admin::user","plugin":"admin","globalId":"AdminUser"},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"admin::role","plugin":"admin","globalId":"AdminRole"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token","connection":"default","uid":"admin::api-token","plugin":"admin","globalId":"AdminApiToken"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"api-token-permission","connection":"default","uid":"admin::api-token-permission","plugin":"admin","globalId":"AdminApiTokenPermission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token","connection":"default","uid":"admin::transfer-token","plugin":"admin","globalId":"AdminTransferToken"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelType":"contentType","modelName":"transfer-token-permission","connection":"default","uid":"admin::transfer-token-permission","plugin":"admin","globalId":"AdminTransferTokenPermission"},"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","min":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"file","connection":"default","uid":"plugin::upload.file","plugin":"upload","globalId":"UploadFile"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","min":1,"required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"folder","connection":"default","uid":"plugin::upload.folder","plugin":"upload","globalId":"UploadFolder"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"permission","connection":"default","uid":"plugin::users-permissions.permission","plugin":"users-permissions","globalId":"UsersPermissionsPermission"},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"role","connection":"default","uid":"plugin::users-permissions.role","plugin":"users-permissions","globalId":"UsersPermissionsRole"},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"flashcards":{"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard","mappedBy":"user"},"reviewlogs":{"type":"relation","relation":"oneToMany","target":"api::reviewlog.reviewlog","mappedBy":"user"},"user_profile":{"type":"relation","relation":"oneToOne","target":"api::user-profile.user-profile","mappedBy":"user"},"user_words":{"type":"relation","relation":"oneToMany","target":"api::user-word.user-word","mappedBy":"user"},"user_sentences":{"type":"relation","relation":"oneToMany","target":"api::user-sentence.user-sentence","mappedBy":"user"},"vocabook":{"type":"relation","relation":"oneToOne","target":"api::vocabook.vocabook","mappedBy":"user"},"vbsetting":{"type":"relation","relation":"oneToOne","target":"api::vbsetting.vbsetting","mappedBy":"user"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"kind":"collectionType","__filename__":"schema.json","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false,"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"flashcards":{"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard","mappedBy":"user"},"reviewlogs":{"type":"relation","relation":"oneToMany","target":"api::reviewlog.reviewlog","mappedBy":"user"},"user_profile":{"type":"relation","relation":"oneToOne","target":"api::user-profile.user-profile","mappedBy":"user"},"user_words":{"type":"relation","relation":"oneToMany","target":"api::user-word.user-word","mappedBy":"user"},"user_sentences":{"type":"relation","relation":"oneToMany","target":"api::user-sentence.user-sentence","mappedBy":"user"},"vocabook":{"type":"relation","relation":"oneToOne","target":"api::vocabook.vocabook","mappedBy":"user"},"vbsetting":{"type":"relation","relation":"oneToOne","target":"api::vbsetting.vbsetting","mappedBy":"user"}},"kind":"collectionType"},"modelType":"contentType","modelName":"user","connection":"default","uid":"plugin::users-permissions.user","plugin":"users-permissions","globalId":"UsersPermissionsUser"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"kind":"collectionType","__schema__":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelType":"contentType","modelName":"locale","connection":"default","uid":"plugin::i18n.locale","plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale"},"api::flashcard.flashcard":{"kind":"collectionType","collectionName":"flashcards","info":{"singularName":"flashcard","pluralName":"flashcards","displayName":"flashcard","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"flashcards"},"content":{"pluginOptions":{"i18n":{"localized":false}},"type":"dynamiczone","components":["a.sent-ref","a.user-sent-ref","a.word-ref","a.user-word-ref"]},"last_reviewed_at":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"flashcards"},"correct_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","default":0,"required":true},"wrong_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","default":0,"required":true},"is_remembered":{"pluginOptions":{"i18n":{"localized":false}},"type":"boolean","default":false,"required":true},"reviewlogs":{"type":"relation","relation":"oneToMany","target":"api::reviewlog.reviewlog","mappedBy":"flashcard"},"vocapage":{"type":"relation","relation":"manyToOne","target":"api::vocapage.vocapage","inversedBy":"flashcards"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"flashcards","info":{"singularName":"flashcard","pluralName":"flashcards","displayName":"flashcard","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"flashcards"},"content":{"pluginOptions":{"i18n":{"localized":false}},"type":"dynamiczone","components":["a.sent-ref","a.user-sent-ref","a.word-ref","a.user-word-ref"]},"last_reviewed_at":{"pluginOptions":{"i18n":{"localized":false}},"type":"datetime"},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"flashcards"},"correct_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","default":0,"required":true},"wrong_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","default":0,"required":true},"is_remembered":{"pluginOptions":{"i18n":{"localized":false}},"type":"boolean","default":false,"required":true},"reviewlogs":{"type":"relation","relation":"oneToMany","target":"api::reviewlog.reviewlog","mappedBy":"flashcard"},"vocapage":{"type":"relation","relation":"manyToOne","target":"api::vocapage.vocapage","inversedBy":"flashcards"}},"kind":"collectionType"},"modelType":"contentType","modelName":"flashcard","connection":"default","uid":"api::flashcard.flashcard","apiName":"flashcard","globalId":"Flashcard","actions":{},"lifecycles":{}},"api::lesson.lesson":{"kind":"collectionType","collectionName":"lessons","info":{"singularName":"lesson","pluralName":"lessons","displayName":"lesson","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"slug":{"pluginOptions":{"i18n":{"localized":true}},"type":"uid","targetField":"title"},"description":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"order":{"pluginOptions":{"i18n":{"localized":true}},"type":"integer"},"tags":{"type":"component","repeatable":true,"pluginOptions":{"i18n":{"localized":true}},"component":"a.taglist"},"lessonlevel":{"type":"relation","relation":"manyToOne","target":"api::lessonlevel.lessonlevel","inversedBy":"lessons"},"sections":{"type":"relation","relation":"oneToMany","target":"api::section.section","mappedBy":"lesson"},"user_words":{"type":"relation","relation":"oneToMany","target":"api::user-word.user-word","mappedBy":"lesson"},"user_sentences":{"type":"relation","relation":"oneToMany","target":"api::user-sentence.user-sentence","mappedBy":"lesson"},"flashcards":{"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard","mappedBy":"lesson"},"unit":{"type":"relation","relation":"manyToOne","target":"api::unit.unit","inversedBy":"lessons"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::lesson.lesson"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"lessons","info":{"singularName":"lesson","pluralName":"lessons","displayName":"lesson","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"slug":{"pluginOptions":{"i18n":{"localized":true}},"type":"uid","targetField":"title"},"description":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"order":{"pluginOptions":{"i18n":{"localized":true}},"type":"integer"},"tags":{"type":"component","repeatable":true,"pluginOptions":{"i18n":{"localized":true}},"component":"a.taglist"},"lessonlevel":{"type":"relation","relation":"manyToOne","target":"api::lessonlevel.lessonlevel","inversedBy":"lessons"},"sections":{"type":"relation","relation":"oneToMany","target":"api::section.section","mappedBy":"lesson"},"user_words":{"type":"relation","relation":"oneToMany","target":"api::user-word.user-word","mappedBy":"lesson"},"user_sentences":{"type":"relation","relation":"oneToMany","target":"api::user-sentence.user-sentence","mappedBy":"lesson"},"flashcards":{"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard","mappedBy":"lesson"},"unit":{"type":"relation","relation":"manyToOne","target":"api::unit.unit","inversedBy":"lessons"}},"kind":"collectionType"},"modelType":"contentType","modelName":"lesson","connection":"default","uid":"api::lesson.lesson","apiName":"lesson","globalId":"Lesson","actions":{},"lifecycles":{}},"api::lessonlevel.lessonlevel":{"kind":"collectionType","collectionName":"lessonlevels","info":{"singularName":"lessonlevel","pluralName":"lessonlevels","displayName":"lessonlevel","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"level":{"type":"string"},"description":{"type":"string"},"lessons":{"type":"relation","relation":"oneToMany","target":"api::lesson.lesson","mappedBy":"lessonlevel"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"lessonlevels","info":{"singularName":"lessonlevel","pluralName":"lessonlevels","displayName":"lessonlevel","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"level":{"type":"string"},"description":{"type":"string"},"lessons":{"type":"relation","relation":"oneToMany","target":"api::lesson.lesson","mappedBy":"lessonlevel"}},"kind":"collectionType"},"modelType":"contentType","modelName":"lessonlevel","connection":"default","uid":"api::lessonlevel.lessonlevel","apiName":"lessonlevel","globalId":"Lessonlevel","actions":{},"lifecycles":{}},"api::review-tire.review-tire":{"kind":"collectionType","collectionName":"review_tires","info":{"singularName":"review-tire","pluralName":"review-tires","displayName":"reviewTire","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"tier":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["new","warmup","weekly","monthly","remembered"],"required":true},"min_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"max_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"cooldown_hours":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"demote_bar":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true,"default":2},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::review-tire.review-tire"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"review_tires","info":{"singularName":"review-tire","pluralName":"review-tires","displayName":"reviewTire","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"tier":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["new","warmup","weekly","monthly","remembered"],"required":true},"min_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"max_streak":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"cooldown_hours":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true},"demote_bar":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer","required":true,"default":2}},"kind":"collectionType"},"modelType":"contentType","modelName":"review-tire","connection":"default","uid":"api::review-tire.review-tire","apiName":"review-tire","globalId":"ReviewTire","actions":{},"lifecycles":{}},"api::reviewlog.reviewlog":{"kind":"collectionType","collectionName":"reviewlogs","info":{"singularName":"reviewlog","pluralName":"reviewlogs","displayName":"reviewlog","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"reviewlogs"},"reviewed_at":{"type":"datetime"},"level":{"type":"enumeration","enum":["daily","weekly","monthly"]},"result":{"type":"enumeration","enum":["correct","wrong"],"required":true},"flashcard":{"type":"relation","relation":"manyToOne","target":"api::flashcard.flashcard","inversedBy":"reviewlogs"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"reviewlogs","info":{"singularName":"reviewlog","pluralName":"reviewlogs","displayName":"reviewlog","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"reviewlogs"},"reviewed_at":{"type":"datetime"},"level":{"type":"enumeration","enum":["daily","weekly","monthly"]},"result":{"type":"enumeration","enum":["correct","wrong"],"required":true},"flashcard":{"type":"relation","relation":"manyToOne","target":"api::flashcard.flashcard","inversedBy":"reviewlogs"}},"kind":"collectionType"},"modelType":"contentType","modelName":"reviewlog","connection":"default","uid":"api::reviewlog.reviewlog","apiName":"reviewlog","globalId":"Reviewlog","actions":{},"lifecycles":{}},"api::section.section":{"kind":"collectionType","collectionName":"sections","info":{"singularName":"section","pluralName":"sections","displayName":"section"},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"sections"},"order":{"pluginOptions":{"i18n":{"localized":true}},"type":"integer"},"components":{"pluginOptions":{"i18n":{"localized":true}},"type":"dynamiczone","components":["a.word-ref","a.video","a.sent-ref","a.quiz","a.pagebreaker","a.external-video"]},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::section.section"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"sections","info":{"singularName":"section","pluralName":"sections","displayName":"section"},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"sections"},"order":{"pluginOptions":{"i18n":{"localized":true}},"type":"integer"},"components":{"pluginOptions":{"i18n":{"localized":true}},"type":"dynamiczone","components":["a.word-ref","a.video","a.sent-ref","a.quiz","a.pagebreaker","a.external-video"]}},"kind":"collectionType"},"modelType":"contentType","modelName":"section","connection":"default","uid":"api::section.section","apiName":"section","globalId":"Section","actions":{},"lifecycles":{}},"api::sentence.sentence":{"kind":"collectionType","collectionName":"sentences","info":{"singularName":"sentence","pluralName":"sentences","displayName":"sentence","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"instruction":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"target_text":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"target_audio":{"type":"media","multiple":false,"required":false,"allowedTypes":["audios"],"pluginOptions":{"i18n":{"localized":false}}},"tags":{"type":"component","repeatable":true,"pluginOptions":{"i18n":{"localized":true}},"component":"a.taglist"},"words":{"type":"relation","relation":"manyToMany","target":"api::word.word","mappedBy":"example_sentences"},"register":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["Formal","Informal","Neutral"],"default":"Neutral"},"exam_base":{"pluginOptions":{"i18n":{"localized":true}},"type":"json"},"exam_target":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::sentence.sentence"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"sentences","info":{"singularName":"sentence","pluralName":"sentences","displayName":"sentence","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"instruction":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"target_text":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"target_audio":{"type":"media","multiple":false,"required":false,"allowedTypes":["audios"],"pluginOptions":{"i18n":{"localized":false}}},"tags":{"type":"component","repeatable":true,"pluginOptions":{"i18n":{"localized":true}},"component":"a.taglist"},"words":{"type":"relation","relation":"manyToMany","target":"api::word.word","mappedBy":"example_sentences"},"register":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["Formal","Informal","Neutral"],"default":"Neutral"},"exam_base":{"pluginOptions":{"i18n":{"localized":true}},"type":"json"},"exam_target":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"}},"kind":"collectionType"},"modelType":"contentType","modelName":"sentence","connection":"default","uid":"api::sentence.sentence","apiName":"sentence","globalId":"Sentence","actions":{},"lifecycles":{}},"api::unit.unit":{"kind":"collectionType","collectionName":"units","info":{"singularName":"unit","pluralName":"units","displayName":"unit","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"slug":{"pluginOptions":{"i18n":{"localized":true}},"type":"uid","targetField":"title"},"description":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer"},"lessons":{"type":"relation","relation":"oneToMany","target":"api::lesson.lesson","mappedBy":"unit"},"precondition":{"type":"relation","relation":"oneToOne","target":"api::unit.unit","inversedBy":"unlocks"},"unlocks":{"type":"relation","relation":"oneToOne","target":"api::unit.unit","mappedBy":"precondition"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::unit.unit"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"units","info":{"singularName":"unit","pluralName":"units","displayName":"unit","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"title":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"slug":{"pluginOptions":{"i18n":{"localized":true}},"type":"uid","targetField":"title"},"description":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"order":{"pluginOptions":{"i18n":{"localized":false}},"type":"integer"},"lessons":{"type":"relation","relation":"oneToMany","target":"api::lesson.lesson","mappedBy":"unit"},"precondition":{"type":"relation","relation":"oneToOne","target":"api::unit.unit","inversedBy":"unlocks"},"unlocks":{"type":"relation","relation":"oneToOne","target":"api::unit.unit","mappedBy":"precondition"}},"kind":"collectionType"},"modelType":"contentType","modelName":"unit","connection":"default","uid":"api::unit.unit","apiName":"unit","globalId":"Unit","actions":{},"lifecycles":{}},"api::user-profile.user-profile":{"kind":"collectionType","collectionName":"user_profiles","info":{"singularName":"user-profile","pluralName":"user-profiles","displayName":"userProfile","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user","inversedBy":"user_profile"},"telephone":{"type":"string"},"baseLanguage":{"type":"string","required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"user_profiles","info":{"singularName":"user-profile","pluralName":"user-profiles","displayName":"userProfile","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user","inversedBy":"user_profile"},"telephone":{"type":"string"},"baseLanguage":{"type":"string","required":true}},"kind":"collectionType"},"modelType":"contentType","modelName":"user-profile","connection":"default","uid":"api::user-profile.user-profile","apiName":"user-profile","globalId":"UserProfile","actions":{},"lifecycles":{}},"api::user-sentence.user-sentence":{"kind":"collectionType","collectionName":"user_sentences","info":{"singularName":"user-sentence","pluralName":"user-sentences","displayName":"user_sentence","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"user_sentences"},"target_text":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"user_sentences"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::user-sentence.user-sentence"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"user_sentences","info":{"singularName":"user-sentence","pluralName":"user-sentences","displayName":"user_sentence","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"user_sentences"},"target_text":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"user_sentences"}},"kind":"collectionType"},"modelType":"contentType","modelName":"user-sentence","connection":"default","uid":"api::user-sentence.user-sentence","apiName":"user-sentence","globalId":"UserSentence","actions":{},"lifecycles":{}},"api::user-word.user-word":{"kind":"collectionType","collectionName":"user_words","info":{"singularName":"user-word","pluralName":"user-words","displayName":"user_word","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"user_words"},"target_text":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":true},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"part_of_speech":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["noun","verb","adjective","adverb","conjunction","preposition","interjection","determiner","pronoun"]},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"user_words"},"exam_base":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"},"exam_target":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::user-word.user-word"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"user_words","info":{"singularName":"user-word","pluralName":"user-words","displayName":"user_word","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"user_words"},"target_text":{"pluginOptions":{"i18n":{"localized":false}},"type":"string","required":true},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"part_of_speech":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["noun","verb","adjective","adverb","conjunction","preposition","interjection","determiner","pronoun"]},"lesson":{"type":"relation","relation":"manyToOne","target":"api::lesson.lesson","inversedBy":"user_words"},"exam_base":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"},"exam_target":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"}},"kind":"collectionType"},"modelType":"contentType","modelName":"user-word","connection":"default","uid":"api::user-word.user-word","apiName":"user-word","globalId":"UserWord","actions":{},"lifecycles":{}},"api::vbsetting.vbsetting":{"kind":"collectionType","collectionName":"vbsettings","info":{"singularName":"vbsetting","pluralName":"vbsettings","displayName":"vbsetting"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user","inversedBy":"vbsetting"},"wordsPerPage":{"type":"integer","default":12,"required":true},"interval1":{"type":"decimal","default":1.5},"interval2":{"type":"decimal","default":2},"interval3":{"type":"decimal","default":2},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"vbsettings","info":{"singularName":"vbsetting","pluralName":"vbsettings","displayName":"vbsetting"},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user","inversedBy":"vbsetting"},"wordsPerPage":{"type":"integer","default":12,"required":true},"interval1":{"type":"decimal","default":1.5},"interval2":{"type":"decimal","default":2},"interval3":{"type":"decimal","default":2}},"kind":"collectionType"},"modelType":"contentType","modelName":"vbsetting","connection":"default","uid":"api::vbsetting.vbsetting","apiName":"vbsetting","globalId":"Vbsetting","actions":{},"lifecycles":{}},"api::vocabook.vocabook":{"kind":"collectionType","collectionName":"vocabooks","info":{"singularName":"vocabook","pluralName":"vocabooks","displayName":"vocabook","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"pluginOptions":{},"type":"string","required":true},"user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user","inversedBy":"vocabook"},"vocapages":{"type":"relation","relation":"oneToMany","target":"api::vocapage.vocapage","mappedBy":"vocabook"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"vocabooks","info":{"singularName":"vocabook","pluralName":"vocabooks","displayName":"vocabook","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"pluginOptions":{},"type":"string","required":true},"user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user","inversedBy":"vocabook"},"vocapages":{"type":"relation","relation":"oneToMany","target":"api::vocapage.vocapage","mappedBy":"vocabook"}},"kind":"collectionType"},"modelType":"contentType","modelName":"vocabook","connection":"default","uid":"api::vocabook.vocabook","apiName":"vocabook","globalId":"Vocabook","actions":{},"lifecycles":{}},"api::vocapage.vocapage":{"kind":"collectionType","collectionName":"vocapages","info":{"singularName":"vocapage","pluralName":"vocapages","displayName":"vocapage","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true},"order":{"type":"integer"},"vocabook":{"type":"relation","relation":"manyToOne","target":"api::vocabook.vocabook","inversedBy":"vocapages"},"flashcards":{"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard","mappedBy":"vocapage"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true}},"__schema__":{"collectionName":"vocapages","info":{"singularName":"vocapage","pluralName":"vocapages","displayName":"vocapage","description":""},"options":{"draftAndPublish":false},"pluginOptions":{},"attributes":{"title":{"type":"string","required":true},"order":{"type":"integer"},"vocabook":{"type":"relation","relation":"manyToOne","target":"api::vocabook.vocabook","inversedBy":"vocapages"},"flashcards":{"type":"relation","relation":"oneToMany","target":"api::flashcard.flashcard","mappedBy":"vocapage"}},"kind":"collectionType"},"modelType":"contentType","modelName":"vocapage","connection":"default","uid":"api::vocapage.vocapage","apiName":"vocapage","globalId":"Vocapage","actions":{},"lifecycles":{}},"api::word.word":{"kind":"collectionType","collectionName":"words","info":{"singularName":"word","pluralName":"words","displayName":"word","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"word":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"instruction":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"part_of_speech":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["noun","verb","adjective","adverb","conjunction","preposition","interjection","determiner","pronoun"]},"gender":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["masculine","feminine","neuter"]},"article":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"audio":{"type":"media","multiple":false,"required":false,"allowedTypes":["audios"],"pluginOptions":{"i18n":{"localized":false}}},"tags":{"type":"component","repeatable":true,"pluginOptions":{"i18n":{"localized":true}},"component":"a.taglist"},"example_sentences":{"type":"relation","relation":"manyToMany","target":"api::sentence.sentence","inversedBy":"words"},"verb_meta":{"type":"component","repeatable":false,"pluginOptions":{"i18n":{"localized":true}},"component":"a.verb-meta"},"register":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["Formal","Informal","Neutral"],"default":"Neutral"},"exam_base":{"pluginOptions":{"i18n":{"localized":true}},"type":"json"},"exam_target":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"relation","relation":"oneToMany","target":"api::word.word"},"locale":{"writable":true,"private":false,"configurable":false,"visible":false,"type":"string"}},"__schema__":{"collectionName":"words","info":{"singularName":"word","pluralName":"words","displayName":"word","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"i18n":{"localized":true}},"attributes":{"word":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"base_text":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"instruction":{"pluginOptions":{"i18n":{"localized":true}},"type":"string"},"part_of_speech":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["noun","verb","adjective","adverb","conjunction","preposition","interjection","determiner","pronoun"]},"gender":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["masculine","feminine","neuter"]},"article":{"pluginOptions":{"i18n":{"localized":false}},"type":"string"},"audio":{"type":"media","multiple":false,"required":false,"allowedTypes":["audios"],"pluginOptions":{"i18n":{"localized":false}}},"tags":{"type":"component","repeatable":true,"pluginOptions":{"i18n":{"localized":true}},"component":"a.taglist"},"example_sentences":{"type":"relation","relation":"manyToMany","target":"api::sentence.sentence","inversedBy":"words"},"verb_meta":{"type":"component","repeatable":false,"pluginOptions":{"i18n":{"localized":true}},"component":"a.verb-meta"},"register":{"pluginOptions":{"i18n":{"localized":true}},"type":"enumeration","enum":["Formal","Informal","Neutral"],"default":"Neutral"},"exam_base":{"pluginOptions":{"i18n":{"localized":true}},"type":"json"},"exam_target":{"pluginOptions":{"i18n":{"localized":false}},"type":"json"}},"kind":"collectionType"},"modelType":"contentType","modelName":"word","connection":"default","uid":"api::word.word","apiName":"word","globalId":"Word","actions":{},"lifecycles":{}}}	object	\N	\N
26	plugin_content_manager_configuration_content_types::api::sentence.sentence	{"uid":"api::sentence.sentence","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"target_text","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"instruction":{"edit":{"label":"instruction","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"instruction","searchable":true,"sortable":true}},"base_text":{"edit":{"label":"base_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"base_text","searchable":true,"sortable":true}},"target_text":{"edit":{"label":"target_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"target_text","searchable":true,"sortable":true}},"target_audio":{"edit":{"label":"target_audio","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"target_audio","searchable":false,"sortable":false}},"tags":{"edit":{"label":"tags","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tags","searchable":false,"sortable":false}},"words":{"edit":{"label":"words","description":"","placeholder":"","visible":true,"editable":true,"mainField":"word"},"list":{"label":"words","searchable":false,"sortable":false}},"register":{"edit":{"label":"register","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"register","searchable":true,"sortable":true}},"exam_base":{"edit":{"label":"exam_base","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"exam_base","searchable":false,"sortable":false}},"exam_target":{"edit":{"label":"exam_target","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"exam_target","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","instruction","base_text"],"edit":[[{"name":"title","size":6},{"name":"instruction","size":6}],[{"name":"base_text","size":6},{"name":"target_text","size":6}],[{"name":"target_audio","size":6}],[{"name":"tags","size":12}],[{"name":"words","size":6},{"name":"register","size":6}],[{"name":"exam_base","size":12}],[{"name":"exam_target","size":12}]]}}	object	\N	\N
28	plugin_content_manager_configuration_components::a.verb-meta	{"uid":"a.verb-meta","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"simple_past","defaultSortBy":"simple_past","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"simple_past":{"edit":{"label":"simple_past","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"simple_past","searchable":true,"sortable":true}},"past_participle":{"edit":{"label":"past_participle","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"past_participle","searchable":true,"sortable":true}},"present_participle":{"edit":{"label":"present_participle","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"present_participle","searchable":true,"sortable":true}},"thirdperson_singular":{"edit":{"label":"thirdperson_singular","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"thirdperson_singular","searchable":true,"sortable":true}},"auxiliary_verb":{"edit":{"label":"auxiliary_verb","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"auxiliary_verb","searchable":true,"sortable":true}},"conjugations":{"edit":{"label":"conjugations","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conjugations","searchable":false,"sortable":false}}},"layouts":{"list":["id","simple_past","past_participle","present_participle"],"edit":[[{"name":"simple_past","size":6},{"name":"past_participle","size":6}],[{"name":"present_participle","size":6},{"name":"thirdperson_singular","size":6}],[{"name":"auxiliary_verb","size":6}],[{"name":"conjugations","size":12}]]},"isComponent":true}	object	\N	\N
30	plugin_content_manager_configuration_components::a.sent-ref	{"uid":"a.sent-ref","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"sentence":{"edit":{"label":"sentence","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"sentence","searchable":true,"sortable":true}}},"layouts":{"list":["id","sentence"],"edit":[[{"name":"sentence","size":6}]]},"isComponent":true}	object	\N	\N
31	plugin_content_manager_configuration_components::a.word-ref	{"uid":"a.word-ref","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"word":{"edit":{"label":"word","description":"","placeholder":"","visible":true,"editable":true,"mainField":"word"},"list":{"label":"word","searchable":true,"sortable":true}}},"layouts":{"list":["id","word"],"edit":[[{"name":"word","size":6}]]},"isComponent":true}	object	\N	\N
32	plugin_content_manager_configuration_components::a.quiz	{"uid":"a.quiz","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"question","defaultSortBy":"question","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"question":{"edit":{"label":"question","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"question","searchable":true,"sortable":true}},"options":{"edit":{"label":"options","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"options","searchable":false,"sortable":false}},"answer":{"edit":{"label":"answer","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"answer","searchable":true,"sortable":true}},"explanation":{"edit":{"label":"explanation","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"explanation","searchable":true,"sortable":true}},"audio":{"edit":{"label":"audio","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"audio","searchable":false,"sortable":false}}},"layouts":{"list":["id","question","answer","explanation"],"edit":[[{"name":"question","size":6}],[{"name":"options","size":12}],[{"name":"answer","size":6},{"name":"explanation","size":6}],[{"name":"audio","size":6}]]},"isComponent":true}	object	\N	\N
29	plugin_content_manager_configuration_content_types::api::word.word	{"uid":"api::word.word","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"word","defaultSortBy":"word","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"word":{"edit":{"label":"word","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"word","searchable":true,"sortable":true}},"base_text":{"edit":{"label":"base_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"base_text","searchable":true,"sortable":true}},"instruction":{"edit":{"label":"instruction","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"instruction","searchable":true,"sortable":true}},"part_of_speech":{"edit":{"label":"part_of_speech","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"part_of_speech","searchable":true,"sortable":true}},"gender":{"edit":{"label":"gender","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gender","searchable":true,"sortable":true}},"article":{"edit":{"label":"article","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"article","searchable":true,"sortable":true}},"audio":{"edit":{"label":"audio","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"audio","searchable":false,"sortable":false}},"tags":{"edit":{"label":"tags","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tags","searchable":false,"sortable":false}},"example_sentences":{"edit":{"label":"example_sentences","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"example_sentences","searchable":false,"sortable":false}},"verb_meta":{"edit":{"label":"verb_meta","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"verb_meta","searchable":false,"sortable":false}},"register":{"edit":{"label":"register","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"register","searchable":true,"sortable":true}},"exam_base":{"edit":{"label":"exam_base","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"exam_base","searchable":false,"sortable":false}},"exam_target":{"edit":{"label":"exam_target","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"exam_target","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","word","base_text","instruction"],"edit":[[{"name":"word","size":6},{"name":"base_text","size":6}],[{"name":"instruction","size":6},{"name":"part_of_speech","size":6}],[{"name":"gender","size":6},{"name":"article","size":6}],[{"name":"audio","size":6}],[{"name":"tags","size":12}],[{"name":"example_sentences","size":6}],[{"name":"verb_meta","size":12}],[{"name":"register","size":6}],[{"name":"exam_base","size":12}],[{"name":"exam_target","size":12}]]}}	object	\N	\N
33	plugin_content_manager_configuration_components::a.pagebreaker	{"uid":"a.pagebreaker","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"backbutton":{"edit":{"label":"backbutton","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"backbutton","searchable":true,"sortable":true}},"nextbutton":{"edit":{"label":"nextbutton","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"nextbutton","searchable":true,"sortable":true}}},"layouts":{"list":["id","backbutton","nextbutton"],"edit":[[{"name":"backbutton","size":4},{"name":"nextbutton","size":4}]]},"isComponent":true}	object	\N	\N
34	plugin_content_manager_configuration_components::a.video	{"uid":"a.video","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"media":{"edit":{"label":"media","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"media","searchable":false,"sortable":false}},"thumbnail":{"edit":{"label":"thumbnail","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"thumbnail","searchable":false,"sortable":false}}},"layouts":{"list":["id","media","thumbnail"],"edit":[[{"name":"media","size":6},{"name":"thumbnail","size":6}]]},"isComponent":true}	object	\N	\N
35	plugin_content_manager_configuration_components::a.external-video	{"uid":"a.external-video","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"url","defaultSortBy":"url","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":false,"sortable":false}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}}},"layouts":{"list":["id","url","caption"],"edit":[[{"name":"url","size":6},{"name":"caption","size":6}]]},"isComponent":true}	object	\N	\N
10	plugin_content_manager_configuration_content_types::plugin::upload.file	{"uid":"plugin::upload.file","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]}}	object	\N	\N
44	plugin_content_manager_configuration_content_types::api::reviewlog.reviewlog	{"uid":"api::reviewlog.reviewlog","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":100,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"reviewed_at":{"edit":{"label":"reviewed_at","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"reviewed_at","searchable":true,"sortable":true}},"level":{"edit":{"label":"level","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"level","searchable":true,"sortable":true}},"result":{"edit":{"label":"result","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"result","searchable":true,"sortable":true}},"flashcard":{"edit":{"label":"flashcard","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"flashcard","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"user","size":6}],[{"name":"level","size":6}],[{"name":"result","size":6},{"name":"flashcard","size":6}],[{"name":"reviewed_at","size":6}]],"list":["id","user","flashcard","result","reviewed_at"]}}	object	\N	\N
45	plugin_content_manager_configuration_content_types::api::review-tire.review-tire	{"uid":"api::review-tire.review-tire","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"tier":{"edit":{"label":"tier","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tier","searchable":true,"sortable":true}},"min_streak":{"edit":{"label":"min_streak","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"min_streak","searchable":true,"sortable":true}},"max_streak":{"edit":{"label":"max_streak","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"max_streak","searchable":true,"sortable":true}},"cooldown_hours":{"edit":{"label":"cooldown_hours","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"cooldown_hours","searchable":true,"sortable":true}},"demote_bar":{"edit":{"label":"demote_bar","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"demote_bar","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"tier","size":6},{"name":"min_streak","size":4}],[{"name":"max_streak","size":4},{"name":"cooldown_hours","size":4},{"name":"demote_bar","size":4}]],"list":["id","tier","min_streak","max_streak","cooldown_hours","demote_bar"]}}	object	\N	\N
22	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
39	plugin_content_manager_configuration_content_types::api::user-word.user-word	{"uid":"api::user-word.user-word","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":100,"mainField":"target_text","defaultSortBy":"id","defaultSortOrder":"DESC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"target_text":{"edit":{"label":"target_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"target_text","searchable":true,"sortable":true}},"base_text":{"edit":{"label":"base_text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"base_text","searchable":true,"sortable":true}},"part_of_speech":{"edit":{"label":"part_of_speech","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"part_of_speech","searchable":true,"sortable":true}},"lesson":{"edit":{"label":"lesson","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"lesson","searchable":true,"sortable":true}},"exam_base":{"edit":{"label":"exam_base","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"exam_base","searchable":false,"sortable":false}},"exam_target":{"edit":{"label":"exam_target","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"exam_target","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"edit":[[{"name":"base_text","size":6},{"name":"part_of_speech","size":6}],[{"name":"lesson","size":6},{"name":"user","size":6}],[{"name":"target_text","size":6}],[{"name":"exam_base","size":12}],[{"name":"exam_target","size":12}]],"list":["id","base_text","user","target_text"]}}	object	\N	\N
46	plugin_content_manager_configuration_content_types::api::user-profile.user-profile	{"uid":"api::user-profile.user-profile","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"telephone","defaultSortBy":"telephone","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"telephone":{"edit":{"label":"telephone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"telephone","searchable":true,"sortable":true}},"baseLanguage":{"edit":{"label":"baseLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"baseLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","user","telephone","baseLanguage"],"edit":[[{"name":"user","size":6},{"name":"telephone","size":6}],[{"name":"baseLanguage","size":6}]]}}	object	\N	\N
48	plugin_content_manager_configuration_content_types::api::vocapage.vocapage	{"uid":"api::vocapage.vocapage","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"order","searchable":true,"sortable":true}},"vocabook":{"edit":{"label":"vocabook","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"vocabook","searchable":true,"sortable":true}},"flashcards":{"edit":{"label":"flashcards","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"flashcards","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","order","vocabook"],"edit":[[{"name":"title","size":6},{"name":"order","size":4}],[{"name":"vocabook","size":6},{"name":"flashcards","size":6}]]}}	object	\N	\N
43	plugin_content_manager_configuration_content_types::api::flashcard.flashcard	{"uid":"api::flashcard.flashcard","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":100,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"DESC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":false,"sortable":false}},"last_reviewed_at":{"edit":{"label":"last_reviewed_at","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"last_reviewed_at","searchable":true,"sortable":true}},"lesson":{"edit":{"label":"lesson","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"lesson","searchable":true,"sortable":true}},"correct_streak":{"edit":{"label":"correct_streak","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"correct_streak","searchable":true,"sortable":true}},"wrong_streak":{"edit":{"label":"wrong_streak","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"wrong_streak","searchable":true,"sortable":true}},"is_remembered":{"edit":{"label":"is_remembered","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"is_remembered","searchable":true,"sortable":true}},"reviewlogs":{"edit":{"label":"reviewlogs","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"reviewlogs","searchable":false,"sortable":false}},"vocapage":{"edit":{"label":"vocapage","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"vocapage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","user","last_reviewed_at","correct_streak","wrong_streak"],"edit":[[{"name":"user","size":6}],[{"name":"content","size":12}],[{"name":"lesson","size":6},{"name":"last_reviewed_at","size":6}],[{"name":"is_remembered","size":4},{"name":"correct_streak","size":4},{"name":"wrong_streak","size":4}],[{"name":"reviewlogs","size":6},{"name":"vocapage","size":6}]]}}	object	\N	\N
47	plugin_content_manager_configuration_content_types::api::vocabook.vocabook	{"uid":"api::vocabook.vocabook","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"vocapages":{"edit":{"label":"vocapages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"vocapages","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","user","createdAt"],"edit":[[{"name":"title","size":6},{"name":"user","size":6}],[{"name":"vocapages","size":6}]]}}	object	\N	\N
49	plugin_content_manager_configuration_content_types::api::vbsetting.vbsetting	{"uid":"api::vbsetting.vbsetting","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"user","searchable":true,"sortable":true}},"wordsPerPage":{"edit":{"label":"wordsPerPage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"wordsPerPage","searchable":true,"sortable":true}},"interval1":{"edit":{"label":"interval1","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"interval1","searchable":true,"sortable":true}},"interval2":{"edit":{"label":"interval2","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"interval2","searchable":true,"sortable":true}},"interval3":{"edit":{"label":"interval3","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"interval3","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","user","wordsPerPage","interval1"],"edit":[[{"name":"user","size":6},{"name":"wordsPerPage","size":4}],[{"name":"interval1","size":4},{"name":"interval2","size":4},{"name":"interval3","size":4}]]}}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"uid":"plugin::users-permissions.user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":100,"mainField":"username","defaultSortBy":"id","defaultSortOrder":"DESC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"flashcards":{"edit":{"label":"flashcards","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"flashcards","searchable":false,"sortable":false}},"reviewlogs":{"edit":{"label":"reviewlogs","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"reviewlogs","searchable":false,"sortable":false}},"user_profile":{"edit":{"label":"user_profile","description":"","placeholder":"","visible":true,"editable":true,"mainField":"telephone"},"list":{"label":"user_profile","searchable":true,"sortable":true}},"user_words":{"edit":{"label":"user_words","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"user_words","searchable":false,"sortable":false}},"user_sentences":{"edit":{"label":"user_sentences","description":"","placeholder":"","visible":true,"editable":true,"mainField":"target_text"},"list":{"label":"user_sentences","searchable":false,"sortable":false}},"vocabook":{"edit":{"label":"vocabook","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"vocabook","searchable":true,"sortable":true}},"vbsetting":{"edit":{"label":"vbsetting","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"vbsetting","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","role","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}],[{"name":"user_words","size":6},{"name":"user_sentences","size":6}],[{"name":"flashcards","size":6},{"name":"reviewlogs","size":6}],[{"name":"user_profile","size":6},{"name":"vocabook","size":6}],[{"name":"vbsetting","size":6}]]}}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
65	{"tables":[{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users","indexes":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_roles","indexes":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users","indexes":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"flashcards","indexes":[{"name":"flashcards_created_by_id_fk","columns":["created_by_id"]},{"name":"flashcards_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"flashcards_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"flashcards_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"last_reviewed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"correct_streak","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"wrong_streak","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_remembered","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"lessons","indexes":[{"type":"unique","name":"lessons_slug_unique","columns":["slug"]},{"name":"lessons_created_by_id_fk","columns":["created_by_id"]},{"name":"lessons_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"lessons_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"lessons_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false,"unique":true},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"lessonlevels","indexes":[{"name":"lessonlevels_created_by_id_fk","columns":["created_by_id"]},{"name":"lessonlevels_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"lessonlevels_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"lessonlevels_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"level","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"review_tires","indexes":[{"name":"review_tires_created_by_id_fk","columns":["created_by_id"]},{"name":"review_tires_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"review_tires_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"review_tires_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"tier","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"min_streak","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"max_streak","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"cooldown_hours","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"demote_bar","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"reviewlogs","indexes":[{"name":"reviewlogs_created_by_id_fk","columns":["created_by_id"]},{"name":"reviewlogs_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"reviewlogs_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"reviewlogs_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reviewed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"level","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"result","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"sections","indexes":[{"name":"sections_created_by_id_fk","columns":["created_by_id"]},{"name":"sections_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"sections_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"sections_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"sentences","indexes":[{"name":"sentences_created_by_id_fk","columns":["created_by_id"]},{"name":"sentences_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"sentences_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"sentences_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"instruction","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"base_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"target_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"register","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"exam_base","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"exam_target","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"units","indexes":[{"type":"unique","name":"units_slug_unique","columns":["slug"]},{"name":"units_created_by_id_fk","columns":["created_by_id"]},{"name":"units_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"units_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"units_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false,"unique":true},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"user_profiles","indexes":[{"name":"user_profiles_created_by_id_fk","columns":["created_by_id"]},{"name":"user_profiles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"user_profiles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"user_profiles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"telephone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"base_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_sentences","indexes":[{"name":"user_sentences_created_by_id_fk","columns":["created_by_id"]},{"name":"user_sentences_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"user_sentences_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"user_sentences_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"target_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"base_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"user_words","indexes":[{"name":"user_words_created_by_id_fk","columns":["created_by_id"]},{"name":"user_words_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"user_words_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"user_words_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"target_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"base_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"part_of_speech","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"exam_base","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"exam_target","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"vbsettings","indexes":[{"name":"vbsettings_created_by_id_fk","columns":["created_by_id"]},{"name":"vbsettings_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"vbsettings_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"vbsettings_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"words_per_page","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"interval_1","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"interval_2","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"interval_3","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"vocabooks","indexes":[{"name":"vocabooks_created_by_id_fk","columns":["created_by_id"]},{"name":"vocabooks_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"vocabooks_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"vocabooks_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"vocapages","indexes":[{"name":"vocapages_created_by_id_fk","columns":["created_by_id"]},{"name":"vocapages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"vocapages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"vocapages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"words","indexes":[{"name":"words_created_by_id_fk","columns":["created_by_id"]},{"name":"words_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"words_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"words_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"word","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"base_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"instruction","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"part_of_speech","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gender","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"article","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"register","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"exam_base","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"exam_target","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_a_external_videos","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_a_pagebreakers","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"backbutton","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"nextbutton","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_a_quizzes","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"question","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"options","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"answer","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"explanation","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_a_sent_refs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"components_a_taglists","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_a_user_sent_refs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"components_a_user_word_refs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"components_a_verb_metas","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"simple_past","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"past_participle","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"present_participle","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"thirdperson_singular","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"auxiliary_verb","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conjugations","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"components_a_videos","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"components_a_word_refs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false}]},{"name":"admin_permissions_role_links","indexes":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"]},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"admin_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"admin_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_links","indexes":[{"name":"admin_users_roles_links_fk","columns":["user_id"]},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"]},{"name":"admin_users_roles_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_links_order_fk","columns":["role_order"]},{"name":"admin_users_roles_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"admin_users_roles_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_links","indexes":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_links_unique","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_links_order_inv_fk","columns":["api_token_permission_order"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_links_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_links_inv_fk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_links","indexes":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_links_unique","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_links_order_inv_fk","columns":["transfer_token_permission_order"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_links_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_links_inv_fk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_morphs","indexes":[{"name":"files_related_morphs_fk","columns":["file_id"]},{"name":"files_related_morphs_order_index","columns":["order"]},{"name":"files_related_morphs_id_column_index","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_morphs_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_links","indexes":[{"name":"files_folder_links_fk","columns":["file_id"]},{"name":"files_folder_links_inv_fk","columns":["folder_id"]},{"name":"files_folder_links_unique","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_links_order_inv_fk","columns":["file_order"]}],"foreignKeys":[{"name":"files_folder_links_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_links_inv_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_links","indexes":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"]},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_links_unique","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_links_order_inv_fk","columns":["folder_order"]}],"foreignKeys":[{"name":"upload_folders_parent_links_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_links_inv_fk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_links","indexes":[{"name":"up_permissions_role_links_fk","columns":["permission_id"]},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"]},{"name":"up_permissions_role_links_unique","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_links_order_inv_fk","columns":["permission_order"]}],"foreignKeys":[{"name":"up_permissions_role_links_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_links","indexes":[{"name":"up_users_role_links_fk","columns":["user_id"]},{"name":"up_users_role_links_inv_fk","columns":["role_id"]},{"name":"up_users_role_links_unique","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_links_order_inv_fk","columns":["user_order"]}],"foreignKeys":[{"name":"up_users_role_links_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_links_inv_fk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"flashcards_components","indexes":[{"name":"flashcards_field_index","columns":["field"]},{"name":"flashcards_component_type_index","columns":["component_type"]},{"name":"flashcards_entity_fk","columns":["entity_id"]},{"name":"flashcards_unique","columns":["entity_id","component_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"flashcards_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"flashcards_user_links","indexes":[{"name":"flashcards_user_links_fk","columns":["flashcard_id"]},{"name":"flashcards_user_links_inv_fk","columns":["user_id"]},{"name":"flashcards_user_links_unique","columns":["flashcard_id","user_id"],"type":"unique"},{"name":"flashcards_user_links_order_inv_fk","columns":["flashcard_order"]}],"foreignKeys":[{"name":"flashcards_user_links_fk","columns":["flashcard_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"},{"name":"flashcards_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"flashcard_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"flashcard_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"flashcards_lesson_links","indexes":[{"name":"flashcards_lesson_links_fk","columns":["flashcard_id"]},{"name":"flashcards_lesson_links_inv_fk","columns":["lesson_id"]},{"name":"flashcards_lesson_links_unique","columns":["flashcard_id","lesson_id"],"type":"unique"},{"name":"flashcards_lesson_links_order_inv_fk","columns":["flashcard_order"]}],"foreignKeys":[{"name":"flashcards_lesson_links_fk","columns":["flashcard_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"},{"name":"flashcards_lesson_links_inv_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"flashcard_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"flashcard_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"flashcards_vocapage_links","indexes":[{"name":"flashcards_vocapage_links_fk","columns":["flashcard_id"]},{"name":"flashcards_vocapage_links_inv_fk","columns":["vocapage_id"]},{"name":"flashcards_vocapage_links_unique","columns":["flashcard_id","vocapage_id"],"type":"unique"},{"name":"flashcards_vocapage_links_order_inv_fk","columns":["flashcard_order"]}],"foreignKeys":[{"name":"flashcards_vocapage_links_fk","columns":["flashcard_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"},{"name":"flashcards_vocapage_links_inv_fk","columns":["vocapage_id"],"referencedColumns":["id"],"referencedTable":"vocapages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"flashcard_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"vocapage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"flashcard_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"flashcards_localizations_links","indexes":[{"name":"flashcards_localizations_links_fk","columns":["flashcard_id"]},{"name":"flashcards_localizations_links_inv_fk","columns":["inv_flashcard_id"]},{"name":"flashcards_localizations_links_unique","columns":["flashcard_id","inv_flashcard_id"],"type":"unique"},{"name":"flashcards_localizations_links_order_fk","columns":["flashcard_order"]}],"foreignKeys":[{"name":"flashcards_localizations_links_fk","columns":["flashcard_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"},{"name":"flashcards_localizations_links_inv_fk","columns":["inv_flashcard_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"flashcard_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_flashcard_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"flashcard_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lessons_components","indexes":[{"name":"lessons_field_index","columns":["field"]},{"name":"lessons_component_type_index","columns":["component_type"]},{"name":"lessons_entity_fk","columns":["entity_id"]},{"name":"lessons_unique","columns":["entity_id","component_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"lessons_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lessons_lessonlevel_links","indexes":[{"name":"lessons_lessonlevel_links_fk","columns":["lesson_id"]},{"name":"lessons_lessonlevel_links_inv_fk","columns":["lessonlevel_id"]},{"name":"lessons_lessonlevel_links_unique","columns":["lesson_id","lessonlevel_id"],"type":"unique"},{"name":"lessons_lessonlevel_links_order_inv_fk","columns":["lesson_order"]}],"foreignKeys":[{"name":"lessons_lessonlevel_links_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"},{"name":"lessons_lessonlevel_links_inv_fk","columns":["lessonlevel_id"],"referencedColumns":["id"],"referencedTable":"lessonlevels","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lessonlevel_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lessons_unit_links","indexes":[{"name":"lessons_unit_links_fk","columns":["lesson_id"]},{"name":"lessons_unit_links_inv_fk","columns":["unit_id"]},{"name":"lessons_unit_links_unique","columns":["lesson_id","unit_id"],"type":"unique"},{"name":"lessons_unit_links_order_inv_fk","columns":["lesson_order"]}],"foreignKeys":[{"name":"lessons_unit_links_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"},{"name":"lessons_unit_links_inv_fk","columns":["unit_id"],"referencedColumns":["id"],"referencedTable":"units","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"unit_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"lessons_localizations_links","indexes":[{"name":"lessons_localizations_links_fk","columns":["lesson_id"]},{"name":"lessons_localizations_links_inv_fk","columns":["inv_lesson_id"]},{"name":"lessons_localizations_links_unique","columns":["lesson_id","inv_lesson_id"],"type":"unique"},{"name":"lessons_localizations_links_order_fk","columns":["lesson_order"]}],"foreignKeys":[{"name":"lessons_localizations_links_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"},{"name":"lessons_localizations_links_inv_fk","columns":["inv_lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"review_tires_localizations_links","indexes":[{"name":"review_tires_localizations_links_fk","columns":["review_tire_id"]},{"name":"review_tires_localizations_links_inv_fk","columns":["inv_review_tire_id"]},{"name":"review_tires_localizations_links_unique","columns":["review_tire_id","inv_review_tire_id"],"type":"unique"},{"name":"review_tires_localizations_links_order_fk","columns":["review_tire_order"]}],"foreignKeys":[{"name":"review_tires_localizations_links_fk","columns":["review_tire_id"],"referencedColumns":["id"],"referencedTable":"review_tires","onDelete":"CASCADE"},{"name":"review_tires_localizations_links_inv_fk","columns":["inv_review_tire_id"],"referencedColumns":["id"],"referencedTable":"review_tires","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"review_tire_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_review_tire_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"review_tire_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"reviewlogs_user_links","indexes":[{"name":"reviewlogs_user_links_fk","columns":["reviewlog_id"]},{"name":"reviewlogs_user_links_inv_fk","columns":["user_id"]},{"name":"reviewlogs_user_links_unique","columns":["reviewlog_id","user_id"],"type":"unique"},{"name":"reviewlogs_user_links_order_inv_fk","columns":["reviewlog_order"]}],"foreignKeys":[{"name":"reviewlogs_user_links_fk","columns":["reviewlog_id"],"referencedColumns":["id"],"referencedTable":"reviewlogs","onDelete":"CASCADE"},{"name":"reviewlogs_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reviewlog_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reviewlog_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"reviewlogs_flashcard_links","indexes":[{"name":"reviewlogs_flashcard_links_fk","columns":["reviewlog_id"]},{"name":"reviewlogs_flashcard_links_inv_fk","columns":["flashcard_id"]},{"name":"reviewlogs_flashcard_links_unique","columns":["reviewlog_id","flashcard_id"],"type":"unique"},{"name":"reviewlogs_flashcard_links_order_inv_fk","columns":["reviewlog_order"]}],"foreignKeys":[{"name":"reviewlogs_flashcard_links_fk","columns":["reviewlog_id"],"referencedColumns":["id"],"referencedTable":"reviewlogs","onDelete":"CASCADE"},{"name":"reviewlogs_flashcard_links_inv_fk","columns":["flashcard_id"],"referencedColumns":["id"],"referencedTable":"flashcards","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reviewlog_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"flashcard_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reviewlog_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"sections_components","indexes":[{"name":"sections_field_index","columns":["field"]},{"name":"sections_component_type_index","columns":["component_type"]},{"name":"sections_entity_fk","columns":["entity_id"]},{"name":"sections_unique","columns":["entity_id","component_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"sections_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"sections","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"sections_lesson_links","indexes":[{"name":"sections_lesson_links_fk","columns":["section_id"]},{"name":"sections_lesson_links_inv_fk","columns":["lesson_id"]},{"name":"sections_lesson_links_unique","columns":["section_id","lesson_id"],"type":"unique"},{"name":"sections_lesson_links_order_inv_fk","columns":["section_order"]}],"foreignKeys":[{"name":"sections_lesson_links_fk","columns":["section_id"],"referencedColumns":["id"],"referencedTable":"sections","onDelete":"CASCADE"},{"name":"sections_lesson_links_inv_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"section_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"section_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"sections_localizations_links","indexes":[{"name":"sections_localizations_links_fk","columns":["section_id"]},{"name":"sections_localizations_links_inv_fk","columns":["inv_section_id"]},{"name":"sections_localizations_links_unique","columns":["section_id","inv_section_id"],"type":"unique"},{"name":"sections_localizations_links_order_fk","columns":["section_order"]}],"foreignKeys":[{"name":"sections_localizations_links_fk","columns":["section_id"],"referencedColumns":["id"],"referencedTable":"sections","onDelete":"CASCADE"},{"name":"sections_localizations_links_inv_fk","columns":["inv_section_id"],"referencedColumns":["id"],"referencedTable":"sections","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"section_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_section_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"section_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"sentences_components","indexes":[{"name":"sentences_field_index","columns":["field"]},{"name":"sentences_component_type_index","columns":["component_type"]},{"name":"sentences_entity_fk","columns":["entity_id"]},{"name":"sentences_unique","columns":["entity_id","component_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"sentences_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"sentences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"sentences_localizations_links","indexes":[{"name":"sentences_localizations_links_fk","columns":["sentence_id"]},{"name":"sentences_localizations_links_inv_fk","columns":["inv_sentence_id"]},{"name":"sentences_localizations_links_unique","columns":["sentence_id","inv_sentence_id"],"type":"unique"},{"name":"sentences_localizations_links_order_fk","columns":["sentence_order"]}],"foreignKeys":[{"name":"sentences_localizations_links_fk","columns":["sentence_id"],"referencedColumns":["id"],"referencedTable":"sentences","onDelete":"CASCADE"},{"name":"sentences_localizations_links_inv_fk","columns":["inv_sentence_id"],"referencedColumns":["id"],"referencedTable":"sentences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"sentence_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"units_precondition_links","indexes":[{"name":"units_precondition_links_fk","columns":["unit_id"]},{"name":"units_precondition_links_inv_fk","columns":["inv_unit_id"]},{"name":"units_precondition_links_unique","columns":["unit_id","inv_unit_id"],"type":"unique"}],"foreignKeys":[{"name":"units_precondition_links_fk","columns":["unit_id"],"referencedColumns":["id"],"referencedTable":"units","onDelete":"CASCADE"},{"name":"units_precondition_links_inv_fk","columns":["inv_unit_id"],"referencedColumns":["id"],"referencedTable":"units","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"unit_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_unit_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"units_localizations_links","indexes":[{"name":"units_localizations_links_fk","columns":["unit_id"]},{"name":"units_localizations_links_inv_fk","columns":["inv_unit_id"]},{"name":"units_localizations_links_unique","columns":["unit_id","inv_unit_id"],"type":"unique"},{"name":"units_localizations_links_order_fk","columns":["unit_order"]}],"foreignKeys":[{"name":"units_localizations_links_fk","columns":["unit_id"],"referencedColumns":["id"],"referencedTable":"units","onDelete":"CASCADE"},{"name":"units_localizations_links_inv_fk","columns":["inv_unit_id"],"referencedColumns":["id"],"referencedTable":"units","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"unit_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_unit_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"unit_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_profiles_user_links","indexes":[{"name":"user_profiles_user_links_fk","columns":["user_profile_id"]},{"name":"user_profiles_user_links_inv_fk","columns":["user_id"]},{"name":"user_profiles_user_links_unique","columns":["user_profile_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"user_profiles_user_links_fk","columns":["user_profile_id"],"referencedColumns":["id"],"referencedTable":"user_profiles","onDelete":"CASCADE"},{"name":"user_profiles_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_profile_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_sentences_user_links","indexes":[{"name":"user_sentences_user_links_fk","columns":["user_sentence_id"]},{"name":"user_sentences_user_links_inv_fk","columns":["user_id"]},{"name":"user_sentences_user_links_unique","columns":["user_sentence_id","user_id"],"type":"unique"},{"name":"user_sentences_user_links_order_inv_fk","columns":["user_sentence_order"]}],"foreignKeys":[{"name":"user_sentences_user_links_fk","columns":["user_sentence_id"],"referencedColumns":["id"],"referencedTable":"user_sentences","onDelete":"CASCADE"},{"name":"user_sentences_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_sentence_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_sentences_lesson_links","indexes":[{"name":"user_sentences_lesson_links_fk","columns":["user_sentence_id"]},{"name":"user_sentences_lesson_links_inv_fk","columns":["lesson_id"]},{"name":"user_sentences_lesson_links_unique","columns":["user_sentence_id","lesson_id"],"type":"unique"},{"name":"user_sentences_lesson_links_order_inv_fk","columns":["user_sentence_order"]}],"foreignKeys":[{"name":"user_sentences_lesson_links_fk","columns":["user_sentence_id"],"referencedColumns":["id"],"referencedTable":"user_sentences","onDelete":"CASCADE"},{"name":"user_sentences_lesson_links_inv_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_sentence_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_sentences_localizations_links","indexes":[{"name":"user_sentences_localizations_links_fk","columns":["user_sentence_id"]},{"name":"user_sentences_localizations_links_inv_fk","columns":["inv_user_sentence_id"]},{"name":"user_sentences_localizations_links_unique","columns":["user_sentence_id","inv_user_sentence_id"],"type":"unique"},{"name":"user_sentences_localizations_links_order_fk","columns":["user_sentence_order"]}],"foreignKeys":[{"name":"user_sentences_localizations_links_fk","columns":["user_sentence_id"],"referencedColumns":["id"],"referencedTable":"user_sentences","onDelete":"CASCADE"},{"name":"user_sentences_localizations_links_inv_fk","columns":["inv_user_sentence_id"],"referencedColumns":["id"],"referencedTable":"user_sentences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_user_sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_sentence_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_words_user_links","indexes":[{"name":"user_words_user_links_fk","columns":["user_word_id"]},{"name":"user_words_user_links_inv_fk","columns":["user_id"]},{"name":"user_words_user_links_unique","columns":["user_word_id","user_id"],"type":"unique"},{"name":"user_words_user_links_order_inv_fk","columns":["user_word_order"]}],"foreignKeys":[{"name":"user_words_user_links_fk","columns":["user_word_id"],"referencedColumns":["id"],"referencedTable":"user_words","onDelete":"CASCADE"},{"name":"user_words_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_word_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_words_lesson_links","indexes":[{"name":"user_words_lesson_links_fk","columns":["user_word_id"]},{"name":"user_words_lesson_links_inv_fk","columns":["lesson_id"]},{"name":"user_words_lesson_links_unique","columns":["user_word_id","lesson_id"],"type":"unique"},{"name":"user_words_lesson_links_order_inv_fk","columns":["user_word_order"]}],"foreignKeys":[{"name":"user_words_lesson_links_fk","columns":["user_word_id"],"referencedColumns":["id"],"referencedTable":"user_words","onDelete":"CASCADE"},{"name":"user_words_lesson_links_inv_fk","columns":["lesson_id"],"referencedColumns":["id"],"referencedTable":"lessons","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"lesson_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_word_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"user_words_localizations_links","indexes":[{"name":"user_words_localizations_links_fk","columns":["user_word_id"]},{"name":"user_words_localizations_links_inv_fk","columns":["inv_user_word_id"]},{"name":"user_words_localizations_links_unique","columns":["user_word_id","inv_user_word_id"],"type":"unique"},{"name":"user_words_localizations_links_order_fk","columns":["user_word_order"]}],"foreignKeys":[{"name":"user_words_localizations_links_fk","columns":["user_word_id"],"referencedColumns":["id"],"referencedTable":"user_words","onDelete":"CASCADE"},{"name":"user_words_localizations_links_inv_fk","columns":["inv_user_word_id"],"referencedColumns":["id"],"referencedTable":"user_words","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_user_word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_word_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"vbsettings_user_links","indexes":[{"name":"vbsettings_user_links_fk","columns":["vbsetting_id"]},{"name":"vbsettings_user_links_inv_fk","columns":["user_id"]},{"name":"vbsettings_user_links_unique","columns":["vbsetting_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"vbsettings_user_links_fk","columns":["vbsetting_id"],"referencedColumns":["id"],"referencedTable":"vbsettings","onDelete":"CASCADE"},{"name":"vbsettings_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"vbsetting_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"vocabooks_user_links","indexes":[{"name":"vocabooks_user_links_fk","columns":["vocabook_id"]},{"name":"vocabooks_user_links_inv_fk","columns":["user_id"]},{"name":"vocabooks_user_links_unique","columns":["vocabook_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"vocabooks_user_links_fk","columns":["vocabook_id"],"referencedColumns":["id"],"referencedTable":"vocabooks","onDelete":"CASCADE"},{"name":"vocabooks_user_links_inv_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"vocabook_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"vocapages_vocabook_links","indexes":[{"name":"vocapages_vocabook_links_fk","columns":["vocapage_id"]},{"name":"vocapages_vocabook_links_inv_fk","columns":["vocabook_id"]},{"name":"vocapages_vocabook_links_unique","columns":["vocapage_id","vocabook_id"],"type":"unique"},{"name":"vocapages_vocabook_links_order_inv_fk","columns":["vocapage_order"]}],"foreignKeys":[{"name":"vocapages_vocabook_links_fk","columns":["vocapage_id"],"referencedColumns":["id"],"referencedTable":"vocapages","onDelete":"CASCADE"},{"name":"vocapages_vocabook_links_inv_fk","columns":["vocabook_id"],"referencedColumns":["id"],"referencedTable":"vocabooks","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"vocapage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"vocabook_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"vocapage_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"words_components","indexes":[{"name":"words_field_index","columns":["field"]},{"name":"words_component_type_index","columns":["component_type"]},{"name":"words_entity_fk","columns":["entity_id"]},{"name":"words_unique","columns":["entity_id","component_id","field","component_type"],"type":"unique"}],"foreignKeys":[{"name":"words_entity_fk","columns":["entity_id"],"referencedColumns":["id"],"referencedTable":"words","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"entity_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"component_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"words_example_sentences_links","indexes":[{"name":"words_example_sentences_links_fk","columns":["word_id"]},{"name":"words_example_sentences_links_inv_fk","columns":["sentence_id"]},{"name":"words_example_sentences_links_unique","columns":["word_id","sentence_id"],"type":"unique"},{"name":"words_example_sentences_links_order_fk","columns":["sentence_order"]},{"name":"words_example_sentences_links_order_inv_fk","columns":["word_order"]}],"foreignKeys":[{"name":"words_example_sentences_links_fk","columns":["word_id"],"referencedColumns":["id"],"referencedTable":"words","onDelete":"CASCADE"},{"name":"words_example_sentences_links_inv_fk","columns":["sentence_id"],"referencedColumns":["id"],"referencedTable":"sentences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"sentence_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"word_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"words_localizations_links","indexes":[{"name":"words_localizations_links_fk","columns":["word_id"]},{"name":"words_localizations_links_inv_fk","columns":["inv_word_id"]},{"name":"words_localizations_links_unique","columns":["word_id","inv_word_id"],"type":"unique"},{"name":"words_localizations_links_order_fk","columns":["word_order"]}],"foreignKeys":[{"name":"words_localizations_links_fk","columns":["word_id"],"referencedColumns":["id"],"referencedTable":"words","onDelete":"CASCADE"},{"name":"words_localizations_links_inv_fk","columns":["inv_word_id"],"referencedColumns":["id"],"referencedTable":"words","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"word_order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_a_sent_refs_sentence_links","indexes":[{"name":"components_a_sent_refs_sentence_links_fk","columns":["sent_ref_id"]},{"name":"components_a_sent_refs_sentence_links_inv_fk","columns":["sentence_id"]},{"name":"components_a_sent_refs_sentence_links_unique","columns":["sent_ref_id","sentence_id"],"type":"unique"}],"foreignKeys":[{"name":"components_a_sent_refs_sentence_links_fk","columns":["sent_ref_id"],"referencedColumns":["id"],"referencedTable":"components_a_sent_refs","onDelete":"CASCADE"},{"name":"components_a_sent_refs_sentence_links_inv_fk","columns":["sentence_id"],"referencedColumns":["id"],"referencedTable":"sentences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"sent_ref_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_a_user_sent_refs_user_sentence_links","indexes":[{"name":"components_a_user_sent_refs_user_sentence_links_fk","columns":["user_sent_ref_id"]},{"name":"components_a_user_sent_refs_user_sentence_links_inv_fk","columns":["user_sentence_id"]},{"name":"components_a_user_sent_refs_user_sentence_links_unique","columns":["user_sent_ref_id","user_sentence_id"],"type":"unique"}],"foreignKeys":[{"name":"components_a_user_sent_refs_user_sentence_links_fk","columns":["user_sent_ref_id"],"referencedColumns":["id"],"referencedTable":"components_a_user_sent_refs","onDelete":"CASCADE"},{"name":"components_a_user_sent_refs_user_sentence_links_inv_fk","columns":["user_sentence_id"],"referencedColumns":["id"],"referencedTable":"user_sentences","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_sent_ref_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_sentence_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_a_user_word_refs_user_word_links","indexes":[{"name":"components_a_user_word_refs_user_word_links_fk","columns":["user_word_ref_id"]},{"name":"components_a_user_word_refs_user_word_links_inv_fk","columns":["user_word_id"]},{"name":"components_a_user_word_refs_user_word_links_unique","columns":["user_word_ref_id","user_word_id"],"type":"unique"}],"foreignKeys":[{"name":"components_a_user_word_refs_user_word_links_fk","columns":["user_word_ref_id"],"referencedColumns":["id"],"referencedTable":"components_a_user_word_refs","onDelete":"CASCADE"},{"name":"components_a_user_word_refs_user_word_links_inv_fk","columns":["user_word_id"],"referencedColumns":["id"],"referencedTable":"user_words","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_word_ref_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"components_a_word_refs_word_links","indexes":[{"name":"components_a_word_refs_word_links_fk","columns":["word_ref_id"]},{"name":"components_a_word_refs_word_links_inv_fk","columns":["word_id"]},{"name":"components_a_word_refs_word_links_unique","columns":["word_ref_id","word_id"],"type":"unique"}],"foreignKeys":[{"name":"components_a_word_refs_word_links_fk","columns":["word_ref_id"],"referencedColumns":["id"],"referencedTable":"components_a_word_refs","onDelete":"CASCADE"},{"name":"components_a_word_refs_word_links_inv_fk","columns":["word_id"],"referencedColumns":["id"],"referencedTable":"words","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"word_ref_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"word_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2025-07-08 22:18:17.633	aab09671a0a2cd4a5fd2bb9e305bd7aa
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.units (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
1	Unit 1 Greeting	unit-1-greenting	Learn Greeting	1	2025-06-24 00:38:03.361	2025-06-24 00:38:03.361	1	1	en
2	Unit 2 Occupation	unit-2-occupation	Learn Occupation	2	2025-06-24 00:38:35.7	2025-06-28 21:53:56.655	1	1	en
\.


--
-- Data for Name: units_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.units_localizations_links (id, unit_id, inv_unit_id, unit_order) FROM stdin;
\.


--
-- Data for Name: units_precondition_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.units_precondition_links (id, unit_id, inv_unit_id) FROM stdin;
2	1	2
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	plugin::users-permissions.user.me	2025-06-23 17:47:30.388	2025-06-23 17:47:30.388	\N	\N
7	plugin::users-permissions.auth.connect	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
3	plugin::users-permissions.auth.forgotPassword	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
6	plugin::users-permissions.auth.emailConfirmation	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
4	plugin::users-permissions.auth.register	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
8	plugin::users-permissions.auth.sendEmailConfirmation	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
9	plugin::users-permissions.auth.resetPassword	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
11	api::flashcard.flashcard.findOne	2025-06-27 18:01:55.539	2025-06-27 18:01:55.539	\N	\N
10	api::flashcard.flashcard.find	2025-06-27 18:01:55.539	2025-06-27 18:01:55.539	\N	\N
16	plugin::users-permissions.user.update	2025-06-28 02:56:42.878	2025-06-28 02:56:42.878	\N	\N
18	api::flashcard.flashcard.find	2025-06-28 10:53:26.215	2025-06-28 10:53:26.215	\N	\N
19	api::flashcard.flashcard.create	2025-06-28 10:53:26.215	2025-06-28 10:53:26.215	\N	\N
20	api::flashcard.flashcard.update	2025-06-28 10:53:26.215	2025-06-28 10:53:26.215	\N	\N
17	api::flashcard.flashcard.findOne	2025-06-28 10:53:26.215	2025-06-28 10:53:26.215	\N	\N
22	api::flashcard.flashcard.findForReview	2025-06-28 16:38:34.388	2025-06-28 16:38:34.388	\N	\N
2	plugin::users-permissions.auth.changePassword	2025-06-23 17:47:30.388	2025-06-23 17:47:30.388	\N	\N
5	plugin::users-permissions.auth.callback	2025-06-23 17:47:30.589	2025-06-23 17:47:30.589	\N	\N
26	api::reviewlog.reviewlog.create	2025-06-29 23:26:45.758	2025-06-29 23:26:45.758	\N	\N
27	api::reviewlog.reviewlog.update	2025-06-29 23:26:45.758	2025-06-29 23:26:45.758	\N	\N
29	api::reviewlog.reviewlog.find	2025-06-30 00:33:03.321	2025-06-30 00:33:03.321	\N	\N
30	api::reviewlog.reviewlog.findOne	2025-06-30 00:33:03.321	2025-06-30 00:33:03.321	\N	\N
31	api::flashcard.flashcard.review	2025-06-30 17:00:02.589	2025-06-30 17:00:02.589	\N	\N
32	api::flashcard.flashcard.getStatistics	2025-07-01 02:23:26.538	2025-07-01 02:23:26.538	\N	\N
33	api::user-profile.user-profile.findMine	2025-07-01 11:20:48.143	2025-07-01 11:20:48.143	\N	\N
34	api::user-profile.user-profile.updateMine	2025-07-01 11:20:48.143	2025-07-01 11:20:48.143	\N	\N
35	api::user-profile.user-profile.registerWithProfile	2025-07-01 11:43:03.585	2025-07-01 11:43:03.585	\N	\N
38	api::lesson.lesson.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
37	api::lesson.lesson.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
39	api::lessonlevel.lessonlevel.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
40	api::lessonlevel.lessonlevel.update	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
41	api::review-tire.review-tire.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
42	api::review-tire.review-tire.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
44	api::section.section.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
43	api::section.section.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
45	api::sentence.sentence.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
46	api::sentence.sentence.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
47	api::unit.unit.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
48	api::user-sentence.user-sentence.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
49	api::user-sentence.user-sentence.update	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
50	api::unit.unit.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
51	api::user-profile.user-profile.registerWithProfile	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
52	api::user-sentence.user-sentence.create	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
53	api::user-sentence.user-sentence.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
54	api::user-sentence.user-sentence.createLocalization	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
55	api::user-word.user-word.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
57	api::user-word.user-word.update	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
56	api::user-sentence.user-sentence.delete	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
59	api::user-word.user-word.delete	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
58	api::user-word.user-word.create	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
60	api::user-word.user-word.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
61	api::user-word.user-word.createLocalization	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
62	api::word.word.find	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
63	api::word.word.findOne	2025-07-01 14:20:26.011	2025-07-01 14:20:26.011	\N	\N
68	api::translate-word.translate-word.translate	2025-07-02 08:43:14.09	2025-07-02 08:43:14.09	\N	\N
77	plugin::users-permissions.user.find	2025-07-07 20:02:08.43	2025-07-07 20:02:08.43	\N	\N
78	plugin::users-permissions.user.findOne	2025-07-07 20:02:08.43	2025-07-07 20:02:08.43	\N	\N
79	api::vocabook.vocabook.findMyVocabook	2025-07-07 20:26:54.788	2025-07-07 20:26:54.788	\N	\N
80	api::vocapage.vocapage.findMyVocapage	2025-07-07 21:08:01.683	2025-07-07 21:08:01.683	\N	\N
81	api::vocabook.vocabook.findOne	2025-07-07 21:47:27.448	2025-07-07 21:47:27.448	\N	\N
82	api::vocapage.vocapage.find	2025-07-07 21:47:27.448	2025-07-07 21:47:27.448	\N	\N
83	api::vocabook.vocabook.find	2025-07-07 21:47:27.448	2025-07-07 21:47:27.448	\N	\N
84	api::vocapage.vocapage.findOne	2025-07-07 21:47:27.448	2025-07-07 21:47:27.448	\N	\N
\.


--
-- Data for Name: up_permissions_role_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
1	1	1	1
2	2	1	1
3	4	2	1
4	3	2	1
5	5	2	1
6	6	2	1
7	9	2	1
8	8	2	1
9	7	2	1
10	10	2	2
11	11	2	2
16	16	1	2
17	18	1	3
18	17	1	3
19	19	1	3
20	20	1	4
22	22	1	5
26	27	1	8
27	26	1	8
29	29	1	10
30	30	1	10
31	31	1	11
32	32	1	12
34	33	1	13
33	34	1	13
35	35	2	3
37	43	1	14
38	44	1	14
39	40	1	14
40	37	1	14
41	39	1	14
42	42	1	14
43	45	1	14
44	38	1	14
45	46	1	14
46	41	1	14
47	48	1	15
48	49	1	15
49	47	1	15
50	53	1	15
51	50	1	15
53	51	1	15
54	54	1	15
55	52	1	15
52	55	1	15
56	61	1	15
57	59	1	16
58	57	1	16
59	62	1	16
60	63	1	16
61	56	1	16
62	58	1	16
63	60	1	16
68	68	1	17
77	77	1	20
78	78	1	20
79	79	1	21
80	80	1	22
81	83	1	23
82	81	1	23
83	82	1	23
84	84	1	24
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
2	Public	Default role given to unauthenticated user.	public	2025-06-23 17:47:30.213	2025-07-01 11:43:29.116	\N	\N
1	Authenticated	Default role given to authenticated user.	authenticated	2025-06-23 17:47:30.092	2025-07-07 22:02:45.441	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
7	James@langGo.com	james@langgo.com	local	$2a$10$Ml5gJ9DX/oshp3t5wXsfOuGyKqRxot4wIrZfafkrZ0dV8.AfFtazK	\N	\N	t	f	2025-06-27 23:00:28.014	2025-06-27 23:00:28.014	\N	\N
8	viv	vivian@langgo.com	local	$2a$10$ONHe/w5EtfUm8ZoE8kdAqemv.KnkF68zanjCbcrHOfD6W.oEwbC8u	\N	\N	t	f	2025-06-27 23:01:16.676	2025-06-28 02:58:48.391	\N	\N
24	produser_july5	prod_july5@example.com	local	$2a$10$BPKwvuAUbMANSlz9G/Egz.wmn.7I0vnCRCOhIZlsaPz5OuEyioqwe	\N	\N	t	f	2025-07-06 17:06:32.544	2025-07-06 17:06:32.544	\N	\N
25	produser_july6	prod_july6@example.com	local	$2a$10$J/OBRHa8BKv8AgmXxNW7Iej7y8ffofwH.o9c3qxBs3BL4qEU/XfmC	\N	\N	t	f	2025-07-06 17:06:37.506	2025-07-06 17:06:37.506	\N	\N
26	produser_july9	prod_july9@example.com	local	$2a$10$9gSc9pXBQ/f3TXUACkVphOqGC0HIyLBSaG3mULiCtXGKaiTr/SFSu	\N	\N	t	f	2025-07-06 19:07:58.43	2025-07-06 19:07:58.43	\N	\N
28	newuser2@langgo.com	newuser2@langgo.com	local	$2a$10$XzCpoh8xhjANYJWC/0rQnen4vkokeMDxGEA48H8jMTncNuTSolPIm	\N	\N	t	f	2025-07-06 19:30:52.538	2025-07-06 19:30:52.538	\N	\N
29	newuser4@langgo.com	newuser4@langgo.com	local	$2a$10$O5FQTMtEUUt5wQvmsZxPnOMpI3wt6C400qFi7wGSNJ8xjUbFK51ZC	\N	\N	t	f	2025-07-07 08:53:42.004	2025-07-07 08:53:42.004	\N	\N
30	july7	july7@example.com	local	$2a$10$kXBlASWZhapfz5KEso/fyONEYpTPA4YKGU4qUgvlAU0v3hrgshlzy	\N	\N	t	f	2025-07-07 15:35:47.855	2025-07-07 15:35:47.855	\N	\N
\.


--
-- Data for Name: up_users_role_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
7	7	1	5
8	8	1	6
20	24	1	7
21	25	1	8
22	26	1	9
23	28	1	10
24	29	1	11
25	30	1	12
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: upload_folders_parent_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_profiles (id, telephone, base_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	\N	Mandarin	2025-07-01 11:48:52.765	2025-07-01 11:48:52.765	\N	\N
2	\N	Chinese, Simplified	2025-07-01 14:16:54.228	2025-07-01 14:16:54.228	\N	\N
3	\N	en	2025-07-01 19:13:47.642	2025-07-01 19:13:47.642	\N	\N
4	\N	ko	2025-07-01 21:21:17.304	2025-07-01 21:21:17.304	\N	\N
5	\N	zh-Hans	2025-07-06 19:18:09.537	2025-07-06 19:18:09.537	\N	\N
\.


--
-- Data for Name: user_profiles_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_profiles_user_links (id, user_profile_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_sentences; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_sentences (id, target_text, base_text, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
1	I am going to school tomorrow.	我明天去上学。	2025-06-28 21:57:55.46	2025-06-28 21:57:55.46	1	1	en
\.


--
-- Data for Name: user_sentences_lesson_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_sentences_lesson_links (id, user_sentence_id, lesson_id, user_sentence_order) FROM stdin;
1	1	1	1
\.


--
-- Data for Name: user_sentences_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_sentences_localizations_links (id, user_sentence_id, inv_user_sentence_id, user_sentence_order) FROM stdin;
\.


--
-- Data for Name: user_sentences_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_sentences_user_links (id, user_sentence_id, user_id, user_sentence_order) FROM stdin;
\.


--
-- Data for Name: user_words; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_words (id, base_text, part_of_speech, created_at, updated_at, created_by_id, updated_by_id, locale, target_text, exam_base, exam_target) FROM stdin;
1	你好	verb	2025-06-27 09:06:35.621	2025-06-28 21:58:41.231	1	1	en	hello	\N	\N
2	电话	\N	2025-07-01 01:09:44.184	2025-07-01 01:09:44.184	1	1	en	phone	\N	\N
3	大门	noun	2025-07-01 22:28:06.822	2025-07-01 22:28:06.822	\N	\N	en	gate	\N	\N
4	牙齿	noun	2025-07-01 22:31:29.795	2025-07-01 22:31:29.795	\N	\N	en	tooth	\N	\N
5	语言	noun	2025-07-01 23:01:44.583	2025-07-01 23:01:44.583	\N	\N	en	language	\N	\N
11	Apple	noun	2025-07-01 23:21:25.715	2025-07-01 23:21:25.715	\N	\N	en	apple	\N	\N
12	内容	noun	2025-07-01 23:29:14.501	2025-07-01 23:29:14.501	\N	\N	en	content	\N	\N
18	测试	noun	2025-07-02 00:19:27.27	2025-07-02 00:19:27.27	\N	\N	en	test	\N	\N
17	键盘	noun	2025-07-02 00:18:17.533	2025-07-02 00:31:53.639	\N	1	en	keyboard	\N	\N
15	屏幕	noun	2025-07-02 00:08:15.039	2025-07-02 00:32:13.659	\N	1	en	screen	\N	\N
19	包包	noun	2025-07-02 00:19:46.537	2025-07-02 00:32:36.208	\N	1	en	bag	\N	\N
20	计算机	noun	2025-07-02 00:27:10.933	2025-07-02 00:32:57.244	\N	1	en	computer	\N	\N
16	汽车	noun	2025-07-02 00:16:16.918	2025-07-02 00:33:11.338	\N	1	en	car	\N	\N
21	细节	noun	2025-07-02 00:43:22.394	2025-07-02 00:43:22.394	\N	\N	en	detail	\N	\N
22	飞 	noun	2025-07-02 00:46:02.604	2025-07-02 00:46:02.604	\N	\N	en	fly	\N	\N
23	 花 	noun	2025-07-02 00:49:18.948	2025-07-02 00:49:18.948	\N	\N	en	flower	\N	\N
24	核实	noun	2025-07-02 10:04:22.693	2025-07-02 10:04:22.693	\N	\N	en	verify	\N	\N
25	满足	verb	2025-07-02 10:16:30.315	2025-07-02 10:16:30.315	\N	\N	en	satisfy	\N	\N
36	欺诈罪	noun	2025-07-02 14:18:57.871	2025-07-02 14:18:57.871	\N	\N	en	fraud	\N	\N
37	 完成 	noun	2025-07-02 14:39:05.934	2025-07-02 14:39:05.934	\N	\N	en	 Finish 	\N	\N
30	初始化	noun	2025-07-02 12:37:06.109	2025-07-02 20:49:43.384	\N	1	en	initialize	\N	\N
31	交换	noun	2025-07-02 12:40:12.893	2025-07-02 20:49:57.261	\N	1	en	swap	\N	\N
33	动画片	noun	2025-07-02 12:59:39.382	2025-07-02 20:50:11.514	\N	1	en	animation	\N	\N
28	 危机 	noun	2025-07-02 12:15:21.658	2025-07-02 20:50:26.139	\N	1	en	Crisis	\N	\N
35	 市场 	noun	2025-07-02 14:07:30.149	2025-07-02 20:50:40.394	\N	1	en	 market 	\N	\N
26	 开始  	noun	2025-07-02 10:31:40.975	2025-07-02 20:50:52.975	\N	1	en	start 	\N	\N
27	成功地	adverb	2025-07-02 10:32:15.623	2025-07-02 20:51:08.881	\N	1	en	successfully	\N	\N
29	模型	noun	2025-07-02 12:32:50.208	2025-07-02 20:51:23.511	\N	1	en	model	\N	\N
32	连词	noun	2025-07-02 12:46:06.902	2025-07-02 20:51:36.024	\N	1	en	Conjunction	\N	\N
34	重点	noun	2025-07-02 14:06:50.812	2025-07-02 20:51:48.272	\N	1	en	focus	\N	\N
38	减轻	noun	2025-07-02 20:55:27.436	2025-07-02 20:55:27.436	\N	\N	en	alleviate	\N	\N
39	自动	noun	2025-07-03 00:33:12.206	2025-07-03 00:33:12.206	\N	\N	en	automatical	\N	\N
40	 创新 	noun	2025-07-03 00:34:21.035	2025-07-03 00:34:21.035	\N	\N	en	Innovation	\N	\N
41	砍死一个蜘蛛	noun	2025-07-06 00:30:36.143	2025-07-06 00:30:36.143	\N	\N	en	Kill a spider	\N	\N
42	高调宣布	noun	2025-07-06 00:31:27.414	2025-07-06 00:31:27.414	\N	\N	en	High-profile announcement	\N	\N
43	安全措施	noun	2025-07-06 00:54:27.653	2025-07-06 00:54:27.653	\N	\N	en	Safety measures	\N	\N
44	令人震惊的交易	noun	2025-07-06 00:54:52.754	2025-07-06 00:54:52.754	\N	\N	en	shocking deal	\N	\N
45	 前槽牙	noun	2025-07-06 01:19:01.92	2025-07-06 01:19:01.92	\N	\N	en	Anterior molars	\N	\N
46	 关系 	noun	2025-07-06 21:28:52.748	2025-07-06 21:28:52.748	\N	\N	en	 relation 	\N	\N
47	 真正 	noun	2025-07-06 21:49:40.088	2025-07-06 21:49:40.088	\N	\N	en	 real 	\N	\N
48	狗	noun	2025-07-07 14:25:52.376	2025-07-07 14:25:52.376	\N	\N	en	dog	[{"text": "猫", "isCorrect": false}, {"text": "鱼", "isCorrect": false}, {"text": "狗", "isCorrect": true}, {"text": "猪", "isCorrect": false}]	[{"text": "hamster", "isCorrect": false}, {"text": "cat", "isCorrect": false}, {"text": "puppy", "isCorrect": false}, {"text": "dog", "isCorrect": true}]
49	 后退	noun	2025-07-07 14:40:25.366	2025-07-07 14:40:25.366	\N	\N	en	 后退	[{"text": "左转", "isCorrect": false}, {"text": "倒退", "isCorrect": false}, {"text": " 后退", "isCorrect": true}, {"text": "前进", "isCorrect": false}]	[{"text": "倒车", "isCorrect": false}, {"text": " 后退", "isCorrect": true}, {"text": "靠近", "isCorrect": false}, {"text": "前进", "isCorrect": false}]
50	猫	noun	2025-07-07 14:43:19.233	2025-07-07 14:43:19.233	\N	\N	en	cat	[{"text": "鸟", "isCorrect": false}, {"text": "狗", "isCorrect": false}, {"text": "猫", "isCorrect": true}, {"text": "马", "isCorrect": false}]	[{"text": "rat", "isCorrect": false}, {"text": "cow", "isCorrect": false}, {"text": "cat", "isCorrect": true}, {"text": "dog", "isCorrect": false}]
51	狮子	noun	2025-07-07 15:07:10.227	2025-07-07 15:07:10.227	\N	\N	en	lion	[{"text": "老虎", "isCorrect": false}, {"text": "狮子", "isCorrect": true}, {"text": "豹子", "isCorrect": false}, {"text": "獾", "isCorrect": false}]	[{"text": "leopard", "isCorrect": false}, {"text": "elephant", "isCorrect": false}, {"text": "tiger", "isCorrect": false}, {"text": "lion", "isCorrect": true}]
52	工具	noun	2025-07-07 15:27:51.662	2025-07-07 15:27:51.662	\N	\N	en	tool	[{"text": "器械", "isCorrect": false}, {"text": "工具", "isCorrect": true}, {"text": "装置", "isCorrect": false}, {"text": "仪器", "isCorrect": false}]	[{"text": "tool", "isCorrect": true}, {"text": "implement", "isCorrect": false}, {"text": "device", "isCorrect": false}, {"text": "utensil", "isCorrect": false}]
53	南方	noun	2025-07-07 15:34:26.016	2025-07-07 15:34:26.016	\N	\N	en	south	[{"text": "南方", "isCorrect": true}, {"text": "东方", "isCorrect": false}, {"text": "西方", "isCorrect": false}, {"text": "北面", "isCorrect": false}]	[{"text": "east", "isCorrect": false}, {"text": "bottom", "isCorrect": false}, {"text": "south", "isCorrect": true}, {"text": "west", "isCorrect": false}]
54	南方	noun	2025-07-07 15:37:08.73	2025-07-07 15:37:08.73	\N	\N	en	south	[{"text": "北方", "isCorrect": false}, {"text": "西方", "isCorrect": false}, {"text": "南方", "isCorrect": true}, {"text": "东方", "isCorrect": false}]	[{"text": "down", "isCorrect": false}, {"text": "south", "isCorrect": true}, {"text": "west", "isCorrect": false}, {"text": "bottom", "isCorrect": false}]
55	狮子	noun	2025-07-07 15:48:21.759	2025-07-07 15:48:21.759	\N	\N	en	lion	[{"text": "狮子", "isCorrect": true}, {"text": "大象", "isCorrect": false}, {"text": "猎豹", "isCorrect": false}, {"text": "老虎", "isCorrect": false}]	[{"text": "lion", "isCorrect": true}, {"text": "tiger", "isCorrect": false}, {"text": "cheetah", "isCorrect": false}, {"text": "panther", "isCorrect": false}]
56	猫	noun	2025-07-07 15:49:16.026	2025-07-07 15:49:16.026	\N	\N	en	cat	[{"text": "兔子", "isCorrect": false}, {"text": "鸟", "isCorrect": false}, {"text": "狗", "isCorrect": false}, {"text": "猫", "isCorrect": true}]	[{"text": "dog", "isCorrect": false}, {"text": "cat", "isCorrect": true}, {"text": "rat", "isCorrect": false}, {"text": "bat", "isCorrect": false}]
57	大师	noun	2025-07-07 15:52:20.355	2025-07-07 15:52:20.355	\N	\N	en	master	[{"text": "专家", "isCorrect": false}, {"text": "师傅", "isCorrect": false}, {"text": "翻译", "isCorrect": false}, {"text": "大师", "isCorrect": true}]	[{"text": "virtuoso", "isCorrect": false}, {"text": "champion", "isCorrect": false}, {"text": "savant", "isCorrect": false}, {"text": "master", "isCorrect": true}]
58	武器	noun	2025-07-07 15:56:12.908	2025-07-07 15:56:12.908	\N	\N	en	weapon	[{"text": "盔甲", "isCorrect": false}, {"text": "武器", "isCorrect": true}, {"text": "战斗", "isCorrect": false}, {"text": "弓箭", "isCorrect": false}]	[{"text": "军火", "isCorrect": false}, {"text": "枪支", "isCorrect": false}, {"text": "护身符", "isCorrect": false}, {"text": "weapon", "isCorrect": true}]
59	  天上的云好蓝啊。	noun	2025-07-07 15:57:47.127	2025-07-07 15:57:47.127	\N	\N	en	The clouds in the sky are so blue.	[{"text": "雪山的冰很白啊。", "isCorrect": false}, {"text": "水里的鱼很闪啊。", "isCorrect": false}, {"text": "地上的草很绿啊。", "isCorrect": false}, {"text": "  天上的云好蓝啊。", "isCorrect": true}]	[{"text": "The clouds in the sky are so green.", "isCorrect": false}, {"text": "The clouds in the sky are so purple.", "isCorrect": false}, {"text": "The clouds in the sky are so black.", "isCorrect": false}, {"text": "The clouds in the sky are so blue.", "isCorrect": true}]
60	 驱散	noun	2025-07-07 16:50:32.354	2025-07-07 16:50:32.354	\N	\N	en	Dispel	\N	\N
61	空难	noun	2025-07-07 16:55:21.927	2025-07-07 16:55:21.927	\N	\N	en	Air crash	\N	\N
62	解说	noun	2025-07-07 16:59:12.713	2025-07-07 16:59:12.713	\N	\N	en	Commentary	\N	\N
63	飞驰	noun	2025-07-07 17:07:17.994	2025-07-07 17:07:17.994	\N	\N	en	Flying	\N	\N
64	废弃	noun	2025-07-07 17:19:23.332	2025-07-07 17:19:23.332	\N	\N	en	Deprecated	\N	\N
65	现象	noun	2025-07-07 17:32:54.174	2025-07-07 17:32:57.908	\N	\N	en	Phenomenon	[{"text": "实践", "isCorrect": false}, {"text": "推理", "isCorrect": false}, {"text": "表象", "isCorrect": false}, {"text": "现象", "isCorrect": true}]	[{"text": "Occurrence", "isCorrect": false}, {"text": "Phenomenon", "isCorrect": true}, {"text": "Spectacle", "isCorrect": false}, {"text": "Consequence", "isCorrect": false}]
66	边界	noun	2025-07-07 17:36:38.264	2025-07-07 17:36:39.024	\N	\N	en	boundary	\N	\N
67	可能性	noun	2025-07-07 17:45:53.225	2025-07-07 17:45:56.589	\N	\N	en	possibility	[{"text": "潜力", "isCorrect": false}, {"text": "或许", "isCorrect": false}, {"text": "可能性", "isCorrect": true}, {"text": "潜在", "isCorrect": false}]	[{"text": "opportunity", "isCorrect": false}, {"text": "likelihood", "isCorrect": false}, {"text": "possibility", "isCorrect": true}, {"text": "potential", "isCorrect": false}]
68	塔	noun	2025-07-07 17:54:27.796	2025-07-07 17:54:31.601	\N	\N	en	tower	[{"text": "塔", "isCorrect": true}, {"text": "楼", "isCorrect": false}, {"text": "庙", "isCorrect": false}, {"text": "阁", "isCorrect": false}]	[{"text": "castle", "isCorrect": false}, {"text": "building", "isCorrect": false}, {"text": "skyscraper", "isCorrect": false}, {"text": "tower", "isCorrect": true}]
69	修补	noun	2025-07-07 17:54:28.756	2025-07-07 17:54:31.817	\N	\N	en	repair	[{"text": "装饰", "isCorrect": false}, {"text": "整理", "isCorrect": false}, {"text": "修补", "isCorrect": true}, {"text": "擦拭", "isCorrect": false}]	[{"text": "maintain", "isCorrect": false}, {"text": "fix", "isCorrect": false}, {"text": "repair", "isCorrect": true}, {"text": "restore", "isCorrect": false}]
70	原始的	noun	2025-07-07 17:54:29.914	2025-07-07 17:54:35.113	\N	\N	en	original	[{"text": "原始的", "isCorrect": true}, {"text": "初始的", "isCorrect": false}, {"text": "古老的", "isCorrect": false}, {"text": "最初的", "isCorrect": false}]	[{"text": "original", "isCorrect": true}, {"text": "authentic", "isCorrect": false}, {"text": "genuine", "isCorrect": false}, {"text": "innovative", "isCorrect": false}]
71	北方	noun	2025-07-07 17:54:30.865	2025-07-07 17:54:35.175	\N	\N	en	north	[{"text": "西方", "isCorrect": false}, {"text": "北方", "isCorrect": true}, {"text": "东方", "isCorrect": false}, {"text": "南方", "isCorrect": false}]	[{"text": "east", "isCorrect": false}, {"text": "north", "isCorrect": true}, {"text": "up", "isCorrect": false}, {"text": "left", "isCorrect": false}]
72	森林	noun	2025-07-07 23:47:03.902	2025-07-07 23:47:07.732	\N	\N	en	forest	[{"text": "草原", "isCorrect": false}, {"text": "海洋", "isCorrect": false}, {"text": "森林", "isCorrect": true}, {"text": "红色", "isCorrect": false}]	[{"text": "park", "isCorrect": false}, {"text": "jungle", "isCorrect": false}, {"text": "forest", "isCorrect": true}, {"text": "woods", "isCorrect": false}]
73	镜子	noun	2025-07-07 23:47:04.952	2025-07-07 23:47:08.358	\N	\N	en	mirror	[{"text": "被子", "isCorrect": false}, {"text": "镜子", "isCorrect": true}, {"text": "窗帘", "isCorrect": false}, {"text": "刷子", "isCorrect": false}]	[{"text": "reflection", "isCorrect": false}, {"text": "glass", "isCorrect": false}, {"text": "duplicate", "isCorrect": false}, {"text": "mirror", "isCorrect": true}]
75	山	noun	2025-07-07 23:47:06.817	2025-07-07 23:47:11.344	\N	\N	en	mountain	[{"text": "峡谷", "isCorrect": false}, {"text": "草原", "isCorrect": false}, {"text": "沙漠", "isCorrect": false}, {"text": "山", "isCorrect": true}]	[{"text": "valley", "isCorrect": false}, {"text": "mountain", "isCorrect": true}, {"text": "hill", "isCorrect": false}, {"text": "ocean", "isCorrect": false}]
74	河流	noun	2025-07-07 23:47:05.845	2025-07-07 23:47:11.824	\N	\N	en	river	[{"text": "河流", "isCorrect": true}, {"text": "江河", "isCorrect": false}, {"text": "湖泊", "isCorrect": false}, {"text": "溪流", "isCorrect": false}]	[{"text": "stream", "isCorrect": false}, {"text": "river", "isCorrect": true}, {"text": "lake", "isCorrect": false}, {"text": "pond", "isCorrect": false}]
77	目标	noun	2025-07-07 23:47:08.72	2025-07-07 23:47:14.787	\N	\N	en	goal	[{"text": "目标", "isCorrect": true}, {"text": "目录", "isCorrect": false}, {"text": "方向", "isCorrect": false}, {"text": "标记", "isCorrect": false}]	[{"text": "aim", "isCorrect": false}, {"text": "destination", "isCorrect": false}, {"text": "goal", "isCorrect": true}, {"text": "purpose", "isCorrect": false}]
76	想法	noun	2025-07-07 23:47:07.761	2025-07-07 23:47:15.058	\N	\N	en	idea	[{"text": "意见", "isCorrect": false}, {"text": "见解", "isCorrect": false}, {"text": "构想", "isCorrect": false}, {"text": "想法", "isCorrect": true}]	[{"text": "concept", "isCorrect": false}, {"text": "idea", "isCorrect": true}, {"text": "thought", "isCorrect": false}, {"text": "notion", "isCorrect": false}]
78	选择	noun	2025-07-07 23:47:09.706	2025-07-07 23:47:20.643	\N	\N	en	choice	[{"text": "选择", "isCorrect": true}, {"text": "拒绝", "isCorrect": false}, {"text": "挑选", "isCorrect": false}, {"text": "判定", "isCorrect": false}]	[{"text": "choice", "isCorrect": true}, {"text": "selection", "isCorrect": false}, {"text": "preference", "isCorrect": false}, {"text": "decision", "isCorrect": false}]
79	自由	noun	2025-07-08 00:08:52.22	2025-07-08 00:08:56.828	\N	\N	en	freedom	[{"text": "独立", "isCorrect": false}, {"text": "自由", "isCorrect": true}, {"text": "束缚", "isCorrect": false}, {"text": "限制", "isCorrect": false}]	[{"text": "autonomy", "isCorrect": false}, {"text": "freedom", "isCorrect": true}, {"text": "independence", "isCorrect": false}, {"text": "bondage", "isCorrect": false}]
80	勇气	noun	2025-07-08 00:08:53.237	2025-07-08 00:08:57.836	\N	\N	en	courage	[{"text": "勇气", "isCorrect": true}, {"text": "勇武", "isCorrect": false}, {"text": "怯懦", "isCorrect": false}, {"text": "胆怯", "isCorrect": false}]	[{"text": "courage", "isCorrect": true}, {"text": "timidity", "isCorrect": false}, {"text": "cowardice", "isCorrect": false}, {"text": "daring", "isCorrect": false}]
82	火车	noun	2025-07-08 00:08:55.215	2025-07-08 00:09:00.689	\N	\N	en	train	[{"text": "火车", "isCorrect": true}, {"text": "飞机", "isCorrect": false}, {"text": "公共汽车", "isCorrect": false}, {"text": "自行车", "isCorrect": false}]	[{"text": "commuter", "isCorrect": false}, {"text": "train", "isCorrect": true}, {"text": "subway", "isCorrect": false}, {"text": "carriage", "isCorrect": false}]
81	窗户	noun	2025-07-08 00:08:54.278	2025-07-08 00:09:01.279	\N	\N	en	window	[{"text": "门窗", "isCorrect": false}, {"text": "窗口", "isCorrect": false}, {"text": "窗帘", "isCorrect": false}, {"text": "窗户", "isCorrect": true}]	[{"text": "door", "isCorrect": false}, {"text": "window", "isCorrect": true}, {"text": "mirror", "isCorrect": false}, {"text": "pane", "isCorrect": false}]
83	云	noun	2025-07-08 00:08:56.191	2025-07-08 00:09:03.44	\N	\N	en	cloud	[{"text": "风", "isCorrect": false}, {"text": "雨", "isCorrect": false}, {"text": "雪", "isCorrect": false}, {"text": "云", "isCorrect": true}]	[{"text": "fog", "isCorrect": false}, {"text": "cloud", "isCorrect": true}, {"text": "rain", "isCorrect": false}, {"text": "mist", "isCorrect": false}]
84	花	noun	2025-07-08 00:08:57.188	2025-07-08 00:09:04.318	\N	\N	en	flower	[{"text": "花", "isCorrect": true}, {"text": "蓝", "isCorrect": false}, {"text": "草", "isCorrect": false}, {"text": "树", "isCorrect": false}]	[{"text": "flower", "isCorrect": true}, {"text": "blossom", "isCorrect": false}, {"text": "lily", "isCorrect": false}, {"text": "tree", "isCorrect": false}]
85	镜子	noun	2025-07-08 00:08:58.178	2025-07-08 00:09:06.447	\N	\N	en	mirror	[{"text": "灯笼", "isCorrect": false}, {"text": "窗户", "isCorrect": false}, {"text": "地板", "isCorrect": false}, {"text": "镜子", "isCorrect": true}]	[{"text": "mirror", "isCorrect": true}, {"text": "echo", "isCorrect": false}, {"text": "glass", "isCorrect": false}, {"text": "duplicate", "isCorrect": false}]
86	厨房	noun	2025-07-08 00:08:59.15	2025-07-08 00:09:07.07	\N	\N	en	kitchen	[{"text": "洗衣房", "isCorrect": false}, {"text": "餐厅", "isCorrect": false}, {"text": "厨房", "isCorrect": true}, {"text": "浴室", "isCorrect": false}]	[{"text": "kitchen", "isCorrect": true}, {"text": "pantry", "isCorrect": false}, {"text": "bedroom", "isCorrect": false}, {"text": "cabinet", "isCorrect": false}]
87	苹果	noun	2025-07-08 00:09:00.083	2025-07-08 00:09:09.606	\N	\N	en	apple	[{"text": "桃子", "isCorrect": false}, {"text": "梨", "isCorrect": false}, {"text": "香蕉", "isCorrect": false}, {"text": "苹果", "isCorrect": true}]	[{"text": "apple", "isCorrect": true}, {"text": "pear", "isCorrect": false}, {"text": "banana", "isCorrect": false}, {"text": "orange", "isCorrect": false}]
88	老师	noun	2025-07-08 00:09:01.001	2025-07-08 00:09:09.758	\N	\N	en	teacher	[{"text": "学生", "isCorrect": false}, {"text": "导师", "isCorrect": false}, {"text": "老师", "isCorrect": true}, {"text": "教练", "isCorrect": false}]	[{"text": "educator", "isCorrect": false}, {"text": "professor", "isCorrect": false}, {"text": "teacher", "isCorrect": true}, {"text": "instructor", "isCorrect": false}]
89	城市	noun	2025-07-08 00:09:01.955	2025-07-08 00:09:12.794	\N	\N	en	city	[{"text": "山脉", "isCorrect": false}, {"text": "乡村", "isCorrect": false}, {"text": "城市", "isCorrect": true}, {"text": "海洋", "isCorrect": false}]	[{"text": "country", "isCorrect": false}, {"text": "village", "isCorrect": false}, {"text": "town", "isCorrect": false}, {"text": "city", "isCorrect": true}]
90	学校	noun	2025-07-08 00:09:02.913	2025-07-08 00:09:13.091	\N	\N	en	school	[{"text": "大学", "isCorrect": false}, {"text": "学校", "isCorrect": true}, {"text": "超市", "isCorrect": false}, {"text": "医院", "isCorrect": false}]	[{"text": "classroom", "isCorrect": false}, {"text": "university", "isCorrect": false}, {"text": "library", "isCorrect": false}, {"text": "school", "isCorrect": true}]
91	太阳	noun	2025-07-08 00:09:03.946	2025-07-08 00:09:16.496	\N	\N	en	sun	[{"text": "台风", "isCorrect": false}, {"text": "月亮", "isCorrect": false}, {"text": "星星", "isCorrect": false}, {"text": "太阳", "isCorrect": true}]	[{"text": "star", "isCorrect": false}, {"text": "sun", "isCorrect": true}, {"text": "moon", "isCorrect": false}, {"text": "rain", "isCorrect": false}]
92	行星	noun	2025-07-08 00:09:04.954	2025-07-08 00:09:16.845	\N	\N	en	planet	[{"text": "卫星", "isCorrect": false}, {"text": "太阳", "isCorrect": false}, {"text": "星球", "isCorrect": false}, {"text": "行星", "isCorrect": true}]	[{"text": "galaxy", "isCorrect": false}, {"text": "comet", "isCorrect": false}, {"text": "star", "isCorrect": false}, {"text": "planet", "isCorrect": true}]
93	音乐	noun	2025-07-08 00:09:27.134	2025-07-08 00:09:29.751	\N	\N	en	music	[{"text": "音乐", "isCorrect": true}, {"text": "艺术", "isCorrect": false}, {"text": "文学", "isCorrect": false}, {"text": "声音", "isCorrect": false}]	[{"text": "rhythm", "isCorrect": false}, {"text": "music", "isCorrect": true}, {"text": "melody", "isCorrect": false}, {"text": "painting", "isCorrect": false}]
94	梦想	noun	2025-07-08 00:09:28.066	2025-07-08 00:09:31.539	\N	\N	en	dream	[{"text": "心情", "isCorrect": false}, {"text": "梦想", "isCorrect": true}, {"text": "愤怒", "isCorrect": false}, {"text": "抱负", "isCorrect": false}]	[{"text": "fantasy", "isCorrect": false}, {"text": "vision", "isCorrect": false}, {"text": "illusion", "isCorrect": false}, {"text": "dream", "isCorrect": true}]
95	书	noun	2025-07-08 00:09:29.085	2025-07-08 00:09:32.781	\N	\N	en	book	[{"text": "电视", "isCorrect": false}, {"text": "书", "isCorrect": true}, {"text": "报纸", "isCorrect": false}, {"text": "钢笔", "isCorrect": false}]	[{"text": "magazine", "isCorrect": false}, {"text": "book", "isCorrect": true}, {"text": "novel", "isCorrect": false}, {"text": "pen", "isCorrect": false}]
96	电影	noun	2025-07-08 00:09:30.002	2025-07-08 00:09:35.198	\N	\N	en	movie	[{"text": "电器", "isCorrect": false}, {"text": "影视", "isCorrect": false}, {"text": "影片", "isCorrect": false}, {"text": "电影", "isCorrect": true}]	[{"text": "documentary", "isCorrect": false}, {"text": "movie", "isCorrect": true}, {"text": "play", "isCorrect": false}, {"text": "book", "isCorrect": false}]
100	自行车	noun	2025-07-08 00:09:33.789	2025-07-08 00:09:41.15	\N	\N	en	bicycle	[{"text": "电动车", "isCorrect": false}, {"text": "自行车", "isCorrect": true}, {"text": "公交车", "isCorrect": false}, {"text": "飞机", "isCorrect": false}]	[{"text": "skateboard", "isCorrect": false}, {"text": "bicycle", "isCorrect": true}, {"text": "car", "isCorrect": false}, {"text": "scooter", "isCorrect": false}]
101	海洋	noun	2025-07-08 00:09:34.743	2025-07-08 00:09:42.455	\N	\N	en	ocean	[{"text": "湖泊", "isCorrect": false}, {"text": "湿地", "isCorrect": false}, {"text": "海洋", "isCorrect": true}, {"text": "河流", "isCorrect": false}]	[{"text": "lake", "isCorrect": false}, {"text": "sea", "isCorrect": false}, {"text": "river", "isCorrect": false}, {"text": "ocean", "isCorrect": true}]
102	铅笔	noun	2025-07-08 00:09:35.679	2025-07-08 00:09:44.541	\N	\N	en	pencil	[{"text": "书本", "isCorrect": false}, {"text": "橡皮", "isCorrect": false}, {"text": "讲桌", "isCorrect": false}, {"text": "铅笔", "isCorrect": true}]	[{"text": "eraser", "isCorrect": false}, {"text": "sharpener", "isCorrect": false}, {"text": "pencil", "isCorrect": true}, {"text": "notebook", "isCorrect": false}]
104	道路	noun	2025-07-08 00:09:37.598	2025-07-08 00:09:46.959	\N	\N	en	road	[{"text": "车站", "isCorrect": false}, {"text": "道路", "isCorrect": true}, {"text": "街道", "isCorrect": false}, {"text": "条纹", "isCorrect": false}]	[{"text": "road", "isCorrect": true}, {"text": "street", "isCorrect": false}, {"text": "path", "isCorrect": false}, {"text": "highway", "isCorrect": false}]
105	门	noun	2025-07-08 00:09:38.533	2025-07-08 00:09:47.606	\N	\N	en	door	[{"text": "门", "isCorrect": true}, {"text": "窗", "isCorrect": false}, {"text": "墙", "isCorrect": false}, {"text": "楼梯", "isCorrect": false}]	[{"text": "window", "isCorrect": false}, {"text": "entrance", "isCorrect": false}, {"text": "gate", "isCorrect": false}, {"text": "door", "isCorrect": true}]
106	家庭	noun	2025-07-08 00:09:39.472	2025-07-08 00:09:50.534	\N	\N	en	family	[{"text": "亲戚", "isCorrect": false}, {"text": "住宅", "isCorrect": false}, {"text": "家庭", "isCorrect": true}, {"text": "婚姻", "isCorrect": false}]	[{"text": "relatives", "isCorrect": false}, {"text": "family", "isCorrect": true}, {"text": "home", "isCorrect": false}, {"text": "tribe", "isCorrect": false}]
97	语言	noun	2025-07-08 00:09:30.935	2025-07-08 00:09:35.589	\N	\N	en	language	[{"text": "语言", "isCorrect": true}, {"text": "词汇", "isCorrect": false}, {"text": "口音", "isCorrect": false}, {"text": "文字", "isCorrect": false}]	[{"text": "lingo", "isCorrect": false}, {"text": "dialect", "isCorrect": false}, {"text": "language", "isCorrect": true}, {"text": "grammar", "isCorrect": false}]
99	朋友	noun	2025-07-08 00:09:32.844	2025-07-08 00:09:38.16	\N	\N	en	friend	[{"text": "邻居", "isCorrect": false}, {"text": "朋友", "isCorrect": true}, {"text": "家人", "isCorrect": false}, {"text": "同事", "isCorrect": false}]	[{"text": "friend", "isCorrect": true}, {"text": "chum", "isCorrect": false}, {"text": "comrade", "isCorrect": false}, {"text": "acquaintance", "isCorrect": false}]
98	动物	noun	2025-07-08 00:09:31.908	2025-07-08 00:09:38.406	\N	\N	en	animal	[{"text": "生物", "isCorrect": false}, {"text": "植物", "isCorrect": false}, {"text": "动物", "isCorrect": true}, {"text": "鱼类", "isCorrect": false}]	[{"text": "creature", "isCorrect": false}, {"text": "animal", "isCorrect": true}, {"text": "beast", "isCorrect": false}, {"text": "pet", "isCorrect": false}]
103	时钟	noun	2025-07-08 00:09:36.684	2025-07-08 00:09:45.103	\N	\N	en	clock	[{"text": "时钟", "isCorrect": true}, {"text": "表", "isCorrect": false}, {"text": "闹钟", "isCorrect": false}, {"text": "尺", "isCorrect": false}]	[{"text": "meter", "isCorrect": false}, {"text": "watch", "isCorrect": false}, {"text": "calendar", "isCorrect": false}, {"text": "clock", "isCorrect": true}]
107	历史	noun	2025-07-08 00:10:41.284	2025-07-08 00:10:44.244	\N	\N	en	history	[{"text": "科学", "isCorrect": false}, {"text": "过去", "isCorrect": false}, {"text": "历史", "isCorrect": true}, {"text": "传统", "isCorrect": false}]	[{"text": "archaeology", "isCorrect": false}, {"text": "geography", "isCorrect": false}, {"text": "culture", "isCorrect": false}, {"text": "history", "isCorrect": true}]
108	森林	noun	2025-07-08 00:13:06.475	2025-07-08 00:13:09.934	\N	\N	en	forest	[{"text": "丛林", "isCorrect": false}, {"text": "森林", "isCorrect": true}, {"text": "田野", "isCorrect": false}, {"text": "草原", "isCorrect": false}]	[{"text": "forest", "isCorrect": true}, {"text": "jungle", "isCorrect": false}, {"text": "desert", "isCorrect": false}, {"text": "woods", "isCorrect": false}]
109	镜子	noun	2025-07-08 00:13:07.42	2025-07-08 00:13:11.039	\N	\N	en	mirror	[{"text": "窗帘", "isCorrect": false}, {"text": "玻璃", "isCorrect": false}, {"text": "镜子", "isCorrect": true}, {"text": "相机", "isCorrect": false}]	[{"text": "reflection", "isCorrect": false}, {"text": "mirror", "isCorrect": true}, {"text": "glass", "isCorrect": false}, {"text": "window", "isCorrect": false}]
110	河流	noun	2025-07-08 00:13:08.351	2025-07-08 00:13:12.476	\N	\N	en	river	[{"text": "河流", "isCorrect": true}, {"text": "小溪", "isCorrect": false}, {"text": "山脉", "isCorrect": false}, {"text": "湖泊", "isCorrect": false}]	[{"text": "river", "isCorrect": true}, {"text": "stream", "isCorrect": false}, {"text": "lake", "isCorrect": false}, {"text": "ocean", "isCorrect": false}]
111	山	noun	2025-07-08 00:13:09.339	2025-07-08 00:13:14.589	\N	\N	en	mountain	[{"text": "河", "isCorrect": false}, {"text": "岛", "isCorrect": false}, {"text": "山", "isCorrect": true}, {"text": "湖", "isCorrect": false}]	[{"text": "valley", "isCorrect": false}, {"text": "mountain", "isCorrect": true}, {"text": "hill", "isCorrect": false}, {"text": "plateau", "isCorrect": false}]
112	想法	noun	2025-07-08 00:13:10.293	2025-07-08 00:13:15.339	\N	\N	en	idea	[{"text": "想法", "isCorrect": true}, {"text": "观念", "isCorrect": false}, {"text": "心情", "isCorrect": false}, {"text": "计划", "isCorrect": false}]	[{"text": "guess", "isCorrect": false}, {"text": "idea", "isCorrect": true}, {"text": "thought", "isCorrect": false}, {"text": "concept", "isCorrect": false}]
113	目标	noun	2025-07-08 00:13:11.323	2025-07-08 00:13:17.823	\N	\N	en	goal	[{"text": "目的", "isCorrect": false}, {"text": "目标", "isCorrect": true}, {"text": "任务", "isCorrect": false}, {"text": "方向", "isCorrect": false}]	[{"text": "objective", "isCorrect": false}, {"text": "intention", "isCorrect": false}, {"text": "purpose", "isCorrect": false}, {"text": "goal", "isCorrect": true}]
114	选择	noun	2025-07-08 00:13:12.289	2025-07-08 00:13:19.028	\N	\N	en	choice	[{"text": "选择", "isCorrect": true}, {"text": "抉择", "isCorrect": false}, {"text": "拒绝", "isCorrect": false}, {"text": "挑选", "isCorrect": false}]	[{"text": "decision", "isCorrect": false}, {"text": "alternatives", "isCorrect": false}, {"text": "choice", "isCorrect": true}, {"text": "option", "isCorrect": false}]
115	自由	noun	2025-07-08 00:13:13.259	2025-07-08 00:13:20.606	\N	\N	en	freedom	[{"text": "自由", "isCorrect": true}, {"text": "繁荣", "isCorrect": false}, {"text": "平等", "isCorrect": false}, {"text": "束缚", "isCorrect": false}]	[{"text": "oppression", "isCorrect": false}, {"text": "liberty", "isCorrect": false}, {"text": "freedom", "isCorrect": true}, {"text": "independence", "isCorrect": false}]
116	勇气	noun	2025-07-08 00:13:14.225	2025-07-08 00:13:23.426	\N	\N	en	courage	[{"text": "勇气", "isCorrect": true}, {"text": "胆怯", "isCorrect": false}, {"text": "勇敢", "isCorrect": false}, {"text": "胆量", "isCorrect": false}]	[{"text": "courage", "isCorrect": true}, {"text": "fear", "isCorrect": false}, {"text": "recklessness", "isCorrect": false}, {"text": "cowardice", "isCorrect": false}]
117	窗户	noun	2025-07-08 00:13:15.186	2025-07-08 00:13:23.578	\N	\N	en	window	[{"text": "楼梯", "isCorrect": false}, {"text": "窗户", "isCorrect": true}, {"text": "门", "isCorrect": false}, {"text": "墙壁", "isCorrect": false}]	[{"text": "mirror", "isCorrect": false}, {"text": "window", "isCorrect": true}, {"text": "glass", "isCorrect": false}, {"text": "door", "isCorrect": false}]
118	火车	noun	2025-07-08 00:13:16.146	2025-07-08 00:13:26.798	\N	\N	en	train	[{"text": "汽车", "isCorrect": false}, {"text": "自行车", "isCorrect": false}, {"text": "火车", "isCorrect": true}, {"text": "飞机", "isCorrect": false}]	[{"text": "bus", "isCorrect": false}, {"text": "locomotive", "isCorrect": false}, {"text": "train", "isCorrect": true}, {"text": "carriage", "isCorrect": false}]
121	厨房	noun	2025-07-08 00:13:19.092	2025-07-08 00:13:30.285	\N	\N	en	kitchen	[{"text": "厨房", "isCorrect": true}, {"text": "卧室", "isCorrect": false}, {"text": "客厅", "isCorrect": false}, {"text": "书房", "isCorrect": false}]	[{"text": "living room", "isCorrect": false}, {"text": "kitchen", "isCorrect": true}, {"text": "cabinet", "isCorrect": false}, {"text": "pantry", "isCorrect": false}]
128	音乐	noun	2025-07-08 00:13:25.901	2025-07-08 00:13:43.488	\N	\N	en	music	[{"text": "运动", "isCorrect": false}, {"text": "电影", "isCorrect": false}, {"text": "画画", "isCorrect": false}, {"text": "音乐", "isCorrect": true}]	[{"text": "tune", "isCorrect": false}, {"text": "lyrics", "isCorrect": false}, {"text": "music", "isCorrect": true}, {"text": "harmony", "isCorrect": false}]
119	云	noun	2025-07-08 00:13:17.094	2025-07-08 00:13:27.107	\N	\N	en	cloud	[{"text": "风", "isCorrect": false}, {"text": "雪", "isCorrect": false}, {"text": "雨", "isCorrect": false}, {"text": "云", "isCorrect": true}]	[{"text": "fog", "isCorrect": false}, {"text": "cloud", "isCorrect": true}, {"text": "rainbow", "isCorrect": false}, {"text": "mist", "isCorrect": false}]
131	电影	noun	2025-07-08 00:13:28.703	2025-07-08 00:13:47.862	\N	\N	en	movie	[{"text": "音乐", "isCorrect": false}, {"text": "电视剧", "isCorrect": false}, {"text": "电影", "isCorrect": true}, {"text": "数学", "isCorrect": false}]	[{"text": "cinema", "isCorrect": false}, {"text": "movie", "isCorrect": true}, {"text": "series", "isCorrect": false}, {"text": "film", "isCorrect": false}]
132	语言	noun	2025-07-08 00:13:29.637	2025-07-08 00:13:52.133	\N	\N	en	language	[{"text": "词汇", "isCorrect": false}, {"text": "发音", "isCorrect": false}, {"text": "文化", "isCorrect": false}, {"text": "语言", "isCorrect": true}]	[{"text": "linguistics", "isCorrect": false}, {"text": "dialect", "isCorrect": false}, {"text": "language", "isCorrect": true}, {"text": "vocabulary", "isCorrect": false}]
135	海洋	noun	2025-07-08 00:13:32.533	2025-07-08 00:13:55.724	\N	\N	en	ocean	[{"text": "渔村", "isCorrect": false}, {"text": "海洋", "isCorrect": true}, {"text": "航空", "isCorrect": false}, {"text": "湖泊", "isCorrect": false}]	[{"text": "river", "isCorrect": false}, {"text": "pond", "isCorrect": false}, {"text": "lake", "isCorrect": false}, {"text": "ocean", "isCorrect": true}]
120	花	noun	2025-07-08 00:13:18.067	2025-07-08 00:13:29.872	\N	\N	en	flower	[{"text": "草莓", "isCorrect": false}, {"text": "草", "isCorrect": false}, {"text": "树", "isCorrect": false}, {"text": "花", "isCorrect": true}]	[{"text": "petal", "isCorrect": false}, {"text": "flower", "isCorrect": true}, {"text": "twig", "isCorrect": false}, {"text": "blossom", "isCorrect": false}]
123	老师	noun	2025-07-08 00:13:21.044	2025-07-08 00:13:34.379	\N	\N	en	teacher	[{"text": "老师", "isCorrect": true}, {"text": "警察", "isCorrect": false}, {"text": "学生", "isCorrect": false}, {"text": "医生", "isCorrect": false}]	[{"text": "educator", "isCorrect": false}, {"text": "instructor", "isCorrect": false}, {"text": "professor", "isCorrect": false}, {"text": "teacher", "isCorrect": true}]
124	城市	noun	2025-07-08 00:13:21.975	2025-07-08 00:13:36.326	\N	\N	en	city	[{"text": "村庄", "isCorrect": false}, {"text": "地方", "isCorrect": false}, {"text": "都市", "isCorrect": false}, {"text": "城市", "isCorrect": true}]	[{"text": "city", "isCorrect": true}, {"text": "village", "isCorrect": false}, {"text": "town", "isCorrect": false}, {"text": "hamlet", "isCorrect": false}]
129	梦想	noun	2025-07-08 00:13:26.85	2025-07-08 00:13:44.314	\N	\N	en	dream	[{"text": "希望", "isCorrect": false}, {"text": "愿望", "isCorrect": false}, {"text": "梦想", "isCorrect": true}, {"text": "目标", "isCorrect": false}]	[{"text": "dream", "isCorrect": true}, {"text": "fantastic", "isCorrect": false}, {"text": "illusion", "isCorrect": false}, {"text": "fantasy", "isCorrect": false}]
136	铅笔	noun	2025-07-08 00:13:33.514	2025-07-08 00:13:57.89	\N	\N	en	pencil	[{"text": "文件夹", "isCorrect": false}, {"text": "书包", "isCorrect": false}, {"text": "钢笔", "isCorrect": false}, {"text": "铅笔", "isCorrect": true}]	[{"text": "crayon", "isCorrect": false}, {"text": "pen", "isCorrect": false}, {"text": "pencil", "isCorrect": true}, {"text": "notebook", "isCorrect": false}]
122	苹果	noun	2025-07-08 00:13:20.054	2025-07-08 00:13:32.76	\N	\N	en	apple	[{"text": "西瓜", "isCorrect": false}, {"text": "桃子", "isCorrect": false}, {"text": "香蕉", "isCorrect": false}, {"text": "苹果", "isCorrect": true}]	[{"text": "banana", "isCorrect": false}, {"text": "apple", "isCorrect": true}, {"text": "grape", "isCorrect": false}, {"text": "orange", "isCorrect": false}]
125	学校	noun	2025-07-08 00:13:22.92	2025-07-08 00:13:36.98	\N	\N	en	school	[{"text": "医院", "isCorrect": false}, {"text": "教室", "isCorrect": false}, {"text": "学校", "isCorrect": true}, {"text": "超市", "isCorrect": false}]	[{"text": "school", "isCorrect": true}, {"text": "academy", "isCorrect": false}, {"text": "institution", "isCorrect": false}, {"text": "university", "isCorrect": false}]
126	太阳	noun	2025-07-08 00:13:23.879	2025-07-08 00:13:39.511	\N	\N	en	sun	[{"text": "阳光", "isCorrect": false}, {"text": "月亮", "isCorrect": false}, {"text": "星星", "isCorrect": false}, {"text": "太阳", "isCorrect": true}]	[{"text": "star", "isCorrect": false}, {"text": "sun", "isCorrect": true}, {"text": "lamp", "isCorrect": false}, {"text": "moon", "isCorrect": false}]
127	行星	noun	2025-07-08 00:13:24.915	2025-07-08 00:13:40.914	\N	\N	en	planet	[{"text": "太空", "isCorrect": false}, {"text": "行星", "isCorrect": true}, {"text": "恒星", "isCorrect": false}, {"text": "宇宙", "isCorrect": false}]	[{"text": "galaxy", "isCorrect": false}, {"text": "comet", "isCorrect": false}, {"text": "orbit", "isCorrect": false}, {"text": "planet", "isCorrect": true}]
130	书	noun	2025-07-08 00:13:27.753	2025-07-08 00:13:48.598	\N	\N	en	book	[{"text": "亭", "isCorrect": false}, {"text": "笔", "isCorrect": false}, {"text": "画", "isCorrect": false}, {"text": "书", "isCorrect": true}]	[{"text": "novel", "isCorrect": false}, {"text": "magazine", "isCorrect": false}, {"text": "article", "isCorrect": false}, {"text": "book", "isCorrect": true}]
133	动物	noun	2025-07-08 00:13:30.601	2025-07-08 00:13:52.473	\N	\N	en	animal	[{"text": "花园", "isCorrect": false}, {"text": "生物", "isCorrect": false}, {"text": "动物", "isCorrect": true}, {"text": "食物", "isCorrect": false}]	[{"text": "beast", "isCorrect": false}, {"text": "creature", "isCorrect": false}, {"text": "animal", "isCorrect": true}, {"text": "mammal", "isCorrect": false}]
134	朋友	noun	2025-07-08 00:13:31.53	2025-07-08 00:13:55.008	\N	\N	en	friend	[{"text": "同学", "isCorrect": false}, {"text": "陌生人", "isCorrect": false}, {"text": "朋友", "isCorrect": true}, {"text": "家人", "isCorrect": false}]	[{"text": "buddy", "isCorrect": false}, {"text": "friend", "isCorrect": true}, {"text": "companion", "isCorrect": false}, {"text": "acquaintance", "isCorrect": false}]
137	市场	noun	2025-07-08 00:13:34.469	2025-07-08 00:13:59.06	\N	\N	en	market	[{"text": "市场", "isCorrect": true}, {"text": "超级市场", "isCorrect": false}, {"text": "商店", "isCorrect": false}, {"text": "商城", "isCorrect": false}]	[{"text": "market", "isCorrect": true}, {"text": "grocery", "isCorrect": false}, {"text": "plaza", "isCorrect": false}, {"text": "bazaar", "isCorrect": false}]
\.


--
-- Data for Name: user_words_lesson_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_words_lesson_links (id, user_word_id, lesson_id, user_word_order) FROM stdin;
1	1	1	1
\.


--
-- Data for Name: user_words_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_words_localizations_links (id, user_word_id, inv_user_word_id, user_word_order) FROM stdin;
\.


--
-- Data for Name: user_words_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.user_words_user_links (id, user_word_id, user_id, user_word_order) FROM stdin;
3	11	8	1
4	12	8	2
7	15	8	3
8	16	8	4
9	17	8	5
10	18	8	6
11	19	8	7
12	20	8	8
13	21	8	9
14	22	8	10
15	23	8	11
16	24	8	12
17	25	8	13
18	26	8	14
19	27	8	15
20	28	8	16
21	29	8	17
22	30	8	18
23	31	8	19
24	32	8	20
25	33	8	21
26	34	8	22
27	35	8	23
28	36	8	24
29	37	8	25
30	38	8	26
31	39	8	27
32	40	8	28
33	41	8	29
34	42	8	30
35	43	8	31
36	44	8	32
37	45	8	33
38	46	8	34
39	47	8	35
40	48	8	36
41	49	29	1
42	50	8	37
43	51	8	38
44	52	8	39
45	53	8	40
46	54	30	1
47	55	30	2
48	56	30	3
49	57	30	4
50	58	30	5
51	59	30	6
52	60	30	7
53	61	30	8
54	62	30	9
55	63	30	10
56	64	30	11
57	65	30	12
58	66	30	13
59	67	30	14
60	68	30	15
61	69	30	16
62	70	30	17
63	71	30	18
64	72	30	19
65	73	30	20
66	74	30	21
67	75	30	22
68	76	30	23
69	77	30	24
70	78	30	25
71	79	30	26
72	80	30	27
73	81	30	28
74	82	30	29
75	83	30	30
76	84	30	31
77	85	30	32
78	86	30	33
79	87	30	34
80	88	30	35
81	89	30	36
82	90	30	37
83	91	30	38
84	92	30	39
85	93	30	40
86	94	30	41
87	95	30	42
88	96	30	43
89	97	30	44
90	98	30	45
91	99	30	46
92	100	30	47
93	101	30	48
94	102	30	49
95	103	30	50
96	104	30	51
97	105	30	52
98	106	30	53
99	107	30	54
100	108	30	55
101	109	30	56
102	110	30	57
103	111	30	58
104	112	30	59
105	113	30	60
106	114	30	61
107	115	30	62
108	116	30	63
109	117	30	64
110	118	30	65
111	119	30	66
112	120	30	67
113	121	30	68
114	122	30	69
115	123	30	70
116	124	30	71
117	125	30	72
118	126	30	73
119	127	30	74
120	128	30	75
121	129	30	76
122	130	30	77
123	131	30	78
124	132	30	79
125	133	30	80
126	134	30	81
127	135	30	82
128	136	30	83
129	137	30	84
\.


--
-- Data for Name: vbsettings; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.vbsettings (id, words_per_page, interval_1, interval_2, interval_3, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: vbsettings_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.vbsettings_user_links (id, vbsetting_id, user_id) FROM stdin;
\.


--
-- Data for Name: vocabooks; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.vocabooks (id, title, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
1	newuser4@langgo.com's Vocab Book	2025-07-07 08:53:43.35	2025-07-07 08:53:43.35	\N	\N
2	Viv's Vocabella	2025-07-07 14:31:04.076	2025-07-07 15:26:30.11	1	1
3	july7's Vocab Book	2025-07-07 15:35:49.211	2025-07-07 15:35:49.211	\N	\N
\.


--
-- Data for Name: vocabooks_user_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.vocabooks_user_links (id, vocabook_id, user_id) FROM stdin;
1	1	29
2	2	8
3	3	30
\.


--
-- Data for Name: vocapages; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.vocapages (id, title, "order", created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
2	First Vocapage	1	2025-07-07 08:53:43.565	2025-07-07 08:53:43.565	\N	\N
3	Page 1	1	2025-07-07 14:31:35.005	2025-07-07 14:33:05.247	1	1
4	Page 1	1	2025-07-07 15:35:49.427	2025-07-08 20:32:12.535	\N	1
5	Page 2	2	2025-07-08 20:33:24.092	2025-07-08 20:38:24.093	1	1
1	Page 3	3	2025-07-06 11:28:30.577	2025-07-08 20:38:41.595	1	1
\.


--
-- Data for Name: vocapages_vocabook_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.vocapages_vocabook_links (id, vocapage_id, vocabook_id, vocapage_order) FROM stdin;
1	2	1	1
2	3	2	1
3	4	3	1
4	1	3	2
5	5	3	3
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.words (id, word, base_text, instruction, part_of_speech, gender, article, created_at, updated_at, created_by_id, updated_by_id, locale, register, exam_base, exam_target) FROM stdin;
3	do	做	怎么说	verb	feminine	le	2025-06-29 00:21:18.092	2025-06-29 10:43:26.133	1	1	en	Neutral	\N	\N
2	work	工作; 作业	用英语怎么说	verb	\N	\N	2025-06-24 00:43:21.743	2025-06-29 10:44:27.814	1	1	en	Neutral	\N	\N
1	hello	你好	一般打招呼，你好怎么说？	\N	\N	\N	2025-06-24 00:42:22.806	2025-06-29 10:44:40.092	1	1	en	Neutral	\N	\N
\.


--
-- Data for Name: words_components; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.words_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
3	3	1	a.verb-meta	verb_meta	3
1	3	2	a.taglist	tags	1
2	3	1	a.taglist	tags	2
\.


--
-- Data for Name: words_example_sentences_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.words_example_sentences_links (id, word_id, sentence_id, sentence_order, word_order) FROM stdin;
\.


--
-- Data for Name: words_localizations_links; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.words_localizations_links (id, word_id, inv_word_id, word_order) FROM stdin;
\.


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 321, true);


--
-- Name: admin_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 321, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: admin_users_roles_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);


--
-- Name: components_a_external_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_external_videos_id_seq', 1, false);


--
-- Name: components_a_pagebreakers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_pagebreakers_id_seq', 1, false);


--
-- Name: components_a_quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_quizzes_id_seq', 1, false);


--
-- Name: components_a_sent_refs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_sent_refs_id_seq', 1, true);


--
-- Name: components_a_sent_refs_sentence_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_sent_refs_sentence_links_id_seq', 1, true);


--
-- Name: components_a_taglists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_taglists_id_seq', 2, true);


--
-- Name: components_a_user_sent_refs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_user_sent_refs_id_seq', 1, true);


--
-- Name: components_a_user_sent_refs_user_sentence_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_user_sent_refs_user_sentence_links_id_seq', 1, true);


--
-- Name: components_a_user_word_refs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_user_word_refs_id_seq', 127, true);


--
-- Name: components_a_user_word_refs_user_word_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_user_word_refs_user_word_links_id_seq', 127, true);


--
-- Name: components_a_verb_metas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_verb_metas_id_seq', 1, true);


--
-- Name: components_a_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_videos_id_seq', 1, false);


--
-- Name: components_a_word_refs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_word_refs_id_seq', 4, true);


--
-- Name: components_a_word_refs_word_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.components_a_word_refs_word_links_id_seq', 4, true);


--
-- Name: files_folder_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_id_seq', 1, false);


--
-- Name: files_related_morphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);


--
-- Name: flashcards_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.flashcards_components_id_seq', 173, true);


--
-- Name: flashcards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.flashcards_id_seq', 129, true);


--
-- Name: flashcards_lesson_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.flashcards_lesson_links_id_seq', 1, true);


--
-- Name: flashcards_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.flashcards_localizations_links_id_seq', 1, false);


--
-- Name: flashcards_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.flashcards_user_links_id_seq', 130, true);


--
-- Name: flashcards_vocapage_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.flashcards_vocapage_links_id_seq', 121, true);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: lessonlevels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.lessonlevels_id_seq', 1, false);


--
-- Name: lessons_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.lessons_components_id_seq', 1, false);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.lessons_id_seq', 1, true);


--
-- Name: lessons_lessonlevel_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.lessons_lessonlevel_links_id_seq', 1, false);


--
-- Name: lessons_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.lessons_localizations_links_id_seq', 1, false);


--
-- Name: lessons_unit_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.lessons_unit_links_id_seq', 1, false);


--
-- Name: review_tires_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.review_tires_id_seq', 5, true);


--
-- Name: review_tires_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.review_tires_localizations_links_id_seq', 1, false);


--
-- Name: reviewlogs_flashcard_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.reviewlogs_flashcard_links_id_seq', 125, true);


--
-- Name: reviewlogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.reviewlogs_id_seq', 152, true);


--
-- Name: reviewlogs_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.reviewlogs_user_links_id_seq', 152, true);


--
-- Name: sections_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sections_components_id_seq', 2, true);


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sections_id_seq', 3, true);


--
-- Name: sections_lesson_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sections_lesson_links_id_seq', 3, true);


--
-- Name: sections_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sections_localizations_links_id_seq', 1, false);


--
-- Name: sentences_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sentences_components_id_seq', 1, false);


--
-- Name: sentences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sentences_id_seq', 2, true);


--
-- Name: sentences_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.sentences_localizations_links_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 49, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 65, true);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.units_id_seq', 2, true);


--
-- Name: units_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.units_localizations_links_id_seq', 1, false);


--
-- Name: units_precondition_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.units_precondition_links_id_seq', 2, true);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 84, true);


--
-- Name: up_permissions_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 84, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_users_id_seq', 30, true);


--
-- Name: up_users_role_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 25, true);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);


--
-- Name: upload_folders_parent_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);


--
-- Name: user_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_profiles_id_seq', 5, true);


--
-- Name: user_profiles_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_profiles_user_links_id_seq', 5, true);


--
-- Name: user_sentences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_sentences_id_seq', 1, true);


--
-- Name: user_sentences_lesson_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_sentences_lesson_links_id_seq', 1, true);


--
-- Name: user_sentences_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_sentences_localizations_links_id_seq', 1, false);


--
-- Name: user_sentences_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_sentences_user_links_id_seq', 1, false);


--
-- Name: user_words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_words_id_seq', 137, true);


--
-- Name: user_words_lesson_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_words_lesson_links_id_seq', 1, true);


--
-- Name: user_words_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_words_localizations_links_id_seq', 1, false);


--
-- Name: user_words_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.user_words_user_links_id_seq', 129, true);


--
-- Name: vbsettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.vbsettings_id_seq', 1, false);


--
-- Name: vbsettings_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.vbsettings_user_links_id_seq', 1, false);


--
-- Name: vocabooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.vocabooks_id_seq', 3, true);


--
-- Name: vocabooks_user_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.vocabooks_user_links_id_seq', 3, true);


--
-- Name: vocapages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.vocapages_id_seq', 5, true);


--
-- Name: vocapages_vocabook_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.vocapages_vocabook_links_id_seq', 5, true);


--
-- Name: words_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.words_components_id_seq', 6, true);


--
-- Name: words_example_sentences_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.words_example_sentences_links_id_seq', 1, false);


--
-- Name: words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.words_id_seq', 3, true);


--
-- Name: words_localizations_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.words_localizations_links_id_seq', 1, false);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_links admin_permissions_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_links admin_permissions_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_unique UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_links admin_users_roles_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_links admin_users_roles_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_unique UNIQUE (user_id, role_id);


--
-- Name: components_a_external_videos components_a_external_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_external_videos
    ADD CONSTRAINT components_a_external_videos_pkey PRIMARY KEY (id);


--
-- Name: components_a_pagebreakers components_a_pagebreakers_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_pagebreakers
    ADD CONSTRAINT components_a_pagebreakers_pkey PRIMARY KEY (id);


--
-- Name: components_a_quizzes components_a_quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_quizzes
    ADD CONSTRAINT components_a_quizzes_pkey PRIMARY KEY (id);


--
-- Name: components_a_sent_refs components_a_sent_refs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs
    ADD CONSTRAINT components_a_sent_refs_pkey PRIMARY KEY (id);


--
-- Name: components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_pkey PRIMARY KEY (id);


--
-- Name: components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_unique UNIQUE (sent_ref_id, sentence_id);


--
-- Name: components_a_taglists components_a_taglists_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_taglists
    ADD CONSTRAINT components_a_taglists_pkey PRIMARY KEY (id);


--
-- Name: components_a_user_sent_refs components_a_user_sent_refs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs
    ADD CONSTRAINT components_a_user_sent_refs_pkey PRIMARY KEY (id);


--
-- Name: components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_pkey PRIMARY KEY (id);


--
-- Name: components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_unique UNIQUE (user_sent_ref_id, user_sentence_id);


--
-- Name: components_a_user_word_refs components_a_user_word_refs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs
    ADD CONSTRAINT components_a_user_word_refs_pkey PRIMARY KEY (id);


--
-- Name: components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_pkey PRIMARY KEY (id);


--
-- Name: components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_unique UNIQUE (user_word_ref_id, user_word_id);


--
-- Name: components_a_verb_metas components_a_verb_metas_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_verb_metas
    ADD CONSTRAINT components_a_verb_metas_pkey PRIMARY KEY (id);


--
-- Name: components_a_videos components_a_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_videos
    ADD CONSTRAINT components_a_videos_pkey PRIMARY KEY (id);


--
-- Name: components_a_word_refs components_a_word_refs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs
    ADD CONSTRAINT components_a_word_refs_pkey PRIMARY KEY (id);


--
-- Name: components_a_word_refs_word_links components_a_word_refs_word_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_pkey PRIMARY KEY (id);


--
-- Name: components_a_word_refs_word_links components_a_word_refs_word_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_unique UNIQUE (word_ref_id, word_id);


--
-- Name: files_folder_links files_folder_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);


--
-- Name: files_folder_links files_folder_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_morphs files_related_morphs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);


--
-- Name: flashcards_components flashcards_components_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_components_pkey PRIMARY KEY (id);


--
-- Name: flashcards_lesson_links flashcards_lesson_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_pkey PRIMARY KEY (id);


--
-- Name: flashcards_lesson_links flashcards_lesson_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_unique UNIQUE (flashcard_id, lesson_id);


--
-- Name: flashcards_localizations_links flashcards_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: flashcards_localizations_links flashcards_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_unique UNIQUE (flashcard_id, inv_flashcard_id);


--
-- Name: flashcards flashcards_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);


--
-- Name: flashcards_components flashcards_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_unique UNIQUE (entity_id, component_id, field, component_type);


--
-- Name: flashcards_user_links flashcards_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_pkey PRIMARY KEY (id);


--
-- Name: flashcards_user_links flashcards_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_unique UNIQUE (flashcard_id, user_id);


--
-- Name: flashcards_vocapage_links flashcards_vocapage_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_vocapage_links
    ADD CONSTRAINT flashcards_vocapage_links_pkey PRIMARY KEY (id);


--
-- Name: flashcards_vocapage_links flashcards_vocapage_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_vocapage_links
    ADD CONSTRAINT flashcards_vocapage_links_unique UNIQUE (flashcard_id, vocapage_id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: lessonlevels lessonlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_pkey PRIMARY KEY (id);


--
-- Name: lessons_components lessons_components_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_components_pkey PRIMARY KEY (id);


--
-- Name: lessons_lessonlevel_links lessons_lessonlevel_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_pkey PRIMARY KEY (id);


--
-- Name: lessons_lessonlevel_links lessons_lessonlevel_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_unique UNIQUE (lesson_id, lessonlevel_id);


--
-- Name: lessons_localizations_links lessons_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: lessons_localizations_links lessons_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_unique UNIQUE (lesson_id, inv_lesson_id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_slug_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_unique UNIQUE (slug);


--
-- Name: lessons_components lessons_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_unique UNIQUE (entity_id, component_id, field, component_type);


--
-- Name: lessons_unit_links lessons_unit_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_pkey PRIMARY KEY (id);


--
-- Name: lessons_unit_links lessons_unit_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_unique UNIQUE (lesson_id, unit_id);


--
-- Name: review_tires_localizations_links review_tires_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: review_tires_localizations_links review_tires_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_unique UNIQUE (review_tire_id, inv_review_tire_id);


--
-- Name: review_tires review_tires_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_pkey PRIMARY KEY (id);


--
-- Name: reviewlogs_flashcard_links reviewlogs_flashcard_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_pkey PRIMARY KEY (id);


--
-- Name: reviewlogs_flashcard_links reviewlogs_flashcard_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_unique UNIQUE (reviewlog_id, flashcard_id);


--
-- Name: reviewlogs reviewlogs_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_pkey PRIMARY KEY (id);


--
-- Name: reviewlogs_user_links reviewlogs_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_pkey PRIMARY KEY (id);


--
-- Name: reviewlogs_user_links reviewlogs_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_unique UNIQUE (reviewlog_id, user_id);


--
-- Name: sections_components sections_components_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_components_pkey PRIMARY KEY (id);


--
-- Name: sections_lesson_links sections_lesson_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_pkey PRIMARY KEY (id);


--
-- Name: sections_lesson_links sections_lesson_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_unique UNIQUE (section_id, lesson_id);


--
-- Name: sections_localizations_links sections_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: sections_localizations_links sections_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_unique UNIQUE (section_id, inv_section_id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: sections_components sections_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_unique UNIQUE (entity_id, component_id, field, component_type);


--
-- Name: sentences_components sentences_components_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_components_pkey PRIMARY KEY (id);


--
-- Name: sentences_localizations_links sentences_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: sentences_localizations_links sentences_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_unique UNIQUE (sentence_id, inv_sentence_id);


--
-- Name: sentences sentences_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);


--
-- Name: sentences_components sentences_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_unique UNIQUE (entity_id, component_id, field, component_type);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_unique UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: units_localizations_links units_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: units_localizations_links units_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_unique UNIQUE (unit_id, inv_unit_id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: units_precondition_links units_precondition_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_pkey PRIMARY KEY (id);


--
-- Name: units_precondition_links units_precondition_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_unique UNIQUE (unit_id, inv_unit_id);


--
-- Name: units units_slug_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_slug_unique UNIQUE (slug);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_links up_permissions_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_links up_permissions_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_unique UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_links up_users_role_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_links up_users_role_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_unique UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_links upload_folders_parent_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_links upload_folders_parent_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_unique UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: user_profiles_user_links user_profiles_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_pkey PRIMARY KEY (id);


--
-- Name: user_profiles_user_links user_profiles_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_unique UNIQUE (user_profile_id, user_id);


--
-- Name: user_sentences_lesson_links user_sentences_lesson_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_pkey PRIMARY KEY (id);


--
-- Name: user_sentences_lesson_links user_sentences_lesson_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_unique UNIQUE (user_sentence_id, lesson_id);


--
-- Name: user_sentences_localizations_links user_sentences_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: user_sentences_localizations_links user_sentences_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_unique UNIQUE (user_sentence_id, inv_user_sentence_id);


--
-- Name: user_sentences user_sentences_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_pkey PRIMARY KEY (id);


--
-- Name: user_sentences_user_links user_sentences_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_pkey PRIMARY KEY (id);


--
-- Name: user_sentences_user_links user_sentences_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_unique UNIQUE (user_sentence_id, user_id);


--
-- Name: user_words_lesson_links user_words_lesson_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_pkey PRIMARY KEY (id);


--
-- Name: user_words_lesson_links user_words_lesson_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_unique UNIQUE (user_word_id, lesson_id);


--
-- Name: user_words_localizations_links user_words_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: user_words_localizations_links user_words_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_unique UNIQUE (user_word_id, inv_user_word_id);


--
-- Name: user_words user_words_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (id);


--
-- Name: user_words_user_links user_words_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_pkey PRIMARY KEY (id);


--
-- Name: user_words_user_links user_words_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_unique UNIQUE (user_word_id, user_id);


--
-- Name: vbsettings vbsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings
    ADD CONSTRAINT vbsettings_pkey PRIMARY KEY (id);


--
-- Name: vbsettings_user_links vbsettings_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings_user_links
    ADD CONSTRAINT vbsettings_user_links_pkey PRIMARY KEY (id);


--
-- Name: vbsettings_user_links vbsettings_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings_user_links
    ADD CONSTRAINT vbsettings_user_links_unique UNIQUE (vbsetting_id, user_id);


--
-- Name: vocabooks vocabooks_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks
    ADD CONSTRAINT vocabooks_pkey PRIMARY KEY (id);


--
-- Name: vocabooks_user_links vocabooks_user_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_pkey PRIMARY KEY (id);


--
-- Name: vocabooks_user_links vocabooks_user_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_unique UNIQUE (vocabook_id, user_id);


--
-- Name: vocapages vocapages_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages
    ADD CONSTRAINT vocapages_pkey PRIMARY KEY (id);


--
-- Name: vocapages_vocabook_links vocapages_vocabook_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_pkey PRIMARY KEY (id);


--
-- Name: vocapages_vocabook_links vocapages_vocabook_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_unique UNIQUE (vocapage_id, vocabook_id);


--
-- Name: words_components words_components_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_components_pkey PRIMARY KEY (id);


--
-- Name: words_example_sentences_links words_example_sentences_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_pkey PRIMARY KEY (id);


--
-- Name: words_example_sentences_links words_example_sentences_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_unique UNIQUE (word_id, sentence_id);


--
-- Name: words_localizations_links words_localizations_links_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_pkey PRIMARY KEY (id);


--
-- Name: words_localizations_links words_localizations_links_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_unique UNIQUE (word_id, inv_word_id);


--
-- Name: words words_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: words_components words_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_unique UNIQUE (entity_id, component_id, field, component_type);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_role_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_links_fk ON public.admin_permissions_role_links USING btree (permission_id);


--
-- Name: admin_permissions_role_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_links_inv_fk ON public.admin_permissions_role_links USING btree (role_id);


--
-- Name: admin_permissions_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_role_links_order_inv_fk ON public.admin_permissions_role_links USING btree (permission_order);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_roles_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_fk ON public.admin_users_roles_links USING btree (user_id);


--
-- Name: admin_users_roles_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_inv_fk ON public.admin_users_roles_links USING btree (role_id);


--
-- Name: admin_users_roles_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_order_fk ON public.admin_users_roles_links USING btree (role_order);


--
-- Name: admin_users_roles_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_roles_links_order_inv_fk ON public.admin_users_roles_links USING btree (user_order);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: components_a_sent_refs_sentence_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_sent_refs_sentence_links_fk ON public.components_a_sent_refs_sentence_links USING btree (sent_ref_id);


--
-- Name: components_a_sent_refs_sentence_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_sent_refs_sentence_links_inv_fk ON public.components_a_sent_refs_sentence_links USING btree (sentence_id);


--
-- Name: components_a_user_sent_refs_user_sentence_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_user_sent_refs_user_sentence_links_fk ON public.components_a_user_sent_refs_user_sentence_links USING btree (user_sent_ref_id);


--
-- Name: components_a_user_sent_refs_user_sentence_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_user_sent_refs_user_sentence_links_inv_fk ON public.components_a_user_sent_refs_user_sentence_links USING btree (user_sentence_id);


--
-- Name: components_a_user_word_refs_user_word_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_user_word_refs_user_word_links_fk ON public.components_a_user_word_refs_user_word_links USING btree (user_word_ref_id);


--
-- Name: components_a_user_word_refs_user_word_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_user_word_refs_user_word_links_inv_fk ON public.components_a_user_word_refs_user_word_links USING btree (user_word_id);


--
-- Name: components_a_word_refs_word_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_word_refs_word_links_fk ON public.components_a_word_refs_word_links USING btree (word_ref_id);


--
-- Name: components_a_word_refs_word_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX components_a_word_refs_word_links_inv_fk ON public.components_a_word_refs_word_links USING btree (word_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_folder_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);


--
-- Name: files_folder_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);


--
-- Name: files_folder_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);


--
-- Name: files_related_morphs_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);


--
-- Name: files_related_morphs_id_column_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);


--
-- Name: files_related_morphs_order_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: flashcards_component_type_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_component_type_index ON public.flashcards_components USING btree (component_type);


--
-- Name: flashcards_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_created_by_id_fk ON public.flashcards USING btree (created_by_id);


--
-- Name: flashcards_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_entity_fk ON public.flashcards_components USING btree (entity_id);


--
-- Name: flashcards_field_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_field_index ON public.flashcards_components USING btree (field);


--
-- Name: flashcards_lesson_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_lesson_links_fk ON public.flashcards_lesson_links USING btree (flashcard_id);


--
-- Name: flashcards_lesson_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_lesson_links_inv_fk ON public.flashcards_lesson_links USING btree (lesson_id);


--
-- Name: flashcards_lesson_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_lesson_links_order_inv_fk ON public.flashcards_lesson_links USING btree (flashcard_order);


--
-- Name: flashcards_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_localizations_links_fk ON public.flashcards_localizations_links USING btree (flashcard_id);


--
-- Name: flashcards_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_localizations_links_inv_fk ON public.flashcards_localizations_links USING btree (inv_flashcard_id);


--
-- Name: flashcards_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_localizations_links_order_fk ON public.flashcards_localizations_links USING btree (flashcard_order);


--
-- Name: flashcards_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_updated_by_id_fk ON public.flashcards USING btree (updated_by_id);


--
-- Name: flashcards_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_user_links_fk ON public.flashcards_user_links USING btree (flashcard_id);


--
-- Name: flashcards_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_user_links_inv_fk ON public.flashcards_user_links USING btree (user_id);


--
-- Name: flashcards_user_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_user_links_order_inv_fk ON public.flashcards_user_links USING btree (flashcard_order);


--
-- Name: flashcards_vocapage_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_vocapage_links_fk ON public.flashcards_vocapage_links USING btree (flashcard_id);


--
-- Name: flashcards_vocapage_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_vocapage_links_inv_fk ON public.flashcards_vocapage_links USING btree (vocapage_id);


--
-- Name: flashcards_vocapage_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX flashcards_vocapage_links_order_inv_fk ON public.flashcards_vocapage_links USING btree (flashcard_order);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: lessonlevels_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessonlevels_created_by_id_fk ON public.lessonlevels USING btree (created_by_id);


--
-- Name: lessonlevels_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessonlevels_updated_by_id_fk ON public.lessonlevels USING btree (updated_by_id);


--
-- Name: lessons_component_type_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_component_type_index ON public.lessons_components USING btree (component_type);


--
-- Name: lessons_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_created_by_id_fk ON public.lessons USING btree (created_by_id);


--
-- Name: lessons_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_entity_fk ON public.lessons_components USING btree (entity_id);


--
-- Name: lessons_field_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_field_index ON public.lessons_components USING btree (field);


--
-- Name: lessons_lessonlevel_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_lessonlevel_links_fk ON public.lessons_lessonlevel_links USING btree (lesson_id);


--
-- Name: lessons_lessonlevel_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_lessonlevel_links_inv_fk ON public.lessons_lessonlevel_links USING btree (lessonlevel_id);


--
-- Name: lessons_lessonlevel_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_lessonlevel_links_order_inv_fk ON public.lessons_lessonlevel_links USING btree (lesson_order);


--
-- Name: lessons_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_localizations_links_fk ON public.lessons_localizations_links USING btree (lesson_id);


--
-- Name: lessons_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_localizations_links_inv_fk ON public.lessons_localizations_links USING btree (inv_lesson_id);


--
-- Name: lessons_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_localizations_links_order_fk ON public.lessons_localizations_links USING btree (lesson_order);


--
-- Name: lessons_unit_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_unit_links_fk ON public.lessons_unit_links USING btree (lesson_id);


--
-- Name: lessons_unit_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_unit_links_inv_fk ON public.lessons_unit_links USING btree (unit_id);


--
-- Name: lessons_unit_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_unit_links_order_inv_fk ON public.lessons_unit_links USING btree (lesson_order);


--
-- Name: lessons_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX lessons_updated_by_id_fk ON public.lessons USING btree (updated_by_id);


--
-- Name: review_tires_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX review_tires_created_by_id_fk ON public.review_tires USING btree (created_by_id);


--
-- Name: review_tires_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX review_tires_localizations_links_fk ON public.review_tires_localizations_links USING btree (review_tire_id);


--
-- Name: review_tires_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX review_tires_localizations_links_inv_fk ON public.review_tires_localizations_links USING btree (inv_review_tire_id);


--
-- Name: review_tires_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX review_tires_localizations_links_order_fk ON public.review_tires_localizations_links USING btree (review_tire_order);


--
-- Name: review_tires_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX review_tires_updated_by_id_fk ON public.review_tires USING btree (updated_by_id);


--
-- Name: reviewlogs_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_created_by_id_fk ON public.reviewlogs USING btree (created_by_id);


--
-- Name: reviewlogs_flashcard_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_flashcard_links_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_id);


--
-- Name: reviewlogs_flashcard_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_flashcard_links_inv_fk ON public.reviewlogs_flashcard_links USING btree (flashcard_id);


--
-- Name: reviewlogs_flashcard_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_flashcard_links_order_inv_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_order);


--
-- Name: reviewlogs_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_updated_by_id_fk ON public.reviewlogs USING btree (updated_by_id);


--
-- Name: reviewlogs_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_user_links_fk ON public.reviewlogs_user_links USING btree (reviewlog_id);


--
-- Name: reviewlogs_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_user_links_inv_fk ON public.reviewlogs_user_links USING btree (user_id);


--
-- Name: reviewlogs_user_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX reviewlogs_user_links_order_inv_fk ON public.reviewlogs_user_links USING btree (reviewlog_order);


--
-- Name: sections_component_type_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_component_type_index ON public.sections_components USING btree (component_type);


--
-- Name: sections_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_created_by_id_fk ON public.sections USING btree (created_by_id);


--
-- Name: sections_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_entity_fk ON public.sections_components USING btree (entity_id);


--
-- Name: sections_field_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_field_index ON public.sections_components USING btree (field);


--
-- Name: sections_lesson_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_lesson_links_fk ON public.sections_lesson_links USING btree (section_id);


--
-- Name: sections_lesson_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_lesson_links_inv_fk ON public.sections_lesson_links USING btree (lesson_id);


--
-- Name: sections_lesson_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_lesson_links_order_inv_fk ON public.sections_lesson_links USING btree (section_order);


--
-- Name: sections_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_localizations_links_fk ON public.sections_localizations_links USING btree (section_id);


--
-- Name: sections_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_localizations_links_inv_fk ON public.sections_localizations_links USING btree (inv_section_id);


--
-- Name: sections_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_localizations_links_order_fk ON public.sections_localizations_links USING btree (section_order);


--
-- Name: sections_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sections_updated_by_id_fk ON public.sections USING btree (updated_by_id);


--
-- Name: sentences_component_type_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_component_type_index ON public.sentences_components USING btree (component_type);


--
-- Name: sentences_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_created_by_id_fk ON public.sentences USING btree (created_by_id);


--
-- Name: sentences_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_entity_fk ON public.sentences_components USING btree (entity_id);


--
-- Name: sentences_field_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_field_index ON public.sentences_components USING btree (field);


--
-- Name: sentences_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_localizations_links_fk ON public.sentences_localizations_links USING btree (sentence_id);


--
-- Name: sentences_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_localizations_links_inv_fk ON public.sentences_localizations_links USING btree (inv_sentence_id);


--
-- Name: sentences_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_localizations_links_order_fk ON public.sentences_localizations_links USING btree (sentence_order);


--
-- Name: sentences_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX sentences_updated_by_id_fk ON public.sentences USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_token_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_token_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: units_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_created_by_id_fk ON public.units USING btree (created_by_id);


--
-- Name: units_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_localizations_links_fk ON public.units_localizations_links USING btree (unit_id);


--
-- Name: units_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_localizations_links_inv_fk ON public.units_localizations_links USING btree (inv_unit_id);


--
-- Name: units_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_localizations_links_order_fk ON public.units_localizations_links USING btree (unit_order);


--
-- Name: units_precondition_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_precondition_links_fk ON public.units_precondition_links USING btree (unit_id);


--
-- Name: units_precondition_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_precondition_links_inv_fk ON public.units_precondition_links USING btree (inv_unit_id);


--
-- Name: units_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX units_updated_by_id_fk ON public.units USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_role_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_links_fk ON public.up_permissions_role_links USING btree (permission_id);


--
-- Name: up_permissions_role_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_links_inv_fk ON public.up_permissions_role_links USING btree (role_id);


--
-- Name: up_permissions_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_role_links_order_inv_fk ON public.up_permissions_role_links USING btree (permission_order);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_role_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_links_fk ON public.up_users_role_links USING btree (user_id);


--
-- Name: up_users_role_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_links_inv_fk ON public.up_users_role_links USING btree (role_id);


--
-- Name: up_users_role_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_role_links_order_inv_fk ON public.up_users_role_links USING btree (user_order);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_parent_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_links_fk ON public.upload_folders_parent_links USING btree (folder_id);


--
-- Name: upload_folders_parent_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_links_inv_fk ON public.upload_folders_parent_links USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_parent_links_order_inv_fk ON public.upload_folders_parent_links USING btree (folder_order);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: user_profiles_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_profiles_created_by_id_fk ON public.user_profiles USING btree (created_by_id);


--
-- Name: user_profiles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_profiles_updated_by_id_fk ON public.user_profiles USING btree (updated_by_id);


--
-- Name: user_profiles_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_profiles_user_links_fk ON public.user_profiles_user_links USING btree (user_profile_id);


--
-- Name: user_profiles_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_profiles_user_links_inv_fk ON public.user_profiles_user_links USING btree (user_id);


--
-- Name: user_sentences_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_created_by_id_fk ON public.user_sentences USING btree (created_by_id);


--
-- Name: user_sentences_lesson_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_lesson_links_fk ON public.user_sentences_lesson_links USING btree (user_sentence_id);


--
-- Name: user_sentences_lesson_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_lesson_links_inv_fk ON public.user_sentences_lesson_links USING btree (lesson_id);


--
-- Name: user_sentences_lesson_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_lesson_links_order_inv_fk ON public.user_sentences_lesson_links USING btree (user_sentence_order);


--
-- Name: user_sentences_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_localizations_links_fk ON public.user_sentences_localizations_links USING btree (user_sentence_id);


--
-- Name: user_sentences_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_localizations_links_inv_fk ON public.user_sentences_localizations_links USING btree (inv_user_sentence_id);


--
-- Name: user_sentences_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_localizations_links_order_fk ON public.user_sentences_localizations_links USING btree (user_sentence_order);


--
-- Name: user_sentences_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_updated_by_id_fk ON public.user_sentences USING btree (updated_by_id);


--
-- Name: user_sentences_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_user_links_fk ON public.user_sentences_user_links USING btree (user_sentence_id);


--
-- Name: user_sentences_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_user_links_inv_fk ON public.user_sentences_user_links USING btree (user_id);


--
-- Name: user_sentences_user_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_sentences_user_links_order_inv_fk ON public.user_sentences_user_links USING btree (user_sentence_order);


--
-- Name: user_words_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_created_by_id_fk ON public.user_words USING btree (created_by_id);


--
-- Name: user_words_lesson_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_lesson_links_fk ON public.user_words_lesson_links USING btree (user_word_id);


--
-- Name: user_words_lesson_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_lesson_links_inv_fk ON public.user_words_lesson_links USING btree (lesson_id);


--
-- Name: user_words_lesson_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_lesson_links_order_inv_fk ON public.user_words_lesson_links USING btree (user_word_order);


--
-- Name: user_words_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_localizations_links_fk ON public.user_words_localizations_links USING btree (user_word_id);


--
-- Name: user_words_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_localizations_links_inv_fk ON public.user_words_localizations_links USING btree (inv_user_word_id);


--
-- Name: user_words_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_localizations_links_order_fk ON public.user_words_localizations_links USING btree (user_word_order);


--
-- Name: user_words_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_updated_by_id_fk ON public.user_words USING btree (updated_by_id);


--
-- Name: user_words_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_user_links_fk ON public.user_words_user_links USING btree (user_word_id);


--
-- Name: user_words_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_user_links_inv_fk ON public.user_words_user_links USING btree (user_id);


--
-- Name: user_words_user_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX user_words_user_links_order_inv_fk ON public.user_words_user_links USING btree (user_word_order);


--
-- Name: vbsettings_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vbsettings_created_by_id_fk ON public.vbsettings USING btree (created_by_id);


--
-- Name: vbsettings_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vbsettings_updated_by_id_fk ON public.vbsettings USING btree (updated_by_id);


--
-- Name: vbsettings_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vbsettings_user_links_fk ON public.vbsettings_user_links USING btree (vbsetting_id);


--
-- Name: vbsettings_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vbsettings_user_links_inv_fk ON public.vbsettings_user_links USING btree (user_id);


--
-- Name: vocabooks_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocabooks_created_by_id_fk ON public.vocabooks USING btree (created_by_id);


--
-- Name: vocabooks_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocabooks_updated_by_id_fk ON public.vocabooks USING btree (updated_by_id);


--
-- Name: vocabooks_user_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocabooks_user_links_fk ON public.vocabooks_user_links USING btree (vocabook_id);


--
-- Name: vocabooks_user_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocabooks_user_links_inv_fk ON public.vocabooks_user_links USING btree (user_id);


--
-- Name: vocapages_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocapages_created_by_id_fk ON public.vocapages USING btree (created_by_id);


--
-- Name: vocapages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocapages_updated_by_id_fk ON public.vocapages USING btree (updated_by_id);


--
-- Name: vocapages_vocabook_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocapages_vocabook_links_fk ON public.vocapages_vocabook_links USING btree (vocapage_id);


--
-- Name: vocapages_vocabook_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocapages_vocabook_links_inv_fk ON public.vocapages_vocabook_links USING btree (vocabook_id);


--
-- Name: vocapages_vocabook_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX vocapages_vocabook_links_order_inv_fk ON public.vocapages_vocabook_links USING btree (vocapage_order);


--
-- Name: words_component_type_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_component_type_index ON public.words_components USING btree (component_type);


--
-- Name: words_created_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_created_by_id_fk ON public.words USING btree (created_by_id);


--
-- Name: words_entity_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_entity_fk ON public.words_components USING btree (entity_id);


--
-- Name: words_example_sentences_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_example_sentences_links_fk ON public.words_example_sentences_links USING btree (word_id);


--
-- Name: words_example_sentences_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_example_sentences_links_inv_fk ON public.words_example_sentences_links USING btree (sentence_id);


--
-- Name: words_example_sentences_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_example_sentences_links_order_fk ON public.words_example_sentences_links USING btree (sentence_order);


--
-- Name: words_example_sentences_links_order_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_example_sentences_links_order_inv_fk ON public.words_example_sentences_links USING btree (word_order);


--
-- Name: words_field_index; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_field_index ON public.words_components USING btree (field);


--
-- Name: words_localizations_links_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_localizations_links_fk ON public.words_localizations_links USING btree (word_id);


--
-- Name: words_localizations_links_inv_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_localizations_links_inv_fk ON public.words_localizations_links USING btree (inv_word_id);


--
-- Name: words_localizations_links_order_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_localizations_links_order_fk ON public.words_localizations_links USING btree (word_order);


--
-- Name: words_updated_by_id_fk; Type: INDEX; Schema: public; Owner: strapi
--

CREATE INDEX words_updated_by_id_fk ON public.words USING btree (updated_by_id);


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_links admin_permissions_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_links admin_permissions_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_links admin_users_roles_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_links admin_users_roles_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_fk FOREIGN KEY (sent_ref_id) REFERENCES public.components_a_sent_refs(id) ON DELETE CASCADE;


--
-- Name: components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;


--
-- Name: components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk FOREIGN KEY (user_sent_ref_id) REFERENCES public.components_a_user_sent_refs(id) ON DELETE CASCADE;


--
-- Name: components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;


--
-- Name: components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_fk FOREIGN KEY (user_word_ref_id) REFERENCES public.components_a_user_word_refs(id) ON DELETE CASCADE;


--
-- Name: components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;


--
-- Name: components_a_word_refs_word_links components_a_word_refs_word_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_fk FOREIGN KEY (word_ref_id) REFERENCES public.components_a_word_refs(id) ON DELETE CASCADE;


--
-- Name: components_a_word_refs_word_links components_a_word_refs_word_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_inv_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_links files_folder_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_links files_folder_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_morphs files_related_morphs_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: flashcards flashcards_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: flashcards_components flashcards_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_entity_fk FOREIGN KEY (entity_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: flashcards_lesson_links flashcards_lesson_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: flashcards_lesson_links flashcards_lesson_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: flashcards_localizations_links flashcards_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: flashcards_localizations_links flashcards_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_inv_fk FOREIGN KEY (inv_flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: flashcards flashcards_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: flashcards_user_links flashcards_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: flashcards_user_links flashcards_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: flashcards_vocapage_links flashcards_vocapage_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_vocapage_links
    ADD CONSTRAINT flashcards_vocapage_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: flashcards_vocapage_links flashcards_vocapage_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.flashcards_vocapage_links
    ADD CONSTRAINT flashcards_vocapage_links_inv_fk FOREIGN KEY (vocapage_id) REFERENCES public.vocapages(id) ON DELETE CASCADE;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lessonlevels lessonlevels_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lessonlevels lessonlevels_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lessons lessons_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: lessons_components lessons_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_entity_fk FOREIGN KEY (entity_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lessons_lessonlevel_links lessons_lessonlevel_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lessons_lessonlevel_links lessons_lessonlevel_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_inv_fk FOREIGN KEY (lessonlevel_id) REFERENCES public.lessonlevels(id) ON DELETE CASCADE;


--
-- Name: lessons_localizations_links lessons_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lessons_localizations_links lessons_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_inv_fk FOREIGN KEY (inv_lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lessons_unit_links lessons_unit_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lessons_unit_links lessons_unit_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_inv_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: lessons lessons_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: review_tires review_tires_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: review_tires_localizations_links review_tires_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_fk FOREIGN KEY (review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;


--
-- Name: review_tires_localizations_links review_tires_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_inv_fk FOREIGN KEY (inv_review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;


--
-- Name: review_tires review_tires_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reviewlogs reviewlogs_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reviewlogs_flashcard_links reviewlogs_flashcard_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;


--
-- Name: reviewlogs_flashcard_links reviewlogs_flashcard_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_inv_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;


--
-- Name: reviewlogs reviewlogs_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reviewlogs_user_links reviewlogs_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;


--
-- Name: reviewlogs_user_links reviewlogs_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: sections sections_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: sections_components sections_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: sections_lesson_links sections_lesson_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: sections_lesson_links sections_lesson_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: sections_localizations_links sections_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: sections_localizations_links sections_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_inv_fk FOREIGN KEY (inv_section_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: sections sections_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: sentences sentences_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: sentences_components sentences_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sentences(id) ON DELETE CASCADE;


--
-- Name: sentences_localizations_links sentences_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;


--
-- Name: sentences_localizations_links sentences_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_inv_fk FOREIGN KEY (inv_sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;


--
-- Name: sentences sentences_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: units units_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: units_localizations_links units_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: units_localizations_links units_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: units_precondition_links units_precondition_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: units_precondition_links units_precondition_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: units units_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_links up_permissions_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_links up_permissions_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_role_links up_users_role_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_links up_users_role_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_links upload_folders_parent_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_links upload_folders_parent_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_profiles user_profiles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_profiles user_profiles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_profiles_user_links user_profiles_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_fk FOREIGN KEY (user_profile_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;


--
-- Name: user_profiles_user_links user_profiles_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: user_sentences user_sentences_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_sentences_lesson_links user_sentences_lesson_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;


--
-- Name: user_sentences_lesson_links user_sentences_lesson_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: user_sentences_localizations_links user_sentences_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;


--
-- Name: user_sentences_localizations_links user_sentences_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_inv_fk FOREIGN KEY (inv_user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;


--
-- Name: user_sentences user_sentences_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_sentences_user_links user_sentences_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;


--
-- Name: user_sentences_user_links user_sentences_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: user_words user_words_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_words_lesson_links user_words_lesson_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;


--
-- Name: user_words_lesson_links user_words_lesson_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: user_words_localizations_links user_words_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;


--
-- Name: user_words_localizations_links user_words_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_inv_fk FOREIGN KEY (inv_user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;


--
-- Name: user_words user_words_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: user_words_user_links user_words_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;


--
-- Name: user_words_user_links user_words_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: vbsettings vbsettings_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings
    ADD CONSTRAINT vbsettings_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: vbsettings vbsettings_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings
    ADD CONSTRAINT vbsettings_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: vbsettings_user_links vbsettings_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings_user_links
    ADD CONSTRAINT vbsettings_user_links_fk FOREIGN KEY (vbsetting_id) REFERENCES public.vbsettings(id) ON DELETE CASCADE;


--
-- Name: vbsettings_user_links vbsettings_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vbsettings_user_links
    ADD CONSTRAINT vbsettings_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: vocabooks vocabooks_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks
    ADD CONSTRAINT vocabooks_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: vocabooks vocabooks_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks
    ADD CONSTRAINT vocabooks_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: vocabooks_user_links vocabooks_user_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_fk FOREIGN KEY (vocabook_id) REFERENCES public.vocabooks(id) ON DELETE CASCADE;


--
-- Name: vocabooks_user_links vocabooks_user_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: vocapages vocapages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages
    ADD CONSTRAINT vocapages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: vocapages vocapages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages
    ADD CONSTRAINT vocapages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: vocapages_vocabook_links vocapages_vocabook_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_fk FOREIGN KEY (vocapage_id) REFERENCES public.vocapages(id) ON DELETE CASCADE;


--
-- Name: vocapages_vocabook_links vocapages_vocabook_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_inv_fk FOREIGN KEY (vocabook_id) REFERENCES public.vocabooks(id) ON DELETE CASCADE;


--
-- Name: words words_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: words_components words_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_entity_fk FOREIGN KEY (entity_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: words_example_sentences_links words_example_sentences_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: words_example_sentences_links words_example_sentences_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;


--
-- Name: words_localizations_links words_localizations_links_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: words_localizations_links words_localizations_links_inv_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_inv_fk FOREIGN KEY (inv_word_id) REFERENCES public.words(id) ON DELETE CASCADE;


--
-- Name: words words_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: cloudsqlsuperuser
--

REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

