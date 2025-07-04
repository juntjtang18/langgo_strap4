PGDMP              
            }           langgo-en-dev1    14.18    14.18 (Homebrew) w   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public          strapi    false    253            �           0    0    flashcards_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;
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
       public          strapi    false    257            �           0    0    flashcards_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.flashcards_lesson_links_id_seq OWNED BY public.flashcards_lesson_links.id;
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
       public          strapi    false    259            �           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.flashcards_localizations_links_id_seq OWNED BY public.flashcards_localizations_links.id;
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
       public          strapi    false    261            �           0    0    flashcards_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_user_links_id_seq OWNED BY public.flashcards_user_links.id;
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
       public          strapi    false    263            �           0    0    i18n_locale_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;
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
       public          strapi    false    265            �           0    0    lessonlevels_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.lessonlevels_id_seq OWNED BY public.lessonlevels.id;
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
       public          strapi    false    268            �           0    0    lessons_components_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_components_id_seq OWNED BY public.lessons_components.id;
          public          strapi    false    269                       1259    59043    lessons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.lessons_id_seq;
       public          strapi    false    267            �           0    0    lessons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;
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
       public          strapi    false    271            �           0    0     lessons_lessonlevel_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.lessons_lessonlevel_links_id_seq OWNED BY public.lessons_lessonlevel_links.id;
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
       public          strapi    false    273            �           0    0 "   lessons_localizations_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.lessons_localizations_links_id_seq OWNED BY public.lessons_localizations_links.id;
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
       public          strapi    false    275            �           0    0    lessons_unit_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_unit_links_id_seq OWNED BY public.lessons_unit_links.id;
          public          strapi    false    276            h           1259    60327    review_tires    TABLE     z  CREATE TABLE public.review_tires (
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
       public         heap    strapi    false            g           1259    60326    review_tires_id_seq    SEQUENCE     �   CREATE SEQUENCE public.review_tires_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.review_tires_id_seq;
       public          strapi    false    360            �           0    0    review_tires_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.review_tires_id_seq OWNED BY public.review_tires.id;
          public          strapi    false    359            j           1259    60338     review_tires_localizations_links    TABLE     �   CREATE TABLE public.review_tires_localizations_links (
    id integer NOT NULL,
    review_tire_id integer,
    inv_review_tire_id integer,
    review_tire_order double precision
);
 4   DROP TABLE public.review_tires_localizations_links;
       public         heap    strapi    false            i           1259    60337 '   review_tires_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.review_tires_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.review_tires_localizations_links_id_seq;
       public          strapi    false    362            �           0    0 '   review_tires_localizations_links_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.review_tires_localizations_links_id_seq OWNED BY public.review_tires_localizations_links.id;
          public          strapi    false    361                       1259    59056 
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
       public         heap    strapi    false            l           1259    60396    reviewlogs_flashcard_links    TABLE     �   CREATE TABLE public.reviewlogs_flashcard_links (
    id integer NOT NULL,
    reviewlog_id integer,
    flashcard_id integer,
    reviewlog_order double precision
);
 .   DROP TABLE public.reviewlogs_flashcard_links;
       public         heap    strapi    false            k           1259    60395 !   reviewlogs_flashcard_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_flashcard_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.reviewlogs_flashcard_links_id_seq;
       public          strapi    false    364            �           0    0 !   reviewlogs_flashcard_links_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.reviewlogs_flashcard_links_id_seq OWNED BY public.reviewlogs_flashcard_links.id;
          public          strapi    false    363                       1259    59061    reviewlogs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.reviewlogs_id_seq;
       public          strapi    false    277            �           0    0    reviewlogs_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.reviewlogs_id_seq OWNED BY public.reviewlogs.id;
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
       public          strapi    false    279            �           0    0    reviewlogs_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.reviewlogs_user_links_id_seq OWNED BY public.reviewlogs_user_links.id;
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
       public          strapi    false    282            �           0    0    sections_components_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.sections_components_id_seq OWNED BY public.sections_components.id;
          public          strapi    false    283                       1259    59077    sections_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sections_id_seq;
       public          strapi    false    281            �           0    0    sections_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;
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
       public          strapi    false    285            �           0    0    sections_lesson_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sections_lesson_links_id_seq OWNED BY public.sections_lesson_links.id;
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
       public          strapi    false    287            �           0    0 #   sections_localizations_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.sections_localizations_links_id_seq OWNED BY public.sections_localizations_links.id;
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
       public          strapi    false    290            �           0    0    sentences_components_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sentences_components_id_seq OWNED BY public.sentences_components.id;
          public          strapi    false    291            $           1259    59097    sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sentences_id_seq;
       public          strapi    false    289            �           0    0    sentences_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;
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
       public          strapi    false    293            �           0    0 $   sentences_localizations_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.sentences_localizations_links_id_seq OWNED BY public.sentences_localizations_links.id;
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
       public          strapi    false    295            �           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;
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
       public          strapi    false    297            �           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;
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
       public          strapi    false    299            �           0    0    strapi_api_tokens_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;
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
       public          strapi    false    301            �           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;
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
       public          strapi    false    303            �           0    0    strapi_database_schema_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;
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
       public          strapi    false    305            �           0    0    strapi_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;
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
       public          strapi    false    307            �           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;
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
       public          strapi    false    309                        0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;
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
       public          strapi    false    311                       0    0    strapi_transfer_tokens_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;
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
       public          strapi    false    313                       0    0    strapi_webhooks_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;
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
       public          strapi    false    315                       0    0    units_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;
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
       public          strapi    false    317                       0    0     units_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.units_localizations_links_id_seq OWNED BY public.units_localizations_links.id;
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
       public          strapi    false    319                       0    0    units_precondition_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.units_precondition_links_id_seq OWNED BY public.units_precondition_links.id;
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
       public          strapi    false    321                       0    0    up_permissions_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;
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
       public          strapi    false    323                       0    0     up_permissions_role_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;
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
       public          strapi    false    325                       0    0    up_roles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;
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
       public          strapi    false    327            	           0    0    up_users_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;
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
       public          strapi    false    329            
           0    0    up_users_role_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;
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
       public          strapi    false    331                       0    0    upload_folders_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;
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
       public          strapi    false    333                       0    0 "   upload_folders_parent_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;
          public          strapi    false    334            O           1259    59200    user_sentences    TABLE     E  CREATE TABLE public.user_sentences (
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
       public          strapi    false    335                       0    0    user_sentences_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.user_sentences_id_seq OWNED BY public.user_sentences.id;
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
       public          strapi    false    337                       0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.user_sentences_lesson_links_id_seq OWNED BY public.user_sentences_lesson_links.id;
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
       public          strapi    false    339                       0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public.user_sentences_localizations_links_id_seq OWNED BY public.user_sentences_localizations_links.id;
          public          strapi    false    340            U           1259    59214 +   user_sentences_users_permissions_user_links    TABLE     �   CREATE TABLE public.user_sentences_users_permissions_user_links (
    id integer NOT NULL,
    user_sentence_id integer,
    user_id integer,
    user_sentence_order double precision
);
 ?   DROP TABLE public.user_sentences_users_permissions_user_links;
       public         heap    strapi    false            V           1259    59217 2   user_sentences_users_permissions_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_users_permissions_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.user_sentences_users_permissions_user_links_id_seq;
       public          strapi    false    341                       0    0 2   user_sentences_users_permissions_user_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.user_sentences_users_permissions_user_links_id_seq OWNED BY public.user_sentences_users_permissions_user_links.id;
          public          strapi    false    342            W           1259    59218 
   user_words    TABLE     e  CREATE TABLE public.user_words (
    id integer NOT NULL,
    word character varying(255),
    base_text character varying(255),
    part_of_speech character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);
    DROP TABLE public.user_words;
       public         heap    strapi    false            X           1259    59223    user_words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.user_words_id_seq;
       public          strapi    false    343                       0    0    user_words_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_words_id_seq OWNED BY public.user_words.id;
          public          strapi    false    344            Y           1259    59224    user_words_lesson_links    TABLE     �   CREATE TABLE public.user_words_lesson_links (
    id integer NOT NULL,
    user_word_id integer,
    lesson_id integer,
    user_word_order double precision
);
 +   DROP TABLE public.user_words_lesson_links;
       public         heap    strapi    false            Z           1259    59227    user_words_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.user_words_lesson_links_id_seq;
       public          strapi    false    345                       0    0    user_words_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.user_words_lesson_links_id_seq OWNED BY public.user_words_lesson_links.id;
          public          strapi    false    346            [           1259    59228    user_words_localizations_links    TABLE     �   CREATE TABLE public.user_words_localizations_links (
    id integer NOT NULL,
    user_word_id integer,
    inv_user_word_id integer,
    user_word_order double precision
);
 2   DROP TABLE public.user_words_localizations_links;
       public         heap    strapi    false            \           1259    59231 %   user_words_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.user_words_localizations_links_id_seq;
       public          strapi    false    347                       0    0 %   user_words_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.user_words_localizations_links_id_seq OWNED BY public.user_words_localizations_links.id;
          public          strapi    false    348            ]           1259    59232 '   user_words_users_permissions_user_links    TABLE     �   CREATE TABLE public.user_words_users_permissions_user_links (
    id integer NOT NULL,
    user_word_id integer,
    user_id integer,
    user_word_order double precision
);
 ;   DROP TABLE public.user_words_users_permissions_user_links;
       public         heap    strapi    false            ^           1259    59235 .   user_words_users_permissions_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_users_permissions_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.user_words_users_permissions_user_links_id_seq;
       public          strapi    false    349                       0    0 .   user_words_users_permissions_user_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.user_words_users_permissions_user_links_id_seq OWNED BY public.user_words_users_permissions_user_links.id;
          public          strapi    false    350            _           1259    59236    words    TABLE     �  CREATE TABLE public.words (
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
       public         heap    strapi    false            `           1259    59241    words_components    TABLE     �   CREATE TABLE public.words_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 $   DROP TABLE public.words_components;
       public         heap    strapi    false            a           1259    59246    words_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.words_components_id_seq;
       public          strapi    false    352                       0    0    words_components_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.words_components_id_seq OWNED BY public.words_components.id;
          public          strapi    false    353            b           1259    59247    words_example_sentences_links    TABLE     �   CREATE TABLE public.words_example_sentences_links (
    id integer NOT NULL,
    word_id integer,
    sentence_id integer,
    sentence_order double precision,
    word_order double precision
);
 1   DROP TABLE public.words_example_sentences_links;
       public         heap    strapi    false            c           1259    59250 $   words_example_sentences_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_example_sentences_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.words_example_sentences_links_id_seq;
       public          strapi    false    354                       0    0 $   words_example_sentences_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.words_example_sentences_links_id_seq OWNED BY public.words_example_sentences_links.id;
          public          strapi    false    355            d           1259    59251    words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.words_id_seq;
       public          strapi    false    351                       0    0    words_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;
          public          strapi    false    356            e           1259    59252    words_localizations_links    TABLE     �   CREATE TABLE public.words_localizations_links (
    id integer NOT NULL,
    word_id integer,
    inv_word_id integer,
    word_order double precision
);
 -   DROP TABLE public.words_localizations_links;
       public         heap    strapi    false            f           1259    59255     words_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.words_localizations_links_id_seq;
       public          strapi    false    357                       0    0     words_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.words_localizations_links_id_seq OWNED BY public.words_localizations_links.id;
          public          strapi    false    358            8           2604    59256    admin_permissions id    DEFAULT     |   ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);
 C   ALTER TABLE public.admin_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    210    209            9           2604    59257    admin_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);
 N   ALTER TABLE public.admin_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    212    211            :           2604    59258    admin_roles id    DEFAULT     p   ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);
 =   ALTER TABLE public.admin_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    214    213            ;           2604    59259    admin_users id    DEFAULT     p   ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);
 =   ALTER TABLE public.admin_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    216    215            <           2604    59260    admin_users_roles_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);
 I   ALTER TABLE public.admin_users_roles_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    218    217            =           2604    59261    components_a_external_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_external_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_external_videos_id_seq'::regclass);
 N   ALTER TABLE public.components_a_external_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    220    219            >           2604    59262    components_a_pagebreakers id    DEFAULT     �   ALTER TABLE ONLY public.components_a_pagebreakers ALTER COLUMN id SET DEFAULT nextval('public.components_a_pagebreakers_id_seq'::regclass);
 K   ALTER TABLE public.components_a_pagebreakers ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    222    221            ?           2604    59263    components_a_quizzes id    DEFAULT     �   ALTER TABLE ONLY public.components_a_quizzes ALTER COLUMN id SET DEFAULT nextval('public.components_a_quizzes_id_seq'::regclass);
 F   ALTER TABLE public.components_a_quizzes ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    224    223            @           2604    59264    components_a_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    226    225            A           2604    59265 (   components_a_sent_refs_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_sentence_links_id_seq'::regclass);
 W   ALTER TABLE public.components_a_sent_refs_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    228    227            B           2604    59266    components_a_taglists id    DEFAULT     �   ALTER TABLE ONLY public.components_a_taglists ALTER COLUMN id SET DEFAULT nextval('public.components_a_taglists_id_seq'::regclass);
 G   ALTER TABLE public.components_a_taglists ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    230    229            C           2604    59267    components_a_user_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    232    231            D           2604    59268 2   components_a_user_sent_refs_user_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_user_sentence_links_id_seq'::regclass);
 a   ALTER TABLE public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    234    233            E           2604    59269    components_a_user_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    236    235            F           2604    59270 .   components_a_user_word_refs_user_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_user_word_links_id_seq'::regclass);
 ]   ALTER TABLE public.components_a_user_word_refs_user_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    238    237            G           2604    59271    components_a_verb_metas id    DEFAULT     �   ALTER TABLE ONLY public.components_a_verb_metas ALTER COLUMN id SET DEFAULT nextval('public.components_a_verb_metas_id_seq'::regclass);
 I   ALTER TABLE public.components_a_verb_metas ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    240    239            H           2604    59272    components_a_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_videos_id_seq'::regclass);
 E   ALTER TABLE public.components_a_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    242    241            I           2604    59273    components_a_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    244    243            J           2604    59274 $   components_a_word_refs_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_word_links_id_seq'::regclass);
 S   ALTER TABLE public.components_a_word_refs_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    246    245            K           2604    59275    files id    DEFAULT     d   ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
 7   ALTER TABLE public.files ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    250    247            L           2604    59276    files_folder_links id    DEFAULT     ~   ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);
 D   ALTER TABLE public.files_folder_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    249    248            M           2604    59277    files_related_morphs id    DEFAULT     �   ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);
 F   ALTER TABLE public.files_related_morphs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    252    251            N           2604    59278    flashcards id    DEFAULT     n   ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);
 <   ALTER TABLE public.flashcards ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    256    253            O           2604    59279    flashcards_components id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_components ALTER COLUMN id SET DEFAULT nextval('public.flashcards_components_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    255    254            P           2604    59280    flashcards_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.flashcards_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    258    257            Q           2604    59281 !   flashcards_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.flashcards_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    260    259            R           2604    59282    flashcards_user_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_user_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_user_links_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    262    261            S           2604    59283    i18n_locale id    DEFAULT     p   ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);
 =   ALTER TABLE public.i18n_locale ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    264    263            T           2604    59284    lessonlevels id    DEFAULT     r   ALTER TABLE ONLY public.lessonlevels ALTER COLUMN id SET DEFAULT nextval('public.lessonlevels_id_seq'::regclass);
 >   ALTER TABLE public.lessonlevels ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    266    265            U           2604    59285 
   lessons id    DEFAULT     h   ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);
 9   ALTER TABLE public.lessons ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    270    267            V           2604    59286    lessons_components id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_components ALTER COLUMN id SET DEFAULT nextval('public.lessons_components_id_seq'::regclass);
 D   ALTER TABLE public.lessons_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    269    268            W           2604    59287    lessons_lessonlevel_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_lessonlevel_links_id_seq'::regclass);
 K   ALTER TABLE public.lessons_lessonlevel_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    272    271            X           2604    59288    lessons_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_localizations_links_id_seq'::regclass);
 M   ALTER TABLE public.lessons_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    274    273            Y           2604    59289    lessons_unit_links id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_unit_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_unit_links_id_seq'::regclass);
 D   ALTER TABLE public.lessons_unit_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    276    275            �           2604    60330    review_tires id    DEFAULT     r   ALTER TABLE ONLY public.review_tires ALTER COLUMN id SET DEFAULT nextval('public.review_tires_id_seq'::regclass);
 >   ALTER TABLE public.review_tires ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    360    359    360            �           2604    60341 #   review_tires_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.review_tires_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.review_tires_localizations_links_id_seq'::regclass);
 R   ALTER TABLE public.review_tires_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    362    361    362            Z           2604    59290    reviewlogs id    DEFAULT     n   ALTER TABLE ONLY public.reviewlogs ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_id_seq'::regclass);
 <   ALTER TABLE public.reviewlogs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    278    277            �           2604    60399    reviewlogs_flashcard_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_flashcard_links_id_seq'::regclass);
 L   ALTER TABLE public.reviewlogs_flashcard_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    364    363    364            [           2604    59291    reviewlogs_user_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_user_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_user_links_id_seq'::regclass);
 G   ALTER TABLE public.reviewlogs_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    280    279            \           2604    59292    sections id    DEFAULT     j   ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);
 :   ALTER TABLE public.sections ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    284    281            ]           2604    59293    sections_components id    DEFAULT     �   ALTER TABLE ONLY public.sections_components ALTER COLUMN id SET DEFAULT nextval('public.sections_components_id_seq'::regclass);
 E   ALTER TABLE public.sections_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    283    282            ^           2604    59294    sections_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.sections_lesson_links_id_seq'::regclass);
 G   ALTER TABLE public.sections_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    286    285            _           2604    59295    sections_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sections_localizations_links_id_seq'::regclass);
 N   ALTER TABLE public.sections_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    288    287            `           2604    59296    sentences id    DEFAULT     l   ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);
 ;   ALTER TABLE public.sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    292    289            a           2604    59297    sentences_components id    DEFAULT     �   ALTER TABLE ONLY public.sentences_components ALTER COLUMN id SET DEFAULT nextval('public.sentences_components_id_seq'::regclass);
 F   ALTER TABLE public.sentences_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    291    290            b           2604    59298     sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sentences_localizations_links_id_seq'::regclass);
 O   ALTER TABLE public.sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    294    293            c           2604    59299    strapi_api_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);
 N   ALTER TABLE public.strapi_api_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    296    295            d           2604    59300 +   strapi_api_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);
 Z   ALTER TABLE public.strapi_api_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    298    297            e           2604    59301    strapi_api_tokens id    DEFAULT     |   ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);
 C   ALTER TABLE public.strapi_api_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    300    299            f           2604    59302    strapi_core_store_settings id    DEFAULT     �   ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);
 L   ALTER TABLE public.strapi_core_store_settings ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    302    301            g           2604    59303    strapi_database_schema id    DEFAULT     �   ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);
 H   ALTER TABLE public.strapi_database_schema ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    304    303            h           2604    59304    strapi_migrations id    DEFAULT     |   ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);
 C   ALTER TABLE public.strapi_migrations ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    306    305            i           2604    59305 $   strapi_transfer_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);
 S   ALTER TABLE public.strapi_transfer_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    308    307            j           2604    59306 0   strapi_transfer_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);
 _   ALTER TABLE public.strapi_transfer_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    310    309            k           2604    59307    strapi_transfer_tokens id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);
 H   ALTER TABLE public.strapi_transfer_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    312    311            l           2604    59308    strapi_webhooks id    DEFAULT     x   ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);
 A   ALTER TABLE public.strapi_webhooks ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    314    313            m           2604    59309    units id    DEFAULT     d   ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);
 7   ALTER TABLE public.units ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    316    315            n           2604    59310    units_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.units_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.units_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.units_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    318    317            o           2604    59311    units_precondition_links id    DEFAULT     �   ALTER TABLE ONLY public.units_precondition_links ALTER COLUMN id SET DEFAULT nextval('public.units_precondition_links_id_seq'::regclass);
 J   ALTER TABLE public.units_precondition_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    320    319            p           2604    59312    up_permissions id    DEFAULT     v   ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);
 @   ALTER TABLE public.up_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    322    321            q           2604    59313    up_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);
 K   ALTER TABLE public.up_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    324    323            r           2604    59314    up_roles id    DEFAULT     j   ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);
 :   ALTER TABLE public.up_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    326    325            s           2604    59315    up_users id    DEFAULT     j   ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);
 :   ALTER TABLE public.up_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    328    327            t           2604    59316    up_users_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);
 E   ALTER TABLE public.up_users_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    330    329            u           2604    59317    upload_folders id    DEFAULT     v   ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);
 @   ALTER TABLE public.upload_folders ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    332    331            v           2604    59318    upload_folders_parent_links id    DEFAULT     �   ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);
 M   ALTER TABLE public.upload_folders_parent_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    334    333            w           2604    59319    user_sentences id    DEFAULT     v   ALTER TABLE ONLY public.user_sentences ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_id_seq'::regclass);
 @   ALTER TABLE public.user_sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    336    335            x           2604    59320    user_sentences_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_lesson_links_id_seq'::regclass);
 M   ALTER TABLE public.user_sentences_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    338    337            y           2604    59321 %   user_sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_localizations_links_id_seq'::regclass);
 T   ALTER TABLE public.user_sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    340    339            z           2604    59322 .   user_sentences_users_permissions_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_users_permissions_user_links_id_seq'::regclass);
 ]   ALTER TABLE public.user_sentences_users_permissions_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    342    341            {           2604    59323    user_words id    DEFAULT     n   ALTER TABLE ONLY public.user_words ALTER COLUMN id SET DEFAULT nextval('public.user_words_id_seq'::regclass);
 <   ALTER TABLE public.user_words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    344    343            |           2604    59324    user_words_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.user_words_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    346    345            }           2604    59325 !   user_words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.user_words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    348    347            ~           2604    59326 *   user_words_users_permissions_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_users_permissions_user_links_id_seq'::regclass);
 Y   ALTER TABLE public.user_words_users_permissions_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    350    349                       2604    59327    words id    DEFAULT     d   ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);
 7   ALTER TABLE public.words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    356    351            �           2604    59328    words_components id    DEFAULT     z   ALTER TABLE ONLY public.words_components ALTER COLUMN id SET DEFAULT nextval('public.words_components_id_seq'::regclass);
 B   ALTER TABLE public.words_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    353    352            �           2604    59329     words_example_sentences_links id    DEFAULT     �   ALTER TABLE ONLY public.words_example_sentences_links ALTER COLUMN id SET DEFAULT nextval('public.words_example_sentences_links_id_seq'::regclass);
 O   ALTER TABLE public.words_example_sentences_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    355    354            �           2604    59330    words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.words_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    358    357            (          0    58893    admin_permissions 
   TABLE DATA           �   COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    209   <�      *          0    58899    admin_permissions_role_links 
   TABLE DATA           d   COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    211   ��      ,          0    58903    admin_roles 
   TABLE DATA           x   COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    213   ��      .          0    58909    admin_users 
   TABLE DATA           �   COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    215   g�      0          0    58915    admin_users_roles_links 
   TABLE DATA           _   COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
    public          strapi    false    217   �      2          0    58919    components_a_external_videos 
   TABLE DATA           H   COPY public.components_a_external_videos (id, url, caption) FROM stdin;
    public          strapi    false    219   $�      4          0    58925    components_a_pagebreakers 
   TABLE DATA           O   COPY public.components_a_pagebreakers (id, backbutton, nextbutton) FROM stdin;
    public          strapi    false    221   A�      6          0    58929    components_a_quizzes 
   TABLE DATA           Z   COPY public.components_a_quizzes (id, question, options, answer, explanation) FROM stdin;
    public          strapi    false    223   ^�      8          0    58935    components_a_sent_refs 
   TABLE DATA           4   COPY public.components_a_sent_refs (id) FROM stdin;
    public          strapi    false    225   {�      :          0    58939 %   components_a_sent_refs_sentence_links 
   TABLE DATA           ]   COPY public.components_a_sent_refs_sentence_links (id, sent_ref_id, sentence_id) FROM stdin;
    public          strapi    false    227   ��      <          0    58943    components_a_taglists 
   TABLE DATA           8   COPY public.components_a_taglists (id, tag) FROM stdin;
    public          strapi    false    229   ��      >          0    58947    components_a_user_sent_refs 
   TABLE DATA           9   COPY public.components_a_user_sent_refs (id) FROM stdin;
    public          strapi    false    231   ��      @          0    58951 /   components_a_user_sent_refs_user_sentence_links 
   TABLE DATA           q   COPY public.components_a_user_sent_refs_user_sentence_links (id, user_sent_ref_id, user_sentence_id) FROM stdin;
    public          strapi    false    233   �      B          0    58955    components_a_user_word_refs 
   TABLE DATA           9   COPY public.components_a_user_word_refs (id) FROM stdin;
    public          strapi    false    235   (�      D          0    58959 +   components_a_user_word_refs_user_word_links 
   TABLE DATA           i   COPY public.components_a_user_word_refs_user_word_links (id, user_word_ref_id, user_word_id) FROM stdin;
    public          strapi    false    237   I�      F          0    58963    components_a_verb_metas 
   TABLE DATA           �   COPY public.components_a_verb_metas (id, simple_past, past_participle, present_participle, thirdperson_singular, auxiliary_verb, conjugations) FROM stdin;
    public          strapi    false    239   p�      H          0    58969    components_a_videos 
   TABLE DATA           1   COPY public.components_a_videos (id) FROM stdin;
    public          strapi    false    241   ��      J          0    58973    components_a_word_refs 
   TABLE DATA           4   COPY public.components_a_word_refs (id) FROM stdin;
    public          strapi    false    243   ��      L          0    58977 !   components_a_word_refs_word_links 
   TABLE DATA           U   COPY public.components_a_word_refs_word_links (id, word_ref_id, word_id) FROM stdin;
    public          strapi    false    245   ��      N          0    58981    files 
   TABLE DATA           �   COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    247   �      O          0    58986    files_folder_links 
   TABLE DATA           P   COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
    public          strapi    false    248   9�      R          0    58991    files_related_morphs 
   TABLE DATA           e   COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
    public          strapi    false    251   V�      T          0    58997 
   flashcards 
   TABLE DATA           �   COPY public.flashcards (id, created_at, updated_at, created_by_id, updated_by_id, locale, last_reviewed_at, is_remembered, correct_streak, wrong_streak) FROM stdin;
    public          strapi    false    253   s�      U          0    59001    flashcards_components 
   TABLE DATA           l   COPY public.flashcards_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    254   ?�      X          0    59008    flashcards_lesson_links 
   TABLE DATA           _   COPY public.flashcards_lesson_links (id, flashcard_id, lesson_id, flashcard_order) FROM stdin;
    public          strapi    false    257   ��      Z          0    59012    flashcards_localizations_links 
   TABLE DATA           m   COPY public.flashcards_localizations_links (id, flashcard_id, inv_flashcard_id, flashcard_order) FROM stdin;
    public          strapi    false    259   ��      \          0    59016    flashcards_user_links 
   TABLE DATA           [   COPY public.flashcards_user_links (id, flashcard_id, user_id, flashcard_order) FROM stdin;
    public          strapi    false    261   ��      ^          0    59020    i18n_locale 
   TABLE DATA           k   COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    263   )�      `          0    59026    lessonlevels 
   TABLE DATA           t   COPY public.lessonlevels (id, level, created_at, updated_at, created_by_id, updated_by_id, description) FROM stdin;
    public          strapi    false    265   u�      b          0    59032    lessons 
   TABLE DATA           �   COPY public.lessons (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    267   ��      c          0    59037    lessons_components 
   TABLE DATA           i   COPY public.lessons_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    268   ��      f          0    59044    lessons_lessonlevel_links 
   TABLE DATA           `   COPY public.lessons_lessonlevel_links (id, lesson_id, lessonlevel_id, lesson_order) FROM stdin;
    public          strapi    false    271   	�      h          0    59048    lessons_localizations_links 
   TABLE DATA           a   COPY public.lessons_localizations_links (id, lesson_id, inv_lesson_id, lesson_order) FROM stdin;
    public          strapi    false    273   &�      j          0    59052    lessons_unit_links 
   TABLE DATA           R   COPY public.lessons_unit_links (id, lesson_id, unit_id, lesson_order) FROM stdin;
    public          strapi    false    275   C�      �          0    60327    review_tires 
   TABLE DATA           �   COPY public.review_tires (id, tier, min_streak, max_streak, cooldown_hours, demote_bar, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    360   `�      �          0    60338     review_tires_localizations_links 
   TABLE DATA           u   COPY public.review_tires_localizations_links (id, review_tire_id, inv_review_tire_id, review_tire_order) FROM stdin;
    public          strapi    false    362   �      l          0    59056 
   reviewlogs 
   TABLE DATA           z   COPY public.reviewlogs (id, level, result, created_at, updated_at, created_by_id, updated_by_id, reviewed_at) FROM stdin;
    public          strapi    false    277   4�      �          0    60396    reviewlogs_flashcard_links 
   TABLE DATA           e   COPY public.reviewlogs_flashcard_links (id, reviewlog_id, flashcard_id, reviewlog_order) FROM stdin;
    public          strapi    false    364   ��      n          0    59062    reviewlogs_user_links 
   TABLE DATA           [   COPY public.reviewlogs_user_links (id, reviewlog_id, user_id, reviewlog_order) FROM stdin;
    public          strapi    false    279   ��      p          0    59066    sections 
   TABLE DATA           t   COPY public.sections (id, title, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    281   �      q          0    59071    sections_components 
   TABLE DATA           j   COPY public.sections_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    282   ��      t          0    59078    sections_lesson_links 
   TABLE DATA           Y   COPY public.sections_lesson_links (id, section_id, lesson_id, section_order) FROM stdin;
    public          strapi    false    285   ��      v          0    59082    sections_localizations_links 
   TABLE DATA           e   COPY public.sections_localizations_links (id, section_id, inv_section_id, section_order) FROM stdin;
    public          strapi    false    287   �      x          0    59086 	   sentences 
   TABLE DATA           �   COPY public.sentences (id, title, instruction, base_text, target_text, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    289   �      y          0    59091    sentences_components 
   TABLE DATA           k   COPY public.sentences_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    290   ��      |          0    59098    sentences_localizations_links 
   TABLE DATA           i   COPY public.sentences_localizations_links (id, sentence_id, inv_sentence_id, sentence_order) FROM stdin;
    public          strapi    false    293   ��      ~          0    59102    strapi_api_token_permissions 
   TABLE DATA           x   COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    295   �      �          0    59106 (   strapi_api_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
    public          strapi    false    297   6�      �          0    59110    strapi_api_tokens 
   TABLE DATA           �   COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    299   S�      �          0    59116    strapi_core_store_settings 
   TABLE DATA           \   COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
    public          strapi    false    301   p�      �          0    59122    strapi_database_schema 
   TABLE DATA           J   COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
    public          strapi    false    303   �      �          0    59128    strapi_migrations 
   TABLE DATA           =   COPY public.strapi_migrations (id, name, "time") FROM stdin;
    public          strapi    false    305   z      �          0    59132 !   strapi_transfer_token_permissions 
   TABLE DATA           }   COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    307   �      �          0    59136 -   strapi_transfer_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
    public          strapi    false    309   �      �          0    59140    strapi_transfer_tokens 
   TABLE DATA           �   COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    311   �      �          0    59146    strapi_webhooks 
   TABLE DATA           R   COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
    public          strapi    false    313   �      �          0    59152    units 
   TABLE DATA           �   COPY public.units (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    315         �          0    59158    units_localizations_links 
   TABLE DATA           Y   COPY public.units_localizations_links (id, unit_id, inv_unit_id, unit_order) FROM stdin;
    public          strapi    false    317   �      �          0    59162    units_precondition_links 
   TABLE DATA           L   COPY public.units_precondition_links (id, unit_id, inv_unit_id) FROM stdin;
    public          strapi    false    319   �      �          0    59166    up_permissions 
   TABLE DATA           j   COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    321   �      �          0    59170    up_permissions_role_links 
   TABLE DATA           a   COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    323   �      �          0    59174    up_roles 
   TABLE DATA           u   COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    325   D      �          0    59180    up_users 
   TABLE DATA           �   COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    327   �      �          0    59186    up_users_role_links 
   TABLE DATA           O   COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
    public          strapi    false    329   �      �          0    59190    upload_folders 
   TABLE DATA           w   COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    331          �          0    59196    upload_folders_parent_links 
   TABLE DATA           a   COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
    public          strapi    false    333         �          0    59200    user_sentences 
   TABLE DATA           �   COPY public.user_sentences (id, target_text, base_text, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    335   :      �          0    59206    user_sentences_lesson_links 
   TABLE DATA           k   COPY public.user_sentences_lesson_links (id, user_sentence_id, lesson_id, user_sentence_order) FROM stdin;
    public          strapi    false    337   �      �          0    59210 "   user_sentences_localizations_links 
   TABLE DATA           }   COPY public.user_sentences_localizations_links (id, user_sentence_id, inv_user_sentence_id, user_sentence_order) FROM stdin;
    public          strapi    false    339   �      �          0    59214 +   user_sentences_users_permissions_user_links 
   TABLE DATA           y   COPY public.user_sentences_users_permissions_user_links (id, user_sentence_id, user_id, user_sentence_order) FROM stdin;
    public          strapi    false    341   �      �          0    59218 
   user_words 
   TABLE DATA           �   COPY public.user_words (id, word, base_text, part_of_speech, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    343         �          0    59224    user_words_lesson_links 
   TABLE DATA           _   COPY public.user_words_lesson_links (id, user_word_id, lesson_id, user_word_order) FROM stdin;
    public          strapi    false    345   �      �          0    59228    user_words_localizations_links 
   TABLE DATA           m   COPY public.user_words_localizations_links (id, user_word_id, inv_user_word_id, user_word_order) FROM stdin;
    public          strapi    false    347   �      �          0    59232 '   user_words_users_permissions_user_links 
   TABLE DATA           m   COPY public.user_words_users_permissions_user_links (id, user_word_id, user_id, user_word_order) FROM stdin;
    public          strapi    false    349   �      �          0    59236    words 
   TABLE DATA           �   COPY public.words (id, word, base_text, instruction, part_of_speech, gender, article, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    351          �          0    59241    words_components 
   TABLE DATA           g   COPY public.words_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    352   �      �          0    59247    words_example_sentences_links 
   TABLE DATA           m   COPY public.words_example_sentences_links (id, word_id, sentence_id, sentence_order, word_order) FROM stdin;
    public          strapi    false    354   D      �          0    59252    words_localizations_links 
   TABLE DATA           Y   COPY public.words_localizations_links (id, word_id, inv_word_id, word_order) FROM stdin;
    public          strapi    false    357   a                 0    0    admin_permissions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.admin_permissions_id_seq', 238, true);
          public          strapi    false    210                       0    0 #   admin_permissions_role_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 238, true);
          public          strapi    false    212                       0    0    admin_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);
          public          strapi    false    214                       0    0    admin_users_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);
          public          strapi    false    216                       0    0    admin_users_roles_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);
          public          strapi    false    218                       0    0 #   components_a_external_videos_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.components_a_external_videos_id_seq', 1, false);
          public          strapi    false    220                       0    0     components_a_pagebreakers_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.components_a_pagebreakers_id_seq', 1, false);
          public          strapi    false    222                        0    0    components_a_quizzes_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_quizzes_id_seq', 1, false);
          public          strapi    false    224            !           0    0    components_a_sent_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_sent_refs_id_seq', 1, true);
          public          strapi    false    226            "           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.components_a_sent_refs_sentence_links_id_seq', 1, true);
          public          strapi    false    228            #           0    0    components_a_taglists_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_taglists_id_seq', 2, true);
          public          strapi    false    230            $           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.components_a_user_sent_refs_id_seq', 1, true);
          public          strapi    false    232            %           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('public.components_a_user_sent_refs_user_sentence_links_id_seq', 1, true);
          public          strapi    false    234            &           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.components_a_user_word_refs_id_seq', 2, true);
          public          strapi    false    236            '           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('public.components_a_user_word_refs_user_word_links_id_seq', 2, true);
          public          strapi    false    238            (           0    0    components_a_verb_metas_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.components_a_verb_metas_id_seq', 1, true);
          public          strapi    false    240            )           0    0    components_a_videos_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.components_a_videos_id_seq', 1, false);
          public          strapi    false    242            *           0    0    components_a_word_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_word_refs_id_seq', 4, true);
          public          strapi    false    244            +           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.components_a_word_refs_word_links_id_seq', 4, true);
          public          strapi    false    246            ,           0    0    files_folder_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);
          public          strapi    false    249            -           0    0    files_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.files_id_seq', 1, false);
          public          strapi    false    250            .           0    0    files_related_morphs_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);
          public          strapi    false    252            /           0    0    flashcards_components_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.flashcards_components_id_seq', 40, true);
          public          strapi    false    255            0           0    0    flashcards_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.flashcards_id_seq', 6, true);
          public          strapi    false    256            1           0    0    flashcards_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.flashcards_lesson_links_id_seq', 1, true);
          public          strapi    false    258            2           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.flashcards_localizations_links_id_seq', 1, false);
          public          strapi    false    260            3           0    0    flashcards_user_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.flashcards_user_links_id_seq', 7, true);
          public          strapi    false    262            4           0    0    i18n_locale_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);
          public          strapi    false    264            5           0    0    lessonlevels_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.lessonlevels_id_seq', 1, false);
          public          strapi    false    266            6           0    0    lessons_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_components_id_seq', 1, false);
          public          strapi    false    269            7           0    0    lessons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.lessons_id_seq', 1, true);
          public          strapi    false    270            8           0    0     lessons_lessonlevel_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.lessons_lessonlevel_links_id_seq', 1, false);
          public          strapi    false    272            9           0    0 "   lessons_localizations_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.lessons_localizations_links_id_seq', 1, false);
          public          strapi    false    274            :           0    0    lessons_unit_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_unit_links_id_seq', 1, false);
          public          strapi    false    276            ;           0    0    review_tires_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.review_tires_id_seq', 5, true);
          public          strapi    false    359            <           0    0 '   review_tires_localizations_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.review_tires_localizations_links_id_seq', 1, false);
          public          strapi    false    361            =           0    0 !   reviewlogs_flashcard_links_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.reviewlogs_flashcard_links_id_seq', 37, true);
          public          strapi    false    363            >           0    0    reviewlogs_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.reviewlogs_id_seq', 64, true);
          public          strapi    false    278            ?           0    0    reviewlogs_user_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.reviewlogs_user_links_id_seq', 64, true);
          public          strapi    false    280            @           0    0    sections_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sections_components_id_seq', 2, true);
          public          strapi    false    283            A           0    0    sections_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sections_id_seq', 3, true);
          public          strapi    false    284            B           0    0    sections_lesson_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sections_lesson_links_id_seq', 3, true);
          public          strapi    false    286            C           0    0 #   sections_localizations_links_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sections_localizations_links_id_seq', 1, false);
          public          strapi    false    288            D           0    0    sentences_components_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sentences_components_id_seq', 1, false);
          public          strapi    false    291            E           0    0    sentences_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sentences_id_seq', 2, true);
          public          strapi    false    292            F           0    0 $   sentences_localizations_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    294            G           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);
          public          strapi    false    296            H           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    298            I           0    0    strapi_api_tokens_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);
          public          strapi    false    300            J           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 45, true);
          public          strapi    false    302            K           0    0    strapi_database_schema_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 47, true);
          public          strapi    false    304            L           0    0    strapi_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);
          public          strapi    false    306            M           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);
          public          strapi    false    308            N           0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    310            O           0    0    strapi_transfer_tokens_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);
          public          strapi    false    312            P           0    0    strapi_webhooks_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);
          public          strapi    false    314            Q           0    0    units_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.units_id_seq', 2, true);
          public          strapi    false    316            R           0    0     units_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.units_localizations_links_id_seq', 1, false);
          public          strapi    false    318            S           0    0    units_precondition_links_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.units_precondition_links_id_seq', 2, true);
          public          strapi    false    320            T           0    0    up_permissions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.up_permissions_id_seq', 32, true);
          public          strapi    false    322            U           0    0     up_permissions_role_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 32, true);
          public          strapi    false    324            V           0    0    up_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);
          public          strapi    false    326            W           0    0    up_users_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_users_id_seq', 8, true);
          public          strapi    false    328            X           0    0    up_users_role_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 8, true);
          public          strapi    false    330            Y           0    0    upload_folders_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);
          public          strapi    false    332            Z           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);
          public          strapi    false    334            [           0    0    user_sentences_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.user_sentences_id_seq', 1, true);
          public          strapi    false    336            \           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.user_sentences_lesson_links_id_seq', 1, true);
          public          strapi    false    338            ]           0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.user_sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    340            ^           0    0 2   user_sentences_users_permissions_user_links_id_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('public.user_sentences_users_permissions_user_links_id_seq', 1, true);
          public          strapi    false    342            _           0    0    user_words_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_words_id_seq', 2, true);
          public          strapi    false    344            `           0    0    user_words_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.user_words_lesson_links_id_seq', 1, true);
          public          strapi    false    346            a           0    0 %   user_words_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.user_words_localizations_links_id_seq', 1, false);
          public          strapi    false    348            b           0    0 .   user_words_users_permissions_user_links_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.user_words_users_permissions_user_links_id_seq', 3, true);
          public          strapi    false    350            c           0    0    words_components_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.words_components_id_seq', 6, true);
          public          strapi    false    353            d           0    0 $   words_example_sentences_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.words_example_sentences_links_id_seq', 1, false);
          public          strapi    false    355            e           0    0    words_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.words_id_seq', 3, true);
          public          strapi    false    356            f           0    0     words_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.words_localizations_links_id_seq', 1, false);
          public          strapi    false    358            �           2606    59334 (   admin_permissions admin_permissions_pkey 
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
       public            strapi    false    257            �           2606    59396 6   flashcards_lesson_links flashcards_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_unique UNIQUE (flashcard_id, lesson_id);
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_unique;
       public            strapi    false    257    257            �           2606    59398 B   flashcards_localizations_links flashcards_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_pkey;
       public            strapi    false    259            �           2606    59400 D   flashcards_localizations_links flashcards_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_unique UNIQUE (flashcard_id, inv_flashcard_id);
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_unique;
       public            strapi    false    259    259            �           2606    59402    flashcards flashcards_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_pkey;
       public            strapi    false    253            �           2606    60434 '   flashcards_components flashcards_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_unique UNIQUE (entity_id, component_id, field, component_type);
 Q   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_unique;
       public            strapi    false    254    254    254    254                        2606    59406 0   flashcards_user_links flashcards_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_pkey;
       public            strapi    false    261                       2606    59408 2   flashcards_user_links flashcards_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_unique UNIQUE (flashcard_id, user_id);
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_unique;
       public            strapi    false    261    261                       2606    59410    i18n_locale i18n_locale_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_pkey;
       public            strapi    false    263            	           2606    59412    lessonlevels lessonlevels_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_pkey;
       public            strapi    false    265                       2606    59414 *   lessons_components lessons_components_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_components_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_components_pkey;
       public            strapi    false    268                       2606    59416 8   lessons_lessonlevel_links lessons_lessonlevel_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_pkey;
       public            strapi    false    271                       2606    59418 :   lessons_lessonlevel_links lessons_lessonlevel_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_unique UNIQUE (lesson_id, lessonlevel_id);
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_unique;
       public            strapi    false    271    271            #           2606    59420 <   lessons_localizations_links lessons_localizations_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_pkey;
       public            strapi    false    273            %           2606    59422 >   lessons_localizations_links lessons_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_unique UNIQUE (lesson_id, inv_lesson_id);
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_unique;
       public            strapi    false    273    273                       2606    59424    lessons lessons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_pkey;
       public            strapi    false    267                       2606    59426    lessons lessons_slug_unique 
   CONSTRAINT     V   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_unique UNIQUE (slug);
 E   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_slug_unique;
       public            strapi    false    267                       2606    60436 !   lessons_components lessons_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_unique UNIQUE (entity_id, component_id, field, component_type);
 K   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_unique;
       public            strapi    false    268    268    268    268            *           2606    59430 *   lessons_unit_links lessons_unit_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_pkey;
       public            strapi    false    275            ,           2606    59432 ,   lessons_unit_links lessons_unit_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_unique UNIQUE (lesson_id, unit_id);
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_unique;
       public            strapi    false    275    275                       2606    60343 F   review_tires_localizations_links review_tires_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_pkey;
       public            strapi    false    362                       2606    60347 H   review_tires_localizations_links review_tires_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_unique UNIQUE (review_tire_id, inv_review_tire_id);
 r   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_unique;
       public            strapi    false    362    362                       2606    60334    review_tires review_tires_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_pkey;
       public            strapi    false    360                        2606    60401 :   reviewlogs_flashcard_links reviewlogs_flashcard_links_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_pkey;
       public            strapi    false    364            "           2606    60405 <   reviewlogs_flashcard_links reviewlogs_flashcard_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_unique UNIQUE (reviewlog_id, flashcard_id);
 f   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_unique;
       public            strapi    false    364    364            /           2606    59434    reviewlogs reviewlogs_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_pkey;
       public            strapi    false    277            5           2606    59436 0   reviewlogs_user_links reviewlogs_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_pkey;
       public            strapi    false    279            7           2606    59438 2   reviewlogs_user_links reviewlogs_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_unique UNIQUE (reviewlog_id, user_id);
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_unique;
       public            strapi    false    279    279            >           2606    59440 ,   sections_components sections_components_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_components_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_components_pkey;
       public            strapi    false    282            G           2606    59442 0   sections_lesson_links sections_lesson_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_pkey;
       public            strapi    false    285            I           2606    59444 2   sections_lesson_links sections_lesson_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_unique UNIQUE (section_id, lesson_id);
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_unique;
       public            strapi    false    285    285            N           2606    59446 >   sections_localizations_links sections_localizations_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_pkey;
       public            strapi    false    287            P           2606    59448 @   sections_localizations_links sections_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_unique UNIQUE (section_id, inv_section_id);
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_unique;
       public            strapi    false    287    287            :           2606    59450    sections sections_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_pkey;
       public            strapi    false    281            B           2606    60438 #   sections_components sections_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_unique UNIQUE (entity_id, component_id, field, component_type);
 M   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_unique;
       public            strapi    false    282    282    282    282            W           2606    59454 .   sentences_components sentences_components_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_components_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_components_pkey;
       public            strapi    false    290            `           2606    59456 @   sentences_localizations_links sentences_localizations_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_pkey;
       public            strapi    false    293            b           2606    59458 B   sentences_localizations_links sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_unique UNIQUE (sentence_id, inv_sentence_id);
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_unique;
       public            strapi    false    293    293            S           2606    59460    sentences sentences_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_pkey;
       public            strapi    false    289            [           2606    60440 %   sentences_components sentences_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_unique UNIQUE (entity_id, component_id, field, component_type);
 O   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_unique;
       public            strapi    false    290    290    290    290            e           2606    59464 >   strapi_api_token_permissions strapi_api_token_permissions_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_pkey;
       public            strapi    false    295            k           2606    59466 V   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_pkey;
       public            strapi    false    297            m           2606    59468 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_unique;
       public            strapi    false    297    297            p           2606    59470 (   strapi_api_tokens strapi_api_tokens_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_pkey;
       public            strapi    false    299            s           2606    59472 :   strapi_core_store_settings strapi_core_store_settings_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.strapi_core_store_settings DROP CONSTRAINT strapi_core_store_settings_pkey;
       public            strapi    false    301            u           2606    59474 2   strapi_database_schema strapi_database_schema_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_database_schema DROP CONSTRAINT strapi_database_schema_pkey;
       public            strapi    false    303            w           2606    59476 (   strapi_migrations strapi_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_migrations DROP CONSTRAINT strapi_migrations_pkey;
       public            strapi    false    305            z           2606    59478 H   strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey 
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
       public            strapi    false    331            �           2606    59524 <   user_sentences_lesson_links user_sentences_lesson_links_pkey 
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
       public            strapi    false    335            �           2606    59534 \   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_pkey;
       public            strapi    false    341            �           2606    59536 ^   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_unique UNIQUE (user_sentence_id, user_id);
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_unique;
       public            strapi    false    341    341            �           2606    59538 4   user_words_lesson_links user_words_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_pkey;
       public            strapi    false    345            �           2606    59540 6   user_words_lesson_links user_words_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_unique UNIQUE (user_word_id, lesson_id);
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_unique;
       public            strapi    false    345    345            �           2606    59542 B   user_words_localizations_links user_words_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_pkey;
       public            strapi    false    347            �           2606    59544 D   user_words_localizations_links user_words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_unique UNIQUE (user_word_id, inv_user_word_id);
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_unique;
       public            strapi    false    347    347            �           2606    59546    user_words user_words_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_pkey;
       public            strapi    false    343            �           2606    59548 T   user_words_users_permissions_user_links user_words_users_permissions_user_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_pkey;
       public            strapi    false    349            �           2606    59550 V   user_words_users_permissions_user_links user_words_users_permissions_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_unique UNIQUE (user_word_id, user_id);
 �   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_unique;
       public            strapi    false    349    349            �           2606    59552 &   words_components words_components_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_components_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_components_pkey;
       public            strapi    false    352                       2606    59554 @   words_example_sentences_links words_example_sentences_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_pkey;
       public            strapi    false    354            	           2606    59556 B   words_example_sentences_links words_example_sentences_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_unique UNIQUE (word_id, sentence_id);
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_unique;
       public            strapi    false    354    354                       2606    59558 8   words_localizations_links words_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_pkey;
       public            strapi    false    357                       2606    59560 :   words_localizations_links words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_unique UNIQUE (word_id, inv_word_id);
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_unique;
       public            strapi    false    357    357            �           2606    59562    words words_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.words DROP CONSTRAINT words_pkey;
       public            strapi    false    351                       2606    60442    words_components words_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_unique UNIQUE (entity_id, component_id, field, component_type);
 G   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_unique;
       public            strapi    false    352    352    352    352            �           1259    59565 "   admin_permissions_created_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);
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
       public            strapi    false    257            �           1259    59601 !   flashcards_localizations_links_fk    INDEX     t   CREATE INDEX flashcards_localizations_links_fk ON public.flashcards_localizations_links USING btree (flashcard_id);
 5   DROP INDEX public.flashcards_localizations_links_fk;
       public            strapi    false    259            �           1259    59602 %   flashcards_localizations_links_inv_fk    INDEX     |   CREATE INDEX flashcards_localizations_links_inv_fk ON public.flashcards_localizations_links USING btree (inv_flashcard_id);
 9   DROP INDEX public.flashcards_localizations_links_inv_fk;
       public            strapi    false    259            �           1259    59603 '   flashcards_localizations_links_order_fk    INDEX     }   CREATE INDEX flashcards_localizations_links_order_fk ON public.flashcards_localizations_links USING btree (flashcard_order);
 ;   DROP INDEX public.flashcards_localizations_links_order_fk;
       public            strapi    false    259            �           1259    59604    flashcards_updated_by_id_fk    INDEX     [   CREATE INDEX flashcards_updated_by_id_fk ON public.flashcards USING btree (updated_by_id);
 /   DROP INDEX public.flashcards_updated_by_id_fk;
       public            strapi    false    253            �           1259    59605    flashcards_user_links_fk    INDEX     b   CREATE INDEX flashcards_user_links_fk ON public.flashcards_user_links USING btree (flashcard_id);
 ,   DROP INDEX public.flashcards_user_links_fk;
       public            strapi    false    261            �           1259    59606    flashcards_user_links_inv_fk    INDEX     a   CREATE INDEX flashcards_user_links_inv_fk ON public.flashcards_user_links USING btree (user_id);
 0   DROP INDEX public.flashcards_user_links_inv_fk;
       public            strapi    false    261            �           1259    59607 "   flashcards_user_links_order_inv_fk    INDEX     o   CREATE INDEX flashcards_user_links_order_inv_fk ON public.flashcards_user_links USING btree (flashcard_order);
 6   DROP INDEX public.flashcards_user_links_order_inv_fk;
       public            strapi    false    261                       1259    59608    i18n_locale_created_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);
 0   DROP INDEX public.i18n_locale_created_by_id_fk;
       public            strapi    false    263                       1259    59609    i18n_locale_updated_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);
 0   DROP INDEX public.i18n_locale_updated_by_id_fk;
       public            strapi    false    263                       1259    59610    lessonlevels_created_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_created_by_id_fk ON public.lessonlevels USING btree (created_by_id);
 1   DROP INDEX public.lessonlevels_created_by_id_fk;
       public            strapi    false    265            
           1259    59611    lessonlevels_updated_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_updated_by_id_fk ON public.lessonlevels USING btree (updated_by_id);
 1   DROP INDEX public.lessonlevels_updated_by_id_fk;
       public            strapi    false    265                       1259    59612    lessons_component_type_index    INDEX     e   CREATE INDEX lessons_component_type_index ON public.lessons_components USING btree (component_type);
 0   DROP INDEX public.lessons_component_type_index;
       public            strapi    false    268                       1259    59613    lessons_created_by_id_fk    INDEX     U   CREATE INDEX lessons_created_by_id_fk ON public.lessons USING btree (created_by_id);
 ,   DROP INDEX public.lessons_created_by_id_fk;
       public            strapi    false    267                       1259    59614    lessons_entity_fk    INDEX     U   CREATE INDEX lessons_entity_fk ON public.lessons_components USING btree (entity_id);
 %   DROP INDEX public.lessons_entity_fk;
       public            strapi    false    268                       1259    59615    lessons_field_index    INDEX     S   CREATE INDEX lessons_field_index ON public.lessons_components USING btree (field);
 '   DROP INDEX public.lessons_field_index;
       public            strapi    false    268                       1259    59616    lessons_lessonlevel_links_fk    INDEX     g   CREATE INDEX lessons_lessonlevel_links_fk ON public.lessons_lessonlevel_links USING btree (lesson_id);
 0   DROP INDEX public.lessons_lessonlevel_links_fk;
       public            strapi    false    271                       1259    59617     lessons_lessonlevel_links_inv_fk    INDEX     p   CREATE INDEX lessons_lessonlevel_links_inv_fk ON public.lessons_lessonlevel_links USING btree (lessonlevel_id);
 4   DROP INDEX public.lessons_lessonlevel_links_inv_fk;
       public            strapi    false    271                       1259    59618 &   lessons_lessonlevel_links_order_inv_fk    INDEX     t   CREATE INDEX lessons_lessonlevel_links_order_inv_fk ON public.lessons_lessonlevel_links USING btree (lesson_order);
 :   DROP INDEX public.lessons_lessonlevel_links_order_inv_fk;
       public            strapi    false    271                       1259    59619    lessons_localizations_links_fk    INDEX     k   CREATE INDEX lessons_localizations_links_fk ON public.lessons_localizations_links USING btree (lesson_id);
 2   DROP INDEX public.lessons_localizations_links_fk;
       public            strapi    false    273                        1259    59620 "   lessons_localizations_links_inv_fk    INDEX     s   CREATE INDEX lessons_localizations_links_inv_fk ON public.lessons_localizations_links USING btree (inv_lesson_id);
 6   DROP INDEX public.lessons_localizations_links_inv_fk;
       public            strapi    false    273            !           1259    59621 $   lessons_localizations_links_order_fk    INDEX     t   CREATE INDEX lessons_localizations_links_order_fk ON public.lessons_localizations_links USING btree (lesson_order);
 8   DROP INDEX public.lessons_localizations_links_order_fk;
       public            strapi    false    273            &           1259    59622    lessons_unit_links_fk    INDEX     Y   CREATE INDEX lessons_unit_links_fk ON public.lessons_unit_links USING btree (lesson_id);
 )   DROP INDEX public.lessons_unit_links_fk;
       public            strapi    false    275            '           1259    59623    lessons_unit_links_inv_fk    INDEX     [   CREATE INDEX lessons_unit_links_inv_fk ON public.lessons_unit_links USING btree (unit_id);
 -   DROP INDEX public.lessons_unit_links_inv_fk;
       public            strapi    false    275            (           1259    59624    lessons_unit_links_order_inv_fk    INDEX     f   CREATE INDEX lessons_unit_links_order_inv_fk ON public.lessons_unit_links USING btree (lesson_order);
 3   DROP INDEX public.lessons_unit_links_order_inv_fk;
       public            strapi    false    275                       1259    59625    lessons_updated_by_id_fk    INDEX     U   CREATE INDEX lessons_updated_by_id_fk ON public.lessons USING btree (updated_by_id);
 ,   DROP INDEX public.lessons_updated_by_id_fk;
       public            strapi    false    267                       1259    60335    review_tires_created_by_id_fk    INDEX     _   CREATE INDEX review_tires_created_by_id_fk ON public.review_tires USING btree (created_by_id);
 1   DROP INDEX public.review_tires_created_by_id_fk;
       public            strapi    false    360                       1259    60344 #   review_tires_localizations_links_fk    INDEX     z   CREATE INDEX review_tires_localizations_links_fk ON public.review_tires_localizations_links USING btree (review_tire_id);
 7   DROP INDEX public.review_tires_localizations_links_fk;
       public            strapi    false    362                       1259    60345 '   review_tires_localizations_links_inv_fk    INDEX     �   CREATE INDEX review_tires_localizations_links_inv_fk ON public.review_tires_localizations_links USING btree (inv_review_tire_id);
 ;   DROP INDEX public.review_tires_localizations_links_inv_fk;
       public            strapi    false    362                       1259    60348 )   review_tires_localizations_links_order_fk    INDEX     �   CREATE INDEX review_tires_localizations_links_order_fk ON public.review_tires_localizations_links USING btree (review_tire_order);
 =   DROP INDEX public.review_tires_localizations_links_order_fk;
       public            strapi    false    362                       1259    60336    review_tires_updated_by_id_fk    INDEX     _   CREATE INDEX review_tires_updated_by_id_fk ON public.review_tires USING btree (updated_by_id);
 1   DROP INDEX public.review_tires_updated_by_id_fk;
       public            strapi    false    360            -           1259    59626    reviewlogs_created_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_created_by_id_fk ON public.reviewlogs USING btree (created_by_id);
 /   DROP INDEX public.reviewlogs_created_by_id_fk;
       public            strapi    false    277                       1259    60402    reviewlogs_flashcard_links_fk    INDEX     l   CREATE INDEX reviewlogs_flashcard_links_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_id);
 1   DROP INDEX public.reviewlogs_flashcard_links_fk;
       public            strapi    false    364                       1259    60403 !   reviewlogs_flashcard_links_inv_fk    INDEX     p   CREATE INDEX reviewlogs_flashcard_links_inv_fk ON public.reviewlogs_flashcard_links USING btree (flashcard_id);
 5   DROP INDEX public.reviewlogs_flashcard_links_inv_fk;
       public            strapi    false    364                       1259    60406 '   reviewlogs_flashcard_links_order_inv_fk    INDEX     y   CREATE INDEX reviewlogs_flashcard_links_order_inv_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_order);
 ;   DROP INDEX public.reviewlogs_flashcard_links_order_inv_fk;
       public            strapi    false    364            0           1259    59627    reviewlogs_updated_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_updated_by_id_fk ON public.reviewlogs USING btree (updated_by_id);
 /   DROP INDEX public.reviewlogs_updated_by_id_fk;
       public            strapi    false    277            1           1259    59628    reviewlogs_user_links_fk    INDEX     b   CREATE INDEX reviewlogs_user_links_fk ON public.reviewlogs_user_links USING btree (reviewlog_id);
 ,   DROP INDEX public.reviewlogs_user_links_fk;
       public            strapi    false    279            2           1259    59629    reviewlogs_user_links_inv_fk    INDEX     a   CREATE INDEX reviewlogs_user_links_inv_fk ON public.reviewlogs_user_links USING btree (user_id);
 0   DROP INDEX public.reviewlogs_user_links_inv_fk;
       public            strapi    false    279            3           1259    59630 "   reviewlogs_user_links_order_inv_fk    INDEX     o   CREATE INDEX reviewlogs_user_links_order_inv_fk ON public.reviewlogs_user_links USING btree (reviewlog_order);
 6   DROP INDEX public.reviewlogs_user_links_order_inv_fk;
       public            strapi    false    279            <           1259    59631    sections_component_type_index    INDEX     g   CREATE INDEX sections_component_type_index ON public.sections_components USING btree (component_type);
 1   DROP INDEX public.sections_component_type_index;
       public            strapi    false    282            8           1259    59632    sections_created_by_id_fk    INDEX     W   CREATE INDEX sections_created_by_id_fk ON public.sections USING btree (created_by_id);
 -   DROP INDEX public.sections_created_by_id_fk;
       public            strapi    false    281            ?           1259    59633    sections_entity_fk    INDEX     W   CREATE INDEX sections_entity_fk ON public.sections_components USING btree (entity_id);
 &   DROP INDEX public.sections_entity_fk;
       public            strapi    false    282            @           1259    59634    sections_field_index    INDEX     U   CREATE INDEX sections_field_index ON public.sections_components USING btree (field);
 (   DROP INDEX public.sections_field_index;
       public            strapi    false    282            C           1259    59635    sections_lesson_links_fk    INDEX     `   CREATE INDEX sections_lesson_links_fk ON public.sections_lesson_links USING btree (section_id);
 ,   DROP INDEX public.sections_lesson_links_fk;
       public            strapi    false    285            D           1259    59636    sections_lesson_links_inv_fk    INDEX     c   CREATE INDEX sections_lesson_links_inv_fk ON public.sections_lesson_links USING btree (lesson_id);
 0   DROP INDEX public.sections_lesson_links_inv_fk;
       public            strapi    false    285            E           1259    59637 "   sections_lesson_links_order_inv_fk    INDEX     m   CREATE INDEX sections_lesson_links_order_inv_fk ON public.sections_lesson_links USING btree (section_order);
 6   DROP INDEX public.sections_lesson_links_order_inv_fk;
       public            strapi    false    285            J           1259    59638    sections_localizations_links_fk    INDEX     n   CREATE INDEX sections_localizations_links_fk ON public.sections_localizations_links USING btree (section_id);
 3   DROP INDEX public.sections_localizations_links_fk;
       public            strapi    false    287            K           1259    59639 #   sections_localizations_links_inv_fk    INDEX     v   CREATE INDEX sections_localizations_links_inv_fk ON public.sections_localizations_links USING btree (inv_section_id);
 7   DROP INDEX public.sections_localizations_links_inv_fk;
       public            strapi    false    287            L           1259    59640 %   sections_localizations_links_order_fk    INDEX     w   CREATE INDEX sections_localizations_links_order_fk ON public.sections_localizations_links USING btree (section_order);
 9   DROP INDEX public.sections_localizations_links_order_fk;
       public            strapi    false    287            ;           1259    59641    sections_updated_by_id_fk    INDEX     W   CREATE INDEX sections_updated_by_id_fk ON public.sections USING btree (updated_by_id);
 -   DROP INDEX public.sections_updated_by_id_fk;
       public            strapi    false    281            U           1259    59642    sentences_component_type_index    INDEX     i   CREATE INDEX sentences_component_type_index ON public.sentences_components USING btree (component_type);
 2   DROP INDEX public.sentences_component_type_index;
       public            strapi    false    290            Q           1259    59643    sentences_created_by_id_fk    INDEX     Y   CREATE INDEX sentences_created_by_id_fk ON public.sentences USING btree (created_by_id);
 .   DROP INDEX public.sentences_created_by_id_fk;
       public            strapi    false    289            X           1259    59644    sentences_entity_fk    INDEX     Y   CREATE INDEX sentences_entity_fk ON public.sentences_components USING btree (entity_id);
 '   DROP INDEX public.sentences_entity_fk;
       public            strapi    false    290            Y           1259    59645    sentences_field_index    INDEX     W   CREATE INDEX sentences_field_index ON public.sentences_components USING btree (field);
 )   DROP INDEX public.sentences_field_index;
       public            strapi    false    290            \           1259    59646     sentences_localizations_links_fk    INDEX     q   CREATE INDEX sentences_localizations_links_fk ON public.sentences_localizations_links USING btree (sentence_id);
 4   DROP INDEX public.sentences_localizations_links_fk;
       public            strapi    false    293            ]           1259    59647 $   sentences_localizations_links_inv_fk    INDEX     y   CREATE INDEX sentences_localizations_links_inv_fk ON public.sentences_localizations_links USING btree (inv_sentence_id);
 8   DROP INDEX public.sentences_localizations_links_inv_fk;
       public            strapi    false    293            ^           1259    59648 &   sentences_localizations_links_order_fk    INDEX     z   CREATE INDEX sentences_localizations_links_order_fk ON public.sentences_localizations_links USING btree (sentence_order);
 :   DROP INDEX public.sentences_localizations_links_order_fk;
       public            strapi    false    293            T           1259    59649    sentences_updated_by_id_fk    INDEX     Y   CREATE INDEX sentences_updated_by_id_fk ON public.sentences USING btree (updated_by_id);
 .   DROP INDEX public.sentences_updated_by_id_fk;
       public            strapi    false    289            c           1259    59650 -   strapi_api_token_permissions_created_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_created_by_id_fk;
       public            strapi    false    295            g           1259    59651 +   strapi_api_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);
 ?   DROP INDEX public.strapi_api_token_permissions_token_links_fk;
       public            strapi    false    297            h           1259    59652 /   strapi_api_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);
 C   DROP INDEX public.strapi_api_token_permissions_token_links_inv_fk;
       public            strapi    false    297            i           1259    59653 5   strapi_api_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);
 I   DROP INDEX public.strapi_api_token_permissions_token_links_order_inv_fk;
       public            strapi    false    297            f           1259    59654 -   strapi_api_token_permissions_updated_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_updated_by_id_fk;
       public            strapi    false    295            n           1259    59655 "   strapi_api_tokens_created_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);
 6   DROP INDEX public.strapi_api_tokens_created_by_id_fk;
       public            strapi    false    299            q           1259    59656 "   strapi_api_tokens_updated_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);
 6   DROP INDEX public.strapi_api_tokens_updated_by_id_fk;
       public            strapi    false    299            x           1259    59657 2   strapi_transfer_token_permissions_created_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_created_by_id_fk;
       public            strapi    false    307            |           1259    59658 0   strapi_transfer_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);
 D   DROP INDEX public.strapi_transfer_token_permissions_token_links_fk;
       public            strapi    false    309            }           1259    59659 4   strapi_transfer_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);
 H   DROP INDEX public.strapi_transfer_token_permissions_token_links_inv_fk;
       public            strapi    false    309            ~           1259    59660 :   strapi_transfer_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);
 N   DROP INDEX public.strapi_transfer_token_permissions_token_links_order_inv_fk;
       public            strapi    false    309            {           1259    59661 2   strapi_transfer_token_permissions_updated_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);
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
       public            strapi    false    331            �           1259    59694    user_sentences_created_by_id_fk    INDEX     c   CREATE INDEX user_sentences_created_by_id_fk ON public.user_sentences USING btree (created_by_id);
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
       public            strapi    false    335            �           1259    59702 .   user_sentences_users_permissions_user_links_fk    INDEX     �   CREATE INDEX user_sentences_users_permissions_user_links_fk ON public.user_sentences_users_permissions_user_links USING btree (user_sentence_id);
 B   DROP INDEX public.user_sentences_users_permissions_user_links_fk;
       public            strapi    false    341            �           1259    59703 2   user_sentences_users_permissions_user_links_inv_fk    INDEX     �   CREATE INDEX user_sentences_users_permissions_user_links_inv_fk ON public.user_sentences_users_permissions_user_links USING btree (user_id);
 F   DROP INDEX public.user_sentences_users_permissions_user_links_inv_fk;
       public            strapi    false    341            �           1259    59704 8   user_sentences_users_permissions_user_links_order_inv_fk    INDEX     �   CREATE INDEX user_sentences_users_permissions_user_links_order_inv_fk ON public.user_sentences_users_permissions_user_links USING btree (user_sentence_order);
 L   DROP INDEX public.user_sentences_users_permissions_user_links_order_inv_fk;
       public            strapi    false    341            �           1259    59705    user_words_created_by_id_fk    INDEX     [   CREATE INDEX user_words_created_by_id_fk ON public.user_words USING btree (created_by_id);
 /   DROP INDEX public.user_words_created_by_id_fk;
       public            strapi    false    343            �           1259    59706    user_words_lesson_links_fk    INDEX     f   CREATE INDEX user_words_lesson_links_fk ON public.user_words_lesson_links USING btree (user_word_id);
 .   DROP INDEX public.user_words_lesson_links_fk;
       public            strapi    false    345            �           1259    59707    user_words_lesson_links_inv_fk    INDEX     g   CREATE INDEX user_words_lesson_links_inv_fk ON public.user_words_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.user_words_lesson_links_inv_fk;
       public            strapi    false    345            �           1259    59708 $   user_words_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX user_words_lesson_links_order_inv_fk ON public.user_words_lesson_links USING btree (user_word_order);
 8   DROP INDEX public.user_words_lesson_links_order_inv_fk;
       public            strapi    false    345            �           1259    59709 !   user_words_localizations_links_fk    INDEX     t   CREATE INDEX user_words_localizations_links_fk ON public.user_words_localizations_links USING btree (user_word_id);
 5   DROP INDEX public.user_words_localizations_links_fk;
       public            strapi    false    347            �           1259    59710 %   user_words_localizations_links_inv_fk    INDEX     |   CREATE INDEX user_words_localizations_links_inv_fk ON public.user_words_localizations_links USING btree (inv_user_word_id);
 9   DROP INDEX public.user_words_localizations_links_inv_fk;
       public            strapi    false    347            �           1259    59711 '   user_words_localizations_links_order_fk    INDEX     }   CREATE INDEX user_words_localizations_links_order_fk ON public.user_words_localizations_links USING btree (user_word_order);
 ;   DROP INDEX public.user_words_localizations_links_order_fk;
       public            strapi    false    347            �           1259    59712    user_words_updated_by_id_fk    INDEX     [   CREATE INDEX user_words_updated_by_id_fk ON public.user_words USING btree (updated_by_id);
 /   DROP INDEX public.user_words_updated_by_id_fk;
       public            strapi    false    343            �           1259    59713 *   user_words_users_permissions_user_links_fk    INDEX     �   CREATE INDEX user_words_users_permissions_user_links_fk ON public.user_words_users_permissions_user_links USING btree (user_word_id);
 >   DROP INDEX public.user_words_users_permissions_user_links_fk;
       public            strapi    false    349            �           1259    59714 .   user_words_users_permissions_user_links_inv_fk    INDEX     �   CREATE INDEX user_words_users_permissions_user_links_inv_fk ON public.user_words_users_permissions_user_links USING btree (user_id);
 B   DROP INDEX public.user_words_users_permissions_user_links_inv_fk;
       public            strapi    false    349            �           1259    59715 4   user_words_users_permissions_user_links_order_inv_fk    INDEX     �   CREATE INDEX user_words_users_permissions_user_links_order_inv_fk ON public.user_words_users_permissions_user_links USING btree (user_word_order);
 H   DROP INDEX public.user_words_users_permissions_user_links_order_inv_fk;
       public            strapi    false    349            �           1259    59716    words_component_type_index    INDEX     a   CREATE INDEX words_component_type_index ON public.words_components USING btree (component_type);
 .   DROP INDEX public.words_component_type_index;
       public            strapi    false    352            �           1259    59717    words_created_by_id_fk    INDEX     Q   CREATE INDEX words_created_by_id_fk ON public.words USING btree (created_by_id);
 *   DROP INDEX public.words_created_by_id_fk;
       public            strapi    false    351            �           1259    59718    words_entity_fk    INDEX     Q   CREATE INDEX words_entity_fk ON public.words_components USING btree (entity_id);
 #   DROP INDEX public.words_entity_fk;
       public            strapi    false    352                       1259    59719     words_example_sentences_links_fk    INDEX     m   CREATE INDEX words_example_sentences_links_fk ON public.words_example_sentences_links USING btree (word_id);
 4   DROP INDEX public.words_example_sentences_links_fk;
       public            strapi    false    354                       1259    59720 $   words_example_sentences_links_inv_fk    INDEX     u   CREATE INDEX words_example_sentences_links_inv_fk ON public.words_example_sentences_links USING btree (sentence_id);
 8   DROP INDEX public.words_example_sentences_links_inv_fk;
       public            strapi    false    354                       1259    59721 &   words_example_sentences_links_order_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_fk ON public.words_example_sentences_links USING btree (sentence_order);
 :   DROP INDEX public.words_example_sentences_links_order_fk;
       public            strapi    false    354                       1259    59722 *   words_example_sentences_links_order_inv_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_inv_fk ON public.words_example_sentences_links USING btree (word_order);
 >   DROP INDEX public.words_example_sentences_links_order_inv_fk;
       public            strapi    false    354            �           1259    59723    words_field_index    INDEX     O   CREATE INDEX words_field_index ON public.words_components USING btree (field);
 %   DROP INDEX public.words_field_index;
       public            strapi    false    352            
           1259    59724    words_localizations_links_fk    INDEX     e   CREATE INDEX words_localizations_links_fk ON public.words_localizations_links USING btree (word_id);
 0   DROP INDEX public.words_localizations_links_fk;
       public            strapi    false    357                       1259    59725     words_localizations_links_inv_fk    INDEX     m   CREATE INDEX words_localizations_links_inv_fk ON public.words_localizations_links USING btree (inv_word_id);
 4   DROP INDEX public.words_localizations_links_inv_fk;
       public            strapi    false    357                       1259    59726 "   words_localizations_links_order_fk    INDEX     n   CREATE INDEX words_localizations_links_order_fk ON public.words_localizations_links USING btree (word_order);
 6   DROP INDEX public.words_localizations_links_order_fk;
       public            strapi    false    357            �           1259    59727    words_updated_by_id_fk    INDEX     Q   CREATE INDEX words_updated_by_id_fk ON public.words USING btree (updated_by_id);
 *   DROP INDEX public.words_updated_by_id_fk;
       public            strapi    false    351            #           2606    59728 4   admin_permissions admin_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_created_by_id_fk;
       public          strapi    false    215    209    4247            %           2606    59733 <   admin_permissions_role_links admin_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_fk;
       public          strapi    false    4232    211    209            &           2606    59738 @   admin_permissions_role_links admin_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_inv_fk;
       public          strapi    false    4243    211    213            $           2606    59743 4   admin_permissions admin_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_updated_by_id_fk;
       public          strapi    false    209    4247    215            '           2606    59748 (   admin_roles admin_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_created_by_id_fk;
       public          strapi    false    4247    213    215            (           2606    59753 (   admin_roles admin_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_updated_by_id_fk;
       public          strapi    false    213    4247    215            )           2606    59758 (   admin_users admin_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_created_by_id_fk;
       public          strapi    false    4247    215    215            +           2606    59763 2   admin_users_roles_links admin_users_roles_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_fk;
       public          strapi    false    217    4247    215            ,           2606    59768 6   admin_users_roles_links admin_users_roles_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_inv_fk;
       public          strapi    false    217    4243    213            *           2606    59773 (   admin_users admin_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_updated_by_id_fk;
       public          strapi    false    215    4247    215            -           2606    59778 N   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_fk FOREIGN KEY (sent_ref_id) REFERENCES public.components_a_sent_refs(id) ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_fk;
       public          strapi    false    4264    227    225            .           2606    59783 R   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 |   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_inv_fk;
       public          strapi    false    4435    227    289            /           2606    59788 b   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk FOREIGN KEY (user_sent_ref_id) REFERENCES public.components_a_user_sent_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk;
       public          strapi    false    233    4274    231            0           2606    59793 f   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk;
       public          strapi    false    233    4551    335            1           2606    59798 Z   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_fk FOREIGN KEY (user_word_ref_id) REFERENCES public.components_a_user_word_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_fk;
       public          strapi    false    4282    237    235            2           2606    59803 ^   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk;
       public          strapi    false    343    237    4576            3           2606    59808 F   components_a_word_refs_word_links components_a_word_refs_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_fk FOREIGN KEY (word_ref_id) REFERENCES public.components_a_word_refs(id) ON DELETE CASCADE;
 p   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_fk;
       public          strapi    false    245    243    4294            4           2606    59813 J   components_a_word_refs_word_links components_a_word_refs_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_inv_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 t   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_inv_fk;
       public          strapi    false    351    4601    245            5           2606    59818    files files_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fk;
       public          strapi    false    247    215    4247            7           2606    59823 (   files_folder_links files_folder_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_fk;
       public          strapi    false    248    4303    247            8           2606    59828 ,   files_folder_links files_folder_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_inv_fk;
       public          strapi    false    248    4540    331            9           2606    59833 ,   files_related_morphs files_related_morphs_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_fk;
       public          strapi    false    251    4303    247            6           2606    59838    files files_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_updated_by_id_fk;
       public          strapi    false    247    4247    215            :           2606    59843 &   flashcards flashcards_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_created_by_id_fk;
       public          strapi    false    253    4247    215            <           2606    59848 *   flashcards_components flashcards_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_entity_fk FOREIGN KEY (entity_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_entity_fk;
       public          strapi    false    254    4325    253            =           2606    59853 2   flashcards_lesson_links flashcards_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_fk;
       public          strapi    false    257    4325    253            >           2606    59858 6   flashcards_lesson_links flashcards_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_inv_fk;
       public          strapi    false    257    4365    267            ?           2606    59863 @   flashcards_localizations_links flashcards_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_fk;
       public          strapi    false    259    4325    253            @           2606    59868 D   flashcards_localizations_links flashcards_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_inv_fk FOREIGN KEY (inv_flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_inv_fk;
       public          strapi    false    259    4325    253            ;           2606    59873 &   flashcards flashcards_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_updated_by_id_fk;
       public          strapi    false    253    4247    215            A           2606    59878 .   flashcards_user_links flashcards_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_fk;
       public          strapi    false    261    4325    253            B           2606    59883 2   flashcards_user_links flashcards_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_inv_fk;
       public          strapi    false    261    4525    327            C           2606    59888 (   i18n_locale i18n_locale_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_created_by_id_fk;
       public          strapi    false    263    4247    215            D           2606    59893 (   i18n_locale i18n_locale_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_updated_by_id_fk;
       public          strapi    false    263    4247    215            E           2606    59898 *   lessonlevels lessonlevels_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_created_by_id_fk;
       public          strapi    false    265    4247    215            F           2606    59903 *   lessonlevels lessonlevels_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_updated_by_id_fk;
       public          strapi    false    265    4247    215            G           2606    59908     lessons lessons_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_created_by_id_fk;
       public          strapi    false    267    4247    215            I           2606    59913 $   lessons_components lessons_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_entity_fk FOREIGN KEY (entity_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_entity_fk;
       public          strapi    false    268    4365    267            J           2606    59918 6   lessons_lessonlevel_links lessons_lessonlevel_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_fk;
       public          strapi    false    271    4365    267            K           2606    59923 :   lessons_lessonlevel_links lessons_lessonlevel_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_inv_fk FOREIGN KEY (lessonlevel_id) REFERENCES public.lessonlevels(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_inv_fk;
       public          strapi    false    271    4361    265            L           2606    59928 :   lessons_localizations_links lessons_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_fk;
       public          strapi    false    273    4365    267            M           2606    59933 >   lessons_localizations_links lessons_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_inv_fk FOREIGN KEY (inv_lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_inv_fk;
       public          strapi    false    273    4365    267            N           2606    59938 (   lessons_unit_links lessons_unit_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_fk;
       public          strapi    false    275    4365    267            O           2606    59943 ,   lessons_unit_links lessons_unit_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_inv_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_inv_fk;
       public          strapi    false    275    4491    315            H           2606    59948     lessons lessons_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_updated_by_id_fk;
       public          strapi    false    267    4247    215            �           2606    60349 *   review_tires review_tires_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_created_by_id_fk;
       public          strapi    false    360    4247    215            �           2606    60359 D   review_tires_localizations_links review_tires_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_fk FOREIGN KEY (review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_fk;
       public          strapi    false    362    4627    360            �           2606    60364 H   review_tires_localizations_links review_tires_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_inv_fk FOREIGN KEY (inv_review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_inv_fk;
       public          strapi    false    362    4627    360            �           2606    60354 *   review_tires review_tires_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_updated_by_id_fk;
       public          strapi    false    360    4247    215            P           2606    59953 &   reviewlogs reviewlogs_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_created_by_id_fk;
       public          strapi    false    277    4247    215            �           2606    60407 8   reviewlogs_flashcard_links reviewlogs_flashcard_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_fk;
       public          strapi    false    364    4399    277            �           2606    60412 <   reviewlogs_flashcard_links reviewlogs_flashcard_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_inv_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_inv_fk;
       public          strapi    false    364    4325    253            Q           2606    59958 &   reviewlogs reviewlogs_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_updated_by_id_fk;
       public          strapi    false    277    4247    215            R           2606    59963 .   reviewlogs_user_links reviewlogs_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_fk;
       public          strapi    false    279    4399    277            S           2606    59968 2   reviewlogs_user_links reviewlogs_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_inv_fk;
       public          strapi    false    279    4525    327            T           2606    59973 "   sections sections_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_created_by_id_fk;
       public          strapi    false    281    4247    215            V           2606    59978 &   sections_components sections_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_entity_fk;
       public          strapi    false    282    4410    281            W           2606    59983 .   sections_lesson_links sections_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_fk;
       public          strapi    false    285    4410    281            X           2606    59988 2   sections_lesson_links sections_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_inv_fk;
       public          strapi    false    285    4365    267            Y           2606    59993 <   sections_localizations_links sections_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_fk;
       public          strapi    false    287    4410    281            Z           2606    59998 @   sections_localizations_links sections_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_inv_fk FOREIGN KEY (inv_section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_inv_fk;
       public          strapi    false    287    4410    281            U           2606    60003 "   sections sections_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_updated_by_id_fk;
       public          strapi    false    281    4247    215            [           2606    60008 $   sentences sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_created_by_id_fk;
       public          strapi    false    289    4247    215            ]           2606    60013 (   sentences_components sentences_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_entity_fk;
       public          strapi    false    290    4435    289            ^           2606    60018 >   sentences_localizations_links sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_fk;
       public          strapi    false    293    4435    289            _           2606    60023 B   sentences_localizations_links sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_inv_fk FOREIGN KEY (inv_sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_inv_fk;
       public          strapi    false    293    4435    289            \           2606    60028 $   sentences sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_updated_by_id_fk;
       public          strapi    false    289    4247    215            `           2606    60033 J   strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_created_by_id_fk;
       public          strapi    false    295    4247    215            b           2606    60038 T   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;
 ~   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_fk;
       public          strapi    false    297    4453    295            c           2606    60043 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_inv_fk;
       public          strapi    false    297    4464    299            a           2606    60048 J   strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_updated_by_id_fk;
       public          strapi    false    295    4247    215            d           2606    60053 4   strapi_api_tokens strapi_api_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_created_by_id_fk;
       public          strapi    false    299    4247    215            e           2606    60058 4   strapi_api_tokens strapi_api_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_updated_by_id_fk;
       public          strapi    false    299    4247    215            f           2606    60063 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk;
       public          strapi    false    307    4247    215            h           2606    60068 ^   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk    FK CONSTRAINT        ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_fk;
       public          strapi    false    309    4474    307            i           2606    60073 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk;
       public          strapi    false    309    4485    311            g           2606    60078 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk;
       public          strapi    false    307    4247    215            j           2606    60083 >   strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_created_by_id_fk;
       public          strapi    false    311    4247    215            k           2606    60088 >   strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_updated_by_id_fk;
       public          strapi    false    311    4247    215            l           2606    60093    units units_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_created_by_id_fk;
       public          strapi    false    315    4247    215            n           2606    60098 6   units_localizations_links units_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_fk;
       public          strapi    false    317    4491    315            o           2606    60103 :   units_localizations_links units_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_inv_fk;
       public          strapi    false    317    4491    315            p           2606    60108 4   units_precondition_links units_precondition_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_fk;
       public          strapi    false    319    4491    315            q           2606    60113 8   units_precondition_links units_precondition_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_inv_fk;
       public          strapi    false    319    4491    315            m           2606    60118    units units_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_updated_by_id_fk;
       public          strapi    false    315    4247    215            r           2606    60123 .   up_permissions up_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_created_by_id_fk;
       public          strapi    false    321    4247    215            t           2606    60128 6   up_permissions_role_links up_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_fk;
       public          strapi    false    323    4510    321            u           2606    60133 :   up_permissions_role_links up_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_inv_fk;
       public          strapi    false    323    4521    325            s           2606    60138 .   up_permissions up_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_updated_by_id_fk;
       public          strapi    false    321    4247    215            v           2606    60143 "   up_roles up_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_created_by_id_fk;
       public          strapi    false    325    4247    215            w           2606    60148 "   up_roles up_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_updated_by_id_fk;
       public          strapi    false    325    4247    215            x           2606    60153 "   up_users up_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_created_by_id_fk;
       public          strapi    false    327    4247    215            z           2606    60158 *   up_users_role_links up_users_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_fk;
       public          strapi    false    329    4525    327            {           2606    60163 .   up_users_role_links up_users_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_inv_fk;
       public          strapi    false    329    4521    325            y           2606    60168 "   up_users up_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_updated_by_id_fk;
       public          strapi    false    327    4247    215            |           2606    60173 .   upload_folders upload_folders_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_created_by_id_fk;
       public          strapi    false    331    4247    215            ~           2606    60178 :   upload_folders_parent_links upload_folders_parent_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_fk;
       public          strapi    false    333    4540    331                       2606    60183 >   upload_folders_parent_links upload_folders_parent_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_inv_fk;
       public          strapi    false    333    4540    331            }           2606    60188 .   upload_folders upload_folders_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_updated_by_id_fk;
       public          strapi    false    331    4247    215            �           2606    60193 .   user_sentences user_sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_created_by_id_fk;
       public          strapi    false    335    4247    215            �           2606    60198 :   user_sentences_lesson_links user_sentences_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_fk;
       public          strapi    false    337    4551    335            �           2606    60203 >   user_sentences_lesson_links user_sentences_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_inv_fk;
       public          strapi    false    337    4365    267            �           2606    60208 H   user_sentences_localizations_links user_sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_fk;
       public          strapi    false    339    4551    335            �           2606    60213 L   user_sentences_localizations_links user_sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_inv_fk FOREIGN KEY (inv_user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_inv_fk;
       public          strapi    false    339    4551    335            �           2606    60218 .   user_sentences user_sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_updated_by_id_fk;
       public          strapi    false    335    4247    215            �           2606    60223 Z   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_fk;
       public          strapi    false    341    4551    335            �           2606    60228 ^   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_inv_fk;
       public          strapi    false    341    4525    327            �           2606    60233 &   user_words user_words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_created_by_id_fk;
       public          strapi    false    343    4247    215            �           2606    60238 2   user_words_lesson_links user_words_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_fk;
       public          strapi    false    345    4576    343            �           2606    60243 6   user_words_lesson_links user_words_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_inv_fk;
       public          strapi    false    345    4365    267            �           2606    60248 @   user_words_localizations_links user_words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_fk;
       public          strapi    false    347    4576    343            �           2606    60253 D   user_words_localizations_links user_words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_inv_fk FOREIGN KEY (inv_user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_inv_fk;
       public          strapi    false    347    4576    343            �           2606    60258 &   user_words user_words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_updated_by_id_fk;
       public          strapi    false    343    4247    215            �           2606    60263 R   user_words_users_permissions_user_links user_words_users_permissions_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 |   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_fk;
       public          strapi    false    349    4576    343            �           2606    60268 V   user_words_users_permissions_user_links user_words_users_permissions_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_inv_fk;
       public          strapi    false    349    4525    327            �           2606    60273    words words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_created_by_id_fk;
       public          strapi    false    351    4247    215            �           2606    60278     words_components words_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_entity_fk FOREIGN KEY (entity_id) REFERENCES public.words(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_entity_fk;
       public          strapi    false    352    4601    351            �           2606    60283 >   words_example_sentences_links words_example_sentences_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_fk;
       public          strapi    false    354    4601    351            �           2606    60288 B   words_example_sentences_links words_example_sentences_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_inv_fk;
       public          strapi    false    354    4435    289            �           2606    60293 6   words_localizations_links words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_fk;
       public          strapi    false    357    4601    351            �           2606    60298 :   words_localizations_links words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_inv_fk FOREIGN KEY (inv_word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_inv_fk;
       public          strapi    false    357    4601    351            �           2606    60303    words words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_updated_by_id_fk;
       public          strapi    false    351    4247    215            (   �	  x��[�r����<E*��*�?~���8w;S.b+.��Lm����ZD+��6���>����j�0�9��cQm��sY�҈�p�ǟ7_Q��}�	��o�x�[�l�d�(�i������%�����8^�y.��"C�Q'��͐���Z��tb� K\�9�_·e�!��9qM����R���a*h\S�.������9��;q͑,�]~8�O�v�{�n�p�8����J�S!I9Πp͐�'�	�t�k�����	)�"�)}_�1²ԉ�l¯�5Fx�%��5���;Qu�S^�G��]�6�� J�9��M�9��T�mQW��q$"Q:qH�H[T�Rl�gѮЈ��J�q�$��e)��T�m�i���y�
��\WӖ����-sP,�4�I0#V*n�/Ey��k������<��(��N���#`6��$��lbh�k1�$�X�i޵r����Ɓ�bL(H����1	3l�8�̖�U31&Q��>��R�&Tcs�A�����?�����]5�\���U"Ƥq`��L^��Nv�W��u]�^�b	Υp�b�p�����i�ӊ�eN�"/6OK&�S8��W��L����\J6OS���8p�+8�4MI�b~�8�&����ڋ�f�\OIc�jX�U��ڢ�L�5�4�HY��R�e����JᰁP�^6s8j�SDQ�^��H`�W� ?D�{勌����A>����)o�D'�x�e�������"����s���X��q��g��F��IM� 9�I�tg����lWF�,]\0HN��~�zZ���Al6�lc�k�lZ�T������ ��T��uS,* ���_�D�H��0�eS���$��� 6����/%,��q̧���K	��Zp<̺�\l��I�%g�m�(=��48HO�.������tO��Fp��!���̙
��`���(*��H�f�E�"F5�p��Ս�)+��ž[W�D�݇s(8���ÿ�߇�>��0S�&��ѐ5���{X��8Pp��P�=\6�~��E�e&��8$./_3�`�/�@��u��d��hh2��̈���qӾ��ۣW���)�˪�z����塽���v�])��w{�Jy�� �}S�UwQ�֍����r��.ύ����|�Rɪ�������ׯZ���M�LoC�e�6�s0���ђ/ki��ꨲ�6z�����)uǅ��ù[�˟)��H�mȔ���iOhÑ����G+����\����m�j�ĉ�3��Cz��$��g(tKC�ٷ
�	nN�<R�5J�x%]�S����6�$��q����9���!db��`/��-ͶAB�0r�f�~�d��y�Y89���,���u�)������A�oR��h���n
�����V�xw�p=�I־��yd�~�a����8`���
4��W!ImG\q���������!u�F���{��������W��땻ͦ_��+�Ae��;q3(g۵/:����^�n��)D�[}W����u�{�Ny���]{b�8
ψ`�V$�N�<ᑤ���4b�W����#�ە��5�vʽ�FW�}�C5:��չ˛��m'��T��uul�EW�(�1U�����Lfi�G���b�3)�0���q�����uE��d�7�K��C����\f��jqP�\&y���� v�fP+�u�/=�fF���2�?��;z}$��Yۚ<׈Vt��ՍҥL�P4�\U6(t~T}���&���)1�pg�#�%[M���)���Oo�,7buؚ���n��Q�L򯴢,�ƭh7O��Zd��v����-���c�R�@M�+�O2��i��̓���`{+���a�["_��̰�=H��/����u�ԃ�I�9q�[][;�c��d��G��<������Ⴡ�y<:z��wfG�A�E�v�eo�3�zE�{m��r(jۊ�{~:�bj�g���N��I[�����M?P���K/�Z��C��+���c�� ��S��_ʼ�~#�|/�"o~�6�LZ���1�݈c�vR�ef�T�~ɖRYfq'n��v�?҇!	ƽu7>�(��D��?֋a�8q�"�ǎ�f���[r,N�km���ްڼ�<"i�D2��}����X�� u�F��%��e�0fN����0ܚzð�F�ѵm	��N�L������Gw��.�_lv���iu�v�;���=e�zE�IaL��_%6n�8��'T�3\M�5=��VLBE��;q���� ���KS�
����+�����~P�͊Z�����m���M#�/#�4uu����I��E-�Q3��W�V�@.(�7&�H����D��3v�� �Ț�?�IF-,6Y՗vw�0�� �{Y�^�n�{����9��Aʜ�Qb�S7���7"u�F��O.|�t�i�q��W��˗� �J�       *   �  x�%�[�� �U�ٰ��]����*u���!i���[�#l����&ʊ�B[��^��p\����	��-9��ؒc�s.��15�=����������gln�eq"{.�qz��[���+��+l�&���q,�F\�|�B(?H.W,�H�W0H.X����]��#�R�`��R�H�X��dUD�F�0�� Y��>+��X��Xb��C�v���X|�2Pm%ZrG�J�,Ա-u�D�A=+��?k��Yk�򡹑�Շ���V�.k�*��m�*�c�;F��h��k-Z�Y�V�وV���������֎)�:0m#Z'�z�օ96+��6��`��h}pҎ&�Bܕ�K��)�o�)���w��K�ǯ�~���#��3��cO��h1o��ҕ��|?q��V�SPr�u{�������c_��=�����LAl|h;��O��p�����J�����C��M��Y�a���19�^���,���_�8J��s�q�<[�X>qM���[͜�t9��8�rc�p&���z�L�˅�������{�t���Ow�Wn�Y���O��N��pXi�S��:~�a�u�΂�J3��K�a���ؔ�ա�Y�bT�O���K�[@��1ױ������?9���      ,   �   x�u��n� @g���b��j6Y�d�r�K������!E�Z�����{ЪsZ(�h��+������j�F��z@c��[����3\	%E*�I��7J��G��׺�v8�ák�v?l��)�J��u��Ce*�T��l[���x���͜l ��+��+S܈�z��KT�Ɣ����2�'*�֘��	>2�������?�p�_���^Xc~3      .   �   x�3�LL�������Ҽ���ļt��������\N�DC�p��D�� �JSǊD����}�T�B'�B�dϊ�J�w���B��L�� �
K=��%�i ����T��L��X��������H����8X3W� (�,      0      x�3�4�@�=... �      2      x������ � �      4      x������ � �      6      x������ � �      8      x�3����� Z �      :      x�3�4�4����� �Y      <      x�3�L��2�,K-J����� $u�      >      x�3����� Z �      @      x�3�4�4����� �X      B      x�3�2����� l       D      x�3�4�4�2�B�=... 
      F   (   x�3�L�L�L��K�y�@2��3#�,�3Ə+F���  	�      H      x������ � �      J      x�3�2�2�2����� �      L   "   x�3�4�4�bN#.cNc i�i�i����� 4yu      N      x������ � �      O      x������ � �      R      x������ � �      T   �   x�uнm�0�Z���x�%�	�M��_Fv.���(~xd+���7p2������>���|Ty�l��M$��N��" ES���0�z��6{b	L�y��2c�H���1�-"1hp�g�9��T�5�p�5�)��J�ш���|�<6���f��=a$�.�%�!�K��8�{�"7��$.!c���� QX�      U   X   x�36�4�4�L�+-N-�-N�+�-JM�L��+�9��̀�p��E)�
�9��0Q���	X36�-9M��X��p�݅��=... �g5�      X      x�3�4�4�4����� ��      Z      x������ � �      \   0   x���  �w�$��b��C[W�T���>i�/F훣��[��|      ^   <   x�3�t�K��,�P�H���L��4202�50�52V04�21�26г04�)�D\1z\\\ ��S      `      x������ � �      b   J   x�3��I-.��S0T�H�����suu3��?NCN##S]3]#+cK+#=3KS��@������� �nW      c      x������ � �      f      x������ � �      h      x������ � �      j      x������ � �      �   �   x�u�K
�@D�5���3�̜ō†%(��1�&Iצy��M	�S_�O8��@H|C�Q:p�곐%��<�tF1�r�тC���ֺ�w�dr���uU	L�B[.���L}���K_.���+A��6����'3�+��l��2��(e3E�ڥ��5�|��KO      �      x������ � �      l   �  x���]j9F��V�D�TU��E�
�33�L&��)u�%|[���eݪ�����������˷���~�s��"o�WO� �ݿ\l������6m=3����up��Ƽ�x�
y���R|��nхE�P�h��[��R6R�wK^Z��pٖw�e�P�)��R������稐w���V"�CCkM�Vȇ&.5|$�|h`���I&{s�����cbȇDW���$Լ$6��O\ ԽV.�ML�g��C��������Р��~��{��xօ�������n���T!&Z��fcH����kmL>3A>L|�.���y�@�CV���h]�!}�����_Ȕ[�dVȇ)=~����7(o��1���Qi�;���|��ZE�10�CU�7�QȾ��8�íJ��4Q�|�h��[@��h��*�:�\�~��:J#�S���c�LoU�v�B�|l���l��P�B��*G���9����u�B�G�8ݭ]؇ʐ��:�����\&sr$�Sǫ�:+�)Zr�o�8�뽑M�|��Χ�3-N�L+�v��t��Χ�3�N'�Q��8B�G�dq �l������{�N�V_|�K�t��-MNnF6������v>՟�}����v�7�|�O���Z��;G�=u��ܞ�ȑ|O�]���^=�l�G�=u�����.����|f��0�x�5d��<N�#�:�Ş���S|���|O����$��[j{���k���zK��_����<����|�N�oQ�&�e���˚;���S�iل�����1r[���p���c�4J�H��N˭��K�w��:{j.%�k���g��@�.���e�������L�K�^���4���Х��FI�A�ω��xO]��z�L�C�2>�O��K��(�kH)�^�ȏ�}�ι���yI      �   �   x��ˑ1�"�-��8���\�]� W|
���a�<@Z)(k%���.⫤��S���S���%W���c���<Up�R9�9l�4*KWū��S� k�S팴8���
��>je���Y��G�l*KW�3�t/��S>m������;�1 X���\#��K��٤�GCR[�C�?3�j1�      n   >  x��˭�0�5Y����q/��:F�H �t`I��A�f0���Bm������n^~�}|x��:�;JЯ����WA%��J� wWQPS��P2�Km���z�1=�AX���Z���W#�"���h��h� ��0.�Z\�Vk�1�Z<�AZ���Z�Hk�C۩�Ɩ�BZ�b6�Z6s��r�i-/s����i-렬�a	e��
��
V���ni���S�e��5(k5���V���Z}���V�}�������b�Z;��:م��{{��h�����/�Z_�Vk���Z?��X���ڈk��X��������"`=      p   {   x�3�(JL.�LNU0�4�4202�50�52Q00�21�20�3��-n��y\�S�8�1U�Y�����b��
4$?O�P��(5�$3/]�%31'?=�M���&���V�&z�03c���� F�1$      q   3   x�3�4�4�L�+�/J�-JM�L��-��K�+)�4�2��5����� i��      t      x�3�4A.#N# m�e�i���b���� 4 m      v      x������ � �      x   �   x�3���|>eŋ�/֯}���dgǋ�[�����c��is��Y�d��M��
9�٩
����FF��f�F
FFV�V&�z��aKC++S=cc#NC L���K--)J��2�n'��+���z�t��=�����)
��Ey�y���X�YZX��hje`�ghi�nc� l T�      y      x������ � �      |      x������ � �      ~      x������ � �      �      x������ � �      �      x������ � �      �      x��]��6���y��gQ��-��03��Ld'��Hw0Xt�ʦ�Jɒ#�U]	
�����'Yޯ�2e�nu��i�H����|�hSl/�r6����l���%�����r[gm^���v����l��K��&?k�+T>�c����]09�4�m�򲙜�1��W�E�&�m�E��e^��֟4(��+����&������d����9*Hce�F��Zfۢ}S��7���W�ո�śo'w�j�E�f�%����[�/.,����*�;���d��w�Eڬ"%	Hv�y�o�h������hU�5��:or�BGk����h�eQ/���I?�a"g��y9�޲�5�?�-Ġ*���N=��"kڟ�x�B�j�1�5ȇp�A�:o�A��̯iI�9�t�lT��2+������k����
c��N=H@�%j6hdY�P�C���(k}r�
{q�'p'�:�^����WU�W�|�q��e��p^M}[�u�R���oB��3�Ux�>�����Էն�v��zǐ��w|�;���|HH@�җw���������zU8@�U�� /�f�y�2� �f9�놂>�{����Qu�+���~y�����!(����Y���fi³	��gfL�1aƄfL���`F��><�F���0><�D��������C�����{BG���a�DC]�t8���K	z8u�qm4��-�`�qQ�_E;~�V�6G0�R�1X5ȇ*�pLՇ�������������/��J�+A.�R�I�O�6�RuA4�
��43�*�2B�!�^�w@��l���T'��-�,
m���ң�(�8��TrR�Iu;)�-J���
ʥ�y�×�8�zlg Qh�}�b�{�̫�}'pZ�۝�m�Y�`��nC��Y��/;/	$8� � �����C �3��Uip��\�񗽀{��|�)�l1]҉��,M�c�c�����a%QV��0k,i0���H1�l-�Z��bQÑ�,;�Z{a.���
�Ķh,>a��Iq4N+$	%H�Is�Mh/<�|�HG�Q���.�Ҭ���u�H_�۱Z�8�%��d�RrH��!s���C�	�m�@�E5�j\��);�Pm�1���Ў@�����T������'�%��,��>��b�D�����&�榪=�'�,N�)���Y#l5^�w���
P+�[�	��%&�gG/�J�:�6҇�y���5�y�,��hăƺ�,��#&K�/]��
��(�b�����pX�?f���b�v�u���:���!)x�:���D4Pa�G�k�P_�ұ��!��)�f���u? ,�I�뼨�9h)�&���ɳö�F��$�L���jQC���xo3��|��}I:n����'o%L�0у�D�<���8iQ.y20��B*G�&ik���^�^4����Rse�{[o�W����g��������]�b��V�|���т���Gq�]hM24����{�29+Q4�3k� U^��"��ҒK�4a�t!T��5i���4��GI���9f�9�1�ve��!�5����a��Np4�����dU"@Ip!F4��9E%�{��S�ț�ؓ����ڢ���!9�s�yl��yV�����ϳm�����,ï�I�t���ϗd���I�
������`CT9k~�f5�Îx�G1qYU�<��Y�z�����nޮ�]��
}ڥo����(�Ϲ�a��목�m7y��n�>|H�^V�X����&o[bb��=௨�IRAٴV�uGS�N���K���6uE��i�������O�׻d���|�cl竾C;_y�zN&V��"/��.;x�Uzp!���gE�"1�8��Q~�Ţ�&��5�.˼�:���"�l/�v����T�9�Wk�����:��?K��ti�т;m������� ���&���|�ʏ;��3�a_5E[�8�f@n����Gi΂+o���.L���.��r@�Lh�[[��K��pƩuOש�����~���h�����@���{ؿcPHX��ԙ�h��n�Ԫ*��ܖs*ح�u[���R� Y�2E��uVRtƁ̤��j�)n�����Ӽ��D�&�f�i�\8���r����*O3�&���_�d���]e�	�'E���|gz�c���$����V��_?����_J���~�������mOnH�?��7&4��<��t�����~��ة��:�#d�sΩb����N~��Ǔ?���ɧ�#�}���^�'F�oWYy�Lɳ�L�d�^g"���P]��|���:朽�ϫmٞX�3G{NglY�',��x���!3�ʮsN��:m�������ex��E>�:�� �F�
G(��Ԡi̎��ҷ���]�$��<�k^����9Z�Ů2�m+G����Lt]�0 " 4Zd�q�-
�5\q�׈�7�Z|Qk���� �eN'B��F������]-�ʟ��m.��EGY�K��^{e���u���a�ˢ�Fi�S����u���[)�+�L�>��ު0ҹÒz��DV�'��MW��{��x���Sc�q���\�Y�`��_ZX5�ޢ��K�Z����Ho<��"kV��31Z�����i1�<"�e����?~Q�G��^�1K;fi�̻c��w�����6��|_a��C	�3
���Ũ<x��i��COs�&��Ɵ��qZvOl�_xQԠ�%'�/��(�.k�H����p�!�5x�!���(w�0��2��=9+����$��{��(����6z>�7�i�1(CΛ��'{�aː�0˲c�ci��ZR�����m��a@�~ƧWxc)�>�Y)���Y;2�FU
�d='� /��k���3@l%�t��]�4W�q�/a|������k��J\N®)2*�O�Y�%b�O��΅���X��`-�$@��.M!G
}+&��v���wŬc� �^ᮯ���;�'5�������r�Y�m�Wu���^�����&��:��&o�*n��Wh�%C1y���ӯO�|}�o���L�����~�FK�_�x��ٗ_�Փg_�M�w��uϟ|UN�j�'HheQ�%q.�I�0!��ͫO�?����E?�+}b�g"���	*'����͉u�=�&��N���J�U�֪ǳV�w���G[Hж1>�EaN��W�������p��;Wf��aZ�oqFY���/���%w�xϓщ�%�,g�K����@���Y�����}|���f����r�P��'�A�tԗ--S�G��E� ��0�
��|j��Vkg�r�l�{��2j�I¶���@/!��L$2�{nW���%����A/VZ��x�G��/�
y���^���hc^ʼ����0�x�VƳҐ�⼜޻��O���M����-yd�(?V'�F��cIҦ�l-^t�!�^�|	�%��&�w!r��i�r�{�-�)+�ł���%���_��\1.^��X�DOiZrLf*[�0|��N��-��%��7��d��׎�Fj��&���^p
XKz|/���+7��j�Բ~��Q�Am�����+�}�6̞Q�ϕ��vF�'�3{)4$U�y�AW���	I�x��$NBp��i��}]6�Jb^Aԛ�#�O�kADp���P)-�C쑣���� �8�&�{�|ra##�.�cV�e�@�WG#�����Q?�����:!:����Y�x��S����������K���c��m�V�T�� X7�+U���M;k�+��0b��y�����x��UQ�/O^���H��yf^.���ܼ��t���w[d�K�JM*sfN	��,�Nw��w��s�W��m��3���#S��W����m^,���fֶu~�m�a�VIvc�}4!7��?��]�i�g��BW����kq�̝�Y�uV�N��rbN�W�|����=�<���Ȥ�M]�is4r��pz��M�tQ�]N�F�8]�<���}[�*�M��3�,�%�L��.���m?�"��͙4|Pn��NFq+����K�`�o�5�&���U^�5*m��Z^~a��������K⊔{ˮ��q�7�%�\2p�ΫRdѨZ��-k�    ��6Z��V�KdOź��E�܋B�ನ.��R�ޥa�nh�z.��4�gϾ���܊Z-(��L	[y
T�݌!�f/M!ggĤ��Ͱ�~ Ey�''N^���2Ț)����%�kx[�e:}����q�3�9�� ����������T_T��d�e�ݓm� �Z��NZ,�����k�M���<u�����/c��8���oj�DXv~̰��W�N�#t�T%�;6�m
���U�X�R)	��F���tr���&�\lr��.��HK���1�2��ѕ0�����>x������2�|n�/(�F�'����VH|�ӴƦ%[-��O��f/@nE��!�\���f�u[�)���Dj�{5L��.���X@H0w<l�A�9J��6G�C��vC%�ݐ@H;î�V�V.#�O+��b���{MT�-=��2��,�T�w��[���8���(�ЮܮQ-��Er3��[�UeA�|�-��l>G����i�5���j[���H��?��@��J$�ƈ���÷�L��[�8�{�m�P�� ��?h�^�/Q��ta�ȱ"��ҏ\2	i�����V2���'��C�p�� k�n��3" �=ۑiۼ�`��W�Gd`+y֕U2p����H�1J����ᘤ�W�t]g����2���|8,�e�D��QӋ���
>Ho5eI�Y�ʵC=!�A����#"iS��N8cLl�3��Mf6����á���!���n�'4�^��O\�5�}L��/�钪��	��I���%�	��́�G������
�/���Ҕq�2�7z��=I��@�K��{��WL��>�2�F	�ä3#g���+�Ox
�ߚg=�n�E�Ҫw�9\���U��eU��6�#]B?kV��[��Z�L;Dyb4��Y���.�o{S����L��S]�\x�m�Q����B��N�3�a���J�;>q*�N����v������06na�_g-(��F�c��$�76�0,�bõ#0��̨d̘�6Xf�.�خ�Oy7ъI��h�-
�`!���Y�B�Ti5>�j�4�yѡu�(+	Q��3�6�~�����1{�!	�$�p�C�!�G��Lv�Pd�Ś�l�L�Q�
��r�.���e����]�fYxV{�&�{����4?,ެ���Ѥ|��ݮ����v�lN�6ό;��5H;L��V�RD6��4��b�;`�G��"R��@נ���x�mL��Ӳ����^ ES��E�M!��[-����M�NѦ���Gd�d��F�x��8@�	��vl�x����G�����I�>�=��V����P�z�o!�J�N+<P����Q�:�c,P$	<�ཎ�`���;���#F`�����#��n�CyH�t<l�J��If�S1;�#����v�}Q�����(��lYߵ��-���&�:[�/����E��8����y�f�M��&��:q���}������`w���O`����<�	������|����J~�9���7��jUyʹ�p�4��;�E��Fփy�w���,�f5�Id*��O����<�5Id*��%P<6�	���x�8Zut��� y�O��f��R|>�)��z�	$�`@�#���!'��RͫE���'_�S��� ON�`y��)���T��v~���u=�hD�Kt�|�}���ػ��9d:dm(!�����tg�s�y��d�u��Ye��[�|&�kv��'_��L���������B�`���X�|3�eS�wE:\�_:2��z�j���1�U����CX��(,�-V�|�{U�yZo𯲥i�ٔ@��-qQ���|B�Y,��T�Y*3X�7F��yl|c��0S�e��Ύ��k,�3��(�ڗ{�?(��@�wSW��q��<+k��@5m�i�9�+�O edlr1ʤ|)���(�P�mz��M���f���7��9L1y���G��=t;�}��yԴH�{��\�;kn~;g"܉(Ĕ�>�{���Jm0#c��ide�c[�6o���C��M����'2�B0��QA��1��-�#6�̙�AEX�$3tN�w�t��ߣ)E	��7���U��@רة컌4�2�)Z�Z(�T$h_�IL���u�2�����n&����y����������>�4���b�1�9�X�t�#����N~;��䷓�`3I��᜽D�9�H��~��BC8W?�s����Ah�$�G���q�?�͌����~H3u�Tۓ��3c.!�Q����ZDV����Pka
�.��q�/��lq��k4�~����y�Cu���}��EV���v|$�7���}-���&�������v��gEiK���el~[5w�g��WU��n�٪ڲ��n`��U�fY����&O926G��⳧#X]If:��d�Gn�*�Fn>�ב��\Cn?���������nR�l���e��w"��J<�z)w�eb��a�3�iYd95 �MyOi����35&<��@F��U�X� %d46CA��g�r�LzB���'e;\��q���nok���r�ǫcj'��0�ES�D�Od#3n���#��нhug�i�����2RM�"�Nl�KtA�>�M�}�wtg����鎌�Q-G�vk��&s��?���Fn.�BꙆ;ި�!��'A���~�C�bth�̫�TM�j�|��̪�K�{+Q�A�.��Z~��A�����e/�9Ĳ�"�43�F�<#���8߀���YQT8�!��t�PjH�у��������L+�0i����>dk<dZ~�.q��<O..#��?�K��%ڶX9��N�0���92 h��Q@�䙒gJ��{�!��T�0n�:�ˇWUwr�����:LO6�N䯘&���4�۽����+}9?�J�����"=:sѷ%9�a���� �跐�=H8vdl�
�*	~M=�d�w���oa7���Q��?�%�U�^�Wh����Y��hX߹9'i��C_������׆F�lk0�O������Ð�Ә�r�0dc�R�>&��> D,�@$�_�k�*�NP�>|������nE�됮����|�c
?�6���cR�MV��j9k6�W���Ֆ�������W"d�T��!V�_����Ѧjr����_e���d�Kv�@]Q��cD��%�5&6��,�;`�ly��ɖ�7��#�, ȟZ��_U�Y�js���a � ۄ�dƦ�Cfp|�*}���ӏa��Y3�9U�%��%ڒd�(�|��ᗊ����撄����3�(KoJdn�Fm�[��.i�66�<�^���Q�ʵ� �H�!!��bH���"�Ã���U�;VQ���w��b�����ӯ�!�q6g�Bșt^��L}0x~�Mǣ?�����k$���mq���2/���O����^`��ɛ�?yL�[�Rd(59��Mְ�-:Xo��e^�J_��ɋ7����lb�1����VXC�J�]�c$&4Oʹ�?�t��'��MI�fϺ���9ZU�M�@B6*��%�S��;��c���lC�/3�.�v���m1O�N/w��֊����^���^l���Z&���^��x
�K���yV��("zaՈ���D�:]�h���(����@��!T��j˾	g�qseXW� i}�;���6(�"yw*���uޟ**�j8�|rPt��d�(�'O��ę7�*�A���_��EVJ�q���V��v����L��>�%��J�z�:��� j$�w7oFi3�
cp�Sa�
Qmf�����p���¨UXM�p��_�c^�SI:�ɪ`��(�[��Ð �] @
��}F9��8݁Y�e�	�q��6�n���6}�����rXǌU�C�0���Ø�l^eYV5�A�U߹p��,��)�ݸU#«��b�
���1�l��3������v˼nZ
b��M��1�pT�Q��7��aG{:�ұ
���&�	���6 "��;�k��x�sʄg��V   Zj��a!B�I￷W�=�g5Q�2�-&j���r(P�k�P���Y6���r�{׾K�VU�)���0h�(���?{����c�4I�N�{�7$#��w�� &NO�'r"�&J���xb��52�7�	.:�H���2'k�C����`�)�bp�h�gV67p��K�Dςt�@���2�͹^�W��=X��0s���)��Y@]- ���#���$8���d}��c}�ch5#lN�0\�E6��ض-��Zi��l�|�.�o���Jcpk�?���B
i����Z�L��0�y�W�9�YO��>?ma9a��d��NP\�^m�e�p�(������D�IH3�� ��+�����y������1�d[��8O��'�]hͰ�#z�nвl��!OQ%CC�>�o�~
b�N�p4Bc��><	^�3R䷙���S,�HjPU1� ���>>JR� �v-�pP�SPkE2��zR�*Q���{�ا��|т� JR���
�+p�yI%�izu��<*�a�o�5�4��Q�[g8�6�k�:�M#}Y����9M(+��8�q�A��c�Zvw��0Zi��jE>�ۊ�tp�T���T���L �.�U���뭄�%o2�� �@а�#�*��`���qA��ؓ{|�>���aDW�,�$7�ƍF����ZQ�\,�j�)�j��k��i�)�� �����n(��Ql8���F;<�FћZ�<x��� ����4��x������5#���	�zpB�k:�`n� �f��8ɹ:����6�� ��r�x���ݡlط�1F��Bm��hӮDT\s0wIo.a����S���h��AZ(�L.���jXg�'NM��ө�Fu.	�]�ᐳ6��T�a���xd�p��a8B�G��΃q�OzӒ�"x�S��Y���q�}��V�F�V'��=n��)g�j[{��7j���j"��ZW-�]��6h�186�'4��HB#hD�zT��X@1홓������2�ς%�C��m�
J�Vy��Ѽ�ь�8˶�
C�fC�?�~�_����>���l�-
�pS�XͯЂ<l�Sg��HⰩ�e�"��AD���a؋��HG�p�aX9�f�b�S'�b��Hز�8��]W�'��8 �\�p�56�ԪGT�&�2ꪼ���(��d6trL�k���v	�cT�rz��B�oQ�gth�GY�3��-	g'��`qvǪ�棡}B�I�9I��� `ݶ�N���iv,3�;\m:P���g�}��տ��      �      x��]K��6>ǿ"�������RI�M��i7łHH�E2$53v*�}	>� �՘��C[������&�����)�.�����otě�MQ�(#A��8(��O\�$9��$~�����쫇��i��tLF�HT�*�d�ߓ0�G����M�,'G��ܖ�	o�VD�_���Fx�Nq�9��&�8�n�����{���Xp��ݣ���l�C��H��Pͮ�J��zMMD��'�3(�Sٓ��ir�2gT3 �NH�&t� ٔ�`��� ?��]��_����܆S��;�"�=�?�4�Yۇvo�$��@"vic�ؕZId8?�� i2�[~���NT�(�}	H��7C�ތ�n��S	(��V�f�dk��M��8�I������$OE#J��{*M�4�	Ǹ�}~������_7�&mh/PXV��@� Cy��$���O�ڵ,O+�*	��G�&)[x c��#�U���&�,����z���8$T�6���o�>�����#�@%K|��ɚ�J:�-�9�wx�51uC��аkV4�oP4&�"S�'yQB��1��Aw�>"��)T�iA��q�ˠ���=u%r| 4�
pn����0�k!A�e��=H�1�Yj���%�:�J�w+�߭��݊���[�а�Vh�ޭИ��
hK�(�aN2�0���5�n����~|gʹ!xN���'�A��@���!.� �h���TĞw�SF���y�=.24��9�b���ܮ��.؉zX3� �x�F��4��=	+��ap0X���JȄ����7%g�F� �"���pć>\�v�J�t���f�zBF���ܦ�8����qO��ŧ,NQ�k�E�O�R��wA�v����T����f5��K��@椨����6)j�7�����|eR���Q�O̩��0��V�.����h�ҾhLnE6:DCqI��h�Vо�g�x(�H�
�l���]�Rw%(�Jo����;T�An� 	�RԦ��e*G�����nS[Ț��p6��j��q�*C� 5c�,y��;�Z�{�-ֲ���7mZ�=b����޷�X��Nx����1�2]�uBƖ�j2:H�d�ޗ���F�(���7�0��������$�MF�>%-�>%���/1uOM@���Kz#*���
�R�k�=�^9�
�螚���'�F���މ뿮�E��
���dO�)��+!Zn��5���[�k�����$��Řmx�m-�=.H�=�ah}K���k��}����'�뗶�$�շi�
��Ms�+������h��u9�+�eP�%F��牏y�\0"E@w���7�y��-Fg�زG14	1.����de;i���˺�ym����e���i��&�"CU�B�Tdm��v�3UiG�!i>J�X8ow��1�;1~�1'��0�-�FDgd�Dg�+2'��@"��I�ïq*�}���wO��q�BGDl���� �Q�+ǒ����Es�|9�'l�4���1	�����A �"|LK���Qy�>}�qz-���d�$�,�Q��+�i��X����x��W��>��y�K��O�S�K�:�����\ZS\���}6�c���|�J�*sa�}l��{@�5&X�՚��Z��+IE�����7`�%\��i>��9����'�tJH)Y�S7U��i�k�W���b��X@ߊS���e����B��\����*X��m��ǘ�53b0:P{b0�57~��ƃ�cc0�o����~n�	� �1*p�՘技��'�����}Pd���I��/��n��v���ḇ�pG��,�'��.US!!l:Ο�x���Mj��4�� ��)zi[�K�ұ��������$��w[2t�;Z�?���r�d���ݩ,��p7DRI0���u"_��Kݚ�N� ?�ɺ�̖��려x����)�Q��>M~��}Y�ŝN�q�]�l��v����:�~\� ���W4���ꏇ]�|u�Ř��h,�%�4�"l��oW��;�GY坥IPT�O1��]OO$&�Ԣ��ɟ����|�����;��Ǻ&�7����D�䞓�����fӬ��If���*DX�~��l{�睘�NȤ.`b�w���re�MU���zǟ�du�����g�n��к�İ��4i`�&��7����Lr��_z��ؘ�\���-4�YĞY���uD�X1陼5��,���� ̜r�-̱u�"K�5�z��Ф��ZJ�=� ����z��d��m��,<�UN;�H@����1���/���=�}V��;x��Y���ҥʂMް�~,����E�(�q��f)�h ��jQ�}q�˗Z0�-�>N}�V$�?���#1hn7�I�a�Τ�}�
��e�_FW���!�?(i��Y=��Ev�ʏ�Y\
/�9D���3���'4��q\���<��}څ�r&����;�،)�c`fM'���Bѧڌ��&~i��M2������a˞����Ә*�����S��Q7��k,wfyC���Y�WS_v`T��"��,��0NY�����m:��B2!`y������M��ټ $�]D�%��oʔ��1ظ	U���ड�(�
����h]���n.�G�p��\�j�OC��O�V����b�TVj�\��ި�"�}��>����2m(U��꧀&���	,��uJˣ��r�k�t���G��ÏD��A9���i� b� ����:A��>n��S='嗙��?O�)�/N3���po�*m�k:���#*�V͏?J~Q
:\s0��l�>>몂65������@�J���05�rcؽ�I�� �C����2�r'g�X�U��;F�`�Yz�8X/8E2OG��|SUA���0dD�%�mI
H2 (�%#��Da���ʆ(���e煽BP�����k���2�1:��Mz�3'/	?v�>tHy�� ����&�s�L�%��j�b��k������I�tD��2]'�I���q�阵�c:Mh�_0U��p�KFC��|�i%M��&C�uJT�������ղ_���V��ֶh��~q@�$�/| �f�G�d�o�,���$#}��u	C�d$�c@�"j�-0\�.�jF���G�Y.�]�k�鄋�������SZ�	U�C:���}�-&����1�Ҝ �xe�gr�@�cP�+��R�y�U�a
��x"nB��Bz[&-2�\�3ఌL�+��C~�@em+�����L�@����X��X���f�M9jS�bC˴�l��7����Ͱ��ê��,��S�@��	+�����%��L��~�Wr 2i��$S�y:�"}�-`cb���	Ψo�j��]a���k��S�q��ή����uN��T���Ͻܟ_+X�����i�?�^�	�Y�ˁ�Mg�Ӷ⪻f!0�?;�-f�{-�����.�n�:R�#���߱d�٤���:�(duh-"˔��H'}uFqU�Fs�V�s�A���^	�T��D@&(�Z*EE3�zaQGF1.�=G`$?de-mI_����h��Q�
.���7���fBu������vN[��x�\������������f�J�r��8a5�]Л�hYg��8L��Ԟ���)Nk��^ng�4+a�Hu���Sp]�'l����ҭ���A�pM���˷�g�m���*F���N��g[����]q�K��Z�����+�d&,z���6ܯ�"^Z�T��@�]��T�V����^Z9v�dj�T�.�j����U�1_�5[���
:� ^rK���򱳠��iD��H�ܡ��R)��Sd���	En��|f0�����A�J�aHW�ج�K>*4D0��pdF�1T�p]t�ڹsv�iw��F��ܙ�j��$*ŗ��x�R!��`���L%1�x�u��f*p���������"��$c�yc-t2�$�G!>d0��8
+�a|�\��.|PQ���}� F5 Р'�;s���i ��:�"�m�=��#�l���A[*snZ)�8 �  O��77$�J�� �yY��P��"җ3����Ղ't�b<�F�]a��&��1����T��TzS ���,_V#�ZIIsw,���}^K���:*�'K�
��@�����*�1��-��|p�[JKYZ��G�Q�怍#郴 �0�$���h"ՕiAi�).�QS��(�^%�Ƹ��!���(�,��"�XZ���Cc�L���'���FƧ��`�L�_ܲ�ėKˏzِ(=��++j�&��A��[g���/ k[����Q�S	l�'.R@�',>�6 ,>��?"R��3�3sP1ٝ�f9�舫Q�(A�;�_�
&%n�T�75r�Qc P_��Tz�e^M�^�����ys���w7�{{��7��?ݾ}���w�y�������7�@�|��߆���o����w7�����W��e(�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�u�1
�0Eg����%Un��:u��	^���'�).���$�Cs�R��\��f;�C7]����U�����xH�=���������6M�s�e�&#�t�l_/����ϝ@���DE>������9�      �      x������ � �      �      x�3�4�4����� �Z      �   �  x���ώ� ���S���c�Z���]�׽P�8�D��J����n��[���f����_;m��z����Y{���`T�Y�0�� �&b�d�@@8O��_�ٳY^�h�1�����N�w<Y�����$�����Z���R��9jw�C�7*�9�i?(��ϗ�^���zL�����5��Eq�?5ҵ��M��<8������:�G2̓�bsf�������!k^@,h%J8�I=���f�%W #��#�Nc�f�� �L�/�p���?�F��mf�uea+ܷ.}�'��z��u©႔ӽ<�#�����մ�
������$M��c�����(�����Ƶ��{yܭƽ������u��扒FyR�`����\����'�=#dl	S�����G��$g�M� �G���ws=�3�ө��&�������V԰�yR���~�5@ty      �   x   x�-�A ��c6�����;��F���4�`���f`�q"������m���nڀF)4�سDMنY���]��\�ZǤ�=S@5Zt	Y�U�v�g�S)61��ؾK9�Os~?$]�:      �   �   x�u�A
�0��ur��@��$66;��x�nb�(i���W��B�Y�0�cq��!�b/��q�pM����Ps��sI}(��g-��#o6����y���|��z��ZML�;�N��}O���؟��c�Kw
	�=ύ6�Y�NK)���Eh      �   �   x�u�Oo�0��sy�Z�B�#�E�d�,�f����):����/겝H���I~��C+Y��S!�l�q�Kt����Nd�l&mJ엂g��l3���cx�iTt^\���6n�\�J������D͍��h���A
1����!���	�`B�^�/-@����AV�i�z��:�VB����SZ�8�򹀫���]R/#5X�n
��4�S��'���|�3��i[lY�j�Z�      �      x�3�4�4�4�� �f\1z\\\ ��      �      x������ � �      �      x������ � �      �   b   x�3��TH�UH���KW(�W(N�����r����8�uL|6��钕O�v?���t���M�FF��f�F
F�V��V��z&f���05�+F��� �^$�      �      x�3�4A�=... ��      �      x������ � �      �      x�3�4��4����� ��      �   v   x�3��H����|�w�ӥ{9�R��8��Lu�t��,�̬�M�̌�
F�V�V&�zFƆ� ���e�Y������|����r��A5��*Z�21�3�0�)5(F��� �>%�      �      x�3�4A�=... ��      �      x������ � �      �      x�3�4��4�2�4�F\1z\\\ ��      �   �   x�3�L��|�8��YCߓ�/�o�,K-J�LK�����K��I�4202�50�5�T00�22�2��3�4B74�21�22�346�4��<N��Ғ��.#����lΧۗ>�;�ZH<�1����/�7�X���?�m�d�����1��&VF�z�&�Vrf����s>ٻ��ҽ�Ov4��X�s���O'�y��"�����P�1�6�22ҳ00ô�� hv��qqq tvB      �   @   x�3�4�4�L�+K-J��M-I����,c.C��P�$1='���HsrA5�q��qqq �@�      �      x������ � �      �      x������ � �     