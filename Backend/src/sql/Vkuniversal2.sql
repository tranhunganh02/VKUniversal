PGDMP         3                |            vkuniversal    15.4    15.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17141    vkuniversal    DATABASE     �   CREATE DATABASE vkuniversal WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE vkuniversal;
                postgres    false            �            1255    17377    find_and_delete_user(integer)    FUNCTION     �   CREATE FUNCTION public.find_and_delete_user(user_id_to_find integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Xóa hàng trong bảng token_keys dựa trên userId
  DELETE FROM token_keys WHERE user_id = user_id_to_find;
END;
$$;
 D   DROP FUNCTION public.find_and_delete_user(user_id_to_find integer);
       public          postgres    false            �            1255    17375 4   insertorupdatetoken(uuid, integer, text, text, text)    FUNCTION     0  CREATE FUNCTION public.insertorupdatetoken(token_id_param uuid, user_id_param integer, public_key_param text, private_key_param text, refresh_token_param text) RETURNS void
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
 �   DROP FUNCTION public.insertorupdatetoken(token_id_param uuid, user_id_param integer, public_key_param text, private_key_param text, refresh_token_param text);
       public          postgres    false            �            1259    17254    acedemic_rank    TABLE     n   CREATE TABLE public.acedemic_rank (
    ar_id integer NOT NULL,
    ar_name character varying(15) NOT NULL
);
 !   DROP TABLE public.acedemic_rank;
       public         heap    postgres    false            �            1259    17253    acedemic_rank_ar_id_seq    SEQUENCE     �   CREATE SEQUENCE public.acedemic_rank_ar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.acedemic_rank_ar_id_seq;
       public          postgres    false    234            �           0    0    acedemic_rank_ar_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.acedemic_rank_ar_id_seq OWNED BY public.acedemic_rank.ar_id;
          public          postgres    false    233            �            1259    17345 
   attachment    TABLE     �   CREATE TABLE public.attachment (
    attachment_id integer NOT NULL,
    post_id integer,
    file_name character varying(32),
    file_type smallint,
    file_url text
);
    DROP TABLE public.attachment;
       public         heap    postgres    false            �            1259    17344    attachment_attachment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attachment_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.attachment_attachment_id_seq;
       public          postgres    false    246            �           0    0    attachment_attachment_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.attachment_attachment_id_seq OWNED BY public.attachment.attachment_id;
          public          postgres    false    245            �            1259    17359    comment    TABLE     <  CREATE TABLE public.comment (
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
    DROP TABLE public.comment;
       public         heap    postgres    false            �            1259    17358    comment_comment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.comment_comment_id_seq;
       public          postgres    false    248            �           0    0    comment_comment_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;
          public          postgres    false    247            �            1259    17261    degree    TABLE     o   CREATE TABLE public.degree (
    degree_id integer NOT NULL,
    degree_name character varying(15) NOT NULL
);
    DROP TABLE public.degree;
       public         heap    postgres    false            �            1259    17260    degree_degree_id_seq    SEQUENCE     �   CREATE SEQUENCE public.degree_degree_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.degree_degree_id_seq;
       public          postgres    false    236            �           0    0    degree_degree_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.degree_degree_id_seq OWNED BY public.degree.degree_id;
          public          postgres    false    235            �            1259    17235 
   department    TABLE     �   CREATE TABLE public.department (
    department_id integer NOT NULL,
    user_id integer,
    department_name character varying(50) NOT NULL,
    department_code character varying(10)
);
    DROP TABLE public.department;
       public         heap    postgres    false            �            1259    17234    department_department_id_seq    SEQUENCE     �   CREATE SEQUENCE public.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.department_department_id_seq;
       public          postgres    false    230            �           0    0    department_department_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;
          public          postgres    false    229            �            1259    17247    faculty    TABLE     r   CREATE TABLE public.faculty (
    faculty_id integer NOT NULL,
    faculty_name character varying(20) NOT NULL
);
    DROP TABLE public.faculty;
       public         heap    postgres    false            �            1259    17246    faculty_faculty_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faculty_faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.faculty_faculty_id_seq;
       public          postgres    false    232            �           0    0    faculty_faculty_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.faculty_faculty_id_seq OWNED BY public.faculty.faculty_id;
          public          postgres    false    231            �            1259    17268    lecturer    TABLE     O  CREATE TABLE public.lecturer (
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
    DROP TABLE public.lecturer;
       public         heap    postgres    false            �            1259    17267    lecturer_lecturer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lecturer_lecturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.lecturer_lecturer_id_seq;
       public          postgres    false    238            �           0    0    lecturer_lecturer_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.lecturer_lecturer_id_seq OWNED BY public.lecturer.lecturer_id;
          public          postgres    false    237            �            1259    17150    link    TABLE     �   CREATE TABLE public.link (
    link_id integer NOT NULL,
    link_name character varying(15) NOT NULL,
    link_content text,
    profile_id integer
);
    DROP TABLE public.link;
       public         heap    postgres    false            �            1259    17149    link_link_id_seq    SEQUENCE     �   CREATE SEQUENCE public.link_link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.link_link_id_seq;
       public          postgres    false    217            �           0    0    link_link_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.link_link_id_seq OWNED BY public.link.link_id;
          public          postgres    false    216            �            1259    17204    major    TABLE     d   CREATE TABLE public.major (
    major_id smallint NOT NULL,
    major_name character varying(70)
);
    DROP TABLE public.major;
       public         heap    postgres    false            �            1259    17203    major_major_id_seq    SEQUENCE     �   CREATE SEQUENCE public.major_major_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.major_major_id_seq;
       public          postgres    false    226            �           0    0    major_major_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.major_major_id_seq OWNED BY public.major.major_id;
          public          postgres    false    225            �            1259    17295    post    TABLE     �   CREATE TABLE public.post (
    post_id integer NOT NULL,
    content text,
    user_id integer,
    privacy boolean,
    post_type smallint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);
    DROP TABLE public.post;
       public         heap    postgres    false            �            1259    17328 	   post_like    TABLE     j   CREATE TABLE public.post_like (
    like_id integer NOT NULL,
    post_id integer,
    user_id integer
);
    DROP TABLE public.post_like;
       public         heap    postgres    false            �            1259    17327    post_like_like_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_like_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.post_like_like_id_seq;
       public          postgres    false    244            �           0    0    post_like_like_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.post_like_like_id_seq OWNED BY public.post_like.like_id;
          public          postgres    false    243            �            1259    17294    post_post_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.post_post_id_seq;
       public          postgres    false    240            �           0    0    post_post_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.post_post_id_seq OWNED BY public.post.post_id;
          public          postgres    false    239            �            1259    17309 
   post_share    TABLE     ~   CREATE TABLE public.post_share (
    share_id integer NOT NULL,
    post_id integer,
    user_id integer,
    content text
);
    DROP TABLE public.post_share;
       public         heap    postgres    false            �            1259    17308    post_share_share_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_share_share_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.post_share_share_id_seq;
       public          postgres    false    242            �           0    0    post_share_share_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.post_share_share_id_seq OWNED BY public.post_share.share_id;
          public          postgres    false    241            �            1259    17159    role    TABLE     j   CREATE TABLE public.role (
    role_id smallint NOT NULL,
    role_name character varying(20) NOT NULL
);
    DROP TABLE public.role;
       public         heap    postgres    false            �            1259    17158    role_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.role_role_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.role_role_id_seq;
       public          postgres    false    219            �           0    0    role_role_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;
          public          postgres    false    218            �            1259    17211    student    TABLE     O  CREATE TABLE public.student (
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
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    17210    student_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.student_student_id_seq;
       public          postgres    false    228            �           0    0    student_student_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.student_student_id_seq OWNED BY public.student.student_id;
          public          postgres    false    227            �            1259    17191 
   token_keys    TABLE     �   CREATE TABLE public.token_keys (
    token_id uuid NOT NULL,
    user_id integer NOT NULL,
    private_key text NOT NULL,
    public_key text,
    refresh_token text,
    refresh_tokens_used text[]
);
    DROP TABLE public.token_keys;
       public         heap    postgres    false            �            1259    17143    university_class    TABLE     w   CREATE TABLE public.university_class (
    class_id integer NOT NULL,
    class_name character varying(10) NOT NULL
);
 $   DROP TABLE public.university_class;
       public         heap    postgres    false            �            1259    17142    university_class_class_id_seq    SEQUENCE     �   CREATE SEQUENCE public.university_class_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.university_class_class_id_seq;
       public          postgres    false    215            �           0    0    university_class_class_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.university_class_class_id_seq OWNED BY public.university_class.class_id;
          public          postgres    false    214            �            1259    17178    user_profile    TABLE     n   CREATE TABLE public.user_profile (
    user_profile_id integer NOT NULL,
    user_id integer,
    bio text
);
     DROP TABLE public.user_profile;
       public         heap    postgres    false            �            1259    17177     user_profile_user_profile_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_profile_user_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.user_profile_user_profile_id_seq;
       public          postgres    false    223            �           0    0     user_profile_user_profile_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.user_profile_user_profile_id_seq OWNED BY public.user_profile.user_profile_id;
          public          postgres    false    222            �            1259    17166    users    TABLE     @  CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(70) NOT NULL,
    password text NOT NULL,
    role smallint,
    phone_number character varying(12),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone,
    avatar text
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    17165    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    221            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    220            �           2604    17257    acedemic_rank ar_id    DEFAULT     z   ALTER TABLE ONLY public.acedemic_rank ALTER COLUMN ar_id SET DEFAULT nextval('public.acedemic_rank_ar_id_seq'::regclass);
 B   ALTER TABLE public.acedemic_rank ALTER COLUMN ar_id DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    17348    attachment attachment_id    DEFAULT     �   ALTER TABLE ONLY public.attachment ALTER COLUMN attachment_id SET DEFAULT nextval('public.attachment_attachment_id_seq'::regclass);
 G   ALTER TABLE public.attachment ALTER COLUMN attachment_id DROP DEFAULT;
       public          postgres    false    245    246    246            �           2604    17362    comment comment_id    DEFAULT     x   ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);
 A   ALTER TABLE public.comment ALTER COLUMN comment_id DROP DEFAULT;
       public          postgres    false    248    247    248            �           2604    17264    degree degree_id    DEFAULT     t   ALTER TABLE ONLY public.degree ALTER COLUMN degree_id SET DEFAULT nextval('public.degree_degree_id_seq'::regclass);
 ?   ALTER TABLE public.degree ALTER COLUMN degree_id DROP DEFAULT;
       public          postgres    false    236    235    236            �           2604    17238    department department_id    DEFAULT     �   ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);
 G   ALTER TABLE public.department ALTER COLUMN department_id DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    17250    faculty faculty_id    DEFAULT     x   ALTER TABLE ONLY public.faculty ALTER COLUMN faculty_id SET DEFAULT nextval('public.faculty_faculty_id_seq'::regclass);
 A   ALTER TABLE public.faculty ALTER COLUMN faculty_id DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    17271    lecturer lecturer_id    DEFAULT     |   ALTER TABLE ONLY public.lecturer ALTER COLUMN lecturer_id SET DEFAULT nextval('public.lecturer_lecturer_id_seq'::regclass);
 C   ALTER TABLE public.lecturer ALTER COLUMN lecturer_id DROP DEFAULT;
       public          postgres    false    237    238    238            �           2604    17153    link link_id    DEFAULT     l   ALTER TABLE ONLY public.link ALTER COLUMN link_id SET DEFAULT nextval('public.link_link_id_seq'::regclass);
 ;   ALTER TABLE public.link ALTER COLUMN link_id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    17207    major major_id    DEFAULT     p   ALTER TABLE ONLY public.major ALTER COLUMN major_id SET DEFAULT nextval('public.major_major_id_seq'::regclass);
 =   ALTER TABLE public.major ALTER COLUMN major_id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    17298    post post_id    DEFAULT     l   ALTER TABLE ONLY public.post ALTER COLUMN post_id SET DEFAULT nextval('public.post_post_id_seq'::regclass);
 ;   ALTER TABLE public.post ALTER COLUMN post_id DROP DEFAULT;
       public          postgres    false    239    240    240            �           2604    17331    post_like like_id    DEFAULT     v   ALTER TABLE ONLY public.post_like ALTER COLUMN like_id SET DEFAULT nextval('public.post_like_like_id_seq'::regclass);
 @   ALTER TABLE public.post_like ALTER COLUMN like_id DROP DEFAULT;
       public          postgres    false    243    244    244            �           2604    17312    post_share share_id    DEFAULT     z   ALTER TABLE ONLY public.post_share ALTER COLUMN share_id SET DEFAULT nextval('public.post_share_share_id_seq'::regclass);
 B   ALTER TABLE public.post_share ALTER COLUMN share_id DROP DEFAULT;
       public          postgres    false    242    241    242            �           2604    17162    role role_id    DEFAULT     l   ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);
 ;   ALTER TABLE public.role ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    17214    student student_id    DEFAULT     x   ALTER TABLE ONLY public.student ALTER COLUMN student_id SET DEFAULT nextval('public.student_student_id_seq'::regclass);
 A   ALTER TABLE public.student ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    17146    university_class class_id    DEFAULT     �   ALTER TABLE ONLY public.university_class ALTER COLUMN class_id SET DEFAULT nextval('public.university_class_class_id_seq'::regclass);
 H   ALTER TABLE public.university_class ALTER COLUMN class_id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    17181    user_profile user_profile_id    DEFAULT     �   ALTER TABLE ONLY public.user_profile ALTER COLUMN user_profile_id SET DEFAULT nextval('public.user_profile_user_profile_id_seq'::regclass);
 K   ALTER TABLE public.user_profile ALTER COLUMN user_profile_id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    17169    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    221    220    221            �          0    17254    acedemic_rank 
   TABLE DATA           7   COPY public.acedemic_rank (ar_id, ar_name) FROM stdin;
    public          postgres    false    234   ��       �          0    17345 
   attachment 
   TABLE DATA           \   COPY public.attachment (attachment_id, post_id, file_name, file_type, file_url) FROM stdin;
    public          postgres    false    246   ��       �          0    17359    comment 
   TABLE DATA           �   COPY public.comment (comment_id, post_id, user_id, content, created_at, updated_at, comment_parent_id, left_id, right_id) FROM stdin;
    public          postgres    false    248   ��       �          0    17261    degree 
   TABLE DATA           8   COPY public.degree (degree_id, degree_name) FROM stdin;
    public          postgres    false    236   ݳ       �          0    17235 
   department 
   TABLE DATA           ^   COPY public.department (department_id, user_id, department_name, department_code) FROM stdin;
    public          postgres    false    230   ��       �          0    17247    faculty 
   TABLE DATA           ;   COPY public.faculty (faculty_id, faculty_name) FROM stdin;
    public          postgres    false    232   �       �          0    17268    lecturer 
   TABLE DATA           �   COPY public.lecturer (lecturer_id, lecturer_code, academic_id, user_id, faculty_id, degree_id, gender, surname, last_name, date_of_birth) FROM stdin;
    public          postgres    false    238   4�       �          0    17150    link 
   TABLE DATA           L   COPY public.link (link_id, link_name, link_content, profile_id) FROM stdin;
    public          postgres    false    217   Q�       �          0    17204    major 
   TABLE DATA           5   COPY public.major (major_id, major_name) FROM stdin;
    public          postgres    false    226   n�       �          0    17295    post 
   TABLE DATA           e   COPY public.post (post_id, content, user_id, privacy, post_type, created_at, updated_at) FROM stdin;
    public          postgres    false    240   ��       �          0    17328 	   post_like 
   TABLE DATA           >   COPY public.post_like (like_id, post_id, user_id) FROM stdin;
    public          postgres    false    244   ��       �          0    17309 
   post_share 
   TABLE DATA           I   COPY public.post_share (share_id, post_id, user_id, content) FROM stdin;
    public          postgres    false    242   ��       �          0    17159    role 
   TABLE DATA           2   COPY public.role (role_id, role_name) FROM stdin;
    public          postgres    false    219   ��       �          0    17211    student 
   TABLE DATA           �   COPY public.student (student_id, user_id, student_code, surname, last_name, date_of_birth, gender, major_id, class_id, status) FROM stdin;
    public          postgres    false    228   �       �          0    17191 
   token_keys 
   TABLE DATA           t   COPY public.token_keys (token_id, user_id, private_key, public_key, refresh_token, refresh_tokens_used) FROM stdin;
    public          postgres    false    224   !�       �          0    17143    university_class 
   TABLE DATA           @   COPY public.university_class (class_id, class_name) FROM stdin;
    public          postgres    false    215   ]�       �          0    17178    user_profile 
   TABLE DATA           E   COPY public.user_profile (user_profile_id, user_id, bio) FROM stdin;
    public          postgres    false    223   z�       �          0    17166    users 
   TABLE DATA           m   COPY public.users (user_id, email, password, role, phone_number, created_at, last_login, avatar) FROM stdin;
    public          postgres    false    221   ��       �           0    0    acedemic_rank_ar_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.acedemic_rank_ar_id_seq', 1, false);
          public          postgres    false    233            �           0    0    attachment_attachment_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.attachment_attachment_id_seq', 1, false);
          public          postgres    false    245            �           0    0    comment_comment_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.comment_comment_id_seq', 1, false);
          public          postgres    false    247            �           0    0    degree_degree_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.degree_degree_id_seq', 1, false);
          public          postgres    false    235            �           0    0    department_department_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.department_department_id_seq', 1, false);
          public          postgres    false    229            �           0    0    faculty_faculty_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.faculty_faculty_id_seq', 1, false);
          public          postgres    false    231            �           0    0    lecturer_lecturer_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.lecturer_lecturer_id_seq', 1, false);
          public          postgres    false    237            �           0    0    link_link_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.link_link_id_seq', 1, false);
          public          postgres    false    216            �           0    0    major_major_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.major_major_id_seq', 1, false);
          public          postgres    false    225            �           0    0    post_like_like_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.post_like_like_id_seq', 1, false);
          public          postgres    false    243            �           0    0    post_post_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.post_post_id_seq', 22, true);
          public          postgres    false    239            �           0    0    post_share_share_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.post_share_share_id_seq', 1, false);
          public          postgres    false    241            �           0    0    role_role_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.role_role_id_seq', 4, true);
          public          postgres    false    218            �           0    0    student_student_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.student_student_id_seq', 1, false);
          public          postgres    false    227            �           0    0    university_class_class_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.university_class_class_id_seq', 1, false);
          public          postgres    false    214            �           0    0     user_profile_user_profile_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.user_profile_user_profile_id_seq', 1, false);
          public          postgres    false    222            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 1, true);
          public          postgres    false    220                       2606    17259     acedemic_rank acedemic_rank_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.acedemic_rank
    ADD CONSTRAINT acedemic_rank_pkey PRIMARY KEY (ar_id);
 J   ALTER TABLE ONLY public.acedemic_rank DROP CONSTRAINT acedemic_rank_pkey;
       public            postgres    false    234                       2606    17352    attachment attachment_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (attachment_id);
 D   ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_pkey;
       public            postgres    false    246                       2606    17364    comment comment_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public            postgres    false    248                       2606    17266    degree degree_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.degree
    ADD CONSTRAINT degree_pkey PRIMARY KEY (degree_id);
 <   ALTER TABLE ONLY public.degree DROP CONSTRAINT degree_pkey;
       public            postgres    false    236                       2606    17240    department department_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);
 D   ALTER TABLE ONLY public.department DROP CONSTRAINT department_pkey;
       public            postgres    false    230                       2606    17252    faculty faculty_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);
 >   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_pkey;
       public            postgres    false    232            
           2606    17273    lecturer lecturer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (lecturer_id);
 @   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_pkey;
       public            postgres    false    238            �           2606    17157    link link_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (link_id);
 8   ALTER TABLE ONLY public.link DROP CONSTRAINT link_pkey;
       public            postgres    false    217            �           2606    17209    major major_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (major_id);
 :   ALTER TABLE ONLY public.major DROP CONSTRAINT major_pkey;
       public            postgres    false    226                       2606    17333    post_like post_like_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_pkey PRIMARY KEY (like_id);
 B   ALTER TABLE ONLY public.post_like DROP CONSTRAINT post_like_pkey;
       public            postgres    false    244                       2606    17302    post post_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);
 8   ALTER TABLE ONLY public.post DROP CONSTRAINT post_pkey;
       public            postgres    false    240                       2606    17316    post_share post_share_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_pkey PRIMARY KEY (share_id);
 D   ALTER TABLE ONLY public.post_share DROP CONSTRAINT post_share_pkey;
       public            postgres    false    242            �           2606    17164    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            postgres    false    219            �           2606    17216    student student_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    228                        2606    17218     student student_student_code_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_student_code_key UNIQUE (student_code);
 J   ALTER TABLE ONLY public.student DROP CONSTRAINT student_student_code_key;
       public            postgres    false    228            �           2606    17197    token_keys token_keys_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.token_keys
    ADD CONSTRAINT token_keys_pkey PRIMARY KEY (token_id);
 D   ALTER TABLE ONLY public.token_keys DROP CONSTRAINT token_keys_pkey;
       public            postgres    false    224            �           2606    17148 &   university_class university_class_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.university_class
    ADD CONSTRAINT university_class_pkey PRIMARY KEY (class_id);
 P   ALTER TABLE ONLY public.university_class DROP CONSTRAINT university_class_pkey;
       public            postgres    false    215            �           2606    17185    user_profile user_profile_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (user_profile_id);
 H   ALTER TABLE ONLY public.user_profile DROP CONSTRAINT user_profile_pkey;
       public            postgres    false    223            �           2606    17176    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    221            �           2606    17174    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    221            $           2606    17353 "   attachment attachment_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 L   ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_post_id_fkey;
       public          postgres    false    3596    246    240            %           2606    17365    comment comment_post_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 F   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_post_id_fkey;
       public          postgres    false    3596    248    240            &           2606    17370    comment comment_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_user_id_fkey;
       public          postgres    false    248    221    3574                       2606    17241 "   department department_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.department DROP CONSTRAINT department_user_id_fkey;
       public          postgres    false    3574    230    221                       2606    17284 "   lecturer lecturer_academic_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_academic_id_fkey FOREIGN KEY (academic_id) REFERENCES public.acedemic_rank(ar_id);
 L   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_academic_id_fkey;
       public          postgres    false    234    3590    238                       2606    17279     lecturer lecturer_degree_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_degree_id_fkey FOREIGN KEY (degree_id) REFERENCES public.degree(degree_id);
 J   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_degree_id_fkey;
       public          postgres    false    238    236    3592                       2606    17289 !   lecturer lecturer_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);
 K   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_faculty_id_fkey;
       public          postgres    false    232    238    3588                       2606    17274    lecturer lecturer_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 H   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_user_id_fkey;
       public          postgres    false    3574    221    238            "           2606    17339     post_like post_like_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 J   ALTER TABLE ONLY public.post_like DROP CONSTRAINT post_like_post_id_fkey;
       public          postgres    false    3596    244    240            #           2606    17334     post_like post_like_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.post_like DROP CONSTRAINT post_like_user_id_fkey;
       public          postgres    false    244    221    3574                        2606    17322 "   post_share post_share_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 L   ALTER TABLE ONLY public.post_share DROP CONSTRAINT post_share_post_id_fkey;
       public          postgres    false    240    242    3596            !           2606    17317 "   post_share post_share_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.post_share DROP CONSTRAINT post_share_user_id_fkey;
       public          postgres    false    221    242    3574                       2606    17303    post post_user_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.post DROP CONSTRAINT post_user_id_fkey;
       public          postgres    false    221    240    3574                       2606    17229    student student_class_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.university_class(class_id);
 G   ALTER TABLE ONLY public.student DROP CONSTRAINT student_class_id_fkey;
       public          postgres    false    215    3566    228                       2606    17219    student student_major_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_major_id_fkey FOREIGN KEY (major_id) REFERENCES public.major(major_id);
 G   ALTER TABLE ONLY public.student DROP CONSTRAINT student_major_id_fkey;
       public          postgres    false    226    3580    228                       2606    17224    student student_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.student DROP CONSTRAINT student_user_id_fkey;
       public          postgres    false    221    3574    228                       2606    17198 "   token_keys token_keys_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.token_keys
    ADD CONSTRAINT token_keys_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.token_keys DROP CONSTRAINT token_keys_user_id_fkey;
       public          postgres    false    221    224    3574                       2606    17186 &   user_profile user_profile_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.user_profile DROP CONSTRAINT user_profile_user_id_fkey;
       public          postgres    false    3574    223    221            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x���KN1���s,����+PY����I���
R�?�RlY�?7Z����1
#��WW����ТYp��j�Ds�,C�\s�3�����c|����Ъ�a	���j�z`���l��s��F��Ⴧ�`�[�N�ES���a}bS"L��3�{�"�Te��o#�8X�q��_k����G�_��lV-�H,o�˟r���$<ڽ�V�4I��*���oG���      �      x������ � �      �      x������ � �      �   5   x�3�.)MI�+�2��IM.)-J-�2�tI-H,*���p:��f�q��qqq b�      �      x������ � �      �   ,  x���I��8 �s�o�BB�U\@�����l H���15�}���;s�( $��ݰ�0t>�X#� b�.F����ФoڛN #�!qh@c��L�L
���f`���ZC�L��4$f��A��4�I��LZ�D�2C`nQ�CA�aJ�1	�!M�5��aT`ƅ�鈽1�`A� nB�,�,l0hp�K�	�H �j+d	$@!�Aa 	1�,H�����
�:*�BcL�B�Y�a� �:@�Z bj�d�fj�x�Ow��
*�IzG�+��#̧��N�t��H�0}~n�*�g�+��msq�ʶn��&���*��u}̯Nu��v����Ϟ��@��x=u��쁼������!��s��S��v�����wv���1YO�hl�G��&y�&o�B��R���"�w�Ï#�q�aX�yt�����d��r���-��k|�g�a��J�8�^�^��)���۸�"��W�QWe�k�$�e�+��(�s3�u&ֽ~�^š���F��Q5?�q4�y����ˤm�L�f;��%Z>���*h��Wq�y�:��e�h��؛���O}�ʘ�Gk��Y�X�d�'����S�b�z�I�ӿ4#:�<OW�X�s'=sg*\�� �md��P��=��?�1W��������K�=�m�NP�?_,�n6`f����gD��$���ݳ×Z��mU+���M�{Vk;�PD�fc%~��B��C�y�4������_��ӯ���g�y��l���<Z��H~Zx]��M!Yc��#0�8�U����rP���g�q|lk��o ��G���eS�v�wv6��⟉�Ys��_;��8��^����_�u�5��d�FU��6� �|����:���?�:�]+��C�V��K�Z��ٹ�v�Z͈�yj�D�+��|~��j���0b5X�z�� �S�ŷUsz�ЋrW����Ο��F�k��]*��d
B��(���Q觳��B��b|?��<$��[}�"�ɺ7��Us���JM�vui%~��ax����R�"U�y��CoZ�50�+o�>8����)�{�,�����������،�      �      x������ � �      �      x������ � �      �   ~   x�3�LLJNq(�.�+M��+��T1JR14P��.K1ϩ�/*(/4)t�-�N��-3(��24��7�4M-(�L��u(O*-M7�4����4202�5 "3#C+c+=cccKC�l�W� 7�"�     