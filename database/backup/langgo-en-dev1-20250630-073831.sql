PGDMP         &                }           langgo-en-dev1    14.18    14.18 (Homebrew) R   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    57374    langgo-en-dev1    DATABASE     d   CREATE DATABASE "langgo-en-dev1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF8';
     DROP DATABASE "langgo-en-dev1";
                strapi    false            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   cloudsqlsuperuser    false    3            �            1259    57375    admin_permissions    TABLE     g  CREATE TABLE public.admin_permissions (
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
       public         heap    strapi    false            �            1259    57380    admin_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.admin_permissions_id_seq;
       public          strapi    false    209            �           0    0    admin_permissions_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;
          public          strapi    false    210            �            1259    57381    admin_permissions_role_links    TABLE     �   CREATE TABLE public.admin_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);
 0   DROP TABLE public.admin_permissions_role_links;
       public         heap    strapi    false            �            1259    57384 #   admin_permissions_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.admin_permissions_role_links_id_seq;
       public          strapi    false    211            �           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;
          public          strapi    false    212            �            1259    57385    admin_roles    TABLE     ;  CREATE TABLE public.admin_roles (
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
       public         heap    strapi    false            �            1259    57390    admin_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_roles_id_seq;
       public          strapi    false    213            �           0    0    admin_roles_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;
          public          strapi    false    214            �            1259    57391    admin_users    TABLE     B  CREATE TABLE public.admin_users (
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
       public         heap    strapi    false            �            1259    57396    admin_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_users_id_seq;
       public          strapi    false    215            �           0    0    admin_users_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;
          public          strapi    false    216            �            1259    57397    admin_users_roles_links    TABLE     �   CREATE TABLE public.admin_users_roles_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_order double precision,
    user_order double precision
);
 +   DROP TABLE public.admin_users_roles_links;
       public         heap    strapi    false            �            1259    57400    admin_users_roles_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_users_roles_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.admin_users_roles_links_id_seq;
       public          strapi    false    217            �           0    0    admin_users_roles_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;
          public          strapi    false    218            �            1259    57401    components_a_external_videos    TABLE     �   CREATE TABLE public.components_a_external_videos (
    id integer NOT NULL,
    url character varying(255),
    caption character varying(255)
);
 0   DROP TABLE public.components_a_external_videos;
       public         heap    strapi    false            �            1259    57406 #   components_a_external_videos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_external_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.components_a_external_videos_id_seq;
       public          strapi    false    219            �           0    0 #   components_a_external_videos_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.components_a_external_videos_id_seq OWNED BY public.components_a_external_videos.id;
          public          strapi    false    220            �            1259    57407    components_a_pagebreakers    TABLE     {   CREATE TABLE public.components_a_pagebreakers (
    id integer NOT NULL,
    backbutton boolean,
    nextbutton boolean
);
 -   DROP TABLE public.components_a_pagebreakers;
       public         heap    strapi    false            �            1259    57410     components_a_pagebreakers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_pagebreakers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.components_a_pagebreakers_id_seq;
       public          strapi    false    221            �           0    0     components_a_pagebreakers_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.components_a_pagebreakers_id_seq OWNED BY public.components_a_pagebreakers.id;
          public          strapi    false    222            �            1259    57411    components_a_quizzes    TABLE     �   CREATE TABLE public.components_a_quizzes (
    id integer NOT NULL,
    question character varying(255),
    options jsonb,
    answer character varying(255),
    explanation character varying(255)
);
 (   DROP TABLE public.components_a_quizzes;
       public         heap    strapi    false            �            1259    57416    components_a_quizzes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.components_a_quizzes_id_seq;
       public          strapi    false    223            �           0    0    components_a_quizzes_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.components_a_quizzes_id_seq OWNED BY public.components_a_quizzes.id;
          public          strapi    false    224            �            1259    57417    components_a_sent_refs    TABLE     H   CREATE TABLE public.components_a_sent_refs (
    id integer NOT NULL
);
 *   DROP TABLE public.components_a_sent_refs;
       public         heap    strapi    false            �            1259    57420    components_a_sent_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_sent_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.components_a_sent_refs_id_seq;
       public          strapi    false    225            �           0    0    components_a_sent_refs_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.components_a_sent_refs_id_seq OWNED BY public.components_a_sent_refs.id;
          public          strapi    false    226            �            1259    57421 %   components_a_sent_refs_sentence_links    TABLE     �   CREATE TABLE public.components_a_sent_refs_sentence_links (
    id integer NOT NULL,
    sent_ref_id integer,
    sentence_id integer
);
 9   DROP TABLE public.components_a_sent_refs_sentence_links;
       public         heap    strapi    false            �            1259    57424 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_sent_refs_sentence_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.components_a_sent_refs_sentence_links_id_seq;
       public          strapi    false    227            �           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.components_a_sent_refs_sentence_links_id_seq OWNED BY public.components_a_sent_refs_sentence_links.id;
          public          strapi    false    228            �            1259    57425    components_a_taglists    TABLE     g   CREATE TABLE public.components_a_taglists (
    id integer NOT NULL,
    tag character varying(255)
);
 )   DROP TABLE public.components_a_taglists;
       public         heap    strapi    false            �            1259    57428    components_a_taglists_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_taglists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.components_a_taglists_id_seq;
       public          strapi    false    229            �           0    0    components_a_taglists_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.components_a_taglists_id_seq OWNED BY public.components_a_taglists.id;
          public          strapi    false    230            �            1259    57429    components_a_user_sent_refs    TABLE     M   CREATE TABLE public.components_a_user_sent_refs (
    id integer NOT NULL
);
 /   DROP TABLE public.components_a_user_sent_refs;
       public         heap    strapi    false            �            1259    57432 "   components_a_user_sent_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_sent_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.components_a_user_sent_refs_id_seq;
       public          strapi    false    231            �           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.components_a_user_sent_refs_id_seq OWNED BY public.components_a_user_sent_refs.id;
          public          strapi    false    232            �            1259    57433 /   components_a_user_sent_refs_user_sentence_links    TABLE     �   CREATE TABLE public.components_a_user_sent_refs_user_sentence_links (
    id integer NOT NULL,
    user_sent_ref_id integer,
    user_sentence_id integer
);
 C   DROP TABLE public.components_a_user_sent_refs_user_sentence_links;
       public         heap    strapi    false            �            1259    57436 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 M   DROP SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq;
       public          strapi    false    233            �           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.components_a_user_sent_refs_user_sentence_links_id_seq OWNED BY public.components_a_user_sent_refs_user_sentence_links.id;
          public          strapi    false    234            �            1259    57437    components_a_user_word_refs    TABLE     M   CREATE TABLE public.components_a_user_word_refs (
    id integer NOT NULL
);
 /   DROP TABLE public.components_a_user_word_refs;
       public         heap    strapi    false            �            1259    57440 "   components_a_user_word_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_word_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.components_a_user_word_refs_id_seq;
       public          strapi    false    235            �           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.components_a_user_word_refs_id_seq OWNED BY public.components_a_user_word_refs.id;
          public          strapi    false    236            �            1259    57441 +   components_a_user_word_refs_user_word_links    TABLE     �   CREATE TABLE public.components_a_user_word_refs_user_word_links (
    id integer NOT NULL,
    user_word_ref_id integer,
    user_word_id integer
);
 ?   DROP TABLE public.components_a_user_word_refs_user_word_links;
       public         heap    strapi    false            �            1259    57444 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq;
       public          strapi    false    237            �           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.components_a_user_word_refs_user_word_links_id_seq OWNED BY public.components_a_user_word_refs_user_word_links.id;
          public          strapi    false    238            �            1259    57445    components_a_verb_metas    TABLE     @  CREATE TABLE public.components_a_verb_metas (
    id integer NOT NULL,
    simple_past character varying(255),
    past_participle character varying(255),
    present_participle character varying(255),
    thirdperson_singular character varying(255),
    auxiliary_verb character varying(255),
    conjugations jsonb
);
 +   DROP TABLE public.components_a_verb_metas;
       public         heap    strapi    false            �            1259    57450    components_a_verb_metas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_verb_metas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.components_a_verb_metas_id_seq;
       public          strapi    false    239            �           0    0    components_a_verb_metas_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.components_a_verb_metas_id_seq OWNED BY public.components_a_verb_metas.id;
          public          strapi    false    240            �            1259    57451    components_a_videos    TABLE     E   CREATE TABLE public.components_a_videos (
    id integer NOT NULL
);
 '   DROP TABLE public.components_a_videos;
       public         heap    strapi    false            �            1259    57454    components_a_videos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.components_a_videos_id_seq;
       public          strapi    false    241            �           0    0    components_a_videos_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.components_a_videos_id_seq OWNED BY public.components_a_videos.id;
          public          strapi    false    242            �            1259    57455    components_a_word_refs    TABLE     H   CREATE TABLE public.components_a_word_refs (
    id integer NOT NULL
);
 *   DROP TABLE public.components_a_word_refs;
       public         heap    strapi    false            �            1259    57458    components_a_word_refs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_word_refs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.components_a_word_refs_id_seq;
       public          strapi    false    243            �           0    0    components_a_word_refs_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.components_a_word_refs_id_seq OWNED BY public.components_a_word_refs.id;
          public          strapi    false    244            �            1259    57459 !   components_a_word_refs_word_links    TABLE     �   CREATE TABLE public.components_a_word_refs_word_links (
    id integer NOT NULL,
    word_ref_id integer,
    word_id integer
);
 5   DROP TABLE public.components_a_word_refs_word_links;
       public         heap    strapi    false            �            1259    57462 (   components_a_word_refs_word_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_word_refs_word_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.components_a_word_refs_word_links_id_seq;
       public          strapi    false    245            �           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.components_a_word_refs_word_links_id_seq OWNED BY public.components_a_word_refs_word_links.id;
          public          strapi    false    246            �            1259    57463    files    TABLE     �  CREATE TABLE public.files (
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
       public         heap    strapi    false            �            1259    57468    files_folder_links    TABLE     �   CREATE TABLE public.files_folder_links (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_order double precision
);
 &   DROP TABLE public.files_folder_links;
       public         heap    strapi    false            �            1259    57471    files_folder_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_folder_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.files_folder_links_id_seq;
       public          strapi    false    248            �           0    0    files_folder_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;
          public          strapi    false    249            �            1259    57472    files_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.files_id_seq;
       public          strapi    false    247            �           0    0    files_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;
          public          strapi    false    250            �            1259    57473    files_related_morphs    TABLE     �   CREATE TABLE public.files_related_morphs (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.files_related_morphs;
       public         heap    strapi    false            �            1259    57478    files_related_morphs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_related_morphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.files_related_morphs_id_seq;
       public          strapi    false    251            �           0    0    files_related_morphs_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;
          public          strapi    false    252            �            1259    57479 
   flashcards    TABLE     �  CREATE TABLE public.flashcards (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    last_reviewed_at timestamp(6) without time zone,
    daily_streak integer,
    weekly_streak integer,
    weekly_wrong_streak integer,
    monthly_streak integer,
    monthly_wrong_streak integer,
    is_remembered boolean
);
    DROP TABLE public.flashcards;
       public         heap    strapi    false            �            1259    57482    flashcards_components    TABLE     �   CREATE TABLE public.flashcards_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 )   DROP TABLE public.flashcards_components;
       public         heap    strapi    false            �            1259    57487    flashcards_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.flashcards_components_id_seq;
       public          strapi    false    254            �           0    0    flashcards_components_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_components_id_seq OWNED BY public.flashcards_components.id;
          public          strapi    false    255                        1259    57488    flashcards_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.flashcards_id_seq;
       public          strapi    false    253            �           0    0    flashcards_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;
          public          strapi    false    256                       1259    57489    flashcards_lesson_links    TABLE     �   CREATE TABLE public.flashcards_lesson_links (
    id integer NOT NULL,
    flashcard_id integer,
    lesson_id integer,
    flashcard_order double precision
);
 +   DROP TABLE public.flashcards_lesson_links;
       public         heap    strapi    false                       1259    57492    flashcards_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.flashcards_lesson_links_id_seq;
       public          strapi    false    257            �           0    0    flashcards_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.flashcards_lesson_links_id_seq OWNED BY public.flashcards_lesson_links.id;
          public          strapi    false    258                       1259    57493    flashcards_localizations_links    TABLE     �   CREATE TABLE public.flashcards_localizations_links (
    id integer NOT NULL,
    flashcard_id integer,
    inv_flashcard_id integer,
    flashcard_order double precision
);
 2   DROP TABLE public.flashcards_localizations_links;
       public         heap    strapi    false                       1259    57496 %   flashcards_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.flashcards_localizations_links_id_seq;
       public          strapi    false    259            �           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.flashcards_localizations_links_id_seq OWNED BY public.flashcards_localizations_links.id;
          public          strapi    false    260                       1259    57498    flashcards_user_links    TABLE     �   CREATE TABLE public.flashcards_user_links (
    id integer NOT NULL,
    flashcard_id integer,
    user_id integer,
    flashcard_order double precision
);
 )   DROP TABLE public.flashcards_user_links;
       public         heap    strapi    false                       1259    57501    flashcards_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flashcards_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.flashcards_user_links_id_seq;
       public          strapi    false    261            �           0    0    flashcards_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.flashcards_user_links_id_seq OWNED BY public.flashcards_user_links.id;
          public          strapi    false    262                       1259    57502    i18n_locale    TABLE       CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.i18n_locale;
       public         heap    strapi    false                       1259    57507    i18n_locale_id_seq    SEQUENCE     �   CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.i18n_locale_id_seq;
       public          strapi    false    263            �           0    0    i18n_locale_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;
          public          strapi    false    264            	           1259    57508    lessonlevels    TABLE       CREATE TABLE public.lessonlevels (
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
           1259    57513    lessonlevels_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessonlevels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.lessonlevels_id_seq;
       public          strapi    false    265            �           0    0    lessonlevels_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.lessonlevels_id_seq OWNED BY public.lessonlevels.id;
          public          strapi    false    266                       1259    57514    lessons    TABLE     p  CREATE TABLE public.lessons (
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
       public         heap    strapi    false                       1259    57519    lessons_components    TABLE     �   CREATE TABLE public.lessons_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 &   DROP TABLE public.lessons_components;
       public         heap    strapi    false                       1259    57524    lessons_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.lessons_components_id_seq;
       public          strapi    false    268            �           0    0    lessons_components_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_components_id_seq OWNED BY public.lessons_components.id;
          public          strapi    false    269                       1259    57525    lessons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.lessons_id_seq;
       public          strapi    false    267            �           0    0    lessons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;
          public          strapi    false    270                       1259    57526    lessons_lessonlevel_links    TABLE     �   CREATE TABLE public.lessons_lessonlevel_links (
    id integer NOT NULL,
    lesson_id integer,
    lessonlevel_id integer,
    lesson_order double precision
);
 -   DROP TABLE public.lessons_lessonlevel_links;
       public         heap    strapi    false                       1259    57529     lessons_lessonlevel_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_lessonlevel_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.lessons_lessonlevel_links_id_seq;
       public          strapi    false    271            �           0    0     lessons_lessonlevel_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.lessons_lessonlevel_links_id_seq OWNED BY public.lessons_lessonlevel_links.id;
          public          strapi    false    272                       1259    57530    lessons_localizations_links    TABLE     �   CREATE TABLE public.lessons_localizations_links (
    id integer NOT NULL,
    lesson_id integer,
    inv_lesson_id integer,
    lesson_order double precision
);
 /   DROP TABLE public.lessons_localizations_links;
       public         heap    strapi    false                       1259    57533 "   lessons_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.lessons_localizations_links_id_seq;
       public          strapi    false    273            �           0    0 "   lessons_localizations_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.lessons_localizations_links_id_seq OWNED BY public.lessons_localizations_links.id;
          public          strapi    false    274                       1259    57534    lessons_unit_links    TABLE     �   CREATE TABLE public.lessons_unit_links (
    id integer NOT NULL,
    lesson_id integer,
    unit_id integer,
    lesson_order double precision
);
 &   DROP TABLE public.lessons_unit_links;
       public         heap    strapi    false                       1259    57537    lessons_unit_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_unit_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.lessons_unit_links_id_seq;
       public          strapi    false    275            �           0    0    lessons_unit_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lessons_unit_links_id_seq OWNED BY public.lessons_unit_links.id;
          public          strapi    false    276                       1259    57538 
   reviewlogs    TABLE     D  CREATE TABLE public.reviewlogs (
    id integer NOT NULL,
    reviewd_at timestamp(6) without time zone,
    level character varying(255),
    result character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.reviewlogs;
       public         heap    strapi    false                       1259    57543    reviewlogs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.reviewlogs_id_seq;
       public          strapi    false    277            �           0    0    reviewlogs_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.reviewlogs_id_seq OWNED BY public.reviewlogs.id;
          public          strapi    false    278                       1259    57544    reviewlogs_user_links    TABLE     �   CREATE TABLE public.reviewlogs_user_links (
    id integer NOT NULL,
    reviewlog_id integer,
    user_id integer,
    reviewlog_order double precision
);
 )   DROP TABLE public.reviewlogs_user_links;
       public         heap    strapi    false                       1259    57547    reviewlogs_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewlogs_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.reviewlogs_user_links_id_seq;
       public          strapi    false    279            �           0    0    reviewlogs_user_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.reviewlogs_user_links_id_seq OWNED BY public.reviewlogs_user_links.id;
          public          strapi    false    280                       1259    57548    sections    TABLE     (  CREATE TABLE public.sections (
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
       public         heap    strapi    false                       1259    57553    sections_components    TABLE     �   CREATE TABLE public.sections_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 '   DROP TABLE public.sections_components;
       public         heap    strapi    false                       1259    57558    sections_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.sections_components_id_seq;
       public          strapi    false    282            �           0    0    sections_components_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.sections_components_id_seq OWNED BY public.sections_components.id;
          public          strapi    false    283                       1259    57559    sections_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sections_id_seq;
       public          strapi    false    281            �           0    0    sections_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;
          public          strapi    false    284                       1259    57560    sections_lesson_links    TABLE     �   CREATE TABLE public.sections_lesson_links (
    id integer NOT NULL,
    section_id integer,
    lesson_id integer,
    section_order double precision
);
 )   DROP TABLE public.sections_lesson_links;
       public         heap    strapi    false                       1259    57563    sections_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sections_lesson_links_id_seq;
       public          strapi    false    285            �           0    0    sections_lesson_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sections_lesson_links_id_seq OWNED BY public.sections_lesson_links.id;
          public          strapi    false    286                       1259    57564    sections_localizations_links    TABLE     �   CREATE TABLE public.sections_localizations_links (
    id integer NOT NULL,
    section_id integer,
    inv_section_id integer,
    section_order double precision
);
 0   DROP TABLE public.sections_localizations_links;
       public         heap    strapi    false                        1259    57567 #   sections_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sections_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.sections_localizations_links_id_seq;
       public          strapi    false    287            �           0    0 #   sections_localizations_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.sections_localizations_links_id_seq OWNED BY public.sections_localizations_links.id;
          public          strapi    false    288            !           1259    57568 	   sentences    TABLE     �  CREATE TABLE public.sentences (
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
       public         heap    strapi    false            "           1259    57573    sentences_components    TABLE     �   CREATE TABLE public.sentences_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.sentences_components;
       public         heap    strapi    false            #           1259    57578    sentences_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.sentences_components_id_seq;
       public          strapi    false    290            �           0    0    sentences_components_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sentences_components_id_seq OWNED BY public.sentences_components.id;
          public          strapi    false    291            $           1259    57579    sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sentences_id_seq;
       public          strapi    false    289            �           0    0    sentences_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;
          public          strapi    false    292            %           1259    57580    sentences_localizations_links    TABLE     �   CREATE TABLE public.sentences_localizations_links (
    id integer NOT NULL,
    sentence_id integer,
    inv_sentence_id integer,
    sentence_order double precision
);
 1   DROP TABLE public.sentences_localizations_links;
       public         heap    strapi    false            &           1259    57583 $   sentences_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.sentences_localizations_links_id_seq;
       public          strapi    false    293            �           0    0 $   sentences_localizations_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.sentences_localizations_links_id_seq OWNED BY public.sentences_localizations_links.id;
          public          strapi    false    294            '           1259    57584    strapi_api_token_permissions    TABLE       CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 0   DROP TABLE public.strapi_api_token_permissions;
       public         heap    strapi    false            (           1259    57587 #   strapi_api_token_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.strapi_api_token_permissions_id_seq;
       public          strapi    false    295            �           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;
          public          strapi    false    296            )           1259    57588 (   strapi_api_token_permissions_token_links    TABLE     �   CREATE TABLE public.strapi_api_token_permissions_token_links (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_order double precision
);
 <   DROP TABLE public.strapi_api_token_permissions_token_links;
       public         heap    strapi    false            *           1259    57591 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 F   DROP SEQUENCE public.strapi_api_token_permissions_token_links_id_seq;
       public          strapi    false    297            �           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;
          public          strapi    false    298            +           1259    57592    strapi_api_tokens    TABLE     �  CREATE TABLE public.strapi_api_tokens (
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
       public         heap    strapi    false            ,           1259    57597    strapi_api_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.strapi_api_tokens_id_seq;
       public          strapi    false    299            �           0    0    strapi_api_tokens_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;
          public          strapi    false    300            -           1259    57598    strapi_core_store_settings    TABLE     �   CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);
 .   DROP TABLE public.strapi_core_store_settings;
       public         heap    strapi    false            .           1259    57603 !   strapi_core_store_settings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.strapi_core_store_settings_id_seq;
       public          strapi    false    301            �           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;
          public          strapi    false    302            /           1259    57604    strapi_database_schema    TABLE     �   CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);
 *   DROP TABLE public.strapi_database_schema;
       public         heap    strapi    false            0           1259    57609    strapi_database_schema_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.strapi_database_schema_id_seq;
       public          strapi    false    303            �           0    0    strapi_database_schema_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;
          public          strapi    false    304            1           1259    57610    strapi_migrations    TABLE     �   CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);
 %   DROP TABLE public.strapi_migrations;
       public         heap    strapi    false            2           1259    57613    strapi_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.strapi_migrations_id_seq;
       public          strapi    false    305            �           0    0    strapi_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;
          public          strapi    false    306            3           1259    57614 !   strapi_transfer_token_permissions    TABLE     
  CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 5   DROP TABLE public.strapi_transfer_token_permissions;
       public         heap    strapi    false            4           1259    57617 (   strapi_transfer_token_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.strapi_transfer_token_permissions_id_seq;
       public          strapi    false    307            �           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;
          public          strapi    false    308            5           1259    57618 -   strapi_transfer_token_permissions_token_links    TABLE     �   CREATE TABLE public.strapi_transfer_token_permissions_token_links (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_order double precision
);
 A   DROP TABLE public.strapi_transfer_token_permissions_token_links;
       public         heap    strapi    false            6           1259    57621 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 K   DROP SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq;
       public          strapi    false    309            �           0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;
          public          strapi    false    310            7           1259    57622    strapi_transfer_tokens    TABLE     �  CREATE TABLE public.strapi_transfer_tokens (
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
       public         heap    strapi    false            8           1259    57627    strapi_transfer_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.strapi_transfer_tokens_id_seq;
       public          strapi    false    311            �           0    0    strapi_transfer_tokens_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;
          public          strapi    false    312            9           1259    57628    strapi_webhooks    TABLE     �   CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);
 #   DROP TABLE public.strapi_webhooks;
       public         heap    strapi    false            :           1259    57633    strapi_webhooks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.strapi_webhooks_id_seq;
       public          strapi    false    313            �           0    0    strapi_webhooks_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;
          public          strapi    false    314            ;           1259    57634    units    TABLE     n  CREATE TABLE public.units (
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
       public         heap    strapi    false            <           1259    57639    units_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.units_id_seq;
       public          strapi    false    315            �           0    0    units_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;
          public          strapi    false    316            =           1259    57640    units_localizations_links    TABLE     �   CREATE TABLE public.units_localizations_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer,
    unit_order double precision
);
 -   DROP TABLE public.units_localizations_links;
       public         heap    strapi    false            >           1259    57643     units_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.units_localizations_links_id_seq;
       public          strapi    false    317            �           0    0     units_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.units_localizations_links_id_seq OWNED BY public.units_localizations_links.id;
          public          strapi    false    318            ?           1259    57644    units_precondition_links    TABLE     x   CREATE TABLE public.units_precondition_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer
);
 ,   DROP TABLE public.units_precondition_links;
       public         heap    strapi    false            @           1259    57647    units_precondition_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_precondition_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.units_precondition_links_id_seq;
       public          strapi    false    319            �           0    0    units_precondition_links_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.units_precondition_links_id_seq OWNED BY public.units_precondition_links.id;
          public          strapi    false    320            A           1259    57648    up_permissions    TABLE     �   CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 "   DROP TABLE public.up_permissions;
       public         heap    strapi    false            B           1259    57651    up_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.up_permissions_id_seq;
       public          strapi    false    321            �           0    0    up_permissions_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;
          public          strapi    false    322            C           1259    57652    up_permissions_role_links    TABLE     �   CREATE TABLE public.up_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);
 -   DROP TABLE public.up_permissions_role_links;
       public         heap    strapi    false            D           1259    57655     up_permissions_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.up_permissions_role_links_id_seq;
       public          strapi    false    323            �           0    0     up_permissions_role_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;
          public          strapi    false    324            E           1259    57656    up_roles    TABLE     8  CREATE TABLE public.up_roles (
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
       public         heap    strapi    false            F           1259    57661    up_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.up_roles_id_seq;
       public          strapi    false    325            �           0    0    up_roles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;
          public          strapi    false    326            G           1259    57662    up_users    TABLE     �  CREATE TABLE public.up_users (
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
       public         heap    strapi    false            H           1259    57667    up_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.up_users_id_seq;
       public          strapi    false    327            �           0    0    up_users_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;
          public          strapi    false    328            I           1259    57668    up_users_role_links    TABLE     �   CREATE TABLE public.up_users_role_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_order double precision
);
 '   DROP TABLE public.up_users_role_links;
       public         heap    strapi    false            J           1259    57671    up_users_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_users_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.up_users_role_links_id_seq;
       public          strapi    false    329            �           0    0    up_users_role_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;
          public          strapi    false    330            K           1259    57672    upload_folders    TABLE     +  CREATE TABLE public.upload_folders (
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
       public         heap    strapi    false            L           1259    57677    upload_folders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.upload_folders_id_seq;
       public          strapi    false    331            �           0    0    upload_folders_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;
          public          strapi    false    332            M           1259    57678    upload_folders_parent_links    TABLE     �   CREATE TABLE public.upload_folders_parent_links (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_order double precision
);
 /   DROP TABLE public.upload_folders_parent_links;
       public         heap    strapi    false            N           1259    57681 "   upload_folders_parent_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.upload_folders_parent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.upload_folders_parent_links_id_seq;
       public          strapi    false    333            �           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;
          public          strapi    false    334            O           1259    57682    user_sentences    TABLE     E  CREATE TABLE public.user_sentences (
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
       public         heap    strapi    false            P           1259    57687    user_sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.user_sentences_id_seq;
       public          strapi    false    335            �           0    0    user_sentences_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.user_sentences_id_seq OWNED BY public.user_sentences.id;
          public          strapi    false    336            Q           1259    57688    user_sentences_lesson_links    TABLE     �   CREATE TABLE public.user_sentences_lesson_links (
    id integer NOT NULL,
    user_sentence_id integer,
    lesson_id integer,
    user_sentence_order double precision
);
 /   DROP TABLE public.user_sentences_lesson_links;
       public         heap    strapi    false            R           1259    57691 "   user_sentences_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.user_sentences_lesson_links_id_seq;
       public          strapi    false    337            �           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.user_sentences_lesson_links_id_seq OWNED BY public.user_sentences_lesson_links.id;
          public          strapi    false    338            S           1259    57692 "   user_sentences_localizations_links    TABLE     �   CREATE TABLE public.user_sentences_localizations_links (
    id integer NOT NULL,
    user_sentence_id integer,
    inv_user_sentence_id integer,
    user_sentence_order double precision
);
 6   DROP TABLE public.user_sentences_localizations_links;
       public         heap    strapi    false            T           1259    57695 )   user_sentences_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.user_sentences_localizations_links_id_seq;
       public          strapi    false    339            �           0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE public.user_sentences_localizations_links_id_seq OWNED BY public.user_sentences_localizations_links.id;
          public          strapi    false    340            U           1259    57696 +   user_sentences_users_permissions_user_links    TABLE     �   CREATE TABLE public.user_sentences_users_permissions_user_links (
    id integer NOT NULL,
    user_sentence_id integer,
    user_id integer,
    user_sentence_order double precision
);
 ?   DROP TABLE public.user_sentences_users_permissions_user_links;
       public         heap    strapi    false            V           1259    57699 2   user_sentences_users_permissions_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_sentences_users_permissions_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.user_sentences_users_permissions_user_links_id_seq;
       public          strapi    false    341            �           0    0 2   user_sentences_users_permissions_user_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.user_sentences_users_permissions_user_links_id_seq OWNED BY public.user_sentences_users_permissions_user_links.id;
          public          strapi    false    342            W           1259    57700 
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
       public         heap    strapi    false            X           1259    57705    user_words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.user_words_id_seq;
       public          strapi    false    343            �           0    0    user_words_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_words_id_seq OWNED BY public.user_words.id;
          public          strapi    false    344            Y           1259    57706    user_words_lesson_links    TABLE     �   CREATE TABLE public.user_words_lesson_links (
    id integer NOT NULL,
    user_word_id integer,
    lesson_id integer,
    user_word_order double precision
);
 +   DROP TABLE public.user_words_lesson_links;
       public         heap    strapi    false            Z           1259    57709    user_words_lesson_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_lesson_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.user_words_lesson_links_id_seq;
       public          strapi    false    345            �           0    0    user_words_lesson_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.user_words_lesson_links_id_seq OWNED BY public.user_words_lesson_links.id;
          public          strapi    false    346            [           1259    57710    user_words_localizations_links    TABLE     �   CREATE TABLE public.user_words_localizations_links (
    id integer NOT NULL,
    user_word_id integer,
    inv_user_word_id integer,
    user_word_order double precision
);
 2   DROP TABLE public.user_words_localizations_links;
       public         heap    strapi    false            \           1259    57713 %   user_words_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.user_words_localizations_links_id_seq;
       public          strapi    false    347            �           0    0 %   user_words_localizations_links_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.user_words_localizations_links_id_seq OWNED BY public.user_words_localizations_links.id;
          public          strapi    false    348            ]           1259    57714 '   user_words_users_permissions_user_links    TABLE     �   CREATE TABLE public.user_words_users_permissions_user_links (
    id integer NOT NULL,
    user_word_id integer,
    user_id integer,
    user_word_order double precision
);
 ;   DROP TABLE public.user_words_users_permissions_user_links;
       public         heap    strapi    false            ^           1259    57717 .   user_words_users_permissions_user_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_words_users_permissions_user_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.user_words_users_permissions_user_links_id_seq;
       public          strapi    false    349            �           0    0 .   user_words_users_permissions_user_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.user_words_users_permissions_user_links_id_seq OWNED BY public.user_words_users_permissions_user_links.id;
          public          strapi    false    350            _           1259    57718    words    TABLE     �  CREATE TABLE public.words (
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
       public         heap    strapi    false            `           1259    57723    words_components    TABLE     �   CREATE TABLE public.words_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 $   DROP TABLE public.words_components;
       public         heap    strapi    false            a           1259    57728    words_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.words_components_id_seq;
       public          strapi    false    352            �           0    0    words_components_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.words_components_id_seq OWNED BY public.words_components.id;
          public          strapi    false    353            b           1259    57729    words_example_sentences_links    TABLE     �   CREATE TABLE public.words_example_sentences_links (
    id integer NOT NULL,
    word_id integer,
    sentence_id integer,
    sentence_order double precision,
    word_order double precision
);
 1   DROP TABLE public.words_example_sentences_links;
       public         heap    strapi    false            c           1259    57732 $   words_example_sentences_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_example_sentences_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.words_example_sentences_links_id_seq;
       public          strapi    false    354            �           0    0 $   words_example_sentences_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.words_example_sentences_links_id_seq OWNED BY public.words_example_sentences_links.id;
          public          strapi    false    355            d           1259    57733    words_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.words_id_seq;
       public          strapi    false    351            �           0    0    words_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;
          public          strapi    false    356            e           1259    57734    words_localizations_links    TABLE     �   CREATE TABLE public.words_localizations_links (
    id integer NOT NULL,
    word_id integer,
    inv_word_id integer,
    word_order double precision
);
 -   DROP TABLE public.words_localizations_links;
       public         heap    strapi    false            f           1259    57737     words_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.words_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.words_localizations_links_id_seq;
       public          strapi    false    357            �           0    0     words_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.words_localizations_links_id_seq OWNED BY public.words_localizations_links.id;
          public          strapi    false    358            )           2604    57738    admin_permissions id    DEFAULT     |   ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);
 C   ALTER TABLE public.admin_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    210    209            *           2604    57739    admin_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);
 N   ALTER TABLE public.admin_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    212    211            +           2604    57740    admin_roles id    DEFAULT     p   ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);
 =   ALTER TABLE public.admin_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    214    213            ,           2604    57741    admin_users id    DEFAULT     p   ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);
 =   ALTER TABLE public.admin_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    216    215            -           2604    57742    admin_users_roles_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);
 I   ALTER TABLE public.admin_users_roles_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    218    217            .           2604    57743    components_a_external_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_external_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_external_videos_id_seq'::regclass);
 N   ALTER TABLE public.components_a_external_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    220    219            /           2604    57744    components_a_pagebreakers id    DEFAULT     �   ALTER TABLE ONLY public.components_a_pagebreakers ALTER COLUMN id SET DEFAULT nextval('public.components_a_pagebreakers_id_seq'::regclass);
 K   ALTER TABLE public.components_a_pagebreakers ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    222    221            0           2604    57745    components_a_quizzes id    DEFAULT     �   ALTER TABLE ONLY public.components_a_quizzes ALTER COLUMN id SET DEFAULT nextval('public.components_a_quizzes_id_seq'::regclass);
 F   ALTER TABLE public.components_a_quizzes ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    224    223            1           2604    57746    components_a_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    226    225            2           2604    57747 (   components_a_sent_refs_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_sent_refs_sentence_links_id_seq'::regclass);
 W   ALTER TABLE public.components_a_sent_refs_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    228    227            3           2604    57748    components_a_taglists id    DEFAULT     �   ALTER TABLE ONLY public.components_a_taglists ALTER COLUMN id SET DEFAULT nextval('public.components_a_taglists_id_seq'::regclass);
 G   ALTER TABLE public.components_a_taglists ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    230    229            4           2604    57749    components_a_user_sent_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_sent_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    232    231            5           2604    57750 2   components_a_user_sent_refs_user_sentence_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_sent_refs_user_sentence_links_id_seq'::regclass);
 a   ALTER TABLE public.components_a_user_sent_refs_user_sentence_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    234    233            6           2604    57751    components_a_user_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_id_seq'::regclass);
 M   ALTER TABLE public.components_a_user_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    236    235            7           2604    57752 .   components_a_user_word_refs_user_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_user_word_refs_user_word_links_id_seq'::regclass);
 ]   ALTER TABLE public.components_a_user_word_refs_user_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    238    237            8           2604    57753    components_a_verb_metas id    DEFAULT     �   ALTER TABLE ONLY public.components_a_verb_metas ALTER COLUMN id SET DEFAULT nextval('public.components_a_verb_metas_id_seq'::regclass);
 I   ALTER TABLE public.components_a_verb_metas ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    240    239            9           2604    57754    components_a_videos id    DEFAULT     �   ALTER TABLE ONLY public.components_a_videos ALTER COLUMN id SET DEFAULT nextval('public.components_a_videos_id_seq'::regclass);
 E   ALTER TABLE public.components_a_videos ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    242    241            :           2604    57755    components_a_word_refs id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_id_seq'::regclass);
 H   ALTER TABLE public.components_a_word_refs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    244    243            ;           2604    57756 $   components_a_word_refs_word_links id    DEFAULT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links ALTER COLUMN id SET DEFAULT nextval('public.components_a_word_refs_word_links_id_seq'::regclass);
 S   ALTER TABLE public.components_a_word_refs_word_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    246    245            <           2604    57757    files id    DEFAULT     d   ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
 7   ALTER TABLE public.files ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    250    247            =           2604    57758    files_folder_links id    DEFAULT     ~   ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);
 D   ALTER TABLE public.files_folder_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    249    248            >           2604    57759    files_related_morphs id    DEFAULT     �   ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);
 F   ALTER TABLE public.files_related_morphs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    252    251            ?           2604    57760    flashcards id    DEFAULT     n   ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);
 <   ALTER TABLE public.flashcards ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    256    253            @           2604    57761    flashcards_components id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_components ALTER COLUMN id SET DEFAULT nextval('public.flashcards_components_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    255    254            A           2604    57762    flashcards_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.flashcards_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    258    257            B           2604    57763 !   flashcards_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.flashcards_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    260    259            C           2604    57764    flashcards_user_links id    DEFAULT     �   ALTER TABLE ONLY public.flashcards_user_links ALTER COLUMN id SET DEFAULT nextval('public.flashcards_user_links_id_seq'::regclass);
 G   ALTER TABLE public.flashcards_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    262    261            D           2604    57765    i18n_locale id    DEFAULT     p   ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);
 =   ALTER TABLE public.i18n_locale ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    264    263            E           2604    57766    lessonlevels id    DEFAULT     r   ALTER TABLE ONLY public.lessonlevels ALTER COLUMN id SET DEFAULT nextval('public.lessonlevels_id_seq'::regclass);
 >   ALTER TABLE public.lessonlevels ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    266    265            F           2604    57767 
   lessons id    DEFAULT     h   ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);
 9   ALTER TABLE public.lessons ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    270    267            G           2604    57768    lessons_components id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_components ALTER COLUMN id SET DEFAULT nextval('public.lessons_components_id_seq'::regclass);
 D   ALTER TABLE public.lessons_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    269    268            H           2604    57769    lessons_lessonlevel_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_lessonlevel_links_id_seq'::regclass);
 K   ALTER TABLE public.lessons_lessonlevel_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    272    271            I           2604    57770    lessons_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_localizations_links_id_seq'::regclass);
 M   ALTER TABLE public.lessons_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    274    273            J           2604    57771    lessons_unit_links id    DEFAULT     ~   ALTER TABLE ONLY public.lessons_unit_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_unit_links_id_seq'::regclass);
 D   ALTER TABLE public.lessons_unit_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    276    275            K           2604    57772    reviewlogs id    DEFAULT     n   ALTER TABLE ONLY public.reviewlogs ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_id_seq'::regclass);
 <   ALTER TABLE public.reviewlogs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    278    277            L           2604    57773    reviewlogs_user_links id    DEFAULT     �   ALTER TABLE ONLY public.reviewlogs_user_links ALTER COLUMN id SET DEFAULT nextval('public.reviewlogs_user_links_id_seq'::regclass);
 G   ALTER TABLE public.reviewlogs_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    280    279            M           2604    57774    sections id    DEFAULT     j   ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);
 :   ALTER TABLE public.sections ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    284    281            N           2604    57775    sections_components id    DEFAULT     �   ALTER TABLE ONLY public.sections_components ALTER COLUMN id SET DEFAULT nextval('public.sections_components_id_seq'::regclass);
 E   ALTER TABLE public.sections_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    283    282            O           2604    57776    sections_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.sections_lesson_links_id_seq'::regclass);
 G   ALTER TABLE public.sections_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    286    285            P           2604    57777    sections_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sections_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sections_localizations_links_id_seq'::regclass);
 N   ALTER TABLE public.sections_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    288    287            Q           2604    57778    sentences id    DEFAULT     l   ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);
 ;   ALTER TABLE public.sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    292    289            R           2604    57779    sentences_components id    DEFAULT     �   ALTER TABLE ONLY public.sentences_components ALTER COLUMN id SET DEFAULT nextval('public.sentences_components_id_seq'::regclass);
 F   ALTER TABLE public.sentences_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    291    290            S           2604    57780     sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sentences_localizations_links_id_seq'::regclass);
 O   ALTER TABLE public.sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    294    293            T           2604    57781    strapi_api_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);
 N   ALTER TABLE public.strapi_api_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    296    295            U           2604    57782 +   strapi_api_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);
 Z   ALTER TABLE public.strapi_api_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    298    297            V           2604    57783    strapi_api_tokens id    DEFAULT     |   ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);
 C   ALTER TABLE public.strapi_api_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    300    299            W           2604    57784    strapi_core_store_settings id    DEFAULT     �   ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);
 L   ALTER TABLE public.strapi_core_store_settings ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    302    301            X           2604    57785    strapi_database_schema id    DEFAULT     �   ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);
 H   ALTER TABLE public.strapi_database_schema ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    304    303            Y           2604    57786    strapi_migrations id    DEFAULT     |   ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);
 C   ALTER TABLE public.strapi_migrations ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    306    305            Z           2604    57787 $   strapi_transfer_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);
 S   ALTER TABLE public.strapi_transfer_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    308    307            [           2604    57788 0   strapi_transfer_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);
 _   ALTER TABLE public.strapi_transfer_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    310    309            \           2604    57789    strapi_transfer_tokens id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);
 H   ALTER TABLE public.strapi_transfer_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    312    311            ]           2604    57790    strapi_webhooks id    DEFAULT     x   ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);
 A   ALTER TABLE public.strapi_webhooks ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    314    313            ^           2604    57791    units id    DEFAULT     d   ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);
 7   ALTER TABLE public.units ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    316    315            _           2604    57792    units_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.units_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.units_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.units_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    318    317            `           2604    57793    units_precondition_links id    DEFAULT     �   ALTER TABLE ONLY public.units_precondition_links ALTER COLUMN id SET DEFAULT nextval('public.units_precondition_links_id_seq'::regclass);
 J   ALTER TABLE public.units_precondition_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    320    319            a           2604    57794    up_permissions id    DEFAULT     v   ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);
 @   ALTER TABLE public.up_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    322    321            b           2604    57795    up_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);
 K   ALTER TABLE public.up_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    324    323            c           2604    57796    up_roles id    DEFAULT     j   ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);
 :   ALTER TABLE public.up_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    326    325            d           2604    57797    up_users id    DEFAULT     j   ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);
 :   ALTER TABLE public.up_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    328    327            e           2604    57798    up_users_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);
 E   ALTER TABLE public.up_users_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    330    329            f           2604    57799    upload_folders id    DEFAULT     v   ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);
 @   ALTER TABLE public.upload_folders ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    332    331            g           2604    57800    upload_folders_parent_links id    DEFAULT     �   ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);
 M   ALTER TABLE public.upload_folders_parent_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    334    333            h           2604    57801    user_sentences id    DEFAULT     v   ALTER TABLE ONLY public.user_sentences ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_id_seq'::regclass);
 @   ALTER TABLE public.user_sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    336    335            i           2604    57802    user_sentences_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_lesson_links_id_seq'::regclass);
 M   ALTER TABLE public.user_sentences_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    338    337            j           2604    57803 %   user_sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_localizations_links_id_seq'::regclass);
 T   ALTER TABLE public.user_sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    340    339            k           2604    57804 .   user_sentences_users_permissions_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_sentences_users_permissions_user_links_id_seq'::regclass);
 ]   ALTER TABLE public.user_sentences_users_permissions_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    342    341            l           2604    57805    user_words id    DEFAULT     n   ALTER TABLE ONLY public.user_words ALTER COLUMN id SET DEFAULT nextval('public.user_words_id_seq'::regclass);
 <   ALTER TABLE public.user_words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    344    343            m           2604    57806    user_words_lesson_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_lesson_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_lesson_links_id_seq'::regclass);
 I   ALTER TABLE public.user_words_lesson_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    346    345            n           2604    57807 !   user_words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_localizations_links_id_seq'::regclass);
 P   ALTER TABLE public.user_words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    348    347            o           2604    57808 *   user_words_users_permissions_user_links id    DEFAULT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links ALTER COLUMN id SET DEFAULT nextval('public.user_words_users_permissions_user_links_id_seq'::regclass);
 Y   ALTER TABLE public.user_words_users_permissions_user_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    350    349            p           2604    57809    words id    DEFAULT     d   ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);
 7   ALTER TABLE public.words ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    356    351            q           2604    57810    words_components id    DEFAULT     z   ALTER TABLE ONLY public.words_components ALTER COLUMN id SET DEFAULT nextval('public.words_components_id_seq'::regclass);
 B   ALTER TABLE public.words_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    353    352            r           2604    57811     words_example_sentences_links id    DEFAULT     �   ALTER TABLE ONLY public.words_example_sentences_links ALTER COLUMN id SET DEFAULT nextval('public.words_example_sentences_links_id_seq'::regclass);
 O   ALTER TABLE public.words_example_sentences_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    355    354            s           2604    57812    words_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.words_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.words_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.words_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    358    357            �          0    57375    admin_permissions 
   TABLE DATA           �   COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    209   ǎ                 0    57381    admin_permissions_role_links 
   TABLE DATA           d   COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    211   �                0    57385    admin_roles 
   TABLE DATA           x   COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    213   ��                0    57391    admin_users 
   TABLE DATA           �   COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    215   f�                0    57397    admin_users_roles_links 
   TABLE DATA           _   COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
    public          strapi    false    217   �                0    57401    components_a_external_videos 
   TABLE DATA           H   COPY public.components_a_external_videos (id, url, caption) FROM stdin;
    public          strapi    false    219   #�      
          0    57407    components_a_pagebreakers 
   TABLE DATA           O   COPY public.components_a_pagebreakers (id, backbutton, nextbutton) FROM stdin;
    public          strapi    false    221   @�                0    57411    components_a_quizzes 
   TABLE DATA           Z   COPY public.components_a_quizzes (id, question, options, answer, explanation) FROM stdin;
    public          strapi    false    223   ]�                0    57417    components_a_sent_refs 
   TABLE DATA           4   COPY public.components_a_sent_refs (id) FROM stdin;
    public          strapi    false    225   z�                0    57421 %   components_a_sent_refs_sentence_links 
   TABLE DATA           ]   COPY public.components_a_sent_refs_sentence_links (id, sent_ref_id, sentence_id) FROM stdin;
    public          strapi    false    227   ��                0    57425    components_a_taglists 
   TABLE DATA           8   COPY public.components_a_taglists (id, tag) FROM stdin;
    public          strapi    false    229   ��                0    57429    components_a_user_sent_refs 
   TABLE DATA           9   COPY public.components_a_user_sent_refs (id) FROM stdin;
    public          strapi    false    231   �                0    57433 /   components_a_user_sent_refs_user_sentence_links 
   TABLE DATA           q   COPY public.components_a_user_sent_refs_user_sentence_links (id, user_sent_ref_id, user_sentence_id) FROM stdin;
    public          strapi    false    233   �                0    57437    components_a_user_word_refs 
   TABLE DATA           9   COPY public.components_a_user_word_refs (id) FROM stdin;
    public          strapi    false    235   '�                0    57441 +   components_a_user_word_refs_user_word_links 
   TABLE DATA           i   COPY public.components_a_user_word_refs_user_word_links (id, user_word_ref_id, user_word_id) FROM stdin;
    public          strapi    false    237   F�                0    57445    components_a_verb_metas 
   TABLE DATA           �   COPY public.components_a_verb_metas (id, simple_past, past_participle, present_participle, thirdperson_singular, auxiliary_verb, conjugations) FROM stdin;
    public          strapi    false    239   i�                0    57451    components_a_videos 
   TABLE DATA           1   COPY public.components_a_videos (id) FROM stdin;
    public          strapi    false    241   ��                 0    57455    components_a_word_refs 
   TABLE DATA           4   COPY public.components_a_word_refs (id) FROM stdin;
    public          strapi    false    243   ��      "          0    57459 !   components_a_word_refs_word_links 
   TABLE DATA           U   COPY public.components_a_word_refs_word_links (id, word_ref_id, word_id) FROM stdin;
    public          strapi    false    245   �      $          0    57463    files 
   TABLE DATA           �   COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    247   �      %          0    57468    files_folder_links 
   TABLE DATA           P   COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
    public          strapi    false    248   2�      (          0    57473    files_related_morphs 
   TABLE DATA           e   COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
    public          strapi    false    251   O�      *          0    57479 
   flashcards 
   TABLE DATA           �   COPY public.flashcards (id, created_at, updated_at, created_by_id, updated_by_id, locale, last_reviewed_at, daily_streak, weekly_streak, weekly_wrong_streak, monthly_streak, monthly_wrong_streak, is_remembered) FROM stdin;
    public          strapi    false    253   l�      +          0    57482    flashcards_components 
   TABLE DATA           l   COPY public.flashcards_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    254   �      .          0    57489    flashcards_lesson_links 
   TABLE DATA           _   COPY public.flashcards_lesson_links (id, flashcard_id, lesson_id, flashcard_order) FROM stdin;
    public          strapi    false    257   N�      0          0    57493    flashcards_localizations_links 
   TABLE DATA           m   COPY public.flashcards_localizations_links (id, flashcard_id, inv_flashcard_id, flashcard_order) FROM stdin;
    public          strapi    false    259   s�      2          0    57498    flashcards_user_links 
   TABLE DATA           [   COPY public.flashcards_user_links (id, flashcard_id, user_id, flashcard_order) FROM stdin;
    public          strapi    false    261   ��      4          0    57502    i18n_locale 
   TABLE DATA           k   COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    263   ͟      6          0    57508    lessonlevels 
   TABLE DATA           t   COPY public.lessonlevels (id, level, created_at, updated_at, created_by_id, updated_by_id, description) FROM stdin;
    public          strapi    false    265   �      8          0    57514    lessons 
   TABLE DATA           �   COPY public.lessons (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    267   6�      9          0    57519    lessons_components 
   TABLE DATA           i   COPY public.lessons_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    268   ��      <          0    57526    lessons_lessonlevel_links 
   TABLE DATA           `   COPY public.lessons_lessonlevel_links (id, lesson_id, lessonlevel_id, lesson_order) FROM stdin;
    public          strapi    false    271   ��      >          0    57530    lessons_localizations_links 
   TABLE DATA           a   COPY public.lessons_localizations_links (id, lesson_id, inv_lesson_id, lesson_order) FROM stdin;
    public          strapi    false    273   ʠ      @          0    57534    lessons_unit_links 
   TABLE DATA           R   COPY public.lessons_unit_links (id, lesson_id, unit_id, lesson_order) FROM stdin;
    public          strapi    false    275   �      B          0    57538 
   reviewlogs 
   TABLE DATA           y   COPY public.reviewlogs (id, reviewd_at, level, result, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    277   �      D          0    57544    reviewlogs_user_links 
   TABLE DATA           [   COPY public.reviewlogs_user_links (id, reviewlog_id, user_id, reviewlog_order) FROM stdin;
    public          strapi    false    279   <�      F          0    57548    sections 
   TABLE DATA           t   COPY public.sections (id, title, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    281   ��      G          0    57553    sections_components 
   TABLE DATA           j   COPY public.sections_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    282   /�      J          0    57560    sections_lesson_links 
   TABLE DATA           Y   COPY public.sections_lesson_links (id, section_id, lesson_id, section_order) FROM stdin;
    public          strapi    false    285   r�      L          0    57564    sections_localizations_links 
   TABLE DATA           e   COPY public.sections_localizations_links (id, section_id, inv_section_id, section_order) FROM stdin;
    public          strapi    false    287   ��      N          0    57568 	   sentences 
   TABLE DATA           �   COPY public.sentences (id, title, instruction, base_text, target_text, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    289   ��      O          0    57573    sentences_components 
   TABLE DATA           k   COPY public.sentences_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    290   �      R          0    57580    sentences_localizations_links 
   TABLE DATA           i   COPY public.sentences_localizations_links (id, sentence_id, inv_sentence_id, sentence_order) FROM stdin;
    public          strapi    false    293   ��      T          0    57584    strapi_api_token_permissions 
   TABLE DATA           x   COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    295   ��      V          0    57588 (   strapi_api_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
    public          strapi    false    297   ֤      X          0    57592    strapi_api_tokens 
   TABLE DATA           �   COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    299   �      Z          0    57598    strapi_core_store_settings 
   TABLE DATA           \   COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
    public          strapi    false    301   �      \          0    57604    strapi_database_schema 
   TABLE DATA           J   COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
    public          strapi    false    303   �      ^          0    57610    strapi_migrations 
   TABLE DATA           =   COPY public.strapi_migrations (id, name, "time") FROM stdin;
    public          strapi    false    305   C�      `          0    57614 !   strapi_transfer_token_permissions 
   TABLE DATA           }   COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    307   `�      b          0    57618 -   strapi_transfer_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
    public          strapi    false    309   }�      d          0    57622    strapi_transfer_tokens 
   TABLE DATA           �   COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    311   ��      f          0    57628    strapi_webhooks 
   TABLE DATA           R   COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
    public          strapi    false    313   ��      h          0    57634    units 
   TABLE DATA           �   COPY public.units (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    315   ��      j          0    57640    units_localizations_links 
   TABLE DATA           Y   COPY public.units_localizations_links (id, unit_id, inv_unit_id, unit_order) FROM stdin;
    public          strapi    false    317   f�      l          0    57644    units_precondition_links 
   TABLE DATA           L   COPY public.units_precondition_links (id, unit_id, inv_unit_id) FROM stdin;
    public          strapi    false    319   ��      n          0    57648    up_permissions 
   TABLE DATA           j   COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    321   ��      p          0    57652    up_permissions_role_links 
   TABLE DATA           a   COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    323   f�      r          0    57656    up_roles 
   TABLE DATA           u   COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    325   ��      t          0    57662    up_users 
   TABLE DATA           �   COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    327   ��      v          0    57668    up_users_role_links 
   TABLE DATA           O   COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
    public          strapi    false    329   y�      x          0    57672    upload_folders 
   TABLE DATA           w   COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    331   ��      z          0    57678    upload_folders_parent_links 
   TABLE DATA           a   COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
    public          strapi    false    333   ��      |          0    57682    user_sentences 
   TABLE DATA           �   COPY public.user_sentences (id, target_text, base_text, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    335   ��      ~          0    57688    user_sentences_lesson_links 
   TABLE DATA           k   COPY public.user_sentences_lesson_links (id, user_sentence_id, lesson_id, user_sentence_order) FROM stdin;
    public          strapi    false    337   P�      �          0    57692 "   user_sentences_localizations_links 
   TABLE DATA           }   COPY public.user_sentences_localizations_links (id, user_sentence_id, inv_user_sentence_id, user_sentence_order) FROM stdin;
    public          strapi    false    339   r�      �          0    57696 +   user_sentences_users_permissions_user_links 
   TABLE DATA           y   COPY public.user_sentences_users_permissions_user_links (id, user_sentence_id, user_id, user_sentence_order) FROM stdin;
    public          strapi    false    341   ��      �          0    57700 
   user_words 
   TABLE DATA           �   COPY public.user_words (id, word, base_text, part_of_speech, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    343   ��      �          0    57706    user_words_lesson_links 
   TABLE DATA           _   COPY public.user_words_lesson_links (id, user_word_id, lesson_id, user_word_order) FROM stdin;
    public          strapi    false    345   �      �          0    57710    user_words_localizations_links 
   TABLE DATA           m   COPY public.user_words_localizations_links (id, user_word_id, inv_user_word_id, user_word_order) FROM stdin;
    public          strapi    false    347   4�      �          0    57714 '   user_words_users_permissions_user_links 
   TABLE DATA           m   COPY public.user_words_users_permissions_user_links (id, user_word_id, user_id, user_word_order) FROM stdin;
    public          strapi    false    349   Q�      �          0    57718    words 
   TABLE DATA           �   COPY public.words (id, word, base_text, instruction, part_of_speech, gender, article, created_at, updated_at, created_by_id, updated_by_id, locale, register) FROM stdin;
    public          strapi    false    351   v�      �          0    57723    words_components 
   TABLE DATA           g   COPY public.words_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    352   j�      �          0    57729    words_example_sentences_links 
   TABLE DATA           m   COPY public.words_example_sentences_links (id, word_id, sentence_id, sentence_order, word_order) FROM stdin;
    public          strapi    false    354   ��      �          0    57734    words_localizations_links 
   TABLE DATA           Y   COPY public.words_localizations_links (id, word_id, inv_word_id, word_order) FROM stdin;
    public          strapi    false    357   ��      �           0    0    admin_permissions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.admin_permissions_id_seq', 222, true);
          public          strapi    false    210            �           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 222, true);
          public          strapi    false    212            �           0    0    admin_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);
          public          strapi    false    214            �           0    0    admin_users_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);
          public          strapi    false    216            �           0    0    admin_users_roles_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);
          public          strapi    false    218            �           0    0 #   components_a_external_videos_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.components_a_external_videos_id_seq', 1, false);
          public          strapi    false    220            �           0    0     components_a_pagebreakers_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.components_a_pagebreakers_id_seq', 1, false);
          public          strapi    false    222            �           0    0    components_a_quizzes_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_quizzes_id_seq', 1, false);
          public          strapi    false    224            �           0    0    components_a_sent_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_sent_refs_id_seq', 1, true);
          public          strapi    false    226            �           0    0 ,   components_a_sent_refs_sentence_links_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.components_a_sent_refs_sentence_links_id_seq', 1, true);
          public          strapi    false    228            �           0    0    components_a_taglists_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.components_a_taglists_id_seq', 2, true);
          public          strapi    false    230            �           0    0 "   components_a_user_sent_refs_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.components_a_user_sent_refs_id_seq', 1, true);
          public          strapi    false    232            �           0    0 6   components_a_user_sent_refs_user_sentence_links_id_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('public.components_a_user_sent_refs_user_sentence_links_id_seq', 1, true);
          public          strapi    false    234            �           0    0 "   components_a_user_word_refs_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.components_a_user_word_refs_id_seq', 1, true);
          public          strapi    false    236            �           0    0 2   components_a_user_word_refs_user_word_links_id_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('public.components_a_user_word_refs_user_word_links_id_seq', 1, true);
          public          strapi    false    238            �           0    0    components_a_verb_metas_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.components_a_verb_metas_id_seq', 1, true);
          public          strapi    false    240            �           0    0    components_a_videos_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.components_a_videos_id_seq', 1, false);
          public          strapi    false    242            �           0    0    components_a_word_refs_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_word_refs_id_seq', 4, true);
          public          strapi    false    244            �           0    0 (   components_a_word_refs_word_links_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.components_a_word_refs_word_links_id_seq', 4, true);
          public          strapi    false    246            �           0    0    files_folder_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);
          public          strapi    false    249            �           0    0    files_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.files_id_seq', 1, false);
          public          strapi    false    250            �           0    0    files_related_morphs_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);
          public          strapi    false    252            �           0    0    flashcards_components_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.flashcards_components_id_seq', 9, true);
          public          strapi    false    255            �           0    0    flashcards_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.flashcards_id_seq', 5, true);
          public          strapi    false    256            �           0    0    flashcards_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.flashcards_lesson_links_id_seq', 1, true);
          public          strapi    false    258            �           0    0 %   flashcards_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.flashcards_localizations_links_id_seq', 1, false);
          public          strapi    false    260                        0    0    flashcards_user_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.flashcards_user_links_id_seq', 6, true);
          public          strapi    false    262                       0    0    i18n_locale_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);
          public          strapi    false    264                       0    0    lessonlevels_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.lessonlevels_id_seq', 1, false);
          public          strapi    false    266                       0    0    lessons_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_components_id_seq', 1, false);
          public          strapi    false    269                       0    0    lessons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.lessons_id_seq', 1, true);
          public          strapi    false    270                       0    0     lessons_lessonlevel_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.lessons_lessonlevel_links_id_seq', 1, false);
          public          strapi    false    272                       0    0 "   lessons_localizations_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.lessons_localizations_links_id_seq', 1, false);
          public          strapi    false    274                       0    0    lessons_unit_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.lessons_unit_links_id_seq', 1, false);
          public          strapi    false    276                       0    0    reviewlogs_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.reviewlogs_id_seq', 15, true);
          public          strapi    false    278            	           0    0    reviewlogs_user_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.reviewlogs_user_links_id_seq', 15, true);
          public          strapi    false    280            
           0    0    sections_components_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sections_components_id_seq', 2, true);
          public          strapi    false    283                       0    0    sections_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sections_id_seq', 3, true);
          public          strapi    false    284                       0    0    sections_lesson_links_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sections_lesson_links_id_seq', 3, true);
          public          strapi    false    286                       0    0 #   sections_localizations_links_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sections_localizations_links_id_seq', 1, false);
          public          strapi    false    288                       0    0    sentences_components_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sentences_components_id_seq', 1, false);
          public          strapi    false    291                       0    0    sentences_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sentences_id_seq', 2, true);
          public          strapi    false    292                       0    0 $   sentences_localizations_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    294                       0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);
          public          strapi    false    296                       0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    298                       0    0    strapi_api_tokens_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);
          public          strapi    false    300                       0    0 !   strapi_core_store_settings_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 44, true);
          public          strapi    false    302                       0    0    strapi_database_schema_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 43, true);
          public          strapi    false    304                       0    0    strapi_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);
          public          strapi    false    306                       0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);
          public          strapi    false    308                       0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    310                       0    0    strapi_transfer_tokens_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);
          public          strapi    false    312                       0    0    strapi_webhooks_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);
          public          strapi    false    314                       0    0    units_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.units_id_seq', 2, true);
          public          strapi    false    316                       0    0     units_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.units_localizations_links_id_seq', 1, false);
          public          strapi    false    318                       0    0    units_precondition_links_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.units_precondition_links_id_seq', 2, true);
          public          strapi    false    320                       0    0    up_permissions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.up_permissions_id_seq', 30, true);
          public          strapi    false    322                       0    0     up_permissions_role_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 30, true);
          public          strapi    false    324                        0    0    up_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);
          public          strapi    false    326            !           0    0    up_users_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_users_id_seq', 8, true);
          public          strapi    false    328            "           0    0    up_users_role_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 8, true);
          public          strapi    false    330            #           0    0    upload_folders_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);
          public          strapi    false    332            $           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);
          public          strapi    false    334            %           0    0    user_sentences_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.user_sentences_id_seq', 1, true);
          public          strapi    false    336            &           0    0 "   user_sentences_lesson_links_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.user_sentences_lesson_links_id_seq', 1, true);
          public          strapi    false    338            '           0    0 )   user_sentences_localizations_links_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.user_sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    340            (           0    0 2   user_sentences_users_permissions_user_links_id_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('public.user_sentences_users_permissions_user_links_id_seq', 1, true);
          public          strapi    false    342            )           0    0    user_words_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_words_id_seq', 1, true);
          public          strapi    false    344            *           0    0    user_words_lesson_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.user_words_lesson_links_id_seq', 1, true);
          public          strapi    false    346            +           0    0 %   user_words_localizations_links_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.user_words_localizations_links_id_seq', 1, false);
          public          strapi    false    348            ,           0    0 .   user_words_users_permissions_user_links_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.user_words_users_permissions_user_links_id_seq', 2, true);
          public          strapi    false    350            -           0    0    words_components_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.words_components_id_seq', 6, true);
          public          strapi    false    353            .           0    0 $   words_example_sentences_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.words_example_sentences_links_id_seq', 1, false);
          public          strapi    false    355            /           0    0    words_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.words_id_seq', 3, true);
          public          strapi    false    356            0           0    0     words_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.words_localizations_links_id_seq', 1, false);
          public          strapi    false    358            v           2606    57816 (   admin_permissions admin_permissions_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_pkey;
       public            strapi    false    209            |           2606    57818 >   admin_permissions_role_links admin_permissions_role_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_pkey;
       public            strapi    false    211            ~           2606    57820 @   admin_permissions_role_links admin_permissions_role_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_unique UNIQUE (permission_id, role_id);
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_unique;
       public            strapi    false    211    211            �           2606    57822    admin_roles admin_roles_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_pkey;
       public            strapi    false    213            �           2606    57824    admin_users admin_users_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_pkey;
       public            strapi    false    215            �           2606    57826 4   admin_users_roles_links admin_users_roles_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_pkey;
       public            strapi    false    217            �           2606    57828 6   admin_users_roles_links admin_users_roles_links_unique 
   CONSTRAINT     }   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_unique UNIQUE (user_id, role_id);
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_unique;
       public            strapi    false    217    217            �           2606    57830 >   components_a_external_videos components_a_external_videos_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.components_a_external_videos
    ADD CONSTRAINT components_a_external_videos_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.components_a_external_videos DROP CONSTRAINT components_a_external_videos_pkey;
       public            strapi    false    219            �           2606    57832 8   components_a_pagebreakers components_a_pagebreakers_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.components_a_pagebreakers
    ADD CONSTRAINT components_a_pagebreakers_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.components_a_pagebreakers DROP CONSTRAINT components_a_pagebreakers_pkey;
       public            strapi    false    221            �           2606    57834 .   components_a_quizzes components_a_quizzes_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.components_a_quizzes
    ADD CONSTRAINT components_a_quizzes_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.components_a_quizzes DROP CONSTRAINT components_a_quizzes_pkey;
       public            strapi    false    223            �           2606    57836 2   components_a_sent_refs components_a_sent_refs_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.components_a_sent_refs
    ADD CONSTRAINT components_a_sent_refs_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.components_a_sent_refs DROP CONSTRAINT components_a_sent_refs_pkey;
       public            strapi    false    225            �           2606    57838 P   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_pkey PRIMARY KEY (id);
 z   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_pkey;
       public            strapi    false    227            �           2606    57840 R   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_unique UNIQUE (sent_ref_id, sentence_id);
 |   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_unique;
       public            strapi    false    227    227            �           2606    57842 0   components_a_taglists components_a_taglists_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.components_a_taglists
    ADD CONSTRAINT components_a_taglists_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.components_a_taglists DROP CONSTRAINT components_a_taglists_pkey;
       public            strapi    false    229            �           2606    57844 <   components_a_user_sent_refs components_a_user_sent_refs_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.components_a_user_sent_refs
    ADD CONSTRAINT components_a_user_sent_refs_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.components_a_user_sent_refs DROP CONSTRAINT components_a_user_sent_refs_pkey;
       public            strapi    false    231            �           2606    57846 d   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_pkey;
       public            strapi    false    233            �           2606    57848 f   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_unique UNIQUE (user_sent_ref_id, user_sentence_id);
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_unique;
       public            strapi    false    233    233            �           2606    57850 <   components_a_user_word_refs components_a_user_word_refs_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.components_a_user_word_refs
    ADD CONSTRAINT components_a_user_word_refs_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.components_a_user_word_refs DROP CONSTRAINT components_a_user_word_refs_pkey;
       public            strapi    false    235            �           2606    57852 \   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_pkey;
       public            strapi    false    237            �           2606    57854 ^   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_unique UNIQUE (user_word_ref_id, user_word_id);
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_unique;
       public            strapi    false    237    237            �           2606    57856 4   components_a_verb_metas components_a_verb_metas_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.components_a_verb_metas
    ADD CONSTRAINT components_a_verb_metas_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.components_a_verb_metas DROP CONSTRAINT components_a_verb_metas_pkey;
       public            strapi    false    239            �           2606    57858 ,   components_a_videos components_a_videos_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.components_a_videos
    ADD CONSTRAINT components_a_videos_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.components_a_videos DROP CONSTRAINT components_a_videos_pkey;
       public            strapi    false    241            �           2606    57860 2   components_a_word_refs components_a_word_refs_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.components_a_word_refs
    ADD CONSTRAINT components_a_word_refs_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.components_a_word_refs DROP CONSTRAINT components_a_word_refs_pkey;
       public            strapi    false    243            �           2606    57862 H   components_a_word_refs_word_links components_a_word_refs_word_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_pkey;
       public            strapi    false    245            �           2606    57864 J   components_a_word_refs_word_links components_a_word_refs_word_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_unique UNIQUE (word_ref_id, word_id);
 t   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_unique;
       public            strapi    false    245    245            �           2606    57866 *   files_folder_links files_folder_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_pkey;
       public            strapi    false    248            �           2606    57868 ,   files_folder_links files_folder_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_unique;
       public            strapi    false    248    248            �           2606    57870    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            strapi    false    247            �           2606    57872 .   files_related_morphs files_related_morphs_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_pkey;
       public            strapi    false    251            �           2606    57874 0   flashcards_components flashcards_components_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_components_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_components_pkey;
       public            strapi    false    254            �           2606    57876 4   flashcards_lesson_links flashcards_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_pkey;
       public            strapi    false    257            �           2606    57878 6   flashcards_lesson_links flashcards_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_unique UNIQUE (flashcard_id, lesson_id);
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_unique;
       public            strapi    false    257    257            �           2606    57880 B   flashcards_localizations_links flashcards_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_pkey;
       public            strapi    false    259            �           2606    57882 D   flashcards_localizations_links flashcards_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_unique UNIQUE (flashcard_id, inv_flashcard_id);
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_unique;
       public            strapi    false    259    259            �           2606    57884    flashcards flashcards_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_pkey;
       public            strapi    false    253            �           2606    58800 '   flashcards_components flashcards_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_unique UNIQUE (entity_id, component_id, field, component_type);
 Q   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_unique;
       public            strapi    false    254    254    254    254            �           2606    57888 0   flashcards_user_links flashcards_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_pkey;
       public            strapi    false    261            �           2606    57890 2   flashcards_user_links flashcards_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_unique UNIQUE (flashcard_id, user_id);
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_unique;
       public            strapi    false    261    261            �           2606    57892    i18n_locale i18n_locale_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_pkey;
       public            strapi    false    263            �           2606    57894    lessonlevels lessonlevels_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_pkey;
       public            strapi    false    265                       2606    57896 *   lessons_components lessons_components_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_components_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_components_pkey;
       public            strapi    false    268            
           2606    57898 8   lessons_lessonlevel_links lessons_lessonlevel_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_pkey;
       public            strapi    false    271                       2606    57900 :   lessons_lessonlevel_links lessons_lessonlevel_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_unique UNIQUE (lesson_id, lessonlevel_id);
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_unique;
       public            strapi    false    271    271                       2606    57902 <   lessons_localizations_links lessons_localizations_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_pkey;
       public            strapi    false    273                       2606    57904 >   lessons_localizations_links lessons_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_unique UNIQUE (lesson_id, inv_lesson_id);
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_unique;
       public            strapi    false    273    273            �           2606    57906    lessons lessons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_pkey;
       public            strapi    false    267            �           2606    57908    lessons lessons_slug_unique 
   CONSTRAINT     V   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_unique UNIQUE (slug);
 E   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_slug_unique;
       public            strapi    false    267                       2606    58802 !   lessons_components lessons_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_unique UNIQUE (entity_id, component_id, field, component_type);
 K   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_unique;
       public            strapi    false    268    268    268    268                       2606    57912 *   lessons_unit_links lessons_unit_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_pkey;
       public            strapi    false    275                       2606    57914 ,   lessons_unit_links lessons_unit_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_unique UNIQUE (lesson_id, unit_id);
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_unique;
       public            strapi    false    275    275                       2606    57916    reviewlogs reviewlogs_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_pkey;
       public            strapi    false    277            #           2606    57918 0   reviewlogs_user_links reviewlogs_user_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_pkey;
       public            strapi    false    279            %           2606    57920 2   reviewlogs_user_links reviewlogs_user_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_unique UNIQUE (reviewlog_id, user_id);
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_unique;
       public            strapi    false    279    279            ,           2606    57922 ,   sections_components sections_components_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_components_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_components_pkey;
       public            strapi    false    282            5           2606    57924 0   sections_lesson_links sections_lesson_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_pkey;
       public            strapi    false    285            7           2606    57926 2   sections_lesson_links sections_lesson_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_unique UNIQUE (section_id, lesson_id);
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_unique;
       public            strapi    false    285    285            <           2606    57928 >   sections_localizations_links sections_localizations_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_pkey;
       public            strapi    false    287            >           2606    57930 @   sections_localizations_links sections_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_unique UNIQUE (section_id, inv_section_id);
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_unique;
       public            strapi    false    287    287            (           2606    57932    sections sections_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_pkey;
       public            strapi    false    281            0           2606    58804 #   sections_components sections_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_unique UNIQUE (entity_id, component_id, field, component_type);
 M   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_unique;
       public            strapi    false    282    282    282    282            E           2606    57936 .   sentences_components sentences_components_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_components_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_components_pkey;
       public            strapi    false    290            N           2606    57938 @   sentences_localizations_links sentences_localizations_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_pkey;
       public            strapi    false    293            P           2606    57940 B   sentences_localizations_links sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_unique UNIQUE (sentence_id, inv_sentence_id);
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_unique;
       public            strapi    false    293    293            A           2606    57942    sentences sentences_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_pkey;
       public            strapi    false    289            I           2606    58806 %   sentences_components sentences_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_unique UNIQUE (entity_id, component_id, field, component_type);
 O   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_unique;
       public            strapi    false    290    290    290    290            S           2606    57946 >   strapi_api_token_permissions strapi_api_token_permissions_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_pkey;
       public            strapi    false    295            Y           2606    57948 V   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_pkey;
       public            strapi    false    297            [           2606    57950 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_unique;
       public            strapi    false    297    297            ^           2606    57952 (   strapi_api_tokens strapi_api_tokens_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_pkey;
       public            strapi    false    299            a           2606    57954 :   strapi_core_store_settings strapi_core_store_settings_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.strapi_core_store_settings DROP CONSTRAINT strapi_core_store_settings_pkey;
       public            strapi    false    301            c           2606    57956 2   strapi_database_schema strapi_database_schema_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_database_schema DROP CONSTRAINT strapi_database_schema_pkey;
       public            strapi    false    303            e           2606    57958 (   strapi_migrations strapi_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_migrations DROP CONSTRAINT strapi_migrations_pkey;
       public            strapi    false    305            h           2606    57960 H   strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_pkey;
       public            strapi    false    307            n           2606    57962 `   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_pkey;
       public            strapi    false    309            p           2606    57964 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_unique UNIQUE (transfer_token_permission_id, transfer_token_id);
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_unique;
       public            strapi    false    309    309            s           2606    57966 2   strapi_transfer_tokens strapi_transfer_tokens_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_pkey;
       public            strapi    false    311            v           2606    57968 $   strapi_webhooks strapi_webhooks_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.strapi_webhooks DROP CONSTRAINT strapi_webhooks_pkey;
       public            strapi    false    313            �           2606    57970 8   units_localizations_links units_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_pkey;
       public            strapi    false    317            �           2606    57972 :   units_localizations_links units_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_unique UNIQUE (unit_id, inv_unit_id);
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_unique;
       public            strapi    false    317    317            y           2606    57974    units units_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.units DROP CONSTRAINT units_pkey;
       public            strapi    false    315            �           2606    57976 6   units_precondition_links units_precondition_links_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_pkey;
       public            strapi    false    319            �           2606    57978 8   units_precondition_links units_precondition_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_unique UNIQUE (unit_id, inv_unit_id);
 b   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_unique;
       public            strapi    false    319    319            {           2606    57980    units units_slug_unique 
   CONSTRAINT     R   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_slug_unique UNIQUE (slug);
 A   ALTER TABLE ONLY public.units DROP CONSTRAINT units_slug_unique;
       public            strapi    false    315            �           2606    57982 "   up_permissions up_permissions_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_pkey;
       public            strapi    false    321            �           2606    57984 8   up_permissions_role_links up_permissions_role_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_pkey;
       public            strapi    false    323            �           2606    57986 :   up_permissions_role_links up_permissions_role_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_unique UNIQUE (permission_id, role_id);
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_unique;
       public            strapi    false    323    323            �           2606    57988    up_roles up_roles_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_pkey;
       public            strapi    false    325            �           2606    57990    up_users up_users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_pkey;
       public            strapi    false    327            �           2606    57992 ,   up_users_role_links up_users_role_links_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_pkey;
       public            strapi    false    329            �           2606    57994 .   up_users_role_links up_users_role_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_unique UNIQUE (user_id, role_id);
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_unique;
       public            strapi    false    329    329            �           2606    57996 <   upload_folders_parent_links upload_folders_parent_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_pkey;
       public            strapi    false    333            �           2606    57998 >   upload_folders_parent_links upload_folders_parent_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_unique UNIQUE (folder_id, inv_folder_id);
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_unique;
       public            strapi    false    333    333            �           2606    58000 +   upload_folders upload_folders_path_id_index 
   CONSTRAINT     i   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);
 U   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_path_id_index;
       public            strapi    false    331            �           2606    58002 (   upload_folders upload_folders_path_index 
   CONSTRAINT     c   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);
 R   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_path_index;
       public            strapi    false    331            �           2606    58004 "   upload_folders upload_folders_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_pkey;
       public            strapi    false    331            �           2606    58006 <   user_sentences_lesson_links user_sentences_lesson_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_pkey;
       public            strapi    false    337            �           2606    58008 >   user_sentences_lesson_links user_sentences_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_unique UNIQUE (user_sentence_id, lesson_id);
 h   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_unique;
       public            strapi    false    337    337            �           2606    58010 J   user_sentences_localizations_links user_sentences_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_pkey PRIMARY KEY (id);
 t   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_pkey;
       public            strapi    false    339            �           2606    58012 L   user_sentences_localizations_links user_sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_unique UNIQUE (user_sentence_id, inv_user_sentence_id);
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_unique;
       public            strapi    false    339    339            �           2606    58014 "   user_sentences user_sentences_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_pkey;
       public            strapi    false    335            �           2606    58016 \   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_pkey;
       public            strapi    false    341            �           2606    58018 ^   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_unique UNIQUE (user_sentence_id, user_id);
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_unique;
       public            strapi    false    341    341            �           2606    58020 4   user_words_lesson_links user_words_lesson_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_pkey;
       public            strapi    false    345            �           2606    58022 6   user_words_lesson_links user_words_lesson_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_unique UNIQUE (user_word_id, lesson_id);
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_unique;
       public            strapi    false    345    345            �           2606    58024 B   user_words_localizations_links user_words_localizations_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_pkey;
       public            strapi    false    347            �           2606    58026 D   user_words_localizations_links user_words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_unique UNIQUE (user_word_id, inv_user_word_id);
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_unique;
       public            strapi    false    347    347            �           2606    58028    user_words user_words_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_pkey;
       public            strapi    false    343            �           2606    58030 T   user_words_users_permissions_user_links user_words_users_permissions_user_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_pkey PRIMARY KEY (id);
 ~   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_pkey;
       public            strapi    false    349            �           2606    58032 V   user_words_users_permissions_user_links user_words_users_permissions_user_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_unique UNIQUE (user_word_id, user_id);
 �   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_unique;
       public            strapi    false    349    349            �           2606    58034 &   words_components words_components_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_components_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_components_pkey;
       public            strapi    false    352            �           2606    58036 @   words_example_sentences_links words_example_sentences_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_pkey;
       public            strapi    false    354            �           2606    58038 B   words_example_sentences_links words_example_sentences_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_unique UNIQUE (word_id, sentence_id);
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_unique;
       public            strapi    false    354    354            �           2606    58040 8   words_localizations_links words_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_pkey;
       public            strapi    false    357            �           2606    58042 :   words_localizations_links words_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_unique UNIQUE (word_id, inv_word_id);
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_unique;
       public            strapi    false    357    357            �           2606    58044    words words_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.words DROP CONSTRAINT words_pkey;
       public            strapi    false    351            �           2606    58808    words_components words_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_unique UNIQUE (entity_id, component_id, field, component_type);
 G   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_unique;
       public            strapi    false    352    352    352    352            t           1259    58047 "   admin_permissions_created_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);
 6   DROP INDEX public.admin_permissions_created_by_id_fk;
       public            strapi    false    209            x           1259    58048    admin_permissions_role_links_fk    INDEX     q   CREATE INDEX admin_permissions_role_links_fk ON public.admin_permissions_role_links USING btree (permission_id);
 3   DROP INDEX public.admin_permissions_role_links_fk;
       public            strapi    false    211            y           1259    58049 #   admin_permissions_role_links_inv_fk    INDEX     o   CREATE INDEX admin_permissions_role_links_inv_fk ON public.admin_permissions_role_links USING btree (role_id);
 7   DROP INDEX public.admin_permissions_role_links_inv_fk;
       public            strapi    false    211            z           1259    58050 )   admin_permissions_role_links_order_inv_fk    INDEX     ~   CREATE INDEX admin_permissions_role_links_order_inv_fk ON public.admin_permissions_role_links USING btree (permission_order);
 =   DROP INDEX public.admin_permissions_role_links_order_inv_fk;
       public            strapi    false    211            w           1259    58051 "   admin_permissions_updated_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);
 6   DROP INDEX public.admin_permissions_updated_by_id_fk;
       public            strapi    false    209                       1259    58052    admin_roles_created_by_id_fk    INDEX     ]   CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);
 0   DROP INDEX public.admin_roles_created_by_id_fk;
       public            strapi    false    213            �           1259    58053    admin_roles_updated_by_id_fk    INDEX     ]   CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);
 0   DROP INDEX public.admin_roles_updated_by_id_fk;
       public            strapi    false    213            �           1259    58054    admin_users_created_by_id_fk    INDEX     ]   CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);
 0   DROP INDEX public.admin_users_created_by_id_fk;
       public            strapi    false    215            �           1259    58055    admin_users_roles_links_fk    INDEX     a   CREATE INDEX admin_users_roles_links_fk ON public.admin_users_roles_links USING btree (user_id);
 .   DROP INDEX public.admin_users_roles_links_fk;
       public            strapi    false    217            �           1259    58056    admin_users_roles_links_inv_fk    INDEX     e   CREATE INDEX admin_users_roles_links_inv_fk ON public.admin_users_roles_links USING btree (role_id);
 2   DROP INDEX public.admin_users_roles_links_inv_fk;
       public            strapi    false    217            �           1259    58057     admin_users_roles_links_order_fk    INDEX     j   CREATE INDEX admin_users_roles_links_order_fk ON public.admin_users_roles_links USING btree (role_order);
 4   DROP INDEX public.admin_users_roles_links_order_fk;
       public            strapi    false    217            �           1259    58058 $   admin_users_roles_links_order_inv_fk    INDEX     n   CREATE INDEX admin_users_roles_links_order_inv_fk ON public.admin_users_roles_links USING btree (user_order);
 8   DROP INDEX public.admin_users_roles_links_order_inv_fk;
       public            strapi    false    217            �           1259    58059    admin_users_updated_by_id_fk    INDEX     ]   CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);
 0   DROP INDEX public.admin_users_updated_by_id_fk;
       public            strapi    false    215            �           1259    58060 (   components_a_sent_refs_sentence_links_fk    INDEX     �   CREATE INDEX components_a_sent_refs_sentence_links_fk ON public.components_a_sent_refs_sentence_links USING btree (sent_ref_id);
 <   DROP INDEX public.components_a_sent_refs_sentence_links_fk;
       public            strapi    false    227            �           1259    58061 ,   components_a_sent_refs_sentence_links_inv_fk    INDEX     �   CREATE INDEX components_a_sent_refs_sentence_links_inv_fk ON public.components_a_sent_refs_sentence_links USING btree (sentence_id);
 @   DROP INDEX public.components_a_sent_refs_sentence_links_inv_fk;
       public            strapi    false    227            �           1259    58062 2   components_a_user_sent_refs_user_sentence_links_fk    INDEX     �   CREATE INDEX components_a_user_sent_refs_user_sentence_links_fk ON public.components_a_user_sent_refs_user_sentence_links USING btree (user_sent_ref_id);
 F   DROP INDEX public.components_a_user_sent_refs_user_sentence_links_fk;
       public            strapi    false    233            �           1259    58063 6   components_a_user_sent_refs_user_sentence_links_inv_fk    INDEX     �   CREATE INDEX components_a_user_sent_refs_user_sentence_links_inv_fk ON public.components_a_user_sent_refs_user_sentence_links USING btree (user_sentence_id);
 J   DROP INDEX public.components_a_user_sent_refs_user_sentence_links_inv_fk;
       public            strapi    false    233            �           1259    58064 .   components_a_user_word_refs_user_word_links_fk    INDEX     �   CREATE INDEX components_a_user_word_refs_user_word_links_fk ON public.components_a_user_word_refs_user_word_links USING btree (user_word_ref_id);
 B   DROP INDEX public.components_a_user_word_refs_user_word_links_fk;
       public            strapi    false    237            �           1259    58065 2   components_a_user_word_refs_user_word_links_inv_fk    INDEX     �   CREATE INDEX components_a_user_word_refs_user_word_links_inv_fk ON public.components_a_user_word_refs_user_word_links USING btree (user_word_id);
 F   DROP INDEX public.components_a_user_word_refs_user_word_links_inv_fk;
       public            strapi    false    237            �           1259    58066 $   components_a_word_refs_word_links_fk    INDEX     y   CREATE INDEX components_a_word_refs_word_links_fk ON public.components_a_word_refs_word_links USING btree (word_ref_id);
 8   DROP INDEX public.components_a_word_refs_word_links_fk;
       public            strapi    false    245            �           1259    58067 (   components_a_word_refs_word_links_inv_fk    INDEX     y   CREATE INDEX components_a_word_refs_word_links_inv_fk ON public.components_a_word_refs_word_links USING btree (word_id);
 <   DROP INDEX public.components_a_word_refs_word_links_inv_fk;
       public            strapi    false    245            �           1259    58068    files_created_by_id_fk    INDEX     Q   CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);
 *   DROP INDEX public.files_created_by_id_fk;
       public            strapi    false    247            �           1259    58069    files_folder_links_fk    INDEX     W   CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);
 )   DROP INDEX public.files_folder_links_fk;
       public            strapi    false    248            �           1259    58070    files_folder_links_inv_fk    INDEX     ]   CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);
 -   DROP INDEX public.files_folder_links_inv_fk;
       public            strapi    false    248            �           1259    58071    files_folder_links_order_inv_fk    INDEX     d   CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);
 3   DROP INDEX public.files_folder_links_order_inv_fk;
       public            strapi    false    248            �           1259    58072    files_related_morphs_fk    INDEX     [   CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);
 +   DROP INDEX public.files_related_morphs_fk;
       public            strapi    false    251            �           1259    58073 $   files_related_morphs_id_column_index    INDEX     k   CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);
 8   DROP INDEX public.files_related_morphs_id_column_index;
       public            strapi    false    251            �           1259    58074     files_related_morphs_order_index    INDEX     d   CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");
 4   DROP INDEX public.files_related_morphs_order_index;
       public            strapi    false    251            �           1259    58075    files_updated_by_id_fk    INDEX     Q   CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);
 *   DROP INDEX public.files_updated_by_id_fk;
       public            strapi    false    247            �           1259    58076    flashcards_component_type_index    INDEX     k   CREATE INDEX flashcards_component_type_index ON public.flashcards_components USING btree (component_type);
 3   DROP INDEX public.flashcards_component_type_index;
       public            strapi    false    254            �           1259    58077    flashcards_created_by_id_fk    INDEX     [   CREATE INDEX flashcards_created_by_id_fk ON public.flashcards USING btree (created_by_id);
 /   DROP INDEX public.flashcards_created_by_id_fk;
       public            strapi    false    253            �           1259    58078    flashcards_entity_fk    INDEX     [   CREATE INDEX flashcards_entity_fk ON public.flashcards_components USING btree (entity_id);
 (   DROP INDEX public.flashcards_entity_fk;
       public            strapi    false    254            �           1259    58079    flashcards_field_index    INDEX     Y   CREATE INDEX flashcards_field_index ON public.flashcards_components USING btree (field);
 *   DROP INDEX public.flashcards_field_index;
       public            strapi    false    254            �           1259    58080    flashcards_lesson_links_fk    INDEX     f   CREATE INDEX flashcards_lesson_links_fk ON public.flashcards_lesson_links USING btree (flashcard_id);
 .   DROP INDEX public.flashcards_lesson_links_fk;
       public            strapi    false    257            �           1259    58081    flashcards_lesson_links_inv_fk    INDEX     g   CREATE INDEX flashcards_lesson_links_inv_fk ON public.flashcards_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.flashcards_lesson_links_inv_fk;
       public            strapi    false    257            �           1259    58082 $   flashcards_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX flashcards_lesson_links_order_inv_fk ON public.flashcards_lesson_links USING btree (flashcard_order);
 8   DROP INDEX public.flashcards_lesson_links_order_inv_fk;
       public            strapi    false    257            �           1259    58083 !   flashcards_localizations_links_fk    INDEX     t   CREATE INDEX flashcards_localizations_links_fk ON public.flashcards_localizations_links USING btree (flashcard_id);
 5   DROP INDEX public.flashcards_localizations_links_fk;
       public            strapi    false    259            �           1259    58084 %   flashcards_localizations_links_inv_fk    INDEX     |   CREATE INDEX flashcards_localizations_links_inv_fk ON public.flashcards_localizations_links USING btree (inv_flashcard_id);
 9   DROP INDEX public.flashcards_localizations_links_inv_fk;
       public            strapi    false    259            �           1259    58085 '   flashcards_localizations_links_order_fk    INDEX     }   CREATE INDEX flashcards_localizations_links_order_fk ON public.flashcards_localizations_links USING btree (flashcard_order);
 ;   DROP INDEX public.flashcards_localizations_links_order_fk;
       public            strapi    false    259            �           1259    58086    flashcards_updated_by_id_fk    INDEX     [   CREATE INDEX flashcards_updated_by_id_fk ON public.flashcards USING btree (updated_by_id);
 /   DROP INDEX public.flashcards_updated_by_id_fk;
       public            strapi    false    253            �           1259    58087    flashcards_user_links_fk    INDEX     b   CREATE INDEX flashcards_user_links_fk ON public.flashcards_user_links USING btree (flashcard_id);
 ,   DROP INDEX public.flashcards_user_links_fk;
       public            strapi    false    261            �           1259    58088    flashcards_user_links_inv_fk    INDEX     a   CREATE INDEX flashcards_user_links_inv_fk ON public.flashcards_user_links USING btree (user_id);
 0   DROP INDEX public.flashcards_user_links_inv_fk;
       public            strapi    false    261            �           1259    58089 "   flashcards_user_links_order_inv_fk    INDEX     o   CREATE INDEX flashcards_user_links_order_inv_fk ON public.flashcards_user_links USING btree (flashcard_order);
 6   DROP INDEX public.flashcards_user_links_order_inv_fk;
       public            strapi    false    261            �           1259    58090    i18n_locale_created_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);
 0   DROP INDEX public.i18n_locale_created_by_id_fk;
       public            strapi    false    263            �           1259    58091    i18n_locale_updated_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);
 0   DROP INDEX public.i18n_locale_updated_by_id_fk;
       public            strapi    false    263            �           1259    58092    lessonlevels_created_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_created_by_id_fk ON public.lessonlevels USING btree (created_by_id);
 1   DROP INDEX public.lessonlevels_created_by_id_fk;
       public            strapi    false    265            �           1259    58093    lessonlevels_updated_by_id_fk    INDEX     _   CREATE INDEX lessonlevels_updated_by_id_fk ON public.lessonlevels USING btree (updated_by_id);
 1   DROP INDEX public.lessonlevels_updated_by_id_fk;
       public            strapi    false    265            �           1259    58094    lessons_component_type_index    INDEX     e   CREATE INDEX lessons_component_type_index ON public.lessons_components USING btree (component_type);
 0   DROP INDEX public.lessons_component_type_index;
       public            strapi    false    268            �           1259    58095    lessons_created_by_id_fk    INDEX     U   CREATE INDEX lessons_created_by_id_fk ON public.lessons USING btree (created_by_id);
 ,   DROP INDEX public.lessons_created_by_id_fk;
       public            strapi    false    267                       1259    58096    lessons_entity_fk    INDEX     U   CREATE INDEX lessons_entity_fk ON public.lessons_components USING btree (entity_id);
 %   DROP INDEX public.lessons_entity_fk;
       public            strapi    false    268                       1259    58097    lessons_field_index    INDEX     S   CREATE INDEX lessons_field_index ON public.lessons_components USING btree (field);
 '   DROP INDEX public.lessons_field_index;
       public            strapi    false    268                       1259    58098    lessons_lessonlevel_links_fk    INDEX     g   CREATE INDEX lessons_lessonlevel_links_fk ON public.lessons_lessonlevel_links USING btree (lesson_id);
 0   DROP INDEX public.lessons_lessonlevel_links_fk;
       public            strapi    false    271                       1259    58099     lessons_lessonlevel_links_inv_fk    INDEX     p   CREATE INDEX lessons_lessonlevel_links_inv_fk ON public.lessons_lessonlevel_links USING btree (lessonlevel_id);
 4   DROP INDEX public.lessons_lessonlevel_links_inv_fk;
       public            strapi    false    271                       1259    58100 &   lessons_lessonlevel_links_order_inv_fk    INDEX     t   CREATE INDEX lessons_lessonlevel_links_order_inv_fk ON public.lessons_lessonlevel_links USING btree (lesson_order);
 :   DROP INDEX public.lessons_lessonlevel_links_order_inv_fk;
       public            strapi    false    271                       1259    58101    lessons_localizations_links_fk    INDEX     k   CREATE INDEX lessons_localizations_links_fk ON public.lessons_localizations_links USING btree (lesson_id);
 2   DROP INDEX public.lessons_localizations_links_fk;
       public            strapi    false    273                       1259    58102 "   lessons_localizations_links_inv_fk    INDEX     s   CREATE INDEX lessons_localizations_links_inv_fk ON public.lessons_localizations_links USING btree (inv_lesson_id);
 6   DROP INDEX public.lessons_localizations_links_inv_fk;
       public            strapi    false    273                       1259    58103 $   lessons_localizations_links_order_fk    INDEX     t   CREATE INDEX lessons_localizations_links_order_fk ON public.lessons_localizations_links USING btree (lesson_order);
 8   DROP INDEX public.lessons_localizations_links_order_fk;
       public            strapi    false    273                       1259    58104    lessons_unit_links_fk    INDEX     Y   CREATE INDEX lessons_unit_links_fk ON public.lessons_unit_links USING btree (lesson_id);
 )   DROP INDEX public.lessons_unit_links_fk;
       public            strapi    false    275                       1259    58105    lessons_unit_links_inv_fk    INDEX     [   CREATE INDEX lessons_unit_links_inv_fk ON public.lessons_unit_links USING btree (unit_id);
 -   DROP INDEX public.lessons_unit_links_inv_fk;
       public            strapi    false    275                       1259    58106    lessons_unit_links_order_inv_fk    INDEX     f   CREATE INDEX lessons_unit_links_order_inv_fk ON public.lessons_unit_links USING btree (lesson_order);
 3   DROP INDEX public.lessons_unit_links_order_inv_fk;
       public            strapi    false    275            �           1259    58107    lessons_updated_by_id_fk    INDEX     U   CREATE INDEX lessons_updated_by_id_fk ON public.lessons USING btree (updated_by_id);
 ,   DROP INDEX public.lessons_updated_by_id_fk;
       public            strapi    false    267                       1259    58108    reviewlogs_created_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_created_by_id_fk ON public.reviewlogs USING btree (created_by_id);
 /   DROP INDEX public.reviewlogs_created_by_id_fk;
       public            strapi    false    277                       1259    58109    reviewlogs_updated_by_id_fk    INDEX     [   CREATE INDEX reviewlogs_updated_by_id_fk ON public.reviewlogs USING btree (updated_by_id);
 /   DROP INDEX public.reviewlogs_updated_by_id_fk;
       public            strapi    false    277                       1259    58110    reviewlogs_user_links_fk    INDEX     b   CREATE INDEX reviewlogs_user_links_fk ON public.reviewlogs_user_links USING btree (reviewlog_id);
 ,   DROP INDEX public.reviewlogs_user_links_fk;
       public            strapi    false    279                        1259    58111    reviewlogs_user_links_inv_fk    INDEX     a   CREATE INDEX reviewlogs_user_links_inv_fk ON public.reviewlogs_user_links USING btree (user_id);
 0   DROP INDEX public.reviewlogs_user_links_inv_fk;
       public            strapi    false    279            !           1259    58112 "   reviewlogs_user_links_order_inv_fk    INDEX     o   CREATE INDEX reviewlogs_user_links_order_inv_fk ON public.reviewlogs_user_links USING btree (reviewlog_order);
 6   DROP INDEX public.reviewlogs_user_links_order_inv_fk;
       public            strapi    false    279            *           1259    58113    sections_component_type_index    INDEX     g   CREATE INDEX sections_component_type_index ON public.sections_components USING btree (component_type);
 1   DROP INDEX public.sections_component_type_index;
       public            strapi    false    282            &           1259    58114    sections_created_by_id_fk    INDEX     W   CREATE INDEX sections_created_by_id_fk ON public.sections USING btree (created_by_id);
 -   DROP INDEX public.sections_created_by_id_fk;
       public            strapi    false    281            -           1259    58115    sections_entity_fk    INDEX     W   CREATE INDEX sections_entity_fk ON public.sections_components USING btree (entity_id);
 &   DROP INDEX public.sections_entity_fk;
       public            strapi    false    282            .           1259    58116    sections_field_index    INDEX     U   CREATE INDEX sections_field_index ON public.sections_components USING btree (field);
 (   DROP INDEX public.sections_field_index;
       public            strapi    false    282            1           1259    58117    sections_lesson_links_fk    INDEX     `   CREATE INDEX sections_lesson_links_fk ON public.sections_lesson_links USING btree (section_id);
 ,   DROP INDEX public.sections_lesson_links_fk;
       public            strapi    false    285            2           1259    58118    sections_lesson_links_inv_fk    INDEX     c   CREATE INDEX sections_lesson_links_inv_fk ON public.sections_lesson_links USING btree (lesson_id);
 0   DROP INDEX public.sections_lesson_links_inv_fk;
       public            strapi    false    285            3           1259    58119 "   sections_lesson_links_order_inv_fk    INDEX     m   CREATE INDEX sections_lesson_links_order_inv_fk ON public.sections_lesson_links USING btree (section_order);
 6   DROP INDEX public.sections_lesson_links_order_inv_fk;
       public            strapi    false    285            8           1259    58120    sections_localizations_links_fk    INDEX     n   CREATE INDEX sections_localizations_links_fk ON public.sections_localizations_links USING btree (section_id);
 3   DROP INDEX public.sections_localizations_links_fk;
       public            strapi    false    287            9           1259    58121 #   sections_localizations_links_inv_fk    INDEX     v   CREATE INDEX sections_localizations_links_inv_fk ON public.sections_localizations_links USING btree (inv_section_id);
 7   DROP INDEX public.sections_localizations_links_inv_fk;
       public            strapi    false    287            :           1259    58122 %   sections_localizations_links_order_fk    INDEX     w   CREATE INDEX sections_localizations_links_order_fk ON public.sections_localizations_links USING btree (section_order);
 9   DROP INDEX public.sections_localizations_links_order_fk;
       public            strapi    false    287            )           1259    58123    sections_updated_by_id_fk    INDEX     W   CREATE INDEX sections_updated_by_id_fk ON public.sections USING btree (updated_by_id);
 -   DROP INDEX public.sections_updated_by_id_fk;
       public            strapi    false    281            C           1259    58124    sentences_component_type_index    INDEX     i   CREATE INDEX sentences_component_type_index ON public.sentences_components USING btree (component_type);
 2   DROP INDEX public.sentences_component_type_index;
       public            strapi    false    290            ?           1259    58125    sentences_created_by_id_fk    INDEX     Y   CREATE INDEX sentences_created_by_id_fk ON public.sentences USING btree (created_by_id);
 .   DROP INDEX public.sentences_created_by_id_fk;
       public            strapi    false    289            F           1259    58126    sentences_entity_fk    INDEX     Y   CREATE INDEX sentences_entity_fk ON public.sentences_components USING btree (entity_id);
 '   DROP INDEX public.sentences_entity_fk;
       public            strapi    false    290            G           1259    58127    sentences_field_index    INDEX     W   CREATE INDEX sentences_field_index ON public.sentences_components USING btree (field);
 )   DROP INDEX public.sentences_field_index;
       public            strapi    false    290            J           1259    58128     sentences_localizations_links_fk    INDEX     q   CREATE INDEX sentences_localizations_links_fk ON public.sentences_localizations_links USING btree (sentence_id);
 4   DROP INDEX public.sentences_localizations_links_fk;
       public            strapi    false    293            K           1259    58129 $   sentences_localizations_links_inv_fk    INDEX     y   CREATE INDEX sentences_localizations_links_inv_fk ON public.sentences_localizations_links USING btree (inv_sentence_id);
 8   DROP INDEX public.sentences_localizations_links_inv_fk;
       public            strapi    false    293            L           1259    58130 &   sentences_localizations_links_order_fk    INDEX     z   CREATE INDEX sentences_localizations_links_order_fk ON public.sentences_localizations_links USING btree (sentence_order);
 :   DROP INDEX public.sentences_localizations_links_order_fk;
       public            strapi    false    293            B           1259    58131    sentences_updated_by_id_fk    INDEX     Y   CREATE INDEX sentences_updated_by_id_fk ON public.sentences USING btree (updated_by_id);
 .   DROP INDEX public.sentences_updated_by_id_fk;
       public            strapi    false    289            Q           1259    58132 -   strapi_api_token_permissions_created_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_created_by_id_fk;
       public            strapi    false    295            U           1259    58133 +   strapi_api_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);
 ?   DROP INDEX public.strapi_api_token_permissions_token_links_fk;
       public            strapi    false    297            V           1259    58134 /   strapi_api_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);
 C   DROP INDEX public.strapi_api_token_permissions_token_links_inv_fk;
       public            strapi    false    297            W           1259    58135 5   strapi_api_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);
 I   DROP INDEX public.strapi_api_token_permissions_token_links_order_inv_fk;
       public            strapi    false    297            T           1259    58136 -   strapi_api_token_permissions_updated_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_updated_by_id_fk;
       public            strapi    false    295            \           1259    58137 "   strapi_api_tokens_created_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);
 6   DROP INDEX public.strapi_api_tokens_created_by_id_fk;
       public            strapi    false    299            _           1259    58138 "   strapi_api_tokens_updated_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);
 6   DROP INDEX public.strapi_api_tokens_updated_by_id_fk;
       public            strapi    false    299            f           1259    58139 2   strapi_transfer_token_permissions_created_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_created_by_id_fk;
       public            strapi    false    307            j           1259    58140 0   strapi_transfer_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);
 D   DROP INDEX public.strapi_transfer_token_permissions_token_links_fk;
       public            strapi    false    309            k           1259    58141 4   strapi_transfer_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);
 H   DROP INDEX public.strapi_transfer_token_permissions_token_links_inv_fk;
       public            strapi    false    309            l           1259    58142 :   strapi_transfer_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);
 N   DROP INDEX public.strapi_transfer_token_permissions_token_links_order_inv_fk;
       public            strapi    false    309            i           1259    58143 2   strapi_transfer_token_permissions_updated_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_updated_by_id_fk;
       public            strapi    false    307            q           1259    58144 '   strapi_transfer_tokens_created_by_id_fk    INDEX     s   CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);
 ;   DROP INDEX public.strapi_transfer_tokens_created_by_id_fk;
       public            strapi    false    311            t           1259    58145 '   strapi_transfer_tokens_updated_by_id_fk    INDEX     s   CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);
 ;   DROP INDEX public.strapi_transfer_tokens_updated_by_id_fk;
       public            strapi    false    311            w           1259    58146    units_created_by_id_fk    INDEX     Q   CREATE INDEX units_created_by_id_fk ON public.units USING btree (created_by_id);
 *   DROP INDEX public.units_created_by_id_fk;
       public            strapi    false    315            }           1259    58147    units_localizations_links_fk    INDEX     e   CREATE INDEX units_localizations_links_fk ON public.units_localizations_links USING btree (unit_id);
 0   DROP INDEX public.units_localizations_links_fk;
       public            strapi    false    317            ~           1259    58148     units_localizations_links_inv_fk    INDEX     m   CREATE INDEX units_localizations_links_inv_fk ON public.units_localizations_links USING btree (inv_unit_id);
 4   DROP INDEX public.units_localizations_links_inv_fk;
       public            strapi    false    317                       1259    58149 "   units_localizations_links_order_fk    INDEX     n   CREATE INDEX units_localizations_links_order_fk ON public.units_localizations_links USING btree (unit_order);
 6   DROP INDEX public.units_localizations_links_order_fk;
       public            strapi    false    317            �           1259    58150    units_precondition_links_fk    INDEX     c   CREATE INDEX units_precondition_links_fk ON public.units_precondition_links USING btree (unit_id);
 /   DROP INDEX public.units_precondition_links_fk;
       public            strapi    false    319            �           1259    58151    units_precondition_links_inv_fk    INDEX     k   CREATE INDEX units_precondition_links_inv_fk ON public.units_precondition_links USING btree (inv_unit_id);
 3   DROP INDEX public.units_precondition_links_inv_fk;
       public            strapi    false    319            |           1259    58152    units_updated_by_id_fk    INDEX     Q   CREATE INDEX units_updated_by_id_fk ON public.units USING btree (updated_by_id);
 *   DROP INDEX public.units_updated_by_id_fk;
       public            strapi    false    315            �           1259    58153    up_permissions_created_by_id_fk    INDEX     c   CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);
 3   DROP INDEX public.up_permissions_created_by_id_fk;
       public            strapi    false    321            �           1259    58154    up_permissions_role_links_fk    INDEX     k   CREATE INDEX up_permissions_role_links_fk ON public.up_permissions_role_links USING btree (permission_id);
 0   DROP INDEX public.up_permissions_role_links_fk;
       public            strapi    false    323            �           1259    58155     up_permissions_role_links_inv_fk    INDEX     i   CREATE INDEX up_permissions_role_links_inv_fk ON public.up_permissions_role_links USING btree (role_id);
 4   DROP INDEX public.up_permissions_role_links_inv_fk;
       public            strapi    false    323            �           1259    58156 &   up_permissions_role_links_order_inv_fk    INDEX     x   CREATE INDEX up_permissions_role_links_order_inv_fk ON public.up_permissions_role_links USING btree (permission_order);
 :   DROP INDEX public.up_permissions_role_links_order_inv_fk;
       public            strapi    false    323            �           1259    58157    up_permissions_updated_by_id_fk    INDEX     c   CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);
 3   DROP INDEX public.up_permissions_updated_by_id_fk;
       public            strapi    false    321            �           1259    58158    up_roles_created_by_id_fk    INDEX     W   CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);
 -   DROP INDEX public.up_roles_created_by_id_fk;
       public            strapi    false    325            �           1259    58159    up_roles_updated_by_id_fk    INDEX     W   CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);
 -   DROP INDEX public.up_roles_updated_by_id_fk;
       public            strapi    false    325            �           1259    58160    up_users_created_by_id_fk    INDEX     W   CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);
 -   DROP INDEX public.up_users_created_by_id_fk;
       public            strapi    false    327            �           1259    58161    up_users_role_links_fk    INDEX     Y   CREATE INDEX up_users_role_links_fk ON public.up_users_role_links USING btree (user_id);
 *   DROP INDEX public.up_users_role_links_fk;
       public            strapi    false    329            �           1259    58162    up_users_role_links_inv_fk    INDEX     ]   CREATE INDEX up_users_role_links_inv_fk ON public.up_users_role_links USING btree (role_id);
 .   DROP INDEX public.up_users_role_links_inv_fk;
       public            strapi    false    329            �           1259    58163     up_users_role_links_order_inv_fk    INDEX     f   CREATE INDEX up_users_role_links_order_inv_fk ON public.up_users_role_links USING btree (user_order);
 4   DROP INDEX public.up_users_role_links_order_inv_fk;
       public            strapi    false    329            �           1259    58164    up_users_updated_by_id_fk    INDEX     W   CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);
 -   DROP INDEX public.up_users_updated_by_id_fk;
       public            strapi    false    327            �           1259    58165    upload_files_created_at_index    INDEX     U   CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);
 1   DROP INDEX public.upload_files_created_at_index;
       public            strapi    false    247            �           1259    58166    upload_files_ext_index    INDEX     G   CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);
 *   DROP INDEX public.upload_files_ext_index;
       public            strapi    false    247            �           1259    58167    upload_files_folder_path_index    INDEX     W   CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);
 2   DROP INDEX public.upload_files_folder_path_index;
       public            strapi    false    247            �           1259    58168    upload_files_name_index    INDEX     I   CREATE INDEX upload_files_name_index ON public.files USING btree (name);
 +   DROP INDEX public.upload_files_name_index;
       public            strapi    false    247            �           1259    58169    upload_files_size_index    INDEX     I   CREATE INDEX upload_files_size_index ON public.files USING btree (size);
 +   DROP INDEX public.upload_files_size_index;
       public            strapi    false    247            �           1259    58170    upload_files_updated_at_index    INDEX     U   CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);
 1   DROP INDEX public.upload_files_updated_at_index;
       public            strapi    false    247            �           1259    58171    upload_folders_created_by_id_fk    INDEX     c   CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);
 3   DROP INDEX public.upload_folders_created_by_id_fk;
       public            strapi    false    331            �           1259    58172    upload_folders_parent_links_fk    INDEX     k   CREATE INDEX upload_folders_parent_links_fk ON public.upload_folders_parent_links USING btree (folder_id);
 2   DROP INDEX public.upload_folders_parent_links_fk;
       public            strapi    false    333            �           1259    58173 "   upload_folders_parent_links_inv_fk    INDEX     s   CREATE INDEX upload_folders_parent_links_inv_fk ON public.upload_folders_parent_links USING btree (inv_folder_id);
 6   DROP INDEX public.upload_folders_parent_links_inv_fk;
       public            strapi    false    333            �           1259    58174 (   upload_folders_parent_links_order_inv_fk    INDEX     x   CREATE INDEX upload_folders_parent_links_order_inv_fk ON public.upload_folders_parent_links USING btree (folder_order);
 <   DROP INDEX public.upload_folders_parent_links_order_inv_fk;
       public            strapi    false    333            �           1259    58175    upload_folders_updated_by_id_fk    INDEX     c   CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);
 3   DROP INDEX public.upload_folders_updated_by_id_fk;
       public            strapi    false    331            �           1259    58176    user_sentences_created_by_id_fk    INDEX     c   CREATE INDEX user_sentences_created_by_id_fk ON public.user_sentences USING btree (created_by_id);
 3   DROP INDEX public.user_sentences_created_by_id_fk;
       public            strapi    false    335            �           1259    58177    user_sentences_lesson_links_fk    INDEX     r   CREATE INDEX user_sentences_lesson_links_fk ON public.user_sentences_lesson_links USING btree (user_sentence_id);
 2   DROP INDEX public.user_sentences_lesson_links_fk;
       public            strapi    false    337            �           1259    58178 "   user_sentences_lesson_links_inv_fk    INDEX     o   CREATE INDEX user_sentences_lesson_links_inv_fk ON public.user_sentences_lesson_links USING btree (lesson_id);
 6   DROP INDEX public.user_sentences_lesson_links_inv_fk;
       public            strapi    false    337            �           1259    58179 (   user_sentences_lesson_links_order_inv_fk    INDEX        CREATE INDEX user_sentences_lesson_links_order_inv_fk ON public.user_sentences_lesson_links USING btree (user_sentence_order);
 <   DROP INDEX public.user_sentences_lesson_links_order_inv_fk;
       public            strapi    false    337            �           1259    58180 %   user_sentences_localizations_links_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_fk ON public.user_sentences_localizations_links USING btree (user_sentence_id);
 9   DROP INDEX public.user_sentences_localizations_links_fk;
       public            strapi    false    339            �           1259    58181 )   user_sentences_localizations_links_inv_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_inv_fk ON public.user_sentences_localizations_links USING btree (inv_user_sentence_id);
 =   DROP INDEX public.user_sentences_localizations_links_inv_fk;
       public            strapi    false    339            �           1259    58182 +   user_sentences_localizations_links_order_fk    INDEX     �   CREATE INDEX user_sentences_localizations_links_order_fk ON public.user_sentences_localizations_links USING btree (user_sentence_order);
 ?   DROP INDEX public.user_sentences_localizations_links_order_fk;
       public            strapi    false    339            �           1259    58183    user_sentences_updated_by_id_fk    INDEX     c   CREATE INDEX user_sentences_updated_by_id_fk ON public.user_sentences USING btree (updated_by_id);
 3   DROP INDEX public.user_sentences_updated_by_id_fk;
       public            strapi    false    335            �           1259    58184 .   user_sentences_users_permissions_user_links_fk    INDEX     �   CREATE INDEX user_sentences_users_permissions_user_links_fk ON public.user_sentences_users_permissions_user_links USING btree (user_sentence_id);
 B   DROP INDEX public.user_sentences_users_permissions_user_links_fk;
       public            strapi    false    341            �           1259    58185 2   user_sentences_users_permissions_user_links_inv_fk    INDEX     �   CREATE INDEX user_sentences_users_permissions_user_links_inv_fk ON public.user_sentences_users_permissions_user_links USING btree (user_id);
 F   DROP INDEX public.user_sentences_users_permissions_user_links_inv_fk;
       public            strapi    false    341            �           1259    58186 8   user_sentences_users_permissions_user_links_order_inv_fk    INDEX     �   CREATE INDEX user_sentences_users_permissions_user_links_order_inv_fk ON public.user_sentences_users_permissions_user_links USING btree (user_sentence_order);
 L   DROP INDEX public.user_sentences_users_permissions_user_links_order_inv_fk;
       public            strapi    false    341            �           1259    58187    user_words_created_by_id_fk    INDEX     [   CREATE INDEX user_words_created_by_id_fk ON public.user_words USING btree (created_by_id);
 /   DROP INDEX public.user_words_created_by_id_fk;
       public            strapi    false    343            �           1259    58188    user_words_lesson_links_fk    INDEX     f   CREATE INDEX user_words_lesson_links_fk ON public.user_words_lesson_links USING btree (user_word_id);
 .   DROP INDEX public.user_words_lesson_links_fk;
       public            strapi    false    345            �           1259    58189    user_words_lesson_links_inv_fk    INDEX     g   CREATE INDEX user_words_lesson_links_inv_fk ON public.user_words_lesson_links USING btree (lesson_id);
 2   DROP INDEX public.user_words_lesson_links_inv_fk;
       public            strapi    false    345            �           1259    58190 $   user_words_lesson_links_order_inv_fk    INDEX     s   CREATE INDEX user_words_lesson_links_order_inv_fk ON public.user_words_lesson_links USING btree (user_word_order);
 8   DROP INDEX public.user_words_lesson_links_order_inv_fk;
       public            strapi    false    345            �           1259    58191 !   user_words_localizations_links_fk    INDEX     t   CREATE INDEX user_words_localizations_links_fk ON public.user_words_localizations_links USING btree (user_word_id);
 5   DROP INDEX public.user_words_localizations_links_fk;
       public            strapi    false    347            �           1259    58192 %   user_words_localizations_links_inv_fk    INDEX     |   CREATE INDEX user_words_localizations_links_inv_fk ON public.user_words_localizations_links USING btree (inv_user_word_id);
 9   DROP INDEX public.user_words_localizations_links_inv_fk;
       public            strapi    false    347            �           1259    58193 '   user_words_localizations_links_order_fk    INDEX     }   CREATE INDEX user_words_localizations_links_order_fk ON public.user_words_localizations_links USING btree (user_word_order);
 ;   DROP INDEX public.user_words_localizations_links_order_fk;
       public            strapi    false    347            �           1259    58194    user_words_updated_by_id_fk    INDEX     [   CREATE INDEX user_words_updated_by_id_fk ON public.user_words USING btree (updated_by_id);
 /   DROP INDEX public.user_words_updated_by_id_fk;
       public            strapi    false    343            �           1259    58195 *   user_words_users_permissions_user_links_fk    INDEX     �   CREATE INDEX user_words_users_permissions_user_links_fk ON public.user_words_users_permissions_user_links USING btree (user_word_id);
 >   DROP INDEX public.user_words_users_permissions_user_links_fk;
       public            strapi    false    349            �           1259    58196 .   user_words_users_permissions_user_links_inv_fk    INDEX     �   CREATE INDEX user_words_users_permissions_user_links_inv_fk ON public.user_words_users_permissions_user_links USING btree (user_id);
 B   DROP INDEX public.user_words_users_permissions_user_links_inv_fk;
       public            strapi    false    349            �           1259    58197 4   user_words_users_permissions_user_links_order_inv_fk    INDEX     �   CREATE INDEX user_words_users_permissions_user_links_order_inv_fk ON public.user_words_users_permissions_user_links USING btree (user_word_order);
 H   DROP INDEX public.user_words_users_permissions_user_links_order_inv_fk;
       public            strapi    false    349            �           1259    58198    words_component_type_index    INDEX     a   CREATE INDEX words_component_type_index ON public.words_components USING btree (component_type);
 .   DROP INDEX public.words_component_type_index;
       public            strapi    false    352            �           1259    58199    words_created_by_id_fk    INDEX     Q   CREATE INDEX words_created_by_id_fk ON public.words USING btree (created_by_id);
 *   DROP INDEX public.words_created_by_id_fk;
       public            strapi    false    351            �           1259    58200    words_entity_fk    INDEX     Q   CREATE INDEX words_entity_fk ON public.words_components USING btree (entity_id);
 #   DROP INDEX public.words_entity_fk;
       public            strapi    false    352            �           1259    58201     words_example_sentences_links_fk    INDEX     m   CREATE INDEX words_example_sentences_links_fk ON public.words_example_sentences_links USING btree (word_id);
 4   DROP INDEX public.words_example_sentences_links_fk;
       public            strapi    false    354            �           1259    58202 $   words_example_sentences_links_inv_fk    INDEX     u   CREATE INDEX words_example_sentences_links_inv_fk ON public.words_example_sentences_links USING btree (sentence_id);
 8   DROP INDEX public.words_example_sentences_links_inv_fk;
       public            strapi    false    354            �           1259    58203 &   words_example_sentences_links_order_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_fk ON public.words_example_sentences_links USING btree (sentence_order);
 :   DROP INDEX public.words_example_sentences_links_order_fk;
       public            strapi    false    354            �           1259    58204 *   words_example_sentences_links_order_inv_fk    INDEX     z   CREATE INDEX words_example_sentences_links_order_inv_fk ON public.words_example_sentences_links USING btree (word_order);
 >   DROP INDEX public.words_example_sentences_links_order_inv_fk;
       public            strapi    false    354            �           1259    58205    words_field_index    INDEX     O   CREATE INDEX words_field_index ON public.words_components USING btree (field);
 %   DROP INDEX public.words_field_index;
       public            strapi    false    352            �           1259    58206    words_localizations_links_fk    INDEX     e   CREATE INDEX words_localizations_links_fk ON public.words_localizations_links USING btree (word_id);
 0   DROP INDEX public.words_localizations_links_fk;
       public            strapi    false    357            �           1259    58207     words_localizations_links_inv_fk    INDEX     m   CREATE INDEX words_localizations_links_inv_fk ON public.words_localizations_links USING btree (inv_word_id);
 4   DROP INDEX public.words_localizations_links_inv_fk;
       public            strapi    false    357            �           1259    58208 "   words_localizations_links_order_fk    INDEX     n   CREATE INDEX words_localizations_links_order_fk ON public.words_localizations_links USING btree (word_order);
 6   DROP INDEX public.words_localizations_links_order_fk;
       public            strapi    false    357            �           1259    58209    words_updated_by_id_fk    INDEX     Q   CREATE INDEX words_updated_by_id_fk ON public.words USING btree (updated_by_id);
 *   DROP INDEX public.words_updated_by_id_fk;
       public            strapi    false    351            �           2606    58210 4   admin_permissions admin_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_created_by_id_fk;
       public          strapi    false    4229    209    215                       2606    58215 <   admin_permissions_role_links admin_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_fk;
       public          strapi    false    4214    211    209                       2606    58220 @   admin_permissions_role_links admin_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_inv_fk;
       public          strapi    false    211    4225    213                        2606    58225 4   admin_permissions admin_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_updated_by_id_fk;
       public          strapi    false    209    4229    215                       2606    58230 (   admin_roles admin_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_created_by_id_fk;
       public          strapi    false    215    213    4229                       2606    58235 (   admin_roles admin_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_updated_by_id_fk;
       public          strapi    false    4229    213    215                       2606    58240 (   admin_users admin_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_created_by_id_fk;
       public          strapi    false    4229    215    215                       2606    58245 2   admin_users_roles_links admin_users_roles_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_fk;
       public          strapi    false    4229    217    215                       2606    58250 6   admin_users_roles_links admin_users_roles_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_inv_fk;
       public          strapi    false    4225    217    213                       2606    58255 (   admin_users admin_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_updated_by_id_fk;
       public          strapi    false    4229    215    215            	           2606    58260 N   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_fk FOREIGN KEY (sent_ref_id) REFERENCES public.components_a_sent_refs(id) ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_fk;
       public          strapi    false    4246    227    225            
           2606    58265 R   components_a_sent_refs_sentence_links components_a_sent_refs_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links
    ADD CONSTRAINT components_a_sent_refs_sentence_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 |   ALTER TABLE ONLY public.components_a_sent_refs_sentence_links DROP CONSTRAINT components_a_sent_refs_sentence_links_inv_fk;
       public          strapi    false    4417    227    289                       2606    58270 b   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk FOREIGN KEY (user_sent_ref_id) REFERENCES public.components_a_user_sent_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_fk;
       public          strapi    false    4256    233    231                       2606    58275 f   components_a_user_sent_refs_user_sentence_links components_a_user_sent_refs_user_sentence_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links
    ADD CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_sent_refs_user_sentence_links DROP CONSTRAINT components_a_user_sent_refs_user_sentence_links_inv_fk;
       public          strapi    false    4533    233    335                       2606    58280 Z   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_fk FOREIGN KEY (user_word_ref_id) REFERENCES public.components_a_user_word_refs(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_fk;
       public          strapi    false    235    237    4264                       2606    58285 ^   components_a_user_word_refs_user_word_links components_a_user_word_refs_user_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links
    ADD CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.components_a_user_word_refs_user_word_links DROP CONSTRAINT components_a_user_word_refs_user_word_links_inv_fk;
       public          strapi    false    237    4558    343                       2606    58290 F   components_a_word_refs_word_links components_a_word_refs_word_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_fk FOREIGN KEY (word_ref_id) REFERENCES public.components_a_word_refs(id) ON DELETE CASCADE;
 p   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_fk;
       public          strapi    false    243    245    4276                       2606    58295 J   components_a_word_refs_word_links components_a_word_refs_word_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_a_word_refs_word_links
    ADD CONSTRAINT components_a_word_refs_word_links_inv_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 t   ALTER TABLE ONLY public.components_a_word_refs_word_links DROP CONSTRAINT components_a_word_refs_word_links_inv_fk;
       public          strapi    false    4583    245    351                       2606    58300    files files_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fk;
       public          strapi    false    4229    247    215                       2606    58305 (   files_folder_links files_folder_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_fk;
       public          strapi    false    4285    248    247                       2606    58310 ,   files_folder_links files_folder_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_inv_fk;
       public          strapi    false    4522    248    331                       2606    58315 ,   files_related_morphs files_related_morphs_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_fk;
       public          strapi    false    4285    251    247                       2606    58320    files files_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_updated_by_id_fk;
       public          strapi    false    4229    247    215                       2606    58325 &   flashcards flashcards_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_created_by_id_fk;
       public          strapi    false    4229    253    215                       2606    58330 *   flashcards_components flashcards_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_components
    ADD CONSTRAINT flashcards_entity_fk FOREIGN KEY (entity_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.flashcards_components DROP CONSTRAINT flashcards_entity_fk;
       public          strapi    false    4307    254    253                       2606    58335 2   flashcards_lesson_links flashcards_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_fk;
       public          strapi    false    4307    257    253                       2606    58340 6   flashcards_lesson_links flashcards_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_lesson_links
    ADD CONSTRAINT flashcards_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.flashcards_lesson_links DROP CONSTRAINT flashcards_lesson_links_inv_fk;
       public          strapi    false    257    267    4347                       2606    58345 @   flashcards_localizations_links flashcards_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_fk;
       public          strapi    false    4307    259    253                       2606    58350 D   flashcards_localizations_links flashcards_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_localizations_links
    ADD CONSTRAINT flashcards_localizations_links_inv_fk FOREIGN KEY (inv_flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.flashcards_localizations_links DROP CONSTRAINT flashcards_localizations_links_inv_fk;
       public          strapi    false    259    4307    253                       2606    58355 &   flashcards flashcards_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.flashcards DROP CONSTRAINT flashcards_updated_by_id_fk;
       public          strapi    false    4229    215    253                       2606    58360 .   flashcards_user_links flashcards_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_fk FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_fk;
       public          strapi    false    261    253    4307                       2606    58365 2   flashcards_user_links flashcards_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flashcards_user_links
    ADD CONSTRAINT flashcards_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.flashcards_user_links DROP CONSTRAINT flashcards_user_links_inv_fk;
       public          strapi    false    261    327    4507                       2606    58370 (   i18n_locale i18n_locale_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_created_by_id_fk;
       public          strapi    false    263    215    4229                        2606    58375 (   i18n_locale i18n_locale_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_updated_by_id_fk;
       public          strapi    false    263    215    4229            !           2606    58380 *   lessonlevels lessonlevels_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_created_by_id_fk;
       public          strapi    false    265    215    4229            "           2606    58385 *   lessonlevels lessonlevels_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessonlevels
    ADD CONSTRAINT lessonlevels_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.lessonlevels DROP CONSTRAINT lessonlevels_updated_by_id_fk;
       public          strapi    false    4229    265    215            #           2606    58390     lessons lessons_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_created_by_id_fk;
       public          strapi    false    267    4229    215            %           2606    58395 $   lessons_components lessons_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_components
    ADD CONSTRAINT lessons_entity_fk FOREIGN KEY (entity_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.lessons_components DROP CONSTRAINT lessons_entity_fk;
       public          strapi    false    4347    267    268            &           2606    58400 6   lessons_lessonlevel_links lessons_lessonlevel_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_fk;
       public          strapi    false    271    267    4347            '           2606    58405 :   lessons_lessonlevel_links lessons_lessonlevel_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_lessonlevel_links
    ADD CONSTRAINT lessons_lessonlevel_links_inv_fk FOREIGN KEY (lessonlevel_id) REFERENCES public.lessonlevels(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_lessonlevel_links DROP CONSTRAINT lessons_lessonlevel_links_inv_fk;
       public          strapi    false    271    265    4343            (           2606    58410 :   lessons_localizations_links lessons_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_fk;
       public          strapi    false    273    267    4347            )           2606    58415 >   lessons_localizations_links lessons_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_inv_fk FOREIGN KEY (inv_lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_inv_fk;
       public          strapi    false    273    267    4347            *           2606    58420 (   lessons_unit_links lessons_unit_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_fk;
       public          strapi    false    267    275    4347            +           2606    58425 ,   lessons_unit_links lessons_unit_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_unit_links
    ADD CONSTRAINT lessons_unit_links_inv_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.lessons_unit_links DROP CONSTRAINT lessons_unit_links_inv_fk;
       public          strapi    false    4473    275    315            $           2606    58430     lessons lessons_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_updated_by_id_fk;
       public          strapi    false    4229    267    215            ,           2606    58435 &   reviewlogs reviewlogs_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_created_by_id_fk;
       public          strapi    false    277    4229    215            -           2606    58440 &   reviewlogs reviewlogs_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs
    ADD CONSTRAINT reviewlogs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.reviewlogs DROP CONSTRAINT reviewlogs_updated_by_id_fk;
       public          strapi    false    4229    215    277            .           2606    58445 .   reviewlogs_user_links reviewlogs_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_fk FOREIGN KEY (reviewlog_id) REFERENCES public.reviewlogs(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_fk;
       public          strapi    false    279    277    4381            /           2606    58450 2   reviewlogs_user_links reviewlogs_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewlogs_user_links
    ADD CONSTRAINT reviewlogs_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.reviewlogs_user_links DROP CONSTRAINT reviewlogs_user_links_inv_fk;
       public          strapi    false    279    327    4507            0           2606    58455 "   sections sections_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_created_by_id_fk;
       public          strapi    false    281    215    4229            2           2606    58460 &   sections_components sections_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_components
    ADD CONSTRAINT sections_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.sections_components DROP CONSTRAINT sections_entity_fk;
       public          strapi    false    282    281    4392            3           2606    58465 .   sections_lesson_links sections_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_fk;
       public          strapi    false    285    281    4392            4           2606    58470 2   sections_lesson_links sections_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_lesson_links
    ADD CONSTRAINT sections_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.sections_lesson_links DROP CONSTRAINT sections_lesson_links_inv_fk;
       public          strapi    false    267    285    4347            5           2606    58475 <   sections_localizations_links sections_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_fk FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_fk;
       public          strapi    false    287    4392    281            6           2606    58480 @   sections_localizations_links sections_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections_localizations_links
    ADD CONSTRAINT sections_localizations_links_inv_fk FOREIGN KEY (inv_section_id) REFERENCES public.sections(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.sections_localizations_links DROP CONSTRAINT sections_localizations_links_inv_fk;
       public          strapi    false    4392    281    287            1           2606    58485 "   sections sections_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_updated_by_id_fk;
       public          strapi    false    281    215    4229            7           2606    58490 $   sentences sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_created_by_id_fk;
       public          strapi    false    289    215    4229            9           2606    58495 (   sentences_components sentences_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_entity_fk;
       public          strapi    false    4417    289    290            :           2606    58500 >   sentences_localizations_links sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_fk;
       public          strapi    false    289    293    4417            ;           2606    58505 B   sentences_localizations_links sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_inv_fk FOREIGN KEY (inv_sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_inv_fk;
       public          strapi    false    293    4417    289            8           2606    58510 $   sentences sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_updated_by_id_fk;
       public          strapi    false    215    4229    289            <           2606    58515 J   strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_created_by_id_fk;
       public          strapi    false    215    4229    295            >           2606    58520 T   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;
 ~   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_fk;
       public          strapi    false    4435    295    297            ?           2606    58525 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_inv_fk;
       public          strapi    false    297    4446    299            =           2606    58530 J   strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_updated_by_id_fk;
       public          strapi    false    215    295    4229            @           2606    58535 4   strapi_api_tokens strapi_api_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_created_by_id_fk;
       public          strapi    false    4229    299    215            A           2606    58540 4   strapi_api_tokens strapi_api_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_updated_by_id_fk;
       public          strapi    false    4229    299    215            B           2606    58545 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk;
       public          strapi    false    215    307    4229            D           2606    58550 ^   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk    FK CONSTRAINT        ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_fk;
       public          strapi    false    309    307    4456            E           2606    58555 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk;
       public          strapi    false    309    311    4467            C           2606    58560 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk;
       public          strapi    false    4229    215    307            F           2606    58565 >   strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_created_by_id_fk;
       public          strapi    false    311    4229    215            G           2606    58570 >   strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_updated_by_id_fk;
       public          strapi    false    311    215    4229            H           2606    58575    units units_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_created_by_id_fk;
       public          strapi    false    315    215    4229            J           2606    58580 6   units_localizations_links units_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_fk;
       public          strapi    false    315    317    4473            K           2606    58585 :   units_localizations_links units_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_inv_fk;
       public          strapi    false    4473    315    317            L           2606    58590 4   units_precondition_links units_precondition_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_fk;
       public          strapi    false    4473    319    315            M           2606    58595 8   units_precondition_links units_precondition_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_precondition_links
    ADD CONSTRAINT units_precondition_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.units_precondition_links DROP CONSTRAINT units_precondition_links_inv_fk;
       public          strapi    false    4473    319    315            I           2606    58600    units units_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_updated_by_id_fk;
       public          strapi    false    4229    315    215            N           2606    58605 .   up_permissions up_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_created_by_id_fk;
       public          strapi    false    215    321    4229            P           2606    58610 6   up_permissions_role_links up_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_fk;
       public          strapi    false    323    321    4492            Q           2606    58615 :   up_permissions_role_links up_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_inv_fk;
       public          strapi    false    325    4503    323            O           2606    58620 .   up_permissions up_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_updated_by_id_fk;
       public          strapi    false    215    321    4229            R           2606    58625 "   up_roles up_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_created_by_id_fk;
       public          strapi    false    4229    325    215            S           2606    58630 "   up_roles up_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_updated_by_id_fk;
       public          strapi    false    325    4229    215            T           2606    58635 "   up_users up_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_created_by_id_fk;
       public          strapi    false    215    327    4229            V           2606    58640 *   up_users_role_links up_users_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_fk;
       public          strapi    false    4507    329    327            W           2606    58645 .   up_users_role_links up_users_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_inv_fk;
       public          strapi    false    4503    329    325            U           2606    58650 "   up_users up_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_updated_by_id_fk;
       public          strapi    false    4229    327    215            X           2606    58655 .   upload_folders upload_folders_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_created_by_id_fk;
       public          strapi    false    4229    331    215            Z           2606    58660 :   upload_folders_parent_links upload_folders_parent_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_fk;
       public          strapi    false    4522    333    331            [           2606    58665 >   upload_folders_parent_links upload_folders_parent_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_inv_fk;
       public          strapi    false    333    331    4522            Y           2606    58670 .   upload_folders upload_folders_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_updated_by_id_fk;
       public          strapi    false    331    215    4229            \           2606    58675 .   user_sentences user_sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_created_by_id_fk;
       public          strapi    false    335    215    4229            ^           2606    58680 :   user_sentences_lesson_links user_sentences_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_fk;
       public          strapi    false    335    4533    337            _           2606    58685 >   user_sentences_lesson_links user_sentences_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_lesson_links
    ADD CONSTRAINT user_sentences_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.user_sentences_lesson_links DROP CONSTRAINT user_sentences_lesson_links_inv_fk;
       public          strapi    false    337    267    4347            `           2606    58690 H   user_sentences_localizations_links user_sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_fk;
       public          strapi    false    335    4533    339            a           2606    58695 L   user_sentences_localizations_links user_sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_localizations_links
    ADD CONSTRAINT user_sentences_localizations_links_inv_fk FOREIGN KEY (inv_user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 v   ALTER TABLE ONLY public.user_sentences_localizations_links DROP CONSTRAINT user_sentences_localizations_links_inv_fk;
       public          strapi    false    339    335    4533            ]           2606    58700 .   user_sentences user_sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences
    ADD CONSTRAINT user_sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.user_sentences DROP CONSTRAINT user_sentences_updated_by_id_fk;
       public          strapi    false    4229    335    215            b           2606    58705 Z   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_fk FOREIGN KEY (user_sentence_id) REFERENCES public.user_sentences(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_fk;
       public          strapi    false    341    335    4533            c           2606    58710 ^   user_sentences_users_permissions_user_links user_sentences_users_permissions_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links
    ADD CONSTRAINT user_sentences_users_permissions_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.user_sentences_users_permissions_user_links DROP CONSTRAINT user_sentences_users_permissions_user_links_inv_fk;
       public          strapi    false    327    341    4507            d           2606    58715 &   user_words user_words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_created_by_id_fk;
       public          strapi    false    4229    215    343            f           2606    58720 2   user_words_lesson_links user_words_lesson_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_fk;
       public          strapi    false    345    4558    343            g           2606    58725 6   user_words_lesson_links user_words_lesson_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_lesson_links
    ADD CONSTRAINT user_words_lesson_links_inv_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.user_words_lesson_links DROP CONSTRAINT user_words_lesson_links_inv_fk;
       public          strapi    false    345    4347    267            h           2606    58730 @   user_words_localizations_links user_words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_fk;
       public          strapi    false    4558    347    343            i           2606    58735 D   user_words_localizations_links user_words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_localizations_links
    ADD CONSTRAINT user_words_localizations_links_inv_fk FOREIGN KEY (inv_user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.user_words_localizations_links DROP CONSTRAINT user_words_localizations_links_inv_fk;
       public          strapi    false    4558    347    343            e           2606    58740 &   user_words user_words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.user_words DROP CONSTRAINT user_words_updated_by_id_fk;
       public          strapi    false    4229    215    343            j           2606    58745 R   user_words_users_permissions_user_links user_words_users_permissions_user_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_fk FOREIGN KEY (user_word_id) REFERENCES public.user_words(id) ON DELETE CASCADE;
 |   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_fk;
       public          strapi    false    349    343    4558            k           2606    58750 V   user_words_users_permissions_user_links user_words_users_permissions_user_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_words_users_permissions_user_links
    ADD CONSTRAINT user_words_users_permissions_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.user_words_users_permissions_user_links DROP CONSTRAINT user_words_users_permissions_user_links_inv_fk;
       public          strapi    false    327    349    4507            l           2606    58755    words words_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_created_by_id_fk;
       public          strapi    false    351    4229    215            n           2606    58760     words_components words_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_components
    ADD CONSTRAINT words_entity_fk FOREIGN KEY (entity_id) REFERENCES public.words(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.words_components DROP CONSTRAINT words_entity_fk;
       public          strapi    false    4583    351    352            o           2606    58765 >   words_example_sentences_links words_example_sentences_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_fk;
       public          strapi    false    351    354    4583            p           2606    58770 B   words_example_sentences_links words_example_sentences_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_example_sentences_links
    ADD CONSTRAINT words_example_sentences_links_inv_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.words_example_sentences_links DROP CONSTRAINT words_example_sentences_links_inv_fk;
       public          strapi    false    289    354    4417            q           2606    58775 6   words_localizations_links words_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_fk FOREIGN KEY (word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_fk;
       public          strapi    false    357    351    4583            r           2606    58780 :   words_localizations_links words_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words_localizations_links
    ADD CONSTRAINT words_localizations_links_inv_fk FOREIGN KEY (inv_word_id) REFERENCES public.words(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.words_localizations_links DROP CONSTRAINT words_localizations_links_inv_fk;
       public          strapi    false    351    4583    357            m           2606    58785    words words_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.words DROP CONSTRAINT words_updated_by_id_fk;
       public          strapi    false    215    351    4229            �   7	  x��[�n�6}�~���EQDч�u�b3�Y2$9٠迗��yhQ	6H�}I�#g��8zw�/Ǭ�n/�L������~�����|���V4�іQ����?���*w_��R��s&^f��Zq���i]��&{iA#f	��k�E��|��ʙ��Bp(_
�y��1��k������ɳ�i�#H���L���I���M��Z�TaZqM�+�|s�A�!yON1�1,���sM+G�1�S,DR��Tc�%����0��1VT4$}B��7�h6��H��"�d���A�B;�ӧU�9���uV���*� ��8(Y��☋M�z��H`��8�V�}��b�H�F�X9�8�'7�O粐Ȑ6O_�K3C̉G���8l&��2qs��dwس�\���8���D��,'2��ڍ�%X�h���`aC� �]�!'�O������ݬ4��CB�D�8p�wG��`��Ɓ�jK\�CDX�q���
��jHB�3(���*s�[!��MQ���y�\VE�``L&:�����b�8p��\�^u��E8����:W�s&ˤ�9K�8�Nl���(Χp��7��J�i��K6Gc���8p�8�,��cq�8�F7X��sZ��a�d���1[5��"VGk�^�����0����4nU%&!íR8<�y�|'�Y��)��l'�$���q����EBh��F� �����)��D#�x�䚄�[���"����q�H�X��q�ͯd;i�EM� 9������e+dGW�]Bx�u�� 96�ە��h������X켏�_�m�0���b],��,pLǂ�cY8��`��'��CꇆA,�u�/%>V6 ��X��)a1�_��`>��_Jx��ʀ��nե�lӔOBm9����Y�Q��9�Az�Hwa�.�Az�Hw���?� �D�S8}�S�0�P�����t�a~�80P��)c԰�v��a�"e����7��@��p��r8�W����p`�VjS�E� *�$��t+1
n�pZj��[���o�(�܄�5 ��F�kF"��(b�����$�6�Mb�qZ�V�5n�W��x���\�r�,���w�2���v�Ǻɚ\�Y�k)O�>�z_eg5]T�J>����)A]�+!Y��Υ�]�S�������Z�(���V�+�nY���B+n���V����6�*`���c�>�?����q��pnĖ�򯌼�	[��,�j�τ�0��G�6=j��'�̅�>�n}��DVܜ-W�EF��.��-��d�P�psr�PR&��T�ų������I>n=N�[qЃ-/mV=�����a���y���4�z	�����8�T?X�$bVT�OZ�J�U:&|8��Fi��I
�ή��6=ٍa���L����ߖ�uU���͡:�����'$��A#v�Q�~�	Q<D�#�g��\�H3�����7f�O]���g���+��=�/:��;w-�M�GuW�J%z�Zq��C���/�� ��,i7���­��~ߧ��5�{�6Ni��ʇ]}b�8Hǌ`�}W$�Vܼ�P���4`Ө���ԡ�O;�Oik§%�Ǎ��5Xw��蓫�MZE�Y;2}������i[���P��z������L��yE��-w?��>�,�7�.o�n�RA:ܼ/�\��<���� �լR�Jn�<�ruxZq����/���ئ�Q���MiO���>��嬮M��D-�� �]M�t+S<d�)U���>����T��@���d�"�'kM�ރ���U���l7Buؚ����ѡ52����l����	n��[����~<���'���>)55鮦s��C+ntXTYn��I��J`���u��*��.�.�_F�uW7�����x��,��$	G_4���Y-�O�t/*y�ɤt�ԃLL�N�q�D���ĉh 1'�۽�`,"���7V�)񆃇	n�^�W�T��-h<-�=n\�`C�����;��E���3��,�����5�F�K���c�Ž���q�t���c�&=�D��c�Y��~�u�Չ���R��a'�+n�Ж�H�3�a�Ys�ƍ{�V�C
��lܳ���\�Δ�B���޸�z�txL���ڹ�吕S/���霋��Eu�;�&%u�ޕ}v3���ݹ������MՋ���cVd�/�S��t��j����=˳�z�)l|Oz���1��]�cV7���&+YY���vl&���҆��~d}��P'���CG6)T�G�c��{��("��7(z����L"8��d
��u��|�'H&n|��aN�T�=�ċm��y����2+�}�|���<v�          e  x�%�۱�0C��bv̧�^n�u,�L�[:u7�0G�~��<'ʊ�B[�����p\�z��	��#9��8�s�s-��1==����4�����gn����=��B\Ab�����e Xa�2,R/ı�q-D�A<�� Y�X~��W0H,Z|H�.�e)Z�Am)Z$r,E�B�+�E#��b��hqP��hqQ�h�Pl�h���;��Ql�h��-�#c%Z�X����V�堞�hyП�hy��h���H��CsD+G��hh�h�����Z�j�����E���lD���~�VC]D�CDkǔ�h���C�D�����]�z0�F�>8iG��S!�����r���~�v��ݽf�����7Y�?r�:C�?�y;�|���9������D���fKVٺ
5��$�Z�\`�8�������OF�����]08l�{4��ѡG��_�>��N�}�.�dŦˇE1]�	�Q����Ib�����m��0O
�&�#��[�a������y��������\��r�^���4�����cM�쐴]u�!wy��9S��m�s���ٺ�L�˯u̙F�L+���q���;�;�+�O��>a{�.�����T         �   x�u��n� @g���b��j6Y�d�r�K������!E�Z�����{ЪsZ(�h��+������j�F��z@c��[����3\	%E*�I��7J��G��׺�v8�ák�v?l��)�J��u��Ce*�T��l[���x���͜l ��+��+S܈�z��KT�Ɣ����2�'*�֘��	>2�������?�p�_���^Xc~3         �   x�3�LL�������Ҽ���ļt��������\N�DC�p��D�� �JSǊD����}�T�B'�B�dϊ�J�w���B��L�� �
K=��%�i ����T��L��X��������H����8X3W� (�,            x�3�4�@�=... �            x������ � �      
      x������ � �            x������ � �            x�3����� Z �            x�3�4�4����� �Y            x�3�L��2�,K-J����� $u�            x�3����� Z �            x�3�4�4����� �X            x�3����� Z �            x�3�4�4����� �X         (   x�3�L�L�L��K�y�@2��3#�,�3Ə+F���  	�            x������ � �             x�3�2�2�2����� �      "   "   x�3�4�4�bN#.cNc i�i�i����� 4yu      $      x������ � �      %      x������ � �      (      x������ � �      *   v   x�u���0 ki
-`��hrO�6)��TQ�H��p8*�l���a$�4��}��Q�p��R/��u��(��]��gN�$�X��G�{0Y��G�x����3��c����Li�|��j�7.�A?      +   L   x�3�4�D����"����ݢ�4�����ԼNC.3N#�|1PMޜ���h��4kŢ˒�(�UW� �+      .      x�3�4�4�4����� ��      0      x������ � �      2   -   x��I 0�wL�=U0口�ǩ�UPJ������j���~�|      4   <   x�3�t�K��,�P�H���L��4202�50�52V04�21�26г04�)�D\1z\\\ ��S      6      x������ � �      8   J   x�3��I-.��S0T�H�����suu3��?NCN##S]3]#+cK+#=3KS��@������� �nW      9      x������ � �      <      x������ � �      >      x������ � �      @      x������ � �      B   (  x�}�MN1FםSp�Z��$9DO�]��Q�B���:�B�l���K�َ��\^X�Z�E�p>.�����T
P�)o��O��SU���ޮ�oaAd�]�� V�j
�����+6�� �@Dku.���z8Z+�0�ji��<乒��|o����nfʕrZ��Up���]���t_m�^I;M��˟�*ZU��:a�rW�������<��LA!C�g�ΐK4���7|>u�
G�꼻%,�~!^i/D�mw��0���St'�]�,�����Ǝ���|�m۾ ߪ�      D   X   x����0��]1Qր�����8i~B���h�CцS٦KՖ�f;����G�yk����u�6�?��t&�I&ũ���y@��l��      F   {   x�3�(JL.�LNU0�4�4202�50�52Q00�21�20�3��-n��y\�S�8�1U�Y�����b��
4$?O�P��(5�$3/]�%31'?=�M���&���V�&z�03c���� F�1$      G   3   x�3�4�4�L�+�/J�-JM�L��-��K�+)�4�2��5����� i��      J      x�3�4A.#N# m�e�i���b���� 4 m      L      x������ � �      N   �   x�3���|>eŋ�/֯}���dgǋ�[�����c��is��Y�d��M��
9�٩
����FF��f�F
FFV�V&�z��aKC++S=cc#NC L���K--)J��2�n'��+���z�t��=�����)
��Ey�y���X�YZX��hje`�ghi�nc� l T�      O      x������ � �      R      x������ � �      T      x������ � �      V      x������ � �      X      x������ � �      Z      x��]���6���y�����L�_q��ݽs�	�[�m��hh��ie�RGR�xp�q�wOr��,��n���[��T�H�~U,�O���eQ���P��VY�]����(.7M��*�nר=?�櫢�������BՃ?&�b>9����I����.�����My�]�hr�5t:Ye��I��&_�O֘�7����GO'���~(PI�����"۔ݛ�龽�j��%��|7��4P�ͳ.�,����y��qaY��פ�.P����W-&����/�f)I@���M�&����2�Ѳ.k��u�Z��ւ�'Ѹˢ^�S�~�D� N��,r�!�ey�����bP��R��j����-�?� ^����C�]�fU�-栅�Ջ����$YN� �0�{�����}@��>�����c�S�b��ujYE8�>�e�O�U� N�neU'��f=��
��0�߂�L�ϫ��E�v�~����P%���A�z���@5�m���c��1��nߟ�ξ{�P����TX���?U�
�j��ES�;�[
 `�,�}]Q�§w����=�/~Ey������/�b�&��j`(k�&<���.x6aƄfL�1aƄ?fTf`d����~t�����^th��|�t|�8���*����q�!Tpl��L4�%I�s�:k�����S'�F#a���P	�E1�U���WS�E�F_�4���A�+S��E�4��0~���0�|d@�K����J����m��.k�� �r���z���@����M]��^�w@�W�l���T'�#Z,,
m��x�Al�
�&#��T2R�FJ�%�AvJ9�r�y�ó}�1=�1�(4��DQ�v_�z�F��q���vgh�z��`d�ٯh�!�����@��%��ڃv�r�Px�@�*N�4��	h�w��7�����(	9��>�|��n���8�$J�Y����sHK��ւ���(���˲1��f��ڃ7 X�����',R>)�&�)B� Q�D[!�T�\��C�V�t�H���(M�xHj��^���xٱ=�zoŨ�)��S�>�d��A:d��/��	����<�������Sv��}����N=4��ǩ,���?�O"K>>eY>5�!|",�%�$+����)��&���n<�^����C�l���;o}x�Ŭ��u��b���v�H�p�	�C�>�V�\y�,��hăƺ��X��%Ã@e�_!p5��#�h���"�֡�����`[��N�|_���<$�!9�Aǂܒ�� �~�c�1*+���m�i��yQ�@HMj\�EM�A�8@�x}�GO��f$�ZH��)N�բ�Pi���f�J�%y��[R��0Q�D�%&����l?�I�r�ȣ����R9*4I[{÷�����%3t�fH.j�Xv��������Y��رn�Dר�j��>_O���A�`[��Ak�B���&���L�@�J�l̺�+�%��K�U2iɤyM�PH��I�̚Ta;�Wڲ�{I��!�L$l��[�p����3�p��5�[\�+T�+�6]��)��䯰Eo5��j��@7���͛�����|���=�Va���xd��&�:LVeTd���"���*<������hs� *sY�E���9�rB�ر�yV�Y~�p��xp�_�W��e���4H�\� r��|O2e�X_��U��Y��&k�vī ?��˺��n��0�e�ƶv�n���k�U�.}l�gc���"o�^t=l�ռ�i��!�zY�ba�S����^�2 j`����'�U�ex��z�Ru4&_��v�nj��M;|�'��WCZ��&�d�喱͗C�6_z�zN&V�������zx�Up!��hfe�!1�X��(?�|��{K���˪���2�ȷ��yML,�su;�N�z�ᗷ�3]��gEm�.-�s���W𱊍�4�c�����R>H�=l���v2�����g�h3 7rt�p飔3���51�S�a�w�"�r�5���!�qj��u*��������/~4A��h������Al�1%�~O�L;��whjU�]ko��
v'��MM�/�q�I���K;y�Ur 3������ 5�Ŵ�'w����F��%N~"��h���iK�����/t��(w~�-��#ٓ�n�F�3=yS7��Iv��.����~���/�T�?L�[�t^W��?�۝ܐ�:�oL(Ϫ<��t��˲�v��詓�>�#d�sΩb����N~���ɟ����{꿑�߾���/����ˬ�j���D�2x٬2��{�	�.�*_�\CY����y^o���b̘9�s:c��9aٌ��ClN��ev�Șsrl�i�'�LO^�(Ó��E~u�{Af��v�ꛩAӘ�!���^����I��*x�_y��:�r4'���m#G�; D�f��2����
i����MYB���A|���⑴�X�F�h��8*������P�9q�n�*o�`�o(�g'���<������=�����J?S�;F_�����<y��ѣ�vK�]����2>_�5�i����M�� �͔|��pP�}S_s��8	��,J�M���8��t��[)Nhf@�\vU�XeI=��O"���ȧ1"��d8^:2�TYx�l1<�o�"r�C���;PYs�aZ�>t������2�<���ܛ�����	���%�m�*=H��҆`�L��A���L5��� ߁�_���k�$Mea���Lu��b�C7��P6��ݎ�Ӓwx���Ë�:�,���x��qwY���T�����^�'�>�r%#|/3���㐳�L
�A�����>�"�� h���yS�FJ�� ��ZC��Z��Y�*�Lkp�ג��x��xm�v�b�#L��7��%H~V�<~�Ď��%�W���h�|��^C���h�_ʲ�.S�)�8��P>^��q��Z�.'n�
�?�m�'q���r�짣:X~�Bڅam,T��*�$�U�]�2BNL�NL8'l�^�v�ؖ.}���:π$���Ҕ�����$Ȕ �g	�̫O�?���ą�+}��g"����	�&ڎd��@�u�h-GKS��ʵ
S0�x��<�������|�T�m����8�W#����Nvxk�B*�ʇE/���0W��Q��;��NL/�C�я
�/�6��g��i�g���2�ۙ�OS�={ @�C��q�Q_:m�T�i�Y�����*���Q�[��ՋY�F(�ܟeԈ��l5q�^B&	�|��ī�^U�˗��
�XykFf���k�l-�=&�?J�����TE7%�ca�8E�'Ґ�Ƽ�޻��O���u����-yd�(?T'�F��cE��t&^t�$�^�|	�%��G�w!r:�iP��=�L����f��b����t������+�ŋZ�'�	�)Mq�1�`�0CPٚ���t��,8�BL	o$�����5��h�&K�8Ē��K�'�ʍ��-��X�yThP@[b������f�����g4�{�1���������>>	ʑ8:!��?/���'uF�h�_�"���W����=�Z��49��UJv�=r
p��^��`դ�\�O�m�od�yQ�p��#�,�,�?7�~�|�/��}ܬ�/�e1FV#����'/|K��4��N�?�o��>�v���`�W��/fu��R�;�ل��6_�U�kF��>?�n����eɾ<y��3#�f�E�E����s�Z�cґ���M�5/�+5��a�]:%�>�c�_:M���]ߝ��)_��yw�8�'�LQ�_�:dH�.6E9+�Y�5�Ŧc�]�[%ٍ��QЄ\�Q�@�e�����">����ۦh�M/w�f��Y�;��ˉ9�_Y�f���{2$ydÏ�ޓI1V��S�h$��������K��ໜ|�JqP��y�5Xu��~U1�r�g�iNK�2k���6h�a��t]���a��r���2��X���!���i��x`�t���E�֨�n�ky�mR��M��UQS�4�[v���,)�����Up�%E�F��oY�\��j�%�R�    �*q_��ੈ�9XDȽ(�.��"+$������������g_�Z�\��ZP4�3%x�ūP8�4�%RnvZ)�懘������(����Ѥ{ς��b�d-+��������d��Ɲ�P}{��您_ʛcF'^����֧���z'�.��l{��j�z�b)@m��_[o��j�SW�p���2�S�����A�e�E����'p����*���a�NЦ`����2X�9�%	���:{C�db��M&6��dbCM����2;[},�`��+�^���+}6�����s�����J_P4��O<���"$>�ijcS��EK��s�S����[��O܁��U�^�-�DMd"���NSd�4�6	���bФ��:������@��@�{?$��_ð��Շ����J�r|�.N�Ņ�T��u(�Ũ����'�D;H��pQ�t�E��U�j����Hn�{�*��/6ey��9j��䛶�W$/#�w�mE��"r�D�#"�+�#^�u�J25���5/�����خC��u�?��v�����L��/�]��K&!��asw��|R�I�'�����!�Zʤ�b-�d϶dC�:�?o�����:�A�XK��e�ܣ�"��8Pj����c����pLZӟ��t��~��H�A��pW�5�#5��Ϳ�|��jʒn�ԕk�zB�� �q��GDҦ }>p:�cbso���lR�I�����93�A���l1����]Su����G�zB~~�;��;dId�G����#����?�)
�"<�)#���ͺ���tQx�ZI��,٦�Yb,^1%���8;J�&�9���H^�[~�SX�V�L��)��R�ދ�p�%*.�݀u�ʺ��t	��]�>n��jU�3E�He�Q^��2��MS����A���9�}��.����*�0�م�)՝�g�Z7��w|�T��خ��"��#e)q�al��j��:P<��$��v�> I��xؼ#�0G�׎���2��1cr0[cA�Ѻ��r�"6��D+&	��զ,���z|�fY�S�a��({���0j�D���@�$D�j� 
X�C�IT���w��	�$�pH�!�3���j���<C��d�Mg�g��jV�����(uaDh�>�.F����5Kó�G���'�aa�q�J��"�͆�M��%�v���w@�sksڶ	���)_\���DXke!Ed=h�&W���w�z�^���H�T�� �kP�Itv�I7&��i������ ��-��E�M!��[-�-�śu�N�z���Gd���f=����rt&��۳����%?6w��M��~����G��j����]ϲ-�X	A��i��#Ӟs;�X�vIOB%x�#4X-���3<���X����d����@����P�)=6�2�I�$�󩨝�C��@[qή(�\���,T�ٲ�k��>[V��&�&[tϫ���EY�8����y�e�u��&���w⪹w9Kk��W�o�ݍp$�G?���G�_�'�r⻟Cz��I��v�R�kΙ�p���W��k�ՅӦ��ܱ-�7��̓����+��E���<�o,$����?��l����>�I"S�n-���aS��]O���UG7�'x��5#����)O�؎�H0 ��8R���r��V�zW'ռZ���x�M5�0c+ȓ��+X��=e²d��4;/��t]�%:���-_e&�_=�P=�L�Ć�<6�ïi����_=��
Rк�Դ2y�-y>��5=��o^�	&��3xL|��~a�l�?�L3�f����)��;#�".�/��w=�u5�Fz\�����j��CX��(4�-^E�{]�yZ�񯪣i�ٔ@��-pQ���|B�Y,��T�Y*3X�7F��Y�|Zcd�0S�e��N��α3w;�eW�����p�n�:p[7M]]�������p�Pkl���6Y�X�Whu��+�Җ߱Li�G�&��LN�"k}k��M��
���q�C�x����'{��}������������?���E 5�K�A�����c��9���Nx���;�Wz�\�fTC�f�Y����+:f����,���/�H�̹P�?�$�Ϙrs���	f*w�"�$y�Ati��r]cHk��M)Jx	Lq3x�;e}Jt��]��L�2�)Z�H(�T$Ю@������.����;�F�j�0?Z_�b��Y��SJ�/(�<&6��4����n'���v���n��(��vw��(GN>Ҽ��Z�箏��}o�e�0� d#�{�
��jF����v���G���u�1���Q���Ҳ��,�R�b(C�1�)l�,�;�Y��]CCy�C�����B=#��S�@��X�v���Sw"�S�u���"�o����Ș6�UiPK��[h�u��#TH ��������6 -�{����4�To�3pƸ�1�S����W�n_lgu�m���W��l����)آ�'���-Gi�8��-����#��|
U�_F^S����]��^�%�)�@�.�؋;26�*6n�#��'u��aDu�?�P�}�Al�<�3w�QCP����0�!��=+M����^�ך|��܎**�{#Q�^�.��:~��^��D�N�r�e�yQkjf��EFdKq�������oМ[��RK�� �>�~X�FS�����D������iC�g����aa�r[�z�X-�ϗh���I&@�
,& xdl �M�Q@�d��eJ��[�1��\�!`��u&�<��n�*�a'/��:�Aa��_1U��i��{����"��.��;z^���^��z�x69�eyB��(��Wo�=H8���<*�$��kR�I�'��U���xۡ�Ώ�|��~� �z�w�?3�د4�a���3��k�q�����v���a����x^s�=wr:&6�9�(�c�RI?&�Y?� D,�@$���h�*����sVX��!�8�������|��k>�jd��Ǵ�Y���Ŭ]#�/G�W���������W"d�T���!^@�n*��Ӡu��/�w5��D�9��@W��ݦ���F���K ��<>�e)�cVI�']�t�1{#�A������ �S���=dJm�{[��`�����-�138>�%}���ӏa�WY�oʂ.���ڐd�(�"���K�瘣�撄����3K)KkJdn�B]�[w�.i�6v<y2ɽ8.6�ʽP�����bH�!!��>.b�߉�_��c嵺k��z��� j��//�_<}�ጳ9� ͤ�"�d)����w�ك?��ܢ��˕��Ŧ��Ģ(���O�������3;9��d��H_*�9���n:*���W,i���wt��Pa@�1ᡆ	�N�]K�K�]��-���U�!1NJ�ɹ�[�-kv�y Qk���[�{Mh�k� �y{!,kg��\���8T��k5u.�ʇ����u��`h$d�U����s��~�!S��Es!\۷ؼ�1F�j �g���i�B���m�0�aި�V;!q/f��`Ո����η�X/f/v����f���-Y#=��#Y8�]nT��$�|���C�ŗ�Qx��W��뷷#�jZ�EѴ����o���}Л���cn�;̓�z��%Gl��M��S��w��%��Ql�����*�PCΏ�b������9@�}�U�jtS�a�8^Oo�U�1��t*:�I���v��*��U���<W�i�lLo�-hX`�'p�����G~��,c���m�I?D됪�5�T�H�˴]%�nA�7�t���֊����^tˢ��Q�u�LD��~��b���PH_�͇�,��vF��@/�1�w����T3@�@�G
����kjwy�
_K�8vX�����C�'w Ew�ax`�������)�B�Ow!'��!D�h�B<��yH�͸VC+��"q��^7�U?F̐SLq�;�-�!�1��t�ѓ��|�~]�8�qSW�>�P�b��B�Q���Y�4�fX߀�g|eB�i~��1�"Oŉ��i3c� �  ���n���~�T�1�ԩ���'��G	>��};����q�|���U��1/���$���D���EQ�\I;�5�ID�GN
�8�rX�L�9q��2���	�q�#٬������1#���*�1:�0f�$)ׁ�eq\I<9ɉHN�ǉ�hO�S:V�<
���d��`�  8i���2����}C�ܸe²@����h�"��$�����.�{�mwO�4�>�){��3��}<��{�w�Lh{O5��"�t���ֈ���'�v�4qE�&iڭ����uɁ`�>^�6�������.�Dns�D�_�O�~۠V:��0�E)�8 Vcc�d�xҾɲ�E1�T�Æ3�����%Q�gA:d ��^���\/���I��#zԜ&�r���CP_ ���BzJ�j|NҾ����W�BKS���Z��I���M���Q+���ȇ��
�M?�Zin�{���YhA�c��O�L��ɀ��7b�S�;��\J~Y��Z�����]#|{�)�����E�`b�*������i�D�Iheȑ�4VY��vY����nf��J6M	,���	i�6qD��
�fk�EQR&%��h?10�)��10d=<
���\�uYg�)�l$WPua�pW��� Il: �"��0�A�NI�9��'�����qڸ'�trS�;0��DIj�C�[��r	�;/���$�!=��0�(��v��[f-8��y�Ad���/��Z��+xU���>����`�Ȍ&����qx㄃vi�k�Y���0Zi����0nk���ة,�é$>�ϙ (}�J19�[	S��*���Q ��b/�G�U~��&\+�c�4�)�'%�����{���}~�p�����>�s�k��z���/��
5�	��������yE��_D�4�ුʮ������R����A^7hFO�e�n���> ���IflrQ汁�j"vզ,qm��ίМ<l�S��_�_|����{j      \      x��]K��6>ǿ"�������fn�$��M��i�łDHE�$53v*�}	� �WcF"ql�ƣ����?�~�צ@�盻�����	o�6y����$�A^T� �1�l7$�s���vs(�c�o���a�D�S<�F²W�%���3|�qA)��X7L3rBٗ�]����gI����n����]|���&N�?ʿб���q^�����r����CI�C9�r*=�E�5�G�qϠ��EO~%��ɜQ� p"8~$Y��dS��}�~»�$y�T�����,r!���8�{V��$�Y��fo�Ĵ�@"vIaەZ�H�8;�<'I<�[~���NT�0�}	H6C�ތ�n��s
(����f�dk��M�8�����kH��Z����T�I�+�pA���ۇo����o�M���^-��}Q�$��e�X��ϻOxj��,)� r�$I���F�`���2I��2��kG/��P��ܽ_�e��hދb�L�,�g&k^)�|�@������T�KMîY��Aј�LɁdy��F��h��Hj�P�?%Y�#�9.��SP$ԕ��а�r(���<����@��=�]��@��RaLD(>��T��[q�nE�DX�VT݊��]�Bc\�n��DW�V@[�}��q��H
f{ؽf�m�������﬙6�)�b�1B±�=(_hB�����y |4Icb*b/���9%eD������)H͎�e���ܮ��.؉zX3� �x�F��4��=	+��ap0X��JȄ����7%g�F� �"���pć>\�v�J�t���f�zBF���ܦ�8�����@����4JP�k�EpH��T��A�v����T����f5��K��@椨����6)j�7�����|eR���Q��̩4�0��V�.����h�ҾhLnE6:DCQA��h�Vм�g�x(�D��l���}�R�(�RoO���{��Cn� ��RT���eJG儢��7�[nS[Ț�G��p6�#	+���p�JC� 5c�,y��;�Z�{�-V�����m�=d��ͣ޷,Y��g��r��`����:!c�s5�k2]��Z|w�VH��oL�rz{�� �A�&���`����`��� f`���ڧ&�e��%��qiE)�5�g�gwP�OMp���z#�Y���_��"�|�WB��@�)��+!n��5���[�k����A)E(�l�;h�m{�4l�_�qAZ`퉮�C`�[<^3"���Qr���~i[O�Z}��@��4��"(�ޯ��V^Z��2j��h���i��N9=eI|t���Ž�����͍�U�ӎ^��o^�uq�e�lh]#����q��v�8ȣ�1�+��ym����e���i��&�"�_�B��Tdm�߶�3UiGGKI6�xX8ow��1�;~�'t�0��FDgd�Dg�+2'��@"����ïqV��qDɑ��sm`������E�i��%za-���eo��5o����_��>տW�%`������5�1x��g<��@^*Ue.�6�p��`h����Z��Pk� 0.i��_�ڡ�R����p6�7�`u�}����>�cRH��VMNJ��گkT�����>�5�'�m�?!����5�lkJ�
�q}�1&c͌�ԞLwM�ō��$��`����鋗" ����pM�* k�
|5��"��~��	�(+���)�{!���W��X7Ct�`��p�C��C��Cw��c��@ʩ�=l:Ο�x���M�>9�ILQ7@�c(��(���$cK;3w�сo���w[Rt�;�&����ٓ�?��E1\7�wl�R���p���|��/uk>�q~���%���z@q�ki�s�9�}��Jg����;���'������W��՝~\� tI�+��#�v��l.k>��rJ#L�,N4��^Dx�6�J�%��+n�=�´�Β8�K���Ʈ�g�R*�uv�����`�7_�./�����N���@/="?p�����c�l���!��T�X���o<�mO�ۉ����L�&�x��*'QV�dQ��Z^�w�u�AV�������_�^ �Vi��nkP�L�6i"X`y�vmY�$���%�]��Y�U������"���O<�#�Ċy_5���g�L�_`�kla��EY"�IV���&�5�R���I��p= ԋ�%��@�m�d��ѭt�QJ�_uy�Ȋֿ�N��L�Y=f���g)W�K�*6y��N�	�T�?��X�I���\�,"�Ei0�š._j� r��N�8�	�(���R\�S��L���8p'Ɇ�;��F�Y�*�ʖ�~]%�ÇX���qdg���?Yص+?6fqq(�$�P9_w̜���x+�QUsJ�����F˙��FS�cvlQd���y��O �ĢѶ](�T����U�/M���BƁ��8�R1 <l9�֢�B�CQ��^�v
�?��2xM���,o����� ��j*�����X���V�9�6<��A�_ZH&,�6�D�p��<=��������(�$��M�?7�*@�Դ�EsA!����q\��x�����(.p�+T-�i�#�)تW�s�T�����J��K���A]�٠/P�G���y_��
X��d�׼ �Eո�@iyԕR��@y�W��Q9��P��Ү��
�V	 V��-1�T���<:�sR|��y��4�2�*L�N��:��d������ =�2h����;����5ӟ�f:�㳮*hS�(��j:O��Dj�S�,7�ݛ�D`;4��<,�� wұ���j��m�1���ҫ�����z�)��x:��t�2l��!#,nHR�@�A9,1��&
+�OT6Dq@���=��.���
A�^dB�֯�b˼��0�p4�I�Μ�$�0ر_��E �uvD�۶�x�2͖�J ����B��m������IʹD��2�W�'e䇻���c֚�i5a�o���m.������4!��)Q�o�g��V�~��RZ�#[ۢ5�����N"����r�`�~tI_�v��2��L2���]�0�##�QCn���Bv�U3����<2�r�͊^$H'\T���]��xL���҉u�Cm1����YG��a�+{8��G����|��l:/�j[MA��]���ݛ&��8�������2�謚���,�DcVr�<�K>p��'��x_����k�P!�:'��}��(�_�^��
V}���|i��3�k��v��\��l:S��W�5Y���_!� [��&��OZ��(��]�1܀u�6#��첕�d�����:�(��:��eJX
^�3):����@��E+�ܠ�dq�z�ϯ/EmK��hF^/,j�(�E�7�_ 0����6�/MM}h��Ш�GЅa���|P3�:��~NOi;�-�tD�x�NC[���^^�peu���c�vy����.��	�,!�_�M�T����Nk��ng�4+aި�U��)�.��Xbc��P�⠀d������[�3�6W�H�F�D'e�-ES����m�M�����{2��hi�WW�/�Z*Q �.?��*�eLThr/]�u2�'*lneRT��*z��/Ú��^I!C/���%�Qo��Y���4�ET$qK�PZ��W�)2��뗄"7o�0IGs��̠I%�0�+�YlV
�%"��^�2���G�6�t�ܹ;��u�Xs�3[ժ/���I��R|)A��w� �J	v�Z�T�W_9*�r g��k�{a���q �K2f�7�B'�8�AA�C눣��N�ǁ/)�b� �؏�GbTz�3'/	?j��)�� ��6��[=2͖�J ���2纕B��NysMB���	��5�UQ+/R!}9�Z˙-xF�4��l$��v�i�)S`�[�Ne�)�@�7�9k1��e5r�%�t�4w�"�Y��T@;�N���y�d��Q:��K���>�Q���"�wJ���t����	kpm�8B�>HPe�R���O�&R]��6��5   �K�"�U�v�K~2,���ʲ9.b���_�;4���t��z���20>��e"��El� �\bh�@X~�ˆD�$|XYQ4@R���:��`|�X�*g���J`�% 8q�>a�Y�a��\��
����1�t�5@�dwVx��H��#�F�r��n�x~	+���YReJ��H���@��&�����˼���n��ǿ����}�����n����ݻ�w7o�����ov���>���"t���ޅ��ߠz���G����������(��=      ^      x������ � �      `      x������ � �      b      x������ � �      d      x������ � �      f      x������ � �      h   �   x�u�1
�0Eg����%Un��:u��	^���'�).���$�Cs�R��\��f;�C7]����U�����xH�=���������6M�s�e�&#�t�l_/����ϝ@���DE>������9�      j      x������ � �      l      x�3�4�4����� �Z      n   �  x���Mn� ���)|� �Ƴ��U��u6�&�8����I,5q��J,Г�f�y�bW�+��NZ��I�(�������p�"4�3H2�Qν���[�,@�v�
��,�1��^���c����i��sc˙Qұ(���1z�l#�N�(de�\+�L>�;����L>~'�ښ8^�����maKt�S�|��͢���1�h��{2��bCf:��~W��"ka,�� �q����o��Q��Q )"1��=6�c+�N �@��b
8`�s�����X|ZY�	>	��}��J�8)P4�~�zϧ~~)ky]w�w�"ΩW����V�J�~�[a�QD]���m�B�sy�Ƶ���n��<"��A�PƸW���<��40����y�Su]�AI�{��������ڍ�O�n�^��4�-��O{�Z�      p   s   x�%��!�v1'�@�^��:�	��̃X6X=:��e����j&��q��y��6����{���mؑ��EE�:�9&]��
jѢkHȒ�	u{(x>ӌj�t�>��O��?�v�      r   �   x�u�M
�0��ur��@��DS�\��&֨��JM<���T���=�vu?�^m�1ԡ�4N�3�j��c.�%�^�d����ȋ����yA�$��Z��[k�Iu��iR���?���fu\���(�\��;�����Ed      t   �   x�u�Oo�0��sy�Z�B�#�E�d�,�f����):����/겝H���I~��C+Y��S!�l�q�Kt����Nd�l&mJ엂g��l3���cx�iTt^\���6n�\�J������D͍��h���A
1����!���	�`B�^�/-@����AV�i�z��:�VB����SZ�8�򹀫���]R/#5X�n
��4�S��'���|�3��i[lY�j�Z�      v      x�3�4�4�4�� �f\1z\\\ ��      x      x������ � �      z      x������ � �      |   b   x�3��TH�UH���KW(�W(N�����r����8�uL|6��钕O�v?���t���M�FF��f�F
F�V��V��z&f���05�+F��� �^$�      ~      x�3�4A�=... ��      �      x������ � �      �      x�3�4��4����� ��      �   N   x�3��H����|�w�ӥ{9�R��8��Lu�t��,�̬�M�̌�
F�V�V&�zFƆ� ������� �_�      �      x�3�4A�=... ��      �      x������ � �      �      x�3�4��4����� �      �   �   x�3�L��|�8��YCߓ�/�o�,K-J�LK�����K��I�4202�50�5�T00�22�2��3�4B74�21�22�346�4��<N��Ғ��.#����lΧۗ>�;�ZH<�1����/�7�X���?�m�d�����1��&VF�z�&�Vrf����s>ٻ��ҽ�Ov4��X�s���O'�y��"�����P�1�6�22ҳ00ô�� hv��qqq tvB      �   @   x�3�4�4�L�+K-J��M-I����,c.C��P�$1='���HsrA5�q��qqq �@�      �      x������ � �      �      x������ � �     