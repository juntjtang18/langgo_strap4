PGDMP         %                 }           langgo-en-dev1    14.18    14.18 (Homebrew) �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    58892    langgo-en-dev1    DATABASE     d   CREATE DATABASE "langgo-en-dev1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF8';
     DROP DATABASE "langgo-en-dev1";
                strapi    false            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   cloudsqlsuperuser    false    3            �            1259    58893    admin_permissions    TABLE     g  CREATE TABLE public.admin_permissions (
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
 %   DROP TABLE public.admin_permissions;
       public         heap    strapi    false            �            1259    58898    admin_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.admin_permissions_id_seq;
       public          strapi    false    209            �           0    0    admin_permissions_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;
          public          strapi    false    210            �            1259    58899    admin_permissions_role_links    TABLE     �   CREATE TABLE public.admin_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);
 0   DROP TABLE public.admin_permissions_role_links;
       public         heap    strapi    false            �            1259    58902 #   admin_permissions_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.admin_permissions_role_links_id_seq;
       public          strapi    false    211            �           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;
          public          strapi    false    212            �            1259    58903    admin_roles    TABLE     ;  CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.admin_roles;
       public         heap    strapi    false            �            1259    58908    admin_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_roles_id_seq;
       public          strapi    false    213            �           0    0    admin_roles_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;
          public          strapi    false    214            �            1259    58909    admin_users    TABLE     B  CREATE TABLE public.admin_users (
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
    DROP TABLE public.admin_users;
       public         heap    strapi    false            �            1259    58914    admin_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_users_id_seq;
       public          strapi    false    215            �           0    0    admin_users_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;
          public          strapi    false    216            �            1259    58915    admin_users_roles_links    TABLE     �   CREATE TABLE public.admin_users_roles_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_order double precision,
    user_order double precision
);
 +   DROP TABLE public.admin_users_roles_links;
       public         heap    strapi    false            �            1259    58918    admin_users_roles_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_users_roles_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.admin_users_roles_links_id_seq;
       public          strapi    false    217            �           0    0    admin_users_roles_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;
          public          strapi    false    218            �            1259    58919    components_a_external_videos    TABLE     �   CREATE TABLE public.components_a_external_videos (
    id integer NOT NULL,
    url character varying(255),
    caption character varying(255)
);
 0   DROP TABLE public.components_a_external_videos;
       public         heap    strapi    false            �            1259    58924 #   components_a_external_videos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_external_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.components_a_external_videos_id_seq;
       public          strapi    false    219            �           0    0 #   components_a_external_videos_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.components_a_external_videos_id_seq OWNED BY public.components_a_external_videos.id;
          public          strapi    false    220            �            1259    58925    components_a_pagebreakers    TABLE     {   CREATE TABLE public.components_a_pagebreakers (
    id integer NOT NULL,
    backbutton boolean,
    nextbutton boolean
);
 -   DROP TABLE public.components_a_pagebreakers;
       public         heap    strapi    false            �            1259    58928     components_a_pagebreakers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_pagebreakers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.components_a_pagebreakers_id_seq;
       public          strapi    false    221            �           0    0     components_a_pagebreakers_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.components_a_pagebreakers_id_seq OWNED BY public.components_a_pagebreakers.id;
          public          strapi    false    222            �            1259    58929    components_a_quizzes    TABLE     �   CREATE TABLE public.components_a_quizzes (
    id integer NOT NULL,
    question character varying(255),
    options jsonb,
    answer character varying(255),
    explanation character varying(255)
);
 (   DROP TABLE public.components_a_quizzes;
       public         heap    strapi    false            �            1259    58934    components_a_quizzes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.components_a_quizzes_id_seq;
       public          strapi    false    223            �           0    0    components_a_quizzes_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.components_a_quizzes_id_seq OWNED BY public.components_a_quizzes.id;
          public          strapi    false    224            �            1259    58935    components_a_sent_refs    TABLE     H   CREATE TABLE public.components_a_sent_refs (
    id integer NOT NULL
);
 *   DROP TABLE public.components_a_sent_refs;
       public         heap    strapi    false            �            1259    58938    components_a_sent_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_sent_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.components_a_sent_refs_id_seq;
       public          strapi    false    225            �           0    0    components_a_sent_refs_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.components_a_sent_refs_id_seq OWNED BY public.components_a_sent_refs.id;
          public          strapi    false    226            �            1259    58939 %   components_a_sent_refs_sentence_links    TABLE     �   CREATE TABLE public.components_a_sent_refs_sentence_links (
    id integer NOT NULL,
    sent_ref_id integer,
    sentence_id integer
);
 9   DROP TABLE public.components_a_sent_refs_sentence_links;
       public         heap    strapi    false            �            1259    58942 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_sent_refs_sentence_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.components_a_sent_refs_sentence_links_id_seq;
       public          strapi    false    227            �           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.components_a_sent_refs_sentence_links_id_seq OWNED BY public.components_a_sent_refs_sentence_links.id;
          public          strapi    false    228            �            1259    58943    components_a_taglists    TABLE     g   CREATE TABLE public.components_a_taglists (
    id integer NOT NULL,
    tag character varying(255)
);
 )   DROP TABLE public.components_a_taglists;
       public         heap    strapi    false            �            1259    58946    components_a_taglists_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_taglists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.components_a_taglists_id_seq;
       public          strapi    false    229            �           0    0    components_a_taglists_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.components_a_taglists_id_seq OWNED BY public.components_a_taglists.id;
          public          strapi    false    230            �            1259    58947    components_a_user_sent_refs    TABLE     M   CREATE TABLE public.components_a_user_sent_refs (
    id integer NOT NULL
);
 /   DROP TABLE public.components_a_user_sent_refs;
       public         heap    strapi    false            �            1259    58950 "   components_a_user_sent_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_sent_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.components_a_user_sent_refs_id_seq;
       public          strapi    false    231            �           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.components_a_user_sent_refs_id_seq OWNED BY public.components_a_user_sent_refs.id;
          public          strapi    false    232            �            1259    58951 /   components_a_user_sent_refs_user_sentence_links    TABLE     �   CREATE TABLE public.components_a_user_sent_refs_user_sentence_links (
    id integer NOT NULL,
    user_sent_ref_id integer,
    user_sentence_id integer
);
 C   DROP TABLE public.components_a_user_sent_refs_user_sentence_links;
       public         heap    strapi    false            �            1259    58954 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 M   DROP SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq;
       public          strapi    false    233            �           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq OWNED BY public.components_a_user_sent_refs_user_sentence_links.id;
          public          strapi    false    234            �            1259    58955    components_a_user_word_refs    TABLE     M   CREATE TABLE public.components_a_user_word_refs (
    id integer NOT NULL
);
 /   DROP TABLE public.components_a_user_word_refs;
       public         heap    strapi    false            �            1259    58958 "   components_a_user_word_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_word_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.components_a_user_word_refs_id_seq;
       public          strapi    false    235            �           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.components_a_user_word_refs_id_seq OWNED BY public.components_a_user_word_refs.id;
          public          strapi    false    236            �            1259    58959 +   components_a_user_word_refs_user_word_links    TABLE     �   CREATE TABLE public.components_a_user_word_refs_user_word_links (
    id integer NOT NULL,
    user_word_ref_id integer,
    user_word_id integer
);
 ?   DROP TABLE public.components_a_user_word_refs_user_word_links;
       public         heap    strapi    false            �            1259    58962 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq;
       public          strapi    false    237            �           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq OWNED BY public.components_a_user_word_refs_user_word_links.id;
          public          strapi    false    238            �            1259    58963    components_a_verb_metas    TABLE     @  CREATE TABLE public.components_a_verb_metas (
    id integer NOT NULL,
    simple_past character varying(255),
    past_participle character varying(255),
    present_participle character varying(255),
    thirdperson_singular character varying(255),
    auxiliary_verb character varying(255),
    conjugations jsonb
);
 +   DROP TABLE public.components_a_verb_metas;
       public         heap    strapi    false            �            1259    58968    components_a_verb_metas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_verb_metas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.components_a_verb_metas_id_seq;
       public          strapi    false    239            �           0    0    components_a_verb_metas_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.components_a_verb_metas_id_seq OWNED BY public.components_a_verb_metas.id;
          public          strapi    false    240            �            1259    58969    components_a_videos    TABLE     E   CREATE TABLE public.components_a_videos (
    id integer NOT NULL
);
 '   DROP TABLE public.components_a_videos;
       public         heap    strapi    false            �            1259    58972    components_a_videos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.components_a_videos_id_seq;
       public          strapi    false    241            �           0    0    components_a_videos_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.components_a_videos_id_seq OWNED BY public.components_a_videos.id;
          public          strapi    false    242            �            1259    58973    components_a_word_refs    TABLE     H   CREATE TABLE public.components_a_word_refs (
    id integer NOT NULL
);
 *   DROP TABLE public.components_a_word_refs;
       public         heap    strapi    false            �            1259    58976    components_a_word_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_word_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.components_a_word_refs_id_seq;
       public          strapi    false    243            �           0    0    components_a_word_refs_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.components_a_word_refs_id_seq OWNED BY public.components_a_word_refs.id;
          public          strapi    false    244            �            1259    58977 !   components_a_word_refs_word_links    TABLE     �   CREATE TABLE public.components_a_word_refs_word_links (
    id integer NOT NULL,
    word_ref_id integer,
    word_id integer
);
 5   DROP TABLE public.components_a_word_refs_word_links;
       public         heap    strapi    false            �            1259    58980 (   components_a_word_refs_word_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_word_refs_word_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.components_a_word_refs_word_links_id_seq;
       public          strapi    false    245            �           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.components_a_word_refs_word_links_id_seq OWNED BY public.components_a_word_refs_word_links.id;
          public          strapi    false    246            �            1259    58981    files    TABLE     �  CREATE TABLE public.files (
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
    DROP TABLE public.files;
       public         heap    strapi    false            �            1259    58986    files_folder_links    TABLE     �   CREATE TABLE public.files_folder_links (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_order double precision
);
 &   DROP TABLE public.files_folder_links;
       public         heap    strapi    false            �            1259    58989    files_folder_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_folder_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.files_folder_links_id_seq;
       public          strapi    false    248            �           0    0    files_folder_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;
          public          strapi    false    249            �            1259    58990    files_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.files_id_seq;
       public          strapi    false    247            �           0    0    files_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;
          public          strapi    false    250            �            1259    58991    files_related_morphs    TABLE     �   CREATE TABLE public.files_related_morphs (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.files_related_morphs;
       public         heap    strapi    false            �            1259    58996    files_related_morphs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_related_morphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.files_related_morphs_id_seq;
       public          strapi    false    251            �           0    0    files_related_morphs_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;
          public          strapi    false    252            �            1259    58997 
   flashcards    TABLE     y  CREATE TABLE public.flashcards (
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
    DROP TABLE public.flashcards;
       public         heap    strapi    false            �            1259    59001    flashcards_components    TABLE     �   CREATE TABLE public.flashcards_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 )   DROP TABLE public.flashcards_components;
       public         heap    strapi    false            �            1259    59006    flashcards_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.flashcards_components_id_seq;
       public          strapi    false    254            �           0    0    flashcards_components_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_components_id_seq OWNED BY public.flashcards_components.id;
          public          strapi    false    255                        1259    59007    flashcards_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.flashcards_id_seq;
       public          strapi    false    253                        0    0    flashcards_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;
          public          strapi    false    256                       1259    59008    flashcards_lesson_links    TABLE     �   CREATE TABLE public.flashcards_lesson_links (
    id integer NOT NULL,
    flashcard_id integer,
    lesson_id integer,
    flashcard_order double precision
);
 +   DROP TABLE public.flashcards_lesson_links;
       public         heap    strapi    false                       1259    59011    flashcards_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.flashcards_lesson_links_id_seq;
       public          strapi    false    257                       0    0    flashcards_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.flashcards_lesson_links_id_seq OWNED BY public.flashcards_lesson_links.id;
          public          strapi    false    258                       1259    59012    flashcards_localizations_links    TABLE     �   CREATE TABLE public.flashcards_localizations_links (
    id integer NOT NULL,
    flashcard_id integer,
    inv_flashcard_id integer,
    flashcard_order double precision
);
 2   DROP TABLE public.flashcards_localizations_links;
       public         heap    strapi    false                       1259    59015 %   flashcards_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.flashcards_localizations_links_id_seq;
       public          strapi    false    259                       0    0 %   flashcards_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.flashcards_localizations_links_id_seq OWNED BY public.flashcards_localizations_links.id;
          public          strapi    false    260                       1259    59016    flashcards_user_links    TABLE     �   CREATE TABLE public.flashcards_user_links (
    id integer NOT NULL,
    flashcard_id integer,
    user_id integer,
    flashcard_order double precision
);
 )   DROP TABLE public.flashcards_user_links;
       public         heap    strapi    false                       1259    59019    flashcards_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.flashcards_user_links_id_seq;
       public          strapi    false    261                       0    0    flashcards_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_user_links_id_seq OWNED BY public.flashcards_user_links.id;
          public          strapi    false    262                       1259    59020    i18n_locale    TABLE       CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.i18n_locale;
       public         heap    strapi    false                       1259    59025    i18n_locale_id_seq    SEQUENCE     �   CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.i18n_locale_id_seq;
       public          strapi    false    263                       0    0    i18n_locale_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;
          public          strapi    false    264            	           1259    59026    lessonlevels    TABLE       CREATE TABLE public.lessonlevels (
    id integer NOT NULL,
    level character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    description character varying(255)
);
     DROP TABLE public.lessonlevels;
       public         heap    strapi    false            
           1259    59031    lessonlevels_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessonlevels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.lessonlevels_id_seq;
       public          strapi    false    265                       0    0    lessonlevels_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.lessonlevels_id_seq OWNED BY public.lessonlevels.id;
          public          strapi    false    266                       1259    59032    lessons    TABLE     p  CREATE TABLE public.lessons (
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
    DROP TABLE public.lessons;
       public         heap    strapi    false                       1259    59037    lessons_components    TABLE     �   CREATE TABLE public.lessons_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 &   DROP TABLE public.lessons_components;
       public         heap    strapi    false                       1259    59042    lessons_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.lessons_components_id_seq;
       public          strapi    false    268                       0    0    lessons_components_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_components_id_seq OWNED BY public.lessons_components.id;
          public          strapi    false    269                       1259    59043    lessons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.lessons_id_seq;
       public          strapi    false    267                       0    0    lessons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;
          public          strapi    false    270                       1259    59044    lessons_lessonlevel_links    TABLE     �   CREATE TABLE public.lessons_lessonlevel_links (
    id integer NOT NULL,
    lesson_id integer,
    lessonlevel_id integer,
    lesson_order double precision
);
 -   DROP TABLE public.lessons_lessonlevel_links;
       public         heap    strapi    false                       1259    59047     lessons_lessonlevel_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_lessonlevel_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.lessons_lessonlevel_links_id_seq;
       public          strapi    false    271                       0    0     lessons_lessonlevel_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.lessons_lessonlevel_links_id_seq OWNED BY public.lessons_lessonlevel_links.id;
          public          strapi    false    272                       1259    59048    lessons_localizations_links    TABLE     �   CREATE TABLE public.lessons_localizations_links (
    id integer NOT NULL,
    lesson_id integer,
    inv_lesson_id integer,
    lesson_order double precision
);
 /   DROP TABLE public.lessons_localizations_links;
       public         heap    strapi    false                       1259    59051 "   lessons_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.lessons_localizations_links_id_seq;
       public          strapi    false    273            	           0    0 "   lessons_localizations_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.lessons_localizations_links_id_seq OWNED BY public.lessons_localizations_links.id;
          public          strapi    false    274                       1259    59052    lessons_unit_links    TABLE     �   CREATE TABLE public.lessons_unit_links (
    id integer NOT NULL,
    lesson_id integer,
    unit_id integer,
    lesson_order double precision
);
 &   DROP TABLE public.lessons_unit_links;
       public         heap    strapi    false                       1259    59055    lessons_unit_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_unit_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.lessons_unit_links_id_seq;
       public          strapi    false    275            
           0    0    lessons_unit_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_unit_links_id_seq OWNED BY public.lessons_unit_links.id;
          public          strapi    false    276            d           1259    60327    review_tires    TABLE     z  CREATE TABLE public.review_tires (
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
     DROP TABLE public.review_tires;
       public         heap    strapi    false            c           1259    60326    review_tires_id_seq    SEQUENCE     �   CREATE SEQUENCE public.review_tires_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.review_tires_id_seq;
       public          strapi    false    356                       0    0    review_tires_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.review_tires_id_seq OWNED BY public.review_tires.id;
          public          strapi    false    355            f           1259    60338     review_tires_localizations_links    TABLE     �   CREATE TABLE public.review_tires_localizations_links (
    id integer NOT NULL,
    review_tire_id integer,
    inv_review_tire_id integer,
    review_tire_order double precision
);
 4   DROP TABLE public.review_tires_localizations_links;
       public         heap    strapi    false            e           1259    60337 '   review_tires_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.review_tires_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.review_tires_localizations_links_id_seq;
       public          strapi    false    358                       0    0 '   review_tires_localizations_links_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.review_tires_localizations_links_id_seq OWNED BY public.review_tires_localizations_links.id;
          public          strapi    false    357                       1259    59056 
   reviewlogs    TABLE     E  CREATE TABLE public.reviewlogs (
    id integer NOT NULL,
    level character varying(255),
    result character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    reviewed_at timestamp(6) without time zone
);
    DROP TABLE public.reviewlogs;
       public         heap    strapi    false            h           1259    60396    reviewlogs_flashcard_links    TABLE     �   CREATE TABLE public.reviewlogs_flashcard_links (
    id integer NOT NULL,
    reviewlog_id integer,
    flashcard_id integer,
    reviewlog_order double precision
);
 .   DROP TABLE public.reviewlogs_flashcard_links;
       public         heap    strapi    false            g           1259    60395 !   reviewlogs_flashcard_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_flashcard_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.reviewlogs_flashcard_links_id_seq;
       public          strapi    false    360                       0    0 !   reviewlogs_flashcard_links_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.reviewlogs_flashcard_links_id_seq OWNED BY public.reviewlogs_flashcard_links.id;
          public          strapi    false    359                       1259    59061    reviewlogs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.reviewlogs_id_seq;
       public          strapi    false    277                       0    0    reviewlogs_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.reviewlogs_id_seq OWNED BY public.reviewlogs.id;
          public          strapi    false    278                       1259    59062    reviewlogs_user_links    TABLE     �   CREATE TABLE public.reviewlogs_user_links (
    id integer NOT NULL,
    reviewlog_id integer,
    user_id integer,
    reviewlog_order double precision
);
 )   DROP TABLE public.reviewlogs_user_links;
       public         heap    strapi    false                       1259    59065    reviewlogs_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.reviewlogs_user_links_id_seq;
       public          strapi    false    279                       0    0    reviewlogs_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.reviewlogs_user_links_id_seq OWNED BY public.reviewlogs_user_links.id;
          public          strapi    false    280                       1259    59066    sections    TABLE     (  CREATE TABLE public.sections (
    id integer NOT NULL,
    title character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);
    DROP TABLE public.sections;
       public         heap    strapi    false                       1259    59071    sections_components    TABLE     �   CREATE TABLE public.sections_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 '   DROP TABLE public.sections_components;
       public         heap    strapi    false                       1259    59076    sections_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.sections_components_id_seq;
       public          strapi    false    282                       0    0    sections_components_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.sections_components_id_seq OWNED BY public.sections_components.id;
          public          strapi    false    283                       1259    59077    sections_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sections_id_seq;
       public          strapi    false    281                       0    0    sections_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;
          public          strapi    false    284                       1259    59078    sections_lesson_links    TABLE     �   CREATE TABLE public.sections_lesson_links (
    id integer NOT NULL,
    section_id integer,
    lesson_id integer,
    section_order double precision
);
 )   DROP TABLE public.sections_lesson_links;
       public         heap    strapi    false                       1259    59081    sections_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sections_lesson_links_id_seq;
       public          strapi    false    285                       0    0    sections_lesson_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sections_lesson_links_id_seq OWNED BY public.sections_lesson_links.id;
          public          strapi    false    286                       1259    59082    sections_localizations_links    TABLE     �   CREATE TABLE public.sections_localizations_links (
    id integer NOT NULL,
    section_id integer,
    inv_section_id integer,
    section_order double precision
);
 0   DROP TABLE public.sections_localizations_links;
       public         heap    strapi    false                        1259    59085 #   sections_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.sections_localizations_links_id_seq;
       public          strapi    false    287                       0    0 #   sections_localizations_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.sections_localizations_links_id_seq OWNED BY public.sections_localizations_links.id;
          public          strapi    false    288            !           1259    59086 	   sentences    TABLE     �  CREATE TABLE public.sentences (
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
    register character varying(255)
);
    DROP TABLE public.sentences;
       public         heap    strapi    false            "           1259    59091    sentences_components    TABLE     �   CREATE TABLE public.sentences_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.sentences_components;
       public         heap    strapi    false            #           1259    59096    sentences_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.sentences_components_id_seq;
       public          strapi    false    290                       0    0    sentences_components_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sentences_components_id_seq OWNED BY public.sentences_components.id;
          public          strapi    false    291            $           1259    59097    sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sentences_id_seq;
       public          strapi    false    289                       0    0    sentences_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;
          public          strapi    false    292            %           1259    59098    sentences_localizations_links    TABLE     �   CREATE TABLE public.sentences_localizations_links (
    id integer NOT NULL,
    sentence_id integer,
    inv_sentence_id integer,
    sentence_order double precision
);
 1   DROP TABLE public.sentences_localizations_links;
       public         heap    strapi    false            &           1259    59101 $   sentences_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.sentences_localizations_links_id_seq;
       public          strapi    false    293                       0    0 $   sentences_localizations_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.sentences_localizations_links_id_seq OWNED BY public.sentences_localizations_links.id;
          public          strapi    false    294            '           1259    59102    strapi_api_token_permissions    TABLE       CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 0   DROP TABLE public.strapi_api_token_permissions;
       public         heap    strapi    false            (           1259    59105 #   strapi_api_token_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.strapi_api_token_permissions_id_seq;
       public          strapi    false    295                       0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;
          public          strapi    false    296            )           1259    59106 (   strapi_api_token_permissions_token_links    TABLE     �   CREATE TABLE public.strapi_api_token_permissions_token_links (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_order double precision
);
 <   DROP TABLE public.strapi_api_token_permissions_token_links;
       public         heap    strapi    false            *           1259    59109 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 F   DROP SEQUENCE public.strapi_api_token_permissions_token_links_id_seq;
       public          strapi    false    297                       0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;
          public          strapi    false    298            +           1259    59110    strapi_api_tokens    TABLE     �  CREATE TABLE public.strapi_api_tokens (
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
 %   DROP TABLE public.strapi_api_tokens;
       public         heap    strapi    false            ,           1259    59115    strapi_api_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.strapi_api_tokens_id_seq;
       public          strapi    false    299                       0    0    strapi_api_tokens_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;
          public          strapi    false    300            -           1259    59116    strapi_core_store_settings    TABLE     �   CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);
 .   DROP TABLE public.strapi_core_store_settings;
       public         heap    strapi    false            .           1259    59121 !   strapi_core_store_settings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.strapi_core_store_settings_id_seq;
       public          strapi    false    301                       0    0 !   strapi_core_store_settings_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;
          public          strapi    false    302            /           1259    59122    strapi_database_schema    TABLE     �   CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);
 *   DROP TABLE public.strapi_database_schema;
       public         heap    strapi    false            0           1259    59127    strapi_database_schema_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.strapi_database_schema_id_seq;
       public          strapi    false    303                       0    0    strapi_database_schema_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;
          public          strapi    false    304            1           1259    59128    strapi_migrations    TABLE     �   CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);
 %   DROP TABLE public.strapi_migrations;
       public         heap    strapi    false            2           1259    59131    strapi_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.strapi_migrations_id_seq;
       public          strapi    false    305                       0    0    strapi_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;
          public          strapi    false    306            3           1259    59132 !   strapi_transfer_token_permissions    TABLE     
  CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 5   DROP TABLE public.strapi_transfer_token_permissions;
       public         heap    strapi    false            4           1259    59135 (   strapi_transfer_token_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.strapi_transfer_token_permissions_id_seq;
       public          strapi    false    307                       0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;
          public          strapi    false    308            5           1259    59136 -   strapi_transfer_token_permissions_token_links    TABLE     �   CREATE TABLE public.strapi_transfer_token_permissions_token_links (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_order double precision
);
 A   DROP TABLE public.strapi_transfer_token_permissions_token_links;
       public         heap    strapi    false            6           1259    59139 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 K   DROP SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq;
       public          strapi    false    309                       0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;
          public          strapi    false    310            7           1259    59140    strapi_transfer_tokens    TABLE     �  CREATE TABLE public.strapi_transfer_tokens (
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
 *   DROP TABLE public.strapi_transfer_tokens;
       public         heap    strapi    false            8           1259    59145    strapi_transfer_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.strapi_transfer_tokens_id_seq;
       public          strapi    false    311                       0    0    strapi_transfer_tokens_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;
          public          strapi    false    312            9           1259    59146    strapi_webhooks    TABLE     �   CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);
 #   DROP TABLE public.strapi_webhooks;
       public         heap    strapi    false            :           1259    59151    strapi_webhooks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.strapi_webhooks_id_seq;
       public          strapi    false    313                        0    0    strapi_webhooks_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;
          public          strapi    false    314            ;           1259    59152    units    TABLE     n  CREATE TABLE public.units (
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
    DROP TABLE public.units;
       public         heap    strapi    false            <           1259    59157    units_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.units_id_seq;
       public          strapi    false    315            !           0    0    units_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;
          public          strapi    false    316            =           1259    59158    units_localizations_links    TABLE     �   CREATE TABLE public.units_localizations_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer,
    unit_order double precision
);
 -   DROP TABLE public.units_localizations_links;
       public         heap    strapi    false            >           1259    59161     units_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.units_localizations_links_id_seq;
       public          strapi    false    317            "           0    0     units_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.units_localizations_links_id_seq OWNED BY public.units_localizations_links.id;
          public          strapi    false    318            ?           1259    59162    units_precondition_links    TABLE     x   CREATE TABLE public.units_precondition_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer
);
 ,   DROP TABLE public.units_precondition_links;
       public         heap    strapi    false            @           1259    59165    units_precondition_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_precondition_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.units_precondition_links_id_seq;
       public          strapi    false    319            #           0    0    units_precondition_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.units_precondition_links_id_seq OWNED BY public.units_precondition_links.id;
          public          strapi    false    320            A           1259    59166    up_permissions    TABLE     �   CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 "   DROP TABLE public.up_permissions;
       public         heap    strapi    false            B           1259    59169    up_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.up_permissions_id_seq;
       public          strapi    false    321            $           0    0    up_permissions_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;
          public          strapi    false    322            C           1259    59170    up_permissions_role_links    TABLE     �   CREATE TABLE public.up_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);
 -   DROP TABLE public.up_permissions_role_links;
       public         heap    strapi    false            D           1259    59173     up_permissions_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.up_permissions_role_links_id_seq;
       public          strapi    false    323            %           0    0     up_permissions_role_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;
          public          strapi    false    324            E           1259    59174    up_roles    TABLE     8  CREATE TABLE public.up_roles (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.up_roles;
       public         heap    strapi    false            F           1259    59179    up_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.up_roles_id_seq;
       public          strapi    false    325            &           0    0    up_roles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;
          public          strapi    false    326            G           1259    59180    up_users    TABLE     �  CREATE TABLE public.up_users (
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
    DROP TABLE public.up_users;
       public         heap    strapi    false            H           1259    59185    up_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.up_users_id_seq;
       public          strapi    false    327            '           0    0    up_users_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;
          public          strapi    false    328            I           1259    59186    up_users_role_links    TABLE     �   CREATE TABLE public.up_users_role_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_order double precision
);
 '   DROP TABLE public.up_users_role_links;
       public         heap    strapi    false            J           1259    59189    up_users_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_users_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.up_users_role_links_id_seq;
       public          strapi    false    329            (           0    0    up_users_role_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;
          public          strapi    false    330            K           1259    59190    upload_folders    TABLE     +  CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 "   DROP TABLE public.upload_folders;
       public         heap    strapi    false            L           1259    59195    upload_folders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.upload_folders_id_seq;
       public          strapi    false    331            )           0    0    upload_folders_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;
          public          strapi    false    332            M           1259    59196    upload_folders_parent_links    TABLE     �   CREATE TABLE public.upload_folders_parent_links (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_order double precision
);
 /   DROP TABLE public.upload_folders_parent_links;
       public         heap    strapi    false            N           1259    59199 "   upload_folders_parent_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.upload_folders_parent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.upload_folders_parent_links_id_seq;
       public          strapi    false    333            *           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;
          public          strapi    false    334            j           1259    60467    user_profiles    TABLE     #  CREATE TABLE public.user_profiles (
    id integer NOT NULL,
    telephone character varying(255),
    base_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 !   DROP TABLE public.user_profiles;
       public         heap    strapi    false            i           1259    60466    user_profiles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.user_profiles_id_seq;
       public          strapi    false    362            +           0    0    user_profiles_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;
          public          strapi    false    361            l           1259    60478    user_profiles_user_links    TABLE     |   CREATE TABLE public.user_profiles_user_links (
    id integer NOT NULL,
    user_profile_id integer,
    user_id integer
);
 ,   DROP TABLE public.user_profiles_user_links;
       public         heap    strapi    false            k           1259    60477    user_profiles_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_profiles_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.user_profiles_user_links_id_seq;
       public          strapi    false    364            ,           0    0    user_profiles_user_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.user_profiles_user_links_id_seq OWNED BY public.user_profiles_user_links.id;
          public          strapi    false    363            O           1259    59200    user_sentences    TABLE     E  CREATE TABLE public.user_sentences (
    id integer NOT NULL,
    target_text character varying(255),
    base_text character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);
 "   DROP TABLE public.user_sentences;
       public         heap    strapi    false            P           1259    59205    user_sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.user_sentences_id_seq;
       public          strapi    false    335            -           0    0    user_sentences_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.user_sentences_id_seq OWNED BY public.user_sentences.id;
          public          strapi    false    336            Q           1259    59206    user_sentences_lesson_links    TABLE     �   CREATE TABLE public.user_sentences_lesson_links (
    id integer NOT NULL,
    user_sentence_id integer,
    lesson_id integer,
    user_sentence_order double precision
);
 /   DROP TABLE public.user_sentences_lesson_links;
       public         heap    strapi    false            R           1259    59209 "   user_sentences_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.user_sentences_lesson_links_id_seq;
       public          strapi    false    337            .           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.user_sentences_lesson_links_id_seq OWNED BY public.user_sentences_lesson_links.id;
          public          strapi    false    338            S           1259    59210 "   user_sentences_localizations_links    TABLE     �   CREATE TABLE public.user_sentences_localizations_links (
    id integer NOT NULL,
    user_sentence_id integer,
    inv_user_sentence_id integer,
    user_sentence_order double precision
);
 6   DROP TABLE public.user_sentences_localizations_links;
       public         heap    strapi    false            T           1259    59213 )   user_sentences_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.user_sentences_localizations_links_id_seq;
       public          strapi    false    339            /           0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public.user_sentences_localizations_links_id_seq OWNED BY public.user_sentences_localizations_links.id;
          public          strapi    false    340            p           1259    60635    user_sentences_user_links    TABLE     �   CREATE TABLE public.user_sentences_user_links (
    id integer NOT NULL,
    user_sentence_id integer,
    user_id integer,
    user_sentence_order double precision
);
 -   DROP TABLE public.user_sentences_user_links;
       public         heap    strapi    false            o           1259    60634     user_sentences_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.user_sentences_user_links_id_seq;
       public          strapi    false    368            0           0    0     user_sentences_user_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.user_sentences_user_links_id_seq OWNED BY public.user_sentences_user_links.id;
          public          strapi    false    367            U           1259    59218 
   user_words    TABLE     l  CREATE TABLE public.user_words (
    id integer NOT NULL,
    base_text character varying(255),
    part_of_speech character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    target_text character varying(255)
);
    DROP TABLE public.user_words;
       public         heap    strapi    false            V           1259    59223    user_words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.user_words_id_seq;
       public          strapi    false    341            1           0    0    user_words_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_words_id_seq OWNED BY public.user_words.id;
          public          strapi    false    342            W           1259    59224    user_words_lesson_links    TABLE     �   CREATE TABLE public.user_words_lesson_links (
    id integer NOT NULL,
    user_word_id integer,
    lesson_id integer,
    user_word_order double precision
);
 +   DROP TABLE public.user_words_lesson_links;
       public         heap    strapi    false            X           1259    59227    user_words_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.user_words_lesson_links_id_seq;
       public          strapi    false    343            2           0    0    user_words_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.user_words_lesson_links_id_seq OWNED BY public.user_words_lesson_links.id;
          public          strapi    false    344            Y           1259    59228    user_words_localizations_links    TABLE     �   CREATE TABLE public.user_words_localizations_links (
    id integer NOT NULL,
    user_word_id integer,
    inv_user_word_id integer,
    user_word_order double precision
);
 2   DROP TABLE public.user_words_localizations_links;
       public         heap    strapi    false            Z           1259    59231 %   user_words_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.user_words_localizations_links_id_seq;
       public          strapi    false    345            3           0    0 %   user_words_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.user_words_localizations_links_id_seq OWNED BY public.user_words_localizations_links.id;
          public          strapi    false    346            n           1259    60600    user_words_user_links    TABLE     �   CREATE TABLE public.user_words_user_links (
    id integer NOT NULL,
    user_word_id integer,
    user_id integer,
    user_word_order double precision
);
 )   DROP TABLE public.user_words_user_links;
       public         heap    strapi    false            m           1259    60599    user_words_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.user_words_user_links_id_seq;
       public          strapi    false    366            4           0    0    user_words_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.user_words_user_links_id_seq OWNED BY public.user_words_user_links.id;
          public          strapi    false    365            [           1259    59236    words    TABLE     �  CREATE TABLE public.words (
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
    register character varying(255)
);
    DROP TABLE public.words;
       public         heap    strapi    false            \           1259    59241    words_components    TABLE     �   CREATE TABLE public.words_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 $   DROP TABLE public.words_components;
       public         heap    strapi    false            ]           1259    59246    words_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.words_components_id_seq;
       public          strapi    false    348            5           0    0    words_components_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.words_components_id_seq OWNED BY public.words_components.id;
          public          strapi    false    349            ^           1259    59247    words_example_sentences_links    TABLE     �   CREATE TABLE public.words_example_sentences_links (
    id integer NOT NULL,
    word_id integer,
    sentence_id integer,
    sentence_order double precision,
    word_order double precision
);
 1   DROP TABLE public.words_example_sentences_links;
       public         heap    strapi    false            _           1259    59250 $   words_example_sentences_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_example_sentences_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.words_example_sentences_links_id_seq;
       public          strapi    false    350            6           0    0 $   words_example_sentences_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.words_example_sentences_links_id_seq OWNED BY public.words_example_sentences_links.id;
          public          strapi    false    351            `           1259    59251    words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.words_id_seq;
       public          strapi    false    347            7           0    0    words_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;
          public          strapi    false    352            a           1259    59252    words_localizations_links    TABLE     �   CREATE TABLE public.words_localizations_links (
    id integer NOT NULL,
    word_id integer,
    inv_word_id integer,
    word_order double precision
);
 -   DROP TABLE public.words_localizations_links;
       public         heap    strapi    false            b           1259    59255     words_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.words_localizations_links_id_seq;
       public          strapi    false    353            8           0    0     words_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.words_localizations_links_id_seq OWNED BY public.words_localizations_links.id;
          public          strapi    false    354            B           2604    59256    admin_permissions id    DEFAULT     |   ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);
 C   ALTER TABLE public.admin_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    210    209            C           2604    59257    admin_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);
 N   ALTER TABLE public.admin_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    212    211            D           2604    59258    admin_roles id    DEFAULT     p   ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);
 =   ALTER TABLE public.admin_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    214    213            E           2604    59259    admin_users id    DEFAULT     p   ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);
 =   ALTER TABLE public.admin_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    216    215            F           2604    59260    admin_users_roles_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);
 I   ALTER TABLE public.admin_users_roles_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    218    217            G           2604    59261    components_a_external_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_external_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_external_videos_id_seq'::regclass);
 N   ALTER TABLE public.components_a_external_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    220    219            H           2604    59262    components_a_pagebreakers id    DEFAULT     �   ALTER TABLE ONLY public.components_a_pagebreakers ALTER COLUMN id SET DEFAULT nextval('public.components_a_pagebreakers_id_seq'::regclass);
 K   ALTER TABLE public.components_a_pagebreakers ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    222    221            I           2604    59263    components_a_quizzes id    DEFAULT     �   ALTER TABLE ONLY public.components_a_quizzes ALTER COLUMN id SET DEFAULT nextval('public.components_a_quizzes_id_seq'::regclass);
 F   ALTER TABLE public.components_a_quizzes ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    224    223            J           2604    59264    components_a_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    226    225            K           2604    59265 (   components_a_sent_refs_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_sentence_links_id_seq'::regclass);
 W   ALTER TABLE public.components_a_sent_refs_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    228    227            L           2604    59266    components_a_taglists id    DEFAULT     �   ALTER TABLE ONLY public.components_a_taglists ALTER COLUMN id SET DEFAULT nextval('public.components_a_taglists_id_seq'::regclass);
 G   ALTER TABLE public.components_a_taglists ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    230    229            M           2604    59267    components_a_user_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    232    231            N           2604    59268 2   components_a_user_sent_refs_user_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_user_sentence_links_id_seq'::regclass);
 a   ALTER TABLE public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    234    233            O           2604    59269    components_a_user_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    236    235            P           2604    59270 .   components_a_user_word_refs_user_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_user_word_links_id_seq'::regclass);
 ]   ALTER TABLE public.components_a_user_word_refs_user_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    238    237            Q           2604    59271    components_a_verb_metas id    DEFAULT     �   ALTER TABLE ONLY public.components_a_verb_metas ALTER COLUMN id SET DEFAULT nextval('public.components_a_verb_metas_id_seq'::regclass);
 I   ALTER TABLE public.components_a_verb_metas ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    240    239            R           2604    59272    components_a_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_videos_id_seq'::regclass);
 E   ALTER TABLE public.components_a_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    242    241            S           2604    59273    components_a_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    244    243            T           2604    59274 $   components_a_word_refs_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_word_links_id_seq'::regclass);
 S   ALTER TABLE public.components_a_word_refs_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    246    245            U           2604    59275    files id    DEFAULT     d   ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
 7   ALTER TABLE public.files ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    250    247            V           2604    59276    files_folder_links id    DEFAULT     ~   ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);
 D   ALTER TABLE public.files_folder_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    249    248            W           2604    59277    files_related_morphs id    DEFAULT     �   ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);
 F   ALTER TABLE public.files_related_morphs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    252    251            X           2604    59278    flashcards id    DEFAULT     n   ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);
 <   ALTER TABLE public.flashcards ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    256    253            Y           2604    59279    flashcards_components id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_components ALTER COLUMN id SET DEFAULT nextval('public.flashcards_components_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    255    254            Z           2604    59280    flashcards_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.flashcards_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    258    257            [           2604    59281 !   flashcards_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.flashcards_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    260    259            \           2604    59282    flashcards_user_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_user_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_user_links_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    262    261            ]           2604    59283    i18n_locale id    DEFAULT     p   ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);
 =   ALTER TABLE public.i18n_locale ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    264    263            ^           2604    59284    lessonlevels id    DEFAULT     r   ALTER TABLE ONLY public.lessonlevels ALTER COLUMN id SET DEFAULT nextval('public.lessonlevels_id_seq'::regclass);
 >   ALTER TABLE public.lessonlevels ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    266    265            _           2604    59285 
   lessons id    DEFAULT     h   ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);
 9   ALTER TABLE public.lessons ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    270    267            `           2604    59286    lessons_components id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_components ALTER COLUMN id SET DEFAULT nextval('public.lessons_components_id_seq'::regclass);
 D   ALTER TABLE public.lessons_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    269    268            a           2604    59287    lessons_lessonlevel_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_lessonlevel_links_id_seq'::regclass);
 K   ALTER TABLE public.lessons_lessonlevel_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    272    271            b           2604    59288    lessons_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_localizations_links_id_seq'::regclass);
 M   ALTER TABLE public.lessons_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    274    273            c           2604    59289    lessons_unit_links id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_unit_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_unit_links_id_seq'::regclass);
 D   ALTER TABLE public.lessons_unit_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    276    275            �           2604    60330    review_tires id    DEFAULT     r   ALTER TABLE ONLY public.review_tires ALTER COLUMN id SET DEFAULT nextval('public.review_tires_id_seq'::regclass);
 >   ALTER TABLE public.review_tires ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    356    355    356            �           2604    60341 #   review_tires_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.review_tires_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.review_tires_localizations_links_id_seq'::regclass);
 R   ALTER TABLE public.review_tires_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    357    358    358            d           2604    59290    reviewlogs id    DEFAULT     n   ALTER TABLE ONLY public.reviewlogs ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_id_seq'::regclass);
 <   ALTER TABLE public.reviewlogs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    278    277            �           2604    60399    reviewlogs_flashcard_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_flashcard_links_id_seq'::regclass);
 L   ALTER TABLE public.reviewlogs_flashcard_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    360    359    360            e           2604    59291    reviewlogs_user_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_user_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_user_links_id_seq'::regclass);
 G   ALTER TABLE public.reviewlogs_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    280    279            f           2604    59292    sections id    DEFAULT     j   ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);
 :   ALTER TABLE public.sections ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    284    281            g           2604    59293    sections_components id    DEFAULT     �   ALTER TABLE ONLY public.sections_components ALTER COLUMN id SET DEFAULT nextval('public.sections_components_id_seq'::regclass);
 E   ALTER TABLE public.sections_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    283    282            h           2604    59294    sections_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.sections_lesson_links_id_seq'::regclass);
 G   ALTER TABLE public.sections_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    286    285            i           2604    59295    sections_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sections_localizations_links_id_seq'::regclass);
 N   ALTER TABLE public.sections_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    288    287            j           2604    59296    sentences id    DEFAULT     l   ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);
 ;   ALTER TABLE public.sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    292    289            k           2604    59297    sentences_components id    DEFAULT     �   ALTER TABLE ONLY public.sentences_components ALTER COLUMN id SET DEFAULT nextval('public.sentences_components_id_seq'::regclass);
 F   ALTER TABLE public.sentences_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    291    290            l           2604    59298     sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sentences_localizations_links_id_seq'::regclass);
 O   ALTER TABLE public.sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    294    293            m           2604    59299    strapi_api_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);
 N   ALTER TABLE public.strapi_api_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    296    295            n           2604    59300 +   strapi_api_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);
 Z   ALTER TABLE public.strapi_api_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    298    297            o           2604    59301    strapi_api_tokens id    DEFAULT     |   ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);
 C   ALTER TABLE public.strapi_api_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    300    299            p           2604    59302    strapi_core_store_settings id    DEFAULT     �   ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);
 L   ALTER TABLE public.strapi_core_store_settings ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    302    301            q           2604    59303    strapi_database_schema id    DEFAULT     �   ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);
 H   ALTER TABLE public.strapi_database_schema ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    304    303            r           2604    59304    strapi_migrations id    DEFAULT     |   ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);
 C   ALTER TABLE public.strapi_migrations ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    306    305            s           2604    59305 $   strapi_transfer_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);
 S   ALTER TABLE public.strapi_transfer_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    308    307            t           2604    59306 0   strapi_transfer_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);
 _   ALTER TABLE public.strapi_transfer_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    310    309            u           2604    59307    strapi_transfer_tokens id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);
 H   ALTER TABLE public.strapi_transfer_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    312    311            v           2604    59308    strapi_webhooks id    DEFAULT     x   ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);
 A   ALTER TABLE public.strapi_webhooks ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    314    313            w           2604    59309    units id    DEFAULT     d   ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);
 7   ALTER TABLE public.units ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    316    315            x           2604    59310    units_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.units_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.units_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.units_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    318    317            y           2604    59311    units_precondition_links id    DEFAULT     �   ALTER TABLE ONLY public.units_precondition_links ALTER COLUMN id SET DEFAULT nextval('public.units_precondition_links_id_seq'::regclass);
 J   ALTER TABLE public.units_precondition_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    320    319            z           2604    59312    up_permissions id    DEFAULT     v   ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);
 @   ALTER TABLE public.up_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    322    321            {           2604    59313    up_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);
 K   ALTER TABLE public.up_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    324    323            |           2604    59314    up_roles id    DEFAULT     j   ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);
 :   ALTER TABLE public.up_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    326    325            }           2604    59315    up_users id    DEFAULT     j   ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);
 :   ALTER TABLE public.up_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    328    327            ~           2604    59316    up_users_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);
 E   ALTER TABLE public.up_users_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    330    329                       2604    59317    upload_folders id    DEFAULT     v   ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);
 @   ALTER TABLE public.upload_folders ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    332    331            �           2604    59318    upload_folders_parent_links id    DEFAULT     �   ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);
 M   ALTER TABLE public.upload_folders_parent_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    334    333            �           2604    60470    user_profiles id    DEFAULT     t   ALTER TABLE ONLY public.user_profiles ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_id_seq'::regclass);
 ?   ALTER TABLE public.user_profiles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    361    362    362            �           2604    60481    user_profiles_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_profiles_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_profiles_user_links_id_seq'::regclass);
 J   ALTER TABLE public.user_profiles_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    363    364    364            �           2604    59319    user_sentences id    DEFAULT     v   ALTER TABLE ONLY public.user_sentences ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_id_seq'::regclass);
 @   ALTER TABLE public.user_sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    336    335            �           2604    59320    user_sentences_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_lesson_links_id_seq'::regclass);
 M   ALTER TABLE public.user_sentences_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    338    337            �           2604    59321 %   user_sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_localizations_links_id_seq'::regclass);
 T   ALTER TABLE public.user_sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    340    339            �           2604    60638    user_sentences_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_user_links_id_seq'::regclass);
 K   ALTER TABLE public.user_sentences_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    368    367    368            �           2604    59323    user_words id    DEFAULT     n   ALTER TABLE ONLY public.user_words ALTER COLUMN id SET DEFAULT nextval('public.user_words_id_seq'::regclass);
 <   ALTER TABLE public.user_words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    342    341            �           2604    59324    user_words_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.user_words_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    344    343            �           2604    59325 !   user_words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.user_words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    346    345            �           2604    60603    user_words_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_user_links_id_seq'::regclass);
 G   ALTER TABLE public.user_words_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    366    365    366            �           2604    59327    words id    DEFAULT     d   ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);
 7   ALTER TABLE public.words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    352    347            �           2604    59328    words_components id    DEFAULT     z   ALTER TABLE ONLY public.words_components ALTER COLUMN id SET DEFAULT nextval('public.words_components_id_seq'::regclass);
 B   ALTER TABLE public.words_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    349    348            �           2604    59329     words_example_sentences_links id    DEFAULT     �   ALTER TABLE ONLY public.words_example_sentences_links ALTER COLUMN id SET DEFAULT nextval('public.words_example_sentences_links_id_seq'::regclass);
 O   ALTER TABLE public.words_example_sentences_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    351    350            �           2604    59330    words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.words_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    354    353            B          0    58893    admin_permissions 
   TABLE DATA           �   COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    209   ��      D          0    58899    admin_permissions_role_links 
   TABLE DATA           d   COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    211   ��      F          0    58903    admin_roles 
   TABLE DATA           x   COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    213   ��      H          0    58909    admin_users 
   TABLE DATA           �   COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    215   w�      J          0    58915    admin_users_roles_links 
   TABLE DATA           _   COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
    public          strapi    false    217   �      L          0    58919    components_a_external_videos 
   TABLE DATA           H   COPY public.components_a_external_videos (id, url, caption) FROM stdin;
    public          strapi    false    219   4�      N          0    58925    components_a_pagebreakers 
   TABLE DATA           O   COPY public.components_a_pagebreakers (id, backbutton, nextbutton) FROM stdin;
    public          strapi    false    221   Q�      P          0    58929    components_a_quizzes 
   TABLE DATA           Z   COPY public.components_a_quizzes (id, question, options, answer, explanation) FROM stdin;
    public          strapi    false    223   n�      R          0    58935    components_a_sent_refs 
   TABLE DATA           4   COPY public.components_a_sent_refs (id) FROM stdin;
    public          strapi    false    225   ��      T          0    58939 %   components_a_sent_refs_sentence_links 
   TABLE DATA           ]   COPY public.components_a_sent_refs_sentence_links (id, sent_ref_id, sentence_id) FROM stdin;
    public          strapi    false    227   ��      V          0    58943    components_a_taglists 
   TABLE DATA           8   COPY public.components_a_taglists (id, tag) FROM stdin;
    public          strapi    false    229   ��      X          0    58947    components_a_user_sent_refs 
   TABLE DATA           9   COPY public.components_a_user_sent_refs (id) FROM stdin;
    public          strapi    false    231   ��      Z          0    58951 /   components_a_user_sent_refs_user_sentence_links 
   TABLE DATA           q   COPY public.components_a_user_sent_refs_user_sentence_links (id, user_sent_ref_id, user_sentence_id) FROM stdin;
    public          strapi    false    233   �      \          0    58955    components_a_user_word_refs 
   TABLE DATA           9   COPY public.components_a_user_word_refs (id) FROM stdin;
    public          strapi    false    235   8�      ^          0    58959 +   components_a_user_word_refs_user_word_links 
   TABLE DATA           i   COPY public.components_a_user_word_refs_user_word_links (id, user_word_ref_id, user_word_id) FROM stdin;
    public          strapi    false    237   ��      `          0    58963    components_a_verb_metas 
   TABLE DATA           �   COPY public.components_a_verb_metas (id, simple_past, past_participle, present_participle, thirdperson_singular, auxiliary_verb, conjugations) FROM stdin;
    public          strapi    false    239   �      b          0    58969    components_a_videos 
   TABLE DATA           1   COPY public.components_a_videos (id) FROM stdin;
    public          strapi    false    241   P�      d          0    58973    components_a_word_refs 
   TABLE DATA           4   COPY public.components_a_word_refs (id) FROM stdin;
    public          strapi    false    243   m�      f          0    58977 !   components_a_word_refs_word_links 
   TABLE DATA           U   COPY public.components_a_word_refs_word_links (id, word_ref_id, word_id) FROM stdin;
    public          strapi    false    245   ��      h          0    58981    files 
   TABLE DATA           �   COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    247   ��      i          0    58986    files_folder_links 
   TABLE DATA           P   COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
    public          strapi    false    248   ��      l          0    58991    files_related_morphs 
   TABLE DATA           e   COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
    public          strapi    false    251   ��      n          0    58997 
   flashcards 
   TABLE DATA           �   COPY public.flashcards (id, created_at, updated_at, created_by_id, updated_by_id, locale, last_reviewed_at, is_remembered, correct_streak, wrong_streak) FROM stdin;
    public          strapi    false    253   �      o          0    59001    flashcards_components 
   TABLE DATA           l   COPY public.flashcards_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    254   ��      r          0    59008    flashcards_lesson_links 
   TABLE DATA           _   COPY public.flashcards_lesson_links (id, flashcard_id, lesson_id, flashcard_order) FROM stdin;
    public          strapi    false    257   ��      t          0    59012    flashcards_localizations_links 
   TABLE DATA           m   COPY public.flashcards_localizations_links (id, flashcard_id, inv_flashcard_id, flashcard_order) FROM stdin;
    public          strapi    false    259   �      v          0    59016    flashcards_user_links 
   TABLE DATA           [   COPY public.flashcards_user_links (id, flashcard_id, user_id, flashcard_order) FROM stdin;
    public          strapi    false    261   :�      x          0    59020    i18n_locale 
   TABLE DATA           k   COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    263   ��      z          0    59026    lessonlevels 
   TABLE DATA           t   COPY public.lessonlevels (id, level, created_at, updated_at, created_by_id, updated_by_id, description) FROM stdin;
    public          strapi    false    265   ;�      |          0    59032    lessons 
   TABLE DATA           �   COPY public.lessons (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    267   X�      }          0    59037    lessons_components 
   TABLE DATA           i   COPY public.lessons_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    268   ��      �          0    59044    lessons_lessonlevel_links 
   TABLE DATA           `   COPY public.lessons_lessonlevel_links (id, lesson_id, lessonlevel_id, lesson_order) FROM stdin;
    public          strapi    false    271   ��      �          0    59048    lessons_localizations_links 
   TABLE DATA           a   COPY public.lessons_localizations_links (id, lesson_id, inv_lesson_id, lesson_order) FROM stdin;
    public          strapi    false    273   ��      �          0    59052    lessons_unit_links 
   TABLE DATA           R   COPY public.lessons_unit_links (id, lesson_id, unit_id, lesson_order) FROM stdin;
    public          strapi    false    275   	�      �          0    60327    review_tires 
   TABLE DATA           �   COPY public.review_tires (id, tier, min_streak, max_streak, cooldown_hours, demote_bar, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    356   &�      �          0    60338     review_tires_localizations_links 
   TABLE DATA           u   COPY public.review_tires_localizations_links (id, review_tire_id, inv_review_tire_id, review_tire_order) FROM stdin;
    public          strapi    false    358   ��      �          0    59056 
   reviewlogs 
   TABLE DATA           z   COPY public.reviewlogs (id, level, result, created_at, updated_at, created_by_id, updated_by_id, reviewed_at) FROM stdin;
    public          strapi    false    277   ��      �          0    60396    reviewlogs_flashcard_links 
   TABLE DATA           e   COPY public.reviewlogs_flashcard_links (id, reviewlog_id, flashcard_id, reviewlog_order) FROM stdin;
    public          strapi    false    360   l�      �          0    59062    reviewlogs_user_links 
   TABLE DATA           [   COPY public.reviewlogs_user_links (id, reviewlog_id, user_id, reviewlog_order) FROM stdin;
    public          strapi    false    279   ��      �          0    59066    sections 
   TABLE DATA           t   COPY public.sections (id, title, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    281   c�      �          0    59071    sections_components 
   TABLE DATA           j   COPY public.sections_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    282   ��      �          0    59078    sections_lesson_links 
   TABLE DATA           Y   COPY public.sections_lesson_links (id, section_id, lesson_id, section_order) FROM stdin;
    public          strapi    false    285   1       �          0    59082    sections_localizations_links 
   TABLE DATA           e   COPY public.sections_localizations_links (id, section_id, inv_section_id, section_order) FROM stdin;
    public          strapi    false    287   `       �          0    59086 	   sentences 
   TABLE DATA           �   COPY public.sentences (id, title, instruction, base_text, target_text, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    289   }       �          0    59091    sentences_components 
   TABLE DATA           k   COPY public.sentences_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    290   >      �          0    59098    sentences_localizations_links 
   TABLE DATA           i   COPY public.sentences_localizations_links (id, sentence_id, inv_sentence_id, sentence_order) FROM stdin;
    public          strapi    false    293   [      �          0    59102    strapi_api_token_permissions 
   TABLE DATA           x   COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    295   x      �          0    59106 (   strapi_api_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
    public          strapi    false    297   �      �          0    59110    strapi_api_tokens 
   TABLE DATA           �   COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    299   �      �          0    59116    strapi_core_store_settings 
   TABLE DATA           \   COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
    public          strapi    false    301   �      �          0    59122    strapi_database_schema 
   TABLE DATA           J   COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
    public          strapi    false    303   A(      �          0    59128    strapi_migrations 
   TABLE DATA           =   COPY public.strapi_migrations (id, name, "time") FROM stdin;
    public          strapi    false    305   n:      �          0    59132 !   strapi_transfer_token_permissions 
   TABLE DATA           }   COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    307   �:      �          0    59136 -   strapi_transfer_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
    public          strapi    false    309   �:      �          0    59140    strapi_transfer_tokens 
   TABLE DATA           �   COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    311   �:      �          0    59146    strapi_webhooks 
   TABLE DATA           R   COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
    public          strapi    false    313   �:      �          0    59152    units 
   TABLE DATA           �   COPY public.units (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    315   �:      �          0    59158    units_localizations_links 
   TABLE DATA           Y   COPY public.units_localizations_links (id, unit_id, inv_unit_id, unit_order) FROM stdin;
    public          strapi    false    317   �;      �          0    59162    units_precondition_links 
   TABLE DATA           L   COPY public.units_precondition_links (id, unit_id, inv_unit_id) FROM stdin;
    public          strapi    false    319   �;      �          0    59166    up_permissions 
   TABLE DATA           j   COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    321   �;      �          0    59170    up_permissions_role_links 
   TABLE DATA           a   COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    323   �>      �          0    59174    up_roles 
   TABLE DATA           u   COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    325   �?      �          0    59180    up_users 
   TABLE DATA           �   COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    327   ~@      �          0    59186    up_users_role_links 
   TABLE DATA           O   COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
    public          strapi    false    329   �B      �          0    59190    upload_folders 
   TABLE DATA           w   COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    331   �B      �          0    59196    upload_folders_parent_links 
   TABLE DATA           a   COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
    public          strapi    false    333   �B      �          0    60467    user_profiles 
   TABLE DATA           {   COPY public.user_profiles (id, telephone, base_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    362   �B      �          0    60478    user_profiles_user_links 
   TABLE DATA           P   COPY public.user_profiles_user_links (id, user_profile_id, user_id) FROM stdin;
    public          strapi    false    364   �C      �          0    59200    user_sentences 
   TABLE DATA           �   COPY public.user_sentences (id, target_text, base_text, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    335   �C      �          0    59206    user_sentences_lesson_links 
   TABLE DATA           k   COPY public.user_sentences_lesson_links (id, user_sentence_id, lesson_id, user_sentence_order) FROM stdin;
    public          strapi    false    337   4D      �          0    59210 "   user_sentences_localizations_links 
   TABLE DATA           }   COPY public.user_sentences_localizations_links (id, user_sentence_id, inv_user_sentence_id, user_sentence_order) FROM stdin;
    public          strapi    false    339   VD      �          0    60635    user_sentences_user_links 
   TABLE DATA           g   COPY public.user_sentences_user_links (id, user_sentence_id, user_id, user_sentence_order) FROM stdin;
    public          strapi    false    368   sD      �          0    59218 
   user_words 
   TABLE DATA           �   COPY public.user_words (id, base_text, part_of_speech, created_at, updated_at, created_by_id, updated_by_id, locale, target_text) FROM stdin;
    public          strapi    false    341   �D      �          0    59224    user_words_lesson_links 
   TABLE DATA           _   COPY public.user_words_lesson_links (id, user_word_id, lesson_id, user_word_order) FROM stdin;
    public          strapi    false    343   �H      �          0    59228    user_words_localizations_links 
   TABLE DATA           m   COPY public.user_words_localizations_links (id, user_word_id, inv_user_word_id, user_word_order) FROM stdin;
    public          strapi    false    345   �H      �          0    60600    user_words_user_links 
   TABLE DATA           [   COPY public.user_words_user_links (id, user_word_id, user_id, user_word_order) FROM stdin;
    public          strapi    false    366   �H      �          0    59236    words 
   TABLE DATA           �   COPY public.words (id, word, base_text, instruction, part_of_speech, gender, article, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    347   �I      �          0    59241    words_components 
   TABLE DATA           g   COPY public.words_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    348   J      �          0    59247    words_example_sentences_links 
   TABLE DATA           m   COPY public.words_example_sentences_links (id, word_id, sentence_id, sentence_order, word_order) FROM stdin;
    public          strapi    false    350   �J      �          0    59252    words_localizations_links 
   TABLE DATA           Y   COPY public.words_localizations_links (id, word_id, inv_word_id, word_order) FROM stdin;
    public          strapi    false    353   �J      9           0    0    admin_permissions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.admin_permissions_id_seq', 272, true);
          public          strapi    false    210            :           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 272, true);
          public          strapi    false    212            ;           0    0    admin_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);
          public          strapi    false    214            <           0    0    admin_users_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);
          public          strapi    false    216            =           0    0    admin_users_roles_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);
          public          strapi    false    218            >           0    0 #   components_a_external_videos_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.components_a_external_videos_id_seq', 1, false);
          public          strapi    false    220            ?           0    0     components_a_pagebreakers_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.components_a_pagebreakers_id_seq', 1, false);
          public          strapi    false    222            @           0    0    components_a_quizzes_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_quizzes_id_seq', 1, false);
          public          strapi    false    224            A           0    0    components_a_sent_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_sent_refs_id_seq', 1, true);
          public          strapi    false    226            B           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.components_a_sent_refs_sentence_links_id_seq', 1, true);
          public          strapi    false    228            C           0    0    components_a_taglists_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_taglists_id_seq', 2, true);
          public          strapi    false    230            D           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.components_a_user_sent_refs_id_seq', 1, true);
          public          strapi    false    232            E           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('public.components_a_user_sent_refs_user_sentence_links_id_seq', 1, true);
          public          strapi    false    234            F           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.components_a_user_word_refs_id_seq', 28, true);
          public          strapi    false    236            G           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.components_a_user_word_refs_user_word_links_id_seq', 28, true);
          public          strapi    false    238            H           0    0    components_a_verb_metas_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.components_a_verb_metas_id_seq', 1, true);
          public          strapi    false    240            I           0    0    components_a_videos_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.components_a_videos_id_seq', 1, false);
          public          strapi    false    242            J           0    0    components_a_word_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_word_refs_id_seq', 4, true);
          public          strapi    false    244            K           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.components_a_word_refs_word_links_id_seq', 4, true);
          public          strapi    false    246            L           0    0    files_folder_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);
          public          strapi    false    249            M           0    0    files_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.files_id_seq', 1, false);
          public          strapi    false    250            N           0    0    files_related_morphs_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);
          public          strapi    false    252            O           0    0    flashcards_components_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.flashcards_components_id_seq', 76, true);
          public          strapi    false    255            P           0    0    flashcards_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.flashcards_id_seq', 32, true);
          public          strapi    false    256            Q           0    0    flashcards_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.flashcards_lesson_links_id_seq', 1, true);
          public          strapi    false    258            R           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.flashcards_localizations_links_id_seq', 1, false);
          public          strapi    false    260            S           0    0    flashcards_user_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.flashcards_user_links_id_seq', 33, true);
          public          strapi    false    262            T           0    0    i18n_locale_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);
          public          strapi    false    264            U           0    0    lessonlevels_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.lessonlevels_id_seq', 1, false);
          public          strapi    false    266            V           0    0    lessons_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_components_id_seq', 1, false);
          public          strapi    false    269            W           0    0    lessons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.lessons_id_seq', 1, true);
          public          strapi    false    270            X           0    0     lessons_lessonlevel_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.lessons_lessonlevel_links_id_seq', 1, false);
          public          strapi    false    272            Y           0    0 "   lessons_localizations_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.lessons_localizations_links_id_seq', 1, false);
          public          strapi    false    274            Z           0    0    lessons_unit_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_unit_links_id_seq', 1, false);
          public          strapi    false    276            [           0    0    review_tires_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.review_tires_id_seq', 5, true);
          public          strapi    false    355            \           0    0 '   review_tires_localizations_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.review_tires_localizations_links_id_seq', 1, false);
          public          strapi    false    357            ]           0    0 !   reviewlogs_flashcard_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.reviewlogs_flashcard_links_id_seq', 104, true);
          public          strapi    false    359            ^           0    0    reviewlogs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.reviewlogs_id_seq', 131, true);
          public          strapi    false    278            _           0    0    reviewlogs_user_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.reviewlogs_user_links_id_seq', 131, true);
          public          strapi    false    280            `           0    0    sections_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sections_components_id_seq', 2, true);
          public          strapi    false    283            a           0    0    sections_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sections_id_seq', 3, true);
          public          strapi    false    284            b           0    0    sections_lesson_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sections_lesson_links_id_seq', 3, true);
          public          strapi    false    286            c           0    0 #   sections_localizations_links_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sections_localizations_links_id_seq', 1, false);
          public          strapi    false    288            d           0    0    sentences_components_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sentences_components_id_seq', 1, false);
          public          strapi    false    291            e           0    0    sentences_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sentences_id_seq', 2, true);
          public          strapi    false    292            f           0    0 $   sentences_localizations_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    294            g           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);
          public          strapi    false    296            h           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    298            i           0    0    strapi_api_tokens_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);
          public          strapi    false    300            j           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 46, true);
          public          strapi    false    302            k           0    0    strapi_database_schema_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 53, true);
          public          strapi    false    304            l           0    0    strapi_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);
          public          strapi    false    306            m           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);
          public          strapi    false    308            n           0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    310            o           0    0    strapi_transfer_tokens_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);
          public          strapi    false    312            p           0    0    strapi_webhooks_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);
          public          strapi    false    314            q           0    0    units_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.units_id_seq', 2, true);
          public          strapi    false    316            r           0    0     units_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.units_localizations_links_id_seq', 1, false);
          public          strapi    false    318            s           0    0    units_precondition_links_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.units_precondition_links_id_seq', 2, true);
          public          strapi    false    320            t           0    0    up_permissions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.up_permissions_id_seq', 68, true);
          public          strapi    false    322            u           0    0     up_permissions_role_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 68, true);
          public          strapi    false    324            v           0    0    up_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);
          public          strapi    false    326            w           0    0    up_users_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.up_users_id_seq', 12, true);
          public          strapi    false    328            x           0    0    up_users_role_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 8, true);
          public          strapi    false    330            y           0    0    upload_folders_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);
          public          strapi    false    332            z           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);
          public          strapi    false    334            {           0    0    user_profiles_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.user_profiles_id_seq', 4, true);
          public          strapi    false    361            |           0    0    user_profiles_user_links_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.user_profiles_user_links_id_seq', 4, true);
          public          strapi    false    363            }           0    0    user_sentences_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.user_sentences_id_seq', 1, true);
          public          strapi    false    336            ~           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.user_sentences_lesson_links_id_seq', 1, true);
          public          strapi    false    338                       0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.user_sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    340            �           0    0     user_sentences_user_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.user_sentences_user_links_id_seq', 1, false);
          public          strapi    false    367            �           0    0    user_words_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.user_words_id_seq', 40, true);
          public          strapi    false    342            �           0    0    user_words_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.user_words_lesson_links_id_seq', 1, true);
          public          strapi    false    344            �           0    0 %   user_words_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.user_words_localizations_links_id_seq', 1, false);
          public          strapi    false    346            �           0    0    user_words_user_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.user_words_user_links_id_seq', 32, true);
          public          strapi    false    365            �           0    0    words_components_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.words_components_id_seq', 6, true);
          public          strapi    false    349            �           0    0 $   words_example_sentences_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.words_example_sentences_links_id_seq', 1, false);
          public          strapi    false    351            �           0    0    words_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.words_id_seq', 3, true);
          public          strapi    false    352            �           0    0     words_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.words_localizations_links_id_seq', 1, false);
          public          strapi    false    354            �           2606    59334 (   admin_permissions admin_permissions_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_pkey;
       public            strapi    false    209            �           2606    59336 >   admin_permissions_role_links admin_permissions_role_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_pkey;
       public            strapi    false    211            �           2606    59338 @   admin_permissions_role_links admin_permissions_role_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_unique UNIQUE (permission_id, role_id);
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_unique;
       public            strapi    false    211    211            �           2606    59340    admin_roles admin_roles_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_pkey;
       public            strapi    false    213            �           2606    59342    admin_users admin_users_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_pkey;
       public            strapi    false    215            �           2606    59344 4   admin_users_roles_links admin_users_roles_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_pkey;
       public            strapi    false    217            �           2606    59346 6   admin_users_roles_links admin_users_roles_links_unique 
   CONSTRAINT     }   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_unique UNIQUE (user_id, role_id);
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_unique;
       public            strapi    false    217    217            �           2606    59348 >   components_a_external_videos components_a_external_videos_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.components_a_external_videos
    ADD CONSTRAINT components_a_external_videos_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.components_a_external_videos DROP CONSTRAINT components_a_external_videos_pkey;
       public            strapi    false    219            �           2606    59350 8   components_a_pagebreakers components_a_pagebreakers_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.components_a_pagebreakers
    ADD CONSTRAINT components_a_pagebreakers_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.components_a_pagebreakers DROP CONSTRAINT components_a_pagebreakers_pkey;
       public            strapi    false    221            �           2606    59352 .   components_a_quizzes components_a_quizzes_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.components_a_quizzes
    ADD CONSTRAINT components_a_quizzes_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.components_a_quizzes DROP CONSTRAINT components_a_quizzes_pkey;
       public            strapi    false    223            �           2606    59354 2   components_a_sent_refs components_a_sent_refs_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.components_a_sent_refs
    ADD CONSTRAINT components_a_sent_refs_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.components_a_sent_refs DROP CONSTRAINT components_a_sent_refs_pkey;
       public            strapi    false    225            �           2606    59356 P   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_pkey;
       public            strapi    false    227            �           2606    59358 R   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_unique UNIQUE (sent_ref_id, sentence_id);
 |   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_unique;
       public            strapi    false    227    227            �           2606    59360 0   components_a_taglists components_a_taglists_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.components_a_taglists
    ADD CONSTRAINT components_a_taglists_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.components_a_taglists DROP CONSTRAINT components_a_taglists_pkey;
       public            strapi    false    229            �           2606    59362 <   components_a_user_sent_refs components_a_user_sent_refs_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.components_a_user_sent_refs
    ADD CONSTRAINT components_a_user_sent_refs_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.components_a_user_sent_refs DROP CONSTRAINT components_a_user_sent_refs_pkey;
       public            strapi    false    231            �           2606    59364 d   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_pkey;
       public            strapi    false    233            �           2606    59366 f   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_unique UNIQUE (user_sent_ref_id, user_sentence_id);
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_unique;
       public            strapi    false    233    233            �           2606    59368 <   components_a_user_word_refs components_a_user_word_refs_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.components_a_user_word_refs
    ADD CONSTRAINT components_a_user_word_refs_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.components_a_user_word_refs DROP CONSTRAINT components_a_user_word_refs_pkey;
       public            strapi    false    235            �           2606    59370 \   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_pkey;
       public            strapi    false    237            �           2606    59372 ^   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_unique UNIQUE (user_word_ref_id, user_word_id);
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_unique;
       public            strapi    false    237    237            �           2606    59374 4   components_a_verb_metas components_a_verb_metas_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.components_a_verb_metas
    ADD CONSTRAINT components_a_verb_metas_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.components_a_verb_metas DROP CONSTRAINT components_a_verb_metas_pkey;
       public            strapi    false    239            �           2606    59376 ,   components_a_videos components_a_videos_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.components_a_videos
    ADD CONSTRAINT components_a_videos_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.components_a_videos DROP CONSTRAINT components_a_videos_pkey;
       public            strapi    false    241            �           2606    59378 2   components_a_word_refs components_a_word_refs_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.components_a_word_refs
    ADD CONSTRAINT components_a_word_refs_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.components_a_word_refs DROP CONSTRAINT components_a_word_refs_pkey;
       public            strapi    false    243            �           2606    59380 H   components_a_word_refs_word_links components_a_word_refs_word_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_pkey;
       public            strapi    false    245            �           2606    59382 J   components_a_word_refs_word_links components_a_word_refs_word_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_unique UNIQUE (word_ref_id, word_id);
 t   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_unique;
       public            strapi    false    245    245            �           2606    59384 *   files_folder_links files_folder_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_pkey;
       public            strapi    false    248            �           2606    59386 ,   files_folder_links files_folder_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_unique;
       public            strapi    false    248    248            �           2606    59388    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            strapi    false    247            �           2606    59390 .   files_related_morphs files_related_morphs_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_pkey;
       public            strapi    false    251            �           2606    59392 0   flashcards_components flashcards_components_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_components_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_components_pkey;
       public            strapi    false    254            �           2606    59394 4   flashcards_lesson_links flashcards_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_pkey;
       public            strapi    false    257                        2606    59396 6   flashcards_lesson_links flashcards_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_unique UNIQUE (flashcard_id, lesson_id);
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_unique;
       public            strapi    false    257    257                       2606    59398 B   flashcards_localizations_links flashcards_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_pkey;
       public            strapi    false    259                       2606    59400 D   flashcards_localizations_links flashcards_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_unique UNIQUE (flashcard_id, inv_flashcard_id);
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_unique;
       public            strapi    false    259    259            �           2606    59402    flashcards flashcards_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_pkey;
       public            strapi    false    253            �           2606    60691 '   flashcards_components flashcards_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_unique UNIQUE (entity_id, component_id, field, component_type);
 Q   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_unique;
       public            strapi    false    254    254    254    254                       2606    59406 0   flashcards_user_links flashcards_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_pkey;
       public            strapi    false    261                       2606    59408 2   flashcards_user_links flashcards_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_unique UNIQUE (flashcard_id, user_id);
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_unique;
       public            strapi    false    261    261                       2606    59410    i18n_locale i18n_locale_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_pkey;
       public            strapi    false    263                       2606    59412    lessonlevels lessonlevels_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_pkey;
       public            strapi    false    265                       2606    59414 *   lessons_components lessons_components_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_components_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_components_pkey;
       public            strapi    false    268            (           2606    59416 8   lessons_lessonlevel_links lessons_lessonlevel_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_pkey;
       public            strapi    false    271            *           2606    59418 :   lessons_lessonlevel_links lessons_lessonlevel_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_unique UNIQUE (lesson_id, lessonlevel_id);
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_unique;
       public            strapi    false    271    271            /           2606    59420 <   lessons_localizations_links lessons_localizations_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_pkey;
       public            strapi    false    273            1           2606    59422 >   lessons_localizations_links lessons_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_unique UNIQUE (lesson_id, inv_lesson_id);
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_unique;
       public            strapi    false    273    273                       2606    59424    lessons lessons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_pkey;
       public            strapi    false    267                       2606    59426    lessons lessons_slug_unique 
   CONSTRAINT     V   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_unique UNIQUE (slug);
 E   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_slug_unique;
       public            strapi    false    267            #           2606    60693 !   lessons_components lessons_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_unique UNIQUE (entity_id, component_id, field, component_type);
 K   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_unique;
       public            strapi    false    268    268    268    268            6           2606    59430 *   lessons_unit_links lessons_unit_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_pkey;
       public            strapi    false    275            8           2606    59432 ,   lessons_unit_links lessons_unit_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_unique UNIQUE (lesson_id, unit_id);
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_unique;
       public            strapi    false    275    275                       2606    60343 F   review_tires_localizations_links review_tires_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_pkey;
       public            strapi    false    358                       2606    60347 H   review_tires_localizations_links review_tires_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_unique UNIQUE (review_tire_id, inv_review_tire_id);
 r   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_unique;
       public            strapi    false    358    358                       2606    60334    review_tires review_tires_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_pkey;
       public            strapi    false    356                       2606    60401 :   reviewlogs_flashcard_links reviewlogs_flashcard_links_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_pkey;
       public            strapi    false    360                        2606    60405 <   reviewlogs_flashcard_links reviewlogs_flashcard_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_unique UNIQUE (reviewlog_id, flashcard_id);
 f   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_unique;
       public            strapi    false    360    360            ;           2606    59434    reviewlogs reviewlogs_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_pkey;
       public            strapi    false    277            A           2606    59436 0   reviewlogs_user_links reviewlogs_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_pkey;
       public            strapi    false    279            C           2606    59438 2   reviewlogs_user_links reviewlogs_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_unique UNIQUE (reviewlog_id, user_id);
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_unique;
       public            strapi    false    279    279            J           2606    59440 ,   sections_components sections_components_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_components_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_components_pkey;
       public            strapi    false    282            S           2606    59442 0   sections_lesson_links sections_lesson_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_pkey;
       public            strapi    false    285            U           2606    59444 2   sections_lesson_links sections_lesson_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_unique UNIQUE (section_id, lesson_id);
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_unique;
       public            strapi    false    285    285            Z           2606    59446 >   sections_localizations_links sections_localizations_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_pkey;
       public            strapi    false    287            \           2606    59448 @   sections_localizations_links sections_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_unique UNIQUE (section_id, inv_section_id);
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_unique;
       public            strapi    false    287    287            F           2606    59450    sections sections_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_pkey;
       public            strapi    false    281            N           2606    60695 #   sections_components sections_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_unique UNIQUE (entity_id, component_id, field, component_type);
 M   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_unique;
       public            strapi    false    282    282    282    282            c           2606    59454 .   sentences_components sentences_components_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_components_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_components_pkey;
       public            strapi    false    290            l           2606    59456 @   sentences_localizations_links sentences_localizations_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_pkey;
       public            strapi    false    293            n           2606    59458 B   sentences_localizations_links sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_unique UNIQUE (sentence_id, inv_sentence_id);
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_unique;
       public            strapi    false    293    293            _           2606    59460    sentences sentences_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_pkey;
       public            strapi    false    289            g           2606    60697 %   sentences_components sentences_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_unique UNIQUE (entity_id, component_id, field, component_type);
 O   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_unique;
       public            strapi    false    290    290    290    290            q           2606    59464 >   strapi_api_token_permissions strapi_api_token_permissions_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_pkey;
       public            strapi    false    295            w           2606    59466 V   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_pkey;
       public            strapi    false    297            y           2606    59468 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_unique;
       public            strapi    false    297    297            |           2606    59470 (   strapi_api_tokens strapi_api_tokens_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_pkey;
       public            strapi    false    299                       2606    59472 :   strapi_core_store_settings strapi_core_store_settings_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.strapi_core_store_settings DROP CONSTRAINT strapi_core_store_settings_pkey;
       public            strapi    false    301            �           2606    59474 2   strapi_database_schema strapi_database_schema_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_database_schema DROP CONSTRAINT strapi_database_schema_pkey;
       public            strapi    false    303            �           2606    59476 (   strapi_migrations strapi_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_migrations DROP CONSTRAINT strapi_migrations_pkey;
       public            strapi    false    305            �           2606    59478 H   strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_pkey;
       public            strapi    false    307            �           2606    59480 `   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_pkey;
       public            strapi    false    309            �           2606    59482 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_unique UNIQUE (transfer_token_permission_id, transfer_token_id);
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_unique;
       public            strapi    false    309    309            �           2606    59484 2   strapi_transfer_tokens strapi_transfer_tokens_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_pkey;
       public            strapi    false    311            �           2606    59486 $   strapi_webhooks strapi_webhooks_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.strapi_webhooks DROP CONSTRAINT strapi_webhooks_pkey;
       public            strapi    false    313            �           2606    59488 8   units_localizations_links units_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_pkey;
       public            strapi    false    317            �           2606    59490 :   units_localizations_links units_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_unique UNIQUE (unit_id, inv_unit_id);
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_unique;
       public            strapi    false    317    317            �           2606    59492    units units_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.units DROP CONSTRAINT units_pkey;
       public            strapi    false    315            �           2606    59494 6   units_precondition_links units_precondition_links_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_pkey;
       public            strapi    false    319            �           2606    59496 8   units_precondition_links units_precondition_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_unique UNIQUE (unit_id, inv_unit_id);
 b   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_unique;
       public            strapi    false    319    319            �           2606    59498    units units_slug_unique 
   CONSTRAINT     R   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_slug_unique UNIQUE (slug);
 A   ALTER TABLE ONLY public.units DROP CONSTRAINT units_slug_unique;
       public            strapi    false    315            �           2606    59500 "   up_permissions up_permissions_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_pkey;
       public            strapi    false    321            �           2606    59502 8   up_permissions_role_links up_permissions_role_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_pkey;
       public            strapi    false    323            �           2606    59504 :   up_permissions_role_links up_permissions_role_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_unique UNIQUE (permission_id, role_id);
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_unique;
       public            strapi    false    323    323            �           2606    59506    up_roles up_roles_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_pkey;
       public            strapi    false    325            �           2606    59508    up_users up_users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_pkey;
       public            strapi    false    327            �           2606    59510 ,   up_users_role_links up_users_role_links_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_pkey;
       public            strapi    false    329            �           2606    59512 .   up_users_role_links up_users_role_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_unique UNIQUE (user_id, role_id);
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_unique;
       public            strapi    false    329    329            �           2606    59514 <   upload_folders_parent_links upload_folders_parent_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_pkey;
       public            strapi    false    333            �           2606    59516 >   upload_folders_parent_links upload_folders_parent_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_unique UNIQUE (folder_id, inv_folder_id);
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_unique;
       public            strapi    false    333    333            �           2606    59518 +   upload_folders upload_folders_path_id_index 
   CONSTRAINT     i   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);
 U   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_path_id_index;
       public            strapi    false    331            �           2606    59520 (   upload_folders upload_folders_path_index 
   CONSTRAINT     c   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);
 R   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_path_index;
       public            strapi    false    331            �           2606    59522 "   upload_folders upload_folders_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_pkey;
       public            strapi    false    331            #           2606    60474     user_profiles user_profiles_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.user_profiles DROP CONSTRAINT user_profiles_pkey;
       public            strapi    false    362            (           2606    60483 6   user_profiles_user_links user_profiles_user_links_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_pkey;
       public            strapi    false    364            *           2606    60487 8   user_profiles_user_links user_profiles_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_unique UNIQUE (user_profile_id, user_id);
 b   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_unique;
       public            strapi    false    364    364            �           2606    59524 <   user_sentences_lesson_links user_sentences_lesson_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_pkey;
       public            strapi    false    337            �           2606    59526 >   user_sentences_lesson_links user_sentences_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_unique UNIQUE (user_sentence_id, lesson_id);
 h   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_unique;
       public            strapi    false    337    337            �           2606    59528 J   user_sentences_localizations_links user_sentences_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_pkey;
       public            strapi    false    339            �           2606    59530 L   user_sentences_localizations_links user_sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_unique UNIQUE (user_sentence_id, inv_user_sentence_id);
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_unique;
       public            strapi    false    339    339            �           2606    59532 "   user_sentences user_sentences_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_pkey;
       public            strapi    false    335            6           2606    60640 8   user_sentences_user_links user_sentences_user_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_pkey;
       public            strapi    false    368            8           2606    60644 :   user_sentences_user_links user_sentences_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_unique UNIQUE (user_sentence_id, user_id);
 d   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_unique;
       public            strapi    false    368    368            �           2606    59538 4   user_words_lesson_links user_words_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_pkey;
       public            strapi    false    343            �           2606    59540 6   user_words_lesson_links user_words_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_unique UNIQUE (user_word_id, lesson_id);
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_unique;
       public            strapi    false    343    343            �           2606    59542 B   user_words_localizations_links user_words_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_pkey;
       public            strapi    false    345            �           2606    59544 D   user_words_localizations_links user_words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_unique UNIQUE (user_word_id, inv_user_word_id);
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_unique;
       public            strapi    false    345    345            �           2606    59546    user_words user_words_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_pkey;
       public            strapi    false    341            /           2606    60605 0   user_words_user_links user_words_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_pkey;
       public            strapi    false    366            1           2606    60609 2   user_words_user_links user_words_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_unique UNIQUE (user_word_id, user_id);
 \   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_unique;
       public            strapi    false    366    366            �           2606    59552 &   words_components words_components_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_components_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_components_pkey;
       public            strapi    false    348                       2606    59554 @   words_example_sentences_links words_example_sentences_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_pkey;
       public            strapi    false    350                       2606    59556 B   words_example_sentences_links words_example_sentences_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_unique UNIQUE (word_id, sentence_id);
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_unique;
       public            strapi    false    350    350                       2606    59558 8   words_localizations_links words_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_pkey;
       public            strapi    false    353                       2606    59560 :   words_localizations_links words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_unique UNIQUE (word_id, inv_word_id);
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_unique;
       public            strapi    false    353    353            �           2606    59562    words words_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.words DROP CONSTRAINT words_pkey;
       public            strapi    false    347            �           2606    60699    words_components words_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_unique UNIQUE (entity_id, component_id, field, component_type);
 G   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_unique;
       public            strapi    false    348    348    348    348            �           1259    59565 "   admin_permissions_created_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);
 6   DROP INDEX public.admin_permissions_created_by_id_fk;
       public            strapi    false    209            �           1259    59566    admin_permissions_role_links_fk    INDEX     q   CREATE INDEX admin_permissions_role_links_fk ON public.admin_permissions_role_links USING btree (permission_id);
 3   DROP INDEX public.admin_permissions_role_links_fk;
       public            strapi    false    211            �           1259    59567 #   admin_permissions_role_links_inv_fk    INDEX     o   CREATE INDEX admin_permissions_role_links_inv_fk ON public.admin_permissions_role_links USING btree (role_id);
 7   DROP INDEX public.admin_permissions_role_links_inv_fk;
       public            strapi    false    211            �           1259    59568 )   admin_permissions_role_links_order_inv_fk    INDEX     ~   CREATE INDEX admin_permissions_role_links_order_inv_fk ON public.admin_permissions_role_links USING btree (permission_order);
 =   DROP INDEX public.admin_permissions_role_links_order_inv_fk;
       public            strapi    false    211            �           1259    59569 "   admin_permissions_updated_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);
 6   DROP INDEX public.admin_permissions_updated_by_id_fk;
       public            strapi    false    209            �           1259    59570    admin_roles_created_by_id_fk    INDEX     ]   CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);
 0   DROP INDEX public.admin_roles_created_by_id_fk;
       public            strapi    false    213            �           1259    59571    admin_roles_updated_by_id_fk    INDEX     ]   CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);
 0   DROP INDEX public.admin_roles_updated_by_id_fk;
       public            strapi    false    213            �           1259    59572    admin_users_created_by_id_fk    INDEX     ]   CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);
 0   DROP INDEX public.admin_users_created_by_id_fk;
       public            strapi    false    215            �           1259    59573    admin_users_roles_links_fk    INDEX     a   CREATE INDEX admin_users_roles_links_fk ON public.admin_users_roles_links USING btree (user_id);
 .   DROP INDEX public.admin_users_roles_links_fk;
       public            strapi    false    217            �           1259    59574    admin_users_roles_links_inv_fk    INDEX     e   CREATE INDEX admin_users_roles_links_inv_fk ON public.admin_users_roles_links USING btree (role_id);
 2   DROP INDEX public.admin_users_roles_links_inv_fk;
       public            strapi    false    217            �           1259    59575     admin_users_roles_links_order_fk    INDEX     j   CREATE INDEX admin_users_roles_links_order_fk ON public.admin_users_roles_links USING btree (role_order);
 4   DROP INDEX public.admin_users_roles_links_order_fk;
       public            strapi    false    217            �           1259    59576 $   admin_users_roles_links_order_inv_fk    INDEX     n   CREATE INDEX admin_users_roles_links_order_inv_fk ON public.admin_users_roles_links USING btree (user_order);
 8   DROP INDEX public.admin_users_roles_links_order_inv_fk;
       public            strapi    false    217            �           1259    59577    admin_users_updated_by_id_fk    INDEX     ]   CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);
 0   DROP INDEX public.admin_users_updated_by_id_fk;
       public            strapi    false    215            �           1259    59578 (   components_a_sent_refs_sentence_links_fk    INDEX     �   CREATE INDEX components_a_sent_refs_sentence_links_fk ON public.components_a_sent_refs_sentence_links USING btree (sent_ref_id);
 <   DROP INDEX public.components_a_sent_refs_sentence_links_fk;
       public            strapi    false    227            �           1259    59579 ,   components_a_sent_refs_sentence_links_inv_fk    INDEX     �   CREATE INDEX components_a_sent_refs_sentence_links_inv_fk ON public.components_a_sent_refs_sentence_links USING btree (sentence_id);
 @   DROP INDEX public.components_a_sent_refs_sentence_links_inv_fk;
       public            strapi    false    227            �           1259    59580 2   components_a_user_sent_refs_user_sentence_links_fk    INDEX     �   CREATE INDEX components_a_user_sent_refs_user_sentence_links_fk ON public.components_a_user_sent_refs_user_sentence_links USING btree (user_sent_ref_id);
 F   DROP INDEX public.components_a_user_sent_refs_user_sentence_links_fk;
       public            strapi    false    233            �           1259    59581 6   components_a_user_sent_refs_user_sentence_links_inv_fk    INDEX     �   CREATE INDEX components_a_user_sent_refs_user_sentence_links_inv_fk ON public.components_a_user_sent_refs_user_sentence_links USING btree (user_sentence_id);
 J   DROP INDEX public.components_a_user_sent_refs_user_sentence_links_inv_fk;
       public            strapi    false    233            �           1259    59582 .   components_a_user_word_refs_user_word_links_fk    INDEX     �   CREATE INDEX components_a_user_word_refs_user_word_links_fk ON public.components_a_user_word_refs_user_word_links USING btree (user_word_ref_id);
 B   DROP INDEX public.components_a_user_word_refs_user_word_links_fk;
       public            strapi    false    237            �           1259    59583 2   components_a_user_word_refs_user_word_links_inv_fk    INDEX     �   CREATE INDEX components_a_user_word_refs_user_word_links_inv_fk ON public.components_a_user_word_refs_user_word_links USING btree (user_word_id);
 F   DROP INDEX public.components_a_user_word_refs_user_word_links_inv_fk;
       public            strapi    false    237            �           1259    59584 $   components_a_word_refs_word_links_fk    INDEX     y   CREATE INDEX components_a_word_refs_word_links_fk ON public.components_a_word_refs_word_links USING btree (word_ref_id);
 8   DROP INDEX public.components_a_word_refs_word_links_fk;
       public            strapi    false    245            �           1259    59585 (   components_a_word_refs_word_links_inv_fk    INDEX     y   CREATE INDEX components_a_word_refs_word_links_inv_fk ON public.components_a_word_refs_word_links USING btree (word_id);
 <   DROP INDEX public.components_a_word_refs_word_links_inv_fk;
       public            strapi    false    245            �           1259    59586    files_created_by_id_fk    INDEX     Q   CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);
 *   DROP INDEX public.files_created_by_id_fk;
       public            strapi    false    247            �           1259    59587    files_folder_links_fk    INDEX     W   CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);
 )   DROP INDEX public.files_folder_links_fk;
       public            strapi    false    248            �           1259    59588    files_folder_links_inv_fk    INDEX     ]   CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);
 -   DROP INDEX public.files_folder_links_inv_fk;
       public            strapi    false    248            �           1259    59589    files_folder_links_order_inv_fk    INDEX     d   CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);
 3   DROP INDEX public.files_folder_links_order_inv_fk;
       public            strapi    false    248            �           1259    59590    files_related_morphs_fk    INDEX     [   CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);
 +   DROP INDEX public.files_related_morphs_fk;
       public            strapi    false    251            �           1259    59591 $   files_related_morphs_id_column_index    INDEX     k   CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);
 8   DROP INDEX public.files_related_morphs_id_column_index;
       public            strapi    false    251            �           1259    59592     files_related_morphs_order_index    INDEX     d   CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");
 4   DROP INDEX public.files_related_morphs_order_index;
       public            strapi    false    251            �           1259    59593    files_updated_by_id_fk    INDEX     Q   CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);
 *   DROP INDEX public.files_updated_by_id_fk;
       public            strapi    false    247            �           1259    59594    flashcards_component_type_index    INDEX     k   CREATE INDEX flashcards_component_type_index ON public.flashcards_components USING btree (component_type);
 3   DROP INDEX public.flashcards_component_type_index;
       public            strapi    false    254            �           1259    59595    flashcards_created_by_id_fk    INDEX     [   CREATE INDEX flashcards_created_by_id_fk ON public.flashcards USING btree (created_by_id);
 /   DROP INDEX public.flashcards_created_by_id_fk;
       public            strapi    false    253            �           1259    59596    flashcards_entity_fk    INDEX     [   CREATE INDEX flashcards_entity_fk ON public.flashcards_components USING btree (entity_id);
 (   DROP INDEX public.flashcards_entity_fk;
       public            strapi    false    254            �           1259    59597    flashcards_field_index    INDEX     Y   CREATE INDEX flashcards_field_index ON public.flashcards_components USING btree (field);
 *   DROP INDEX public.flashcards_field_index;
       public            strapi    false    254            �           1259    59598    flashcards_lesson_links_fk    INDEX     f   CREATE INDEX flashcards_lesson_links_fk ON public.flashcards_lesson_links USING btree (flashcard_id);
 .   DROP INDEX public.flashcards_lesson_links_fk;
       public            strapi    false    257            �           1259    59599    flashcards_lesson_links_inv_fk    INDEX     g   CREATE INDEX flashcards_lesson_links_inv_fk ON public.flashcards_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.flashcards_lesson_links_inv_fk;
       public            strapi    false    257            �           1259    59600 $   flashcards_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX flashcards_lesson_links_order_inv_fk ON public.flashcards_lesson_links USING btree (flashcard_order);
 8   DROP INDEX public.flashcards_lesson_links_order_inv_fk;
       public            strapi    false    257                       1259    59601 !   flashcards_localizations_links_fk    INDEX     t   CREATE INDEX flashcards_localizations_links_fk ON public.flashcards_localizations_links USING btree (flashcard_id);
 5   DROP INDEX public.flashcards_localizations_links_fk;
       public            strapi    false    259                       1259    59602 %   flashcards_localizations_links_inv_fk    INDEX     |   CREATE INDEX flashcards_localizations_links_inv_fk ON public.flashcards_localizations_links USING btree (inv_flashcard_id);
 9   DROP INDEX public.flashcards_localizations_links_inv_fk;
       public            strapi    false    259                       1259    59603 '   flashcards_localizations_links_order_fk    INDEX     }   CREATE INDEX flashcards_localizations_links_order_fk ON public.flashcards_localizations_links USING btree (flashcard_order);
 ;   DROP INDEX public.flashcards_localizations_links_order_fk;
       public            strapi    false    259            �           1259    59604    flashcards_updated_by_id_fk    INDEX     [   CREATE INDEX flashcards_updated_by_id_fk ON public.flashcards USING btree (updated_by_id);
 /   DROP INDEX public.flashcards_updated_by_id_fk;
       public            strapi    false    253                       1259    59605    flashcards_user_links_fk    INDEX     b   CREATE INDEX flashcards_user_links_fk ON public.flashcards_user_links USING btree (flashcard_id);
 ,   DROP INDEX public.flashcards_user_links_fk;
       public            strapi    false    261            	           1259    59606    flashcards_user_links_inv_fk    INDEX     a   CREATE INDEX flashcards_user_links_inv_fk ON public.flashcards_user_links USING btree (user_id);
 0   DROP INDEX public.flashcards_user_links_inv_fk;
       public            strapi    false    261            
           1259    59607 "   flashcards_user_links_order_inv_fk    INDEX     o   CREATE INDEX flashcards_user_links_order_inv_fk ON public.flashcards_user_links USING btree (flashcard_order);
 6   DROP INDEX public.flashcards_user_links_order_inv_fk;
       public            strapi    false    261                       1259    59608    i18n_locale_created_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);
 0   DROP INDEX public.i18n_locale_created_by_id_fk;
       public            strapi    false    263                       1259    59609    i18n_locale_updated_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);
 0   DROP INDEX public.i18n_locale_updated_by_id_fk;
       public            strapi    false    263                       1259    59610    lessonlevels_created_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_created_by_id_fk ON public.lessonlevels USING btree (created_by_id);
 1   DROP INDEX public.lessonlevels_created_by_id_fk;
       public            strapi    false    265                       1259    59611    lessonlevels_updated_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_updated_by_id_fk ON public.lessonlevels USING btree (updated_by_id);
 1   DROP INDEX public.lessonlevels_updated_by_id_fk;
       public            strapi    false    265                       1259    59612    lessons_component_type_index    INDEX     e   CREATE INDEX lessons_component_type_index ON public.lessons_components USING btree (component_type);
 0   DROP INDEX public.lessons_component_type_index;
       public            strapi    false    268                       1259    59613    lessons_created_by_id_fk    INDEX     U   CREATE INDEX lessons_created_by_id_fk ON public.lessons USING btree (created_by_id);
 ,   DROP INDEX public.lessons_created_by_id_fk;
       public            strapi    false    267                        1259    59614    lessons_entity_fk    INDEX     U   CREATE INDEX lessons_entity_fk ON public.lessons_components USING btree (entity_id);
 %   DROP INDEX public.lessons_entity_fk;
       public            strapi    false    268            !           1259    59615    lessons_field_index    INDEX     S   CREATE INDEX lessons_field_index ON public.lessons_components USING btree (field);
 '   DROP INDEX public.lessons_field_index;
       public            strapi    false    268            $           1259    59616    lessons_lessonlevel_links_fk    INDEX     g   CREATE INDEX lessons_lessonlevel_links_fk ON public.lessons_lessonlevel_links USING btree (lesson_id);
 0   DROP INDEX public.lessons_lessonlevel_links_fk;
       public            strapi    false    271            %           1259    59617     lessons_lessonlevel_links_inv_fk    INDEX     p   CREATE INDEX lessons_lessonlevel_links_inv_fk ON public.lessons_lessonlevel_links USING btree (lessonlevel_id);
 4   DROP INDEX public.lessons_lessonlevel_links_inv_fk;
       public            strapi    false    271            &           1259    59618 &   lessons_lessonlevel_links_order_inv_fk    INDEX     t   CREATE INDEX lessons_lessonlevel_links_order_inv_fk ON public.lessons_lessonlevel_links USING btree (lesson_order);
 :   DROP INDEX public.lessons_lessonlevel_links_order_inv_fk;
       public            strapi    false    271            +           1259    59619    lessons_localizations_links_fk    INDEX     k   CREATE INDEX lessons_localizations_links_fk ON public.lessons_localizations_links USING btree (lesson_id);
 2   DROP INDEX public.lessons_localizations_links_fk;
       public            strapi    false    273            ,           1259    59620 "   lessons_localizations_links_inv_fk    INDEX     s   CREATE INDEX lessons_localizations_links_inv_fk ON public.lessons_localizations_links USING btree (inv_lesson_id);
 6   DROP INDEX public.lessons_localizations_links_inv_fk;
       public            strapi    false    273            -           1259    59621 $   lessons_localizations_links_order_fk    INDEX     t   CREATE INDEX lessons_localizations_links_order_fk ON public.lessons_localizations_links USING btree (lesson_order);
 8   DROP INDEX public.lessons_localizations_links_order_fk;
       public            strapi    false    273            2           1259    59622    lessons_unit_links_fk    INDEX     Y   CREATE INDEX lessons_unit_links_fk ON public.lessons_unit_links USING btree (lesson_id);
 )   DROP INDEX public.lessons_unit_links_fk;
       public            strapi    false    275            3           1259    59623    lessons_unit_links_inv_fk    INDEX     [   CREATE INDEX lessons_unit_links_inv_fk ON public.lessons_unit_links USING btree (unit_id);
 -   DROP INDEX public.lessons_unit_links_inv_fk;
       public            strapi    false    275            4           1259    59624    lessons_unit_links_order_inv_fk    INDEX     f   CREATE INDEX lessons_unit_links_order_inv_fk ON public.lessons_unit_links USING btree (lesson_order);
 3   DROP INDEX public.lessons_unit_links_order_inv_fk;
       public            strapi    false    275                       1259    59625    lessons_updated_by_id_fk    INDEX     U   CREATE INDEX lessons_updated_by_id_fk ON public.lessons USING btree (updated_by_id);
 ,   DROP INDEX public.lessons_updated_by_id_fk;
       public            strapi    false    267                       1259    60335    review_tires_created_by_id_fk    INDEX     _   CREATE INDEX review_tires_created_by_id_fk ON public.review_tires USING btree (created_by_id);
 1   DROP INDEX public.review_tires_created_by_id_fk;
       public            strapi    false    356                       1259    60344 #   review_tires_localizations_links_fk    INDEX     z   CREATE INDEX review_tires_localizations_links_fk ON public.review_tires_localizations_links USING btree (review_tire_id);
 7   DROP INDEX public.review_tires_localizations_links_fk;
       public            strapi    false    358                       1259    60345 '   review_tires_localizations_links_inv_fk    INDEX     �   CREATE INDEX review_tires_localizations_links_inv_fk ON public.review_tires_localizations_links USING btree (inv_review_tire_id);
 ;   DROP INDEX public.review_tires_localizations_links_inv_fk;
       public            strapi    false    358                       1259    60348 )   review_tires_localizations_links_order_fk    INDEX     �   CREATE INDEX review_tires_localizations_links_order_fk ON public.review_tires_localizations_links USING btree (review_tire_order);
 =   DROP INDEX public.review_tires_localizations_links_order_fk;
       public            strapi    false    358                       1259    60336    review_tires_updated_by_id_fk    INDEX     _   CREATE INDEX review_tires_updated_by_id_fk ON public.review_tires USING btree (updated_by_id);
 1   DROP INDEX public.review_tires_updated_by_id_fk;
       public            strapi    false    356            9           1259    59626    reviewlogs_created_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_created_by_id_fk ON public.reviewlogs USING btree (created_by_id);
 /   DROP INDEX public.reviewlogs_created_by_id_fk;
       public            strapi    false    277                       1259    60402    reviewlogs_flashcard_links_fk    INDEX     l   CREATE INDEX reviewlogs_flashcard_links_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_id);
 1   DROP INDEX public.reviewlogs_flashcard_links_fk;
       public            strapi    false    360                       1259    60403 !   reviewlogs_flashcard_links_inv_fk    INDEX     p   CREATE INDEX reviewlogs_flashcard_links_inv_fk ON public.reviewlogs_flashcard_links USING btree (flashcard_id);
 5   DROP INDEX public.reviewlogs_flashcard_links_inv_fk;
       public            strapi    false    360                       1259    60406 '   reviewlogs_flashcard_links_order_inv_fk    INDEX     y   CREATE INDEX reviewlogs_flashcard_links_order_inv_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_order);
 ;   DROP INDEX public.reviewlogs_flashcard_links_order_inv_fk;
       public            strapi    false    360            <           1259    59627    reviewlogs_updated_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_updated_by_id_fk ON public.reviewlogs USING btree (updated_by_id);
 /   DROP INDEX public.reviewlogs_updated_by_id_fk;
       public            strapi    false    277            =           1259    59628    reviewlogs_user_links_fk    INDEX     b   CREATE INDEX reviewlogs_user_links_fk ON public.reviewlogs_user_links USING btree (reviewlog_id);
 ,   DROP INDEX public.reviewlogs_user_links_fk;
       public            strapi    false    279            >           1259    59629    reviewlogs_user_links_inv_fk    INDEX     a   CREATE INDEX reviewlogs_user_links_inv_fk ON public.reviewlogs_user_links USING btree (user_id);
 0   DROP INDEX public.reviewlogs_user_links_inv_fk;
       public            strapi    false    279            ?           1259    59630 "   reviewlogs_user_links_order_inv_fk    INDEX     o   CREATE INDEX reviewlogs_user_links_order_inv_fk ON public.reviewlogs_user_links USING btree (reviewlog_order);
 6   DROP INDEX public.reviewlogs_user_links_order_inv_fk;
       public            strapi    false    279            H           1259    59631    sections_component_type_index    INDEX     g   CREATE INDEX sections_component_type_index ON public.sections_components USING btree (component_type);
 1   DROP INDEX public.sections_component_type_index;
       public            strapi    false    282            D           1259    59632    sections_created_by_id_fk    INDEX     W   CREATE INDEX sections_created_by_id_fk ON public.sections USING btree (created_by_id);
 -   DROP INDEX public.sections_created_by_id_fk;
       public            strapi    false    281            K           1259    59633    sections_entity_fk    INDEX     W   CREATE INDEX sections_entity_fk ON public.sections_components USING btree (entity_id);
 &   DROP INDEX public.sections_entity_fk;
       public            strapi    false    282            L           1259    59634    sections_field_index    INDEX     U   CREATE INDEX sections_field_index ON public.sections_components USING btree (field);
 (   DROP INDEX public.sections_field_index;
       public            strapi    false    282            O           1259    59635    sections_lesson_links_fk    INDEX     `   CREATE INDEX sections_lesson_links_fk ON public.sections_lesson_links USING btree (section_id);
 ,   DROP INDEX public.sections_lesson_links_fk;
       public            strapi    false    285            P           1259    59636    sections_lesson_links_inv_fk    INDEX     c   CREATE INDEX sections_lesson_links_inv_fk ON public.sections_lesson_links USING btree (lesson_id);
 0   DROP INDEX public.sections_lesson_links_inv_fk;
       public            strapi    false    285            Q           1259    59637 "   sections_lesson_links_order_inv_fk    INDEX     m   CREATE INDEX sections_lesson_links_order_inv_fk ON public.sections_lesson_links USING btree (section_order);
 6   DROP INDEX public.sections_lesson_links_order_inv_fk;
       public            strapi    false    285            V           1259    59638    sections_localizations_links_fk    INDEX     n   CREATE INDEX sections_localizations_links_fk ON public.sections_localizations_links USING btree (section_id);
 3   DROP INDEX public.sections_localizations_links_fk;
       public            strapi    false    287            W           1259    59639 #   sections_localizations_links_inv_fk    INDEX     v   CREATE INDEX sections_localizations_links_inv_fk ON public.sections_localizations_links USING btree (inv_section_id);
 7   DROP INDEX public.sections_localizations_links_inv_fk;
       public            strapi    false    287            X           1259    59640 %   sections_localizations_links_order_fk    INDEX     w   CREATE INDEX sections_localizations_links_order_fk ON public.sections_localizations_links USING btree (section_order);
 9   DROP INDEX public.sections_localizations_links_order_fk;
       public            strapi    false    287            G           1259    59641    sections_updated_by_id_fk    INDEX     W   CREATE INDEX sections_updated_by_id_fk ON public.sections USING btree (updated_by_id);
 -   DROP INDEX public.sections_updated_by_id_fk;
       public            strapi    false    281            a           1259    59642    sentences_component_type_index    INDEX     i   CREATE INDEX sentences_component_type_index ON public.sentences_components USING btree (component_type);
 2   DROP INDEX public.sentences_component_type_index;
       public            strapi    false    290            ]           1259    59643    sentences_created_by_id_fk    INDEX     Y   CREATE INDEX sentences_created_by_id_fk ON public.sentences USING btree (created_by_id);
 .   DROP INDEX public.sentences_created_by_id_fk;
       public            strapi    false    289            d           1259    59644    sentences_entity_fk    INDEX     Y   CREATE INDEX sentences_entity_fk ON public.sentences_components USING btree (entity_id);
 '   DROP INDEX public.sentences_entity_fk;
       public            strapi    false    290            e           1259    59645    sentences_field_index    INDEX     W   CREATE INDEX sentences_field_index ON public.sentences_components USING btree (field);
 )   DROP INDEX public.sentences_field_index;
       public            strapi    false    290            h           1259    59646     sentences_localizations_links_fk    INDEX     q   CREATE INDEX sentences_localizations_links_fk ON public.sentences_localizations_links USING btree (sentence_id);
 4   DROP INDEX public.sentences_localizations_links_fk;
       public            strapi    false    293            i           1259    59647 $   sentences_localizations_links_inv_fk    INDEX     y   CREATE INDEX sentences_localizations_links_inv_fk ON public.sentences_localizations_links USING btree (inv_sentence_id);
 8   DROP INDEX public.sentences_localizations_links_inv_fk;
       public            strapi    false    293            j           1259    59648 &   sentences_localizations_links_order_fk    INDEX     z   CREATE INDEX sentences_localizations_links_order_fk ON public.sentences_localizations_links USING btree (sentence_order);
 :   DROP INDEX public.sentences_localizations_links_order_fk;
       public            strapi    false    293            `           1259    59649    sentences_updated_by_id_fk    INDEX     Y   CREATE INDEX sentences_updated_by_id_fk ON public.sentences USING btree (updated_by_id);
 .   DROP INDEX public.sentences_updated_by_id_fk;
       public            strapi    false    289            o           1259    59650 -   strapi_api_token_permissions_created_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_created_by_id_fk;
       public            strapi    false    295            s           1259    59651 +   strapi_api_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);
 ?   DROP INDEX public.strapi_api_token_permissions_token_links_fk;
       public            strapi    false    297            t           1259    59652 /   strapi_api_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);
 C   DROP INDEX public.strapi_api_token_permissions_token_links_inv_fk;
       public            strapi    false    297            u           1259    59653 5   strapi_api_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);
 I   DROP INDEX public.strapi_api_token_permissions_token_links_order_inv_fk;
       public            strapi    false    297            r           1259    59654 -   strapi_api_token_permissions_updated_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_updated_by_id_fk;
       public            strapi    false    295            z           1259    59655 "   strapi_api_tokens_created_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);
 6   DROP INDEX public.strapi_api_tokens_created_by_id_fk;
       public            strapi    false    299            }           1259    59656 "   strapi_api_tokens_updated_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);
 6   DROP INDEX public.strapi_api_tokens_updated_by_id_fk;
       public            strapi    false    299            �           1259    59657 2   strapi_transfer_token_permissions_created_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_created_by_id_fk;
       public            strapi    false    307            �           1259    59658 0   strapi_transfer_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);
 D   DROP INDEX public.strapi_transfer_token_permissions_token_links_fk;
       public            strapi    false    309            �           1259    59659 4   strapi_transfer_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);
 H   DROP INDEX public.strapi_transfer_token_permissions_token_links_inv_fk;
       public            strapi    false    309            �           1259    59660 :   strapi_transfer_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);
 N   DROP INDEX public.strapi_transfer_token_permissions_token_links_order_inv_fk;
       public            strapi    false    309            �           1259    59661 2   strapi_transfer_token_permissions_updated_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_updated_by_id_fk;
       public            strapi    false    307            �           1259    59662 '   strapi_transfer_tokens_created_by_id_fk    INDEX     s   CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);
 ;   DROP INDEX public.strapi_transfer_tokens_created_by_id_fk;
       public            strapi    false    311            �           1259    59663 '   strapi_transfer_tokens_updated_by_id_fk    INDEX     s   CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);
 ;   DROP INDEX public.strapi_transfer_tokens_updated_by_id_fk;
       public            strapi    false    311            �           1259    59664    units_created_by_id_fk    INDEX     Q   CREATE INDEX units_created_by_id_fk ON public.units USING btree (created_by_id);
 *   DROP INDEX public.units_created_by_id_fk;
       public            strapi    false    315            �           1259    59665    units_localizations_links_fk    INDEX     e   CREATE INDEX units_localizations_links_fk ON public.units_localizations_links USING btree (unit_id);
 0   DROP INDEX public.units_localizations_links_fk;
       public            strapi    false    317            �           1259    59666     units_localizations_links_inv_fk    INDEX     m   CREATE INDEX units_localizations_links_inv_fk ON public.units_localizations_links USING btree (inv_unit_id);
 4   DROP INDEX public.units_localizations_links_inv_fk;
       public            strapi    false    317            �           1259    59667 "   units_localizations_links_order_fk    INDEX     n   CREATE INDEX units_localizations_links_order_fk ON public.units_localizations_links USING btree (unit_order);
 6   DROP INDEX public.units_localizations_links_order_fk;
       public            strapi    false    317            �           1259    59668    units_precondition_links_fk    INDEX     c   CREATE INDEX units_precondition_links_fk ON public.units_precondition_links USING btree (unit_id);
 /   DROP INDEX public.units_precondition_links_fk;
       public            strapi    false    319            �           1259    59669    units_precondition_links_inv_fk    INDEX     k   CREATE INDEX units_precondition_links_inv_fk ON public.units_precondition_links USING btree (inv_unit_id);
 3   DROP INDEX public.units_precondition_links_inv_fk;
       public            strapi    false    319            �           1259    59670    units_updated_by_id_fk    INDEX     Q   CREATE INDEX units_updated_by_id_fk ON public.units USING btree (updated_by_id);
 *   DROP INDEX public.units_updated_by_id_fk;
       public            strapi    false    315            �           1259    59671    up_permissions_created_by_id_fk    INDEX     c   CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);
 3   DROP INDEX public.up_permissions_created_by_id_fk;
       public            strapi    false    321            �           1259    59672    up_permissions_role_links_fk    INDEX     k   CREATE INDEX up_permissions_role_links_fk ON public.up_permissions_role_links USING btree (permission_id);
 0   DROP INDEX public.up_permissions_role_links_fk;
       public            strapi    false    323            �           1259    59673     up_permissions_role_links_inv_fk    INDEX     i   CREATE INDEX up_permissions_role_links_inv_fk ON public.up_permissions_role_links USING btree (role_id);
 4   DROP INDEX public.up_permissions_role_links_inv_fk;
       public            strapi    false    323            �           1259    59674 &   up_permissions_role_links_order_inv_fk    INDEX     x   CREATE INDEX up_permissions_role_links_order_inv_fk ON public.up_permissions_role_links USING btree (permission_order);
 :   DROP INDEX public.up_permissions_role_links_order_inv_fk;
       public            strapi    false    323            �           1259    59675    up_permissions_updated_by_id_fk    INDEX     c   CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);
 3   DROP INDEX public.up_permissions_updated_by_id_fk;
       public            strapi    false    321            �           1259    59676    up_roles_created_by_id_fk    INDEX     W   CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);
 -   DROP INDEX public.up_roles_created_by_id_fk;
       public            strapi    false    325            �           1259    59677    up_roles_updated_by_id_fk    INDEX     W   CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);
 -   DROP INDEX public.up_roles_updated_by_id_fk;
       public            strapi    false    325            �           1259    59678    up_users_created_by_id_fk    INDEX     W   CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);
 -   DROP INDEX public.up_users_created_by_id_fk;
       public            strapi    false    327            �           1259    59679    up_users_role_links_fk    INDEX     Y   CREATE INDEX up_users_role_links_fk ON public.up_users_role_links USING btree (user_id);
 *   DROP INDEX public.up_users_role_links_fk;
       public            strapi    false    329            �           1259    59680    up_users_role_links_inv_fk    INDEX     ]   CREATE INDEX up_users_role_links_inv_fk ON public.up_users_role_links USING btree (role_id);
 .   DROP INDEX public.up_users_role_links_inv_fk;
       public            strapi    false    329            �           1259    59681     up_users_role_links_order_inv_fk    INDEX     f   CREATE INDEX up_users_role_links_order_inv_fk ON public.up_users_role_links USING btree (user_order);
 4   DROP INDEX public.up_users_role_links_order_inv_fk;
       public            strapi    false    329            �           1259    59682    up_users_updated_by_id_fk    INDEX     W   CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);
 -   DROP INDEX public.up_users_updated_by_id_fk;
       public            strapi    false    327            �           1259    59683    upload_files_created_at_index    INDEX     U   CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);
 1   DROP INDEX public.upload_files_created_at_index;
       public            strapi    false    247            �           1259    59684    upload_files_ext_index    INDEX     G   CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);
 *   DROP INDEX public.upload_files_ext_index;
       public            strapi    false    247            �           1259    59685    upload_files_folder_path_index    INDEX     W   CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);
 2   DROP INDEX public.upload_files_folder_path_index;
       public            strapi    false    247            �           1259    59686    upload_files_name_index    INDEX     I   CREATE INDEX upload_files_name_index ON public.files USING btree (name);
 +   DROP INDEX public.upload_files_name_index;
       public            strapi    false    247            �           1259    59687    upload_files_size_index    INDEX     I   CREATE INDEX upload_files_size_index ON public.files USING btree (size);
 +   DROP INDEX public.upload_files_size_index;
       public            strapi    false    247            �           1259    59688    upload_files_updated_at_index    INDEX     U   CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);
 1   DROP INDEX public.upload_files_updated_at_index;
       public            strapi    false    247            �           1259    59689    upload_folders_created_by_id_fk    INDEX     c   CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);
 3   DROP INDEX public.upload_folders_created_by_id_fk;
       public            strapi    false    331            �           1259    59690    upload_folders_parent_links_fk    INDEX     k   CREATE INDEX upload_folders_parent_links_fk ON public.upload_folders_parent_links USING btree (folder_id);
 2   DROP INDEX public.upload_folders_parent_links_fk;
       public            strapi    false    333            �           1259    59691 "   upload_folders_parent_links_inv_fk    INDEX     s   CREATE INDEX upload_folders_parent_links_inv_fk ON public.upload_folders_parent_links USING btree (inv_folder_id);
 6   DROP INDEX public.upload_folders_parent_links_inv_fk;
       public            strapi    false    333            �           1259    59692 (   upload_folders_parent_links_order_inv_fk    INDEX     x   CREATE INDEX upload_folders_parent_links_order_inv_fk ON public.upload_folders_parent_links USING btree (folder_order);
 <   DROP INDEX public.upload_folders_parent_links_order_inv_fk;
       public            strapi    false    333            �           1259    59693    upload_folders_updated_by_id_fk    INDEX     c   CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);
 3   DROP INDEX public.upload_folders_updated_by_id_fk;
       public            strapi    false    331            !           1259    60475    user_profiles_created_by_id_fk    INDEX     a   CREATE INDEX user_profiles_created_by_id_fk ON public.user_profiles USING btree (created_by_id);
 2   DROP INDEX public.user_profiles_created_by_id_fk;
       public            strapi    false    362            $           1259    60476    user_profiles_updated_by_id_fk    INDEX     a   CREATE INDEX user_profiles_updated_by_id_fk ON public.user_profiles USING btree (updated_by_id);
 2   DROP INDEX public.user_profiles_updated_by_id_fk;
       public            strapi    false    362            %           1259    60484    user_profiles_user_links_fk    INDEX     k   CREATE INDEX user_profiles_user_links_fk ON public.user_profiles_user_links USING btree (user_profile_id);
 /   DROP INDEX public.user_profiles_user_links_fk;
       public            strapi    false    364            &           1259    60485    user_profiles_user_links_inv_fk    INDEX     g   CREATE INDEX user_profiles_user_links_inv_fk ON public.user_profiles_user_links USING btree (user_id);
 3   DROP INDEX public.user_profiles_user_links_inv_fk;
       public            strapi    false    364            �           1259    59694    user_sentences_created_by_id_fk    INDEX     c   CREATE INDEX user_sentences_created_by_id_fk ON public.user_sentences USING btree (created_by_id);
 3   DROP INDEX public.user_sentences_created_by_id_fk;
       public            strapi    false    335            �           1259    59695    user_sentences_lesson_links_fk    INDEX     r   CREATE INDEX user_sentences_lesson_links_fk ON public.user_sentences_lesson_links USING btree (user_sentence_id);
 2   DROP INDEX public.user_sentences_lesson_links_fk;
       public            strapi    false    337            �           1259    59696 "   user_sentences_lesson_links_inv_fk    INDEX     o   CREATE INDEX user_sentences_lesson_links_inv_fk ON public.user_sentences_lesson_links USING btree (lesson_id);
 6   DROP INDEX public.user_sentences_lesson_links_inv_fk;
       public            strapi    false    337            �           1259    59697 (   user_sentences_lesson_links_order_inv_fk    INDEX        CREATE INDEX user_sentences_lesson_links_order_inv_fk ON public.user_sentences_lesson_links USING btree (user_sentence_order);
 <   DROP INDEX public.user_sentences_lesson_links_order_inv_fk;
       public            strapi    false    337            �           1259    59698 %   user_sentences_localizations_links_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_fk ON public.user_sentences_localizations_links USING btree (user_sentence_id);
 9   DROP INDEX public.user_sentences_localizations_links_fk;
       public            strapi    false    339            �           1259    59699 )   user_sentences_localizations_links_inv_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_inv_fk ON public.user_sentences_localizations_links USING btree (inv_user_sentence_id);
 =   DROP INDEX public.user_sentences_localizations_links_inv_fk;
       public            strapi    false    339            �           1259    59700 +   user_sentences_localizations_links_order_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_order_fk ON public.user_sentences_localizations_links USING btree (user_sentence_order);
 ?   DROP INDEX public.user_sentences_localizations_links_order_fk;
       public            strapi    false    339            �           1259    59701    user_sentences_updated_by_id_fk    INDEX     c   CREATE INDEX user_sentences_updated_by_id_fk ON public.user_sentences USING btree (updated_by_id);
 3   DROP INDEX public.user_sentences_updated_by_id_fk;
       public            strapi    false    335            2           1259    60641    user_sentences_user_links_fk    INDEX     n   CREATE INDEX user_sentences_user_links_fk ON public.user_sentences_user_links USING btree (user_sentence_id);
 0   DROP INDEX public.user_sentences_user_links_fk;
       public            strapi    false    368            3           1259    60642     user_sentences_user_links_inv_fk    INDEX     i   CREATE INDEX user_sentences_user_links_inv_fk ON public.user_sentences_user_links USING btree (user_id);
 4   DROP INDEX public.user_sentences_user_links_inv_fk;
       public            strapi    false    368            4           1259    60645 &   user_sentences_user_links_order_inv_fk    INDEX     {   CREATE INDEX user_sentences_user_links_order_inv_fk ON public.user_sentences_user_links USING btree (user_sentence_order);
 :   DROP INDEX public.user_sentences_user_links_order_inv_fk;
       public            strapi    false    368            �           1259    59705    user_words_created_by_id_fk    INDEX     [   CREATE INDEX user_words_created_by_id_fk ON public.user_words USING btree (created_by_id);
 /   DROP INDEX public.user_words_created_by_id_fk;
       public            strapi    false    341            �           1259    59706    user_words_lesson_links_fk    INDEX     f   CREATE INDEX user_words_lesson_links_fk ON public.user_words_lesson_links USING btree (user_word_id);
 .   DROP INDEX public.user_words_lesson_links_fk;
       public            strapi    false    343            �           1259    59707    user_words_lesson_links_inv_fk    INDEX     g   CREATE INDEX user_words_lesson_links_inv_fk ON public.user_words_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.user_words_lesson_links_inv_fk;
       public            strapi    false    343            �           1259    59708 $   user_words_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX user_words_lesson_links_order_inv_fk ON public.user_words_lesson_links USING btree (user_word_order);
 8   DROP INDEX public.user_words_lesson_links_order_inv_fk;
       public            strapi    false    343            �           1259    59709 !   user_words_localizations_links_fk    INDEX     t   CREATE INDEX user_words_localizations_links_fk ON public.user_words_localizations_links USING btree (user_word_id);
 5   DROP INDEX public.user_words_localizations_links_fk;
       public            strapi    false    345            �           1259    59710 %   user_words_localizations_links_inv_fk    INDEX     |   CREATE INDEX user_words_localizations_links_inv_fk ON public.user_words_localizations_links USING btree (inv_user_word_id);
 9   DROP INDEX public.user_words_localizations_links_inv_fk;
       public            strapi    false    345            �           1259    59711 '   user_words_localizations_links_order_fk    INDEX     }   CREATE INDEX user_words_localizations_links_order_fk ON public.user_words_localizations_links USING btree (user_word_order);
 ;   DROP INDEX public.user_words_localizations_links_order_fk;
       public            strapi    false    345            �           1259    59712    user_words_updated_by_id_fk    INDEX     [   CREATE INDEX user_words_updated_by_id_fk ON public.user_words USING btree (updated_by_id);
 /   DROP INDEX public.user_words_updated_by_id_fk;
       public            strapi    false    341            +           1259    60606    user_words_user_links_fk    INDEX     b   CREATE INDEX user_words_user_links_fk ON public.user_words_user_links USING btree (user_word_id);
 ,   DROP INDEX public.user_words_user_links_fk;
       public            strapi    false    366            ,           1259    60607    user_words_user_links_inv_fk    INDEX     a   CREATE INDEX user_words_user_links_inv_fk ON public.user_words_user_links USING btree (user_id);
 0   DROP INDEX public.user_words_user_links_inv_fk;
       public            strapi    false    366            -           1259    60610 "   user_words_user_links_order_inv_fk    INDEX     o   CREATE INDEX user_words_user_links_order_inv_fk ON public.user_words_user_links USING btree (user_word_order);
 6   DROP INDEX public.user_words_user_links_order_inv_fk;
       public            strapi    false    366            �           1259    59716    words_component_type_index    INDEX     a   CREATE INDEX words_component_type_index ON public.words_components USING btree (component_type);
 .   DROP INDEX public.words_component_type_index;
       public            strapi    false    348            �           1259    59717    words_created_by_id_fk    INDEX     Q   CREATE INDEX words_created_by_id_fk ON public.words USING btree (created_by_id);
 *   DROP INDEX public.words_created_by_id_fk;
       public            strapi    false    347            �           1259    59718    words_entity_fk    INDEX     Q   CREATE INDEX words_entity_fk ON public.words_components USING btree (entity_id);
 #   DROP INDEX public.words_entity_fk;
       public            strapi    false    348                        1259    59719     words_example_sentences_links_fk    INDEX     m   CREATE INDEX words_example_sentences_links_fk ON public.words_example_sentences_links USING btree (word_id);
 4   DROP INDEX public.words_example_sentences_links_fk;
       public            strapi    false    350                       1259    59720 $   words_example_sentences_links_inv_fk    INDEX     u   CREATE INDEX words_example_sentences_links_inv_fk ON public.words_example_sentences_links USING btree (sentence_id);
 8   DROP INDEX public.words_example_sentences_links_inv_fk;
       public            strapi    false    350                       1259    59721 &   words_example_sentences_links_order_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_fk ON public.words_example_sentences_links USING btree (sentence_order);
 :   DROP INDEX public.words_example_sentences_links_order_fk;
       public            strapi    false    350                       1259    59722 *   words_example_sentences_links_order_inv_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_inv_fk ON public.words_example_sentences_links USING btree (word_order);
 >   DROP INDEX public.words_example_sentences_links_order_inv_fk;
       public            strapi    false    350            �           1259    59723    words_field_index    INDEX     O   CREATE INDEX words_field_index ON public.words_components USING btree (field);
 %   DROP INDEX public.words_field_index;
       public            strapi    false    348                       1259    59724    words_localizations_links_fk    INDEX     e   CREATE INDEX words_localizations_links_fk ON public.words_localizations_links USING btree (word_id);
 0   DROP INDEX public.words_localizations_links_fk;
       public            strapi    false    353            	           1259    59725     words_localizations_links_inv_fk    INDEX     m   CREATE INDEX words_localizations_links_inv_fk ON public.words_localizations_links USING btree (inv_word_id);
 4   DROP INDEX public.words_localizations_links_inv_fk;
       public            strapi    false    353            
           1259    59726 "   words_localizations_links_order_fk    INDEX     n   CREATE INDEX words_localizations_links_order_fk ON public.words_localizations_links USING btree (word_order);
 6   DROP INDEX public.words_localizations_links_order_fk;
       public            strapi    false    353            �           1259    59727    words_updated_by_id_fk    INDEX     Q   CREATE INDEX words_updated_by_id_fk ON public.words USING btree (updated_by_id);
 *   DROP INDEX public.words_updated_by_id_fk;
       public            strapi    false    347            9           2606    59728 4   admin_permissions admin_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_created_by_id_fk;
       public          strapi    false    209    4259    215            ;           2606    59733 <   admin_permissions_role_links admin_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_fk;
       public          strapi    false    211    4244    209            <           2606    59738 @   admin_permissions_role_links admin_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_inv_fk;
       public          strapi    false    211    4255    213            :           2606    59743 4   admin_permissions admin_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_updated_by_id_fk;
       public          strapi    false    215    209    4259            =           2606    59748 (   admin_roles admin_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_created_by_id_fk;
       public          strapi    false    4259    215    213            >           2606    59753 (   admin_roles admin_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_updated_by_id_fk;
       public          strapi    false    213    215    4259            ?           2606    59758 (   admin_users admin_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_created_by_id_fk;
       public          strapi    false    4259    215    215            A           2606    59763 2   admin_users_roles_links admin_users_roles_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_fk;
       public          strapi    false    4259    215    217            B           2606    59768 6   admin_users_roles_links admin_users_roles_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_inv_fk;
       public          strapi    false    213    4255    217            @           2606    59773 (   admin_users admin_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_updated_by_id_fk;
       public          strapi    false    4259    215    215            C           2606    59778 N   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_fk FOREIGN KEY (sent_ref_id) REFERENCES public.components_a_sent_refs(id) ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_fk;
       public          strapi    false    227    225    4276            D           2606    59783 R   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 |   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_inv_fk;
       public          strapi    false    289    4447    227            E           2606    59788 b   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk FOREIGN KEY (user_sent_ref_id) REFERENCES public.components_a_user_sent_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk;
       public          strapi    false    4286    233    231            F           2606    59793 f   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk;
       public          strapi    false    335    233    4563            G           2606    59798 Z   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_fk FOREIGN KEY (user_word_ref_id) REFERENCES public.components_a_user_word_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_fk;
       public          strapi    false    4294    237    235            H           2606    59803 ^   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk;
       public          strapi    false    237    4581    341            I           2606    59808 F   components_a_word_refs_word_links components_a_word_refs_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_fk FOREIGN KEY (word_ref_id) REFERENCES public.components_a_word_refs(id) ON DELETE CASCADE;
 p   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_fk;
       public          strapi    false    4306    243    245            J           2606    59813 J   components_a_word_refs_word_links components_a_word_refs_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_inv_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 t   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_inv_fk;
       public          strapi    false    347    4599    245            K           2606    59818    files files_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fk;
       public          strapi    false    4259    247    215            M           2606    59823 (   files_folder_links files_folder_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_fk;
       public          strapi    false    4315    248    247            N           2606    59828 ,   files_folder_links files_folder_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_inv_fk;
       public          strapi    false    248    331    4552            O           2606    59833 ,   files_related_morphs files_related_morphs_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_fk;
       public          strapi    false    247    4315    251            L           2606    59838    files files_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_updated_by_id_fk;
       public          strapi    false    247    4259    215            P           2606    59843 &   flashcards flashcards_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_created_by_id_fk;
       public          strapi    false    253    4259    215            R           2606    59848 *   flashcards_components flashcards_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_entity_fk FOREIGN KEY (entity_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_entity_fk;
       public          strapi    false    254    4337    253            S           2606    59853 2   flashcards_lesson_links flashcards_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_fk;
       public          strapi    false    257    253    4337            T           2606    59858 6   flashcards_lesson_links flashcards_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_inv_fk;
       public          strapi    false    257    267    4377            U           2606    59863 @   flashcards_localizations_links flashcards_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_fk;
       public          strapi    false    259    253    4337            V           2606    59868 D   flashcards_localizations_links flashcards_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_inv_fk FOREIGN KEY (inv_flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_inv_fk;
       public          strapi    false    4337    253    259            Q           2606    59873 &   flashcards flashcards_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_updated_by_id_fk;
       public          strapi    false    215    4259    253            W           2606    59878 .   flashcards_user_links flashcards_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_fk;
       public          strapi    false    261    253    4337            X           2606    59883 2   flashcards_user_links flashcards_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_inv_fk;
       public          strapi    false    327    261    4537            Y           2606    59888 (   i18n_locale i18n_locale_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_created_by_id_fk;
       public          strapi    false    4259    263    215            Z           2606    59893 (   i18n_locale i18n_locale_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_updated_by_id_fk;
       public          strapi    false    215    4259    263            [           2606    59898 *   lessonlevels lessonlevels_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_created_by_id_fk;
       public          strapi    false    215    4259    265            \           2606    59903 *   lessonlevels lessonlevels_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_updated_by_id_fk;
       public          strapi    false    265    215    4259            ]           2606    59908     lessons lessons_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_created_by_id_fk;
       public          strapi    false    267    215    4259            _           2606    59913 $   lessons_components lessons_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_entity_fk FOREIGN KEY (entity_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_entity_fk;
       public          strapi    false    268    4377    267            `           2606    59918 6   lessons_lessonlevel_links lessons_lessonlevel_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_fk;
       public          strapi    false    271    267    4377            a           2606    59923 :   lessons_lessonlevel_links lessons_lessonlevel_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_inv_fk FOREIGN KEY (lessonlevel_id) REFERENCES public.lessonlevels(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_inv_fk;
       public          strapi    false    265    4373    271            b           2606    59928 :   lessons_localizations_links lessons_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_fk;
       public          strapi    false    273    4377    267            c           2606    59933 >   lessons_localizations_links lessons_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_inv_fk FOREIGN KEY (inv_lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_inv_fk;
       public          strapi    false    273    4377    267            d           2606    59938 (   lessons_unit_links lessons_unit_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_fk;
       public          strapi    false    267    275    4377            e           2606    59943 ,   lessons_unit_links lessons_unit_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_inv_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_inv_fk;
       public          strapi    false    4503    275    315            ^           2606    59948     lessons lessons_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_updated_by_id_fk;
       public          strapi    false    267    4259    215            �           2606    60349 *   review_tires review_tires_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_created_by_id_fk;
       public          strapi    false    4259    356    215            �           2606    60359 D   review_tires_localizations_links review_tires_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_fk FOREIGN KEY (review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_fk;
       public          strapi    false    358    4625    356            �           2606    60364 H   review_tires_localizations_links review_tires_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_inv_fk FOREIGN KEY (inv_review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_inv_fk;
       public          strapi    false    4625    356    358            �           2606    60354 *   review_tires review_tires_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_updated_by_id_fk;
       public          strapi    false    215    356    4259            f           2606    59953 &   reviewlogs reviewlogs_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_created_by_id_fk;
       public          strapi    false    215    277    4259            �           2606    60407 8   reviewlogs_flashcard_links reviewlogs_flashcard_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_fk;
       public          strapi    false    277    4411    360            �           2606    60412 <   reviewlogs_flashcard_links reviewlogs_flashcard_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_inv_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_inv_fk;
       public          strapi    false    360    4337    253            g           2606    59958 &   reviewlogs reviewlogs_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_updated_by_id_fk;
       public          strapi    false    4259    277    215            h           2606    59963 .   reviewlogs_user_links reviewlogs_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_fk;
       public          strapi    false    4411    279    277            i           2606    59968 2   reviewlogs_user_links reviewlogs_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_inv_fk;
       public          strapi    false    4537    279    327            j           2606    59973 "   sections sections_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_created_by_id_fk;
       public          strapi    false    4259    281    215            l           2606    59978 &   sections_components sections_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_entity_fk;
       public          strapi    false    4422    282    281            m           2606    59983 .   sections_lesson_links sections_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_fk;
       public          strapi    false    281    4422    285            n           2606    59988 2   sections_lesson_links sections_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_inv_fk;
       public          strapi    false    285    4377    267            o           2606    59993 <   sections_localizations_links sections_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_fk;
       public          strapi    false    281    287    4422            p           2606    59998 @   sections_localizations_links sections_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_inv_fk FOREIGN KEY (inv_section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_inv_fk;
       public          strapi    false    4422    287    281            k           2606    60003 "   sections sections_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_updated_by_id_fk;
       public          strapi    false    215    281    4259            q           2606    60008 $   sentences sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_created_by_id_fk;
       public          strapi    false    289    4259    215            s           2606    60013 (   sentences_components sentences_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_entity_fk;
       public          strapi    false    289    290    4447            t           2606    60018 >   sentences_localizations_links sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_fk;
       public          strapi    false    4447    293    289            u           2606    60023 B   sentences_localizations_links sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_inv_fk FOREIGN KEY (inv_sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_inv_fk;
       public          strapi    false    293    4447    289            r           2606    60028 $   sentences sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_updated_by_id_fk;
       public          strapi    false    4259    289    215            v           2606    60033 J   strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_created_by_id_fk;
       public          strapi    false    4259    215    295            x           2606    60038 T   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;
 ~   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_fk;
       public          strapi    false    4465    295    297            y           2606    60043 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_inv_fk;
       public          strapi    false    299    4476    297            w           2606    60048 J   strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_updated_by_id_fk;
       public          strapi    false    295    215    4259            z           2606    60053 4   strapi_api_tokens strapi_api_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_created_by_id_fk;
       public          strapi    false    215    4259    299            {           2606    60058 4   strapi_api_tokens strapi_api_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_updated_by_id_fk;
       public          strapi    false    4259    215    299            |           2606    60063 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk;
       public          strapi    false    4259    307    215            ~           2606    60068 ^   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk    FK CONSTRAINT        ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_fk;
       public          strapi    false    4486    307    309                       2606    60073 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk;
       public          strapi    false    309    4497    311            }           2606    60078 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk;
       public          strapi    false    4259    215    307            �           2606    60083 >   strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_created_by_id_fk;
       public          strapi    false    215    4259    311            �           2606    60088 >   strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_updated_by_id_fk;
       public          strapi    false    311    4259    215            �           2606    60093    units units_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_created_by_id_fk;
       public          strapi    false    215    315    4259            �           2606    60098 6   units_localizations_links units_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_fk;
       public          strapi    false    315    4503    317            �           2606    60103 :   units_localizations_links units_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_inv_fk;
       public          strapi    false    315    317    4503            �           2606    60108 4   units_precondition_links units_precondition_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_fk;
       public          strapi    false    319    4503    315            �           2606    60113 8   units_precondition_links units_precondition_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_inv_fk;
       public          strapi    false    319    315    4503            �           2606    60118    units units_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_updated_by_id_fk;
       public          strapi    false    4259    315    215            �           2606    60123 .   up_permissions up_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_created_by_id_fk;
       public          strapi    false    4259    215    321            �           2606    60128 6   up_permissions_role_links up_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_fk;
       public          strapi    false    323    321    4522            �           2606    60133 :   up_permissions_role_links up_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_inv_fk;
       public          strapi    false    323    325    4533            �           2606    60138 .   up_permissions up_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_updated_by_id_fk;
       public          strapi    false    321    4259    215            �           2606    60143 "   up_roles up_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_created_by_id_fk;
       public          strapi    false    215    325    4259            �           2606    60148 "   up_roles up_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_updated_by_id_fk;
       public          strapi    false    325    4259    215            �           2606    60153 "   up_users up_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_created_by_id_fk;
       public          strapi    false    327    4259    215            �           2606    60158 *   up_users_role_links up_users_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_fk;
       public          strapi    false    329    327    4537            �           2606    60163 .   up_users_role_links up_users_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_inv_fk;
       public          strapi    false    4533    325    329            �           2606    60168 "   up_users up_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_updated_by_id_fk;
       public          strapi    false    215    4259    327            �           2606    60173 .   upload_folders upload_folders_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_created_by_id_fk;
       public          strapi    false    215    4259    331            �           2606    60178 :   upload_folders_parent_links upload_folders_parent_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_fk;
       public          strapi    false    331    4552    333            �           2606    60183 >   upload_folders_parent_links upload_folders_parent_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_inv_fk;
       public          strapi    false    331    4552    333            �           2606    60188 .   upload_folders upload_folders_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_updated_by_id_fk;
       public          strapi    false    4259    331    215            �           2606    60488 ,   user_profiles user_profiles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 V   ALTER TABLE ONLY public.user_profiles DROP CONSTRAINT user_profiles_created_by_id_fk;
       public          strapi    false    215    362    4259            �           2606    60493 ,   user_profiles user_profiles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 V   ALTER TABLE ONLY public.user_profiles DROP CONSTRAINT user_profiles_updated_by_id_fk;
       public          strapi    false    4259    215    362            �           2606    60498 4   user_profiles_user_links user_profiles_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_fk FOREIGN KEY (user_profile_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_fk;
       public          strapi    false    364    362    4643            �           2606    60503 8   user_profiles_user_links user_profiles_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_inv_fk;
       public          strapi    false    364    327    4537            �           2606    60193 .   user_sentences user_sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_created_by_id_fk;
       public          strapi    false    215    335    4259            �           2606    60198 :   user_sentences_lesson_links user_sentences_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_fk;
       public          strapi    false    335    4563    337            �           2606    60203 >   user_sentences_lesson_links user_sentences_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_inv_fk;
       public          strapi    false    267    337    4377            �           2606    60208 H   user_sentences_localizations_links user_sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_fk;
       public          strapi    false    335    339    4563            �           2606    60213 L   user_sentences_localizations_links user_sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_inv_fk FOREIGN KEY (inv_user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_inv_fk;
       public          strapi    false    4563    339    335            �           2606    60218 .   user_sentences user_sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_updated_by_id_fk;
       public          strapi    false    215    4259    335            �           2606    60646 6   user_sentences_user_links user_sentences_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_fk;
       public          strapi    false    368    4563    335            �           2606    60651 :   user_sentences_user_links user_sentences_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_inv_fk;
       public          strapi    false    368    4537    327            �           2606    60233 &   user_words user_words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_created_by_id_fk;
       public          strapi    false    341    4259    215            �           2606    60238 2   user_words_lesson_links user_words_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_fk;
       public          strapi    false    343    341    4581            �           2606    60243 6   user_words_lesson_links user_words_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_inv_fk;
       public          strapi    false    267    4377    343            �           2606    60248 @   user_words_localizations_links user_words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_fk;
       public          strapi    false    4581    345    341            �           2606    60253 D   user_words_localizations_links user_words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_inv_fk FOREIGN KEY (inv_user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_inv_fk;
       public          strapi    false    4581    341    345            �           2606    60258 &   user_words user_words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_updated_by_id_fk;
       public          strapi    false    215    341    4259            �           2606    60611 .   user_words_user_links user_words_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_fk;
       public          strapi    false    366    341    4581            �           2606    60616 2   user_words_user_links user_words_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_inv_fk;
       public          strapi    false    366    4537    327            �           2606    60273    words words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_created_by_id_fk;
       public          strapi    false    4259    215    347            �           2606    60278     words_components words_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_entity_fk FOREIGN KEY (entity_id) REFERENCES public.words(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_entity_fk;
       public          strapi    false    347    348    4599            �           2606    60283 >   words_example_sentences_links words_example_sentences_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_fk;
       public          strapi    false    350    347    4599            �           2606    60288 B   words_example_sentences_links words_example_sentences_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_inv_fk;
       public          strapi    false    289    4447    350            �           2606    60293 6   words_localizations_links words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_fk;
       public          strapi    false    347    4599    353            �           2606    60298 :   words_localizations_links words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_inv_fk FOREIGN KEY (inv_word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_inv_fk;
       public          strapi    false    347    4599    353            �           2606    60303    words words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_updated_by_id_fk;
       public          strapi    false    4259    215    347            B   
  x��[�r����<�+�kB �ϰ�u.��Δ�؊�8���y�#��DR��l�Mb>��u�Z�RK�7U~9e�nw��2=�Z�Ǜ��w�����o7��[�o}���.�v�N+.����/�T�,�ӥۧL</2D	�⚁MҦmC҂V,$�����Ku\�2+�	B��|.��"c�	��梲��ͳ�q�#HB+�9�� �M�g�n�l��)�[��G܊k��]1�8�����#�]㚀z�a��7F|��Ɓ��/�aIlŁc6�W�#a�%��5��з�h��HO�&�E����Q�B;�קu��D}Κ&+�l�X	H�}+�DVE��8�b�~�D�.@�l(5ı��P�8������>�N4��+��,$2�����] �G���8oF�L��]��(�jV(�6954�y"�i����ƍ�%X�hf��IpaC� �]�0$Q��Ɓ�]�0$	Z�4�,��P4�4רּ��	VD4$���j&rD��G�@1+�kB��
���Y��p�-Nb�(jVr�"��U�L�Ɓ�.29�sD(:�5\�"׵V���"�K���^���)�i�ы!K�8�Nl���(Χp�_��2���*�l�6��zF���Wp:Y/��Q������ ��5s=&>�l�8�ƫX�E�2���Ѹ yyHs�Ub�n��a��|f�~���v�LB<˾�>*�)_$�Ƙo4��l/�i�(Z�'�$�ql�j�F���{(�G�R��0�	��L�����4��L��p&>.[� ;��v���K�c#���N����4�0�M�b�},��.[ ���7��`)�c��A0v�n�E� �7���<%�?4b�X��)�8��b��K	�1�j�c�N��$��Zp�Ϻ�ʶm�(T�9D�,J�$��#D��&�t�cD��H��Fp�� ����'�`*z���I�v�z�_4ap���å�~���)W��C�na�vΡp�`V��U�>d�80�3��Ӣ�5Y������Eh�p����[���/�6
'7�}�� �8�5#��(b�����$�
�Ɓ&��8͌�� ��7��`�=z{99e�,���?7��g"?6��͟�m������m#��G��R�E�X�r��^�b��]�zY�B�3�K!W����7��n��e������x���;_���[qce�l�	�Oh��6�X��������.\'8��5�����k�6�'S������#{+ߦG#���ɼp�'�;_�}"+nΈ֫�,G��?.���Ug������!�LTѡ��'����yj�|!�y!IBߊ�l}j��1� �L3&�6����΋H�V�(�0��L��UN"f�A�`~Ҳ�z~��1	���	n��������i���ne�Gj������p��(k_O��s�����8�ac�CE�Ӂ����Y�-�?���<B}jō�SW{�����p�ص&��N�u�nD��jT��Q�D���7��s@�J_�GOn�1����*w�͡�z���y8��c��E��F�U�B���V��;��'J�B�_�����e=�P/\u�[qs��0EѲ~��oY������?����'�2�JX��^����H��#�ߗS�Er��Eqb��V��#K��{�s�ƍ{&�\�W8����6�J�t#�jR8K��}Q�D�o�K���F�P(���ݨ��]7��Ȋ�QwXWO��p40B!3���i����z������7����D� ��:f��1+��!^�s���?��nmJ��{�J�v��B�U'=������P��Y}�D-]�W��.yZ�?�^^�<K��{��ߓ��rJ� ��)kZi�rh&*�_��T֙Њ�Qt�����k?r}��	����	��(~�(�^d�ͭD�E�l�:o�a�t2��ѝTxDG�/�o�A�8A"p��z���x $^l����WR?�|ά��CKz2�>h�f� ��SO�u�dh����)}<�2W]��n���\�b�:�<u $�>'lp�s�CzT�`��f�7S��L��$�?���Zqc�����Pg����k��+��@6 ��g�"���}:�{t�k�+�s]��s��o���N��S�7�y��x'�'���7.qH����;D���[q��d4��?�Kw'�q��lF�Ф1�9d� h[ȅ�%oGM��	r/N���>eV�����CMP�	�Vܘ���������#\��wBTӧ���,�<X@��Te!����T�t$ü�C�
v��_���F�y��Np�����sُV[5ܩ6j�?
xEm��?���c���t��S��[����� ?V�݅�1]��o���=-�&�Y}�v�SPׄ;uU�C�w?�&�h�-a�[�lk�Z��$Է�Ư#�����E�7f�8��,������s�xum���C���0��I�j��P�?;����q�k�����.�� �������.��6b9x��v?�qqĬ�1o}���(�@+d�k��/_������      D   �  x�%�[�� �U�ٰ��]����*u��F)D
7�0G��!-yO��16����q��x�xO�g��Ƒ���X��c�zLC_�i��3;��8�.�i1�=�b �G��zd�L��f�zL��q,�F\�|�B(?H�+�_$���	���-Y��Ԗ�E"�R�($�"Z4��-�ڈ�Y��:������-�⋖�j+ђ;2V�e���h٨k%Z�Y���Y���Z��͍�>4�G�rtY�V��n�V���1*p�E�F_k�j��Z�:��F���h�0�E��0t@�vLوցi�:1�K�.̱YA�ܵ��lD냓vl�
pW���ޚ����S���&t٥m�~:�(J�KoAu��.{t����'���~�QN�|QÐt;�o:L�c�����G��y�O@¥���FK�u��^�~�4ٷ>6�L[�ޅ˪5�?D6կ[8K�I�q��Y�X�1�5�?VH�<�6s��O���E(���5�aUԆ�><��:�׊�UQ3���*����aU�c�}�Wm�(�:n&�8o��/y\h�b���Ί�.��q��[�%����/+]: 6��i�̶���@c-�$�0V��a2:B���<!}u)�1��ЩB!c�,����p�,��~���K�z����������b      F   �   x�u��n� @g���b��j6Y�d�r�K������!E�Z�����{ЪsZ(�h��+������j�F��z@c��[����3\	%E*�I��7J��G��׺�v8�ák�v?l��)�J��u��Ce*�T��l[���x���͜l ��+��+S܈�z��KT�Ɣ����2�'*�֘��	>2�������?�p�_���^Xc~3      H   �   x�3�LL�������Ҽ���ļt��������\N�DC�p��D�� �JSǊD����}�T�B'�B�dϊ�J�w���B��L�� �
K=��%�i ����T��L��X��������H����8X3W� (�,      J      x�3�4�@�=... �      L      x������ � �      N      x������ � �      P      x������ � �      R      x�3����� Z �      T      x�3�4�4����� �Y      V      x�3�L��2�,K-J����� $u�      X      x�3����� Z �      Z      x�3�4�4����� �X      \   ;   x�ȹ�@ �\�0�r���:L�@Q��^ǶL�#_��dˑWo�V:u���w��o+      ^   �   x���D!�3�#D���_�2p~ ���P��Ɔ�6��xq�Ň�ZHm*�ࢌԛ
U�m��p*`×
9�n&P�zA�P؅2V�����yz��t؃:l�.vP��݋���H�1�!h      `   (   x�3�L�L�L��K�y�@2��3#�,�3Ə+F���  	�      b      x������ � �      d      x�3�2�2�2����� �      f   "   x�3�4�4�bN#.cNc i�i�i����� 4yu      h      x������ � �      i      x������ � �      l      x������ � �      n   �  x�}�Ir�0E��)|�0r:D� �β��O9�%�RU*|���e���S�qj!���lO�&�"��,_���S	_�]��y�fLQ��`���r!�
�,��2��t��pP3�&�)�s�V�r>ec��|�8��M6ޓ7�����ωS)w`8��~�!����P�-��P���R׀����q��W[8U���)��|/�3!��Y�~������7�~����"�*�Y�@���Y��!�꘴�ҝC�(�PeUVR�����{�Q�_�`�Pn�����8Hsl`��+;�,�DUnɉ��l١��p3Rq�͔V��-�#��d1K���\��߀c GE�c|ؙlF�vC6�n�Q�ky��ƘWI&`G�k�g�u��c.O]+�h�i�A	�
ɤ����h�����]C3�0��~{t�b�DP�,u�%�m�uǬ%;�
n�:r�E��9?��mNe�}6��ֻ��d>���"ܷ]Wpׁ� ֌��2�.C�:��=ҵ��e �i�n��`c{\�a��l>�{��$��\n�����#��:,3�c4_)�ۍ�m�QFl�X�Q�^3|S���ny8�� C�Z�+�����l��ۖ�![�L�����ߓ���R�I_�}"����\1���{]e,�߸�1�W	9��ќJO���?��亾D��Z�s�9�v4�wM$D�E���?���      o   �   x�}�Kn�0D���I}��Mк�p��%�	P��>I�#�*��u}=����?�}������nO�b���:�\�����@��ẜP���< ¼J���!ޙa0B!���ƈiQQa��ϬN��6/����3m�9R=���3��C���!�A%t��:)P��;ˡC�-�C���C�m�s����C���!��R��;��郿�
L�Qa���׺,��=�      r      x�3�4�4�4����� ��      t      x������ � �      v   �   x���0�3S��.���*��'�.Ă;͉�,.��ɍչx�;7/N���ُ��(��������R,SJ��ZP�5�EТD��G�zP(]z@��h��<h��,����az��\�y���E8�7�3���h��G�c	�˨h�_V�he~?$�J-�      x   <   x�3�t�K��,�P�H���L��4202�50�52V04�21�26г04�)�D\1z\\\ ��S      z      x������ � �      |   J   x�3��I-.��S0T�H�����suu3��?NCN##S]3]#+cK+#=3KS��@������� �nW      }      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�u�K
�@D�5���3�̜ō†%(��1�&Iצy��M	�S_�O8��@H|C�Q:p�곐%��<�tF1�r�тC���ֺ�w�dr���uU	L�B[.���L}���K_.���+A��6����'3�+��l��2��(e3E�ڥ��5�|��KO      �      x������ � �      �   b  x���kn7����"���Et��F[�M
#E�ݗ�t�� �9�g�CJ��k^>���������/V��I�O��Zw�p��L6P������?߿��o�sH�Z�ӯZ���P���)Yْ�>(aC�.ʇ�A�J>LP�;�J�R�W����<y�A�d�>(Q̡��r6@}P��cx��B}b��U.�c����5����e�"7]�m�l���v�_A�>!�x���?�W�e�O�^�Z:��3f��
X�e�*��Al��V�wm"��^�_~���_�R(�O�+�O�ِ��mh"�+�'��9�pF%g�>I��.�#��P'���Ж�>A}r���߿�����Ir�_~�����y�B��P�����D�=�h9
�vP���AY{n��J�P����Ey�B\��>Qf��)��6�
�
���e����
�K~w9��KT����>��qo��?�7	��UN7�9h��d�(P�撋wk�N����%n���=׹_$��^]r��ꑼ�� u�ד+���#$��%�C_⻛�o	r֖xI�З��Z򛓧��ul���%�9�Z����a�A�����U	��:�ߴl��܄ˣ��]~�a�Or���}���o���¥��%�m�$�_*�^]��n�E9�Z{�����A�Z���S�!}��å���w�1��s;M��K�lr.aVE{n��#xu)�8_��:���9qx��%��c<����x���R�: 7���%1��U>{/k���p)�mZ�˾>d�f�
�攰�l������-��K���%�5��be,��N��KQ����D�/�/����~�^.�qAo2�W�����)J��91u�.ExՓ� ��K�}	�������V��ͥ^���<��6�r9�H~����).��9�������RL��g�ݨ�/�/�ͥ�������gC�*�m�#zu�u���U��7��u��n_9u�ԡx\3��	��%�����>���=�W��K����g� u�.%w�<d�#xu��=�p'�#xu)�}���*-]��R�7pΞ_���^]J�EGXT.'�#���x��ór@E`�(��|Y�LZd�� ]]O�f���E�t��K��7�WqU�]G��R��M[�Fϫ��ե|ӛ|Uz���xs)���㻘Y�f����oz�%�����#xu)���\��j�MG��R��Mo�ы�u o.����ɢ����ե|ӡ��*/��u�.����Ǧž�u�.�YTZUc���Tn�4<�(�� ڋ�����3�/�g�
l��kH� ]M*�C{7��PGlq����aI����ե;����*)MG��R�*aQޖ$����w7R��ÜJ�A�ŵd4l�������L��h�+ʺuD�.��^���C�(�s�^$���\f�-�����J���$;�6+��MɈ-&��v�Q�(��#tu�oا�����2���l>��*�MG��|�OwV�_Z�.�azٮ�����g��K�����p�Ǉ��e�ٲ��z�n:bW���ƴ<�r�uĮ.���i#?�E�w����ƴ�2�@ѫ��mo��n�j�MG��2{{vF�����L��Q�w�HK�[LF�4�ʯΟ�#�����������Ɉ-&�{S�(�A�﩯��e6�M_?��dd�Kr7���Z�9�吗�n2؁��N������c�P?�?����Y�7uf�>B}�.�[�e�<��R�O�zs��<7GTV�y?�]]f��lq�~ԗ��tМ-����6@}I�$S�K��^�<ѡvsɸew>��b��'���l0�>��:��O���ͥϊ��BÚ8      �     x��˕1�M0������c��b�%���qj��2�f#f,��X����hq�W�[������椵�"��SZ��s�H�9��\��=�v�Č$X]m��6ߪ�Ҧ ��ֶǊ9��Jm���9�1��;�[�(*�G� ߒ���c��s,��:�<'�ph���p����� �u'��aR	ū)>]��J��@㺕и�jEp�
f�yh��4Wp<��5<&@� D�&��3ò�� 0yOe�	V̄;����t�H�ɿ篊�;)X
r��KA� ���˂L=M�b�l��/h��!h�<VG͞06�4N�
6���No+�����&���"S]�5<݆���1LMA#�m@��5V�q�x��$� �%����)�ghh��25�7��M2�w��P��И�ݦ�JW�b����{���&\<��F�	`��`���X�[���M`���.�P�������x�-=!'��n��,��gU����o">t(�U��n}{�{�\ߦ���E�?�4��      �   �  x�=�Q�-!D��ż"�^f��xU�dro$�᡻���v���m�u#-Y��AY�ښ�q��06�_�?OZp7�:<�u�|��h��4���c.�x���osa��\E�s�|�B�X�-�|������F��h��c!ZDY��hѢ\E���b��m���vۢm�ۢm�4����6v�m'��-�>�e[�]�m[���\E�{l���,E˅tK�ґa)Zr[���J�L�;%�X��Y��e!�R�l$W��"�R��eG��p܎h�qh'p����I;�^ދw1N��N��4W���;��A-+�j��J�rTX�V��V��F��h��c%Z��"��X����U�������E�vk���a-Zz[���֢u���h}�e-Z���濫�h���E��h=�D�v.Q�]�%J��D�v7.Q���%J�{p��.Q�]&�����%J�;�e#�,�ۈ6�	�&0�F�٘�mslD��)Ѧ0m#�4��h�h3�/�J����_L�z_��b��K�b�s�^��������Ŵ��ż/~�ߎ�_/�X�/��XL�z�_ԀT��N�l��F��,�qd9瓎$�|ޑ�d�O=Ґ���G&�>IFR�� �H�4$%�B�L�w��Ɉ=�$��~2!gyJb�;���w�剉=�8�s{�q��'��S}��VNA��{,gy�b�;��T�~��o�݁      �   {   x�3�(JL.�LNU0�4�4202�50�52Q00�21�20�3��-n��y\�S�8�1U�Y�����b��
4$?O�P��(5�$3/]�%31'?=�M���&���V�&z�03c���� F�1$      �   3   x�3�4�4�L�+�/J�-JM�L��-��K�+)�4�2��5����� i��      �      x�3�4A.#N# m�e�i���b���� 4 m      �      x������ � �      �   �   x�3���|>eŋ�/֯}���dgǋ�[�����c��is��Y�d��M��
9�٩
����FF��f�F
FFV�V&�z��aKC++S=cc#NC L���K--)J��2�n'��+���z�t��=�����)
��Ey�y���X�YZX��hje`�ghi�nc� l T�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x��]�n#7���y
������vwғ3���$@v�ݍt�E�JmU\�R�Jv;��}�}�}���zXbIEY���N�E��)�\�C�/����e^NfU٢��,�2�D5��"�\�Y�W���]���,�/����O��
�������ld��Gjۼ�lFg����*�ht��kt<�ȋ���e�l�?Yav���O���Y^~���4VfK����l]�﫺��|������~����@m6�ڌ�D��c��y��ŅEސ_�"�����!�LV�}�_��*R��d������&~���l�U�X���&�Z t�\�8�ތ�]�����C&rqJ��`��-��P���B��\��CX-����A��-īV�Y�|�+T/��4�z�����$�Q:�G���_q������i�ר�;]��s�z����Ye�U�eQ�C�sV���ɱ*��)�����Cx]��~^Ua^u�=��Ж���y5��"����/j��7�ߠ
��z����Z��j�R��h}d�@�;�����>$$�p��ݱ,�<0/??V�
�j��E��;�[ `�,�}�P��/�����U�_Ѭ}����g/vA�m����a(k�&<���6x6aƄfL�1aƄ�3*700p���q7:�_���q':4�g>�b|�8���*����q�!T�l��L4�%I�s�.������S'�F#a��YS	�E1�U���W]a%hs�/U�U�|X�b�T}hQ+���A>�ߺ*� �>���o+A����@.囤��ja-UDS��`���QO3��2,#��i��B�yT}9���^Au�:0�ŦE��Z>_��&g��JN*9�n'%�EIc��RA�T7�sx��s ��v��՗(F���ˬ�����q���]Z7��	V0���64M���ǲ��@�Op�X�^+�8a(�x�^�'x]��
h�w��֫����:Pr��	|�Xe��9�qXI��fA:��K�!-�SL,[�֋���p$/��ĸ�^�Ǻ/@��=�-�OX�|RM��I�D	m�D��s�)_!�tT#m���4��!i]�;!�W�e�v��{+FNi�>M�'���#uH����z7ABy�#�gQ����{���T�`L�36�#Щ�f��8�e�2�{�Id�ǧ,���F<�O�峀�dQ��9尹����j��	/�}J�!|�[�w��>�Ԋ�V�v�>��b���+�J�>�m&���5�*נ�ɲ"����3	�
��,>	4-���Q��YE;,������5�Š������uI�C
R��	t,��-�h�����n�P��ұ���G�h�OC΋� �Ԥ�u^��4Xolt�r�eF�ЩM�5c#ũ�Z�*-<>�̢C>C�$�7{K�ם��&J��Ib��?Og�8NZ�GN�#��^H��$-��_�K�E�Jn��ݐTj�,[/�mܥ�r˝8����MU�c��Z���5�l� <ߋc`�BKh�����d'?�Е�X����Y����Y%��\�ץ	���dȭI�Ex���?J���m�\���t{ؕ�^�|��Ig���8��̨t���e��-&�Jҁsѣ���)*�W+:$󼙉5yQ�+�-j����#:V�ǖ��eE1�fW�%��������e~eF��=}~A���yN�V��M�ꪃQ��m�ը;�U���eU]�f�W��2{cS�y�XO��e��K� ��Q�3��2��US]�l��强i��!�zYca�Sڛ�m���2 j�`����'Ie�fXU�M�:=�/y�v��+�LM?��Kܯ���|�I�I?��v��۵���S���jV����e�J.�; ���[$�<�O6��؄S�f�e��UW�_��t^o��\ގ��Y�����������nM��͹����+�Xm�O~ b���a��[��������:���Uc���m�F���.��f,���F]L���:X8���-�Ȉf��5��Ŀg�Z�p˟)��#�|�G��&h�D�����B��w�θEK�w��VU�i�m9��݊U������C��$kW����J��8���I�V����|�W#������DT#M��G?V�4V�X�i�诫��-0�����= ����p_�eS�9i�?���������a��������������cB��<�_@GUQT�o^;u�VG���v�8UL�����?�x���;���7�������~b��a��W͘<��O/�e&�m�8��X�h���}���٬Z��Ř1r���]T�K,D5�bsp�H,�kD���c�N�=�.`|��@�Y�Ϯ��W�Q�c�#��fl�4FGqHG�۷���{��k��5/�_g���dW�������wF�j">]�0 " 4Zd�q�.
�5\q�׈�7�Z|Rk���� �eF;By�-~�E��)�1FN$�S�{�I��<�0��<t"�?Cڅ�&8;��LP�;ބ^s�*<&��ߊ�-W��1�Q�"A�ş����8��$�F�ȗ��9\K�m���qs�+��v'8hs�|����Eq�N�>��d4k�a���R�)��������ϣ�h�?ʉ�	��*+����$��%8�O�G2��S��j�w�a�h�ʻ��gm�a �fY��������	�B�$:^:�d�%b-�����d�=��A�G��}(V�{�"����U��Y�2��h�vv�G�K�ë[e>�A<^�������|��}Q����Q��Q�Y48/� :��D5�N*�S�-��2�yDO��r4�y�ՆN�1��K��2�_���%u>#1�BW������t���WG/�>:��������ؾ��Z?SI���/O_�|����N_~m7��E<"5?�
Gt�,��heQ���a�1��lr�O�͚��v������+�'�<3��t�P9zִd�@�nyD���v��5g��4x8�|f�;��L�"~�nj=���4���ȧl�䇓��J�ô�_ī,Wψ��T׺~|�c��%q���������5���&���֬j$�-��7���V�A��$'���D�hK��4m��Z�ka��.�p��8йۡ�',-C(+������6)�dㄬ`���BK,4�G�������=%�9sw=RvU��#Ns}_찫]�9?�)C�8n���I
W�#����0�8������Y����(g�j��R��@B`���	|:�g�y^up��#�,N3?��HoF^�d<�`�_�ڋ�;b;R�O1T��R�!�2ݧ�O�)�	A�����PLG��g�u��?3̟ե��|��w\Qk�eM��+�'�������<��ОoӁ���= <�0��H �i����N�)�16"�n$ѹ
/������L��M���OkZ�w��*��=d�L�RB�iT����ء&��4�ZfX��%~�aϘ�YU,��?��Ԛ�gZ������ӏ�vF���.���}:6,��SB' رo�&���2��������'\��#ӌ�4:V�t��t�s�"���m�O�-���f�/�X���U���Kr��)��T[����kqRܝ8$�]V�l�=����l��p�$�Ar=�����}��+<4m��O�U�N�#=������ר�ȟgX����ے��x�״D���gg�A�񆈗ks���X��Q��O��������x`�s��Vy������ky��'�M��U^��,�vB�����$�d���5p^�"@����k���6Z��V����
ۺsIO{����eQM��R��e�nh�z.�ް4�g�܏��܊Z-/2��ܷ��۪���r����	Ǡ�_��~ EyJ/''�3��{d�<p���~toK?�Os��"�;�-�vρ�Q.���~�,�9���ɴ{_��y?lKf����vS(;h1�]��#0�ڄ1xg�
;̧C7��#t�P%�{8l�	���6�|>G�RH��:;C��b��M.6���bC]�r;c,e    `��+a^���}qI�e��\Kg}>���M���{����4��i��fK�y*�S�����v����\���j�u[�)���@���o�"3�]�ٕ1��`�᰹+M�(��m�v�/m�J޻!��v��]'� �>\F��V���*?b��QAE��CY�*�N�R�����͊�?@��1�4FQ�v�z�j!��/z��'UY)�X�I6���p�릭�$�!��Tۊ$]E"���n�D(V"a7F����dZ�8�:/���X��lC�r��V�A����jV�.l�+R�.�x�%���᰹=�J>�d���w��]u�`-cҍb�aF@�'�!m�ם7����^�� �l%O���@Q~�}�)5FIZ�1��p8&�����]�I��7���940w�\�z�L���E�x������,u�ڡ�� Xp}�H�����8$6w���&3�����ݡ���!���n�'4؞��\�5�}L��/�钪��	��I���%�	�㏤�I�����
� <=�)#�2Av��"�$��],٦�Yb,^1%���8;H�&�9S��H^�~�SX��,��u�ω���x�_��r��xᢪ�Y�I��Ϛ���֫���.C�N	Q���eV������^��:G7?Ӡ�T�9�m[e&� ��1����&�1�U�Z�x�'N���m�4Ķ]b�,#.,��[X�wY�'�����r������;"s��p�p v�/��	���
֥��%�)GZ1I�`Z��B�KX�Ǉo��9UF�����*�F�Ath� 
�JB����M:D�u���5fO8$ᐄCy�8d�h�������X�=6�͟�3jY��R��cԅ�5����}Ӿ��,�j�I�Ǟp���9h+͍E��5=�0�����k>*~D���ӖM���s��&�Z+RDV��4��fw(����@�E
�
]��A&���&ۘl�ò���ѽ �� !��6A�l�՗Z���׫U���!��<��z�=?<cut�o��X��Ŀɓ��/�&}|����_[2��C��Y��+!h<+�pGyd�snG�܎CA�"I�e�ou�����x��]@a0�>���yȐ�p{�Cr����N�4��dv���1����l�L���GQ=g������lY5]4���E����[O������<l̛6[��6i�_׉��ns��`���_ ��H�{?���G�_�'�r�۟Cz��I�{�v�*y�%��Y�2~�t�I�3�D��i8��ml���.wiM�_pk�.�="��?H���r*c���F�E�[~��ON�,�њ�;v��W�-'�}8l
����󠵵��^����DQhV؄Xn
��<�bs �pE�	W$\�p�S����!g�o������O���ӯ�1��	�'k�W�\{�4�r����c?
B]	��v@�_t=�}�}��;��9;d�*A��a3x�8������Y�W�����f��chl�󉬮��N�z��t�[�>�	��D:��Ž8�eS�wE�]�_�3��z����1S���+- ��.%QX�[�����d��/_���٘���]�L���  �X>!w���^&�]P��yl|c��G7S�eƜΆ��k,���(�ږ{��(#��@<ySW��~��<*K�����J۴�����_(�O ����b�I�Rd��2���mz��X���f���7�vE&��<b��#F񈻇��>��?��� jZ��^y&:����7����w"
1%�O��^�0�R��X�fYY{���[����|���/oI�����sT��gL��U;��(s&[PV�<����*�
�>���hJQ�*0���!n�}.�5*6*�&#M��u���JI���pc��i]���mr�jo�������h�Z�[nzc_�_S~AI��!�yP���` JJ~;��䷓�N~{��$a�6�s��
��#-��QV�\�����6z�}�{� !��Q8��63�~v�N�fj��בg�\B��f(VJjY-�2Ģ+C�1�)l�,�;�Y���B��œ6��X���B��&�Qԩ�[U�+���{m�H~kx_L[���MV/�+��+zI��ς�Ҧ�ρ�el~�5w�g���UU1�n�ɢZ��70G˪E�i<d�ĵI��S�5�⳧0���t2�O�L��LU،�|��#7��~��'�����A]��`��3`	�ː`�D���x�}�\՗�`�����e��Ԁ86�6�P��@�gj�xh����-'��)��NJ��p�E�$0���2�	u�v���p�S���ʛ��������%����CôM���Bf�F�K�-G�i�[���25�H�6��2RM�"�N��K4%P�ڦl�>�[D���yr���AMG�v� �!�9L�0�9�(�ی>�\�<�3w�WCPO����p�����4�Wa��z��5���̪�K�{-Q�N��Y�&-��j'JL�{Ѳ'�b�z�W��Y�y�Y�R����o���(*��b:J(5$�����}�u��;1�
:L���9�O�w���D�K���3�ߓ���������[��d ��|� ���y` �v!�gJ�)y����R�C��m�L8.x\U��U�n N^�0u<�<���b�8^�a��G����*}9?�J��0��<_�u梯Kr�b�����A��Iӿ ��c�p�����ɠ'���F��;��-l�~:?
������J ��A��i��vY�[�X���eAp�;��^s+ ��ZaL�h� k�m3��1ý�]�<�&�� ���~e #m�I���8�[3�f�u��;�F�-��(�m�&/�=ˮ���1�6��+���ˡg�� ��\�vC�[���a�v���d�y�kB+����#� ��@Kϕ����P��9u�!_QruP���Q���A�R���UV���bҬ�-]�+�5��Д��W"i�T���!֢_ץL۬Ѫjr��F��yosԒ�/�e2uE���ǒ�AM ��<<�eY�CWɠ'���;��B����9ς����U���~� �&��a�'� >�P�!���J_�r�-%0�ˬ��������%Z�6�(�|�`헊��w������lb�(K'Kdn�Dm�n���������>���<�C���,bH�!!��b�_İ{��{IT�����ݳjJ���_���>{��3օ��_�;�΋К�M�gg�p<�C��95�m�F����+]�/�����AY=[z�9x�otv��$,��:mr*뫬a�����Wu�6��J߲���������lb�1����VtXC�J�M��@#����ȥ��t����MI�f��D=�ZT��d�@B�+���%�S��ۭ�c���dE�/3�.�v���m1_#b�6��֊�	P3!_�.�z��k��r�w��b|����o�֟�"���	E$�WX5b��4�9�N�*ڰ�6�cpm5bo��Z�s>���\��U/@ZϏ�G�(ne�
�ȯ�e9���������C�'w Ew��Jv�2��� μ�V:$�_�:�/�R�-�k4����� ePgzF��.ѧV"ֳ�	=P#ٿ�y3"H�AU�K�z�V�j3��`פ�+�8؅F�8��j"�s����J�ANVˎw�EQܪ��x � R��3�aP]����.�8xN8�;0��Yu+�̷�K�?�[���>̘5�?H� �z��D�ͫ,���F<��+r���8彲�j�Cx5VQl^Ua^u�=��-�x����x5��"����X�f{�7��p�ߠ7��:���t8�c(� �	?L�b!m D��w���+�p��	�"��� �8B�t�$�?�g_>�f6Q��M&j�I��r(P��k�P���Lz�O��޵�:h6Q5���J:��ֈ������m$M]�I�v��Ӑ��!90�K����X�0qz��8�Sn5Q�����֨�A�)LpўDJ6�����8Y#�����MQ�KE;�;���� X  �^%z�C:}�학o�������tD���D\�������z�<BHOI��Q����A���6�W;Z\3���OåO���tݶ�6j�q�5�!�Xb���V+���A~'�a|�FRH���<}����/Ӝ/�J� g������-,'=�,6��	ʁSӋ�rZfy���8k�����K|�"	i��`9Xc��7�r�0/�Дú�"����P�����qD�����V>�)��dhH�;������'������rF*�ܲ�*�l>&�7I� ʢ*� W3��{Ij`�@��ࠅ
t
j�Hf�Oj�]%J���H�xt��[0��DIj�C�[��r�;/���$�!M�n�YQ�GE;��-�f�<J'2�a�/����p^�i�ϣ �<�42�	ee��7N8h��P�֊���3̟V)�Z��"(�;�eq8����9 ��aU)&�z+a�
��b��@ h؋�g��e��J� �|J�I�=�f�|b�x�0�+na��Z�F#�~'�V$���{
����Z�VZ|l
��"���oF�t�����:��}����Q��}<��n� �7�f���9�q���^3��>���0�'4���	��l��|���F/�����a�@��Ϭ ��rX6tk3ԕۋ�9� �V`;9���%U8���`��\�p	�%�0����x���P@�2.\��|հ�O� �3�S���$\����!'m^����"N���ȡ6��}e�;�K<�MKr��)NYg�S#�m���[U�[�|��{�ZuSNպ���7j�كo5��-�M��Zi��	�$4��H���q&PL{�$�ébj���`	����h�����U^�x6�j4��6N�u��PC���.�Ϫ��.W>X���T��-�E�n������{�l������f�'8G���7G���[��l<��<�݁wV��^���Ny��m��ݙ1~��~4��%�0T�P�-�0qۯVhM�U�sϼ�M����%���ו^�Z��Q��?5ޜ��u�/pY/�_��@�/.�Pآ�&!Y�h$��i򧾭 ܇j:n��P-����-�m��{��ݸ�G��)c���@��q��,m<@�Ǉ��gE�����2Qr톬�N����GWu��F�"�U#��XMmᩫ�o�<ʆ���#`,XK��"zkp�Q!�1�V�ZE����%w�h/̶$p���S�}�w4%�vL�@N:oѶ6���m��*����L��!_����h�Aק�'�����tݍپ{v#^  'p�X�7��ۯm�5�;E<hG��s�+���s���]b|c]�_黳.k�	��,���$�s��w����?P+J'����-���~�[)Z���0�V��]I=hv��I��./�2�+i�6���*?�և�x[���'����.�P|�Eo�Kb?=QKf�N��YS���kuax��r��y��r6�1*��OX5����?����?�p�	`y<"��B��&�j;@��5$�a�# נ����i�70Od���uh��6���.��2����2y�]      �      x��]K��4>3���sA�44}#���\�=���������������$�ꮲ�``�R��_>������M�v1.6���{��#��o�2G	�4�AQ��$ɡ�l7$��K����f_=$����S�C�Ƨc2�F��W�)��?	s|�II)���4�rrD���}����kE��埊n������}r���&I�ߪ��c������6�{���y�����US��/R����?���{%~){�8M�O�j����ӄn$���c���g�{H��K���?��p�cB��Q��g�g�&;�b�����6H�.Mc��R��#I��GR$M�r�oT҉J�O����f(ћ�Ӎ�ap�"��ӊ�L�l�q����8	q��Y���hD��SO��&?�����|�������ޤ����
�j} ��d(��^Dq���CP���i%W%����$"e`LZ}D���jP��$�e���������������e�[�O��� ��4P�pn�浒�g�h��^qML��и44��q����Ȕ�I^���l��yН�恏�Ġv
�s�G�<r\�2�8e��A]��j��)�<��ZH�s��i�v}�c� F�����݊�w+�4�B��n`�V44��w+4&�"���iJ?�E��:���{Ͱ�&�鿵���Y3m�S�Ćc��c�I{P�4Є>kCa��" >��11�W�]���*"|�A�d���fG�2Gdon�ln��D=�a�c<{#wi��ង��?��0���L�J%dB�I[S蛒�zF�u wF�_�]I8��.x;y%vR:f�w�k=!�[spnS}�������'���S���5�"اqT)f�ʇ�n;V��c�C̀�F��륊En sR�z�`Q�5��N�V�BA>3)���(��T�W����j��ij{4�i_4&�"����U{�^+h�s��V<|&Q�r6Qy��R���E��G���* �X��V)jS��2��rDq�����ւ۔������� �M�D�Z��yG\�� @�:K�q������y��,-x�M��y�X~e���-+���p9rC�q�LG�a���幚�҅5���e-���(
�o��7&�a9�=nc � �k���B�OIK@�OI{ 30�KL�Sв���ވ��ʿ�����y��W���;(��&8k��	�㬿w���kp�~��+!�4�z���J���u.���V���.y�!	*)B1f�Am�;�a��j��kOtEF� C������p��!DyĉC����m=	k�m��-rӜ抠�~��)Zyu]N�`Tx��#�y�s�&�H�]=��f�G�6A���9��QMB��b~::.Y�NE|:�ò����A^�bu�m�+��@�*�	��P���P�A�)Y�����LU��yH���t ��ow��N��p̉w�-�GKĮ��%љ��I�<���o���k�
j�&)��lp���[�?2Hpԟ���$�g�t�$_����0M�(}N���4�` ��;�}zoTޮO߀l��F�>74Y5	�K}T��J}�+2Vo��<������%<�k^��Ò��S�T��������Fz%��W���)z�����=ߢR:��\�m�lG��j�	i�&��b�JR�<����C�XeE	��l�>�fμ}����>�RJ���M*|�����ս���>з��'�m���񱐷5�lk
z�_��.T6ѷ#*�l���@m��d�dS��fijW�����#��T�G�6fHi?�d2:p��ɤE�t�q���PymP�
N+�D��s3nHX`�Q����4=�^$�f(/�tơ���C���x���]Lcp�\x� �MeN �љ�;Kq�	�-u�TH{zᏕ�I}�&5L�Y�P��P��2�������ݛEt�/8�}���-:�}jz��������SY��*���`06����D>Ɨ�5�p~�u�-��!CI�ki�K�9�}�*g����;���'����>��Q��u>�"8��hNO8���Z���ʬ�1�1�N8�X�;�i�E2��+��'���$���;K���h�b��^HL*�E��M�?Oc��
uy�w.��uM�o��0�A� &�#'+�1K=�ͦYY!�<�HՏU��ʣ����D�;1���I]���US*�*�,�0_�K����7������?���/� �*��u��b�i��&M,oԭ- ����y�����1��
7_�i���=����2�b�Wk��Y0��W�9�[�c�E�k�� e�Ia͵��;z�A"�=\�bw��3p��3Y*xt��v����[XhdE�_p'�{&���W�e�����K���ao'�X*͟���Q,���R.� �բ4��P�/�`9Zp'|����HT&E%.�)Gb&��n��d�ҝIW#�,LNe�b������C,P�8��z���,�ڕ��8^�s(����;fNA�y�1�q]sL���%,F˙��FS�cv�P�b3�0����I4�X4��E�j3RԿ�E܋R�n��q`�7�� [�Ǡ���`��T!�׼������^�`�3���v@F��0�򽚚����<��d��q��E-ms���	ˣ�ޛm6=��g�xt�Tv�$׿)Sb��`�&T("�"����2�h.(�R[ۣu!�8/0<��@��ns��>�cD>[�
|���RY��r)�{�>��<�
�(�8/�˴�Ta������$���(-��R�(��J��:*��_�W�rR!}�:��A6��%u���}܂G�zN�O39o�&S�~,0�;mܛ�J��j6��ʠU�#gڗ���5ӟ�f:�㳮*hS�(��j:Ot�Dj_S�,7�ݛ�D`;4��<,�� wrf!���X5۸c�	v��7����"�S$�t��'�%d�XCFX�6�� �$�rX2b`MV�	��l�‚�Rx�}��
A�^dB>7��b˼��0�p4�I�Μ�$�0ر_��E �uvD�۶�x�2͖�J �5H�	���BvfFZ'5�Q��t��'e䇻���c֚��4��o�}i���m.������4!��)Q�o�g��ZV�~��RZ�#[ۢ5�������g�����;��ߨ�����"�:2����r�%9�� �Y��!�@�p!�ت���f��vE�	�.��އB��Ni	<&Te��Ċ���������Ƭ#Hs�0㕽�����AIr� 6K��%V}�)X,�≸	M
M�m�Lx�Ȕs�π�22��"�-����?�7�[3�/w��bcqzX��a6�MՊ-��u3��|4j W7�&��z����jZZLYH��&��nf"6�\73OG��\ɁȤ��Li��R��H ��Q���u�Q[S'8��E�9�v�9���]O���A^:�>7T8���9�>SQ:�>�r~�0`�ۓZʗ���{�'�g]X.f6�)Oۊ����,�@��M��t,$�S^3��c��H�$��~ǒ�8d�¢�0��=ԡ��,S�R�"���A�U��-Z���u&�{%�S����k����EŸ����������%}ij�C���F�6(�8�.kܴ�C��	ա��szJ�9m��#��suZ�2����Z�+���(�����DvAo��e�A��0M"R{Z��8��Jz��yҬD�y#չ2sDN�uQ��ŲZK��*_��5��f.�Ҟ���F�5*&:)C�m�k�wũ/�nkm�Wܓ�8��D&������4^kvES�p� <"��i\�{&#U�	�_{�Z7d��ZK��*���_^��L��9]e5g/r�QRW&���#'��R>��kb"�Ձ��_s����q%�,�w��A#�Ѭ�Q�D �
#0R\]�8�<^�ܼ���`$��X�gM*�!]I�b�R�/��!�i�[ 3�^��z��R1��;�`���\��l�V#ڊ	;��Jެ7��(Dv3��T�B�WMG�kr���	k��z����m ��   �C2j�7���H�AAI"4�h���N��Gb�)W ���GbT]rz�3'/	?jѕ)�� ��6��[=2͖�J �������BE���N5~CB���W��UQ+/R!}��Z��[-xA�,��| ��v�i�)S`�
�N&�)�@�7�Yc1�j{5r�%�t�4w�"�Y���;�N��P�d��Q:��K���>�Q���"�wJ���t����	kpm�8B�>HPm�J���M�&R]��6��5�K�"���n�K~2,���ʲ9.b���_�;4���t��zr>`od`|�.�D��%�� A|��ϐ�� ����I����&h2��X۱u��8������N/�_���K@p�"4|��j��3�1��#"`1Y=cP93� ��Y�i�# ����ˁt�����%�`R�fI�)qS#�5��0�|M�W_��$=�uP����ۛۻ�n���������w��߾�����/"���o�>�|�!B77��(��>
����w���ݻw��P߇      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�u�1
�0Eg����%Un��:u��	^���'�).���$�Cs�R��\��f;�C7]����U�����xH�=���������6M�s�e�&#�t�l_/����ϝ@���DE>������9�      �      x������ � �      �      x�3�4�4����� �Z      �     x���ώ�0�ϛ�����ת=��U{�e/�8�Ub"��J}�����W��I��x�ctw��G�8����"�Y#ke@������Lw�lQƓ�c^���l�rqmN���esCY��{<	��>��Ca�s��+���(�\��S�R����+%�@Z�i�^�g!�j���6��7cDlk�+.��CU�SY�=���߫�s�-b"N)�$����k�sf�f�z�� k���Ӕ'��yu�g�͚m�p���Ww�܏-��� �g��!��g��g��.�J��X|YY��[�>�'���$��r�8I���Dw|���E%�uǐC�!�1��8x��
u�c~��`���~埕�
N����U}o����-n��
2ʼ�g~������<|��g��m#vJ|�{��y����3��ֶ ۣ�ixԻ���3�s���N�idi'�A��]Q�Iͼ���i����� +Fma����t ��������$� �SbB�P����/ٜzm�L��RF����^I�0�V��<��1i����yu�|��IA0�!�O��u=�����/������#*��0:�*�������^~c&~dD���J^1��sЈd�t\�l@��$��	��"����ƃ�[�X�0E�G�X8\��udq ����'����e|q��;��[��U�2?6Θi�8���� �?�80��������R� �n\;j��RrQ״F�Tv���}�o4����ԡ��'�1�f��X�V�      �   �   x�5�[B!���b�����á�H2G���;1�GZi�+qXe *Y�p*7v����\�"�e�S⮫��)����.Jy����<�X��(Dy�R�W�g�04�x�[e�M���8��j4�P��4a��c��Ԃ��.���<��ȴ�d��T�6����f��l&|6٭6�0�4�m=�@X�b41���&ߓ6M���ޅ�)��y���iMv�&���!Gs#��%ߏ�� �LO3      �   �   x�u�A
�0�ur��@�̤6mv�k� ��5P�RϯbA�
�����P�C��.�}2����!A�$_�5�{��	�-�ZL�	#o֊�u�u5�Yz����U�q��j�ퟑ$�ߗ�5��[ձ�΀�K'�m����R> Y>E9      �     x�u�[��0��k�^xkm9�8x�誙��E�C������캑�k��I�'�IL�nD�������'�!b��OZ�>"i?V�u�e�Iȥj���bp�ϋ��j�n}���V辕���}:_�s>�C^jC��+M^� �x k�����C��$��M�!�TR?��1޲>w���%��В�$Ǟ�éoʿ�Wn�4�!Ȋ���&�5	k"���4�KhUd4E]z!�)�߲��[,�jse��Z�(IY�������:��� {ǈ*IAv�����p�6DM��&M⁌����"�4I�]��7e,�����Ż�f���i�ި��PW�4�w�l�l%p6�tf�b���JwUR��o�I"�P��O/�r�\�����/J�ٖ�/
�YK��PAr�V�ȷ~8����z6c�V���(U	�� ���u���9�u���_D�|��Fb8�TF���4��{�6�8�&���%-o����j��ߋx��) A\��O�h4� ZHF      �      x�3�4�4�4�� �f\1z\\\ ��      �      x������ � �      �      x������ � �      �   �   x�u��
�0@��W�\hҴ��zv��V��U����^ܡx��Agu^ʺ|rQdȍ&�D�IA��6Κ*O�\�7�K~���Ӻ�XЋc ������i��Q�
�L]�j�����e`w}�#h��(:?      �   '   x��1 0İ���'Y¥�qT
a-�\�&qR��~CA      �   b   x�3��TH�UH���KW(�W(N�����r����8�uL|6��钕O�v?���t���M�FF��f�F
F�V��V��z&f���05�+F��� �^$�      �      x�3�4A�=... ��      �      x������ � �      �      x������ � �      �     x�u��n�F��3O��`�䐻"@�n���m��I�����@b��7I�č۴1�V�Q�H�
y�P�ޢg�Tx������\�sF}������� ]G�r�F�5�X����	El�*][�yJ{�.2A���(J0G����%���� g�2�2XR�e��4�J� ��~�xz��d��p�qi�y��>�m�Y�%�?�e1�����.q\թ��,I�-�P1��8�߄	ʁZ��z	��xs�o�1��`m<�3W�a�S/y�a`�Q��A>��Js=YP֩��^gA�a����a1�����s=��t�U�!��8ϟ?kEi�9D	Q�a
J[���tǝ��z�}���󏭩Q�)B!�����x�^1f.ʏ��Q��!�z�@6�T��us����|�t�ⲍ��Q�6k垂�IY�z��`�)f6�]L�韭���FU�	�1"D�]�O1,���aq�ۆ�`N�+;�r�� ��î-~?�Za�G9�iV�%l#���@Vqpю�j��z����J�BǸD�W��i��Ҕc��S/qp�HN���Y��?�'�& (�[Z�K����!����b�?��mf(�>���:�����1x���G�����8�\��d�^�o�8nYXP�����GO�L��c�-�_�_E
"t�c f��?�Yg������omD	=�D=�k���U[{�`ؠ��|~r5�׆S.���NQ��U	�q��Ib�5���V���p<�^����Ћ�;u+����y+Oz�1a��C�Iz�pK����w������a.Vry2!�uT��R/����:l����x��~����4��sQ�zk���\F�^0n�"��.���姇������l0���T���DXpT|:-&ǭƱ�]ژ43�򪍷���Q�[�\��;�������&?�Z�R���K�F���5��ӫ�)�$J��.�zǣ(�	ͯ0S��^#���Ρ}v�^GYb���#,)�g���ɻ�w����7�S/���q�s�3�	��U��      �      x�3�4A�=... ��      �      x������ � �      �   �   x���0B��PLd����:�!K�ȺE̢<�S\�n��W<���#>�_ix]�K�8K�8`K�IX���)6*NXTB\0���aSI��h���������}�h�&�h�&�h����NMF;5-�Դa�SӁљ�.� ?!�)�      �   �   x�3�L��|�8��YCߓ�/�o�,K-J�LK�����K��I�4202�50�5�T00�22�2��3�4B74�21�22�346�4��<N��Ғ��.#����lΧۗ>�;�ZH<�1����/�7�X���?�m�d�����1��&VF�z�&�Vrf����s>ٻ��ҽ�Ov4��X�s���O'�y��"�����P�1�6�22ҳ00ô�� hv��qqq tvB      �   @   x�3�4�4�L�+K-J��M-I����,c.C��P�$1='���HsrA5�q��qqq �@�      �      x������ � �      �      x������ � �     