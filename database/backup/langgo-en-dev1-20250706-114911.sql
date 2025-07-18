PGDMP         1                }           langgo-en-dev1    14.18    14.18 (Homebrew) �   B           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            C           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            D           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            E           1262    58892    langgo-en-dev1    DATABASE     d   CREATE DATABASE "langgo-en-dev1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF8';
     DROP DATABASE "langgo-en-dev1";
                strapi    false            F           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
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
       public          strapi    false    209            G           0    0    admin_permissions_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;
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
       public          strapi    false    211            H           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;
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
       public          strapi    false    213            I           0    0    admin_roles_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;
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
       public          strapi    false    215            J           0    0    admin_users_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;
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
       public          strapi    false    217            K           0    0    admin_users_roles_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;
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
       public          strapi    false    219            L           0    0 #   components_a_external_videos_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.components_a_external_videos_id_seq OWNED BY public.components_a_external_videos.id;
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
       public          strapi    false    221            M           0    0     components_a_pagebreakers_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.components_a_pagebreakers_id_seq OWNED BY public.components_a_pagebreakers.id;
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
       public          strapi    false    223            N           0    0    components_a_quizzes_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.components_a_quizzes_id_seq OWNED BY public.components_a_quizzes.id;
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
       public          strapi    false    225            O           0    0    components_a_sent_refs_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.components_a_sent_refs_id_seq OWNED BY public.components_a_sent_refs.id;
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
       public          strapi    false    227            P           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.components_a_sent_refs_sentence_links_id_seq OWNED BY public.components_a_sent_refs_sentence_links.id;
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
       public          strapi    false    229            Q           0    0    components_a_taglists_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.components_a_taglists_id_seq OWNED BY public.components_a_taglists.id;
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
       public          strapi    false    231            R           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.components_a_user_sent_refs_id_seq OWNED BY public.components_a_user_sent_refs.id;
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
       public          strapi    false    233            S           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq OWNED BY public.components_a_user_sent_refs_user_sentence_links.id;
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
       public          strapi    false    235            T           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.components_a_user_word_refs_id_seq OWNED BY public.components_a_user_word_refs.id;
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
       public          strapi    false    237            U           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq OWNED BY public.components_a_user_word_refs_user_word_links.id;
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
       public          strapi    false    239            V           0    0    components_a_verb_metas_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.components_a_verb_metas_id_seq OWNED BY public.components_a_verb_metas.id;
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
       public          strapi    false    241            W           0    0    components_a_videos_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.components_a_videos_id_seq OWNED BY public.components_a_videos.id;
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
       public          strapi    false    243            X           0    0    components_a_word_refs_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.components_a_word_refs_id_seq OWNED BY public.components_a_word_refs.id;
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
       public          strapi    false    245            Y           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.components_a_word_refs_word_links_id_seq OWNED BY public.components_a_word_refs_word_links.id;
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
       public          strapi    false    248            Z           0    0    files_folder_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;
          public          strapi    false    249            �            1259    58990    files_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.files_id_seq;
       public          strapi    false    247            [           0    0    files_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;
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
       public          strapi    false    251            \           0    0    files_related_morphs_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;
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
       public          strapi    false    254            ]           0    0    flashcards_components_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_components_id_seq OWNED BY public.flashcards_components.id;
          public          strapi    false    255                        1259    59007    flashcards_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.flashcards_id_seq;
       public          strapi    false    253            ^           0    0    flashcards_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;
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
       public          strapi    false    257            _           0    0    flashcards_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.flashcards_lesson_links_id_seq OWNED BY public.flashcards_lesson_links.id;
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
       public          strapi    false    259            `           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.flashcards_localizations_links_id_seq OWNED BY public.flashcards_localizations_links.id;
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
       public          strapi    false    261            a           0    0    flashcards_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_user_links_id_seq OWNED BY public.flashcards_user_links.id;
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
       public          strapi    false    263            b           0    0    i18n_locale_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;
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
       public          strapi    false    265            c           0    0    lessonlevels_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.lessonlevels_id_seq OWNED BY public.lessonlevels.id;
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
       public          strapi    false    268            d           0    0    lessons_components_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_components_id_seq OWNED BY public.lessons_components.id;
          public          strapi    false    269                       1259    59043    lessons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.lessons_id_seq;
       public          strapi    false    267            e           0    0    lessons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;
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
       public          strapi    false    271            f           0    0     lessons_lessonlevel_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.lessons_lessonlevel_links_id_seq OWNED BY public.lessons_lessonlevel_links.id;
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
       public          strapi    false    273            g           0    0 "   lessons_localizations_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.lessons_localizations_links_id_seq OWNED BY public.lessons_localizations_links.id;
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
       public          strapi    false    275            h           0    0    lessons_unit_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_unit_links_id_seq OWNED BY public.lessons_unit_links.id;
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
       public          strapi    false    356            i           0    0    review_tires_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.review_tires_id_seq OWNED BY public.review_tires.id;
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
       public          strapi    false    358            j           0    0 '   review_tires_localizations_links_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.review_tires_localizations_links_id_seq OWNED BY public.review_tires_localizations_links.id;
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
       public          strapi    false    360            k           0    0 !   reviewlogs_flashcard_links_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.reviewlogs_flashcard_links_id_seq OWNED BY public.reviewlogs_flashcard_links.id;
          public          strapi    false    359                       1259    59061    reviewlogs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.reviewlogs_id_seq;
       public          strapi    false    277            l           0    0    reviewlogs_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.reviewlogs_id_seq OWNED BY public.reviewlogs.id;
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
       public          strapi    false    279            m           0    0    reviewlogs_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.reviewlogs_user_links_id_seq OWNED BY public.reviewlogs_user_links.id;
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
       public          strapi    false    282            n           0    0    sections_components_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.sections_components_id_seq OWNED BY public.sections_components.id;
          public          strapi    false    283                       1259    59077    sections_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sections_id_seq;
       public          strapi    false    281            o           0    0    sections_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;
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
       public          strapi    false    285            p           0    0    sections_lesson_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sections_lesson_links_id_seq OWNED BY public.sections_lesson_links.id;
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
       public          strapi    false    287            q           0    0 #   sections_localizations_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.sections_localizations_links_id_seq OWNED BY public.sections_localizations_links.id;
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
       public          strapi    false    290            r           0    0    sentences_components_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sentences_components_id_seq OWNED BY public.sentences_components.id;
          public          strapi    false    291            $           1259    59097    sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sentences_id_seq;
       public          strapi    false    289            s           0    0    sentences_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;
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
       public          strapi    false    293            t           0    0 $   sentences_localizations_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.sentences_localizations_links_id_seq OWNED BY public.sentences_localizations_links.id;
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
       public          strapi    false    295            u           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;
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
       public          strapi    false    297            v           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;
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
       public          strapi    false    299            w           0    0    strapi_api_tokens_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;
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
       public          strapi    false    301            x           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;
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
       public          strapi    false    303            y           0    0    strapi_database_schema_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;
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
       public          strapi    false    305            z           0    0    strapi_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;
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
       public          strapi    false    307            {           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;
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
       public          strapi    false    309            |           0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;
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
       public          strapi    false    311            }           0    0    strapi_transfer_tokens_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;
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
       public          strapi    false    313            ~           0    0    strapi_webhooks_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;
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
       public          strapi    false    315                       0    0    units_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;
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
       public          strapi    false    317            �           0    0     units_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.units_localizations_links_id_seq OWNED BY public.units_localizations_links.id;
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
       public          strapi    false    319            �           0    0    units_precondition_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.units_precondition_links_id_seq OWNED BY public.units_precondition_links.id;
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
       public          strapi    false    321            �           0    0    up_permissions_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;
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
       public          strapi    false    323            �           0    0     up_permissions_role_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;
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
       public          strapi    false    325            �           0    0    up_roles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;
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
       public          strapi    false    327            �           0    0    up_users_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;
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
       public          strapi    false    329            �           0    0    up_users_role_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;
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
       public          strapi    false    331            �           0    0    upload_folders_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;
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
       public          strapi    false    333            �           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;
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
       public          strapi    false    362            �           0    0    user_profiles_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.user_profiles_id_seq OWNED BY public.user_profiles.id;
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
       public          strapi    false    364            �           0    0    user_profiles_user_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.user_profiles_user_links_id_seq OWNED BY public.user_profiles_user_links.id;
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
       public          strapi    false    335            �           0    0    user_sentences_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.user_sentences_id_seq OWNED BY public.user_sentences.id;
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
       public          strapi    false    337            �           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.user_sentences_lesson_links_id_seq OWNED BY public.user_sentences_lesson_links.id;
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
       public          strapi    false    339            �           0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public.user_sentences_localizations_links_id_seq OWNED BY public.user_sentences_localizations_links.id;
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
       public          strapi    false    368            �           0    0     user_sentences_user_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.user_sentences_user_links_id_seq OWNED BY public.user_sentences_user_links.id;
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
       public          strapi    false    341            �           0    0    user_words_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_words_id_seq OWNED BY public.user_words.id;
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
       public          strapi    false    343            �           0    0    user_words_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.user_words_lesson_links_id_seq OWNED BY public.user_words_lesson_links.id;
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
       public          strapi    false    345            �           0    0 %   user_words_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.user_words_localizations_links_id_seq OWNED BY public.user_words_localizations_links.id;
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
       public          strapi    false    366            �           0    0    user_words_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.user_words_user_links_id_seq OWNED BY public.user_words_user_links.id;
          public          strapi    false    365            r           1259    63664 	   vocabooks    TABLE       CREATE TABLE public.vocabooks (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);
    DROP TABLE public.vocabooks;
       public         heap    strapi    false            q           1259    63663    vocabooks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vocabooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.vocabooks_id_seq;
       public          strapi    false    370            �           0    0    vocabooks_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.vocabooks_id_seq OWNED BY public.vocabooks.id;
          public          strapi    false    369            v           1259    63686    vocabooks_localizations_links    TABLE     �   CREATE TABLE public.vocabooks_localizations_links (
    id integer NOT NULL,
    vocabook_id integer,
    inv_vocabook_id integer,
    vocabook_order double precision
);
 1   DROP TABLE public.vocabooks_localizations_links;
       public         heap    strapi    false            u           1259    63685 $   vocabooks_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vocabooks_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.vocabooks_localizations_links_id_seq;
       public          strapi    false    374            �           0    0 $   vocabooks_localizations_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.vocabooks_localizations_links_id_seq OWNED BY public.vocabooks_localizations_links.id;
          public          strapi    false    373            t           1259    63675    vocabooks_user_links    TABLE     t   CREATE TABLE public.vocabooks_user_links (
    id integer NOT NULL,
    vocabook_id integer,
    user_id integer
);
 (   DROP TABLE public.vocabooks_user_links;
       public         heap    strapi    false            s           1259    63674    vocabooks_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vocabooks_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.vocabooks_user_links_id_seq;
       public          strapi    false    372            �           0    0    vocabooks_user_links_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.vocabooks_user_links_id_seq OWNED BY public.vocabooks_user_links.id;
          public          strapi    false    371            x           1259    63740 	   vocapages    TABLE       CREATE TABLE public.vocapages (
    id integer NOT NULL,
    title character varying(255),
    "order" integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.vocapages;
       public         heap    strapi    false            |           1259    63793    vocapages_components    TABLE     �   CREATE TABLE public.vocapages_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.vocapages_components;
       public         heap    strapi    false            {           1259    63792    vocapages_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vocapages_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.vocapages_components_id_seq;
       public          strapi    false    380            �           0    0    vocapages_components_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.vocapages_components_id_seq OWNED BY public.vocapages_components.id;
          public          strapi    false    379            w           1259    63739    vocapages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vocapages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.vocapages_id_seq;
       public          strapi    false    376            �           0    0    vocapages_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.vocapages_id_seq OWNED BY public.vocapages.id;
          public          strapi    false    375            z           1259    63749    vocapages_vocabook_links    TABLE     �   CREATE TABLE public.vocapages_vocabook_links (
    id integer NOT NULL,
    vocapage_id integer,
    vocabook_id integer,
    vocapage_order double precision
);
 ,   DROP TABLE public.vocapages_vocabook_links;
       public         heap    strapi    false            y           1259    63748    vocapages_vocabook_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vocapages_vocabook_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.vocapages_vocabook_links_id_seq;
       public          strapi    false    378            �           0    0    vocapages_vocabook_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.vocapages_vocabook_links_id_seq OWNED BY public.vocapages_vocabook_links.id;
          public          strapi    false    377            [           1259    59236    words    TABLE     �  CREATE TABLE public.words (
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
       public          strapi    false    348            �           0    0    words_components_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.words_components_id_seq OWNED BY public.words_components.id;
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
       public          strapi    false    350            �           0    0 $   words_example_sentences_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.words_example_sentences_links_id_seq OWNED BY public.words_example_sentences_links.id;
          public          strapi    false    351            `           1259    59251    words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.words_id_seq;
       public          strapi    false    347            �           0    0    words_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;
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
       public          strapi    false    353            �           0    0     words_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.words_localizations_links_id_seq OWNED BY public.words_localizations_links.id;
          public          strapi    false    354            `           2604    59256    admin_permissions id    DEFAULT     |   ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);
 C   ALTER TABLE public.admin_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    210    209            a           2604    59257    admin_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);
 N   ALTER TABLE public.admin_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    212    211            b           2604    59258    admin_roles id    DEFAULT     p   ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);
 =   ALTER TABLE public.admin_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    214    213            c           2604    59259    admin_users id    DEFAULT     p   ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);
 =   ALTER TABLE public.admin_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    216    215            d           2604    59260    admin_users_roles_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);
 I   ALTER TABLE public.admin_users_roles_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    218    217            e           2604    59261    components_a_external_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_external_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_external_videos_id_seq'::regclass);
 N   ALTER TABLE public.components_a_external_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    220    219            f           2604    59262    components_a_pagebreakers id    DEFAULT     �   ALTER TABLE ONLY public.components_a_pagebreakers ALTER COLUMN id SET DEFAULT nextval('public.components_a_pagebreakers_id_seq'::regclass);
 K   ALTER TABLE public.components_a_pagebreakers ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    222    221            g           2604    59263    components_a_quizzes id    DEFAULT     �   ALTER TABLE ONLY public.components_a_quizzes ALTER COLUMN id SET DEFAULT nextval('public.components_a_quizzes_id_seq'::regclass);
 F   ALTER TABLE public.components_a_quizzes ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    224    223            h           2604    59264    components_a_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    226    225            i           2604    59265 (   components_a_sent_refs_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_sentence_links_id_seq'::regclass);
 W   ALTER TABLE public.components_a_sent_refs_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    228    227            j           2604    59266    components_a_taglists id    DEFAULT     �   ALTER TABLE ONLY public.components_a_taglists ALTER COLUMN id SET DEFAULT nextval('public.components_a_taglists_id_seq'::regclass);
 G   ALTER TABLE public.components_a_taglists ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    230    229            k           2604    59267    components_a_user_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    232    231            l           2604    59268 2   components_a_user_sent_refs_user_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_user_sentence_links_id_seq'::regclass);
 a   ALTER TABLE public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    234    233            m           2604    59269    components_a_user_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    236    235            n           2604    59270 .   components_a_user_word_refs_user_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_user_word_links_id_seq'::regclass);
 ]   ALTER TABLE public.components_a_user_word_refs_user_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    238    237            o           2604    59271    components_a_verb_metas id    DEFAULT     �   ALTER TABLE ONLY public.components_a_verb_metas ALTER COLUMN id SET DEFAULT nextval('public.components_a_verb_metas_id_seq'::regclass);
 I   ALTER TABLE public.components_a_verb_metas ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    240    239            p           2604    59272    components_a_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_videos_id_seq'::regclass);
 E   ALTER TABLE public.components_a_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    242    241            q           2604    59273    components_a_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    244    243            r           2604    59274 $   components_a_word_refs_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_word_links_id_seq'::regclass);
 S   ALTER TABLE public.components_a_word_refs_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    246    245            s           2604    59275    files id    DEFAULT     d   ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
 7   ALTER TABLE public.files ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    250    247            t           2604    59276    files_folder_links id    DEFAULT     ~   ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);
 D   ALTER TABLE public.files_folder_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    249    248            u           2604    59277    files_related_morphs id    DEFAULT     �   ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);
 F   ALTER TABLE public.files_related_morphs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    252    251            v           2604    59278    flashcards id    DEFAULT     n   ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);
 <   ALTER TABLE public.flashcards ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    256    253            w           2604    59279    flashcards_components id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_components ALTER COLUMN id SET DEFAULT nextval('public.flashcards_components_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    255    254            x           2604    59280    flashcards_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.flashcards_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    258    257            y           2604    59281 !   flashcards_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.flashcards_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    260    259            z           2604    59282    flashcards_user_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_user_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_user_links_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    262    261            {           2604    59283    i18n_locale id    DEFAULT     p   ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);
 =   ALTER TABLE public.i18n_locale ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    264    263            |           2604    59284    lessonlevels id    DEFAULT     r   ALTER TABLE ONLY public.lessonlevels ALTER COLUMN id SET DEFAULT nextval('public.lessonlevels_id_seq'::regclass);
 >   ALTER TABLE public.lessonlevels ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    266    265            }           2604    59285 
   lessons id    DEFAULT     h   ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);
 9   ALTER TABLE public.lessons ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    270    267            ~           2604    59286    lessons_components id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_components ALTER COLUMN id SET DEFAULT nextval('public.lessons_components_id_seq'::regclass);
 D   ALTER TABLE public.lessons_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    269    268                       2604    59287    lessons_lessonlevel_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_lessonlevel_links_id_seq'::regclass);
 K   ALTER TABLE public.lessons_lessonlevel_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    272    271            �           2604    59288    lessons_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_localizations_links_id_seq'::regclass);
 M   ALTER TABLE public.lessons_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    274    273            �           2604    59289    lessons_unit_links id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_unit_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_unit_links_id_seq'::regclass);
 D   ALTER TABLE public.lessons_unit_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    276    275            �           2604    60330    review_tires id    DEFAULT     r   ALTER TABLE ONLY public.review_tires ALTER COLUMN id SET DEFAULT nextval('public.review_tires_id_seq'::regclass);
 >   ALTER TABLE public.review_tires ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    355    356    356            �           2604    60341 #   review_tires_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.review_tires_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.review_tires_localizations_links_id_seq'::regclass);
 R   ALTER TABLE public.review_tires_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    358    357    358            �           2604    59290    reviewlogs id    DEFAULT     n   ALTER TABLE ONLY public.reviewlogs ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_id_seq'::regclass);
 <   ALTER TABLE public.reviewlogs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    278    277            �           2604    60399    reviewlogs_flashcard_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_flashcard_links_id_seq'::regclass);
 L   ALTER TABLE public.reviewlogs_flashcard_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    359    360    360            �           2604    59291    reviewlogs_user_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_user_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_user_links_id_seq'::regclass);
 G   ALTER TABLE public.reviewlogs_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    280    279            �           2604    59292    sections id    DEFAULT     j   ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);
 :   ALTER TABLE public.sections ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    284    281            �           2604    59293    sections_components id    DEFAULT     �   ALTER TABLE ONLY public.sections_components ALTER COLUMN id SET DEFAULT nextval('public.sections_components_id_seq'::regclass);
 E   ALTER TABLE public.sections_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    283    282            �           2604    59294    sections_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.sections_lesson_links_id_seq'::regclass);
 G   ALTER TABLE public.sections_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    286    285            �           2604    59295    sections_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sections_localizations_links_id_seq'::regclass);
 N   ALTER TABLE public.sections_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    288    287            �           2604    59296    sentences id    DEFAULT     l   ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);
 ;   ALTER TABLE public.sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    292    289            �           2604    59297    sentences_components id    DEFAULT     �   ALTER TABLE ONLY public.sentences_components ALTER COLUMN id SET DEFAULT nextval('public.sentences_components_id_seq'::regclass);
 F   ALTER TABLE public.sentences_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    291    290            �           2604    59298     sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sentences_localizations_links_id_seq'::regclass);
 O   ALTER TABLE public.sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    294    293            �           2604    59299    strapi_api_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);
 N   ALTER TABLE public.strapi_api_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    296    295            �           2604    59300 +   strapi_api_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);
 Z   ALTER TABLE public.strapi_api_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    298    297            �           2604    59301    strapi_api_tokens id    DEFAULT     |   ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);
 C   ALTER TABLE public.strapi_api_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    300    299            �           2604    59302    strapi_core_store_settings id    DEFAULT     �   ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);
 L   ALTER TABLE public.strapi_core_store_settings ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    302    301            �           2604    59303    strapi_database_schema id    DEFAULT     �   ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);
 H   ALTER TABLE public.strapi_database_schema ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    304    303            �           2604    59304    strapi_migrations id    DEFAULT     |   ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);
 C   ALTER TABLE public.strapi_migrations ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    306    305            �           2604    59305 $   strapi_transfer_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);
 S   ALTER TABLE public.strapi_transfer_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    308    307            �           2604    59306 0   strapi_transfer_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);
 _   ALTER TABLE public.strapi_transfer_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    310    309            �           2604    59307    strapi_transfer_tokens id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);
 H   ALTER TABLE public.strapi_transfer_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    312    311            �           2604    59308    strapi_webhooks id    DEFAULT     x   ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);
 A   ALTER TABLE public.strapi_webhooks ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    314    313            �           2604    59309    units id    DEFAULT     d   ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);
 7   ALTER TABLE public.units ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    316    315            �           2604    59310    units_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.units_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.units_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.units_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    318    317            �           2604    59311    units_precondition_links id    DEFAULT     �   ALTER TABLE ONLY public.units_precondition_links ALTER COLUMN id SET DEFAULT nextval('public.units_precondition_links_id_seq'::regclass);
 J   ALTER TABLE public.units_precondition_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    320    319            �           2604    59312    up_permissions id    DEFAULT     v   ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);
 @   ALTER TABLE public.up_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    322    321            �           2604    59313    up_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);
 K   ALTER TABLE public.up_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    324    323            �           2604    59314    up_roles id    DEFAULT     j   ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);
 :   ALTER TABLE public.up_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    326    325            �           2604    59315    up_users id    DEFAULT     j   ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);
 :   ALTER TABLE public.up_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    328    327            �           2604    59316    up_users_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);
 E   ALTER TABLE public.up_users_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    330    329            �           2604    59317    upload_folders id    DEFAULT     v   ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);
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
       public          strapi    false    366    365    366            �           2604    63667    vocabooks id    DEFAULT     l   ALTER TABLE ONLY public.vocabooks ALTER COLUMN id SET DEFAULT nextval('public.vocabooks_id_seq'::regclass);
 ;   ALTER TABLE public.vocabooks ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    370    369    370            �           2604    63689     vocabooks_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.vocabooks_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.vocabooks_localizations_links_id_seq'::regclass);
 O   ALTER TABLE public.vocabooks_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    374    373    374            �           2604    63678    vocabooks_user_links id    DEFAULT     �   ALTER TABLE ONLY public.vocabooks_user_links ALTER COLUMN id SET DEFAULT nextval('public.vocabooks_user_links_id_seq'::regclass);
 F   ALTER TABLE public.vocabooks_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    372    371    372            �           2604    63743    vocapages id    DEFAULT     l   ALTER TABLE ONLY public.vocapages ALTER COLUMN id SET DEFAULT nextval('public.vocapages_id_seq'::regclass);
 ;   ALTER TABLE public.vocapages ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    376    375    376            �           2604    63796    vocapages_components id    DEFAULT     �   ALTER TABLE ONLY public.vocapages_components ALTER COLUMN id SET DEFAULT nextval('public.vocapages_components_id_seq'::regclass);
 F   ALTER TABLE public.vocapages_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    380    379    380            �           2604    63752    vocapages_vocabook_links id    DEFAULT     �   ALTER TABLE ONLY public.vocapages_vocabook_links ALTER COLUMN id SET DEFAULT nextval('public.vocapages_vocabook_links_id_seq'::regclass);
 J   ALTER TABLE public.vocapages_vocabook_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    377    378    378            �           2604    59327    words id    DEFAULT     d   ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);
 7   ALTER TABLE public.words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    352    347            �           2604    59328    words_components id    DEFAULT     z   ALTER TABLE ONLY public.words_components ALTER COLUMN id SET DEFAULT nextval('public.words_components_id_seq'::regclass);
 B   ALTER TABLE public.words_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    349    348            �           2604    59329     words_example_sentences_links id    DEFAULT     �   ALTER TABLE ONLY public.words_example_sentences_links ALTER COLUMN id SET DEFAULT nextval('public.words_example_sentences_links_id_seq'::regclass);
 O   ALTER TABLE public.words_example_sentences_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    351    350            �           2604    59330    words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.words_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    354    353            �          0    58893    admin_permissions 
   TABLE DATA           �   COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    209   -:      �          0    58899    admin_permissions_role_links 
   TABLE DATA           d   COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    211   �D      �          0    58903    admin_roles 
   TABLE DATA           x   COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    213   �G      �          0    58909    admin_users 
   TABLE DATA           �   COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    215   �H      �          0    58915    admin_users_roles_links 
   TABLE DATA           _   COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
    public          strapi    false    217   eI      �          0    58919    components_a_external_videos 
   TABLE DATA           H   COPY public.components_a_external_videos (id, url, caption) FROM stdin;
    public          strapi    false    219   �I      �          0    58925    components_a_pagebreakers 
   TABLE DATA           O   COPY public.components_a_pagebreakers (id, backbutton, nextbutton) FROM stdin;
    public          strapi    false    221   �I      �          0    58929    components_a_quizzes 
   TABLE DATA           Z   COPY public.components_a_quizzes (id, question, options, answer, explanation) FROM stdin;
    public          strapi    false    223   �I      �          0    58935    components_a_sent_refs 
   TABLE DATA           4   COPY public.components_a_sent_refs (id) FROM stdin;
    public          strapi    false    225   �I      �          0    58939 %   components_a_sent_refs_sentence_links 
   TABLE DATA           ]   COPY public.components_a_sent_refs_sentence_links (id, sent_ref_id, sentence_id) FROM stdin;
    public          strapi    false    227   �I      �          0    58943    components_a_taglists 
   TABLE DATA           8   COPY public.components_a_taglists (id, tag) FROM stdin;
    public          strapi    false    229    J      �          0    58947    components_a_user_sent_refs 
   TABLE DATA           9   COPY public.components_a_user_sent_refs (id) FROM stdin;
    public          strapi    false    231   IJ      �          0    58951 /   components_a_user_sent_refs_user_sentence_links 
   TABLE DATA           q   COPY public.components_a_user_sent_refs_user_sentence_links (id, user_sent_ref_id, user_sentence_id) FROM stdin;
    public          strapi    false    233   hJ      �          0    58955    components_a_user_word_refs 
   TABLE DATA           9   COPY public.components_a_user_word_refs (id) FROM stdin;
    public          strapi    false    235   �J      �          0    58959 +   components_a_user_word_refs_user_word_links 
   TABLE DATA           i   COPY public.components_a_user_word_refs_user_word_links (id, user_word_ref_id, user_word_id) FROM stdin;
    public          strapi    false    237   �J      �          0    58963    components_a_verb_metas 
   TABLE DATA           �   COPY public.components_a_verb_metas (id, simple_past, past_participle, present_participle, thirdperson_singular, auxiliary_verb, conjugations) FROM stdin;
    public          strapi    false    239   �K      �          0    58969    components_a_videos 
   TABLE DATA           1   COPY public.components_a_videos (id) FROM stdin;
    public          strapi    false    241   �K      �          0    58973    components_a_word_refs 
   TABLE DATA           4   COPY public.components_a_word_refs (id) FROM stdin;
    public          strapi    false    243   �K      �          0    58977 !   components_a_word_refs_word_links 
   TABLE DATA           U   COPY public.components_a_word_refs_word_links (id, word_ref_id, word_id) FROM stdin;
    public          strapi    false    245   L      �          0    58981    files 
   TABLE DATA           �   COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    247   ?L      �          0    58986    files_folder_links 
   TABLE DATA           P   COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
    public          strapi    false    248   \L      �          0    58991    files_related_morphs 
   TABLE DATA           e   COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
    public          strapi    false    251   yL      �          0    58997 
   flashcards 
   TABLE DATA           �   COPY public.flashcards (id, created_at, updated_at, created_by_id, updated_by_id, locale, last_reviewed_at, is_remembered, correct_streak, wrong_streak) FROM stdin;
    public          strapi    false    253   �L      �          0    59001    flashcards_components 
   TABLE DATA           l   COPY public.flashcards_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    254   �O      �          0    59008    flashcards_lesson_links 
   TABLE DATA           _   COPY public.flashcards_lesson_links (id, flashcard_id, lesson_id, flashcard_order) FROM stdin;
    public          strapi    false    257   �P      �          0    59012    flashcards_localizations_links 
   TABLE DATA           m   COPY public.flashcards_localizations_links (id, flashcard_id, inv_flashcard_id, flashcard_order) FROM stdin;
    public          strapi    false    259   �P      �          0    59016    flashcards_user_links 
   TABLE DATA           [   COPY public.flashcards_user_links (id, flashcard_id, user_id, flashcard_order) FROM stdin;
    public          strapi    false    261   Q      �          0    59020    i18n_locale 
   TABLE DATA           k   COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    263   �Q      �          0    59026    lessonlevels 
   TABLE DATA           t   COPY public.lessonlevels (id, level, created_at, updated_at, created_by_id, updated_by_id, description) FROM stdin;
    public          strapi    false    265   )R      �          0    59032    lessons 
   TABLE DATA           �   COPY public.lessons (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    267   FR      �          0    59037    lessons_components 
   TABLE DATA           i   COPY public.lessons_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    268   �R      �          0    59044    lessons_lessonlevel_links 
   TABLE DATA           `   COPY public.lessons_lessonlevel_links (id, lesson_id, lessonlevel_id, lesson_order) FROM stdin;
    public          strapi    false    271   �R      �          0    59048    lessons_localizations_links 
   TABLE DATA           a   COPY public.lessons_localizations_links (id, lesson_id, inv_lesson_id, lesson_order) FROM stdin;
    public          strapi    false    273   �R      �          0    59052    lessons_unit_links 
   TABLE DATA           R   COPY public.lessons_unit_links (id, lesson_id, unit_id, lesson_order) FROM stdin;
    public          strapi    false    275   �R      '          0    60327    review_tires 
   TABLE DATA           �   COPY public.review_tires (id, tier, min_streak, max_streak, cooldown_hours, demote_bar, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    356   S      )          0    60338     review_tires_localizations_links 
   TABLE DATA           u   COPY public.review_tires_localizations_links (id, review_tire_id, inv_review_tire_id, review_tire_order) FROM stdin;
    public          strapi    false    358   �S      �          0    59056 
   reviewlogs 
   TABLE DATA           z   COPY public.reviewlogs (id, level, result, created_at, updated_at, created_by_id, updated_by_id, reviewed_at) FROM stdin;
    public          strapi    false    277   �S      +          0    60396    reviewlogs_flashcard_links 
   TABLE DATA           e   COPY public.reviewlogs_flashcard_links (id, reviewlog_id, flashcard_id, reviewlog_order) FROM stdin;
    public          strapi    false    360   Z[      �          0    59062    reviewlogs_user_links 
   TABLE DATA           [   COPY public.reviewlogs_user_links (id, reviewlog_id, user_id, reviewlog_order) FROM stdin;
    public          strapi    false    279   z]      �          0    59066    sections 
   TABLE DATA           t   COPY public.sections (id, title, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    281   Q`      �          0    59071    sections_components 
   TABLE DATA           j   COPY public.sections_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    282   �`      �          0    59078    sections_lesson_links 
   TABLE DATA           Y   COPY public.sections_lesson_links (id, section_id, lesson_id, section_order) FROM stdin;
    public          strapi    false    285   a      �          0    59082    sections_localizations_links 
   TABLE DATA           e   COPY public.sections_localizations_links (id, section_id, inv_section_id, section_order) FROM stdin;
    public          strapi    false    287   Na      �          0    59086 	   sentences 
   TABLE DATA           �   COPY public.sentences (id, title, instruction, base_text, target_text, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    289   ka      �          0    59091    sentences_components 
   TABLE DATA           k   COPY public.sentences_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    290   ,b      �          0    59098    sentences_localizations_links 
   TABLE DATA           i   COPY public.sentences_localizations_links (id, sentence_id, inv_sentence_id, sentence_order) FROM stdin;
    public          strapi    false    293   Ib      �          0    59102    strapi_api_token_permissions 
   TABLE DATA           x   COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    295   fb      �          0    59106 (   strapi_api_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
    public          strapi    false    297   �b      �          0    59110    strapi_api_tokens 
   TABLE DATA           �   COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    299   �b      �          0    59116    strapi_core_store_settings 
   TABLE DATA           \   COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
    public          strapi    false    301   �b      �          0    59122    strapi_database_schema 
   TABLE DATA           J   COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
    public          strapi    false    303   �      �          0    59128    strapi_migrations 
   TABLE DATA           =   COPY public.strapi_migrations (id, name, "time") FROM stdin;
    public          strapi    false    305   ;�      �          0    59132 !   strapi_transfer_token_permissions 
   TABLE DATA           }   COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    307   X�      �          0    59136 -   strapi_transfer_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
    public          strapi    false    309   u�      �          0    59140    strapi_transfer_tokens 
   TABLE DATA           �   COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    311   ��      �          0    59146    strapi_webhooks 
   TABLE DATA           R   COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
    public          strapi    false    313   ��      �          0    59152    units 
   TABLE DATA           �   COPY public.units (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    315   ̞                 0    59158    units_localizations_links 
   TABLE DATA           Y   COPY public.units_localizations_links (id, unit_id, inv_unit_id, unit_order) FROM stdin;
    public          strapi    false    317   ^�                0    59162    units_precondition_links 
   TABLE DATA           L   COPY public.units_precondition_links (id, unit_id, inv_unit_id) FROM stdin;
    public          strapi    false    319   {�                0    59166    up_permissions 
   TABLE DATA           j   COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    321   ��                0    59170    up_permissions_role_links 
   TABLE DATA           a   COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    323   ��                0    59174    up_roles 
   TABLE DATA           u   COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    325   ��      
          0    59180    up_users 
   TABLE DATA           �   COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    327   K�                0    59186    up_users_role_links 
   TABLE DATA           O   COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
    public          strapi    false    329   ]�                0    59190    upload_folders 
   TABLE DATA           w   COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    331   ��                0    59196    upload_folders_parent_links 
   TABLE DATA           a   COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
    public          strapi    false    333   ��      -          0    60467    user_profiles 
   TABLE DATA           {   COPY public.user_profiles (id, telephone, base_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    362   ¦      /          0    60478    user_profiles_user_links 
   TABLE DATA           P   COPY public.user_profiles_user_links (id, user_profile_id, user_id) FROM stdin;
    public          strapi    false    364   X�                0    59200    user_sentences 
   TABLE DATA           �   COPY public.user_sentences (id, target_text, base_text, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    335   ��                0    59206    user_sentences_lesson_links 
   TABLE DATA           k   COPY public.user_sentences_lesson_links (id, user_sentence_id, lesson_id, user_sentence_order) FROM stdin;
    public          strapi    false    337   �                0    59210 "   user_sentences_localizations_links 
   TABLE DATA           }   COPY public.user_sentences_localizations_links (id, user_sentence_id, inv_user_sentence_id, user_sentence_order) FROM stdin;
    public          strapi    false    339   #�      3          0    60635    user_sentences_user_links 
   TABLE DATA           g   COPY public.user_sentences_user_links (id, user_sentence_id, user_id, user_sentence_order) FROM stdin;
    public          strapi    false    368   @�                0    59218 
   user_words 
   TABLE DATA           �   COPY public.user_words (id, base_text, part_of_speech, created_at, updated_at, created_by_id, updated_by_id, locale, target_text) FROM stdin;
    public          strapi    false    341   ]�                0    59224    user_words_lesson_links 
   TABLE DATA           _   COPY public.user_words_lesson_links (id, user_word_id, lesson_id, user_word_order) FROM stdin;
    public          strapi    false    343   ?�                0    59228    user_words_localizations_links 
   TABLE DATA           m   COPY public.user_words_localizations_links (id, user_word_id, inv_user_word_id, user_word_order) FROM stdin;
    public          strapi    false    345   a�      1          0    60600    user_words_user_links 
   TABLE DATA           [   COPY public.user_words_user_links (id, user_word_id, user_id, user_word_order) FROM stdin;
    public          strapi    false    366   ~�      5          0    63664 	   vocabooks 
   TABLE DATA           l   COPY public.vocabooks (id, title, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    370   >�      9          0    63686    vocabooks_localizations_links 
   TABLE DATA           i   COPY public.vocabooks_localizations_links (id, vocabook_id, inv_vocabook_id, vocabook_order) FROM stdin;
    public          strapi    false    374   [�      7          0    63675    vocabooks_user_links 
   TABLE DATA           H   COPY public.vocabooks_user_links (id, vocabook_id, user_id) FROM stdin;
    public          strapi    false    372   x�      ;          0    63740 	   vocapages 
   TABLE DATA           m   COPY public.vocapages (id, title, "order", created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    376   ��      ?          0    63793    vocapages_components 
   TABLE DATA           k   COPY public.vocapages_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    380   ٮ      =          0    63749    vocapages_vocabook_links 
   TABLE DATA           `   COPY public.vocapages_vocabook_links (id, vocapage_id, vocabook_id, vocapage_order) FROM stdin;
    public          strapi    false    378   "�                0    59236    words 
   TABLE DATA           �   COPY public.words (id, word, base_text, instruction, part_of_speech, gender, article, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    347   ?�                0    59241    words_components 
   TABLE DATA           g   COPY public.words_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    348   3�      !          0    59247    words_example_sentences_links 
   TABLE DATA           m   COPY public.words_example_sentences_links (id, word_id, sentence_id, sentence_order, word_order) FROM stdin;
    public          strapi    false    350   ��      $          0    59252    words_localizations_links 
   TABLE DATA           Y   COPY public.words_localizations_links (id, word_id, inv_word_id, word_order) FROM stdin;
    public          strapi    false    353   ��      �           0    0    admin_permissions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.admin_permissions_id_seq', 289, true);
          public          strapi    false    210            �           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 289, true);
          public          strapi    false    212            �           0    0    admin_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);
          public          strapi    false    214            �           0    0    admin_users_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);
          public          strapi    false    216            �           0    0    admin_users_roles_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);
          public          strapi    false    218            �           0    0 #   components_a_external_videos_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.components_a_external_videos_id_seq', 1, false);
          public          strapi    false    220            �           0    0     components_a_pagebreakers_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.components_a_pagebreakers_id_seq', 1, false);
          public          strapi    false    222            �           0    0    components_a_quizzes_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_quizzes_id_seq', 1, false);
          public          strapi    false    224            �           0    0    components_a_sent_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_sent_refs_id_seq', 1, true);
          public          strapi    false    226            �           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.components_a_sent_refs_sentence_links_id_seq', 1, true);
          public          strapi    false    228            �           0    0    components_a_taglists_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_taglists_id_seq', 2, true);
          public          strapi    false    230            �           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.components_a_user_sent_refs_id_seq', 1, true);
          public          strapi    false    232            �           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('public.components_a_user_sent_refs_user_sentence_links_id_seq', 1, true);
          public          strapi    false    234            �           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.components_a_user_word_refs_id_seq', 35, true);
          public          strapi    false    236            �           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.components_a_user_word_refs_user_word_links_id_seq', 35, true);
          public          strapi    false    238            �           0    0    components_a_verb_metas_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.components_a_verb_metas_id_seq', 1, true);
          public          strapi    false    240            �           0    0    components_a_videos_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.components_a_videos_id_seq', 1, false);
          public          strapi    false    242            �           0    0    components_a_word_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_word_refs_id_seq', 4, true);
          public          strapi    false    244            �           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.components_a_word_refs_word_links_id_seq', 4, true);
          public          strapi    false    246            �           0    0    files_folder_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);
          public          strapi    false    249            �           0    0    files_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.files_id_seq', 1, false);
          public          strapi    false    250            �           0    0    files_related_morphs_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);
          public          strapi    false    252            �           0    0    flashcards_components_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.flashcards_components_id_seq', 81, true);
          public          strapi    false    255            �           0    0    flashcards_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.flashcards_id_seq', 37, true);
          public          strapi    false    256            �           0    0    flashcards_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.flashcards_lesson_links_id_seq', 1, true);
          public          strapi    false    258            �           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.flashcards_localizations_links_id_seq', 1, false);
          public          strapi    false    260            �           0    0    flashcards_user_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.flashcards_user_links_id_seq', 38, true);
          public          strapi    false    262            �           0    0    i18n_locale_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);
          public          strapi    false    264            �           0    0    lessonlevels_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.lessonlevels_id_seq', 1, false);
          public          strapi    false    266            �           0    0    lessons_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_components_id_seq', 1, false);
          public          strapi    false    269            �           0    0    lessons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.lessons_id_seq', 1, true);
          public          strapi    false    270            �           0    0     lessons_lessonlevel_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.lessons_lessonlevel_links_id_seq', 1, false);
          public          strapi    false    272            �           0    0 "   lessons_localizations_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.lessons_localizations_links_id_seq', 1, false);
          public          strapi    false    274            �           0    0    lessons_unit_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_unit_links_id_seq', 1, false);
          public          strapi    false    276            �           0    0    review_tires_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.review_tires_id_seq', 5, true);
          public          strapi    false    355            �           0    0 '   review_tires_localizations_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.review_tires_localizations_links_id_seq', 1, false);
          public          strapi    false    357            �           0    0 !   reviewlogs_flashcard_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.reviewlogs_flashcard_links_id_seq', 104, true);
          public          strapi    false    359            �           0    0    reviewlogs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.reviewlogs_id_seq', 131, true);
          public          strapi    false    278            �           0    0    reviewlogs_user_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.reviewlogs_user_links_id_seq', 131, true);
          public          strapi    false    280            �           0    0    sections_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sections_components_id_seq', 2, true);
          public          strapi    false    283            �           0    0    sections_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sections_id_seq', 3, true);
          public          strapi    false    284            �           0    0    sections_lesson_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sections_lesson_links_id_seq', 3, true);
          public          strapi    false    286            �           0    0 #   sections_localizations_links_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sections_localizations_links_id_seq', 1, false);
          public          strapi    false    288            �           0    0    sentences_components_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sentences_components_id_seq', 1, false);
          public          strapi    false    291            �           0    0    sentences_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sentences_id_seq', 2, true);
          public          strapi    false    292            �           0    0 $   sentences_localizations_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    294            �           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);
          public          strapi    false    296            �           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    298            �           0    0    strapi_api_tokens_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);
          public          strapi    false    300            �           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 48, true);
          public          strapi    false    302            �           0    0    strapi_database_schema_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 56, true);
          public          strapi    false    304            �           0    0    strapi_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);
          public          strapi    false    306            �           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);
          public          strapi    false    308            �           0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    310            �           0    0    strapi_transfer_tokens_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);
          public          strapi    false    312            �           0    0    strapi_webhooks_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);
          public          strapi    false    314            �           0    0    units_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.units_id_seq', 2, true);
          public          strapi    false    316            �           0    0     units_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.units_localizations_links_id_seq', 1, false);
          public          strapi    false    318            �           0    0    units_precondition_links_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.units_precondition_links_id_seq', 2, true);
          public          strapi    false    320            �           0    0    up_permissions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.up_permissions_id_seq', 68, true);
          public          strapi    false    322            �           0    0     up_permissions_role_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 68, true);
          public          strapi    false    324            �           0    0    up_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);
          public          strapi    false    326            �           0    0    up_users_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.up_users_id_seq', 12, true);
          public          strapi    false    328            �           0    0    up_users_role_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 8, true);
          public          strapi    false    330            �           0    0    upload_folders_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);
          public          strapi    false    332            �           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);
          public          strapi    false    334            �           0    0    user_profiles_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.user_profiles_id_seq', 4, true);
          public          strapi    false    361            �           0    0    user_profiles_user_links_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.user_profiles_user_links_id_seq', 4, true);
          public          strapi    false    363            �           0    0    user_sentences_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.user_sentences_id_seq', 1, true);
          public          strapi    false    336            �           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.user_sentences_lesson_links_id_seq', 1, true);
          public          strapi    false    338            �           0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.user_sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    340            �           0    0     user_sentences_user_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.user_sentences_user_links_id_seq', 1, false);
          public          strapi    false    367            �           0    0    user_words_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.user_words_id_seq', 45, true);
          public          strapi    false    342            �           0    0    user_words_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.user_words_lesson_links_id_seq', 1, true);
          public          strapi    false    344            �           0    0 %   user_words_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.user_words_localizations_links_id_seq', 1, false);
          public          strapi    false    346            �           0    0    user_words_user_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.user_words_user_links_id_seq', 37, true);
          public          strapi    false    365            �           0    0    vocabooks_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.vocabooks_id_seq', 1, false);
          public          strapi    false    369            �           0    0 $   vocabooks_localizations_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.vocabooks_localizations_links_id_seq', 1, false);
          public          strapi    false    373            �           0    0    vocabooks_user_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.vocabooks_user_links_id_seq', 1, false);
          public          strapi    false    371            �           0    0    vocapages_components_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.vocapages_components_id_seq', 2, true);
          public          strapi    false    379            �           0    0    vocapages_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.vocapages_id_seq', 1, true);
          public          strapi    false    375            �           0    0    vocapages_vocabook_links_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.vocapages_vocabook_links_id_seq', 1, false);
          public          strapi    false    377            �           0    0    words_components_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.words_components_id_seq', 6, true);
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
       public            strapi    false    245    245                       2606    59384 *   files_folder_links files_folder_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_pkey;
       public            strapi    false    248                       2606    59386 ,   files_folder_links files_folder_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_unique;
       public            strapi    false    248    248            �           2606    59388    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            strapi    false    247                       2606    59390 .   files_related_morphs files_related_morphs_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_pkey;
       public            strapi    false    251                       2606    59392 0   flashcards_components flashcards_components_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_components_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_components_pkey;
       public            strapi    false    254            "           2606    59394 4   flashcards_lesson_links flashcards_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_pkey;
       public            strapi    false    257            $           2606    59396 6   flashcards_lesson_links flashcards_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_unique UNIQUE (flashcard_id, lesson_id);
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_unique;
       public            strapi    false    257    257            )           2606    59398 B   flashcards_localizations_links flashcards_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_pkey;
       public            strapi    false    259            +           2606    59400 D   flashcards_localizations_links flashcards_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_unique UNIQUE (flashcard_id, inv_flashcard_id);
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_unique;
       public            strapi    false    259    259                       2606    59402    flashcards flashcards_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_pkey;
       public            strapi    false    253                       2606    63812 '   flashcards_components flashcards_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_unique UNIQUE (entity_id, component_id, field, component_type);
 Q   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_unique;
       public            strapi    false    254    254    254    254            0           2606    59406 0   flashcards_user_links flashcards_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_pkey;
       public            strapi    false    261            2           2606    59408 2   flashcards_user_links flashcards_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_unique UNIQUE (flashcard_id, user_id);
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_unique;
       public            strapi    false    261    261            5           2606    59410    i18n_locale i18n_locale_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_pkey;
       public            strapi    false    263            9           2606    59412    lessonlevels lessonlevels_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_pkey;
       public            strapi    false    265            C           2606    59414 *   lessons_components lessons_components_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_components_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_components_pkey;
       public            strapi    false    268            L           2606    59416 8   lessons_lessonlevel_links lessons_lessonlevel_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_pkey;
       public            strapi    false    271            N           2606    59418 :   lessons_lessonlevel_links lessons_lessonlevel_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_unique UNIQUE (lesson_id, lessonlevel_id);
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_unique;
       public            strapi    false    271    271            S           2606    59420 <   lessons_localizations_links lessons_localizations_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_pkey;
       public            strapi    false    273            U           2606    59422 >   lessons_localizations_links lessons_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_unique UNIQUE (lesson_id, inv_lesson_id);
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_unique;
       public            strapi    false    273    273            =           2606    59424    lessons lessons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_pkey;
       public            strapi    false    267            ?           2606    59426    lessons lessons_slug_unique 
   CONSTRAINT     V   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_unique UNIQUE (slug);
 E   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_slug_unique;
       public            strapi    false    267            G           2606    63814 !   lessons_components lessons_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_unique UNIQUE (entity_id, component_id, field, component_type);
 K   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_unique;
       public            strapi    false    268    268    268    268            Z           2606    59430 *   lessons_unit_links lessons_unit_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_pkey;
       public            strapi    false    275            \           2606    59432 ,   lessons_unit_links lessons_unit_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_unique UNIQUE (lesson_id, unit_id);
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_unique;
       public            strapi    false    275    275            ;           2606    60343 F   review_tires_localizations_links review_tires_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_pkey PRIMARY KEY (id);
 p   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_pkey;
       public            strapi    false    358            =           2606    60347 H   review_tires_localizations_links review_tires_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_unique UNIQUE (review_tire_id, inv_review_tire_id);
 r   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_unique;
       public            strapi    false    358    358            5           2606    60334    review_tires review_tires_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_pkey;
       public            strapi    false    356            B           2606    60401 :   reviewlogs_flashcard_links reviewlogs_flashcard_links_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_pkey;
       public            strapi    false    360            D           2606    60405 <   reviewlogs_flashcard_links reviewlogs_flashcard_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_unique UNIQUE (reviewlog_id, flashcard_id);
 f   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_unique;
       public            strapi    false    360    360            _           2606    59434    reviewlogs reviewlogs_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_pkey;
       public            strapi    false    277            e           2606    59436 0   reviewlogs_user_links reviewlogs_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_pkey;
       public            strapi    false    279            g           2606    59438 2   reviewlogs_user_links reviewlogs_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_unique UNIQUE (reviewlog_id, user_id);
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_unique;
       public            strapi    false    279    279            n           2606    59440 ,   sections_components sections_components_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_components_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_components_pkey;
       public            strapi    false    282            w           2606    59442 0   sections_lesson_links sections_lesson_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_pkey;
       public            strapi    false    285            y           2606    59444 2   sections_lesson_links sections_lesson_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_unique UNIQUE (section_id, lesson_id);
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_unique;
       public            strapi    false    285    285            ~           2606    59446 >   sections_localizations_links sections_localizations_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_pkey;
       public            strapi    false    287            �           2606    59448 @   sections_localizations_links sections_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_unique UNIQUE (section_id, inv_section_id);
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_unique;
       public            strapi    false    287    287            j           2606    59450    sections sections_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_pkey;
       public            strapi    false    281            r           2606    63816 #   sections_components sections_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_unique UNIQUE (entity_id, component_id, field, component_type);
 M   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_unique;
       public            strapi    false    282    282    282    282            �           2606    59454 .   sentences_components sentences_components_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_components_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_components_pkey;
       public            strapi    false    290            �           2606    59456 @   sentences_localizations_links sentences_localizations_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_pkey;
       public            strapi    false    293            �           2606    59458 B   sentences_localizations_links sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_unique UNIQUE (sentence_id, inv_sentence_id);
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_unique;
       public            strapi    false    293    293            �           2606    59460    sentences sentences_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_pkey;
       public            strapi    false    289            �           2606    63818 %   sentences_components sentences_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_unique UNIQUE (entity_id, component_id, field, component_type);
 O   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_unique;
       public            strapi    false    290    290    290    290            �           2606    59464 >   strapi_api_token_permissions strapi_api_token_permissions_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_pkey;
       public            strapi    false    295            �           2606    59466 V   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_pkey;
       public            strapi    false    297            �           2606    59468 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_unique;
       public            strapi    false    297    297            �           2606    59470 (   strapi_api_tokens strapi_api_tokens_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_pkey;
       public            strapi    false    299            �           2606    59472 :   strapi_core_store_settings strapi_core_store_settings_pkey 
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
       public            strapi    false    331            G           2606    60474     user_profiles user_profiles_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.user_profiles DROP CONSTRAINT user_profiles_pkey;
       public            strapi    false    362            L           2606    60483 6   user_profiles_user_links user_profiles_user_links_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_pkey;
       public            strapi    false    364            N           2606    60487 8   user_profiles_user_links user_profiles_user_links_unique 
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
       public            strapi    false    337    337                       2606    59528 J   user_sentences_localizations_links user_sentences_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_pkey;
       public            strapi    false    339                       2606    59530 L   user_sentences_localizations_links user_sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_unique UNIQUE (user_sentence_id, inv_user_sentence_id);
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_unique;
       public            strapi    false    339    339            �           2606    59532 "   user_sentences user_sentences_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_pkey;
       public            strapi    false    335            Z           2606    60640 8   user_sentences_user_links user_sentences_user_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_pkey;
       public            strapi    false    368            \           2606    60644 :   user_sentences_user_links user_sentences_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_unique UNIQUE (user_sentence_id, user_id);
 d   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_unique;
       public            strapi    false    368    368                       2606    59538 4   user_words_lesson_links user_words_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_pkey;
       public            strapi    false    343                       2606    59540 6   user_words_lesson_links user_words_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_unique UNIQUE (user_word_id, lesson_id);
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_unique;
       public            strapi    false    343    343                       2606    59542 B   user_words_localizations_links user_words_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_pkey;
       public            strapi    false    345                       2606    59544 D   user_words_localizations_links user_words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_unique UNIQUE (user_word_id, inv_user_word_id);
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_unique;
       public            strapi    false    345    345            	           2606    59546    user_words user_words_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_pkey;
       public            strapi    false    341            S           2606    60605 0   user_words_user_links user_words_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_pkey;
       public            strapi    false    366            U           2606    60609 2   user_words_user_links user_words_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_unique UNIQUE (user_word_id, user_id);
 \   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_unique;
       public            strapi    false    366    366            k           2606    63691 @   vocabooks_localizations_links vocabooks_localizations_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.vocabooks_localizations_links
    ADD CONSTRAINT vocabooks_localizations_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.vocabooks_localizations_links DROP CONSTRAINT vocabooks_localizations_links_pkey;
       public            strapi    false    374            m           2606    63695 B   vocabooks_localizations_links vocabooks_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks_localizations_links
    ADD CONSTRAINT vocabooks_localizations_links_unique UNIQUE (vocabook_id, inv_vocabook_id);
 l   ALTER TABLE ONLY public.vocabooks_localizations_links DROP CONSTRAINT vocabooks_localizations_links_unique;
       public            strapi    false    374    374            _           2606    63671    vocabooks vocabooks_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.vocabooks
    ADD CONSTRAINT vocabooks_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.vocabooks DROP CONSTRAINT vocabooks_pkey;
       public            strapi    false    370            d           2606    63680 .   vocabooks_user_links vocabooks_user_links_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.vocabooks_user_links DROP CONSTRAINT vocabooks_user_links_pkey;
       public            strapi    false    372            f           2606    63684 0   vocabooks_user_links vocabooks_user_links_unique 
   CONSTRAINT     {   ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_unique UNIQUE (vocabook_id, user_id);
 Z   ALTER TABLE ONLY public.vocabooks_user_links DROP CONSTRAINT vocabooks_user_links_unique;
       public            strapi    false    372    372            {           2606    63800 .   vocapages_components vocapages_components_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.vocapages_components
    ADD CONSTRAINT vocapages_components_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.vocapages_components DROP CONSTRAINT vocapages_components_pkey;
       public            strapi    false    380            p           2606    63745    vocapages vocapages_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.vocapages
    ADD CONSTRAINT vocapages_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.vocapages DROP CONSTRAINT vocapages_pkey;
       public            strapi    false    376                       2606    63805 %   vocapages_components vocapages_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.vocapages_components
    ADD CONSTRAINT vocapages_unique UNIQUE (entity_id, component_id, field, component_type);
 O   ALTER TABLE ONLY public.vocapages_components DROP CONSTRAINT vocapages_unique;
       public            strapi    false    380    380    380    380            v           2606    63754 6   vocapages_vocabook_links vocapages_vocabook_links_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.vocapages_vocabook_links DROP CONSTRAINT vocapages_vocabook_links_pkey;
       public            strapi    false    378            x           2606    63758 8   vocapages_vocabook_links vocapages_vocabook_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_unique UNIQUE (vocapage_id, vocabook_id);
 b   ALTER TABLE ONLY public.vocapages_vocabook_links DROP CONSTRAINT vocapages_vocabook_links_unique;
       public            strapi    false    378    378                       2606    59552 &   words_components words_components_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_components_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_components_pkey;
       public            strapi    false    348            )           2606    59554 @   words_example_sentences_links words_example_sentences_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_pkey;
       public            strapi    false    350            +           2606    59556 B   words_example_sentences_links words_example_sentences_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_unique UNIQUE (word_id, sentence_id);
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_unique;
       public            strapi    false    350    350            0           2606    59558 8   words_localizations_links words_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_pkey;
       public            strapi    false    353            2           2606    59560 :   words_localizations_links words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_unique UNIQUE (word_id, inv_word_id);
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_unique;
       public            strapi    false    353    353                       2606    59562    words words_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.words DROP CONSTRAINT words_pkey;
       public            strapi    false    347            #           2606    63820    words_components words_unique 
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
       public            strapi    false    247                       1259    59587    files_folder_links_fk    INDEX     W   CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);
 )   DROP INDEX public.files_folder_links_fk;
       public            strapi    false    248                       1259    59588    files_folder_links_inv_fk    INDEX     ]   CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);
 -   DROP INDEX public.files_folder_links_inv_fk;
       public            strapi    false    248            	           1259    59589    files_folder_links_order_inv_fk    INDEX     d   CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);
 3   DROP INDEX public.files_folder_links_order_inv_fk;
       public            strapi    false    248                       1259    59590    files_related_morphs_fk    INDEX     [   CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);
 +   DROP INDEX public.files_related_morphs_fk;
       public            strapi    false    251                       1259    59591 $   files_related_morphs_id_column_index    INDEX     k   CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);
 8   DROP INDEX public.files_related_morphs_id_column_index;
       public            strapi    false    251                       1259    59592     files_related_morphs_order_index    INDEX     d   CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");
 4   DROP INDEX public.files_related_morphs_order_index;
       public            strapi    false    251                        1259    59593    files_updated_by_id_fk    INDEX     Q   CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);
 *   DROP INDEX public.files_updated_by_id_fk;
       public            strapi    false    247                       1259    59594    flashcards_component_type_index    INDEX     k   CREATE INDEX flashcards_component_type_index ON public.flashcards_components USING btree (component_type);
 3   DROP INDEX public.flashcards_component_type_index;
       public            strapi    false    254                       1259    59595    flashcards_created_by_id_fk    INDEX     [   CREATE INDEX flashcards_created_by_id_fk ON public.flashcards USING btree (created_by_id);
 /   DROP INDEX public.flashcards_created_by_id_fk;
       public            strapi    false    253                       1259    59596    flashcards_entity_fk    INDEX     [   CREATE INDEX flashcards_entity_fk ON public.flashcards_components USING btree (entity_id);
 (   DROP INDEX public.flashcards_entity_fk;
       public            strapi    false    254                       1259    59597    flashcards_field_index    INDEX     Y   CREATE INDEX flashcards_field_index ON public.flashcards_components USING btree (field);
 *   DROP INDEX public.flashcards_field_index;
       public            strapi    false    254                       1259    59598    flashcards_lesson_links_fk    INDEX     f   CREATE INDEX flashcards_lesson_links_fk ON public.flashcards_lesson_links USING btree (flashcard_id);
 .   DROP INDEX public.flashcards_lesson_links_fk;
       public            strapi    false    257                       1259    59599    flashcards_lesson_links_inv_fk    INDEX     g   CREATE INDEX flashcards_lesson_links_inv_fk ON public.flashcards_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.flashcards_lesson_links_inv_fk;
       public            strapi    false    257                        1259    59600 $   flashcards_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX flashcards_lesson_links_order_inv_fk ON public.flashcards_lesson_links USING btree (flashcard_order);
 8   DROP INDEX public.flashcards_lesson_links_order_inv_fk;
       public            strapi    false    257            %           1259    59601 !   flashcards_localizations_links_fk    INDEX     t   CREATE INDEX flashcards_localizations_links_fk ON public.flashcards_localizations_links USING btree (flashcard_id);
 5   DROP INDEX public.flashcards_localizations_links_fk;
       public            strapi    false    259            &           1259    59602 %   flashcards_localizations_links_inv_fk    INDEX     |   CREATE INDEX flashcards_localizations_links_inv_fk ON public.flashcards_localizations_links USING btree (inv_flashcard_id);
 9   DROP INDEX public.flashcards_localizations_links_inv_fk;
       public            strapi    false    259            '           1259    59603 '   flashcards_localizations_links_order_fk    INDEX     }   CREATE INDEX flashcards_localizations_links_order_fk ON public.flashcards_localizations_links USING btree (flashcard_order);
 ;   DROP INDEX public.flashcards_localizations_links_order_fk;
       public            strapi    false    259                       1259    59604    flashcards_updated_by_id_fk    INDEX     [   CREATE INDEX flashcards_updated_by_id_fk ON public.flashcards USING btree (updated_by_id);
 /   DROP INDEX public.flashcards_updated_by_id_fk;
       public            strapi    false    253            ,           1259    59605    flashcards_user_links_fk    INDEX     b   CREATE INDEX flashcards_user_links_fk ON public.flashcards_user_links USING btree (flashcard_id);
 ,   DROP INDEX public.flashcards_user_links_fk;
       public            strapi    false    261            -           1259    59606    flashcards_user_links_inv_fk    INDEX     a   CREATE INDEX flashcards_user_links_inv_fk ON public.flashcards_user_links USING btree (user_id);
 0   DROP INDEX public.flashcards_user_links_inv_fk;
       public            strapi    false    261            .           1259    59607 "   flashcards_user_links_order_inv_fk    INDEX     o   CREATE INDEX flashcards_user_links_order_inv_fk ON public.flashcards_user_links USING btree (flashcard_order);
 6   DROP INDEX public.flashcards_user_links_order_inv_fk;
       public            strapi    false    261            3           1259    59608    i18n_locale_created_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);
 0   DROP INDEX public.i18n_locale_created_by_id_fk;
       public            strapi    false    263            6           1259    59609    i18n_locale_updated_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);
 0   DROP INDEX public.i18n_locale_updated_by_id_fk;
       public            strapi    false    263            7           1259    59610    lessonlevels_created_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_created_by_id_fk ON public.lessonlevels USING btree (created_by_id);
 1   DROP INDEX public.lessonlevels_created_by_id_fk;
       public            strapi    false    265            :           1259    59611    lessonlevels_updated_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_updated_by_id_fk ON public.lessonlevels USING btree (updated_by_id);
 1   DROP INDEX public.lessonlevels_updated_by_id_fk;
       public            strapi    false    265            A           1259    59612    lessons_component_type_index    INDEX     e   CREATE INDEX lessons_component_type_index ON public.lessons_components USING btree (component_type);
 0   DROP INDEX public.lessons_component_type_index;
       public            strapi    false    268            ;           1259    59613    lessons_created_by_id_fk    INDEX     U   CREATE INDEX lessons_created_by_id_fk ON public.lessons USING btree (created_by_id);
 ,   DROP INDEX public.lessons_created_by_id_fk;
       public            strapi    false    267            D           1259    59614    lessons_entity_fk    INDEX     U   CREATE INDEX lessons_entity_fk ON public.lessons_components USING btree (entity_id);
 %   DROP INDEX public.lessons_entity_fk;
       public            strapi    false    268            E           1259    59615    lessons_field_index    INDEX     S   CREATE INDEX lessons_field_index ON public.lessons_components USING btree (field);
 '   DROP INDEX public.lessons_field_index;
       public            strapi    false    268            H           1259    59616    lessons_lessonlevel_links_fk    INDEX     g   CREATE INDEX lessons_lessonlevel_links_fk ON public.lessons_lessonlevel_links USING btree (lesson_id);
 0   DROP INDEX public.lessons_lessonlevel_links_fk;
       public            strapi    false    271            I           1259    59617     lessons_lessonlevel_links_inv_fk    INDEX     p   CREATE INDEX lessons_lessonlevel_links_inv_fk ON public.lessons_lessonlevel_links USING btree (lessonlevel_id);
 4   DROP INDEX public.lessons_lessonlevel_links_inv_fk;
       public            strapi    false    271            J           1259    59618 &   lessons_lessonlevel_links_order_inv_fk    INDEX     t   CREATE INDEX lessons_lessonlevel_links_order_inv_fk ON public.lessons_lessonlevel_links USING btree (lesson_order);
 :   DROP INDEX public.lessons_lessonlevel_links_order_inv_fk;
       public            strapi    false    271            O           1259    59619    lessons_localizations_links_fk    INDEX     k   CREATE INDEX lessons_localizations_links_fk ON public.lessons_localizations_links USING btree (lesson_id);
 2   DROP INDEX public.lessons_localizations_links_fk;
       public            strapi    false    273            P           1259    59620 "   lessons_localizations_links_inv_fk    INDEX     s   CREATE INDEX lessons_localizations_links_inv_fk ON public.lessons_localizations_links USING btree (inv_lesson_id);
 6   DROP INDEX public.lessons_localizations_links_inv_fk;
       public            strapi    false    273            Q           1259    59621 $   lessons_localizations_links_order_fk    INDEX     t   CREATE INDEX lessons_localizations_links_order_fk ON public.lessons_localizations_links USING btree (lesson_order);
 8   DROP INDEX public.lessons_localizations_links_order_fk;
       public            strapi    false    273            V           1259    59622    lessons_unit_links_fk    INDEX     Y   CREATE INDEX lessons_unit_links_fk ON public.lessons_unit_links USING btree (lesson_id);
 )   DROP INDEX public.lessons_unit_links_fk;
       public            strapi    false    275            W           1259    59623    lessons_unit_links_inv_fk    INDEX     [   CREATE INDEX lessons_unit_links_inv_fk ON public.lessons_unit_links USING btree (unit_id);
 -   DROP INDEX public.lessons_unit_links_inv_fk;
       public            strapi    false    275            X           1259    59624    lessons_unit_links_order_inv_fk    INDEX     f   CREATE INDEX lessons_unit_links_order_inv_fk ON public.lessons_unit_links USING btree (lesson_order);
 3   DROP INDEX public.lessons_unit_links_order_inv_fk;
       public            strapi    false    275            @           1259    59625    lessons_updated_by_id_fk    INDEX     U   CREATE INDEX lessons_updated_by_id_fk ON public.lessons USING btree (updated_by_id);
 ,   DROP INDEX public.lessons_updated_by_id_fk;
       public            strapi    false    267            3           1259    60335    review_tires_created_by_id_fk    INDEX     _   CREATE INDEX review_tires_created_by_id_fk ON public.review_tires USING btree (created_by_id);
 1   DROP INDEX public.review_tires_created_by_id_fk;
       public            strapi    false    356            7           1259    60344 #   review_tires_localizations_links_fk    INDEX     z   CREATE INDEX review_tires_localizations_links_fk ON public.review_tires_localizations_links USING btree (review_tire_id);
 7   DROP INDEX public.review_tires_localizations_links_fk;
       public            strapi    false    358            8           1259    60345 '   review_tires_localizations_links_inv_fk    INDEX     �   CREATE INDEX review_tires_localizations_links_inv_fk ON public.review_tires_localizations_links USING btree (inv_review_tire_id);
 ;   DROP INDEX public.review_tires_localizations_links_inv_fk;
       public            strapi    false    358            9           1259    60348 )   review_tires_localizations_links_order_fk    INDEX     �   CREATE INDEX review_tires_localizations_links_order_fk ON public.review_tires_localizations_links USING btree (review_tire_order);
 =   DROP INDEX public.review_tires_localizations_links_order_fk;
       public            strapi    false    358            6           1259    60336    review_tires_updated_by_id_fk    INDEX     _   CREATE INDEX review_tires_updated_by_id_fk ON public.review_tires USING btree (updated_by_id);
 1   DROP INDEX public.review_tires_updated_by_id_fk;
       public            strapi    false    356            ]           1259    59626    reviewlogs_created_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_created_by_id_fk ON public.reviewlogs USING btree (created_by_id);
 /   DROP INDEX public.reviewlogs_created_by_id_fk;
       public            strapi    false    277            >           1259    60402    reviewlogs_flashcard_links_fk    INDEX     l   CREATE INDEX reviewlogs_flashcard_links_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_id);
 1   DROP INDEX public.reviewlogs_flashcard_links_fk;
       public            strapi    false    360            ?           1259    60403 !   reviewlogs_flashcard_links_inv_fk    INDEX     p   CREATE INDEX reviewlogs_flashcard_links_inv_fk ON public.reviewlogs_flashcard_links USING btree (flashcard_id);
 5   DROP INDEX public.reviewlogs_flashcard_links_inv_fk;
       public            strapi    false    360            @           1259    60406 '   reviewlogs_flashcard_links_order_inv_fk    INDEX     y   CREATE INDEX reviewlogs_flashcard_links_order_inv_fk ON public.reviewlogs_flashcard_links USING btree (reviewlog_order);
 ;   DROP INDEX public.reviewlogs_flashcard_links_order_inv_fk;
       public            strapi    false    360            `           1259    59627    reviewlogs_updated_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_updated_by_id_fk ON public.reviewlogs USING btree (updated_by_id);
 /   DROP INDEX public.reviewlogs_updated_by_id_fk;
       public            strapi    false    277            a           1259    59628    reviewlogs_user_links_fk    INDEX     b   CREATE INDEX reviewlogs_user_links_fk ON public.reviewlogs_user_links USING btree (reviewlog_id);
 ,   DROP INDEX public.reviewlogs_user_links_fk;
       public            strapi    false    279            b           1259    59629    reviewlogs_user_links_inv_fk    INDEX     a   CREATE INDEX reviewlogs_user_links_inv_fk ON public.reviewlogs_user_links USING btree (user_id);
 0   DROP INDEX public.reviewlogs_user_links_inv_fk;
       public            strapi    false    279            c           1259    59630 "   reviewlogs_user_links_order_inv_fk    INDEX     o   CREATE INDEX reviewlogs_user_links_order_inv_fk ON public.reviewlogs_user_links USING btree (reviewlog_order);
 6   DROP INDEX public.reviewlogs_user_links_order_inv_fk;
       public            strapi    false    279            l           1259    59631    sections_component_type_index    INDEX     g   CREATE INDEX sections_component_type_index ON public.sections_components USING btree (component_type);
 1   DROP INDEX public.sections_component_type_index;
       public            strapi    false    282            h           1259    59632    sections_created_by_id_fk    INDEX     W   CREATE INDEX sections_created_by_id_fk ON public.sections USING btree (created_by_id);
 -   DROP INDEX public.sections_created_by_id_fk;
       public            strapi    false    281            o           1259    59633    sections_entity_fk    INDEX     W   CREATE INDEX sections_entity_fk ON public.sections_components USING btree (entity_id);
 &   DROP INDEX public.sections_entity_fk;
       public            strapi    false    282            p           1259    59634    sections_field_index    INDEX     U   CREATE INDEX sections_field_index ON public.sections_components USING btree (field);
 (   DROP INDEX public.sections_field_index;
       public            strapi    false    282            s           1259    59635    sections_lesson_links_fk    INDEX     `   CREATE INDEX sections_lesson_links_fk ON public.sections_lesson_links USING btree (section_id);
 ,   DROP INDEX public.sections_lesson_links_fk;
       public            strapi    false    285            t           1259    59636    sections_lesson_links_inv_fk    INDEX     c   CREATE INDEX sections_lesson_links_inv_fk ON public.sections_lesson_links USING btree (lesson_id);
 0   DROP INDEX public.sections_lesson_links_inv_fk;
       public            strapi    false    285            u           1259    59637 "   sections_lesson_links_order_inv_fk    INDEX     m   CREATE INDEX sections_lesson_links_order_inv_fk ON public.sections_lesson_links USING btree (section_order);
 6   DROP INDEX public.sections_lesson_links_order_inv_fk;
       public            strapi    false    285            z           1259    59638    sections_localizations_links_fk    INDEX     n   CREATE INDEX sections_localizations_links_fk ON public.sections_localizations_links USING btree (section_id);
 3   DROP INDEX public.sections_localizations_links_fk;
       public            strapi    false    287            {           1259    59639 #   sections_localizations_links_inv_fk    INDEX     v   CREATE INDEX sections_localizations_links_inv_fk ON public.sections_localizations_links USING btree (inv_section_id);
 7   DROP INDEX public.sections_localizations_links_inv_fk;
       public            strapi    false    287            |           1259    59640 %   sections_localizations_links_order_fk    INDEX     w   CREATE INDEX sections_localizations_links_order_fk ON public.sections_localizations_links USING btree (section_order);
 9   DROP INDEX public.sections_localizations_links_order_fk;
       public            strapi    false    287            k           1259    59641    sections_updated_by_id_fk    INDEX     W   CREATE INDEX sections_updated_by_id_fk ON public.sections USING btree (updated_by_id);
 -   DROP INDEX public.sections_updated_by_id_fk;
       public            strapi    false    281            �           1259    59642    sentences_component_type_index    INDEX     i   CREATE INDEX sentences_component_type_index ON public.sentences_components USING btree (component_type);
 2   DROP INDEX public.sentences_component_type_index;
       public            strapi    false    290            �           1259    59643    sentences_created_by_id_fk    INDEX     Y   CREATE INDEX sentences_created_by_id_fk ON public.sentences USING btree (created_by_id);
 .   DROP INDEX public.sentences_created_by_id_fk;
       public            strapi    false    289            �           1259    59644    sentences_entity_fk    INDEX     Y   CREATE INDEX sentences_entity_fk ON public.sentences_components USING btree (entity_id);
 '   DROP INDEX public.sentences_entity_fk;
       public            strapi    false    290            �           1259    59645    sentences_field_index    INDEX     W   CREATE INDEX sentences_field_index ON public.sentences_components USING btree (field);
 )   DROP INDEX public.sentences_field_index;
       public            strapi    false    290            �           1259    59646     sentences_localizations_links_fk    INDEX     q   CREATE INDEX sentences_localizations_links_fk ON public.sentences_localizations_links USING btree (sentence_id);
 4   DROP INDEX public.sentences_localizations_links_fk;
       public            strapi    false    293            �           1259    59647 $   sentences_localizations_links_inv_fk    INDEX     y   CREATE INDEX sentences_localizations_links_inv_fk ON public.sentences_localizations_links USING btree (inv_sentence_id);
 8   DROP INDEX public.sentences_localizations_links_inv_fk;
       public            strapi    false    293            �           1259    59648 &   sentences_localizations_links_order_fk    INDEX     z   CREATE INDEX sentences_localizations_links_order_fk ON public.sentences_localizations_links USING btree (sentence_order);
 :   DROP INDEX public.sentences_localizations_links_order_fk;
       public            strapi    false    293            �           1259    59649    sentences_updated_by_id_fk    INDEX     Y   CREATE INDEX sentences_updated_by_id_fk ON public.sentences USING btree (updated_by_id);
 .   DROP INDEX public.sentences_updated_by_id_fk;
       public            strapi    false    289            �           1259    59650 -   strapi_api_token_permissions_created_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_created_by_id_fk;
       public            strapi    false    295            �           1259    59651 +   strapi_api_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);
 ?   DROP INDEX public.strapi_api_token_permissions_token_links_fk;
       public            strapi    false    297            �           1259    59652 /   strapi_api_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);
 C   DROP INDEX public.strapi_api_token_permissions_token_links_inv_fk;
       public            strapi    false    297            �           1259    59653 5   strapi_api_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);
 I   DROP INDEX public.strapi_api_token_permissions_token_links_order_inv_fk;
       public            strapi    false    297            �           1259    59654 -   strapi_api_token_permissions_updated_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_updated_by_id_fk;
       public            strapi    false    295            �           1259    59655 "   strapi_api_tokens_created_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);
 6   DROP INDEX public.strapi_api_tokens_created_by_id_fk;
       public            strapi    false    299            �           1259    59656 "   strapi_api_tokens_updated_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);
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
       public            strapi    false    327                       1259    59683    upload_files_created_at_index    INDEX     U   CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);
 1   DROP INDEX public.upload_files_created_at_index;
       public            strapi    false    247                       1259    59684    upload_files_ext_index    INDEX     G   CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);
 *   DROP INDEX public.upload_files_ext_index;
       public            strapi    false    247                       1259    59685    upload_files_folder_path_index    INDEX     W   CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);
 2   DROP INDEX public.upload_files_folder_path_index;
       public            strapi    false    247                       1259    59686    upload_files_name_index    INDEX     I   CREATE INDEX upload_files_name_index ON public.files USING btree (name);
 +   DROP INDEX public.upload_files_name_index;
       public            strapi    false    247                       1259    59687    upload_files_size_index    INDEX     I   CREATE INDEX upload_files_size_index ON public.files USING btree (size);
 +   DROP INDEX public.upload_files_size_index;
       public            strapi    false    247                       1259    59688    upload_files_updated_at_index    INDEX     U   CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);
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
       public            strapi    false    331            E           1259    60475    user_profiles_created_by_id_fk    INDEX     a   CREATE INDEX user_profiles_created_by_id_fk ON public.user_profiles USING btree (created_by_id);
 2   DROP INDEX public.user_profiles_created_by_id_fk;
       public            strapi    false    362            H           1259    60476    user_profiles_updated_by_id_fk    INDEX     a   CREATE INDEX user_profiles_updated_by_id_fk ON public.user_profiles USING btree (updated_by_id);
 2   DROP INDEX public.user_profiles_updated_by_id_fk;
       public            strapi    false    362            I           1259    60484    user_profiles_user_links_fk    INDEX     k   CREATE INDEX user_profiles_user_links_fk ON public.user_profiles_user_links USING btree (user_profile_id);
 /   DROP INDEX public.user_profiles_user_links_fk;
       public            strapi    false    364            J           1259    60485    user_profiles_user_links_inv_fk    INDEX     g   CREATE INDEX user_profiles_user_links_inv_fk ON public.user_profiles_user_links USING btree (user_id);
 3   DROP INDEX public.user_profiles_user_links_inv_fk;
       public            strapi    false    364            �           1259    59694    user_sentences_created_by_id_fk    INDEX     c   CREATE INDEX user_sentences_created_by_id_fk ON public.user_sentences USING btree (created_by_id);
 3   DROP INDEX public.user_sentences_created_by_id_fk;
       public            strapi    false    335            �           1259    59695    user_sentences_lesson_links_fk    INDEX     r   CREATE INDEX user_sentences_lesson_links_fk ON public.user_sentences_lesson_links USING btree (user_sentence_id);
 2   DROP INDEX public.user_sentences_lesson_links_fk;
       public            strapi    false    337            �           1259    59696 "   user_sentences_lesson_links_inv_fk    INDEX     o   CREATE INDEX user_sentences_lesson_links_inv_fk ON public.user_sentences_lesson_links USING btree (lesson_id);
 6   DROP INDEX public.user_sentences_lesson_links_inv_fk;
       public            strapi    false    337            �           1259    59697 (   user_sentences_lesson_links_order_inv_fk    INDEX        CREATE INDEX user_sentences_lesson_links_order_inv_fk ON public.user_sentences_lesson_links USING btree (user_sentence_order);
 <   DROP INDEX public.user_sentences_lesson_links_order_inv_fk;
       public            strapi    false    337                        1259    59698 %   user_sentences_localizations_links_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_fk ON public.user_sentences_localizations_links USING btree (user_sentence_id);
 9   DROP INDEX public.user_sentences_localizations_links_fk;
       public            strapi    false    339                       1259    59699 )   user_sentences_localizations_links_inv_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_inv_fk ON public.user_sentences_localizations_links USING btree (inv_user_sentence_id);
 =   DROP INDEX public.user_sentences_localizations_links_inv_fk;
       public            strapi    false    339                       1259    59700 +   user_sentences_localizations_links_order_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_order_fk ON public.user_sentences_localizations_links USING btree (user_sentence_order);
 ?   DROP INDEX public.user_sentences_localizations_links_order_fk;
       public            strapi    false    339            �           1259    59701    user_sentences_updated_by_id_fk    INDEX     c   CREATE INDEX user_sentences_updated_by_id_fk ON public.user_sentences USING btree (updated_by_id);
 3   DROP INDEX public.user_sentences_updated_by_id_fk;
       public            strapi    false    335            V           1259    60641    user_sentences_user_links_fk    INDEX     n   CREATE INDEX user_sentences_user_links_fk ON public.user_sentences_user_links USING btree (user_sentence_id);
 0   DROP INDEX public.user_sentences_user_links_fk;
       public            strapi    false    368            W           1259    60642     user_sentences_user_links_inv_fk    INDEX     i   CREATE INDEX user_sentences_user_links_inv_fk ON public.user_sentences_user_links USING btree (user_id);
 4   DROP INDEX public.user_sentences_user_links_inv_fk;
       public            strapi    false    368            X           1259    60645 &   user_sentences_user_links_order_inv_fk    INDEX     {   CREATE INDEX user_sentences_user_links_order_inv_fk ON public.user_sentences_user_links USING btree (user_sentence_order);
 :   DROP INDEX public.user_sentences_user_links_order_inv_fk;
       public            strapi    false    368                       1259    59705    user_words_created_by_id_fk    INDEX     [   CREATE INDEX user_words_created_by_id_fk ON public.user_words USING btree (created_by_id);
 /   DROP INDEX public.user_words_created_by_id_fk;
       public            strapi    false    341                       1259    59706    user_words_lesson_links_fk    INDEX     f   CREATE INDEX user_words_lesson_links_fk ON public.user_words_lesson_links USING btree (user_word_id);
 .   DROP INDEX public.user_words_lesson_links_fk;
       public            strapi    false    343                       1259    59707    user_words_lesson_links_inv_fk    INDEX     g   CREATE INDEX user_words_lesson_links_inv_fk ON public.user_words_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.user_words_lesson_links_inv_fk;
       public            strapi    false    343                       1259    59708 $   user_words_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX user_words_lesson_links_order_inv_fk ON public.user_words_lesson_links USING btree (user_word_order);
 8   DROP INDEX public.user_words_lesson_links_order_inv_fk;
       public            strapi    false    343                       1259    59709 !   user_words_localizations_links_fk    INDEX     t   CREATE INDEX user_words_localizations_links_fk ON public.user_words_localizations_links USING btree (user_word_id);
 5   DROP INDEX public.user_words_localizations_links_fk;
       public            strapi    false    345                       1259    59710 %   user_words_localizations_links_inv_fk    INDEX     |   CREATE INDEX user_words_localizations_links_inv_fk ON public.user_words_localizations_links USING btree (inv_user_word_id);
 9   DROP INDEX public.user_words_localizations_links_inv_fk;
       public            strapi    false    345                       1259    59711 '   user_words_localizations_links_order_fk    INDEX     }   CREATE INDEX user_words_localizations_links_order_fk ON public.user_words_localizations_links USING btree (user_word_order);
 ;   DROP INDEX public.user_words_localizations_links_order_fk;
       public            strapi    false    345            
           1259    59712    user_words_updated_by_id_fk    INDEX     [   CREATE INDEX user_words_updated_by_id_fk ON public.user_words USING btree (updated_by_id);
 /   DROP INDEX public.user_words_updated_by_id_fk;
       public            strapi    false    341            O           1259    60606    user_words_user_links_fk    INDEX     b   CREATE INDEX user_words_user_links_fk ON public.user_words_user_links USING btree (user_word_id);
 ,   DROP INDEX public.user_words_user_links_fk;
       public            strapi    false    366            P           1259    60607    user_words_user_links_inv_fk    INDEX     a   CREATE INDEX user_words_user_links_inv_fk ON public.user_words_user_links USING btree (user_id);
 0   DROP INDEX public.user_words_user_links_inv_fk;
       public            strapi    false    366            Q           1259    60610 "   user_words_user_links_order_inv_fk    INDEX     o   CREATE INDEX user_words_user_links_order_inv_fk ON public.user_words_user_links USING btree (user_word_order);
 6   DROP INDEX public.user_words_user_links_order_inv_fk;
       public            strapi    false    366            ]           1259    63672    vocabooks_created_by_id_fk    INDEX     Y   CREATE INDEX vocabooks_created_by_id_fk ON public.vocabooks USING btree (created_by_id);
 .   DROP INDEX public.vocabooks_created_by_id_fk;
       public            strapi    false    370            g           1259    63692     vocabooks_localizations_links_fk    INDEX     q   CREATE INDEX vocabooks_localizations_links_fk ON public.vocabooks_localizations_links USING btree (vocabook_id);
 4   DROP INDEX public.vocabooks_localizations_links_fk;
       public            strapi    false    374            h           1259    63693 $   vocabooks_localizations_links_inv_fk    INDEX     y   CREATE INDEX vocabooks_localizations_links_inv_fk ON public.vocabooks_localizations_links USING btree (inv_vocabook_id);
 8   DROP INDEX public.vocabooks_localizations_links_inv_fk;
       public            strapi    false    374            i           1259    63696 &   vocabooks_localizations_links_order_fk    INDEX     z   CREATE INDEX vocabooks_localizations_links_order_fk ON public.vocabooks_localizations_links USING btree (vocabook_order);
 :   DROP INDEX public.vocabooks_localizations_links_order_fk;
       public            strapi    false    374            `           1259    63673    vocabooks_updated_by_id_fk    INDEX     Y   CREATE INDEX vocabooks_updated_by_id_fk ON public.vocabooks USING btree (updated_by_id);
 .   DROP INDEX public.vocabooks_updated_by_id_fk;
       public            strapi    false    370            a           1259    63681    vocabooks_user_links_fk    INDEX     _   CREATE INDEX vocabooks_user_links_fk ON public.vocabooks_user_links USING btree (vocabook_id);
 +   DROP INDEX public.vocabooks_user_links_fk;
       public            strapi    false    372            b           1259    63682    vocabooks_user_links_inv_fk    INDEX     _   CREATE INDEX vocabooks_user_links_inv_fk ON public.vocabooks_user_links USING btree (user_id);
 /   DROP INDEX public.vocabooks_user_links_inv_fk;
       public            strapi    false    372            y           1259    63802    vocapages_component_type_index    INDEX     i   CREATE INDEX vocapages_component_type_index ON public.vocapages_components USING btree (component_type);
 2   DROP INDEX public.vocapages_component_type_index;
       public            strapi    false    380            n           1259    63746    vocapages_created_by_id_fk    INDEX     Y   CREATE INDEX vocapages_created_by_id_fk ON public.vocapages USING btree (created_by_id);
 .   DROP INDEX public.vocapages_created_by_id_fk;
       public            strapi    false    376            |           1259    63803    vocapages_entity_fk    INDEX     Y   CREATE INDEX vocapages_entity_fk ON public.vocapages_components USING btree (entity_id);
 '   DROP INDEX public.vocapages_entity_fk;
       public            strapi    false    380            }           1259    63801    vocapages_field_index    INDEX     W   CREATE INDEX vocapages_field_index ON public.vocapages_components USING btree (field);
 )   DROP INDEX public.vocapages_field_index;
       public            strapi    false    380            q           1259    63747    vocapages_updated_by_id_fk    INDEX     Y   CREATE INDEX vocapages_updated_by_id_fk ON public.vocapages USING btree (updated_by_id);
 .   DROP INDEX public.vocapages_updated_by_id_fk;
       public            strapi    false    376            r           1259    63755    vocapages_vocabook_links_fk    INDEX     g   CREATE INDEX vocapages_vocabook_links_fk ON public.vocapages_vocabook_links USING btree (vocapage_id);
 /   DROP INDEX public.vocapages_vocabook_links_fk;
       public            strapi    false    378            s           1259    63756    vocapages_vocabook_links_inv_fk    INDEX     k   CREATE INDEX vocapages_vocabook_links_inv_fk ON public.vocapages_vocabook_links USING btree (vocabook_id);
 3   DROP INDEX public.vocapages_vocabook_links_inv_fk;
       public            strapi    false    378            t           1259    63759 %   vocapages_vocabook_links_order_inv_fk    INDEX     t   CREATE INDEX vocapages_vocabook_links_order_inv_fk ON public.vocapages_vocabook_links USING btree (vocapage_order);
 9   DROP INDEX public.vocapages_vocabook_links_order_inv_fk;
       public            strapi    false    378                       1259    59716    words_component_type_index    INDEX     a   CREATE INDEX words_component_type_index ON public.words_components USING btree (component_type);
 .   DROP INDEX public.words_component_type_index;
       public            strapi    false    348                       1259    59717    words_created_by_id_fk    INDEX     Q   CREATE INDEX words_created_by_id_fk ON public.words USING btree (created_by_id);
 *   DROP INDEX public.words_created_by_id_fk;
       public            strapi    false    347                        1259    59718    words_entity_fk    INDEX     Q   CREATE INDEX words_entity_fk ON public.words_components USING btree (entity_id);
 #   DROP INDEX public.words_entity_fk;
       public            strapi    false    348            $           1259    59719     words_example_sentences_links_fk    INDEX     m   CREATE INDEX words_example_sentences_links_fk ON public.words_example_sentences_links USING btree (word_id);
 4   DROP INDEX public.words_example_sentences_links_fk;
       public            strapi    false    350            %           1259    59720 $   words_example_sentences_links_inv_fk    INDEX     u   CREATE INDEX words_example_sentences_links_inv_fk ON public.words_example_sentences_links USING btree (sentence_id);
 8   DROP INDEX public.words_example_sentences_links_inv_fk;
       public            strapi    false    350            &           1259    59721 &   words_example_sentences_links_order_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_fk ON public.words_example_sentences_links USING btree (sentence_order);
 :   DROP INDEX public.words_example_sentences_links_order_fk;
       public            strapi    false    350            '           1259    59722 *   words_example_sentences_links_order_inv_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_inv_fk ON public.words_example_sentences_links USING btree (word_order);
 >   DROP INDEX public.words_example_sentences_links_order_inv_fk;
       public            strapi    false    350            !           1259    59723    words_field_index    INDEX     O   CREATE INDEX words_field_index ON public.words_components USING btree (field);
 %   DROP INDEX public.words_field_index;
       public            strapi    false    348            ,           1259    59724    words_localizations_links_fk    INDEX     e   CREATE INDEX words_localizations_links_fk ON public.words_localizations_links USING btree (word_id);
 0   DROP INDEX public.words_localizations_links_fk;
       public            strapi    false    353            -           1259    59725     words_localizations_links_inv_fk    INDEX     m   CREATE INDEX words_localizations_links_inv_fk ON public.words_localizations_links USING btree (inv_word_id);
 4   DROP INDEX public.words_localizations_links_inv_fk;
       public            strapi    false    353            .           1259    59726 "   words_localizations_links_order_fk    INDEX     n   CREATE INDEX words_localizations_links_order_fk ON public.words_localizations_links USING btree (word_order);
 6   DROP INDEX public.words_localizations_links_order_fk;
       public            strapi    false    353                       1259    59727    words_updated_by_id_fk    INDEX     Q   CREATE INDEX words_updated_by_id_fk ON public.words USING btree (updated_by_id);
 *   DROP INDEX public.words_updated_by_id_fk;
       public            strapi    false    347            �           2606    59728 4   admin_permissions admin_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_created_by_id_fk;
       public          strapi    false    209    4295    215            �           2606    59733 <   admin_permissions_role_links admin_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_fk;
       public          strapi    false    211    4280    209            �           2606    59738 @   admin_permissions_role_links admin_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_inv_fk;
       public          strapi    false    211    4291    213            �           2606    59743 4   admin_permissions admin_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_updated_by_id_fk;
       public          strapi    false    209    4295    215            �           2606    59748 (   admin_roles admin_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_created_by_id_fk;
       public          strapi    false    215    213    4295            �           2606    59753 (   admin_roles admin_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_updated_by_id_fk;
       public          strapi    false    213    215    4295            �           2606    59758 (   admin_users admin_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_created_by_id_fk;
       public          strapi    false    215    215    4295            �           2606    59763 2   admin_users_roles_links admin_users_roles_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_fk;
       public          strapi    false    215    4295    217            �           2606    59768 6   admin_users_roles_links admin_users_roles_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_inv_fk;
       public          strapi    false    213    217    4291            �           2606    59773 (   admin_users admin_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_updated_by_id_fk;
       public          strapi    false    4295    215    215            �           2606    59778 N   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_fk FOREIGN KEY (sent_ref_id) REFERENCES public.components_a_sent_refs(id) ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_fk;
       public          strapi    false    4312    227    225            �           2606    59783 R   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 |   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_inv_fk;
       public          strapi    false    227    289    4483            �           2606    59788 b   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk FOREIGN KEY (user_sent_ref_id) REFERENCES public.components_a_user_sent_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk;
       public          strapi    false    4322    231    233            �           2606    59793 f   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk;
       public          strapi    false    233    335    4599            �           2606    59798 Z   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_fk FOREIGN KEY (user_word_ref_id) REFERENCES public.components_a_user_word_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_fk;
       public          strapi    false    4330    237    235            �           2606    59803 ^   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk;
       public          strapi    false    237    341    4617            �           2606    59808 F   components_a_word_refs_word_links components_a_word_refs_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_fk FOREIGN KEY (word_ref_id) REFERENCES public.components_a_word_refs(id) ON DELETE CASCADE;
 p   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_fk;
       public          strapi    false    245    243    4342            �           2606    59813 J   components_a_word_refs_word_links components_a_word_refs_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_inv_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 t   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_inv_fk;
       public          strapi    false    245    347    4635            �           2606    59818    files files_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fk;
       public          strapi    false    4295    247    215            �           2606    59823 (   files_folder_links files_folder_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_fk;
       public          strapi    false    247    248    4351            �           2606    59828 ,   files_folder_links files_folder_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_inv_fk;
       public          strapi    false    4588    331    248            �           2606    59833 ,   files_related_morphs files_related_morphs_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_fk;
       public          strapi    false    4351    247    251            �           2606    59838    files files_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_updated_by_id_fk;
       public          strapi    false    4295    215    247            �           2606    59843 &   flashcards flashcards_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_created_by_id_fk;
       public          strapi    false    215    253    4295            �           2606    59848 *   flashcards_components flashcards_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_entity_fk FOREIGN KEY (entity_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_entity_fk;
       public          strapi    false    254    4373    253            �           2606    59853 2   flashcards_lesson_links flashcards_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_fk;
       public          strapi    false    253    4373    257            �           2606    59858 6   flashcards_lesson_links flashcards_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_inv_fk;
       public          strapi    false    257    267    4413            �           2606    59863 @   flashcards_localizations_links flashcards_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_fk;
       public          strapi    false    259    4373    253            �           2606    59868 D   flashcards_localizations_links flashcards_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_inv_fk FOREIGN KEY (inv_flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_inv_fk;
       public          strapi    false    253    4373    259            �           2606    59873 &   flashcards flashcards_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_updated_by_id_fk;
       public          strapi    false    253    215    4295            �           2606    59878 .   flashcards_user_links flashcards_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_fk;
       public          strapi    false    253    261    4373            �           2606    59883 2   flashcards_user_links flashcards_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_inv_fk;
       public          strapi    false    4573    261    327            �           2606    59888 (   i18n_locale i18n_locale_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_created_by_id_fk;
       public          strapi    false    263    4295    215            �           2606    59893 (   i18n_locale i18n_locale_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_updated_by_id_fk;
       public          strapi    false    4295    263    215            �           2606    59898 *   lessonlevels lessonlevels_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_created_by_id_fk;
       public          strapi    false    265    4295    215            �           2606    59903 *   lessonlevels lessonlevels_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_updated_by_id_fk;
       public          strapi    false    265    215    4295            �           2606    59908     lessons lessons_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_created_by_id_fk;
       public          strapi    false    215    267    4295            �           2606    59913 $   lessons_components lessons_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_entity_fk FOREIGN KEY (entity_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_entity_fk;
       public          strapi    false    267    4413    268            �           2606    59918 6   lessons_lessonlevel_links lessons_lessonlevel_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_fk;
       public          strapi    false    271    4413    267            �           2606    59923 :   lessons_lessonlevel_links lessons_lessonlevel_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_inv_fk FOREIGN KEY (lessonlevel_id) REFERENCES public.lessonlevels(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_inv_fk;
       public          strapi    false    265    271    4409            �           2606    59928 :   lessons_localizations_links lessons_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_fk;
       public          strapi    false    273    267    4413            �           2606    59933 >   lessons_localizations_links lessons_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_inv_fk FOREIGN KEY (inv_lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_inv_fk;
       public          strapi    false    273    4413    267            �           2606    59938 (   lessons_unit_links lessons_unit_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_fk;
       public          strapi    false    267    275    4413            �           2606    59943 ,   lessons_unit_links lessons_unit_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_inv_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_inv_fk;
       public          strapi    false    315    4539    275            �           2606    59948     lessons lessons_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_updated_by_id_fk;
       public          strapi    false    215    267    4295            �           2606    60349 *   review_tires review_tires_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_created_by_id_fk;
       public          strapi    false    356    215    4295            �           2606    60359 D   review_tires_localizations_links review_tires_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_fk FOREIGN KEY (review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_fk;
       public          strapi    false    356    4661    358            �           2606    60364 H   review_tires_localizations_links review_tires_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires_localizations_links
    ADD CONSTRAINT review_tires_localizations_links_inv_fk FOREIGN KEY (inv_review_tire_id) REFERENCES public.review_tires(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.review_tires_localizations_links DROP CONSTRAINT review_tires_localizations_links_inv_fk;
       public          strapi    false    358    4661    356            �           2606    60354 *   review_tires review_tires_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.review_tires
    ADD CONSTRAINT review_tires_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.review_tires DROP CONSTRAINT review_tires_updated_by_id_fk;
       public          strapi    false    356    215    4295            �           2606    59953 &   reviewlogs reviewlogs_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_created_by_id_fk;
       public          strapi    false    277    215    4295            �           2606    60407 8   reviewlogs_flashcard_links reviewlogs_flashcard_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_fk;
       public          strapi    false    4447    277    360            �           2606    60412 <   reviewlogs_flashcard_links reviewlogs_flashcard_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_flashcard_links
    ADD CONSTRAINT reviewlogs_flashcard_links_inv_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.reviewlogs_flashcard_links DROP CONSTRAINT reviewlogs_flashcard_links_inv_fk;
       public          strapi    false    253    4373    360            �           2606    59958 &   reviewlogs reviewlogs_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_updated_by_id_fk;
       public          strapi    false    215    4295    277            �           2606    59963 .   reviewlogs_user_links reviewlogs_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_fk;
       public          strapi    false    4447    279    277            �           2606    59968 2   reviewlogs_user_links reviewlogs_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_inv_fk;
       public          strapi    false    279    4573    327            �           2606    59973 "   sections sections_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_created_by_id_fk;
       public          strapi    false    4295    281    215            �           2606    59978 &   sections_components sections_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_entity_fk;
       public          strapi    false    4458    281    282            �           2606    59983 .   sections_lesson_links sections_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_fk;
       public          strapi    false    281    285    4458            �           2606    59988 2   sections_lesson_links sections_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_inv_fk;
       public          strapi    false    285    4413    267            �           2606    59993 <   sections_localizations_links sections_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_fk;
       public          strapi    false    287    4458    281            �           2606    59998 @   sections_localizations_links sections_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_inv_fk FOREIGN KEY (inv_section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_inv_fk;
       public          strapi    false    4458    287    281            �           2606    60003 "   sections sections_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_updated_by_id_fk;
       public          strapi    false    281    4295    215            �           2606    60008 $   sentences sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_created_by_id_fk;
       public          strapi    false    289    4295    215            �           2606    60013 (   sentences_components sentences_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_entity_fk;
       public          strapi    false    290    4483    289            �           2606    60018 >   sentences_localizations_links sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_fk;
       public          strapi    false    293    4483    289            �           2606    60023 B   sentences_localizations_links sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_inv_fk FOREIGN KEY (inv_sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_inv_fk;
       public          strapi    false    293    4483    289            �           2606    60028 $   sentences sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_updated_by_id_fk;
       public          strapi    false    289    4295    215            �           2606    60033 J   strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_created_by_id_fk;
       public          strapi    false    295    4295    215            �           2606    60038 T   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;
 ~   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_fk;
       public          strapi    false    297    4501    295            �           2606    60043 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_inv_fk;
       public          strapi    false    297    4512    299            �           2606    60048 J   strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_updated_by_id_fk;
       public          strapi    false    295    4295    215            �           2606    60053 4   strapi_api_tokens strapi_api_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_created_by_id_fk;
       public          strapi    false    215    4295    299            �           2606    60058 4   strapi_api_tokens strapi_api_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_updated_by_id_fk;
       public          strapi    false    4295    299    215            �           2606    60063 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk;
       public          strapi    false    307    4295    215            �           2606    60068 ^   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk    FK CONSTRAINT        ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_fk;
       public          strapi    false    309    4522    307            �           2606    60073 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk;
       public          strapi    false    309    4533    311            �           2606    60078 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk;
       public          strapi    false    307    4295    215            �           2606    60083 >   strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_created_by_id_fk;
       public          strapi    false    311    4295    215            �           2606    60088 >   strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_updated_by_id_fk;
       public          strapi    false    311    4295    215            �           2606    60093    units units_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_created_by_id_fk;
       public          strapi    false    315    4295    215            �           2606    60098 6   units_localizations_links units_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_fk;
       public          strapi    false    317    4539    315            �           2606    60103 :   units_localizations_links units_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_inv_fk;
       public          strapi    false    317    4539    315            �           2606    60108 4   units_precondition_links units_precondition_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_fk;
       public          strapi    false    4539    319    315            �           2606    60113 8   units_precondition_links units_precondition_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_inv_fk;
       public          strapi    false    319    4539    315            �           2606    60118    units units_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_updated_by_id_fk;
       public          strapi    false    315    4295    215            �           2606    60123 .   up_permissions up_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_created_by_id_fk;
       public          strapi    false    321    4295    215            �           2606    60128 6   up_permissions_role_links up_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_fk;
       public          strapi    false    323    4558    321            �           2606    60133 :   up_permissions_role_links up_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_inv_fk;
       public          strapi    false    323    4569    325            �           2606    60138 .   up_permissions up_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_updated_by_id_fk;
       public          strapi    false    321    4295    215            �           2606    60143 "   up_roles up_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_created_by_id_fk;
       public          strapi    false    325    4295    215            �           2606    60148 "   up_roles up_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_updated_by_id_fk;
       public          strapi    false    325    4295    215            �           2606    60153 "   up_users up_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_created_by_id_fk;
       public          strapi    false    327    4295    215            �           2606    60158 *   up_users_role_links up_users_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_fk;
       public          strapi    false    329    327    4573            �           2606    60163 .   up_users_role_links up_users_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_inv_fk;
       public          strapi    false    4569    325    329            �           2606    60168 "   up_users up_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_updated_by_id_fk;
       public          strapi    false    327    4295    215            �           2606    60173 .   upload_folders upload_folders_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_created_by_id_fk;
       public          strapi    false    215    331    4295            �           2606    60178 :   upload_folders_parent_links upload_folders_parent_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_fk;
       public          strapi    false    4588    333    331            �           2606    60183 >   upload_folders_parent_links upload_folders_parent_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_inv_fk;
       public          strapi    false    4588    333    331            �           2606    60188 .   upload_folders upload_folders_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_updated_by_id_fk;
       public          strapi    false    4295    331    215            �           2606    60488 ,   user_profiles user_profiles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 V   ALTER TABLE ONLY public.user_profiles DROP CONSTRAINT user_profiles_created_by_id_fk;
       public          strapi    false    4295    215    362            �           2606    60493 ,   user_profiles user_profiles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 V   ALTER TABLE ONLY public.user_profiles DROP CONSTRAINT user_profiles_updated_by_id_fk;
       public          strapi    false    215    362    4295            �           2606    60498 4   user_profiles_user_links user_profiles_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_fk FOREIGN KEY (user_profile_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_fk;
       public          strapi    false    364    4679    362            �           2606    60503 8   user_profiles_user_links user_profiles_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profiles_user_links
    ADD CONSTRAINT user_profiles_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.user_profiles_user_links DROP CONSTRAINT user_profiles_user_links_inv_fk;
       public          strapi    false    4573    364    327            �           2606    60193 .   user_sentences user_sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_created_by_id_fk;
       public          strapi    false    4295    335    215            �           2606    60198 :   user_sentences_lesson_links user_sentences_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_fk;
       public          strapi    false    4599    337    335            �           2606    60203 >   user_sentences_lesson_links user_sentences_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_inv_fk;
       public          strapi    false    4413    337    267            �           2606    60208 H   user_sentences_localizations_links user_sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_fk;
       public          strapi    false    4599    339    335            �           2606    60213 L   user_sentences_localizations_links user_sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_inv_fk FOREIGN KEY (inv_user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_inv_fk;
       public          strapi    false    4599    339    335            �           2606    60218 .   user_sentences user_sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_updated_by_id_fk;
       public          strapi    false    4295    335    215            �           2606    60646 6   user_sentences_user_links user_sentences_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_fk;
       public          strapi    false    368    4599    335            �           2606    60651 :   user_sentences_user_links user_sentences_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_user_links
    ADD CONSTRAINT user_sentences_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.user_sentences_user_links DROP CONSTRAINT user_sentences_user_links_inv_fk;
       public          strapi    false    4573    368    327            �           2606    60233 &   user_words user_words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_created_by_id_fk;
       public          strapi    false    341    4295    215            �           2606    60238 2   user_words_lesson_links user_words_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_fk;
       public          strapi    false    343    4617    341            �           2606    60243 6   user_words_lesson_links user_words_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_inv_fk;
       public          strapi    false    267    343    4413            �           2606    60248 @   user_words_localizations_links user_words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_fk;
       public          strapi    false    4617    345    341            �           2606    60253 D   user_words_localizations_links user_words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_inv_fk FOREIGN KEY (inv_user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_inv_fk;
       public          strapi    false    4617    345    341            �           2606    60258 &   user_words user_words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_updated_by_id_fk;
       public          strapi    false    4295    341    215            �           2606    60611 .   user_words_user_links user_words_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_fk;
       public          strapi    false    341    366    4617            �           2606    60616 2   user_words_user_links user_words_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_user_links
    ADD CONSTRAINT user_words_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_words_user_links DROP CONSTRAINT user_words_user_links_inv_fk;
       public          strapi    false    366    327    4573            �           2606    63697 $   vocabooks vocabooks_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks
    ADD CONSTRAINT vocabooks_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.vocabooks DROP CONSTRAINT vocabooks_created_by_id_fk;
       public          strapi    false    215    4295    370                       2606    63717 >   vocabooks_localizations_links vocabooks_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks_localizations_links
    ADD CONSTRAINT vocabooks_localizations_links_fk FOREIGN KEY (vocabook_id) REFERENCES public.vocabooks(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.vocabooks_localizations_links DROP CONSTRAINT vocabooks_localizations_links_fk;
       public          strapi    false    4703    374    370                       2606    63722 B   vocabooks_localizations_links vocabooks_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks_localizations_links
    ADD CONSTRAINT vocabooks_localizations_links_inv_fk FOREIGN KEY (inv_vocabook_id) REFERENCES public.vocabooks(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.vocabooks_localizations_links DROP CONSTRAINT vocabooks_localizations_links_inv_fk;
       public          strapi    false    4703    374    370            �           2606    63702 $   vocabooks vocabooks_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks
    ADD CONSTRAINT vocabooks_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.vocabooks DROP CONSTRAINT vocabooks_updated_by_id_fk;
       public          strapi    false    370    215    4295                        2606    63707 ,   vocabooks_user_links vocabooks_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_fk FOREIGN KEY (vocabook_id) REFERENCES public.vocabooks(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.vocabooks_user_links DROP CONSTRAINT vocabooks_user_links_fk;
       public          strapi    false    4703    372    370                       2606    63712 0   vocabooks_user_links vocabooks_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocabooks_user_links
    ADD CONSTRAINT vocabooks_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.vocabooks_user_links DROP CONSTRAINT vocabooks_user_links_inv_fk;
       public          strapi    false    4573    327    372                       2606    63760 $   vocapages vocapages_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocapages
    ADD CONSTRAINT vocapages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.vocapages DROP CONSTRAINT vocapages_created_by_id_fk;
       public          strapi    false    376    4295    215                       2606    63806 (   vocapages_components vocapages_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocapages_components
    ADD CONSTRAINT vocapages_entity_fk FOREIGN KEY (entity_id) REFERENCES public.vocapages(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.vocapages_components DROP CONSTRAINT vocapages_entity_fk;
       public          strapi    false    380    4720    376                       2606    63765 $   vocapages vocapages_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocapages
    ADD CONSTRAINT vocapages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.vocapages DROP CONSTRAINT vocapages_updated_by_id_fk;
       public          strapi    false    215    4295    376                       2606    63770 4   vocapages_vocabook_links vocapages_vocabook_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_fk FOREIGN KEY (vocapage_id) REFERENCES public.vocapages(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.vocapages_vocabook_links DROP CONSTRAINT vocapages_vocabook_links_fk;
       public          strapi    false    376    378    4720                       2606    63775 8   vocapages_vocabook_links vocapages_vocabook_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vocapages_vocabook_links
    ADD CONSTRAINT vocapages_vocabook_links_inv_fk FOREIGN KEY (vocabook_id) REFERENCES public.vocabooks(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.vocapages_vocabook_links DROP CONSTRAINT vocapages_vocabook_links_inv_fk;
       public          strapi    false    370    4703    378            �           2606    60273    words words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_created_by_id_fk;
       public          strapi    false    4295    347    215            �           2606    60278     words_components words_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_entity_fk FOREIGN KEY (entity_id) REFERENCES public.words(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_entity_fk;
       public          strapi    false    4635    348    347            �           2606    60283 >   words_example_sentences_links words_example_sentences_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_fk;
       public          strapi    false    4635    350    347            �           2606    60288 B   words_example_sentences_links words_example_sentences_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_inv_fk;
       public          strapi    false    4483    350    289            �           2606    60293 6   words_localizations_links words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_fk;
       public          strapi    false    4635    353    347            �           2606    60298 :   words_localizations_links words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_inv_fk FOREIGN KEY (inv_word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_inv_fk;
       public          strapi    false    353    347    4635            �           2606    60303    words words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_updated_by_id_fk;
       public          strapi    false    215    4295    347            �   �
  x��[�r����<�+�kB ��pj�\��Δ�؊��p2S[�ݏ�Z���H*����$���u�Z
����SV�v�K^�GR��x���n���~������p���64�юQ�i`��~���?�{(���t���)ϋ��Zq́M9�u-����Xd�D6X�,䯗�2y�АYq� �08�υz_d����5n3Qy��ͳ�q�G��V\��6=�էY�m=SV�8+q+�Y�o�)��!�A�C�b�c��5�P�5��ƈO1i�ҷ�#,��8�-����HcIE���h��F����ITD|�\+�p�І��EUo/�:gu���4�D��$�A"� uV�r�m~\D�.@�̕Ʊ���sqh���c�X:�80O^`~���D�l��Gym�ģXpi��7c�T��]��(�;ԬP�lqj���D��,'2���ڍK���80�-'�a�-��7ÐD!xo��!I�b�q��Ƃ�	EI����?���Ɓɬ$�Z����hX�J�P儇8����Y��p�-Nb�(j:9o���V�L'�'���)�#B�Ůq��/��kՋ�X��R8�b/�T�S&Ӥ�C�Xq�8qs�dDq~
~���L�m���Kn�:�h?�q��W�t�4&^��Q��5z�kz|J��8n׬����U��5^��Q[��ia��g�����C����p�8��d3��:?��d��x�}5�}��S�H�1�h��^���Q42�N�I��r�8�gq�P����"!a�5	�ጶ����4�����;��p��h��2�d�b��rl(�+�����1�5d�1�e˿F��a��ɺX��,p LǄ�cQ8�a��'��C򇆁,�u�/%>�6 �����})a1f_��pL�ɾ����ݪK/ٶ)�*9����E�Q��9��z�PwtaM�@=F�;x��7*�����N�`�T(�=T�(D�B=�0�h8P��SĨaN�w[]ޭH�i�%ͺ�$P�>����p��!����[�M����Ț�W�=,�hX�6N+@�p-X7������L�\p`�8���k~�]�E�H`�D��&��qZ���5n�W��x���\��\YCԏ��o�3�������&krq��涖��UvQ�E�ZVr��d1��.A=^*!�3�k!�������Zۿjڢ��6�2��t��Ηk0�V�h.ki��ꨲ�6:������:���u�ù[3˟)��$l�{2��z=�	a8��mr�B}On�̃�<!�������9#Z/ҳ�$Q?\D�;���������!�LDѡ��'����<�I~!�y!IBߊ�l}j��1\ -�,�&�6����΋H�V����Q�zg���Yq9���,��w:&�p<8����+��]\3�d���F���Z�c;�-)\�:�����Cvn���]��`l�p�@���p�x�7J��Jm���j����S+n԰����Tg�������:�ו�ն�Qݓ�P���q+n���V�����܄cLm6��͡�z���~8��b�ӢP|#}ƻPM��7��}�D�J��˼<��iZ������-��7��K-�}�~M�ۤr'/􋹫O�d�NX��^�j�f�E:���ec��$��Q'V�l�1�B����y4n�㰰�v�_a >�+��vp(Ӎ�Iq`,���Eu;��z�֢{�B��T���FU���QEV�ܯp�{����M�*�s�!�����9�k�Q�\�Z4��5�ѝ@q�U�TE���ݩ��~T��y$tɵ�)�}���UO��we�8�1�P��h�`�����:cb^.XC�rQw�}縹���G�[�&���.��bgD�%-��'����e�!��D�ن��w{FbFM����F�&a��	�x]>�̤�G�VݰO�$��F��������*�qSR��%��<9*	YQ7��`J�%��}y��/Brh'?�Z��z��i����%��'���Y4)���S����
�_Z��E�|��za��yȪ�,"����U�k�V�o���Y��Տ��ƟI��u=�]�P�SV7R�废l��YD;JeZq�ŵk�?҇>���	n|�>�����z��"+^D�/���X�xp��I[����^�6'H$nl@W��ċm���6�粀ϙ76p8��6Y%��yj	��ΙL�$�vC�����P���/��Cy�j��?���ߥ�2O��˽��	\���FQ�n�P͐�j*ܨ�0>���'T4�B+n]��+�,X���N���,�T�� �v�����B��p��~��ġ8�*���=��_���NT0���N��w2�x����Nqc��#��� �?׸7Y?z��M2�@>��AV3Z�&��Af���ld�y3���U�}u���/�2+n�X{��CUP�pE��Qa���+A�3S�p�-1�p�&�0�%��t]��CY���'�;�a>AW�3O��r�Xq#��<�b'��I/��\��b��Lj�����Y_�*�}+n��$����<�Ċ��f�\����6�/�L,�++�������{{����ݹ��F���O�\1+n�[���4
ʕ�]���F�U{�_���V	Yqc���YxfɀNO�zܜЭO�t�N���������p1�b+���J�|����Y�      �   �  x�%�ّ�@���q����o��c��4j����6^V\�ۚk���u���u���/¯]�ҟ=���G�E�q����W�M��ӡ��t��3v<?����E {��E �{B,ݒ/�nӓ�n˓$ŉ�<���"��|�B��"]��z��`�HX���X�h^m%ZR�e%Z�׶-ۋ���ˋ�ۋڈ����-�7u-�7%�>oj'Z�7���{Y�V�ȶ���X�V��Z�V��Y�V��gK�����h�|��������W����-Z��mkv�-�z���D�������϶h}}�����.���7���w�m��e[�U��K�վ���m����l������`;P�9H9�ޘ@�w�)�y�ɍN��a�����V��uIM�=\�]�z�N�;�Ul�
��AmB�v�߱q�s�-�����x���t��`���� �h?���d��h�6���!�Ƭ�(�l�_��,���3�3Q��ỉ�
I��'h�����}B66'P���5�*j�_��N���*j�_7�B���U��r�,�ښ(�:6�'�������,6.<:+����c��[������K�[bb>M2�F��r�K�t�Q.56�,G�Ը8��-�ȣV��eh$5ɩ;�u/�Q� �!02�h!5� �!0"�B�C`J$2��L������a*�.w����NLB^���:�y��������|���      �   �   x�u��n� @g���b��j6Y�d�r�K������!E�Z�����{ЪsZ(�h��+������j�F��z@c��[����3\	%E*�I��7J��G��׺�v8�ák�v?l��)�J��u��Ce*�T��l[���x���͜l ��+��+S܈�z��KT�Ɣ����2�'*�֘��	>2�������?�p�_���^Xc~3      �   �   x�-�M�0D���Ы1��6MO~ATP/^�����*��Ea`�����n�e7��j�{�M5��Y>��5Ǡ�����-�f=�}��$���\���\��w���)�ɩ�����SgRW�v)Y,JT (��D�x��N܆�J�X%c�#���t����N#�2�����GE��y5b      �      x�3�4�@�=... �      �      x������ � �      �      x������ � �      �      x������ � �      �      x�3����� Z �      �      x�3�4�4����� �Y      �      x�3�L��2�,K-J����� $u�      �      x�3����� Z �      �      x�3�4�4����� �X      �   F   x�̱ !��\�0�������Il a$4�6M�z��P�Ft�����n����L"b�6�7��x=      �   �   x��ˑEA�53ՠ�'���--��ȰPа���`�Í]������� ��2�n*T�CkxS�>T�_*�u�Z�K*��.��B֨�æ��a�鰃:t؍�t؃zt�^��S���
���6���
kt��zXa��n���?��*�      �   (   x�3�L�L�L��K�y�@2��3#�,�3Ə+F���  	�      �      x������ � �      �      x�3�2�2�2����� �      �   "   x�3�4�4�bN#.cNc i�i�i����� 4yu      �      x������ � �      �      x������ � �      �      x������ � �      �     x�}�Ir�0E��)|������'ȶ���/���b	�T�ʂ�!��H�J�+ɓmMyu&�ϱ>SZ9��I���?��￩�-?�,�!%�˪�����J��7�JZd^�!5��v�Ax�kJT�<r������t��8O�:0p�㋬iO|��R����z�An��=�F���И���m8�En^�R�S���F-i�������Y�G�����:=�u�������H}�������<��Q��|�h�=�����	ă���Jl������Ʈ$6���'���<
XH����������P�C�+b�sӴ�Z�_�3(��?4��|��T�ͳ+��� ��A(��Y�;I�,\�`x�����-9S���5�-��nA(��ʡ|�h�B�P@^�Et&7���ado�U���ɪ�Io�*��m���Gm�5ad���oݟ9��6}��u}�ȜA���:e4�%%��&{�|5�MgX$�Z���<�&��Gg��X(�p�a_�>F�H��Wp��ȅ�@�0>�޾���]0Q4�kڻ��D���z���^��K K�d�Ԟ�nB�JU{0JW�� �C�Z&`�j��|	�}w�=����U&�`�l|���E.*[F�q�|U�^i,=5bsǪł�ϰ$����� m��q�DZhn����o��[ �2\־Nā+֗�b�'W����\���D�����r�.mC�?�m�1�6��@���|l��u�=��`�3���&Z��gA;^���������fQ       �     x�}��n�0����]�<3��K7QK������wƛH>b����
���<�������<�o|�o����l�`~\����</~�����⫧��
%�R ��$�?<1�;3&��LXd4&fEe� �A@E��Z��6_�tH���3m1�5�>�c%�g:_!
M�C�A%r�P�B
�"���r�Ҡ%r��9�h��5i	�#����!Da)r������D/�G�i�⟤E/!�����9k�l�"���&��m��q      �      x�3�4�4�4����� ��      �      x������ � �      �   �   x��˭%A�53j�>ݹ���sU�񊣲!�O��7�����ܼ8��/���7s���G	�O�C���
�b�ZP�jC�עTA��Pjf]�J���>Zp5?��j=��}��9�y���M_��=��/����2\�#�Z�H��ɂT��9��na6R-�9H�l�"�r���r�����&5o      �   <   x�3�t�K��,�P�H���L��4202�50�52V04�21�26г04�)�D\1z\\\ ��S      �      x������ � �      �   J   x�3��I-.��S0T�H�����suu3��?NCN##S]3]#+cK+#=3KS��@������� �nW      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      '   �   x�u�K
�@D�5���3�̜ō†%(��1�&Iצy��M	�S_�O8��@H|C�Q:p�곐%��<�tF1�r�тC���ֺ�w�dr���uU	L�B[.���L}���K_.���+A��6����'3�+��l��2��(e3E�ڥ��5�|��KO      )      x������ � �      �   b  x���kn7����"���Et��F[�M
#E�ݗ�t�� �9�g�CJ��k^>���������/V��I�O��Zw�p��L6P������?߿��o�sH�Z�ӯZ���P���)Yْ�>(aC�.ʇ�A�J>LP�;�J�R�W����<y�A�d�>(Q̡��r6@}P��cx��B}b��U.�c����5����e�"7]�m�l���v�_A�>!�x���?�W�e�O�^�Z:��3f��
X�e�*��Al��V�wm"��^�_~���_�R(�O�+�O�ِ��mh"�+�'��9�pF%g�>I��.�#��P'���Ж�>A}r���߿�����Ir�_~�����y�B��P�����D�=�h9
�vP���AY{n��J�P����Ey�B\��>Qf��)��6�
�
���e����
�K~w9��KT����>��qo��?�7	��UN7�9h��d�(P�撋wk�N����%n���=׹_$��^]r��ꑼ�� u�ד+���#$��%�C_⻛�o	r֖xI�З��Z򛓧��ul���%�9�Z����a�A�����U	��:�ߴl��܄ˣ��]~�a�Or���}���o���¥��%�m�$�_*�^]��n�E9�Z{�����A�Z���S�!}��å���w�1��s;M��K�lr.aVE{n��#xu)�8_��:���9qx��%��c<����x���R�: 7���%1��U>{/k���p)�mZ�˾>d�f�
�攰�l������-��K���%�5��be,��N��KQ����D�/�/����~�^.�qAo2�W�����)J��91u�.ExՓ� ��K�}	�������V��ͥ^���<��6�r9�H~����).��9�������RL��g�ݨ�/�/�ͥ�������gC�*�m�#zu�u���U��7��u��n_9u�ԡx\3��	��%�����>���=�W��K����g� u�.%w�<d�#xu��=�p'�#xu)�}���*-]��R�7pΞ_���^]J�EGXT.'�#���x��ór@E`�(��|Y�LZd�� ]]O�f���E�t��K��7�WqU�]G��R��M[�Fϫ��ե|ӛ|Uz���xs)���㻘Y�f����oz�%�����#xu)���\��j�MG��R��Mo�ы�u o.����ɢ����ե|ӡ��*/��u�.����Ǧž�u�.�YTZUc���Tn�4<�(�� ڋ�����3�/�g�
l��kH� ]M*�C{7��PGlq����aI����ե;����*)MG��R�*aQޖ$����w7R��ÜJ�A�ŵd4l�������L��h�+ʺuD�.��^���C�(�s�^$���\f�-�����J���$;�6+��MɈ-&��v�Q�(��#tu�oا�����2���l>��*�MG��|�OwV�_Z�.�azٮ�����g��K�����p�Ǉ��e�ٲ��z�n:bW���ƴ<�r�uĮ.���i#?�E�w����ƴ�2�@ѫ��mo��n�j�MG��2{{vF�����L��Q�w�HK�[LF�4�ʯΟ�#�����������Ɉ-&�{S�(�A�﩯��e6�M_?��dd�Kr7���Z�9�吗�n2؁��N������c�P?�?����Y�7uf�>B}�.�[�e�<��R�O�zs��<7GTV�y?�]]f��lq�~ԗ��tМ-����6@}I�$S�K��^�<ѡvsɸew>��b��'���l0�>��:��O���ͥϊ��BÚ8      +     x��˕1�M0������c��b�%���qj��2�f#f,��X����hq�W�[������椵�"��SZ��s�H�9��\��=�v�Č$X]m��6ߪ�Ҧ ��ֶǊ9��Jm���9�1��;�[�(*�G� ߒ���c��s,��:�<'�ph���p����� �u'��aR	ū)>]��J��@㺕и�jEp�
f�yh��4Wp<��5<&@� D�&��3ò�� 0yOe�	V̄;����t�H�ɿ篊�;)X
r��KA� ���˂L=M�b�l��/h��!h�<VG͞06�4N�
6���No+�����&���"S]�5<݆���1LMA#�m@��5V�q�x��$� �%����)�ghh��25�7��M2�w��P��И�ݦ�JW�b����{���&\<��F�	`��`���X�[���M`���.�P�������x�-=!'��n��,��gU����o">t(�U��n}{�{�\ߦ���E�?�4��      �   �  x�=�Q�-!D��ż"�^f��xU�dro$�᡻���v���m�u#-Y��AY�ښ�q��06�_�?OZp7�:<�u�|��h��4���c.�x���osa��\E�s�|�B�X�-�|������F��h��c!ZDY��hѢ\E���b��m���vۢm�ۢm�4����6v�m'��-�>�e[�]�m[���\E�{l���,E˅tK�ґa)Zr[���J�L�;%�X��Y��e!�R�l$W��"�R��eG��p܎h�qh'p����I;�^ދw1N��N��4W���;��A-+�j��J�rTX�V��V��F��h��c%Z��"��X����U�������E�vk���a-Zz[���֢u���h}�e-Z���濫�h���E��h=�D�v.Q�]�%J��D�v7.Q���%J�{p��.Q�]&�����%J�;�e#�,�ۈ6�	�&0�F�٘�mslD��)Ѧ0m#�4��h�h3�/�J����_L�z_��b��K�b�s�^��������Ŵ��ż/~�ߎ�_/�X�/��XL�z�_ԀT��N�l��F��,�qd9瓎$�|ޑ�d�O=Ґ���G&�>IFR�� �H�4$%�B�L�w��Ɉ=�$��~2!gyJb�;���w�剉=�8�s{�q��'��S}��VNA��{,gy�b�;��T�~��o�݁      �   {   x�3�(JL.�LNU0�4�4202�50�52Q00�21�20�3��-n��y\�S�8�1U�Y�����b��
4$?O�P��(5�$3/]�%31'?=�M���&���V�&z�03c���� F�1$      �   3   x�3�4�4�L�+�/J�-JM�L��-��K�+)�4�2��5����� i��      �      x�3�4A.#N# m�e�i���b���� 4 m      �      x������ � �      �   �   x�3���|>eŋ�/֯}���dgǋ�[�����c��is��Y�d��M��
9�٩
����FF��f�F
FFV�V&�z��aKC++S=cc#NC L���K--)J��2�n'��+���z�t��=�����)
��Ey�y���X�YZX��hje`�ghi�nc� l T�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x��]{o�6��{�)��?�wy�{7�&@n�f��-�!w�n�j�#��q�5���'9��E5�-��6q���HK$��W�"��ɺ�\��l^�-*��*+�KT��/��M��y�J��5jNO��*/�?�����P���&_LN'v��xҠ����fr���|S\e�����O.�E���AY=_�O֘�w����gO�'�,/�QA+��,�E�)�wU�~{>~S/P�K^��nr�i�6[dmFY"l�1A������"oȯI������!�LV�}�_��*R��d������&~���l��U�X���&�Z t�\�8�ތ�]�����C&��>��"'�[6������T�1�ԩ��ZdM�s�/[�W�4��nר^�M�9h v���55I6�t��0տ�"+�3����:�Qw�*���:��	�_�f��ZA�E��x��e�o��^���ʪN>���z��UF�U'ߣ_�u�*ܟWS�.�i�������J�3���ߠ7������6-�{���< �����1�����CB
���;����g��Ua �W��h�y�uK��弯+
Z������ݓ��W4o�������}Pl[ges�jʚ�	�&<��M�1aƄfL�1a�O��8B�������3~�>T��P�DŅ�Ҹ�*86��X&꒤�9|��x����S'�F#a����1.�b�h����B��F_�4���N����ТV�_�|�uU�N}>0���%�V�\	r%��\�6I�I��Z�.��\s�@�s����!PehF�}SA5�����b���?���$�52��¢�R-���F��l2R�H%#�m�����d��S.��k���8�c�B��K��c�e^-@���8�����mOt�l?�M�'>�PV^Hp�Q�����k�@(g��ԫR���@㫝�{��t�.�l1��%!X���(��:k�?.@��J�D��0k<�`iɁ|b�Z��^�Ţ�=yYv Ƶ��L8�=x��m�X |�S�7����!I�(A���H�{�B{�!e+D:��j�Nvq��� <$��`'D�z��؎h��bT��B�)d�R2H� 2d��>f���E Ϣ*5�������A�DglhC�S���q*�be�����%��,��>���$+����)��&�榪=�^����C���o�;�}x�Ŭ��}�%&�g�Wؕ"}��L�7��KlU�Aɓe1��F<��+O�0Y2<t^T�+J�(�ѳ�vX�/�nZ�����Š�����uI�Cr���qt,��-�h ����n�P�Q�X���#`
�ا��E� !5�q�55�� m������o��,tj!�fj�8uW��B����Y4�3�J��a���~�;y+a���%&����l?�I�r�ȳ����R9*4IK{����~�d����Bͅe�e���4_�g���bǺ��]�b��V�|���тm��1�]h	M24�����躲y:V�h`c��m��j/yVɤ%��5iB!�P2d֤
�������%I��6r̮stc�=l�L+C>X��ӿO�EXfT:������U� %�����|N���۫5�E��Ś��̇��5�'W��	+�c�~ϳ�8��W�$�9۴�?�W�,��+s� /l��2��3���g�yU]u�!��4�m��aG�
򣘸��K���,�
=Zfolk7o���vY�>��7�vyb��T���u�Tm7y��n�>|H�^V�x�/(�M޶D�x5z0�_Q͓���i3,*���T��ɗ�_;[�I��|�5ݯ���|�mn�~�/���|ٷk�K吏���fX��WX�<�*=��|Գ"o��s���(?�bQcNٚW�e�V\e�)�l��v����T�9�W+�����:��?Kj���R�7�>y�-�)�@���;Tv{K� ��v��W'��öj�6�~�̀���ݥ�Ҝ9Wި��1�0������Ȅf��5����8���:�??PV�&.L�Ə&�;M�������;����I�i�V��M���Ӛ�rN'v+V�.��_�^��]�"v�6+):�@fRV'5Z��Nj��i^MX���C3Q�4�.��DX9�XYa��D�����Ot�Āsq�.���ʣ�j�Z�3=�>|}{��c�I+��/^��_J���-~�������m�nH�?�7&4��#ܙ�ttQE�����SGmuD{�l�S�$��/=���WG��#[��J�~��߿�O���/�򪙒g����e�ʄ��'�����5�u�1{9�W��=�3F�~9���>b����]l�ev�H�sr��i�G�L��(Ã5/����
2jt���R�L���(�(}����w�}m�S��e�묜�	v��o�[L}gdR�ħ�0��F�l9.7E��+.���V��f,�O� �,s�����m�+<p9	�M1r".���'Q�y� ��<4��ߐv��	���9��^�7!�ל�r�I.�wb�9a�}ay�b�� ���O_���8��$�F�W��9\J6m���qs�+v�z���3;Cai^w���!0���	F�v�9,|s�!�5x�!���('3�2P^�	��
b0)(M������ix�^_��4���_yW���4$��,��X�5�?7#PțD�K������@�E[_2�l�Ǘ4�ب9�Ū�	�Ho<�d�"k���3>Z��_���F{��R���V�~�W,xc)#&-��C�# $CkTd@�F�s�>�N�!Q�SD�
�t�`�Liѓ�x@�����a�����ǿL����a������A誸}7_�ņ�}����g��+��g��蟴��t&���g/^|�͗_?{���n�T����أ���wF+����3��df��}�f�<��;�4��W�>^�?��噈\s�=A��IӒ��2��v��5��Va��'�#������3-D|�nj=���4���ȧl�d�����J�ä��ǫ4WO�֔T�׺v|�c��%~���i���d��c�Ӛ��Y���{k�5��B����� �V��i�E"^t��	�^
�$���Z��Ķ�r\�8t�v(��	KAA�Jxc:�?�%���`����]h����P0_ 8�~x��Bc=gk���F�G���c�d�i�O���=v��6��2���:*ژ$w%�=�ɫ�xcы�Lk�a�<kc�]U�W�zXʞ�������	|:�g�E^up��#�,N3qf�7#/J2�
��/O������ֈ'*�Pɇ��C��S٧~��e��ư|�}(���N��:Xş�������z�G�]8W�Y�x�O�z}����p�k6���v��C�l���4�2�x� ��E��S}
b��H�It��-���G�:aU�0���x��ª�k�T�'�C6H(��Q��3��z?a�B�r�̗h��)�/��{ƌͫ�`����Ѥ���<�://h$�s�V?.��O�M�կ�ӱ����_8%4 ���x�4q��qw���Q'h��=�bF�j��ѱ:�KN�7y� +�Y�����e[�����	�r��ý�W��$w~?���h��F�m�Z�w'�}���#[~� ��+�8[��\ I�\�?�cO&E_��
M�����kU���@m�Gb��r�5*�A'��)���}��dN�5f5���􀐅�Sڠ��xC�ʵ9�������(r����?����yk<��9~�?��|oTZ���<�ʆce�y��Dk+����?�*o6K
.)���B�W�Ы�xϚ�S�K-�DW+�yG����mٹ����B�ನγ�GR��eʌ�h�r.�ް$�gO�ǒm�����L	Zx�k�m�`�\�y����	Ǡ�_��~ EyJ/''�3���2H�)��dYI��>ޖ~.^�� xJw�[t���\n;q��YN��z'��}�l{���!,�����k�M!��<v����k3���q+�0���4PΤ��*���y'hS�fhX,���JH �6�����M&6��db��5��{Z��l��    ������zջ߯��%͖���s-�����J_P4��O<���"$>�ijcS��EK�y*�S�����;���]�\�W�z�e[�)���@���o�"3�]�ٵ@H0w<l�A�:J��^���!��K�!���ݐ@�v��]'� �>\F��V���:?b��AEےCY�
�N��{ ������A��1�4FQ�v�f�j1��_� �-N�� ��bS'�|N���Mn��Z�����Sm+�t�����!_����z�{�R��1\�`˼��'���v"�#�I����=?��/P����v�cAjѥ�d���#�����O
>)x����UW! �R&�(k�D ${�%��y�yC/�����Q�"ϔ���IWV���/Ҽ��ƨ��p̨��$�~�2=��:���#a̇Ó�l.P�=R#jz��{^�魦��m���ڡ�� Xp�	��9��N8cLl�3��Mj6�������#�!���n�'$�b�.Xu�>�����tͪ���	��I���5#���$�I�����l�<=�9G�e��"��E�Ij%�<Xs��gMc�9cȡ��Q��ٙ�3Eʌ䕿��;��oͳ�	_7��ȍ�މ�p�%�/�m�.�z��a�t	��Y��o��j��3D�e��<_eE�뛺ؽ�u��st�s0�Nu��ɻk���L@:�Tw�<����K����Sa~�v-���)K�c�V�mւӓ�Hb|l9`I�}�a�L��Ht�v8�ЗΌ��5�3Z��SlVĦ|�h�$a�}h�)
�.a��Y�B�Ti5��j�4�yѡu�(-	Q��3�V�~ԩ���Θ=ᐄCI8�1���Q�&;O�3�|M��t6�Ϩf\K9
�RF������M�._�4<�=J��=�O���47o����h�|�ğ]� ���tnmN[6�_sw̅k�v��Z��Sd�KH�+0*6�]���� */R U� tj0)���7�Ƥ�n ����P4�
QԷ	"d3���2ݲ\�Yw���,qD�Hxl4�����=��0�i�c����&K>6w_�M��0�q�����u�b׳l)V�����Ӟs;�X�v��$��3x�#4X-���3<���X��s�ɀ��ǁ�	���<$S:6�2�I�$�s_����!�d��8gW�`���7<��9[�wu��g˪p�dQg��r�vs^�dN$�ae޴�jݨ�IC��N\5ep���;}���� G�~�X�{d�5�p+'��9�w{�dz@oG��gY�Ț�<��N�W��>SId*��S�Ɩ��r��$����F����#�I��$yY+�2���hT^��'�����r���c�n�{%-��u5��ڽc��$6���x��s�s�A�n���]�#��D���1Գ����F0	�$ � L0	�`���"�5��k`�����4�u9Ū#c3ғ�+X6�=e�l�`Ud�W�PW��ǆ�(�G3V����O�ak���!񸄑��fp�;��dg�,�+HA��S���14���LV���Ͼ~��t���>�MFwW�BR�?�9~���<��h*����Ҟ�׳�\'ih����|�>_Ii8�u9�f�����J6N�:y�ڙM	�9��.�ΑO�2��rk-9�f�`'�׵+����ʧ1V�zt3�������ҵu�g��8ʮv�^�lJW�)���Uyy�����
��Q͜�]��{pN{�qd��'�226�4���Rd�@� �������GDn���L1Y�d�E�b�w=t=�}~�?ȉ� j���^y.:����7����w�1gn���ҡj�4���|�T����5l���h�!a٦�I�_ޑs11�QA��1����#V�̘�@Eh�$3dN�w*tk��ߣ)E	��7���U��@ר�*�۔4�2�)Z�ZLP2�H
Ю����M�������V{�㫶��}k�︍�}!~}Ji�'J����|%����KJv;��d���Nv{��$����sv�@9r��Ž��B]8W>�;s����AH`$�F���1�=�Ռҟ��m���gVۃ��g�\B��b3+%��,C)bѕ����^��,_خ�Yp��k4�~����y�c*���͔�ȝ���={��H~gx_�[���MV�6k��+z��
ϟ%����π�2V?�E�]���x��UU,��r��6l���,Ъj��<�P�Z��y��#csT1�>At%�餦���������d_Gn�s����O0p3ׇ��6�H�E��g@�!=�މ�7*�D�J��/;�\ӟ�U�"˩qt�m���w��1�i�2RwwT�!��NJ�h<l�"���Nev��	5�v��mp�S����ۭ�������%����C´M����Bf�F�K�-G�i�;���25�H�~���2RM� �N��KtN�>�M�}���'�ųdtG�����A"�ä#����~�ч�����z��w�b��I2�����&�*,QS�ڲ&߸�YUy�o$�ۋ�y֠Y�o�ڋ�^�젘C,�,�JS3+��32��,���1;�AV�r��b2J(5�����ݧH�
�wb�4�4��MsB��2-��:j��ف#�?���������mZ,�d d�S>L pdl� �&d0Y�d��ez�i,.�:�ۺ΄���U��\%����U���C�+���5�z{p�|��w���,��W�b�X����#��\�MI�ulX�;�9H#��o�$;26G�c�~M
=)��з*���oa;���Q��?�%�U�����^�O;w�Kc�g�:��h$,�K���[M�~�ƙ�D�P��K�F��6=�W��� �1&016Lj�O#((isL�u�1��6���ߪ7u�gGqom���,����4����P�uV_i. w���d���渜�=6�8�Ǥ�ǁ�J�e���H,��2��s�8x�7TakN�r�W�\/���yв�>P�����p������5k���A��jC��=tN&��W2Ӯ�D^��X�~ݔ2m�F���_$�V�*���%�_��d�R?;�&���@֘�Ȳ4�X�UR�I�'���@���A $t�ų� j��V��_������u�]6gh�USY�7��% �
���D~�M��
S�cb����%`3&6Gl\}2X���#TS��kmNl������Vk5S�_Z�0Sm~y_S���Sx�:2 ^ue���9���g���&�ߝ�G���:�uҝ��1h��{+��eѸ(���f}��=�Ƥ�a3)��3M
h�Qu�IQ�=���-"(6��>QDH|�XV��ܓu�:����@��U��7EN���F��m��%�(�|����1�:sw��i�������!V2�f+�f_+L�ΟK;��ݍf�[��bsT�e�G�I�!!��bH���"�����K�$崺˕K�wO�s�������󯟰.�q6gxr`���I�Eh͔�z�Ǔ?���;��K$��Mq������c�?iPVϗ�\`�����>{J"�y)�69���a�0ig�����+}â*��ﾣÃ��((c3�Z#�(Z�a5*EvN��Н�:�|67������}ESR��3�.�l��U�X�hP��
!�z	�Ԥ�v��X��:[S��ԣ˴]%�nA�׈h�m����|�L�W�˼^����R&��`�_�i(�[��Ǽȳ�vF	�V��;M�pN�ӥ�6l���\[��B%��6,<�~�����x����LJ~��P�F���X�r��+*�h8�|���1P��QfO�ߝę7�)�A�Ĳ�߄�EVJ�1���V��6���t�L��>�$��J�z�8��� b$�w;o�i3�
cp�Sa�rQmf�����p����¨UXM�p��_�c^�SI:��*gٱ��(�Y��Ð w�] @
��}F9�?݁Y�e�	�q��6�n���6m�<�����3�����ScV4ؼʲ�jă���r� WY؋S�+�q�F>�Wc��UF�U'ߣ_�R��_���WS�.�i)���7m�G�ߠ
�z� 
  ۿ����hO�S:V�\���d�;a� ���@Dz�};�7n@��,����@M�0�#DHWI��3;����.�D�3��4�x�R9J��CE��M���w����]�VEU�{	��F�FԴ�x��L�g�L����L����}��m�?@ÇM��L'rǉ6���'��o�H'ߜLpс��l�VcC�d�x��l6EQ.������v:xI�Y��H��Wf�1׋c�j� �5�Mq9D��CP �i�Bzj&8�����}_�}���4%l^7�8L�y6�:ߴ-,�Zi�X�F>DK�7��j�1�5��?����Bi��O�kbe2ŋ�$���7��kz����qH�	��H~�	ʁ���fu^fy���8k�����K|�"	I��`9Xc��5�b�0�%Ԅú�0��l���䄴��8S��
�fk�EQ24$����NA�	��Dh���g�A9#�A�L_U����{�T eQ�v�+��$5�� ��`gp��9:�V$3��'�����q�x �}<��-���
�$�p�!�-Q~�ǝ��`P�ᐦW�`F��Q�3ˬ��>�҉�pX��X�.��V��yd��Ff4�������	�Ҏk�kt����a���H9Պ|�A�`�T���T���L �.�U���뭄)��*�ƋA: ��b/�{�U~��&\+�c�4�)�'%���}�=��q݈.�Y�Inj��@��ZQ�\g���
5�	���������yE��_D�4���e�:��}����R��}�v7d��,�˩�en� *����p�i`�OxԂ�^���p6Fh1�@[��I���0\�k�gV�IA9�?���ʆ�E�ы�tj+���gp�*x��`��\�p	�%�0����x���P@�R.\��|���O� �3�S���$\����!'m^����"N����X�H��p�>������%�Ep�S��	tj䃸�>vq�J�p����[�n�ٲ�Ԟ�F�8{�&B8_�Uբ�9|j�V�c�|B#	�$4ҁF��w@��\� ��Ϝ>Wq8ULI�9~,��mZP�u����O�U�f���Y�i�j���"���I�r��m�O��rS��zUͯЂ<l�Sg��Gf ����'b�F��b#oi��xp�y����~�N���r�P����1~��a4��%�0T�P�-J1qݯ+VhM�U�sϼ�M�������J_�Z0�"��S� �@բ�tZT��������,�x��A�/.�P��*+/7�J+���X�Ek ��dO�=�m�6T�qC| �j�<m���) �h��"��u-�\O��_�-*���ǳ�qb8ϊ"���i�e���-Y!N�(Yn#���k��E&�F��b5���������(z����m��Z��9��V ���k���UT�a�Z�Arw���tK�	�>p�'}G��P�oG�2��y���V�l��T�-��g�-�B �F�.��p�E���&���8�_� �-���9į�uS�C���Eh�C��k��
��;V�����9��
>���5�.��q �F>A�)��ƻ���I�9���R��\W jѥU��>3%�<P�����5�a�i�Y{t��=>��j��p�Xt�И�T���7�+�A�.�<�r��(g/��Ӹ|���=TU����5��bY'KE��ڷ�����t@�(����
~EU��+�Jq �L�o�c_�0R8ZRZ�-h�$��ʋ���J�AS���%��@'7�z� ��R�����} ��ʙH\���Jl�S�k�>�3j��ƌ�d��ye�o\0�1*��DY5>��pK�}�F$�>y��ѻ�|)�(��Ke��"���Ż���h�h0�Y.�h���`&��K�L��ЀW"l4K�P���
�W��@��⇻aG�e��^+�0�H,d��F	�S�?����������/�ߑ�`����2����D~      �      x��]K��6>ǿ"����qۙ[*�akS��{�u� �0C�I͌��_�� �՘��C[������&�û��ޔh�bs�߿7	:��ݦ(s�E�>�qP�՟�,��Xl��(	�s���vs �c�o���a���S2���W�9����s|�II)��X7����ϛ�2?�m�OB���B7�t�ˏ��.9��v�����/t�m�sR���psw@q���vCx ��1�ّ����W�D�Q|�=�?�=�M�&��'sF����1�ӄn$���4`���ݧ�åJm�?�m8����(�yѳ��H��U�}l��AB$b��1F�]�E�)J�秨(�4�-�Y@��8v��(��DoFO7B��9�FO	��*��v���q����z�������=��k���c\�>��������o{��?�W�?h_���D��C����������A�Z��D��C�c�&aT6� Ƥ�G4X/�eT��N������r���Nm��-�߲}j4�E1F��J���s�5��t>[ Fs�o�kb��ƥ�a׬h�ޠhLtE���E	�����h����N��xJ��G�\-��L0�+��cDþʡ ��]r`-$���t� v}�
c� F�񌎠��݊�w+�4�B��j`�V�4��w+4&�"�����~��}e�a���k��&�M����ΚiC�- 6#$Nڃ�&�Y��qQ�G�4&�"�¸����D�/;�8:�"C��E��#�7�k6��v�֌0�1����4��pO�J��y\�?����L�1ik
}Sr�A�h���h�+�+	G|���o'��NJ��nv�'d�`k�m��#|�������)"�F[�4�bf����c<�:T�h4��^�X�2'E����HQ����Tm�(�&���̜J�J ��xaU��x!Mm��X ���VdC�C4��j��k�{.p�
���OQHP�&*O9���/AY�=!Зv�Qq���t�`��2�/C��{�7۷ܦ��5Ǐ~
�٤�QX�?8���KDԌ���w�k9X�҂_�i����W6�zߒ���:��#7� �tt�	[���� ]X��z_����@�f�0x�`b����6��6,������0C ���>5-��/����K+(J����8{�8+���}j��vo��0��{'�����+�b�&���29���|]��+!�սf��~H"E(�l�;h�m{�4l�_�qAZ`퉮�C`�[<^3bT��Qr���~i[O�Z}��@��4��"(�ޯ��V^\�Ӝ,��=��'>�irt�(*���������&h1�c���$ĸ(槣㒕��qP��c�=�u�ym����e���i��&�"CUF%�
�O��ڦ�mUg�Ҏ�C�|���p��x�cnwb��cN�3lah?"v�����-��TWdN��D^���_�TP�6II�`�㰅68���G��A���TW�e{�K�A�儞]�٧i�OIp���`�SZ�`��O�����k��ӣ�h��&�"a�`��
�\�OsE��u^���_!�}(�Q_��/�/��?�O�/�j	X��KkD�WriMqEH����l�����-��QU��l�� g[
��VkL�H�5I�WB�����7`��.���|�͜y��퓉}:'Q)Y�S5U���k�W���b��X@ߊS���e����B��\��)�~y*�Py�D�v��X�!�c�%��]�M!c���ԮT���J�Gb�['�F/$��m̐�~
�dt�X�I�`�&?�$���ڠ��Vz����f \��
��_�iz�H��P^�!(2����^��	�]�>p�{��=[��9&Hxל��:����)f���9t�����`5����@���<Ծ�� �7��F��,������)�k���� ���8���L%�Ú;_h��k�-��)K����n�����5<[ڙ�{���MO���r��F-;�z�����';�؝�r�n �+&D���p��s���ԭ���"Ȭ}��aa�˴()�`--~�b� ǺO�"�l_�tq�S�cL|�˚�� �~�2����+�������]���˚Ϡ�>:e1�X>z.�W\h�e��WF?���V�Gy��,M���>�6v=?GqDd�=Pg7M�<���+��ܹ\>�Չ���c�'�8JxG���c�l��������
�s��l{��N�?/dR�z0�;`U����&�*���R��o1��?����?����Jkh�WVY�ze�4�I���k�b&�}�/=�bl�j����
��.bϬ��ă:�L���UÚy̴�U fN����ZD�%d5HYhRXs-�o��d�Hq�B��]2��6�L�
݈ӎ�(��U��Y�������>���Y�,��{�Re�&o��	?�J���"s�8i��K4�Ed�(�þ8��K-D��	�>a#�Ϥ �b �r$f��Ɓ;I6,ݙt5���T�T�,���*9>��%�� ;�]���®]��1��C�%9������c���.rW�1�4��y�Fe���-m4E;f�E�1�y���A݉E�m�P��6#E�k�f�(uk'�{�K� �����Ҙ*�����S��Q7��k,wfyC���Y�WS_v`T��"��,��0�Y�����m:��B2���h��F�M��ټ $�]D�%��oʔ��1ظ	U���द�(�
����h]���n.�G�p��\�j�OC��O�V����b�TVj�\��ި�"�}��>����2m(U��꧀&���	,��uJˣ��r�k�t���G����{T��U�rR!}�*��A֙�%U���}܂G�<���39o~�&S�~,0�;m��J��j6��ʠU�#�KS�ᚃ��d3��YW���M�xe5�� �V"�/��A����L��}~�I\�;�XH�c5V�6�m�]g��B�Dl`���D<�qL�[Lr2l��!#,nHR�@�A9,1��&
+�OT6Dq@uO)��>���BP��D_��e�e�Gbt����$pgN^~��/}�"��:�"�m[M��
�fK|% ���M�N!;3#���i�(�e�N�2��]����1kMǴ�P�?Ə89=����?߁�[Ib���a��6|&��a���h-�U8��-Z���_P:�|&�ȹ���b|��)ˠ#3�H/w]��x�ZD����V��6��0��6+zM� �ptP�>vuJK�1�*�H'VԽ�ń�?�6fA����5�L�#��Q��f�׼Ī�0�EZ<7��B�	�-�� ��r��pXF&�WD�!�E������jqk&u����\��a,N��u3̦�!���2�.[7���G�f ru3l����g!�;j���Ŕ�$�(m�J�f&bs�u3S�t�����L�k!ɔ��.E���He�X��5u�3�[���kW�����%�x_;�Kg�]C���9q��뎊��u�����UoOj(_���쵞`w��\�l:S��W�5���Y�1�l0�8�kiYH�O��fv�p֑I�e���%�p�&�E=�aD!{�CkY����E:髃0��
4�[����L�J�����LPԶT��f��¢��b\�v{��H~��Zڐ�45���zC�V\A�5�[�!@̈́�Pc�9=�휶����:m_G{y-Õ��Z���
��q�j"��7OѲ� ��>M¨�D�OqZK��r;�Y��F��2sDN�uQ��ŲZK��*_��5��f.�Ҟ���F�5*&:)C�m�+�wũ/�nkm�W�ׯܓ�8��D&������4^kvES�p� <"��i\�{&#U�	�_{�Z7d��ZK��*���_^��L��9]e5g/r�QRW&���#'��R>��kb"�Ձ��_s����q%�,�w��A#�Ѭ�Q�D �
#0R\]�8�<^�ܼ���`$��X�gM*�!]I�b�R�/��!�i� E  [ 3�^��z�kS1��;�`���\��l�V#ڊ	;��Jެ7��(Dv3��T�B�WMG�+r���	k��z����m ���C2j�7���H�AAI"4�h���N��Gb/) ���GbT]rz�3'/	?jѕ)�� ��6��[=2͖�J ꑈ�.M��&V˙$������,11;��f�]��Z}����1X��%[I|3���oآ-��h(���ѣ���3��@̋�t�����u ڛeylk������.�3����kz}K����u^���(���ws���ʐ54�"}i��_�[�kz�6tض��Z3m1m�W�	��y8L"<��v�#&~µc$�ר/�e0��)k�dz!�w/��$^��ْS�R�^&du<�����Ҝp:�Xd�����c���Z=�F��)��ĉ���4�u�"���݌]'���>�-['�!y��9�H��h�E����k������u�=0Y2W�(���?j壢J�S��G��P>1�[JKYZ��G��9�6���TY��HB�W�D�+ӂ҆S\����{�Q�]�Ԏq��C���QTY6�EL���kq���q�.WO�wj�B �D�o�,b�����i�eC�}&I����&h2��X۱u��� k��Jk[����Q�S	l�E�R@�',.�7 ,.��?"R��3�������
t	Xt�ը^���Ս�/a�7K�L���v����D�5�^}�W���m@����Woo������on�}}{{������oon��������-�����ớ�o�ͻ|x����ۛ��7���͛7���[�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�u�1
�0Eg����%Un��:u��	^���'�).���$�Cs�R��\��f;�C7]����U�����xH�=���������6M�s�e�&#�t�l_/����ϝ@���DE>������9�             x������ � �            x�3�4�4����� �Z           x���ώ�0�ϛ�����ת=��U{�e/�8�Ub"��J}�����W��I��x�ctw��G�8����"�Y#ke@������Lw�lQƓ�c^���l�rqmN���esCY��{<	��>��Ca�s��+���(�\��S�R����+%�@Z�i�^�g!�j���6��7cDlk�+.��CU�SY�=���߫�s�-b"N)�$����k�sf�f�z�� k���Ӕ'��yu�g�͚m�p���Ww�܏-��� �g��!��g��g��.�J��X|YY��[�>�'���$��r�8I���Dw|���E%�uǐC�!�1��8x��
u�c~��`���~埕�
N����U}o����-n��
2ʼ�g~������<|��g��m#vJ|�{��y����3��ֶ ۣ�ixԻ���3�s���N�idi'�A��]Q�Iͼ���i����� +Fma����t ��������$� �SbB�P����/ٜzm�L��RF����^I�0�V��<��1i����yu�|��IA0�!�O��u=�����/������#*��0:�*�������^~c&~dD���J^1��sЈd�t\�l@��$��	��"����ƃ�[�X�0E�G�X8\��udq ����'����e|q��;��[��U�2?6Θi�8���� �?�80��������R� �n\;j��RrQ״F�Tv���}�o4����ԡ��'�1�f��X�V�         �   x�5�[B!���b�����á�H2G���;1�GZi�+qXe *Y�p*7v����\�"�e�S⮫��)����.Jy����<�X��(Dy�R�W�g�04�x�[e�M���8��j4�P��4a��c��Ԃ��.���<��ȴ�d��T�6����f��l&|6٭6�0�4�m=�@X�b41���&ߓ6M���ޅ�)��y���iMv�&���!Gs#��%ߏ�� �LO3         �   x�u�A
�0�ur��@�̤6mv�k� ��5P�RϯbA�
�����P�C��.�}2����!A�$_�5�{��	�-�ZL�	#o֊�u�u5�Yz����U�q��j�ퟑ$�ߗ�5��[ձ�΀�K'�m����R> Y>E9      
     x�u�[��0��k�^xkm9�8x�誙��E�C������캑�k��I�'�IL�nD�������'�!b��OZ�>"i?V�u�e�Iȥj���bp�ϋ��j�n}���V辕���}:_�s>�C^jC��+M^� �x k�����C��$��M�!�TR?��1޲>w���%��В�$Ǟ�éoʿ�Wn�4�!Ȋ���&�5	k"���4�KhUd4E]z!�)�߲��[,�jse��Z�(IY�������:��� {ǈ*IAv�����p�6DM��&M⁌����"�4I�]��7e,�����Ż�f���i�ި��PW�4�w�l�l%p6�tf�b���JwUR��o�I"�P��O/�r�\�����/J�ٖ�/
�YK��PAr�V�ȷ~8����z6c�V���(U	�� ���u���9�u���_D�|��Fb8�TF���4��{�6�8�&���%-o����j��ߋx��) A\��O�h4� ZHF            x�3�4�4�4�� �f\1z\\\ ��            x������ � �            x������ � �      -   �   x�u��
�0@��W�\hҴ��zv��V��U����^ܡx��Agu^ʺ|rQdȍ&�D�IA��6Κ*O�\�7�K~���Ӻ�XЋc ������i��Q�
�L]�j�����e`w}�#h��(:?      /   '   x��1 0İ���'Y¥�qT
a-�\�&qR��~CA         b   x�3��TH�UH���KW(�W(N�����r����8�uL|6��钕O�v?���t���M�FF��f�F
F�V��V��z&f���05�+F��� �^$�            x�3�4A�=... ��            x������ � �      3      x������ � �         �  x�u��n�V���~
�@�}��!U�*����83N��G�'�^!(� )H��6!%%m��L�*��t����-������\�����Z{St>y��1A�^<�ar�s�Ԉ���R7�tKcԑ�#��8E��h��34}��8z�n}��9G�F�,!tj�N�h���(�ۿxy��h^?�,K������آ�zX���/��m,Nf�-;���FQ��%*����0�@:���x�^�7\������ufR7���K���2�=z��?��l�B�v�%�����Z(��8���c!�f��쒫�y	�Lt�|<��lEY5u�yM�.H��V��;n{w�#7�cH>;~�}h� O���x̡��/�Şbj���C�w$*���)и�3b��yw3����t�2�>m�1ӡD���2GB݄(i�h0�^�����I1��5:�����C��y]ύ1���Q�~�%�L���˞�����v�fGk�a�A�R/a�]�8Ҋ��v8��mQO�ү��;P1&P��$�4p�!T:��;��_��$��v����"��A8���)��%.qS?���}Z�N'������e�N�J8vG}�Բ�|�Y��p��"��9ѩ�<�?��%s���W����ɋ&�o�mK�g3�fM\�V�c �����Z���t/����(�fL�>��%QM�A����1LP�~0}~6][i�I�@X'�I� ��@g�3�q��RGXv/���dP�k{�f�'~�������'b*�PQ�!���O��m/�03���=�ւ��L8j����l��EL�XM���˶�!��bp�5���	���[ֵ��z=/IF��h�����V�@�lw6��Cs*� �{�w���V�ʊ6it��MXUƛQ��(��z��X٘ޯ_���1T|mA
n7V"��m�l�i19k��!��DSߥW�xx˾z�����Cpx�ȯ�;���zE��rw�� `�խ�Ż�w.Oeo�e�^R�
�h�rf\)�7�g�'��O���bk��7f��A��K��~h���>ls��_�Ż��Mv�Mg���S/�_��Ks�8Z�OsC�y�܁��Z�� ��01i���g�z�^~�[w�K�j�MF��`������OO/�W���_P�p�������N�Ww�RԻ퇋Z�SVgm#ߟ���I��1C�n�.��ހ'`�G�6�7N�-c�?�:\            x�3�4A�=... ��            x������ � �      1   �   x�����0Bѵ)f�%�{���1���s-{�k/b�!��w���'cpߌ�wփ\��z�[��6�Z��b�K�$�i:�xj�F@5�AD5�!��TS|�mq#������Aݚ��nMBP�&#�[� �[Ӎ�nM��5�:�i#账��Ӛ/��L��,������w1�      5      x������ � �      9      x������ � �      7      x������ � �      ;   4   x�3�HLOU0�4�4202�50�50S04�2��26�357�)������ ˚�      ?   9   x�3�4�46�L�+-N-�-�/J�-JM�L��-��K�+)�4�2�1ŧƈ+F��� }��      =      x������ � �         �   x�3�L��|�8��YCߓ�/�o�,K-J�LK�����K��I�4202�50�5�T00�22�2��3�4B74�21�22�346�4��<N��Ғ��.#����lΧۗ>�;�ZH<�1����/�7�X���?�m�d�����1��&VF�z�&�Vrf����s>ٻ��ҽ�Ov4��X�s���O'�y��"�����P�1�6�22ҳ00ô�� hv��qqq tvB         @   x�3�4�4�L�+K-J��M-I����,c.C��P�$1='���HsrA5�q��qqq �@�      !      x������ � �      $      x������ � �     