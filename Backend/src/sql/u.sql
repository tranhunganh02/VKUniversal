--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.3

-- Started on 2024-04-13 13:54:43 +07

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

DROP DATABASE IF EXISTS vkuniversal;
--
-- TOC entry 3770 (class 1262 OID 17141)
-- Name: vkuniversal; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE vkuniversal WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE vkuniversal OWNER TO postgres;

\connect vkuniversal

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
-- TOC entry 250 (class 1255 OID 17377)
-- Name: find_and_delete_user(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_and_delete_user(user_id_to_find integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Xóa hàng trong bảng token_keys dựa trên userId
  DELETE FROM token_keys WHERE user_id = user_id_to_find;
END;
$$;


ALTER FUNCTION public.find_and_delete_user(user_id_to_find integer) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 17375)
-- Name: insertorupdatetoken(uuid, integer, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insertorupdatetoken(token_id_param uuid, user_id_param integer, public_key_param text, private_key_param text, refresh_token_param text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Kiểm tra xem user_id đã tồn tại trong bảng token_keys chưa
    IF EXISTS (SELECT 1 FROM token_keys WHERE user_id = user_id_param) THEN
        -- Nếu user_id đã tồn tại, thực hiện update
        UPDATE token_keys
        SET 
            public_key = public_key_param,
            private_key = private_key_param,
            refresh_token = refresh_token_param,
            refresh_tokens_used = array_append(refresh_tokens_used, (SELECT refresh_token FROM token_keys WHERE user_id = user_id_param))
        WHERE user_id = user_id_param;
    ELSE
        -- Nếu user_id chưa tồn tại, thực hiện insert
        INSERT INTO token_keys (token_id, user_id, public_key, private_key, refresh_token)
        VALUES (token_id_param, user_id_param, public_key_param, private_key_param, refresh_token_param);
    END IF;
END;
$$;


ALTER FUNCTION public.insertorupdatetoken(token_id_param uuid, user_id_param integer, public_key_param text, private_key_param text, refresh_token_param text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 234 (class 1259 OID 17254)
-- Name: acedemic_rank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acedemic_rank (
    ar_id integer NOT NULL,
    ar_name character varying(15) NOT NULL
);


ALTER TABLE public.acedemic_rank OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17253)
-- Name: acedemic_rank_ar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acedemic_rank_ar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acedemic_rank_ar_id_seq OWNER TO postgres;

--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 233
-- Name: acedemic_rank_ar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acedemic_rank_ar_id_seq OWNED BY public.acedemic_rank.ar_id;


--
-- TOC entry 246 (class 1259 OID 17345)
-- Name: attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachment (
    attachment_id integer NOT NULL,
    post_id integer,
    file_name character varying(32),
    file_type smallint,
    file_url text
);


ALTER TABLE public.attachment OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17344)
-- Name: attachment_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attachment_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attachment_attachment_id_seq OWNER TO postgres;

--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 245
-- Name: attachment_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attachment_attachment_id_seq OWNED BY public.attachment.attachment_id;


--
-- TOC entry 248 (class 1259 OID 17359)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    comment_id integer NOT NULL,
    post_id integer,
    user_id integer,
    content character varying(300),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    comment_parent_id integer,
    left_id smallint,
    right_id smallint
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17358)
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_comment_id_seq OWNER TO postgres;

--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 247
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;


--
-- TOC entry 236 (class 1259 OID 17261)
-- Name: degree; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.degree (
    degree_id integer NOT NULL,
    degree_name character varying(15) NOT NULL
);


ALTER TABLE public.degree OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17260)
-- Name: degree_degree_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.degree_degree_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.degree_degree_id_seq OWNER TO postgres;

--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 235
-- Name: degree_degree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.degree_degree_id_seq OWNED BY public.degree.degree_id;


--
-- TOC entry 230 (class 1259 OID 17235)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    user_id integer,
    department_name character varying(50) NOT NULL,
    department_code character varying(10)
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17234)
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_department_id_seq OWNER TO postgres;

--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 229
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;


--
-- TOC entry 232 (class 1259 OID 17247)
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    faculty_id integer NOT NULL,
    faculty_name character varying(20) NOT NULL
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17246)
-- Name: faculty_faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faculty_faculty_id_seq OWNER TO postgres;

--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 231
-- Name: faculty_faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_faculty_id_seq OWNED BY public.faculty.faculty_id;


--
-- TOC entry 238 (class 1259 OID 17268)
-- Name: lecturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturer (
    lecturer_id integer NOT NULL,
    lecturer_code character varying(7),
    academic_id integer,
    user_id integer,
    faculty_id integer,
    degree_id integer,
    gender smallint,
    surname character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    date_of_birth date
);


ALTER TABLE public.lecturer OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17267)
-- Name: lecturer_lecturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lecturer_lecturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lecturer_lecturer_id_seq OWNER TO postgres;

--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 237
-- Name: lecturer_lecturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lecturer_lecturer_id_seq OWNED BY public.lecturer.lecturer_id;


--
-- TOC entry 217 (class 1259 OID 17150)
-- Name: link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.link (
    link_id integer NOT NULL,
    link_name character varying(15) NOT NULL,
    link_content text,
    profile_id integer
);


ALTER TABLE public.link OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17149)
-- Name: link_link_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.link_link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.link_link_id_seq OWNER TO postgres;

--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 216
-- Name: link_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.link_link_id_seq OWNED BY public.link.link_id;


--
-- TOC entry 226 (class 1259 OID 17204)
-- Name: major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major (
    major_id smallint NOT NULL,
    major_name character varying(70)
);


ALTER TABLE public.major OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17203)
-- Name: major_major_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.major_major_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.major_major_id_seq OWNER TO postgres;

--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 225
-- Name: major_major_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.major_major_id_seq OWNED BY public.major.major_id;


--
-- TOC entry 240 (class 1259 OID 17295)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    post_id integer NOT NULL,
    content text,
    user_id integer,
    privacy boolean,
    post_type smallint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17328)
-- Name: post_like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_like (
    like_id integer NOT NULL,
    post_id integer,
    user_id integer
);


ALTER TABLE public.post_like OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17327)
-- Name: post_like_like_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_like_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_like_like_id_seq OWNER TO postgres;

--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 243
-- Name: post_like_like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_like_like_id_seq OWNED BY public.post_like.like_id;


--
-- TOC entry 239 (class 1259 OID 17294)
-- Name: post_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_post_id_seq OWNER TO postgres;

--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 239
-- Name: post_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_post_id_seq OWNED BY public.post.post_id;


--
-- TOC entry 242 (class 1259 OID 17309)
-- Name: post_share; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_share (
    share_id integer NOT NULL,
    post_id integer,
    user_id integer,
    content text
);


ALTER TABLE public.post_share OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17308)
-- Name: post_share_share_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_share_share_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_share_share_id_seq OWNER TO postgres;

--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 241
-- Name: post_share_share_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_share_share_id_seq OWNED BY public.post_share.share_id;


--
-- TOC entry 219 (class 1259 OID 17159)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_id smallint NOT NULL,
    role_name character varying(20) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17158)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_role_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_role_id_seq OWNER TO postgres;

--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 218
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- TOC entry 228 (class 1259 OID 17211)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    user_id integer,
    student_code character varying(7) NOT NULL,
    surname character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    date_of_birth date,
    gender smallint,
    major_id smallint,
    class_id smallint,
    status integer
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17210)
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_student_id_seq OWNER TO postgres;

--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 227
-- Name: student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_student_id_seq OWNED BY public.student.student_id;


--
-- TOC entry 224 (class 1259 OID 17191)
-- Name: token_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_keys (
    token_id uuid NOT NULL,
    user_id integer NOT NULL,
    private_key text NOT NULL,
    public_key text,
    refresh_token text,
    refresh_tokens_used text[]
);


ALTER TABLE public.token_keys OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17143)
-- Name: university_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_class (
    class_id integer NOT NULL,
    class_name character varying(10) NOT NULL
);


ALTER TABLE public.university_class OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17142)
-- Name: university_class_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_class_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.university_class_class_id_seq OWNER TO postgres;

--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 214
-- Name: university_class_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_class_class_id_seq OWNED BY public.university_class.class_id;


--
-- TOC entry 223 (class 1259 OID 17178)
-- Name: user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profile (
    user_profile_id integer NOT NULL,
    user_id integer,
    bio text
);


ALTER TABLE public.user_profile OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17177)
-- Name: user_profile_user_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_profile_user_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profile_user_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 222
-- Name: user_profile_user_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_profile_user_profile_id_seq OWNED BY public.user_profile.user_profile_id;


--
-- TOC entry 221 (class 1259 OID 17166)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(70) NOT NULL,
    password text NOT NULL,
    role smallint,
    phone_number character varying(12),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone,
    avatar text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17165)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 3557 (class 2604 OID 17257)
-- Name: acedemic_rank ar_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acedemic_rank ALTER COLUMN ar_id SET DEFAULT nextval('public.acedemic_rank_ar_id_seq'::regclass);


--
-- TOC entry 3563 (class 2604 OID 17348)
-- Name: attachment attachment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment ALTER COLUMN attachment_id SET DEFAULT nextval('public.attachment_attachment_id_seq'::regclass);


--
-- TOC entry 3564 (class 2604 OID 17362)
-- Name: comment comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);


--
-- TOC entry 3558 (class 2604 OID 17264)
-- Name: degree degree_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degree ALTER COLUMN degree_id SET DEFAULT nextval('public.degree_degree_id_seq'::regclass);


--
-- TOC entry 3555 (class 2604 OID 17238)
-- Name: department department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);


--
-- TOC entry 3556 (class 2604 OID 17250)
-- Name: faculty faculty_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty ALTER COLUMN faculty_id SET DEFAULT nextval('public.faculty_faculty_id_seq'::regclass);


--
-- TOC entry 3559 (class 2604 OID 17271)
-- Name: lecturer lecturer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer ALTER COLUMN lecturer_id SET DEFAULT nextval('public.lecturer_lecturer_id_seq'::regclass);


--
-- TOC entry 3548 (class 2604 OID 17153)
-- Name: link link_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link ALTER COLUMN link_id SET DEFAULT nextval('public.link_link_id_seq'::regclass);


--
-- TOC entry 3553 (class 2604 OID 17207)
-- Name: major major_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major ALTER COLUMN major_id SET DEFAULT nextval('public.major_major_id_seq'::regclass);


--
-- TOC entry 3560 (class 2604 OID 17298)
-- Name: post post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post ALTER COLUMN post_id SET DEFAULT nextval('public.post_post_id_seq'::regclass);


--
-- TOC entry 3562 (class 2604 OID 17331)
-- Name: post_like like_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like ALTER COLUMN like_id SET DEFAULT nextval('public.post_like_like_id_seq'::regclass);


--
-- TOC entry 3561 (class 2604 OID 17312)
-- Name: post_share share_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_share ALTER COLUMN share_id SET DEFAULT nextval('public.post_share_share_id_seq'::regclass);


--
-- TOC entry 3549 (class 2604 OID 17162)
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- TOC entry 3554 (class 2604 OID 17214)
-- Name: student student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN student_id SET DEFAULT nextval('public.student_student_id_seq'::regclass);


--
-- TOC entry 3547 (class 2604 OID 17146)
-- Name: university_class class_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_class ALTER COLUMN class_id SET DEFAULT nextval('public.university_class_class_id_seq'::regclass);


--
-- TOC entry 3552 (class 2604 OID 17181)
-- Name: user_profile user_profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile ALTER COLUMN user_profile_id SET DEFAULT nextval('public.user_profile_user_profile_id_seq'::regclass);


--
-- TOC entry 3550 (class 2604 OID 17169)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3590 (class 2606 OID 17259)
-- Name: acedemic_rank acedemic_rank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acedemic_rank
    ADD CONSTRAINT acedemic_rank_pkey PRIMARY KEY (ar_id);


--
-- TOC entry 3602 (class 2606 OID 17352)
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (attachment_id);


--
-- TOC entry 3604 (class 2606 OID 17364)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- TOC entry 3592 (class 2606 OID 17266)
-- Name: degree degree_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degree
    ADD CONSTRAINT degree_pkey PRIMARY KEY (degree_id);


--
-- TOC entry 3586 (class 2606 OID 17240)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- TOC entry 3588 (class 2606 OID 17252)
-- Name: faculty faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);


--
-- TOC entry 3594 (class 2606 OID 17273)
-- Name: lecturer lecturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (lecturer_id);


--
-- TOC entry 3568 (class 2606 OID 17157)
-- Name: link link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (link_id);


--
-- TOC entry 3580 (class 2606 OID 17209)
-- Name: major major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (major_id);


--
-- TOC entry 3600 (class 2606 OID 17333)
-- Name: post_like post_like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_pkey PRIMARY KEY (like_id);


--
-- TOC entry 3596 (class 2606 OID 17302)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);


--
-- TOC entry 3598 (class 2606 OID 17316)
-- Name: post_share post_share_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_pkey PRIMARY KEY (share_id);


--
-- TOC entry 3570 (class 2606 OID 17164)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3582 (class 2606 OID 17216)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 3584 (class 2606 OID 17218)
-- Name: student student_student_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_student_code_key UNIQUE (student_code);


--
-- TOC entry 3578 (class 2606 OID 17197)
-- Name: token_keys token_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_keys
    ADD CONSTRAINT token_keys_pkey PRIMARY KEY (token_id);


--
-- TOC entry 3566 (class 2606 OID 17148)
-- Name: university_class university_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_class
    ADD CONSTRAINT university_class_pkey PRIMARY KEY (class_id);


--
-- TOC entry 3576 (class 2606 OID 17185)
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (user_profile_id);


--
-- TOC entry 3572 (class 2606 OID 17176)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3574 (class 2606 OID 17174)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3620 (class 2606 OID 17353)
-- Name: attachment attachment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- TOC entry 3621 (class 2606 OID 17365)
-- Name: comment comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- TOC entry 3622 (class 2606 OID 17370)
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3610 (class 2606 OID 17241)
-- Name: department department_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3611 (class 2606 OID 17284)
-- Name: lecturer lecturer_academic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_academic_id_fkey FOREIGN KEY (academic_id) REFERENCES public.acedemic_rank(ar_id);


--
-- TOC entry 3612 (class 2606 OID 17279)
-- Name: lecturer lecturer_degree_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_degree_id_fkey FOREIGN KEY (degree_id) REFERENCES public.degree(degree_id);


--
-- TOC entry 3613 (class 2606 OID 17289)
-- Name: lecturer lecturer_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);


--
-- TOC entry 3614 (class 2606 OID 17274)
-- Name: lecturer lecturer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3618 (class 2606 OID 17339)
-- Name: post_like post_like_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- TOC entry 3619 (class 2606 OID 17334)
-- Name: post_like post_like_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3616 (class 2606 OID 17322)
-- Name: post_share post_share_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- TOC entry 3617 (class 2606 OID 17317)
-- Name: post_share post_share_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3615 (class 2606 OID 17303)
-- Name: post post_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3607 (class 2606 OID 17229)
-- Name: student student_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.university_class(class_id);


--
-- TOC entry 3608 (class 2606 OID 17219)
-- Name: student student_major_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_major_id_fkey FOREIGN KEY (major_id) REFERENCES public.major(major_id);


--
-- TOC entry 3609 (class 2606 OID 17224)
-- Name: student student_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3606 (class 2606 OID 17198)
-- Name: token_keys token_keys_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_keys
    ADD CONSTRAINT token_keys_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3605 (class 2606 OID 17186)
-- Name: user_profile user_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2024-04-13 13:54:43 +07

--
-- PostgreSQL database dump complete
--

