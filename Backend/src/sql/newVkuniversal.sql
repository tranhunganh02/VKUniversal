PGDMP     '    1                |            vkuniversal    15.4    15.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17633    vkuniversal    DATABASE     �   CREATE DATABASE vkuniversal WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE vkuniversal;
                postgres    false            	           1255    17859 -   delete_post_and_attachments(integer, integer)    FUNCTION     �  CREATE FUNCTION public.delete_post_and_attachments(post_id integer, user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
  success BOOLEAN := FALSE;
BEGIN
  BEGIN
    -- Xoá các tệp đính kèm có post_id tương ứng
    DELETE FROM Attachment WHERE Attachment.post_id = $1;
    
    -- Xoá bài viết có post_id tương ứng
    DELETE FROM Post WHERE Post.post_id = $1 AND Post.user_id = $2;

    -- Đặt biến success thành TRUE nếu không có lỗi xảy ra
    success := TRUE;
  
  EXCEPTION
    -- Xử lý ngoại lệ và ghi lại thông báo lỗi
    WHEN OTHERS THEN
      RAISE NOTICE 'Error deleting post and attachments: %', SQLERRM;
END;

-- Trả về giá trị của biến success
RETURN success;
END;
$_$;
 T   DROP FUNCTION public.delete_post_and_attachments(post_id integer, user_id integer);
       public          postgres    false            
           1255    17923 "   delete_sell_post(integer, integer)    FUNCTION     v  CREATE FUNCTION public.delete_sell_post(sell_post_id integer, user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
    row_deleted BOOLEAN;
BEGIN
    DELETE FROM sell_post 
    WHERE sell_post_id = $1 AND user_id = $2
    RETURNING true INTO row_deleted;

    IF row_deleted THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$_$;
 N   DROP FUNCTION public.delete_sell_post(sell_post_id integer, user_id integer);
       public          postgres    false            �            1255    17858    find_and_delete_user(integer)    FUNCTION     �   CREATE FUNCTION public.find_and_delete_user(user_id_to_find integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Xóa hàng trong bảng token_keys dựa trên userId
  DELETE FROM token_keys WHERE user_id = user_id_to_find;
END;
$$;
 D   DROP FUNCTION public.find_and_delete_user(user_id_to_find integer);
       public          postgres    false                       1255    17856 4   insertorupdatetoken(uuid, integer, text, text, text)    FUNCTION     0  CREATE FUNCTION public.insertorupdatetoken(token_id_param uuid, user_id_param integer, public_key_param text, private_key_param text, refresh_token_param text) RETURNS void
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
       public          postgres    false            �            1259    17735    acedemic_rank    TABLE     n   CREATE TABLE public.acedemic_rank (
    ar_id integer NOT NULL,
    ar_name character varying(15) NOT NULL
);
 !   DROP TABLE public.acedemic_rank;
       public         heap    postgres    false            �            1259    17734    acedemic_rank_ar_id_seq    SEQUENCE     �   CREATE SEQUENCE public.acedemic_rank_ar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.acedemic_rank_ar_id_seq;
       public          postgres    false    232            �           0    0    acedemic_rank_ar_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.acedemic_rank_ar_id_seq OWNED BY public.acedemic_rank.ar_id;
          public          postgres    false    231            �            1259    17826 
   attachment    TABLE     �   CREATE TABLE public.attachment (
    attachment_id integer NOT NULL,
    post_id integer,
    file_name character varying(225),
    file_type smallint,
    file_url text
);
    DROP TABLE public.attachment;
       public         heap    postgres    false            �            1259    17825    attachment_attachment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attachment_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.attachment_attachment_id_seq;
       public          postgres    false    244            �           0    0    attachment_attachment_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.attachment_attachment_id_seq OWNED BY public.attachment.attachment_id;
          public          postgres    false    243            �            1259    17905    category    TABLE     w   CREATE TABLE public.category (
    category_id smallint NOT NULL,
    category_name character varying(255) NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    17904    category_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.category_category_id_seq;
       public          postgres    false    250            �           0    0    category_category_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;
          public          postgres    false    249            �            1259    17742    degree    TABLE     o   CREATE TABLE public.degree (
    degree_id integer NOT NULL,
    degree_name character varying(15) NOT NULL
);
    DROP TABLE public.degree;
       public         heap    postgres    false            �            1259    17741    degree_degree_id_seq    SEQUENCE     �   CREATE SEQUENCE public.degree_degree_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.degree_degree_id_seq;
       public          postgres    false    234            �           0    0    degree_degree_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.degree_degree_id_seq OWNED BY public.degree.degree_id;
          public          postgres    false    233            �            1259    17723 
   department    TABLE     �   CREATE TABLE public.department (
    department_id integer NOT NULL,
    user_id integer,
    department_name character varying(50) NOT NULL,
    department_code character varying(10)
);
    DROP TABLE public.department;
       public         heap    postgres    false            �            1259    17722    department_department_id_seq    SEQUENCE     �   CREATE SEQUENCE public.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.department_department_id_seq;
       public          postgres    false    230            �           0    0    department_department_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;
          public          postgres    false    229            �            1259    17680    faculty    TABLE     s   CREATE TABLE public.faculty (
    faculty_id smallint NOT NULL,
    faculty_name character varying(80) NOT NULL
);
    DROP TABLE public.faculty;
       public         heap    postgres    false            �            1259    17679    faculty_faculty_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faculty_faculty_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.faculty_faculty_id_seq;
       public          postgres    false    222            �           0    0    faculty_faculty_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.faculty_faculty_id_seq OWNED BY public.faculty.faculty_id;
          public          postgres    false    221            �            1259    17927    follow    TABLE     Q   CREATE TABLE public.follow (
    follower_id integer,
    followed_id integer
);
    DROP TABLE public.follow;
       public         heap    postgres    false            �            1259    17749    lecturer    TABLE     O  CREATE TABLE public.lecturer (
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
       public         heap    postgres    false            �            1259    17748    lecturer_lecturer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lecturer_lecturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.lecturer_lecturer_id_seq;
       public          postgres    false    236            �           0    0    lecturer_lecturer_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.lecturer_lecturer_id_seq OWNED BY public.lecturer.lecturer_id;
          public          postgres    false    235            �            1259    17687    major    TABLE     }   CREATE TABLE public.major (
    major_id smallint NOT NULL,
    major_name character varying(80),
    faculty_id smallint
);
    DROP TABLE public.major;
       public         heap    postgres    false            �            1259    17686    major_major_id_seq    SEQUENCE     �   CREATE SEQUENCE public.major_major_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.major_major_id_seq;
       public          postgres    false    224            �           0    0    major_major_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.major_major_id_seq OWNED BY public.major.major_id;
          public          postgres    false    223            �            1259    17776    post    TABLE     �   CREATE TABLE public.post (
    post_id integer NOT NULL,
    content text,
    user_id integer,
    privacy boolean,
    post_type smallint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);
    DROP TABLE public.post;
       public         heap    postgres    false            �            1259    17809 	   post_like    TABLE     j   CREATE TABLE public.post_like (
    like_id integer NOT NULL,
    post_id integer,
    user_id integer
);
    DROP TABLE public.post_like;
       public         heap    postgres    false            �            1259    17808    post_like_like_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_like_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.post_like_like_id_seq;
       public          postgres    false    242            �           0    0    post_like_like_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.post_like_like_id_seq OWNED BY public.post_like.like_id;
          public          postgres    false    241            �            1259    17775    post_post_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.post_post_id_seq;
       public          postgres    false    238            �           0    0    post_post_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.post_post_id_seq OWNED BY public.post.post_id;
          public          postgres    false    237            �            1259    17790 
   post_share    TABLE     ~   CREATE TABLE public.post_share (
    share_id integer NOT NULL,
    post_id integer,
    user_id integer,
    content text
);
    DROP TABLE public.post_share;
       public         heap    postgres    false            �            1259    17789    post_share_share_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_share_share_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.post_share_share_id_seq;
       public          postgres    false    240            �           0    0    post_share_share_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.post_share_share_id_seq OWNED BY public.post_share.share_id;
          public          postgres    false    239            �            1259    17861    product_type    TABLE     �   CREATE TABLE public.product_type (
    product_type_id smallint NOT NULL,
    product_title character varying(255) NOT NULL,
    category_id smallint
);
     DROP TABLE public.product_type;
       public         heap    postgres    false            �            1259    17860     product_type_product_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_type_product_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.product_type_product_type_id_seq;
       public          postgres    false    246            �           0    0     product_type_product_type_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.product_type_product_type_id_seq OWNED BY public.product_type.product_type_id;
          public          postgres    false    245            �            1259    17661    role    TABLE     j   CREATE TABLE public.role (
    role_id smallint NOT NULL,
    role_name character varying(20) NOT NULL
);
    DROP TABLE public.role;
       public         heap    postgres    false            �            1259    17660    role_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.role_role_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.role_role_id_seq;
       public          postgres    false    219            �           0    0    role_role_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;
          public          postgres    false    218            �            1259    17886 	   sell_post    TABLE     �  CREATE TABLE public.sell_post (
    sell_post_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    product_type smallint,
    price numeric(10,2) NOT NULL,
    detail text,
    user_id integer,
    address character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    image_url text[]
);
    DROP TABLE public.sell_post;
       public         heap    postgres    false            �            1259    17885    sell_post_sell_post_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sell_post_sell_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.sell_post_sell_post_id_seq;
       public          postgres    false    248                        0    0    sell_post_sell_post_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.sell_post_sell_post_id_seq OWNED BY public.sell_post.sell_post_id;
          public          postgres    false    247            �            1259    17711    student    TABLE       CREATE TABLE public.student (
    student_id integer NOT NULL,
    user_id integer,
    student_code character varying(7),
    surname character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    date_of_birth date,
    gender smallint,
    class_id smallint
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    17710    student_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.student_student_id_seq;
       public          postgres    false    228                       0    0    student_student_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.student_student_id_seq OWNED BY public.student.student_id;
          public          postgres    false    227            �            1259    17667 
   token_keys    TABLE     �   CREATE TABLE public.token_keys (
    token_id uuid NOT NULL,
    user_id integer NOT NULL,
    private_key text NOT NULL,
    public_key text,
    refresh_token text,
    refresh_tokens_used text[]
);
    DROP TABLE public.token_keys;
       public         heap    postgres    false            �            1259    17699    university_class    TABLE     �   CREATE TABLE public.university_class (
    class_id integer NOT NULL,
    class_name character varying(10) NOT NULL,
    major_id smallint
);
 $   DROP TABLE public.university_class;
       public         heap    postgres    false            �            1259    17698    university_class_class_id_seq    SEQUENCE     �   CREATE SEQUENCE public.university_class_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.university_class_class_id_seq;
       public          postgres    false    226                       0    0    university_class_class_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.university_class_class_id_seq OWNED BY public.university_class.class_id;
          public          postgres    false    225            �            1259    17647    user_profile    TABLE     n   CREATE TABLE public.user_profile (
    user_profile_id integer NOT NULL,
    user_id integer,
    bio text
);
     DROP TABLE public.user_profile;
       public         heap    postgres    false            �            1259    17646     user_profile_user_profile_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_profile_user_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.user_profile_user_profile_id_seq;
       public          postgres    false    217                       0    0     user_profile_user_profile_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.user_profile_user_profile_id_seq OWNED BY public.user_profile.user_profile_id;
          public          postgres    false    216            �            1259    17635    users    TABLE     @  CREATE TABLE public.users (
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
       public         heap    postgres    false            �            1259    17634    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    215                       0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    214            �           2604    17738    acedemic_rank ar_id    DEFAULT     z   ALTER TABLE ONLY public.acedemic_rank ALTER COLUMN ar_id SET DEFAULT nextval('public.acedemic_rank_ar_id_seq'::regclass);
 B   ALTER TABLE public.acedemic_rank ALTER COLUMN ar_id DROP DEFAULT;
       public          postgres    false    231    232    232            �           2604    17829    attachment attachment_id    DEFAULT     �   ALTER TABLE ONLY public.attachment ALTER COLUMN attachment_id SET DEFAULT nextval('public.attachment_attachment_id_seq'::regclass);
 G   ALTER TABLE public.attachment ALTER COLUMN attachment_id DROP DEFAULT;
       public          postgres    false    243    244    244            �           2604    17908    category category_id    DEFAULT     |   ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);
 C   ALTER TABLE public.category ALTER COLUMN category_id DROP DEFAULT;
       public          postgres    false    249    250    250            �           2604    17745    degree degree_id    DEFAULT     t   ALTER TABLE ONLY public.degree ALTER COLUMN degree_id SET DEFAULT nextval('public.degree_degree_id_seq'::regclass);
 ?   ALTER TABLE public.degree ALTER COLUMN degree_id DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    17726    department department_id    DEFAULT     �   ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);
 G   ALTER TABLE public.department ALTER COLUMN department_id DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    17683    faculty faculty_id    DEFAULT     x   ALTER TABLE ONLY public.faculty ALTER COLUMN faculty_id SET DEFAULT nextval('public.faculty_faculty_id_seq'::regclass);
 A   ALTER TABLE public.faculty ALTER COLUMN faculty_id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    17752    lecturer lecturer_id    DEFAULT     |   ALTER TABLE ONLY public.lecturer ALTER COLUMN lecturer_id SET DEFAULT nextval('public.lecturer_lecturer_id_seq'::regclass);
 C   ALTER TABLE public.lecturer ALTER COLUMN lecturer_id DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    17690    major major_id    DEFAULT     p   ALTER TABLE ONLY public.major ALTER COLUMN major_id SET DEFAULT nextval('public.major_major_id_seq'::regclass);
 =   ALTER TABLE public.major ALTER COLUMN major_id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    17779    post post_id    DEFAULT     l   ALTER TABLE ONLY public.post ALTER COLUMN post_id SET DEFAULT nextval('public.post_post_id_seq'::regclass);
 ;   ALTER TABLE public.post ALTER COLUMN post_id DROP DEFAULT;
       public          postgres    false    237    238    238            �           2604    17812    post_like like_id    DEFAULT     v   ALTER TABLE ONLY public.post_like ALTER COLUMN like_id SET DEFAULT nextval('public.post_like_like_id_seq'::regclass);
 @   ALTER TABLE public.post_like ALTER COLUMN like_id DROP DEFAULT;
       public          postgres    false    242    241    242            �           2604    17793    post_share share_id    DEFAULT     z   ALTER TABLE ONLY public.post_share ALTER COLUMN share_id SET DEFAULT nextval('public.post_share_share_id_seq'::regclass);
 B   ALTER TABLE public.post_share ALTER COLUMN share_id DROP DEFAULT;
       public          postgres    false    239    240    240            �           2604    17864    product_type product_type_id    DEFAULT     �   ALTER TABLE ONLY public.product_type ALTER COLUMN product_type_id SET DEFAULT nextval('public.product_type_product_type_id_seq'::regclass);
 K   ALTER TABLE public.product_type ALTER COLUMN product_type_id DROP DEFAULT;
       public          postgres    false    245    246    246            �           2604    17664    role role_id    DEFAULT     l   ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);
 ;   ALTER TABLE public.role ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    17889    sell_post sell_post_id    DEFAULT     �   ALTER TABLE ONLY public.sell_post ALTER COLUMN sell_post_id SET DEFAULT nextval('public.sell_post_sell_post_id_seq'::regclass);
 E   ALTER TABLE public.sell_post ALTER COLUMN sell_post_id DROP DEFAULT;
       public          postgres    false    247    248    248            �           2604    17714    student student_id    DEFAULT     x   ALTER TABLE ONLY public.student ALTER COLUMN student_id SET DEFAULT nextval('public.student_student_id_seq'::regclass);
 A   ALTER TABLE public.student ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    17702    university_class class_id    DEFAULT     �   ALTER TABLE ONLY public.university_class ALTER COLUMN class_id SET DEFAULT nextval('public.university_class_class_id_seq'::regclass);
 H   ALTER TABLE public.university_class ALTER COLUMN class_id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    17650    user_profile user_profile_id    DEFAULT     �   ALTER TABLE ONLY public.user_profile ALTER COLUMN user_profile_id SET DEFAULT nextval('public.user_profile_user_profile_id_seq'::regclass);
 K   ALTER TABLE public.user_profile ALTER COLUMN user_profile_id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    17638    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    214    215    215            �          0    17735    acedemic_rank 
   TABLE DATA           7   COPY public.acedemic_rank (ar_id, ar_name) FROM stdin;
    public          postgres    false    232   t�       �          0    17826 
   attachment 
   TABLE DATA           \   COPY public.attachment (attachment_id, post_id, file_name, file_type, file_url) FROM stdin;
    public          postgres    false    244   ��       �          0    17905    category 
   TABLE DATA           >   COPY public.category (category_id, category_name) FROM stdin;
    public          postgres    false    250   ��       �          0    17742    degree 
   TABLE DATA           8   COPY public.degree (degree_id, degree_name) FROM stdin;
    public          postgres    false    234   W�       �          0    17723 
   department 
   TABLE DATA           ^   COPY public.department (department_id, user_id, department_name, department_code) FROM stdin;
    public          postgres    false    230   ��       �          0    17680    faculty 
   TABLE DATA           ;   COPY public.faculty (faculty_id, faculty_name) FROM stdin;
    public          postgres    false    222   ��       �          0    17927    follow 
   TABLE DATA           :   COPY public.follow (follower_id, followed_id) FROM stdin;
    public          postgres    false    251   )�       �          0    17749    lecturer 
   TABLE DATA           �   COPY public.lecturer (lecturer_id, lecturer_code, academic_id, user_id, faculty_id, degree_id, gender, surname, last_name, date_of_birth) FROM stdin;
    public          postgres    false    236   V�       �          0    17687    major 
   TABLE DATA           A   COPY public.major (major_id, major_name, faculty_id) FROM stdin;
    public          postgres    false    224   ��       �          0    17776    post 
   TABLE DATA           e   COPY public.post (post_id, content, user_id, privacy, post_type, created_at, updated_at) FROM stdin;
    public          postgres    false    238   5�       �          0    17809 	   post_like 
   TABLE DATA           >   COPY public.post_like (like_id, post_id, user_id) FROM stdin;
    public          postgres    false    242   ��       �          0    17790 
   post_share 
   TABLE DATA           I   COPY public.post_share (share_id, post_id, user_id, content) FROM stdin;
    public          postgres    false    240   ��       �          0    17861    product_type 
   TABLE DATA           S   COPY public.product_type (product_type_id, product_title, category_id) FROM stdin;
    public          postgres    false    246   ��       �          0    17661    role 
   TABLE DATA           2   COPY public.role (role_id, role_name) FROM stdin;
    public          postgres    false    219   Y�       �          0    17886 	   sell_post 
   TABLE DATA           �   COPY public.sell_post (sell_post_id, product_name, product_type, price, detail, user_id, address, created_at, updated_at, image_url) FROM stdin;
    public          postgres    false    248   ��       �          0    17711    student 
   TABLE DATA           y   COPY public.student (student_id, user_id, student_code, surname, last_name, date_of_birth, gender, class_id) FROM stdin;
    public          postgres    false    228   D�       �          0    17667 
   token_keys 
   TABLE DATA           t   COPY public.token_keys (token_id, user_id, private_key, public_key, refresh_token, refresh_tokens_used) FROM stdin;
    public          postgres    false    220   ��       �          0    17699    university_class 
   TABLE DATA           J   COPY public.university_class (class_id, class_name, major_id) FROM stdin;
    public          postgres    false    226   �      �          0    17647    user_profile 
   TABLE DATA           E   COPY public.user_profile (user_profile_id, user_id, bio) FROM stdin;
    public          postgres    false    217   �      �          0    17635    users 
   TABLE DATA           m   COPY public.users (user_id, email, password, role, phone_number, created_at, last_login, avatar) FROM stdin;
    public          postgres    false    215   �                 0    0    acedemic_rank_ar_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.acedemic_rank_ar_id_seq', 5, true);
          public          postgres    false    231                       0    0    attachment_attachment_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.attachment_attachment_id_seq', 29, true);
          public          postgres    false    243                       0    0    category_category_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.category_category_id_seq', 5, true);
          public          postgres    false    249                       0    0    degree_degree_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.degree_degree_id_seq', 3, true);
          public          postgres    false    233            	           0    0    department_department_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.department_department_id_seq', 9, true);
          public          postgres    false    229            
           0    0    faculty_faculty_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.faculty_faculty_id_seq', 3, true);
          public          postgres    false    221                       0    0    lecturer_lecturer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.lecturer_lecturer_id_seq', 1, true);
          public          postgres    false    235                       0    0    major_major_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.major_major_id_seq', 20, true);
          public          postgres    false    223                       0    0    post_like_like_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.post_like_like_id_seq', 1, false);
          public          postgres    false    241                       0    0    post_post_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.post_post_id_seq', 33, true);
          public          postgres    false    237                       0    0    post_share_share_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.post_share_share_id_seq', 1, false);
          public          postgres    false    239                       0    0     product_type_product_type_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.product_type_product_type_id_seq', 23, true);
          public          postgres    false    245                       0    0    role_role_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.role_role_id_seq', 4, true);
          public          postgres    false    218                       0    0    sell_post_sell_post_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sell_post_sell_post_id_seq', 8, true);
          public          postgres    false    247                       0    0    student_student_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.student_student_id_seq', 3, true);
          public          postgres    false    227                       0    0    university_class_class_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.university_class_class_id_seq', 94, true);
          public          postgres    false    225                       0    0     user_profile_user_profile_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.user_profile_user_profile_id_seq', 13, true);
          public          postgres    false    216                       0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 29, true);
          public          postgres    false    214                       2606    17740     acedemic_rank acedemic_rank_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.acedemic_rank
    ADD CONSTRAINT acedemic_rank_pkey PRIMARY KEY (ar_id);
 J   ALTER TABLE ONLY public.acedemic_rank DROP CONSTRAINT acedemic_rank_pkey;
       public            postgres    false    232                       2606    17833    attachment attachment_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (attachment_id);
 D   ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_pkey;
       public            postgres    false    244            "           2606    17910    category category_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    250                       2606    17747    degree degree_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.degree
    ADD CONSTRAINT degree_pkey PRIMARY KEY (degree_id);
 <   ALTER TABLE ONLY public.degree DROP CONSTRAINT degree_pkey;
       public            postgres    false    234                       2606    17728    department department_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);
 D   ALTER TABLE ONLY public.department DROP CONSTRAINT department_pkey;
       public            postgres    false    230                       2606    17685    faculty faculty_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);
 >   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_pkey;
       public            postgres    false    222                       2606    17754    lecturer lecturer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (lecturer_id);
 @   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_pkey;
       public            postgres    false    236                       2606    17692    major major_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (major_id);
 :   ALTER TABLE ONLY public.major DROP CONSTRAINT major_pkey;
       public            postgres    false    224                       2606    17814    post_like post_like_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_pkey PRIMARY KEY (like_id);
 B   ALTER TABLE ONLY public.post_like DROP CONSTRAINT post_like_pkey;
       public            postgres    false    242                       2606    17783    post post_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);
 8   ALTER TABLE ONLY public.post DROP CONSTRAINT post_pkey;
       public            postgres    false    238                       2606    17797    post_share post_share_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_pkey PRIMARY KEY (share_id);
 D   ALTER TABLE ONLY public.post_share DROP CONSTRAINT post_share_pkey;
       public            postgres    false    240                       2606    17866    product_type product_type_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT product_type_pkey PRIMARY KEY (product_type_id);
 H   ALTER TABLE ONLY public.product_type DROP CONSTRAINT product_type_pkey;
       public            postgres    false    246                       2606    17666    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            postgres    false    219                        2606    17893    sell_post sell_post_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.sell_post
    ADD CONSTRAINT sell_post_pkey PRIMARY KEY (sell_post_id);
 B   ALTER TABLE ONLY public.sell_post DROP CONSTRAINT sell_post_pkey;
       public            postgres    false    248                       2606    17716    student student_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    228                       2606    17673    token_keys token_keys_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.token_keys
    ADD CONSTRAINT token_keys_pkey PRIMARY KEY (token_id);
 D   ALTER TABLE ONLY public.token_keys DROP CONSTRAINT token_keys_pkey;
       public            postgres    false    220            	           2606    17704 &   university_class university_class_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.university_class
    ADD CONSTRAINT university_class_pkey PRIMARY KEY (class_id);
 P   ALTER TABLE ONLY public.university_class DROP CONSTRAINT university_class_pkey;
       public            postgres    false    226            �           2606    17654    user_profile user_profile_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (user_profile_id);
 H   ALTER TABLE ONLY public.user_profile DROP CONSTRAINT user_profile_pkey;
       public            postgres    false    217            �           2606    17645    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    215            �           2606    17643    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215                       1259    17926    user_id_1715845828369_index    INDEX     R   CREATE INDEX user_id_1715845828369_index ON public.student USING btree (user_id);
 /   DROP INDEX public.user_id_1715845828369_index;
       public            postgres    false    228            3           2606    17834 "   attachment attachment_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 L   ALTER TABLE ONLY public.attachment DROP CONSTRAINT attachment_post_id_fkey;
       public          postgres    false    238    244    3606            (           2606    17729 "   department department_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.department DROP CONSTRAINT department_user_id_fkey;
       public          postgres    false    230    3581    215            )           2606    17957    lecturer fk_academic_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT fk_academic_id FOREIGN KEY (academic_id) REFERENCES public.acedemic_rank(ar_id);
 A   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT fk_academic_id;
       public          postgres    false    236    232    3600            7           2606    17935    follow follow_followed_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_followed_id_fkey FOREIGN KEY (followed_id) REFERENCES public.users(user_id);
 H   ALTER TABLE ONLY public.follow DROP CONSTRAINT follow_followed_id_fkey;
       public          postgres    false    3581    251    215            8           2606    17930    follow follow_follower_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public.users(user_id);
 H   ALTER TABLE ONLY public.follow DROP CONSTRAINT follow_follower_id_fkey;
       public          postgres    false    251    215    3581            *           2606    17765 "   lecturer lecturer_academic_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_academic_id_fkey FOREIGN KEY (academic_id) REFERENCES public.acedemic_rank(ar_id);
 L   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_academic_id_fkey;
       public          postgres    false    232    236    3600            +           2606    17760     lecturer lecturer_degree_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_degree_id_fkey FOREIGN KEY (degree_id) REFERENCES public.degree(degree_id);
 J   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_degree_id_fkey;
       public          postgres    false    234    3602    236            ,           2606    17770 !   lecturer lecturer_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);
 K   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_faculty_id_fkey;
       public          postgres    false    222    236    3589            -           2606    17755    lecturer lecturer_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 H   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT lecturer_user_id_fkey;
       public          postgres    false    3581    215    236            %           2606    17693    major major_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);
 E   ALTER TABLE ONLY public.major DROP CONSTRAINT major_faculty_id_fkey;
       public          postgres    false    3589    224    222            1           2606    17820     post_like post_like_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 J   ALTER TABLE ONLY public.post_like DROP CONSTRAINT post_like_post_id_fkey;
       public          postgres    false    238    242    3606            2           2606    17815     post_like post_like_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_like
    ADD CONSTRAINT post_like_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.post_like DROP CONSTRAINT post_like_user_id_fkey;
       public          postgres    false    242    215    3581            /           2606    17803 "   post_share post_share_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 L   ALTER TABLE ONLY public.post_share DROP CONSTRAINT post_share_post_id_fkey;
       public          postgres    false    3606    238    240            0           2606    17798 "   post_share post_share_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.post_share
    ADD CONSTRAINT post_share_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.post_share DROP CONSTRAINT post_share_user_id_fkey;
       public          postgres    false    3581    240    215            .           2606    17784    post post_user_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.post DROP CONSTRAINT post_user_id_fkey;
       public          postgres    false    215    3581    238            4           2606    17911 *   product_type product_type_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT product_type_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id);
 T   ALTER TABLE ONLY public.product_type DROP CONSTRAINT product_type_category_id_fkey;
       public          postgres    false    3618    246    250            5           2606    17894 %   sell_post sell_post_product_type_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sell_post
    ADD CONSTRAINT sell_post_product_type_fkey FOREIGN KEY (product_type) REFERENCES public.product_type(product_type_id);
 O   ALTER TABLE ONLY public.sell_post DROP CONSTRAINT sell_post_product_type_fkey;
       public          postgres    false    246    248    3614            6           2606    17899     sell_post sell_post_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sell_post
    ADD CONSTRAINT sell_post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.sell_post DROP CONSTRAINT sell_post_user_id_fkey;
       public          postgres    false    3581    248    215            '           2606    17717    student student_class_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.university_class(class_id);
 G   ALTER TABLE ONLY public.student DROP CONSTRAINT student_class_id_fkey;
       public          postgres    false    226    3593    228            $           2606    17674 "   token_keys token_keys_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.token_keys
    ADD CONSTRAINT token_keys_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.token_keys DROP CONSTRAINT token_keys_user_id_fkey;
       public          postgres    false    215    220    3581            &           2606    17705 /   university_class university_class_major_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.university_class
    ADD CONSTRAINT university_class_major_id_fkey FOREIGN KEY (major_id) REFERENCES public.major(major_id);
 Y   ALTER TABLE ONLY public.university_class DROP CONSTRAINT university_class_major_id_fkey;
       public          postgres    false    226    3591    224            #           2606    17655 &   user_profile user_profile_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.user_profile DROP CONSTRAINT user_profile_user_id_fkey;
       public          postgres    false    3581    215    217            �   K   x�3�t�<�0_���.#΀�Û��Ɯ!�w��S(>��˄3$�ᮅ�`�)P��]����2������� � 
      �      x��{ٮ�ڵ�s�+��[�i(�*�wA�#K�}�|}A��_J���b� `k�5�cM�o෿�ϫX�a�_�˼�S��?�ϛ4��GҷY�y��Q��?�a��~���l���]=V�1�DK~�ٝ6�o�gd���,~���SGs�=��e7��ш\����.��G>��V&i�$���<���p?�|!ȋ   ��*�.Z�)�k�Qi=��K�W"$�]�6�>�IP,�z�:NvV��`F�3U8�\�8��L���L^��2M� }&09���J��"�t�u�3�VQU�%\	�����?�Ѣ���4���v9�  [T������3D����@d�(���KG�F)��ƣY�Fý�r�3ĽE7��)�����lf�Ae��)uQ@^6�uQ#v�;����C�.	�FuҨ����QT��k��K��9��X���������u��"��_����0�BDh�#���ĨU��g��_��AV�*1W���iIV�Wb��;�D��9�����vz��E{Z����롄�#Am��^)#K���c!0R��S��!�f,���Eq��[�DfA�T��~���\a�v���rG�z;�"Hd�j}�R�'f�>!ﳔ���u���4)e}q�}�ԙ�fB�A�j���=��#�>��0X�6MX
�t���	�@��H�w�Wr��!��� Q�Z��j:���;���r
l�0�6vo-�1��08?�b�(�(�%y���r�mu�ь���t��)8��u������3���?G頼���>_���R�-��ޭ���j����-!Z
A��9�1aWIz�?޲��&��pߘH��FH#�Ћd-î��[���?5�q�M���A%�ޤ��Q���c�9<%j�on��7|2�g�������.�m����=ہƧ���ٗ��-�xQ����1��|-F2N�ޛ�N۱�fAN��6��g^p��?��m;*)[������WF+o[��y��B�dȜ�RQ��g�i:�U[��Z��� ~�j9V,4�%�EIF��c��<�B�&���ޔ���g<ꋸ�'�Cbm�����ES��������������7����K��z�Z9�U^|hh\�PԖ��E\J��ѳƓUd�`���V;J�ŎƸ�VS��4=?wE&H{�r��Q�Z	_��n�C�l�2���.B>CK��H�lOT���ƴrMXJo��Eڶ�Е���i�H��mH�-t�1C6�n��e&ٗ@��C켕�+WMr���Ҝ���XQ�y����֬J�T�gW%�
+oa��O߉8ƻ��U��լN�ba�zGv7Ѿ�@E����gcV��䓽/0)�0�	���a.�(1��M��}g��Q�}��H�(���h��]&�+�+���E����x(GF#�Ydfv�2~���:�p�ta� yb�{�i��Qw�s>�Ǘ_V6�,':zq�6�ۢ��Ϳ��-���#Z�lo,g�u�����+��r�j,�������Q=u����2T�?�m*`�t��LTN�eO���DF��.�����q� ��;"q��.X�%r"��]��)�Ca+�!"F����ؔ����RA!Q���=���;�x��5��"�ޱ"�@��M�Rw}&�q��5[�gg�.}��'m�Ti��^�a�#�~����M�����{D@�`C` ~�r���1�|�꜈��Յ��i%��Y�%���=h�܊��� 0�w�Zo�;I�����"�
eH{�����)L�=�'b�K��/w t^ָ����):(��+j�#	A}:/A����X�!W�yz��bwT�1�9��F�{i�S�0�i���b���'����+��	l3�T�!lyf��wn��h��62���Ml��d��p��4^�8��R%i��>C��tt��j�ɵ{%�����#�Z��u�nU���&_�n��R����-���6ԅ#2��]j߈�P����`!n��S�Э�TyH��qnI����ؓ`�w[LT�a1{����Ù~刬s}���������4�J��^��k���#��G� �F�]����07V�[,��8�r�-e� _�v�;��kF��1^U��&{*�WJJ�Z
���ɰ���#ŭy=��	�u�ϋ3�����Q9p~�+w�w�C%�d=	!vn��LA���?�T ֶ'Š غ�J�5�q� U��=f)�~އ��^-r~X�/�L)�;�qq�����2Xh[ka�NN��m�v���`r;���"��p���_	�G�nN�f�;8�=;9�����Dmq9��h�8��Z�/]i���)�&
���*�z�3�na{I�{���/C�d�be�DB��C�^��;�F��T9Tժg2 Oػ�1�}��_k�	:���� ���F5-�R
�&���IW����|RN��۾� H������ �8��0
�=*S`qҦ�E�$�`���!�T2$�{7�X�䠐�0�Lǂ�r�c�?�v��������zNm�F%�( �w&船g���1T&�_�b�����JV2�i7��3�}�� �_����?��������=��	��೏`����:��r���K������l��3)R��l�1�D�#wr"�o~c"i8$��
/��90��@Fw��W�;5w����r��.�ppܼy�h��S�S�@vz�ߘ<c���|��!F��n�E8!���;����(ς��%�<�X�i6���w�E�CBe�#�J�)��n�G#$�����h�u��Q��2�����ܠ,%#c�u>(Bf�읹Bn�%�f�ck�;ͣ \������Q��������[@XN���� ����s�jB��8M�.�4�K��w���D��ڼϬ�K���{�oT��V�Z��lDL���*��¨I�ĉ<���f���dr��EV�5z\@ؗ	ȭx"y�:)�KX��8{���W���a-��;/�+���1b�i�/�D;1r�-2G��Ư�k l�ߘ||"%����zifZ���X��n�5�Ӗ1#mAW/k���s.��ms�����Ϯճ�F�m�ׇ(��t�xj�`d��ܼ�|=y���Z��*_�.��#X�m	;y�i0��u�L�� �b���/ �����1�0�j�3�]��e���K���<�f�(C�4��(���y���p��yA��J��$�����+�<����u��hL��b�R��l�F��ͭ�簜�"�Y%���A�7��v��R�XÓ&e�<3��K�X�A���C$��H53��,�~����f|e G���,:���u"#���D6����q�H��Ȉ.6-��1âDhþŊ����l87��&���3�=�jߏG�Pۋ{�:evt}&Ĩ8
Q���^�(T�K�͋�zw��Ahqc�p��s�9Z1~A�f'�?�]H�hI�jޣ�Y_	1�iaH��m1� �}��IJ_�a�YحN=�p�6\}��G^!Ԍ0{l�Pл�V�U��Y�m��	!	7�`�Xg����R7�i�N�=b��PcJٍ[~L�x=��v#����/*�_�JVL,/�xx�LA�h8��O/��A58po��'�"Ŷ���:E�4C}+l�����;e�`6&2$ܹ�(��W�I�n��۷����CaIз'L/��)���z�l�[ZQj����B1�`�%�^�-��k�^�;���0��̅1����_@�25�Įؤ�I�H%�V���A��ޤU�\�j�:��EW,b��b'����t�3����`��w����L��W)|�]���oU}�S��+� �m��e_��t��l- ù����E�v��?��NW��v���t4ḳV��A�Yc����ɀEX�]fBݕ�Xsi-j�4Y���fS��eB�����.�F5�hSc������y��T��71e��գ��S��}#�зd>�����eW�o��,^�(6�*JQ�d	�k��(~��$�~�@�|�9��_�1&�� �  c�4% z���	a����0�����Q�(^��[}0ŏ��J�4T�zHJ���G\�x?�kL�� �J��|�7�-d,=��EC	�L�Ƹ;Pe�` 5W�g�Ak]��]��T�
4��{��71�0����SuV�x�v!Guc�d+	����
Rbzl���<|�t{Z���3Zn�0 t����,:��K�@�X��Sg�w2�ƢV����b��l�c"9^%S���g>�j`_$��{���MW�t�j����K��EW�����c[a���v��l�?4쮗���n��M�������'41�_A������_��G�%�N��C�,G�%�
�ɤ�iG�m�M3�����>� �Ju)?��s�ײ���G	.����$p�"�����d��VN^�Ǭrl���.�J��9 �⡹��Z�R�ʀ=N)jQp��ۓ�hM���,SI��%`���M��P��"b1 �>N�c�{�bԡUz��2yq�Jw��y�˩X~t=���:�����2[#��&_B��z���}�I�8��V��#�;� ��
Ι��HA�F�sҡ����-��D�*� "��ّ���BM2g��j�o�� �}�)H��m����
B# N�[c�ŊS�ֶ&��5�E *K�j���������.��u��+(�و&�,�eT�CYd'��8���!������4��y��|�Z<C�Ck�hP�2>a�� ����-	�J��>����T��o�錼�ċ��]z�J�nH�C�Hj�Q_����S��#1�"�<�9���|w&�<�Yu���������f2����=�=�,HH�I���B�n��p~Ԧ$���&k�'ܽ#%Oz��ϵ3+TRw������3���c�}��A��Ì��x7���#�ߩ�+a���ᆙnb�v2���_k����8Y���I�"��kte�a�^hm���h����|�t���o�[k��@M�R����Xll��f#�U���Ҡh���������U�[[�U����E��lU����Ƥw����X�2��Cςs� W��T_:F�(9��Mu�������m�]6�B���� }��p����+]��8H�b���`��:I�Y,Z��a�U��|�̦��;c�K�d�4�X���� ����S22��߳E2~����=LB�7������Y��*���/�H��{�-+EVjX��H���K��͓����L�e��n�*A�&E�s���S�I���87d�0D���}{Xt���s���d�I��Xt��ƸJz��pʭ�ssм����{~���M_��?񔇟��/����1 &��BV��_J����| ^�+��z�m �{\DŻ����}t{,|�0x�H�L;(�A?�F�k빴�k�Sr�&�<"
�n_5|�$���6��躿��ʊ���J�m��)�M��\�!*&m|mb�����_<���z����@�(��w?����RA�Oz��@3Y�ʆ|�8�!Z��"��B�`�u�[\�9J��)`L�Ś��l$[ƷjE0w� �f��z��Kа���n��@Pso'�5:�)��7Ǫi5�!�m�:Q�j
�������Ca/;4���KM K�8�gV�G���i��Ņc�	����������v�ս59%[�7@���9�.[R�y�����&%Z�dr�$�<kU�u�I��l�"���և��lg�0���X�2^%���,e�C��\W��D�!�V��B���(�z`������������"�y~Oc�g�(�`}]oQ�yo)F_�S/pZ}�iH	G=y���<��䓫	Ew���3/G��R�.wr�ҜP�}cN��)�6;[�߼;fXZ_��K�ƕ�W_�`���6"{q���b����Iޕz�P��a���0o��淇�zO�$�Sw'��S
q��Y2F���m���)/"���U���K�a��c���:t�o&�˾y�.���d�����¯��~JQc�=���7Q`B�`��=�8b�t")J:���m����/��?@���f�?h1���`�j�b���?Y�����\�^<���KF����x�I���E�<RVNY�����$��z2M�	�U)���X�a?�|�8�`G�E��z��.]g5N%������8=���y�a4����8�Q�e�%�c�+�*v]��1�.O�r��;�fȘ~~�M��ۦ��/5��lN|�h��y�}��?��q�"��O���>kٴ7�����դE>����3Z�m]�D)��r���7�N��h��D���'_�$f*�1(ѐ����S��:�LC���׿2����@�i��?ư���pK�ր�-գ�����ܘP��1�vRo)<��Cb�^*A?��Q	{1f�ٵ/�C$���?f��}�?�*��/��>�.�G��5iS�T����I�»UEשU�b@�<)��qc�������<����ë:]�����s:șj�%�����(R��W-��޻�+�1�1S���M�����CoW�����#4�<b �(��D���!^nF�`�ٱs�1����:\�Jϔ>�Q}�Лuk��08��6'�?~w�!��Rb���#��C&�� K�r@!B�'ו>i����/ψ�d�:"�Iۗq=O@��}��V�������HS���*<ǅ.ucQ{g�j��oԚiב�<,���ҟjWb��+HO�HX,�k9������wDZ��ʤg�i����%J*F�0�mR�\v��Ҿ�G�S�*�\2N��UC>WW%��%�{��ѧBkqx���J�(�Q����2LPv�Id��ai�t5J:rz�R�a�\|/��#$����g:��Bp�	��y����:�b��v�1��5�_������8� �t����]��/-;�F�2��eIR�[�~T�7d�2i�s܎���!��#e�����Ǿ����|�K�#~�ī�!�aK�����#������*�"dN'!෸�	W1p�p��X�fy7�E�UC h��l��Y/J�X��D�{�~*���)\�:�T�W� ���(���C�2��Գ����HJ�X>�VzP.'��x>�I�k��;[?<���l�Rz���J�Dek'��f��3x���i��\��H��@`�*fK�y��Df׵J����7��?`�?�q~i-�Yʹ"9��<K`�&��_�ǫ�HZ�
9+C�pi
9�������j9�����A+&�M��"V݋�q	GP�n+&m�Tc�a��q��ٯ���Cj���e���V,�œ�~\2����\IM��n9�[��~��:뜟B����}�Jtc�&�]�8���g��%Ux/k��l�8|�����2]�,v�@�;�k�m���1S����*X�^yk��ϳ���I�̂���xe^�I}��RHg�So���q�H^{�[3������{r��ӟ�$�I�      �   l   x�3�<2����
G&f>�ݞ�P�p�Z.#�`zf�B���K�ҹ�9C2�PR����Pvx�BP`�B6X�	TKrƱ��`�⇻�+�d^���e�|x!������ ��4S      �   2   x�3��|�k�B�\F�!w-Ls�9��^���qxQW� ���      �     x�EP�JA��b^@�ɟ�iA,R�9W�=��h�{+���R(D�n�	y�}gO�lf���!�#���i
����J��� ϸ6ZZ��l t�!w�\[t��6��@ԭ��%ձW�,E�*��$�hЁε�Q���o
��k��/��!��J.߉?��c�� +�q����ک\�l��?DK�E���u�t&@��b�KDw������%�v'@�����e�X�f���h�g"j+?QZ�f\�8��7?̲���Z      �   l   x�3����OT�x��7Y!���J���k�2��8�3�2J�گP�p�D5���c�-�KW�}�ka���w����^�e���p�N��҇�֖ �Pvx��=... �7S      �      x�3��44�2��4�朆\1z\\\ *�V      �   3   x�3�4��4�@h����Yv�9O!#����<NCKc]C]#C�=... �<      �   �  x��Q�NA��{����x�i�� &J<{��Pc���60��X�{�8{��b��n盙���T6j�a��>_E�Pp��Qw��D�Q�o�ϣ�H~�2��O!�H�Bn�d6p��,6�@ר{n�J-X��Q�,F���z܇�tR���,c�r(�$���x��Q\	�6x9�sG��+����1W��O��QCܖ�"�:��ͨ�,!N��m��>վl� ��&���T�w��2�Ds���QŦ��)G�"�
(CG1�P�/�1c�S$��?��w��N��M��Zj�7Q_Y�1�V�}ڔ��Ֆ������Q�������v�j�����>*��)����Ws��[L8O�-�rs���m����
�b�q���Bl      �   R  x��X�n���V�b�E��G��?{���u��&j��ДB��FZ�r⻦,�Ec E�X��0�t�&�h+��~�	�=g��$Jr�
ؒ�9s�w�3�Q	zµ�
�+I�U�ƍ��`a��M�1j�ÜJ�v˺Y��t�����&J�7K���QGӘe��s���{�A�馁�L�Y��N5��g7�[���X\ӥ8����P�1��R�(�yI�!��4�㌚��y��G�j�6�l)n}T�qG��x���C�$+�tN-���|�,(=Y�d��T��$�V�ܾzwuT�"���j���e��������l�O���]u3��%����5������v6��o˫��� �ȅl�7��o�p��}�7�_�:݊��71I"�~1j��;� Q69�$=Ȟ\�ſ"w���O� ?�L?��$�"��G��L��8=�f69P~�$0y H;�cDW﯎Qk���<L�z$�Ơ��&�"ë�D�!�)/18L.�gp�>��E���?�w<�'k�4�fɾH���������d�s�I�(r�'����F�����rg~����'b����-À@A2�ɻ��&_�"�s���u��g����=����=ee6kh4��Ř��g}�� ~	���~��y�)��C[!�9͌G��W��Wǈ��c���	H'=�6Ӵ�a��,�&�&XP�/�@��7|�p���Av�pl�|�+��D�l��`�\;�bY��#%��R���%�-w
fO����w����RS��y���� ��8��y�]0�]��8���� ���,`�g���s��W��9㭄���4ce@-��M	Ŏ�g,�r����	������3_�}��˗y���(΅$Z�$��P�o�y�p�·:�h��h_��jy,�T��nD��#\�#��K���YX,uvW�%Ί�TҵYCp��v����O'=���p%�X�X�����Z�s�~�cw��T���8o4�� K>���yl���&$�vdҀ
��Y�U�`)���4�h;�wC����[�4�����U�v������������MnN��� �Y�un��r���:f"T���uhc�vw��`�X�jn�h�] �r�~�M�A���Kp����4"��H�J�lѣJ,����)�F�X4�"�8Cؤ>�0#�$
�ؕ���n���9�������N1ҷ]��8�hz�� 9��t$��Z��w	�F��,�5�G�3���1J�h֢��㓸@p7�h)(Bڻ�l��r�狾���]��� ��m�9�8h���|�`ķ��N4";�~͖X���6k���d��}~]Ŏې������^�푧O��'�z�j��8�"~F���A����9f�D�<o��x���-QNU$+�S5dQ�6>�_o
�ݏ��%I�U��8��#�i5GtOT�0&�Au���-��	���'��W���B���'�G��GY�=|��)�MW�dYe�B�7����@U�$!zN���������
-ߐ������1�6��S��@|'}� �\C�|h\��'P����*;0�}F��_F	��w"��h`*^4�����\�m^��]��w�k�~��8%��(rJ��P�������]��Z��!��9c�!6ҪN�8@����r�1��i�#d~�ǓɅ:Cȳ��N,�$���N�<��)z	���W?}��{�|8��~�6���~���Y0�PNi����w)*�4T��<=@�=b13�3PG���>-{���g����9�<kuU^�ih����!��QS �@\"���{�_�pL�FI���q�9T�a���W��C�cN�"����-�cutC=�sc^��j�:�lGQ�Y��W���6�^�p��g���`%˱�ԳKz�J=�Q�3�������ZϠ�e\�sKz�j=(�ik�,������z&�L�\���s^�]�gP昮|��*Q������9Y�h�g�a.wG�N�+���i�gؔ&S�̙WOOߚY�nS�t&���(��9�LCS�3��sSB�����g�3tOs�e���L�+M����pA��4����]&�Ҡ�n��[��      �      x������ � �      �      x������ � �      �   x  x�UQ�KA>��+�_��^%�Eҩ�����㢫�1<t
�N�K�-!��h��a��c��ތ+�e߾�{���=q#��g>4�Z`ר[�ʰ��o��*��D��@/Q�cJ�yJ\ GF͉)��z�m�uH�z�S�x=�p��T�ld�B���Pf58���;:O(�CS�':9��sh�g�C�핊��nhTZ���q
�����1�&�*�%��,].��|�Y�H�W=�0�^�W�~(�F--@�.���cD�\&�mgL����;�E�72�mUNȎ,t�Y�V�܌�v9ũ�����-�ù3�g�s���'���%��3���y��4�jԊ�)�uضnS���v��]XB�Δ����������//��<      �   5   x�3�.)MI�+�2��IM.)-J-�2�tI-H,*���p:��f�q��qqq b�      �   �  x���Ɏ�V���OQ��U��<�Ԋ6`lf����LQ�#�d�ȶ{�E��G�IpE��̢t���9���.�|`����}���~�I��l �!���qz�����e�?|���!�&!��_at�`$��g�h�ח�4]�%��i�s�E����$=��� M�Mж}ۀ�xQ��/��4���ۖe(a,�ZM���]�������SZtI��s�ť�����-��[��M�'�PDIE�����Q���|�	&0��i���F�]p�O罿tT	W/���eP�;K�x(F�	aъ���"��9B����W��i���F*E�<��7��8�[Z�YGUÉB$���z�a!��Uj]�F���W��E�AY���|�g<=z7z� �ڦU� 9����ڏ1�Gii{���W��-aJ�&1��v�4V84��`����?[���Wt���P���^,p^��zU���؊%����]f,�k��DXUT~�s�ժ�_���)�du�S�A���0�,�i�*��YdT{��J�rG9{B�u���z��o_~��o_�)���0��r�B��p����zj"i��%�ˎ��O�&�u��Jk�pr����8�Y[�I^��� |�UG�nc���{�>���^9�G�6�(tƱ)��&�{� ��ڶ鵪�Ž�j���q
B�Ρ�/�ۤԬ�
3F���&�,X�u<��)�L~p�y-n�V�h�x��O���g��\��O��:0��CX
�<v.Uf�E�n5�Ll������l�Ye�1���#�>�9����r���kǄ�Y�� A�"k���$A�Ŭ�>T�j����S�S�P%5	�_\�	�20o����&�%�����}�-H!b��'�@�y�?I���LFA|���L��z�k�:����&�Ɉ�����HB��qj+,�X�g�>�7�O�t=A���u�T�r!n�%���p�x��ϐv�.���A��{���W7fv�:���wV�1�W9v&Q�L�.1rH�a�gO��<��`+��-��)_�U� �z�ʥ�->Q����
�J�����Y�;`���`\��O�!���b�D!�,ME�!��@>k"�����BlF�W��MQ���e}|��4,$��Ž�Ic[�<ˆ�'^�����͇�1nb�      �   B   x�3�4� ��Ҝ�A\���� 䗞��yd�ᅜFƺ�F@�i�i�e�idBX���qqq c      �      x��Z�n#K�|������摞E�މ�BZzѻZ̿�)�b�i	��.�Zb�<'ND$%��[�haq�V���%�0��\ ���d�0�3A*M�B�=��N�t^+�48HŜFx;�	���W�t��S��
�δv���V�B�g�U8:����k��d�x*��ؚ��"%9��XrE8B�7��� �A�9���#g�$x'��pI�\#f�V:j�����}!<�[w�β������)��sWNE�޿��M�7�?�޲�Jo����Nj{�yP�6�Ԋ~{Ư�]rb?/Ҽ���o���f������۫⣽Ji�|[���t����*i��{w���+�;�N7��x׿[���p��~5�>�����d0Z����D8&*q�W�<�5�'XYF���[ �`���#/��c�$F1j�i$ ��Q?"�y�E!���R�8u�2 �3x�z�Ij���@ �!�`���sD��Y��rS�LE�HE�	��Hm�qRR8��X	wu"16� ��@��� "@Q�x���� �JEc��b���.��2�^���Ix?����o�ݺ��߀���l�:�t��^�U�U�Z]>Hb�xO�);n�/u�wm\�fXbT≍�l�3ۑ�<cB3�
�$����+�"�� �P�G�����p��4!�(o9t��iI���H�@k"t~0�
[�R�Es�ө�����ke*�@����j�'�S�b�D.��(�)քBފLAc���R�B$�1�5��s�]����~W�0�E`��X[g�h��?;�
v�w�F�2;���&E\[���ʵ�S�Y��n���U��J�:J��:�OfS�(��&�K� �|�<E	0MSx.�n��g@��B7���0��R�t�����8h��HJ�%�H絔�E�`꒜�8 f�Y�4�ۘ X8�X���h�֖K��p
�\GŅ1�h��Ӡ�
T�h#�BQ�\�*�9p�yBF�"��;����Z�B����sнREL�A��?}{��`���;�G�n����eu���fv����n��u�|�Q�0xc.��ɍ����=M���fS��� ��,�Ѳ@xA�Tr�a�d�1��4�8_A��V+�w�<�ZBJ`2,�*:b����A�p�,H?h������!pJJ�w0`�q�c	�wb�`C�X̍��:m�6:���@$�:��4�����Ì��0߁�0[��:w  HKn�04�Vp���ab�k�G`�`�~l��lw��&���X"��Z���V�F�Q[_�;B���ۣqh���A�����I<�Z��'���>���
D�d"!8A4v��q�����,,�  ���\@�A��`QF���
��ICc���\�"X�AC��. �� 
������Aa�upC�A��זA�`mha(��0xY�� �nQb��S�i�&����a���^�W� Ph	=e���Sk`�8�	�t�O�&_���6o}����]�6���~g2ٸC���&�f�UW&w��Y} ��lc��''��K��D�I�:�0lY�\��Jx���V.��怀�� �v �k&�����0���B����	��q�d�s��PKH �1����a����x�T&��T�H��K�ǳ\6�c�}372����0��ἣ���:g0��<� &1���=43���`]r�`!�h	�&�#��W��v֮�avzkW>���V���.�񲫾�M��M} �������o��>�9��@���oFS�R�P ��|��nV]���,��t;����d����l���(�D(̢N�C11�>	h:�����.�\�����`�a���h>3�B��D`r=3\"�AJ �Y/��� 7�l�A��r���W � &��b�����e#dH�p!ϘVK{�u(�:H.�!�5��0Aj��'�Ņ��#����J�:5�ӧ%`F-��W�h]�+$��i�gW/�ԫ��P7jԮ���a�uoe�<L,���ׯ�K��eܟ7'�.���m�R��Q�e7/~U�Y��_�'���A."(�W�������x��^�Nty���~��v� 5�`>�6V��x ߬?�s���&!C?������W�^���ǜ��4)Y�*�T��k`ka���4�{�}��I�b+D]�x`O��MP���ì�y*54���<���$"$~_�>p�A�z�e�֒ ������"`ŌQ�1+�����VH�e��1/C��a�Cx����D����0��<%h?$O&�2Z�k���Ӑo�q6gz Y� ޱ^1R�!{``�O�Ve��v��]f�f�D]��y��]R�����l 0�5��_h+=ކ�̯����5��#��M�u��^����~\�I\Nd8�bpw�v-<�~ĸ?R�TzХ��_ˀ�E���h˻k�E�t��:�[n&Y��q�r��JK���sep���w��}���þ���z��Y�����.��͌��m�4���3���v�|�ϮbX�}S�TI��ꧭ����耳{y@��]���z�h��r�gE�_��էV�;��7X�Y{X<ƕ1����q��Ec�b�Ͷ�U�u�����.��{j���e_�h�vx��=T�6g���v�r�c'��Z}нtH�.��zXJ����/����k�r���D�>�Lc���F�ʷk �*��<B�`R<�`o0� �ƖR�Ђ�`��:p���(�fC@x�����@OC$��n?8{%���x�r���~.�k% Z�B�pc�C� ��!��s"��d�X�����*�PL|ƙ��*$a���G��� OO`�|���`2�]Z����`�����Ċ��%���ҋ���pW�E«��j��J����r	ǋ�\��qle����;�V��v���/=Ki��v6h�>�w�P��#$y&q� �&<'(r�Y � �"�bHG`'�l���DI	<s�j�t  ��C�f �w
Q
!q���B�(v/��B|V
��v;�V> K1dF8zL���Dzh����TC�8� B�� 1RT�|WWP��x8�`!��E�*(�� DXu�Az�pV�������\��r�"�a?��+�wbꛍ]��/a�p�:�/���'�{A�Mi2ZTC�ܒһ>���D��-�b��Q��xi���n�o<��I��2�7�����D�6ߖ� /�h'��V;+���<�ˀ����ǘ9��}9k��,�D����� ��� D��o8e5^�\�Q:�" ���M��F��X��)u^��Ҁ��તU�`7#�K� D���j�	��0k��:� 'D-8�CfE�i D%X�W<��*	8�u��FB�j�іl�_��G�1�p�����!ӧ��������<�mz��A����T*Ѵ]=��9mo�ک~|��;>|o���\۟)d�x;K�/�
���w�+I:��)�"[��Kz�=��������Tmv�ܲ�&�����:樕�n�_���S)���9����������&���c���Jѓ������!���s�h�����т���;������\z�û���mz��:%gp���Ǩ8+^���u���7ud)�:�R�I8�t|=�ϮnQgS�^�dz���JUn��֏r��#s�7u ��y��jΊW�]��>��-Z��{2̒�n��ޮ6ߵ��O��v�E��^�q(ԡ_�����A�Kӑl�-O���H'��>-�ݴ�y�����:XkX��O�:@k?���GIs������9�D���No|�R�����s�e�*���U1�TF�m
������&/S/V��r�ԋ���_7�BT+������f��ց���bvSҩ8�����~���A7f(%�A�:ۓ�w��rL���>�:��,k��:��Z����٧i��z��<��J�ې��f   H��˚d���dp���fz�>��Ϲ���>�n�����/�j��nl��ۯkW�˵Nq���s��˖�R1?���Su�VΏ������|�z�c�f�pۚ��;/ZZ�͊�-��]��:�V4�>��g����U�|�y�u*Ӝ�gE�j�����[��I��Yy=�T�4i��۩?x��v8�}����5����O��TlO�����5L>�c~�;ǒU��蚎�[�%��5�W�G��f�j���`t�Md�?x=:��,ʯ�܊�����]�?X��W=�g�O=G/���˂���Zki�S�!=!�2����U�g�v�\����W��?u|�ݷ�E����bxj�S�Q��,۽<*�ywg<�5�����jξ�G^����]s{�:�5Z�(M�~�]���۾xa1k�7'wO�y����,��h��`('��x�N�ߗ���V>u��8/�7S/ߛ��*\��W���ld����WT�wR����|{�����)}���>E�X����L���:�7��PG/�%���\����Į�ﶎ�m�K��L����p���֤����u�o��Ms~�o��ͤ%;���7�仈��~91/[�J����^���%P�^�����t�!�"�4�X\�=���j�f����ee3$�[��>��W�ב����g��;w��p_&��j?��-}%���B�Ym�m_���x����ud��|��K֙���Y�[�f�{��*�p��]c7�P�>5�u���9j��5�9j}0f��"�%�����ԯ��*��mڪ��E,�+�����qoUZ��yE��:�W�2��&v���?��%)�a6��4�|P���3;<������˼��ު��yU���_��ͩDNu�������˘����z��z��K�J�}�W�"?�ϫ�t�i甭����>5lw�j֏�6"���Y���\>��C�n����#߇�U�ݽ�q�,�vo�.���8^�1�陿��#m6�ŧ���]q_�nΛ�߽�z����?�E<��oꚬ��P��ۦW��Գ�XM�_x��?�9��Gھ�G�e��q���):��vJ��J���]���?��?>��y�}#�u��>]�C�^�n�w\���y����CF+%ۇM�������_�c��S��c�h��[q>���s����tv���P.��A���zx��Z���f�>�v�Ð�bt��u��kdy�C���ڣzy�:]z���k��z�~{^Ǫ�u?1���>�7u�Mh��.��-����������Q�6:�W��v��_���_��߄�c�      �   �  x�-�;��@�xp�CQ���^m�R������e���&C���_�ME����6�5�"eԘ����t��������h+���j]�`1<W��6]A<z�\��3��5�Ѭ�p=!˷�gf�tl,z������*[z"#}�u�^�Iˮ�8�*����i�=k��i����T�
��ʡl�K˶rI�����JQw^�n���M�y�aU|��_��ـ�ǥ����+hnT�z{p�j�˱���a��;w�����WӜHvbŕ�^�������X%;���rN��Oې�eKw|C�W�=dl��k ��פ�����/0���^��:��J��I'1\$f+��#f��1'͐��L�Q�G6>G�ӫ���8�������4��\߾�`�}Łe��䧨��`'d'9��K�W	n$�I$x�H���֝Ķ���������,�       �   E   x��; 1�Zs���8�##Wo��p�Hp�5; �	�.(톺=аlЬ T'
�:��E��x�      �   s  x�u�[��H�g�S�äߺ�{&f�������pQZ�˧_����N�G8��թ�OaX��1��ږ�2Pe�������3�ƾiT$V��.l	f�)g���pr��ސ���"��л�H��Y��W�^�|F��D�A 	�߫?�'��*~�&���SZ�,5�[�W���W��~�	���^�����X���cU60a�Ч��*y������i�,6���u2O�����c7É�MJx�}��t:�09�:ߨ�Ƒ`�S%w�>P�����u�'S;�兿} ���~���Aؓ����ԛ�=YlI�U�!�
��׬�������U����uI?�UH21�~a�%�FXm���w��W�7*b@As�Sew�?P�?�X�|����@�eq�hT�s7�T���&;��6p�^K7m_�N%H�p���*ͺ׹ykW��2*L��Z׮��~��0���"I�H���B�nߨ!!_wU>Po'��w��2.b~�S�Z5?���q�m�j�̓��uJ����RHT���*����*7���;���]#.�<�;͹Fe�X���OŜ�NP��*g�Q6no^C���3����f+L@v��Eq86����ϊ0+@�z� �\y��YXԫzA@����	Ea&ي��[+��BW��(�K.nBD
��@rX������Mɋ�{M�*^������"�����Tî<��YH�h�J���-������6�z�#���{��n+_	�**qVd�|6+&~J��mi�JVt;em�����P�W��u���bkVk����ߺ�T��,�J'uZ;�W����dz<^�-���~�D�H/'���X�_�w�����	#�����棋}��MW�B���a����C5ͤ<����@�$#,iyڜ.%���>lrNu���	���n�ƠX?����(d�^������4U�r����Z����+FGo�㙜��,��EyF��4!I���i?��7�3�%	��#���Zxn΍a4JՒ'�����X}�7v��_n���3���2��I��^�b�9[���	+���7a��Ej-�~�m�ؽ�iX�"�����c/>͝� �[4�2W"BAK[w⸬����'��>9#H���	����f"1     