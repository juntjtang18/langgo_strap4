PGDMP                         }           langgo-en-dev1    14.18    14.18 (Homebrew) �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    53304    langgo-en-dev1    DATABASE     d   CREATE DATABASE "langgo-en-dev1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF8';
     DROP DATABASE "langgo-en-dev1";
                strapi    false            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   cloudsqlsuperuser    false    3            �            1259    53340    admin_permissions    TABLE     g  CREATE TABLE public.admin_permissions (
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
       public         heap    strapi    false            �            1259    53339    admin_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.admin_permissions_id_seq;
       public          strapi    false    218            �           0    0    admin_permissions_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;
          public          strapi    false    217            �            1259    53487    admin_permissions_role_links    TABLE     �   CREATE TABLE public.admin_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);
 0   DROP TABLE public.admin_permissions_role_links;
       public         heap    strapi    false            �            1259    53486 #   admin_permissions_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.admin_permissions_role_links_id_seq;
       public          strapi    false    244            �           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.admin_permissions_role_links_id_seq OWNED BY public.admin_permissions_role_links.id;
          public          strapi    false    243            �            1259    53362    admin_roles    TABLE     ;  CREATE TABLE public.admin_roles (
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
       public         heap    strapi    false            �            1259    53361    admin_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_roles_id_seq;
       public          strapi    false    222            �           0    0    admin_roles_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;
          public          strapi    false    221            �            1259    53351    admin_users    TABLE     B  CREATE TABLE public.admin_users (
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
       public         heap    strapi    false            �            1259    53350    admin_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_users_id_seq;
       public          strapi    false    220            �           0    0    admin_users_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;
          public          strapi    false    219            �            1259    53499    admin_users_roles_links    TABLE     �   CREATE TABLE public.admin_users_roles_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_order double precision,
    user_order double precision
);
 +   DROP TABLE public.admin_users_roles_links;
       public         heap    strapi    false            �            1259    53498    admin_users_roles_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_users_roles_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.admin_users_roles_links_id_seq;
       public          strapi    false    246            �           0    0    admin_users_roles_links_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.admin_users_roles_links_id_seq OWNED BY public.admin_users_roles_links.id;
          public          strapi    false    245                       1259    53911    chapters    TABLE     q  CREATE TABLE public.chapters (
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
    DROP TABLE public.chapters;
       public         heap    strapi    false                       1259    53910    chapters_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chapters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.chapters_id_seq;
       public          strapi    false    270            �           0    0    chapters_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;
          public          strapi    false    269                       1259    53936    chapters_localizations_links    TABLE     �   CREATE TABLE public.chapters_localizations_links (
    id integer NOT NULL,
    chapter_id integer,
    inv_chapter_id integer,
    chapter_order double precision
);
 0   DROP TABLE public.chapters_localizations_links;
       public         heap    strapi    false                       1259    53935 #   chapters_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chapters_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.chapters_localizations_links_id_seq;
       public          strapi    false    274            �           0    0 #   chapters_localizations_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.chapters_localizations_links_id_seq OWNED BY public.chapters_localizations_links.id;
          public          strapi    false    273                       1259    53980    chapters_preconditions_links    TABLE     �   CREATE TABLE public.chapters_preconditions_links (
    id integer NOT NULL,
    chapter_id integer,
    inv_chapter_id integer,
    chapter_order double precision,
    inv_chapter_order double precision
);
 0   DROP TABLE public.chapters_preconditions_links;
       public         heap    strapi    false                       1259    53979 #   chapters_preconditions_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chapters_preconditions_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.chapters_preconditions_links_id_seq;
       public          strapi    false    276            �           0    0 #   chapters_preconditions_links_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.chapters_preconditions_links_id_seq OWNED BY public.chapters_preconditions_links.id;
          public          strapi    false    275                       1259    53924    chapters_unit_links    TABLE     �   CREATE TABLE public.chapters_unit_links (
    id integer NOT NULL,
    chapter_id integer,
    unit_id integer,
    chapter_order double precision
);
 '   DROP TABLE public.chapters_unit_links;
       public         heap    strapi    false                       1259    53923    chapters_unit_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chapters_unit_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.chapters_unit_links_id_seq;
       public          strapi    false    272            �           0    0    chapters_unit_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.chapters_unit_links_id_seq OWNED BY public.chapters_unit_links.id;
          public          strapi    false    271                       1259    53993    chapters_unlocks_links    TABLE     �   CREATE TABLE public.chapters_unlocks_links (
    id integer NOT NULL,
    chapter_id integer,
    inv_chapter_id integer,
    chapter_order double precision,
    inv_chapter_order double precision
);
 *   DROP TABLE public.chapters_unlocks_links;
       public         heap    strapi    false                       1259    53992    chapters_unlocks_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chapters_unlocks_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.chapters_unlocks_links_id_seq;
       public          strapi    false    278            �           0    0    chapters_unlocks_links_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.chapters_unlocks_links_id_seq OWNED BY public.chapters_unlocks_links.id;
          public          strapi    false    277            "           1259    54142    components_a_taglists    TABLE     g   CREATE TABLE public.components_a_taglists (
    id integer NOT NULL,
    tag character varying(255)
);
 )   DROP TABLE public.components_a_taglists;
       public         heap    strapi    false            !           1259    54141    components_a_taglists_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_taglists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.components_a_taglists_id_seq;
       public          strapi    false    290            �           0    0    components_a_taglists_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.components_a_taglists_id_seq OWNED BY public.components_a_taglists.id;
          public          strapi    false    289            &           1259    54173    components_a_verb_metas    TABLE     @  CREATE TABLE public.components_a_verb_metas (
    id integer NOT NULL,
    simple_past character varying(255),
    past_participle character varying(255),
    present_participle character varying(255),
    thirdperson_singular character varying(255),
    auxiliary_verb character varying(255),
    conjugations jsonb
);
 +   DROP TABLE public.components_a_verb_metas;
       public         heap    strapi    false            %           1259    54172    components_a_verb_metas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.components_a_verb_metas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.components_a_verb_metas_id_seq;
       public          strapi    false    294            �           0    0    components_a_verb_metas_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.components_a_verb_metas_id_seq OWNED BY public.components_a_verb_metas.id;
          public          strapi    false    293            �            1259    53413    files    TABLE     �  CREATE TABLE public.files (
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
       public         heap    strapi    false            �            1259    53548    files_folder_links    TABLE     �   CREATE TABLE public.files_folder_links (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_order double precision
);
 &   DROP TABLE public.files_folder_links;
       public         heap    strapi    false            �            1259    53547    files_folder_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_folder_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.files_folder_links_id_seq;
       public          strapi    false    254            �           0    0    files_folder_links_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.files_folder_links_id_seq OWNED BY public.files_folder_links.id;
          public          strapi    false    253            �            1259    53412    files_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.files_id_seq;
       public          strapi    false    232            �           0    0    files_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;
          public          strapi    false    231            �            1259    53536    files_related_morphs    TABLE     �   CREATE TABLE public.files_related_morphs (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.files_related_morphs;
       public         heap    strapi    false            �            1259    53535    files_related_morphs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_related_morphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.files_related_morphs_id_seq;
       public          strapi    false    252            �           0    0    files_related_morphs_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.files_related_morphs_id_seq OWNED BY public.files_related_morphs.id;
          public          strapi    false    251            �            1259    53476    i18n_locale    TABLE       CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
    DROP TABLE public.i18n_locale;
       public         heap    strapi    false            �            1259    53475    i18n_locale_id_seq    SEQUENCE     �   CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.i18n_locale_id_seq;
       public          strapi    false    242            �           0    0    i18n_locale_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;
          public          strapi    false    241                       1259    54028    lessons    TABLE     [  CREATE TABLE public.lessons (
    id integer NOT NULL,
    title character varying(255),
    slug character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);
    DROP TABLE public.lessons;
       public         heap    strapi    false                       1259    54041    lessons_chapter_links    TABLE     �   CREATE TABLE public.lessons_chapter_links (
    id integer NOT NULL,
    lesson_id integer,
    chapter_id integer,
    lesson_order double precision
);
 )   DROP TABLE public.lessons_chapter_links;
       public         heap    strapi    false                       1259    54040    lessons_chapter_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_chapter_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.lessons_chapter_links_id_seq;
       public          strapi    false    282            �           0    0    lessons_chapter_links_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.lessons_chapter_links_id_seq OWNED BY public.lessons_chapter_links.id;
          public          strapi    false    281                       1259    54027    lessons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.lessons_id_seq;
       public          strapi    false    280            �           0    0    lessons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;
          public          strapi    false    279                       1259    54053    lessons_localizations_links    TABLE     �   CREATE TABLE public.lessons_localizations_links (
    id integer NOT NULL,
    lesson_id integer,
    inv_lesson_id integer,
    lesson_order double precision
);
 /   DROP TABLE public.lessons_localizations_links;
       public         heap    strapi    false                       1259    54052 "   lessons_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lessons_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.lessons_localizations_links_id_seq;
       public          strapi    false    284            �           0    0 "   lessons_localizations_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.lessons_localizations_links_id_seq OWNED BY public.lessons_localizations_links.id;
          public          strapi    false    283                       1259    54097 	   sentences    TABLE     �  CREATE TABLE public.sentences (
    id integer NOT NULL,
    title character varying(255),
    instruction character varying(255),
    base_text character varying(255),
    target_text character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);
    DROP TABLE public.sentences;
       public         heap    strapi    false            $           1259    54151    sentences_components    TABLE     �   CREATE TABLE public.sentences_components (
    id integer NOT NULL,
    entity_id integer,
    component_id integer,
    component_type character varying(255),
    field character varying(255),
    "order" double precision
);
 (   DROP TABLE public.sentences_components;
       public         heap    strapi    false            #           1259    54150    sentences_components_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.sentences_components_id_seq;
       public          strapi    false    292            �           0    0    sentences_components_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.sentences_components_id_seq OWNED BY public.sentences_components.id;
          public          strapi    false    291                       1259    54096    sentences_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sentences_id_seq;
       public          strapi    false    286            �           0    0    sentences_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sentences_id_seq OWNED BY public.sentences.id;
          public          strapi    false    285                        1259    54108    sentences_localizations_links    TABLE     �   CREATE TABLE public.sentences_localizations_links (
    id integer NOT NULL,
    sentence_id integer,
    inv_sentence_id integer,
    sentence_order double precision
);
 1   DROP TABLE public.sentences_localizations_links;
       public         heap    strapi    false                       1259    54107 $   sentences_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentences_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.sentences_localizations_links_id_seq;
       public          strapi    false    288            �           0    0 $   sentences_localizations_links_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.sentences_localizations_links_id_seq OWNED BY public.sentences_localizations_links.id;
          public          strapi    false    287            �            1259    53384    strapi_api_token_permissions    TABLE       CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 0   DROP TABLE public.strapi_api_token_permissions;
       public         heap    strapi    false            �            1259    53383 #   strapi_api_token_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.strapi_api_token_permissions_id_seq;
       public          strapi    false    226            �           0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;
          public          strapi    false    225            �            1259    53512 (   strapi_api_token_permissions_token_links    TABLE     �   CREATE TABLE public.strapi_api_token_permissions_token_links (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_order double precision
);
 <   DROP TABLE public.strapi_api_token_permissions_token_links;
       public         heap    strapi    false            �            1259    53511 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 F   DROP SEQUENCE public.strapi_api_token_permissions_token_links_id_seq;
       public          strapi    false    248            �           0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_api_token_permissions_token_links_id_seq OWNED BY public.strapi_api_token_permissions_token_links.id;
          public          strapi    false    247            �            1259    53373    strapi_api_tokens    TABLE     �  CREATE TABLE public.strapi_api_tokens (
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
       public         heap    strapi    false            �            1259    53372    strapi_api_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.strapi_api_tokens_id_seq;
       public          strapi    false    224            �           0    0    strapi_api_tokens_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;
          public          strapi    false    223            �            1259    53322    strapi_core_store_settings    TABLE     �   CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);
 .   DROP TABLE public.strapi_core_store_settings;
       public         heap    strapi    false            �            1259    53321 !   strapi_core_store_settings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.strapi_core_store_settings_id_seq;
       public          strapi    false    214            �           0    0 !   strapi_core_store_settings_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;
          public          strapi    false    213            �            1259    53313    strapi_database_schema    TABLE     �   CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);
 *   DROP TABLE public.strapi_database_schema;
       public         heap    strapi    false            �            1259    53312    strapi_database_schema_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.strapi_database_schema_id_seq;
       public          strapi    false    212            �           0    0    strapi_database_schema_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;
          public          strapi    false    211            �            1259    53306    strapi_migrations    TABLE     �   CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);
 %   DROP TABLE public.strapi_migrations;
       public         heap    strapi    false            �            1259    53305    strapi_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.strapi_migrations_id_seq;
       public          strapi    false    210            �           0    0    strapi_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;
          public          strapi    false    209            �            1259    53404 !   strapi_transfer_token_permissions    TABLE     
  CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 5   DROP TABLE public.strapi_transfer_token_permissions;
       public         heap    strapi    false            �            1259    53403 (   strapi_transfer_token_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.strapi_transfer_token_permissions_id_seq;
       public          strapi    false    230            �           0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;
          public          strapi    false    229            �            1259    53524 -   strapi_transfer_token_permissions_token_links    TABLE     �   CREATE TABLE public.strapi_transfer_token_permissions_token_links (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_order double precision
);
 A   DROP TABLE public.strapi_transfer_token_permissions_token_links;
       public         heap    strapi    false            �            1259    53523 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 K   DROP SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq;
       public          strapi    false    250            �           0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.strapi_transfer_token_permissions_token_links_id_seq OWNED BY public.strapi_transfer_token_permissions_token_links.id;
          public          strapi    false    249            �            1259    53393    strapi_transfer_tokens    TABLE     �  CREATE TABLE public.strapi_transfer_tokens (
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
       public         heap    strapi    false            �            1259    53392    strapi_transfer_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.strapi_transfer_tokens_id_seq;
       public          strapi    false    228            �           0    0    strapi_transfer_tokens_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;
          public          strapi    false    227            �            1259    53331    strapi_webhooks    TABLE     �   CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);
 #   DROP TABLE public.strapi_webhooks;
       public         heap    strapi    false            �            1259    53330    strapi_webhooks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.strapi_webhooks_id_seq;
       public          strapi    false    216            �           0    0    strapi_webhooks_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;
          public          strapi    false    215                       1259    53816    units    TABLE     n  CREATE TABLE public.units (
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
       public         heap    strapi    false                       1259    53815    units_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.units_id_seq;
       public          strapi    false    262            �           0    0    units_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;
          public          strapi    false    261                       1259    53829    units_localizations_links    TABLE     �   CREATE TABLE public.units_localizations_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer,
    unit_order double precision
);
 -   DROP TABLE public.units_localizations_links;
       public         heap    strapi    false                       1259    53828     units_localizations_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_localizations_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.units_localizations_links_id_seq;
       public          strapi    false    264            �           0    0     units_localizations_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.units_localizations_links_id_seq OWNED BY public.units_localizations_links.id;
          public          strapi    false    263            
           1259    53863    units_preconditions_links    TABLE     �   CREATE TABLE public.units_preconditions_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer,
    unit_order double precision,
    inv_unit_order double precision
);
 -   DROP TABLE public.units_preconditions_links;
       public         heap    strapi    false            	           1259    53862     units_preconditions_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_preconditions_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.units_preconditions_links_id_seq;
       public          strapi    false    266            �           0    0     units_preconditions_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.units_preconditions_links_id_seq OWNED BY public.units_preconditions_links.id;
          public          strapi    false    265                       1259    53876    units_unlocks_links    TABLE     �   CREATE TABLE public.units_unlocks_links (
    id integer NOT NULL,
    unit_id integer,
    inv_unit_id integer,
    unit_order double precision,
    inv_unit_order double precision
);
 '   DROP TABLE public.units_unlocks_links;
       public         heap    strapi    false                       1259    53875    units_unlocks_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.units_unlocks_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.units_unlocks_links_id_seq;
       public          strapi    false    268            �           0    0    units_unlocks_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.units_unlocks_links_id_seq OWNED BY public.units_unlocks_links.id;
          public          strapi    false    267            �            1259    53445    up_permissions    TABLE     �   CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);
 "   DROP TABLE public.up_permissions;
       public         heap    strapi    false            �            1259    53444    up_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.up_permissions_id_seq;
       public          strapi    false    236            �           0    0    up_permissions_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;
          public          strapi    false    235                       1259    53572    up_permissions_role_links    TABLE     �   CREATE TABLE public.up_permissions_role_links (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_order double precision
);
 -   DROP TABLE public.up_permissions_role_links;
       public         heap    strapi    false                       1259    53571     up_permissions_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_permissions_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.up_permissions_role_links_id_seq;
       public          strapi    false    258            �           0    0     up_permissions_role_links_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.up_permissions_role_links_id_seq OWNED BY public.up_permissions_role_links.id;
          public          strapi    false    257            �            1259    53454    up_roles    TABLE     8  CREATE TABLE public.up_roles (
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
       public         heap    strapi    false            �            1259    53453    up_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.up_roles_id_seq;
       public          strapi    false    238            �           0    0    up_roles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;
          public          strapi    false    237            �            1259    53465    up_users    TABLE     �  CREATE TABLE public.up_users (
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
       public         heap    strapi    false            �            1259    53464    up_users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.up_users_id_seq;
       public          strapi    false    240            �           0    0    up_users_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;
          public          strapi    false    239                       1259    53584    up_users_role_links    TABLE     �   CREATE TABLE public.up_users_role_links (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_order double precision
);
 '   DROP TABLE public.up_users_role_links;
       public         heap    strapi    false                       1259    53583    up_users_role_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.up_users_role_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.up_users_role_links_id_seq;
       public          strapi    false    260            �           0    0    up_users_role_links_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.up_users_role_links_id_seq OWNED BY public.up_users_role_links.id;
          public          strapi    false    259            �            1259    53430    upload_folders    TABLE     +  CREATE TABLE public.upload_folders (
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
       public         heap    strapi    false            �            1259    53429    upload_folders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.upload_folders_id_seq;
       public          strapi    false    234            �           0    0    upload_folders_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;
          public          strapi    false    233                        1259    53560    upload_folders_parent_links    TABLE     �   CREATE TABLE public.upload_folders_parent_links (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_order double precision
);
 /   DROP TABLE public.upload_folders_parent_links;
       public         heap    strapi    false            �            1259    53559 "   upload_folders_parent_links_id_seq    SEQUENCE     �   CREATE SEQUENCE public.upload_folders_parent_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.upload_folders_parent_links_id_seq;
       public          strapi    false    256            �           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.upload_folders_parent_links_id_seq OWNED BY public.upload_folders_parent_links.id;
          public          strapi    false    255            �           2604    53343    admin_permissions id    DEFAULT     |   ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);
 C   ALTER TABLE public.admin_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    218    217    218            �           2604    53490    admin_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_links_id_seq'::regclass);
 N   ALTER TABLE public.admin_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    243    244    244            �           2604    53365    admin_roles id    DEFAULT     p   ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);
 =   ALTER TABLE public.admin_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    221    222    222            �           2604    53354    admin_users id    DEFAULT     p   ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);
 =   ALTER TABLE public.admin_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    219    220    220            �           2604    53502    admin_users_roles_links id    DEFAULT     �   ALTER TABLE ONLY public.admin_users_roles_links ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_links_id_seq'::regclass);
 I   ALTER TABLE public.admin_users_roles_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    245    246    246            �           2604    53914    chapters id    DEFAULT     j   ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);
 :   ALTER TABLE public.chapters ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    270    269    270            �           2604    53939    chapters_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.chapters_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.chapters_localizations_links_id_seq'::regclass);
 N   ALTER TABLE public.chapters_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    273    274    274            �           2604    53983    chapters_preconditions_links id    DEFAULT     �   ALTER TABLE ONLY public.chapters_preconditions_links ALTER COLUMN id SET DEFAULT nextval('public.chapters_preconditions_links_id_seq'::regclass);
 N   ALTER TABLE public.chapters_preconditions_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    275    276    276            �           2604    53927    chapters_unit_links id    DEFAULT     �   ALTER TABLE ONLY public.chapters_unit_links ALTER COLUMN id SET DEFAULT nextval('public.chapters_unit_links_id_seq'::regclass);
 E   ALTER TABLE public.chapters_unit_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    272    271    272            �           2604    53996    chapters_unlocks_links id    DEFAULT     �   ALTER TABLE ONLY public.chapters_unlocks_links ALTER COLUMN id SET DEFAULT nextval('public.chapters_unlocks_links_id_seq'::regclass);
 H   ALTER TABLE public.chapters_unlocks_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    278    277    278            �           2604    54145    components_a_taglists id    DEFAULT     �   ALTER TABLE ONLY public.components_a_taglists ALTER COLUMN id SET DEFAULT nextval('public.components_a_taglists_id_seq'::regclass);
 G   ALTER TABLE public.components_a_taglists ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    289    290    290            �           2604    54176    components_a_verb_metas id    DEFAULT     �   ALTER TABLE ONLY public.components_a_verb_metas ALTER COLUMN id SET DEFAULT nextval('public.components_a_verb_metas_id_seq'::regclass);
 I   ALTER TABLE public.components_a_verb_metas ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    294    293    294            �           2604    53416    files id    DEFAULT     d   ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
 7   ALTER TABLE public.files ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    231    232    232            �           2604    53551    files_folder_links id    DEFAULT     ~   ALTER TABLE ONLY public.files_folder_links ALTER COLUMN id SET DEFAULT nextval('public.files_folder_links_id_seq'::regclass);
 D   ALTER TABLE public.files_folder_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    253    254    254            �           2604    53539    files_related_morphs id    DEFAULT     �   ALTER TABLE ONLY public.files_related_morphs ALTER COLUMN id SET DEFAULT nextval('public.files_related_morphs_id_seq'::regclass);
 F   ALTER TABLE public.files_related_morphs ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    252    251    252            �           2604    53479    i18n_locale id    DEFAULT     p   ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);
 =   ALTER TABLE public.i18n_locale ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    242    241    242            �           2604    54031 
   lessons id    DEFAULT     h   ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);
 9   ALTER TABLE public.lessons ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    280    279    280            �           2604    54044    lessons_chapter_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_chapter_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_chapter_links_id_seq'::regclass);
 G   ALTER TABLE public.lessons_chapter_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    282    281    282            �           2604    54056    lessons_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.lessons_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.lessons_localizations_links_id_seq'::regclass);
 M   ALTER TABLE public.lessons_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    283    284    284            �           2604    54100    sentences id    DEFAULT     l   ALTER TABLE ONLY public.sentences ALTER COLUMN id SET DEFAULT nextval('public.sentences_id_seq'::regclass);
 ;   ALTER TABLE public.sentences ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    285    286    286            �           2604    54154    sentences_components id    DEFAULT     �   ALTER TABLE ONLY public.sentences_components ALTER COLUMN id SET DEFAULT nextval('public.sentences_components_id_seq'::regclass);
 F   ALTER TABLE public.sentences_components ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    292    291    292            �           2604    54111     sentences_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.sentences_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.sentences_localizations_links_id_seq'::regclass);
 O   ALTER TABLE public.sentences_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    288    287    288            �           2604    53387    strapi_api_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);
 N   ALTER TABLE public.strapi_api_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    225    226    226            �           2604    53515 +   strapi_api_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_links_id_seq'::regclass);
 Z   ALTER TABLE public.strapi_api_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    248    247    248            �           2604    53376    strapi_api_tokens id    DEFAULT     |   ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);
 C   ALTER TABLE public.strapi_api_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    223    224    224            �           2604    53325    strapi_core_store_settings id    DEFAULT     �   ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);
 L   ALTER TABLE public.strapi_core_store_settings ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    214    213    214            �           2604    53316    strapi_database_schema id    DEFAULT     �   ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);
 H   ALTER TABLE public.strapi_database_schema ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    211    212    212            �           2604    53309    strapi_migrations id    DEFAULT     |   ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);
 C   ALTER TABLE public.strapi_migrations ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    209    210    210            �           2604    53407 $   strapi_transfer_token_permissions id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);
 S   ALTER TABLE public.strapi_transfer_token_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    230    229    230            �           2604    53527 0   strapi_transfer_token_permissions_token_links id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_links_id_seq'::regclass);
 _   ALTER TABLE public.strapi_transfer_token_permissions_token_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    250    249    250            �           2604    53396    strapi_transfer_tokens id    DEFAULT     �   ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);
 H   ALTER TABLE public.strapi_transfer_tokens ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    227    228    228            �           2604    53334    strapi_webhooks id    DEFAULT     x   ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);
 A   ALTER TABLE public.strapi_webhooks ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    216    215    216            �           2604    53819    units id    DEFAULT     d   ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);
 7   ALTER TABLE public.units ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    262    261    262            �           2604    53832    units_localizations_links id    DEFAULT     �   ALTER TABLE ONLY public.units_localizations_links ALTER COLUMN id SET DEFAULT nextval('public.units_localizations_links_id_seq'::regclass);
 K   ALTER TABLE public.units_localizations_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    263    264    264            �           2604    53866    units_preconditions_links id    DEFAULT     �   ALTER TABLE ONLY public.units_preconditions_links ALTER COLUMN id SET DEFAULT nextval('public.units_preconditions_links_id_seq'::regclass);
 K   ALTER TABLE public.units_preconditions_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    265    266    266            �           2604    53879    units_unlocks_links id    DEFAULT     �   ALTER TABLE ONLY public.units_unlocks_links ALTER COLUMN id SET DEFAULT nextval('public.units_unlocks_links_id_seq'::regclass);
 E   ALTER TABLE public.units_unlocks_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    267    268    268            �           2604    53448    up_permissions id    DEFAULT     v   ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);
 @   ALTER TABLE public.up_permissions ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    235    236    236            �           2604    53575    up_permissions_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_permissions_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_links_id_seq'::regclass);
 K   ALTER TABLE public.up_permissions_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    258    257    258            �           2604    53457    up_roles id    DEFAULT     j   ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);
 :   ALTER TABLE public.up_roles ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    237    238    238            �           2604    53468    up_users id    DEFAULT     j   ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);
 :   ALTER TABLE public.up_users ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    239    240    240            �           2604    53587    up_users_role_links id    DEFAULT     �   ALTER TABLE ONLY public.up_users_role_links ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_links_id_seq'::regclass);
 E   ALTER TABLE public.up_users_role_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    259    260    260            �           2604    53433    upload_folders id    DEFAULT     v   ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);
 @   ALTER TABLE public.upload_folders ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    233    234    234            �           2604    53563    upload_folders_parent_links id    DEFAULT     �   ALTER TABLE ONLY public.upload_folders_parent_links ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_links_id_seq'::regclass);
 M   ALTER TABLE public.upload_folders_parent_links ALTER COLUMN id DROP DEFAULT;
       public          strapi    false    255    256    256                      0    53340    admin_permissions 
   TABLE DATA           �   COPY public.admin_permissions (id, action, action_parameters, subject, properties, conditions, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    218   �      �          0    53487    admin_permissions_role_links 
   TABLE DATA           d   COPY public.admin_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    244   `�      �          0    53362    admin_roles 
   TABLE DATA           x   COPY public.admin_roles (id, name, code, description, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    222   !�      �          0    53351    admin_users 
   TABLE DATA           �   COPY public.admin_users (id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    220   �      �          0    53499    admin_users_roles_links 
   TABLE DATA           _   COPY public.admin_users_roles_links (id, user_id, role_id, role_order, user_order) FROM stdin;
    public          strapi    false    246   ��      �          0    53911    chapters 
   TABLE DATA           �   COPY public.chapters (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    270   ��      �          0    53936    chapters_localizations_links 
   TABLE DATA           e   COPY public.chapters_localizations_links (id, chapter_id, inv_chapter_id, chapter_order) FROM stdin;
    public          strapi    false    274   ޼      �          0    53980    chapters_preconditions_links 
   TABLE DATA           x   COPY public.chapters_preconditions_links (id, chapter_id, inv_chapter_id, chapter_order, inv_chapter_order) FROM stdin;
    public          strapi    false    276   ��      �          0    53924    chapters_unit_links 
   TABLE DATA           U   COPY public.chapters_unit_links (id, chapter_id, unit_id, chapter_order) FROM stdin;
    public          strapi    false    272   �      �          0    53993    chapters_unlocks_links 
   TABLE DATA           r   COPY public.chapters_unlocks_links (id, chapter_id, inv_chapter_id, chapter_order, inv_chapter_order) FROM stdin;
    public          strapi    false    278   5�      �          0    54142    components_a_taglists 
   TABLE DATA           8   COPY public.components_a_taglists (id, tag) FROM stdin;
    public          strapi    false    290   R�      �          0    54173    components_a_verb_metas 
   TABLE DATA           �   COPY public.components_a_verb_metas (id, simple_past, past_participle, present_participle, thirdperson_singular, auxiliary_verb, conjugations) FROM stdin;
    public          strapi    false    294   o�      �          0    53413    files 
   TABLE DATA           �   COPY public.files (id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    232   ��      �          0    53548    files_folder_links 
   TABLE DATA           P   COPY public.files_folder_links (id, file_id, folder_id, file_order) FROM stdin;
    public          strapi    false    254   ��      �          0    53536    files_related_morphs 
   TABLE DATA           e   COPY public.files_related_morphs (id, file_id, related_id, related_type, field, "order") FROM stdin;
    public          strapi    false    252   ƽ      �          0    53476    i18n_locale 
   TABLE DATA           k   COPY public.i18n_locale (id, name, code, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    242   �      �          0    54028    lessons 
   TABLE DATA           }   COPY public.lessons (id, title, slug, description, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    280   /�      �          0    54041    lessons_chapter_links 
   TABLE DATA           X   COPY public.lessons_chapter_links (id, lesson_id, chapter_id, lesson_order) FROM stdin;
    public          strapi    false    282   L�      �          0    54053    lessons_localizations_links 
   TABLE DATA           a   COPY public.lessons_localizations_links (id, lesson_id, inv_lesson_id, lesson_order) FROM stdin;
    public          strapi    false    284   i�      �          0    54097 	   sentences 
   TABLE DATA           �   COPY public.sentences (id, title, instruction, base_text, target_text, created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    286   ��      �          0    54151    sentences_components 
   TABLE DATA           k   COPY public.sentences_components (id, entity_id, component_id, component_type, field, "order") FROM stdin;
    public          strapi    false    292   ��      �          0    54108    sentences_localizations_links 
   TABLE DATA           i   COPY public.sentences_localizations_links (id, sentence_id, inv_sentence_id, sentence_order) FROM stdin;
    public          strapi    false    288   ��      �          0    53384    strapi_api_token_permissions 
   TABLE DATA           x   COPY public.strapi_api_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    226   ݾ      �          0    53512 (   strapi_api_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_api_token_permissions_token_links (id, api_token_permission_id, api_token_id, api_token_permission_order) FROM stdin;
    public          strapi    false    248   ��      �          0    53373    strapi_api_tokens 
   TABLE DATA           �   COPY public.strapi_api_tokens (id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    224   �      {          0    53322    strapi_core_store_settings 
   TABLE DATA           \   COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
    public          strapi    false    214   4�      y          0    53313    strapi_database_schema 
   TABLE DATA           J   COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
    public          strapi    false    212   ��      w          0    53306    strapi_migrations 
   TABLE DATA           =   COPY public.strapi_migrations (id, name, "time") FROM stdin;
    public          strapi    false    210   q�      �          0    53404 !   strapi_transfer_token_permissions 
   TABLE DATA           }   COPY public.strapi_transfer_token_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    230   ��      �          0    53524 -   strapi_transfer_token_permissions_token_links 
   TABLE DATA           �   COPY public.strapi_transfer_token_permissions_token_links (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_order) FROM stdin;
    public          strapi    false    250   ��      �          0    53393    strapi_transfer_tokens 
   TABLE DATA           �   COPY public.strapi_transfer_tokens (id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    228   ��      }          0    53331    strapi_webhooks 
   TABLE DATA           R   COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
    public          strapi    false    216   ��      �          0    53816    units 
   TABLE DATA           �   COPY public.units (id, title, slug, description, "order", created_at, updated_at, created_by_id, updated_by_id, locale) FROM stdin;
    public          strapi    false    262   �      �          0    53829    units_localizations_links 
   TABLE DATA           Y   COPY public.units_localizations_links (id, unit_id, inv_unit_id, unit_order) FROM stdin;
    public          strapi    false    264   �      �          0    53863    units_preconditions_links 
   TABLE DATA           i   COPY public.units_preconditions_links (id, unit_id, inv_unit_id, unit_order, inv_unit_order) FROM stdin;
    public          strapi    false    266   <�      �          0    53876    units_unlocks_links 
   TABLE DATA           c   COPY public.units_unlocks_links (id, unit_id, inv_unit_id, unit_order, inv_unit_order) FROM stdin;
    public          strapi    false    268   Y�      �          0    53445    up_permissions 
   TABLE DATA           j   COPY public.up_permissions (id, action, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    236   v�      �          0    53572    up_permissions_role_links 
   TABLE DATA           a   COPY public.up_permissions_role_links (id, permission_id, role_id, permission_order) FROM stdin;
    public          strapi    false    258   D�      �          0    53454    up_roles 
   TABLE DATA           u   COPY public.up_roles (id, name, description, type, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    238   ��      �          0    53465    up_users 
   TABLE DATA           �   COPY public.up_users (id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    240   �      �          0    53584    up_users_role_links 
   TABLE DATA           O   COPY public.up_users_role_links (id, user_id, role_id, user_order) FROM stdin;
    public          strapi    false    260   /�      �          0    53430    upload_folders 
   TABLE DATA           w   COPY public.upload_folders (id, name, path_id, path, created_at, updated_at, created_by_id, updated_by_id) FROM stdin;
    public          strapi    false    234   L�      �          0    53560    upload_folders_parent_links 
   TABLE DATA           a   COPY public.upload_folders_parent_links (id, folder_id, inv_folder_id, folder_order) FROM stdin;
    public          strapi    false    256   i�      �           0    0    admin_permissions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.admin_permissions_id_seq', 100, true);
          public          strapi    false    217            �           0    0 #   admin_permissions_role_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.admin_permissions_role_links_id_seq', 100, true);
          public          strapi    false    243                        0    0    admin_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);
          public          strapi    false    221                       0    0    admin_users_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);
          public          strapi    false    219                       0    0    admin_users_roles_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.admin_users_roles_links_id_seq', 1, true);
          public          strapi    false    245                       0    0    chapters_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.chapters_id_seq', 1, false);
          public          strapi    false    269                       0    0 #   chapters_localizations_links_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.chapters_localizations_links_id_seq', 1, false);
          public          strapi    false    273                       0    0 #   chapters_preconditions_links_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.chapters_preconditions_links_id_seq', 1, false);
          public          strapi    false    275                       0    0    chapters_unit_links_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.chapters_unit_links_id_seq', 1, false);
          public          strapi    false    271                       0    0    chapters_unlocks_links_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.chapters_unlocks_links_id_seq', 1, false);
          public          strapi    false    277                       0    0    components_a_taglists_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.components_a_taglists_id_seq', 1, false);
          public          strapi    false    289            	           0    0    components_a_verb_metas_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.components_a_verb_metas_id_seq', 1, false);
          public          strapi    false    293            
           0    0    files_folder_links_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.files_folder_links_id_seq', 1, false);
          public          strapi    false    253                       0    0    files_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.files_id_seq', 1, false);
          public          strapi    false    231                       0    0    files_related_morphs_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.files_related_morphs_id_seq', 1, false);
          public          strapi    false    251                       0    0    i18n_locale_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);
          public          strapi    false    241                       0    0    lessons_chapter_links_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.lessons_chapter_links_id_seq', 1, false);
          public          strapi    false    281                       0    0    lessons_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.lessons_id_seq', 1, false);
          public          strapi    false    279                       0    0 "   lessons_localizations_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.lessons_localizations_links_id_seq', 1, false);
          public          strapi    false    283                       0    0    sentences_components_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.sentences_components_id_seq', 1, false);
          public          strapi    false    291                       0    0    sentences_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.sentences_id_seq', 1, false);
          public          strapi    false    285                       0    0 $   sentences_localizations_links_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.sentences_localizations_links_id_seq', 1, false);
          public          strapi    false    287                       0    0 #   strapi_api_token_permissions_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);
          public          strapi    false    225                       0    0 /   strapi_api_token_permissions_token_links_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    247                       0    0    strapi_api_tokens_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 1, false);
          public          strapi    false    223                       0    0 !   strapi_core_store_settings_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 28, true);
          public          strapi    false    213                       0    0    strapi_database_schema_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 10, true);
          public          strapi    false    211                       0    0    strapi_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);
          public          strapi    false    209                       0    0 (   strapi_transfer_token_permissions_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);
          public          strapi    false    229                       0    0 4   strapi_transfer_token_permissions_token_links_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_links_id_seq', 1, false);
          public          strapi    false    249                       0    0    strapi_transfer_tokens_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);
          public          strapi    false    227                       0    0    strapi_webhooks_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);
          public          strapi    false    215                       0    0    units_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.units_id_seq', 1, false);
          public          strapi    false    261                       0    0     units_localizations_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.units_localizations_links_id_seq', 1, false);
          public          strapi    false    263                        0    0     units_preconditions_links_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.units_preconditions_links_id_seq', 1, false);
          public          strapi    false    265            !           0    0    units_unlocks_links_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.units_unlocks_links_id_seq', 1, false);
          public          strapi    false    267            "           0    0    up_permissions_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.up_permissions_id_seq', 9, true);
          public          strapi    false    235            #           0    0     up_permissions_role_links_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.up_permissions_role_links_id_seq', 9, true);
          public          strapi    false    257            $           0    0    up_roles_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);
          public          strapi    false    237            %           0    0    up_users_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.up_users_id_seq', 1, false);
          public          strapi    false    239            &           0    0    up_users_role_links_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.up_users_role_links_id_seq', 1, false);
          public          strapi    false    259            '           0    0    upload_folders_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);
          public          strapi    false    233            (           0    0 "   upload_folders_parent_links_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.upload_folders_parent_links_id_seq', 1, false);
          public          strapi    false    255            �           2606    53347 (   admin_permissions admin_permissions_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_pkey;
       public            strapi    false    218            �           2606    53492 >   admin_permissions_role_links admin_permissions_role_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_pkey;
       public            strapi    false    244                        2606    53496 @   admin_permissions_role_links admin_permissions_role_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_unique UNIQUE (permission_id, role_id);
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_unique;
       public            strapi    false    244    244            �           2606    53369    admin_roles admin_roles_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_pkey;
       public            strapi    false    222            �           2606    53358    admin_users admin_users_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_pkey;
       public            strapi    false    220                       2606    53504 4   admin_users_roles_links admin_users_roles_links_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_pkey;
       public            strapi    false    246                       2606    53508 6   admin_users_roles_links admin_users_roles_links_unique 
   CONSTRAINT     }   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_unique UNIQUE (user_id, role_id);
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_unique;
       public            strapi    false    246    246            f           2606    53941 >   chapters_localizations_links chapters_localizations_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.chapters_localizations_links
    ADD CONSTRAINT chapters_localizations_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.chapters_localizations_links DROP CONSTRAINT chapters_localizations_links_pkey;
       public            strapi    false    274            h           2606    53945 @   chapters_localizations_links chapters_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.chapters_localizations_links
    ADD CONSTRAINT chapters_localizations_links_unique UNIQUE (chapter_id, inv_chapter_id);
 j   ALTER TABLE ONLY public.chapters_localizations_links DROP CONSTRAINT chapters_localizations_links_unique;
       public            strapi    false    274    274            W           2606    53918    chapters chapters_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.chapters DROP CONSTRAINT chapters_pkey;
       public            strapi    false    270            n           2606    53985 >   chapters_preconditions_links chapters_preconditions_links_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.chapters_preconditions_links
    ADD CONSTRAINT chapters_preconditions_links_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.chapters_preconditions_links DROP CONSTRAINT chapters_preconditions_links_pkey;
       public            strapi    false    276            p           2606    53989 @   chapters_preconditions_links chapters_preconditions_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.chapters_preconditions_links
    ADD CONSTRAINT chapters_preconditions_links_unique UNIQUE (chapter_id, inv_chapter_id);
 j   ALTER TABLE ONLY public.chapters_preconditions_links DROP CONSTRAINT chapters_preconditions_links_unique;
       public            strapi    false    276    276            Y           2606    53920    chapters chapters_slug_unique 
   CONSTRAINT     X   ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_slug_unique UNIQUE (slug);
 G   ALTER TABLE ONLY public.chapters DROP CONSTRAINT chapters_slug_unique;
       public            strapi    false    270            _           2606    53929 ,   chapters_unit_links chapters_unit_links_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.chapters_unit_links
    ADD CONSTRAINT chapters_unit_links_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.chapters_unit_links DROP CONSTRAINT chapters_unit_links_pkey;
       public            strapi    false    272            a           2606    53933 .   chapters_unit_links chapters_unit_links_unique 
   CONSTRAINT     x   ALTER TABLE ONLY public.chapters_unit_links
    ADD CONSTRAINT chapters_unit_links_unique UNIQUE (chapter_id, unit_id);
 X   ALTER TABLE ONLY public.chapters_unit_links DROP CONSTRAINT chapters_unit_links_unique;
       public            strapi    false    272    272            v           2606    53998 2   chapters_unlocks_links chapters_unlocks_links_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.chapters_unlocks_links
    ADD CONSTRAINT chapters_unlocks_links_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.chapters_unlocks_links DROP CONSTRAINT chapters_unlocks_links_pkey;
       public            strapi    false    278            x           2606    54002 4   chapters_unlocks_links chapters_unlocks_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.chapters_unlocks_links
    ADD CONSTRAINT chapters_unlocks_links_unique UNIQUE (chapter_id, inv_chapter_id);
 ^   ALTER TABLE ONLY public.chapters_unlocks_links DROP CONSTRAINT chapters_unlocks_links_unique;
       public            strapi    false    278    278            �           2606    54147 0   components_a_taglists components_a_taglists_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.components_a_taglists
    ADD CONSTRAINT components_a_taglists_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.components_a_taglists DROP CONSTRAINT components_a_taglists_pkey;
       public            strapi    false    290            �           2606    54180 4   components_a_verb_metas components_a_verb_metas_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.components_a_verb_metas
    ADD CONSTRAINT components_a_verb_metas_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.components_a_verb_metas DROP CONSTRAINT components_a_verb_metas_pkey;
       public            strapi    false    294                        2606    53553 *   files_folder_links files_folder_links_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_pkey;
       public            strapi    false    254            "           2606    53557 ,   files_folder_links files_folder_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_unique UNIQUE (file_id, folder_id);
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_unique;
       public            strapi    false    254    254            �           2606    53420    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            strapi    false    232                       2606    53543 .   files_related_morphs files_related_morphs_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_pkey;
       public            strapi    false    252            �           2606    53483    i18n_locale i18n_locale_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_pkey;
       public            strapi    false    242            �           2606    54046 0   lessons_chapter_links lessons_chapter_links_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.lessons_chapter_links
    ADD CONSTRAINT lessons_chapter_links_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.lessons_chapter_links DROP CONSTRAINT lessons_chapter_links_pkey;
       public            strapi    false    282            �           2606    54050 2   lessons_chapter_links lessons_chapter_links_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY public.lessons_chapter_links
    ADD CONSTRAINT lessons_chapter_links_unique UNIQUE (lesson_id, chapter_id);
 \   ALTER TABLE ONLY public.lessons_chapter_links DROP CONSTRAINT lessons_chapter_links_unique;
       public            strapi    false    282    282            �           2606    54058 <   lessons_localizations_links lessons_localizations_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_pkey;
       public            strapi    false    284            �           2606    54062 >   lessons_localizations_links lessons_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_unique UNIQUE (lesson_id, inv_lesson_id);
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_unique;
       public            strapi    false    284    284            {           2606    54035    lessons lessons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_pkey;
       public            strapi    false    280            }           2606    54037    lessons lessons_slug_unique 
   CONSTRAINT     V   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_slug_unique UNIQUE (slug);
 E   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_slug_unique;
       public            strapi    false    280            �           2606    54158 .   sentences_components sentences_components_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_components_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_components_pkey;
       public            strapi    false    292            �           2606    54113 @   sentences_localizations_links sentences_localizations_links_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_pkey;
       public            strapi    false    288            �           2606    54117 B   sentences_localizations_links sentences_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_unique UNIQUE (sentence_id, inv_sentence_id);
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_unique;
       public            strapi    false    288    288            �           2606    54104    sentences sentences_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_pkey;
       public            strapi    false    286            �           2606    54182 %   sentences_components sentences_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_unique UNIQUE (entity_id, component_id, field, component_type);
 O   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_unique;
       public            strapi    false    292    292    292    292            �           2606    53389 >   strapi_api_token_permissions strapi_api_token_permissions_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_pkey;
       public            strapi    false    226                       2606    53517 V   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_pkey;
       public            strapi    false    248                       2606    53521 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_unique UNIQUE (api_token_permission_id, api_token_id);
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_unique;
       public            strapi    false    248    248            �           2606    53380 (   strapi_api_tokens strapi_api_tokens_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_pkey;
       public            strapi    false    224            �           2606    53329 :   strapi_core_store_settings strapi_core_store_settings_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.strapi_core_store_settings DROP CONSTRAINT strapi_core_store_settings_pkey;
       public            strapi    false    214            �           2606    53320 2   strapi_database_schema strapi_database_schema_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_database_schema DROP CONSTRAINT strapi_database_schema_pkey;
       public            strapi    false    212            �           2606    53311 (   strapi_migrations strapi_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.strapi_migrations DROP CONSTRAINT strapi_migrations_pkey;
       public            strapi    false    210            �           2606    53409 H   strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_pkey;
       public            strapi    false    230                       2606    53529 `   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_pkey PRIMARY KEY (id);
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_pkey;
       public            strapi    false    250                       2606    53533 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_unique UNIQUE (transfer_token_permission_id, transfer_token_id);
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_unique;
       public            strapi    false    250    250            �           2606    53400 2   strapi_transfer_tokens strapi_transfer_tokens_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_pkey;
       public            strapi    false    228            �           2606    53338 $   strapi_webhooks strapi_webhooks_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.strapi_webhooks DROP CONSTRAINT strapi_webhooks_pkey;
       public            strapi    false    216            B           2606    53834 8   units_localizations_links units_localizations_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_pkey;
       public            strapi    false    264            D           2606    53838 :   units_localizations_links units_localizations_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_unique UNIQUE (unit_id, inv_unit_id);
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_unique;
       public            strapi    false    264    264            :           2606    53823    units units_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.units DROP CONSTRAINT units_pkey;
       public            strapi    false    262            J           2606    53868 8   units_preconditions_links units_preconditions_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.units_preconditions_links
    ADD CONSTRAINT units_preconditions_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.units_preconditions_links DROP CONSTRAINT units_preconditions_links_pkey;
       public            strapi    false    266            L           2606    53872 :   units_preconditions_links units_preconditions_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.units_preconditions_links
    ADD CONSTRAINT units_preconditions_links_unique UNIQUE (unit_id, inv_unit_id);
 d   ALTER TABLE ONLY public.units_preconditions_links DROP CONSTRAINT units_preconditions_links_unique;
       public            strapi    false    266    266            <           2606    53825    units units_slug_unique 
   CONSTRAINT     R   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_slug_unique UNIQUE (slug);
 A   ALTER TABLE ONLY public.units DROP CONSTRAINT units_slug_unique;
       public            strapi    false    262            R           2606    53881 ,   units_unlocks_links units_unlocks_links_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.units_unlocks_links
    ADD CONSTRAINT units_unlocks_links_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.units_unlocks_links DROP CONSTRAINT units_unlocks_links_pkey;
       public            strapi    false    268            T           2606    53885 .   units_unlocks_links units_unlocks_links_unique 
   CONSTRAINT     y   ALTER TABLE ONLY public.units_unlocks_links
    ADD CONSTRAINT units_unlocks_links_unique UNIQUE (unit_id, inv_unit_id);
 X   ALTER TABLE ONLY public.units_unlocks_links DROP CONSTRAINT units_unlocks_links_unique;
       public            strapi    false    268    268            �           2606    53450 "   up_permissions up_permissions_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_pkey;
       public            strapi    false    236            .           2606    53577 8   up_permissions_role_links up_permissions_role_links_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_pkey;
       public            strapi    false    258            0           2606    53581 :   up_permissions_role_links up_permissions_role_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_unique UNIQUE (permission_id, role_id);
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_unique;
       public            strapi    false    258    258            �           2606    53461    up_roles up_roles_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_pkey;
       public            strapi    false    238            �           2606    53472    up_users up_users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_pkey;
       public            strapi    false    240            5           2606    53589 ,   up_users_role_links up_users_role_links_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_pkey;
       public            strapi    false    260            7           2606    53593 .   up_users_role_links up_users_role_links_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_unique UNIQUE (user_id, role_id);
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_unique;
       public            strapi    false    260    260            '           2606    53565 <   upload_folders_parent_links upload_folders_parent_links_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_pkey;
       public            strapi    false    256            )           2606    53569 >   upload_folders_parent_links upload_folders_parent_links_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_unique UNIQUE (folder_id, inv_folder_id);
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_unique;
       public            strapi    false    256    256            �           2606    53439 +   upload_folders upload_folders_path_id_index 
   CONSTRAINT     i   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);
 U   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_path_id_index;
       public            strapi    false    234            �           2606    53441 (   upload_folders upload_folders_path_index 
   CONSTRAINT     c   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);
 R   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_path_index;
       public            strapi    false    234            �           2606    53437 "   upload_folders upload_folders_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_pkey;
       public            strapi    false    234            �           1259    53348 "   admin_permissions_created_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);
 6   DROP INDEX public.admin_permissions_created_by_id_fk;
       public            strapi    false    218            �           1259    53493    admin_permissions_role_links_fk    INDEX     q   CREATE INDEX admin_permissions_role_links_fk ON public.admin_permissions_role_links USING btree (permission_id);
 3   DROP INDEX public.admin_permissions_role_links_fk;
       public            strapi    false    244            �           1259    53494 #   admin_permissions_role_links_inv_fk    INDEX     o   CREATE INDEX admin_permissions_role_links_inv_fk ON public.admin_permissions_role_links USING btree (role_id);
 7   DROP INDEX public.admin_permissions_role_links_inv_fk;
       public            strapi    false    244            �           1259    53497 )   admin_permissions_role_links_order_inv_fk    INDEX     ~   CREATE INDEX admin_permissions_role_links_order_inv_fk ON public.admin_permissions_role_links USING btree (permission_order);
 =   DROP INDEX public.admin_permissions_role_links_order_inv_fk;
       public            strapi    false    244            �           1259    53349 "   admin_permissions_updated_by_id_fk    INDEX     i   CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);
 6   DROP INDEX public.admin_permissions_updated_by_id_fk;
       public            strapi    false    218            �           1259    53370    admin_roles_created_by_id_fk    INDEX     ]   CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);
 0   DROP INDEX public.admin_roles_created_by_id_fk;
       public            strapi    false    222            �           1259    53371    admin_roles_updated_by_id_fk    INDEX     ]   CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);
 0   DROP INDEX public.admin_roles_updated_by_id_fk;
       public            strapi    false    222            �           1259    53359    admin_users_created_by_id_fk    INDEX     ]   CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);
 0   DROP INDEX public.admin_users_created_by_id_fk;
       public            strapi    false    220                       1259    53505    admin_users_roles_links_fk    INDEX     a   CREATE INDEX admin_users_roles_links_fk ON public.admin_users_roles_links USING btree (user_id);
 .   DROP INDEX public.admin_users_roles_links_fk;
       public            strapi    false    246                       1259    53506    admin_users_roles_links_inv_fk    INDEX     e   CREATE INDEX admin_users_roles_links_inv_fk ON public.admin_users_roles_links USING btree (role_id);
 2   DROP INDEX public.admin_users_roles_links_inv_fk;
       public            strapi    false    246                       1259    53509     admin_users_roles_links_order_fk    INDEX     j   CREATE INDEX admin_users_roles_links_order_fk ON public.admin_users_roles_links USING btree (role_order);
 4   DROP INDEX public.admin_users_roles_links_order_fk;
       public            strapi    false    246                       1259    53510 $   admin_users_roles_links_order_inv_fk    INDEX     n   CREATE INDEX admin_users_roles_links_order_inv_fk ON public.admin_users_roles_links USING btree (user_order);
 8   DROP INDEX public.admin_users_roles_links_order_inv_fk;
       public            strapi    false    246            �           1259    53360    admin_users_updated_by_id_fk    INDEX     ]   CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);
 0   DROP INDEX public.admin_users_updated_by_id_fk;
       public            strapi    false    220            U           1259    53921    chapters_created_by_id_fk    INDEX     W   CREATE INDEX chapters_created_by_id_fk ON public.chapters USING btree (created_by_id);
 -   DROP INDEX public.chapters_created_by_id_fk;
       public            strapi    false    270            b           1259    53942    chapters_localizations_links_fk    INDEX     n   CREATE INDEX chapters_localizations_links_fk ON public.chapters_localizations_links USING btree (chapter_id);
 3   DROP INDEX public.chapters_localizations_links_fk;
       public            strapi    false    274            c           1259    53943 #   chapters_localizations_links_inv_fk    INDEX     v   CREATE INDEX chapters_localizations_links_inv_fk ON public.chapters_localizations_links USING btree (inv_chapter_id);
 7   DROP INDEX public.chapters_localizations_links_inv_fk;
       public            strapi    false    274            d           1259    53946 %   chapters_localizations_links_order_fk    INDEX     w   CREATE INDEX chapters_localizations_links_order_fk ON public.chapters_localizations_links USING btree (chapter_order);
 9   DROP INDEX public.chapters_localizations_links_order_fk;
       public            strapi    false    274            i           1259    53986    chapters_preconditions_links_fk    INDEX     n   CREATE INDEX chapters_preconditions_links_fk ON public.chapters_preconditions_links USING btree (chapter_id);
 3   DROP INDEX public.chapters_preconditions_links_fk;
       public            strapi    false    276            j           1259    53987 #   chapters_preconditions_links_inv_fk    INDEX     v   CREATE INDEX chapters_preconditions_links_inv_fk ON public.chapters_preconditions_links USING btree (inv_chapter_id);
 7   DROP INDEX public.chapters_preconditions_links_inv_fk;
       public            strapi    false    276            k           1259    53990 %   chapters_preconditions_links_order_fk    INDEX     w   CREATE INDEX chapters_preconditions_links_order_fk ON public.chapters_preconditions_links USING btree (chapter_order);
 9   DROP INDEX public.chapters_preconditions_links_order_fk;
       public            strapi    false    276            l           1259    53991 )   chapters_preconditions_links_order_inv_fk    INDEX        CREATE INDEX chapters_preconditions_links_order_inv_fk ON public.chapters_preconditions_links USING btree (inv_chapter_order);
 =   DROP INDEX public.chapters_preconditions_links_order_inv_fk;
       public            strapi    false    276            [           1259    53930    chapters_unit_links_fk    INDEX     \   CREATE INDEX chapters_unit_links_fk ON public.chapters_unit_links USING btree (chapter_id);
 *   DROP INDEX public.chapters_unit_links_fk;
       public            strapi    false    272            \           1259    53931    chapters_unit_links_inv_fk    INDEX     ]   CREATE INDEX chapters_unit_links_inv_fk ON public.chapters_unit_links USING btree (unit_id);
 .   DROP INDEX public.chapters_unit_links_inv_fk;
       public            strapi    false    272            ]           1259    53934     chapters_unit_links_order_inv_fk    INDEX     i   CREATE INDEX chapters_unit_links_order_inv_fk ON public.chapters_unit_links USING btree (chapter_order);
 4   DROP INDEX public.chapters_unit_links_order_inv_fk;
       public            strapi    false    272            q           1259    53999    chapters_unlocks_links_fk    INDEX     b   CREATE INDEX chapters_unlocks_links_fk ON public.chapters_unlocks_links USING btree (chapter_id);
 -   DROP INDEX public.chapters_unlocks_links_fk;
       public            strapi    false    278            r           1259    54000    chapters_unlocks_links_inv_fk    INDEX     j   CREATE INDEX chapters_unlocks_links_inv_fk ON public.chapters_unlocks_links USING btree (inv_chapter_id);
 1   DROP INDEX public.chapters_unlocks_links_inv_fk;
       public            strapi    false    278            s           1259    54003    chapters_unlocks_links_order_fk    INDEX     k   CREATE INDEX chapters_unlocks_links_order_fk ON public.chapters_unlocks_links USING btree (chapter_order);
 3   DROP INDEX public.chapters_unlocks_links_order_fk;
       public            strapi    false    278            t           1259    54004 #   chapters_unlocks_links_order_inv_fk    INDEX     s   CREATE INDEX chapters_unlocks_links_order_inv_fk ON public.chapters_unlocks_links USING btree (inv_chapter_order);
 7   DROP INDEX public.chapters_unlocks_links_order_inv_fk;
       public            strapi    false    278            Z           1259    53922    chapters_updated_by_id_fk    INDEX     W   CREATE INDEX chapters_updated_by_id_fk ON public.chapters USING btree (updated_by_id);
 -   DROP INDEX public.chapters_updated_by_id_fk;
       public            strapi    false    270            �           1259    53427    files_created_by_id_fk    INDEX     Q   CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);
 *   DROP INDEX public.files_created_by_id_fk;
       public            strapi    false    232                       1259    53554    files_folder_links_fk    INDEX     W   CREATE INDEX files_folder_links_fk ON public.files_folder_links USING btree (file_id);
 )   DROP INDEX public.files_folder_links_fk;
       public            strapi    false    254                       1259    53555    files_folder_links_inv_fk    INDEX     ]   CREATE INDEX files_folder_links_inv_fk ON public.files_folder_links USING btree (folder_id);
 -   DROP INDEX public.files_folder_links_inv_fk;
       public            strapi    false    254                       1259    53558    files_folder_links_order_inv_fk    INDEX     d   CREATE INDEX files_folder_links_order_inv_fk ON public.files_folder_links USING btree (file_order);
 3   DROP INDEX public.files_folder_links_order_inv_fk;
       public            strapi    false    254                       1259    53544    files_related_morphs_fk    INDEX     [   CREATE INDEX files_related_morphs_fk ON public.files_related_morphs USING btree (file_id);
 +   DROP INDEX public.files_related_morphs_fk;
       public            strapi    false    252                       1259    53546 $   files_related_morphs_id_column_index    INDEX     k   CREATE INDEX files_related_morphs_id_column_index ON public.files_related_morphs USING btree (related_id);
 8   DROP INDEX public.files_related_morphs_id_column_index;
       public            strapi    false    252                       1259    53545     files_related_morphs_order_index    INDEX     d   CREATE INDEX files_related_morphs_order_index ON public.files_related_morphs USING btree ("order");
 4   DROP INDEX public.files_related_morphs_order_index;
       public            strapi    false    252            �           1259    53428    files_updated_by_id_fk    INDEX     Q   CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);
 *   DROP INDEX public.files_updated_by_id_fk;
       public            strapi    false    232            �           1259    53484    i18n_locale_created_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);
 0   DROP INDEX public.i18n_locale_created_by_id_fk;
       public            strapi    false    242            �           1259    53485    i18n_locale_updated_by_id_fk    INDEX     ]   CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);
 0   DROP INDEX public.i18n_locale_updated_by_id_fk;
       public            strapi    false    242                       1259    54047    lessons_chapter_links_fk    INDEX     _   CREATE INDEX lessons_chapter_links_fk ON public.lessons_chapter_links USING btree (lesson_id);
 ,   DROP INDEX public.lessons_chapter_links_fk;
       public            strapi    false    282            �           1259    54048    lessons_chapter_links_inv_fk    INDEX     d   CREATE INDEX lessons_chapter_links_inv_fk ON public.lessons_chapter_links USING btree (chapter_id);
 0   DROP INDEX public.lessons_chapter_links_inv_fk;
       public            strapi    false    282            �           1259    54051 "   lessons_chapter_links_order_inv_fk    INDEX     l   CREATE INDEX lessons_chapter_links_order_inv_fk ON public.lessons_chapter_links USING btree (lesson_order);
 6   DROP INDEX public.lessons_chapter_links_order_inv_fk;
       public            strapi    false    282            y           1259    54038    lessons_created_by_id_fk    INDEX     U   CREATE INDEX lessons_created_by_id_fk ON public.lessons USING btree (created_by_id);
 ,   DROP INDEX public.lessons_created_by_id_fk;
       public            strapi    false    280            �           1259    54059    lessons_localizations_links_fk    INDEX     k   CREATE INDEX lessons_localizations_links_fk ON public.lessons_localizations_links USING btree (lesson_id);
 2   DROP INDEX public.lessons_localizations_links_fk;
       public            strapi    false    284            �           1259    54060 "   lessons_localizations_links_inv_fk    INDEX     s   CREATE INDEX lessons_localizations_links_inv_fk ON public.lessons_localizations_links USING btree (inv_lesson_id);
 6   DROP INDEX public.lessons_localizations_links_inv_fk;
       public            strapi    false    284            �           1259    54063 $   lessons_localizations_links_order_fk    INDEX     t   CREATE INDEX lessons_localizations_links_order_fk ON public.lessons_localizations_links USING btree (lesson_order);
 8   DROP INDEX public.lessons_localizations_links_order_fk;
       public            strapi    false    284            ~           1259    54039    lessons_updated_by_id_fk    INDEX     U   CREATE INDEX lessons_updated_by_id_fk ON public.lessons USING btree (updated_by_id);
 ,   DROP INDEX public.lessons_updated_by_id_fk;
       public            strapi    false    280            �           1259    54160    sentences_component_type_index    INDEX     i   CREATE INDEX sentences_component_type_index ON public.sentences_components USING btree (component_type);
 2   DROP INDEX public.sentences_component_type_index;
       public            strapi    false    292            �           1259    54105    sentences_created_by_id_fk    INDEX     Y   CREATE INDEX sentences_created_by_id_fk ON public.sentences USING btree (created_by_id);
 .   DROP INDEX public.sentences_created_by_id_fk;
       public            strapi    false    286            �           1259    54161    sentences_entity_fk    INDEX     Y   CREATE INDEX sentences_entity_fk ON public.sentences_components USING btree (entity_id);
 '   DROP INDEX public.sentences_entity_fk;
       public            strapi    false    292            �           1259    54159    sentences_field_index    INDEX     W   CREATE INDEX sentences_field_index ON public.sentences_components USING btree (field);
 )   DROP INDEX public.sentences_field_index;
       public            strapi    false    292            �           1259    54114     sentences_localizations_links_fk    INDEX     q   CREATE INDEX sentences_localizations_links_fk ON public.sentences_localizations_links USING btree (sentence_id);
 4   DROP INDEX public.sentences_localizations_links_fk;
       public            strapi    false    288            �           1259    54115 $   sentences_localizations_links_inv_fk    INDEX     y   CREATE INDEX sentences_localizations_links_inv_fk ON public.sentences_localizations_links USING btree (inv_sentence_id);
 8   DROP INDEX public.sentences_localizations_links_inv_fk;
       public            strapi    false    288            �           1259    54118 &   sentences_localizations_links_order_fk    INDEX     z   CREATE INDEX sentences_localizations_links_order_fk ON public.sentences_localizations_links USING btree (sentence_order);
 :   DROP INDEX public.sentences_localizations_links_order_fk;
       public            strapi    false    288            �           1259    54106    sentences_updated_by_id_fk    INDEX     Y   CREATE INDEX sentences_updated_by_id_fk ON public.sentences USING btree (updated_by_id);
 .   DROP INDEX public.sentences_updated_by_id_fk;
       public            strapi    false    286            �           1259    53390 -   strapi_api_token_permissions_created_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_created_by_id_fk;
       public            strapi    false    226            	           1259    53518 +   strapi_api_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id);
 ?   DROP INDEX public.strapi_api_token_permissions_token_links_fk;
       public            strapi    false    248            
           1259    53519 /   strapi_api_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id);
 C   DROP INDEX public.strapi_api_token_permissions_token_links_inv_fk;
       public            strapi    false    248                       1259    53522 5   strapi_api_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order);
 I   DROP INDEX public.strapi_api_token_permissions_token_links_order_inv_fk;
       public            strapi    false    248            �           1259    53391 -   strapi_api_token_permissions_updated_by_id_fk    INDEX        CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);
 A   DROP INDEX public.strapi_api_token_permissions_updated_by_id_fk;
       public            strapi    false    226            �           1259    53381 "   strapi_api_tokens_created_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);
 6   DROP INDEX public.strapi_api_tokens_created_by_id_fk;
       public            strapi    false    224            �           1259    53382 "   strapi_api_tokens_updated_by_id_fk    INDEX     i   CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);
 6   DROP INDEX public.strapi_api_tokens_updated_by_id_fk;
       public            strapi    false    224            �           1259    53410 2   strapi_transfer_token_permissions_created_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_created_by_id_fk;
       public            strapi    false    230                       1259    53530 0   strapi_transfer_token_permissions_token_links_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_id);
 D   DROP INDEX public.strapi_transfer_token_permissions_token_links_fk;
       public            strapi    false    250                       1259    53531 4   strapi_transfer_token_permissions_token_links_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_id);
 H   DROP INDEX public.strapi_transfer_token_permissions_token_links_inv_fk;
       public            strapi    false    250                       1259    53534 :   strapi_transfer_token_permissions_token_links_order_inv_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_token_links_order_inv_fk ON public.strapi_transfer_token_permissions_token_links USING btree (transfer_token_permission_order);
 N   DROP INDEX public.strapi_transfer_token_permissions_token_links_order_inv_fk;
       public            strapi    false    250            �           1259    53411 2   strapi_transfer_token_permissions_updated_by_id_fk    INDEX     �   CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);
 F   DROP INDEX public.strapi_transfer_token_permissions_updated_by_id_fk;
       public            strapi    false    230            �           1259    53401 '   strapi_transfer_tokens_created_by_id_fk    INDEX     s   CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);
 ;   DROP INDEX public.strapi_transfer_tokens_created_by_id_fk;
       public            strapi    false    228            �           1259    53402 '   strapi_transfer_tokens_updated_by_id_fk    INDEX     s   CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);
 ;   DROP INDEX public.strapi_transfer_tokens_updated_by_id_fk;
       public            strapi    false    228            8           1259    53826    units_created_by_id_fk    INDEX     Q   CREATE INDEX units_created_by_id_fk ON public.units USING btree (created_by_id);
 *   DROP INDEX public.units_created_by_id_fk;
       public            strapi    false    262            >           1259    53835    units_localizations_links_fk    INDEX     e   CREATE INDEX units_localizations_links_fk ON public.units_localizations_links USING btree (unit_id);
 0   DROP INDEX public.units_localizations_links_fk;
       public            strapi    false    264            ?           1259    53836     units_localizations_links_inv_fk    INDEX     m   CREATE INDEX units_localizations_links_inv_fk ON public.units_localizations_links USING btree (inv_unit_id);
 4   DROP INDEX public.units_localizations_links_inv_fk;
       public            strapi    false    264            @           1259    53839 "   units_localizations_links_order_fk    INDEX     n   CREATE INDEX units_localizations_links_order_fk ON public.units_localizations_links USING btree (unit_order);
 6   DROP INDEX public.units_localizations_links_order_fk;
       public            strapi    false    264            E           1259    53869    units_preconditions_links_fk    INDEX     e   CREATE INDEX units_preconditions_links_fk ON public.units_preconditions_links USING btree (unit_id);
 0   DROP INDEX public.units_preconditions_links_fk;
       public            strapi    false    266            F           1259    53870     units_preconditions_links_inv_fk    INDEX     m   CREATE INDEX units_preconditions_links_inv_fk ON public.units_preconditions_links USING btree (inv_unit_id);
 4   DROP INDEX public.units_preconditions_links_inv_fk;
       public            strapi    false    266            G           1259    53873 "   units_preconditions_links_order_fk    INDEX     n   CREATE INDEX units_preconditions_links_order_fk ON public.units_preconditions_links USING btree (unit_order);
 6   DROP INDEX public.units_preconditions_links_order_fk;
       public            strapi    false    266            H           1259    53874 &   units_preconditions_links_order_inv_fk    INDEX     v   CREATE INDEX units_preconditions_links_order_inv_fk ON public.units_preconditions_links USING btree (inv_unit_order);
 :   DROP INDEX public.units_preconditions_links_order_inv_fk;
       public            strapi    false    266            M           1259    53882    units_unlocks_links_fk    INDEX     Y   CREATE INDEX units_unlocks_links_fk ON public.units_unlocks_links USING btree (unit_id);
 *   DROP INDEX public.units_unlocks_links_fk;
       public            strapi    false    268            N           1259    53883    units_unlocks_links_inv_fk    INDEX     a   CREATE INDEX units_unlocks_links_inv_fk ON public.units_unlocks_links USING btree (inv_unit_id);
 .   DROP INDEX public.units_unlocks_links_inv_fk;
       public            strapi    false    268            O           1259    53886    units_unlocks_links_order_fk    INDEX     b   CREATE INDEX units_unlocks_links_order_fk ON public.units_unlocks_links USING btree (unit_order);
 0   DROP INDEX public.units_unlocks_links_order_fk;
       public            strapi    false    268            P           1259    53887     units_unlocks_links_order_inv_fk    INDEX     j   CREATE INDEX units_unlocks_links_order_inv_fk ON public.units_unlocks_links USING btree (inv_unit_order);
 4   DROP INDEX public.units_unlocks_links_order_inv_fk;
       public            strapi    false    268            =           1259    53827    units_updated_by_id_fk    INDEX     Q   CREATE INDEX units_updated_by_id_fk ON public.units USING btree (updated_by_id);
 *   DROP INDEX public.units_updated_by_id_fk;
       public            strapi    false    262            �           1259    53451    up_permissions_created_by_id_fk    INDEX     c   CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);
 3   DROP INDEX public.up_permissions_created_by_id_fk;
       public            strapi    false    236            *           1259    53578    up_permissions_role_links_fk    INDEX     k   CREATE INDEX up_permissions_role_links_fk ON public.up_permissions_role_links USING btree (permission_id);
 0   DROP INDEX public.up_permissions_role_links_fk;
       public            strapi    false    258            +           1259    53579     up_permissions_role_links_inv_fk    INDEX     i   CREATE INDEX up_permissions_role_links_inv_fk ON public.up_permissions_role_links USING btree (role_id);
 4   DROP INDEX public.up_permissions_role_links_inv_fk;
       public            strapi    false    258            ,           1259    53582 &   up_permissions_role_links_order_inv_fk    INDEX     x   CREATE INDEX up_permissions_role_links_order_inv_fk ON public.up_permissions_role_links USING btree (permission_order);
 :   DROP INDEX public.up_permissions_role_links_order_inv_fk;
       public            strapi    false    258            �           1259    53452    up_permissions_updated_by_id_fk    INDEX     c   CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);
 3   DROP INDEX public.up_permissions_updated_by_id_fk;
       public            strapi    false    236            �           1259    53462    up_roles_created_by_id_fk    INDEX     W   CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);
 -   DROP INDEX public.up_roles_created_by_id_fk;
       public            strapi    false    238            �           1259    53463    up_roles_updated_by_id_fk    INDEX     W   CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);
 -   DROP INDEX public.up_roles_updated_by_id_fk;
       public            strapi    false    238            �           1259    53473    up_users_created_by_id_fk    INDEX     W   CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);
 -   DROP INDEX public.up_users_created_by_id_fk;
       public            strapi    false    240            1           1259    53590    up_users_role_links_fk    INDEX     Y   CREATE INDEX up_users_role_links_fk ON public.up_users_role_links USING btree (user_id);
 *   DROP INDEX public.up_users_role_links_fk;
       public            strapi    false    260            2           1259    53591    up_users_role_links_inv_fk    INDEX     ]   CREATE INDEX up_users_role_links_inv_fk ON public.up_users_role_links USING btree (role_id);
 .   DROP INDEX public.up_users_role_links_inv_fk;
       public            strapi    false    260            3           1259    53594     up_users_role_links_order_inv_fk    INDEX     f   CREATE INDEX up_users_role_links_order_inv_fk ON public.up_users_role_links USING btree (user_order);
 4   DROP INDEX public.up_users_role_links_order_inv_fk;
       public            strapi    false    260            �           1259    53474    up_users_updated_by_id_fk    INDEX     W   CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);
 -   DROP INDEX public.up_users_updated_by_id_fk;
       public            strapi    false    240            �           1259    53422    upload_files_created_at_index    INDEX     U   CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);
 1   DROP INDEX public.upload_files_created_at_index;
       public            strapi    false    232            �           1259    53426    upload_files_ext_index    INDEX     G   CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);
 *   DROP INDEX public.upload_files_ext_index;
       public            strapi    false    232            �           1259    53421    upload_files_folder_path_index    INDEX     W   CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);
 2   DROP INDEX public.upload_files_folder_path_index;
       public            strapi    false    232            �           1259    53424    upload_files_name_index    INDEX     I   CREATE INDEX upload_files_name_index ON public.files USING btree (name);
 +   DROP INDEX public.upload_files_name_index;
       public            strapi    false    232            �           1259    53425    upload_files_size_index    INDEX     I   CREATE INDEX upload_files_size_index ON public.files USING btree (size);
 +   DROP INDEX public.upload_files_size_index;
       public            strapi    false    232            �           1259    53423    upload_files_updated_at_index    INDEX     U   CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);
 1   DROP INDEX public.upload_files_updated_at_index;
       public            strapi    false    232            �           1259    53442    upload_folders_created_by_id_fk    INDEX     c   CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);
 3   DROP INDEX public.upload_folders_created_by_id_fk;
       public            strapi    false    234            #           1259    53566    upload_folders_parent_links_fk    INDEX     k   CREATE INDEX upload_folders_parent_links_fk ON public.upload_folders_parent_links USING btree (folder_id);
 2   DROP INDEX public.upload_folders_parent_links_fk;
       public            strapi    false    256            $           1259    53567 "   upload_folders_parent_links_inv_fk    INDEX     s   CREATE INDEX upload_folders_parent_links_inv_fk ON public.upload_folders_parent_links USING btree (inv_folder_id);
 6   DROP INDEX public.upload_folders_parent_links_inv_fk;
       public            strapi    false    256            %           1259    53570 (   upload_folders_parent_links_order_inv_fk    INDEX     x   CREATE INDEX upload_folders_parent_links_order_inv_fk ON public.upload_folders_parent_links USING btree (folder_order);
 <   DROP INDEX public.upload_folders_parent_links_order_inv_fk;
       public            strapi    false    256            �           1259    53443    upload_folders_updated_by_id_fk    INDEX     c   CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);
 3   DROP INDEX public.upload_folders_updated_by_id_fk;
       public            strapi    false    234            �           2606    53595 4   admin_permissions admin_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_created_by_id_fk;
       public          strapi    false    218    220    4034            �           2606    53725 <   admin_permissions_role_links admin_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_fk;
       public          strapi    false    4030    218    244            �           2606    53730 @   admin_permissions_role_links admin_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions_role_links
    ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.admin_permissions_role_links DROP CONSTRAINT admin_permissions_role_links_inv_fk;
       public          strapi    false    244    4038    222            �           2606    53600 4   admin_permissions admin_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.admin_permissions DROP CONSTRAINT admin_permissions_updated_by_id_fk;
       public          strapi    false    220    4034    218            �           2606    53615 (   admin_roles admin_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_created_by_id_fk;
       public          strapi    false    220    4034    222            �           2606    53620 (   admin_roles admin_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_roles DROP CONSTRAINT admin_roles_updated_by_id_fk;
       public          strapi    false    4034    222    220            �           2606    53605 (   admin_users admin_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_created_by_id_fk;
       public          strapi    false    220    4034    220            �           2606    53735 2   admin_users_roles_links admin_users_roles_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_fk;
       public          strapi    false    220    246    4034            �           2606    53740 6   admin_users_roles_links admin_users_roles_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users_roles_links
    ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.admin_users_roles_links DROP CONSTRAINT admin_users_roles_links_inv_fk;
       public          strapi    false    246    4038    222            �           2606    53610 (   admin_users admin_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.admin_users DROP CONSTRAINT admin_users_updated_by_id_fk;
       public          strapi    false    220    4034    220            �           2606    53947 "   chapters chapters_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.chapters DROP CONSTRAINT chapters_created_by_id_fk;
       public          strapi    false    270    220    4034            �           2606    53967 <   chapters_localizations_links chapters_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_localizations_links
    ADD CONSTRAINT chapters_localizations_links_fk FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.chapters_localizations_links DROP CONSTRAINT chapters_localizations_links_fk;
       public          strapi    false    274    270    4183            �           2606    53972 @   chapters_localizations_links chapters_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_localizations_links
    ADD CONSTRAINT chapters_localizations_links_inv_fk FOREIGN KEY (inv_chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.chapters_localizations_links DROP CONSTRAINT chapters_localizations_links_inv_fk;
       public          strapi    false    274    270    4183            �           2606    54005 <   chapters_preconditions_links chapters_preconditions_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_preconditions_links
    ADD CONSTRAINT chapters_preconditions_links_fk FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.chapters_preconditions_links DROP CONSTRAINT chapters_preconditions_links_fk;
       public          strapi    false    270    276    4183            �           2606    54010 @   chapters_preconditions_links chapters_preconditions_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_preconditions_links
    ADD CONSTRAINT chapters_preconditions_links_inv_fk FOREIGN KEY (inv_chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.chapters_preconditions_links DROP CONSTRAINT chapters_preconditions_links_inv_fk;
       public          strapi    false    276    270    4183            �           2606    53957 *   chapters_unit_links chapters_unit_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_unit_links
    ADD CONSTRAINT chapters_unit_links_fk FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.chapters_unit_links DROP CONSTRAINT chapters_unit_links_fk;
       public          strapi    false    4183    270    272            �           2606    53962 .   chapters_unit_links chapters_unit_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_unit_links
    ADD CONSTRAINT chapters_unit_links_inv_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.chapters_unit_links DROP CONSTRAINT chapters_unit_links_inv_fk;
       public          strapi    false    4154    262    272            �           2606    54015 0   chapters_unlocks_links chapters_unlocks_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_unlocks_links
    ADD CONSTRAINT chapters_unlocks_links_fk FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.chapters_unlocks_links DROP CONSTRAINT chapters_unlocks_links_fk;
       public          strapi    false    270    278    4183            �           2606    54020 4   chapters_unlocks_links chapters_unlocks_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters_unlocks_links
    ADD CONSTRAINT chapters_unlocks_links_inv_fk FOREIGN KEY (inv_chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.chapters_unlocks_links DROP CONSTRAINT chapters_unlocks_links_inv_fk;
       public          strapi    false    270    278    4183            �           2606    53952 "   chapters chapters_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.chapters DROP CONSTRAINT chapters_updated_by_id_fk;
       public          strapi    false    270    4034    220            �           2606    53665    files files_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fk;
       public          strapi    false    4034    232    220            �           2606    53770 (   files_folder_links files_folder_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_fk;
       public          strapi    false    254    232    4058            �           2606    53775 ,   files_folder_links files_folder_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_folder_links
    ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_folder_links DROP CONSTRAINT files_folder_links_inv_fk;
       public          strapi    false    4072    254    234            �           2606    53765 ,   files_related_morphs files_related_morphs_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files_related_morphs
    ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.files_related_morphs DROP CONSTRAINT files_related_morphs_fk;
       public          strapi    false    232    252    4058            �           2606    53670    files files_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.files DROP CONSTRAINT files_updated_by_id_fk;
       public          strapi    false    232    220    4034            �           2606    53715 (   i18n_locale i18n_locale_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_created_by_id_fk;
       public          strapi    false    4034    220    242            �           2606    53720 (   i18n_locale i18n_locale_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.i18n_locale DROP CONSTRAINT i18n_locale_updated_by_id_fk;
       public          strapi    false    4034    220    242            �           2606    54074 .   lessons_chapter_links lessons_chapter_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_chapter_links
    ADD CONSTRAINT lessons_chapter_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.lessons_chapter_links DROP CONSTRAINT lessons_chapter_links_fk;
       public          strapi    false    4219    280    282            �           2606    54079 2   lessons_chapter_links lessons_chapter_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_chapter_links
    ADD CONSTRAINT lessons_chapter_links_inv_fk FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.lessons_chapter_links DROP CONSTRAINT lessons_chapter_links_inv_fk;
       public          strapi    false    4183    282    270            �           2606    54064     lessons lessons_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_created_by_id_fk;
       public          strapi    false    280    4034    220            �           2606    54084 :   lessons_localizations_links lessons_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_fk;
       public          strapi    false    284    280    4219            �           2606    54089 >   lessons_localizations_links lessons_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons_localizations_links
    ADD CONSTRAINT lessons_localizations_links_inv_fk FOREIGN KEY (inv_lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.lessons_localizations_links DROP CONSTRAINT lessons_localizations_links_inv_fk;
       public          strapi    false    284    280    4219            �           2606    54069     lessons lessons_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.lessons DROP CONSTRAINT lessons_updated_by_id_fk;
       public          strapi    false    4034    280    220            �           2606    54119 $   sentences sentences_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_created_by_id_fk;
       public          strapi    false    4034    286    220            �           2606    54164 (   sentences_components sentences_entity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_components
    ADD CONSTRAINT sentences_entity_fk FOREIGN KEY (entity_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.sentences_components DROP CONSTRAINT sentences_entity_fk;
       public          strapi    false    292    4239    286            �           2606    54129 >   sentences_localizations_links sentences_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_fk FOREIGN KEY (sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_fk;
       public          strapi    false    286    288    4239            �           2606    54134 B   sentences_localizations_links sentences_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences_localizations_links
    ADD CONSTRAINT sentences_localizations_links_inv_fk FOREIGN KEY (inv_sentence_id) REFERENCES public.sentences(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.sentences_localizations_links DROP CONSTRAINT sentences_localizations_links_inv_fk;
       public          strapi    false    286    4239    288            �           2606    54124 $   sentences sentences_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentences
    ADD CONSTRAINT sentences_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.sentences DROP CONSTRAINT sentences_updated_by_id_fk;
       public          strapi    false    4034    220    286            �           2606    53635 J   strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_created_by_id_fk;
       public          strapi    false    226    4034    220            �           2606    53745 T   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;
 ~   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_fk;
       public          strapi    false    248    4046    226            �           2606    53750 X   strapi_api_token_permissions_token_links strapi_api_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links
    ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_api_token_permissions_token_links DROP CONSTRAINT strapi_api_token_permissions_token_links_inv_fk;
       public          strapi    false    4042    248    224            �           2606    53640 J   strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 t   ALTER TABLE ONLY public.strapi_api_token_permissions DROP CONSTRAINT strapi_api_token_permissions_updated_by_id_fk;
       public          strapi    false    226    4034    220            �           2606    53625 4   strapi_api_tokens strapi_api_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_created_by_id_fk;
       public          strapi    false    220    224    4034            �           2606    53630 4   strapi_api_tokens strapi_api_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.strapi_api_tokens DROP CONSTRAINT strapi_api_tokens_updated_by_id_fk;
       public          strapi    false    220    224    4034            �           2606    53655 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk;
       public          strapi    false    230    220    4034            �           2606    53755 ^   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_fk    FK CONSTRAINT        ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_fk;
       public          strapi    false    250    4054    230            �           2606    53760 b   strapi_transfer_token_permissions_token_links strapi_transfer_token_permissions_token_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links
    ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_links DROP CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk;
       public          strapi    false    4050    228    250            �           2606    53660 T   strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 ~   ALTER TABLE ONLY public.strapi_transfer_token_permissions DROP CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk;
       public          strapi    false    230    4034    220            �           2606    53645 >   strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_created_by_id_fk;
       public          strapi    false    4034    228    220            �           2606    53650 >   strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 h   ALTER TABLE ONLY public.strapi_transfer_tokens DROP CONSTRAINT strapi_transfer_tokens_updated_by_id_fk;
       public          strapi    false    220    228    4034            �           2606    53840    units units_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_created_by_id_fk;
       public          strapi    false    220    262    4034            �           2606    53850 6   units_localizations_links units_localizations_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_fk;
       public          strapi    false    262    4154    264            �           2606    53855 :   units_localizations_links units_localizations_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_localizations_links
    ADD CONSTRAINT units_localizations_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.units_localizations_links DROP CONSTRAINT units_localizations_links_inv_fk;
       public          strapi    false    262    264    4154            �           2606    53888 6   units_preconditions_links units_preconditions_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_preconditions_links
    ADD CONSTRAINT units_preconditions_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.units_preconditions_links DROP CONSTRAINT units_preconditions_links_fk;
       public          strapi    false    4154    266    262            �           2606    53893 :   units_preconditions_links units_preconditions_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_preconditions_links
    ADD CONSTRAINT units_preconditions_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.units_preconditions_links DROP CONSTRAINT units_preconditions_links_inv_fk;
       public          strapi    false    266    4154    262            �           2606    53898 *   units_unlocks_links units_unlocks_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_unlocks_links
    ADD CONSTRAINT units_unlocks_links_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.units_unlocks_links DROP CONSTRAINT units_unlocks_links_fk;
       public          strapi    false    262    268    4154            �           2606    53903 .   units_unlocks_links units_unlocks_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units_unlocks_links
    ADD CONSTRAINT units_unlocks_links_inv_fk FOREIGN KEY (inv_unit_id) REFERENCES public.units(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.units_unlocks_links DROP CONSTRAINT units_unlocks_links_inv_fk;
       public          strapi    false    4154    262    268            �           2606    53845    units units_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.units DROP CONSTRAINT units_updated_by_id_fk;
       public          strapi    false    220    4034    262            �           2606    53685 .   up_permissions up_permissions_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_created_by_id_fk;
       public          strapi    false    4034    236    220            �           2606    53790 6   up_permissions_role_links up_permissions_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_fk;
       public          strapi    false    258    4076    236            �           2606    53795 :   up_permissions_role_links up_permissions_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions_role_links
    ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.up_permissions_role_links DROP CONSTRAINT up_permissions_role_links_inv_fk;
       public          strapi    false    258    4080    238            �           2606    53690 .   up_permissions up_permissions_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.up_permissions DROP CONSTRAINT up_permissions_updated_by_id_fk;
       public          strapi    false    4034    220    236            �           2606    53695 "   up_roles up_roles_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_created_by_id_fk;
       public          strapi    false    220    238    4034            �           2606    53700 "   up_roles up_roles_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_roles DROP CONSTRAINT up_roles_updated_by_id_fk;
       public          strapi    false    220    4034    238            �           2606    53705 "   up_users up_users_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_created_by_id_fk;
       public          strapi    false    220    4034    240            �           2606    53800 *   up_users_role_links up_users_role_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_fk;
       public          strapi    false    4084    260    240            �           2606    53805 .   up_users_role_links up_users_role_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users_role_links
    ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.up_users_role_links DROP CONSTRAINT up_users_role_links_inv_fk;
       public          strapi    false    4080    260    238            �           2606    53710 "   up_users up_users_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.up_users DROP CONSTRAINT up_users_updated_by_id_fk;
       public          strapi    false    4034    220    240            �           2606    53675 .   upload_folders upload_folders_created_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_created_by_id_fk;
       public          strapi    false    4034    220    234            �           2606    53780 :   upload_folders_parent_links upload_folders_parent_links_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_fk;
       public          strapi    false    234    256    4072            �           2606    53785 >   upload_folders_parent_links upload_folders_parent_links_inv_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders_parent_links
    ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;
 h   ALTER TABLE ONLY public.upload_folders_parent_links DROP CONSTRAINT upload_folders_parent_links_inv_fk;
       public          strapi    false    256    234    4072            �           2606    53680 .   upload_folders upload_folders_updated_by_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.upload_folders DROP CONSTRAINT upload_folders_updated_by_id_fk;
       public          strapi    false    4034    234    220               O  x��ZM��8={~E��
}��#R{�[��b@�����I*��}%�m�eD\��\lx���V��&t��OU���u���3y������{���ӊ%Ln�a�M�"�rJA�����v�[�����Йͷʼ�*��q����7CO
k�`ft�=����<=#T� �d@�l_w?+�9f�ǽ�
������U�<�!��^#��@�ܹ�V����[�R*UA�Kew�)F2�+8�+�{�'	ǂ�q/@��m�7N�B�q��m5N�΂8hL~�^�DfXQ�8�\rކ~0Ͱ��M�d:b�[��^\Bu^Oo�~�7ݮ���m��-����\�����w�i�Y��nmvyU��}�~�J���9/mW���X������4=n�n�V�4��=�m��/��6�OAWh��8�B̻┉�#�	vx!�qI�?�,Ê���j���M�+��qXH\H_5O��?��_V�Q�t�,(\�um
�_�v�z���ݾm,�Z����aFX��b����k%ag���P��:pS�Ql{yd.��1���g'�5�m<�3$�X�ع�q ��W�$����8(��.J��^��pg��E7��A�ކQ���� 2�e�""����ĤS\�UQWp8(����Ƚ�H�����dV+ª�L��Dg���sJ(��-6�u9�nj��r8h�Z�=ҋ�c���AMD�Ez2E[A�����w�ԛ����U��1C�}���Z�eiF����A5������0�fI�g�)�V��j�H5�Z��9 z�0�b�ļ6qU%#��V9�	��@��q��&	��{��U/4���?_���.��`�q�M�����@.N�/��K�>G�H�5	n9�Zu�5���0G�S3�����N�cB)ۺ�``�N��̍r��=�b������m[ ��`2��q�%Pبp �c�H�fخ �ى8���$H��0��1m�)aX� hŘ6ʿ�p��p �c�(�R"�+�����fp{����Y�T ep`O��j�<t��I�?� ��
'#X0
#�]��iL�.�/�(D�7����QW�3�v�_M1,kL����Ԉ���#��p�ԡ˛���Ȓ���X��8HȐDT��7n?�Q*$�&t�8�!��Xs�b�/� ��m�L
N������De� T`����*���E��=-�j �c�s�{L?6�tN��$����_ð���y�1Yǫ�P�q:�[>�]��誽r�۶;�;c�����w��qc��e�%��)X�71F��P��A^�M���o�Ȕ$�Y�#ټ��T|�f
4�3��,��wdu��������/�Rh��_q���\���Ccc�nYF$�T�36//~%�,��_dD:>tG8~E��7672���	���2MƯ^�` ]\��x�2<d�ُ^^�k�xB%�8��`_�6��'�Q������
CNq�t�������ఢ�[���P���cޛ������{2��m~(�����'����
7�����]Zs߬��N"{��|Qp���m�+m:kĽ�������o      �   �  x��ɍ�0C�d1[�{���1b�X|Z��å������@l&rs�P�������K>���{��[q/6|k�
��V�-�غPl�M(T[P���P�@���v�q1�X5<�6mR>����4ۼ(�hۿ0�i;�87h�&m`"ݢ=�P��;�Xw�ۣ`��w���wj����ʹ�K�h��fAߝ�fIߵ�fE�͉f�8�l���1� ��a�fE���ӈ��Hķ½W!D�`4B4O� D�b<�h�̃͇���s�,Z�^O���@��\/��,�w�5H#E�dR�(�C��:(�bX{O���L��a�CD��
�hi�D���Z��j�g�u�D�b=�h�lGK�.{П��s0ꡒc��9����1ҭ�Yk���a>�]��'�^˯�4E;��I����$���x��7x�÷���f���峲��G�JX}�      �   �   x�u��n� @g���b��j6Y�d�r�K������!E�Z�����{ЪsZ(�h��+������j�F��z@c��[����3\	%E*�I��7J��G��׺�v8�ák�v?l��)�J��u��Ce*�T��l[���x���͜l ��+��+S܈�z��KT�Ɣ����2�'*�֘��	>2�������?�p�_���^Xc~3      �   �   x�3�LL�������Ҽ���ļt��������\N�DC�p��D�� �JSǊD����}�T�B'�B�dϊ�J�w���B��L�� �
K=��%�i ����T��L��X��������H����8X3W� (�,      �      x�3�4�@�=... �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   <   x�3�t�K��,�P�H���L��4202�50�52V04�21�26г04�)�D\1z\\\ ��S      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      {      x��]�n�F���<�F��Y�N��tz�Lv;����n��E�h�$1�H���v��z�$[��)�(���]���fU�:Uu�w�����ɲX��r�Ve��v�H�d�j��4����+���/Qsy�d���?��Y[ݠ���*�Ɨc;a|:nP���_�1�^7�u�Ɨm�B��i^��֟4(�ӹ�d��y�����xt:^$y����2Y \A��ɪh�Tu��=��e���<{��x�e�6ɒ6�*���,o�O�X��m\$ר�ep:�U�Ū�׸ �V���:MZ�Kқ�!~�,�ͫ�����M��@�h5��q�!���*��Chj�Q���)}>��\p�nI�����C
��!�ԥ��Z$M��Aٳ�UKBYC|��KT/��4��z����H��T��R�Ӥh�f����2�Qw�J��u�A�OQ�L@T�i���gZ���ٱJ�)�����Ct]-3��*q]u�=��;�T��6�릥����߅�o3��x�6��nnE��j�R�c��3���Nyc߿���I	(]z�>�	V��W����NQ#� M�w�[ 
00�)�M�r}u�^�T׿��=������]Xl['e3E5Le���g#�݆�F�9c䌑3F�9��U�3q���i7;ԋ����3�~�?T��P��y�q�!�pn�+��`�K���URc+�]�'�pZ��1�fE-R\$���D��
;A�#�}��!T5ću*�p,����!�5ć�[W8	���Lh}q��)W�\�ry(��M>��@\K�ٔ.)xl��`"U2B�M,�r��R��^�����
��֑-�,
m���҃�(�8�TR1Hu)�-��┚�Kw��'�z�` Yh�}�{쾤U�F�3q�>ڝ�U�Y�`	{���@��Y��Xv^"�t������C �������}�h|��`e./WˢJ��)(I9��H>��|,�v�SF�2�J��a�-֐�hN,kB�y^d5<��iR\�/,�c߃7 X���'lR>+̆�
I�D�m�D�9���C*V��:�����(� >$����"=���؎�zo�A�S\��K�1 ŀ���C.��m�0A��vD �5.�{�T���DWl߁@�z�ߧ�L�=�-���iC�	�a�, %Y� ���䰵����j��	Of�)���Y#��x��>��$����5c�E1��h��i�F�Մ�!o��rz�L�d4�A}]y�X�K�/]Uz�@oIC���v��iʞ'�l�c1�v�a��:���C�<�Ƀg�sA�nIF� ���c%�kT:Wr_�4���؁SP����D\��s�R�&޹���m3��NmI�97�8ugt
7?ړE�|���rx谧�$��|x+r�ȉ>IN��ߧ��B�X�KG.�LG�m��̃R����k/�/�PC���Ssg�z[o�[��ݍ�Gc��;۠����1�t�����OUW�9�	�U�������vtj��E����iTӣ�J�)=D��?9o休�?����
� �;�v�������kԇm�KQػc�1c&�^�![�'l�X�`�Č9�E?�T�Eq�����e�cb΋�\��'V��9�3�=��d�d�t@���GB�-�����'�:)[,Vɒ�A&4�Sj���EE�����M*���̭��9N�7��159�c�~O���N�2%Z��Ι΋|.�p��TH�w\>��wE�aG����5D���UR�>ꈢ�>J�YU�xԂU�z��Jl�7o��zY�>��`�|H~\*yZWM5m;Ը�ˬ�k��!�zU9�ƞQڻ�m��V@�� /��'��ʦM��,:�RyzT&y[;�3��m�m�������v�m�~H��6����t�m�%X�����:�,=�e@=�I��H�9F�	�'�2��U+�fe�VZ%~�oV�YE�6�sq.�<O��G_^_�p���%�κ��(��ã'��S+I �X��n�$�5��������<�D����#�K凜-yt�!��qai*��qw�2��m��.����=\����Tի�ˍ��g�fta`�/�����-Q�G��E�w�έ��i�}�R�n��i]Q��$�y;A��JJT�!�S��F����H�e~�W�$ih"��*����D�����<=)9�f��?�h�ys6j�I;��xTT���e�Go���%ט:ӌ���巿�R�X�w�iV������;��/��łҤ����hZE���lDpj�V#�Cf=�\*��_�>z������'������/��~b��v��7�9y6�K�}��s���r��9J5�u�1{��ժlG�b��і��V���F5�bsp�H̓[D���c�N��p>zU�VZ������+<Ѫ�����(�(}�����<�#��%�mR�(#K�e��J��������%��<�&�~\��*�3fy���*�ŗ�'l]��,)��83������u����B7��lbي
z2z�dt�t��cv$�4�;:�����z���_<yrq�]�vw�����iy�g�	p�OKǳ~�p��o8��q��\?4���1������<ZE`y"��ņ�'�d`�q�q�'�;�C���ܮs5�^�~�kb��i�Q�W��+g��ѪH��!3:�88N
=��X������֧<V�T�7��GA��4��E�.9�^�Ef$3�����eop�sV���8�gy��3ru�_>&�W7���"�� }
������A�M����T�<�NJ��2����~�v���J�e�r�5*����YjR޿�^����-�P�)�I=��P��W;����9�#� ��w*Z�H�i+�W2�����:q�����iY�r�Ć�cU�y���Q�`o�A�	���$\�p� �u)2��d�x˪�ƽ��@����b:-x���*f�"?��uR�+٪��3:���\�`�<�]�ڲ|������}ß��C;�q���lE��V����1�|������&0'��5����R�/fXQR_�u�ˮ}��������s`uAҁ;"�%\���˼�0�$��݃m���f!D� ���_7����y����b��yxm?M�.B(�蠡�<�x��4g�����<�2T*'�|�ȳ3��!6��bc��!64��>�Rag�Kl��J����~�w�X���s��}>���˱������x�hl"Y�j���ۿd놐 �]k7Hl����{�,�ܷŘ��i�\�ѿb���z�j��B��ǣ�4�Q��G�Sɗ6Se�ݔ@X��\�9/#��� w|��G��D��l�e�댺8������ mv��D��N7u��]�Z�Z:��0GIvV����(Β4%'�q�����DP�T�J$�E"�~F�{�Dh�D�ݘ�z�{�V��.8�>����f�׮N�?,�f���5�D7��;R�f~>���L�x�ܞiE�� >�#fwC������ba 0ٳ�!m��>7���O�F�NyLFɳ�SE���"m�q��1��"�9*5��c�O�>���u�����F�x���a���^6��g�Qz�*˺�T׮�����\��L��3�3��<��ܙgD��0a��`vw��8f郼���	�1��F�S:������:gB~}�th��e����{����;��P�)d������ȯ�;y��i����,��7�f,����:qv�$;�:r�O��s�o��%\��V��<�u�g�\����p�9�g�G�iE�z
{I��O����֫��.CĮQ���")����b���5"w����6?��m�L�D\:�;��<�Z�˹���̩0��%۸�DY .��-,���͓`$	>�9�����G�51�} �]D��1av0YbC�мT�b� 1��XK&6XC��v�%D�<>|���ĩ�0i��=�Tj�4��C�I (	I��$C:$� �Y�jk�yH�!��D�)��g�&;'���P�k���d�}F��Z�Qp@ �	  ]���E��.�Y�r%��c������@�4_,J�X��<��f�|T�D�wn�N�6�Y�r��K=̄�Z��D���4N�J�� �>� �ʓI�]C,
��=����aa��ht/��9�F�����t�/�w��}���qE�l��l�C���;��3`��ݎm��7F�Qs�����?�=��V��_(v>+��de�g��(�M{���}0w�{;���C_�Z�VWh�\n�wx��3�n�s�ɀ��ׁ�S���:�Pz<j�J#�D�y(��;c�h#�ٖ%�.����z�]u���ݿ�N���2{��.r�'�a0o�d�l�ޤ�]7��>��]Z{�}���zW���7��r��C	�����7�p�#\)��cWS�涷��Nc���d_��#@� 3��[C.��H������O���lS�o��Þ���N%�p�\�:��A�#�p��E�a|��#/Q��;2]�$�x���w��wv�g9^A m~Z\�2y�-��̮��OO_�&���//q^��>�?I�ѩ���8y"�Zv�4�O�ߓ��.�?io��L[j��>"L��\xK!+�ud�;��L)w)q'����Rĩ�5��-O�P�#�ϩ��ʰQ
}2��r�6��m*V�ذf�_���l��p���-��I8g?��Q�D��G�&w�Dڶk����Vܪ�4 �d�~hߊ	Zo\���%�\Hpٝ��t_y �~���x��*c*�{ͮBJ�SvNv-���>|X���d��4Y��+�����6���k7������m��GŶL�9��+�2�]����l�6�Pa\>Ң�s�msoQ/E��^�\��)��	���Z��9��K��*�Kt�N4i���;Ib�K�\��	KVY^i��@Y�3��/�=a� )��eİ�;TRC���Ud�s��Z,q<)[
IK�� ѣ��$��lcm�+Ǧ�Q�L���D���ia���L3�����z��i5��F˺���e�>��pz��g�Z�ELg�9���L��b����j��Vj����]��V������g�ɧ�@K������<*r���H]������`�7f3!ԛ�� ���Y:������v����ǏOҪF���ٷ�?��zv����^�����8�p-�[r��P�:M�� M�)eW�ڵ}qv�;e�'N$��e*��~qN����kԶ�I��׫�FG�iNn�ԟ���9�bU��� /��Kӑe��Tu˾#�>��s��������A��x<]j��44��5*�wfcH��USoh�eI	J!���)�����1XD�V�������Q[;�|���,(�Uԓ��Ԕ���{[U�0��Br�zN��43�.�@�Z��^���(��)�"�PP����=[w�`�A��*�^�&9���^���6Z�.>��)�c&2q]u�!��GO�~w�]MØ�u�җ��M����pT�A۠W��D@r_����L�{�eXuC��)o�{u}��Ni��*Ly�թ*d����{��Q��Q��T@�:��+�~�=/����]9b䈑#�#���SAkE��<4jFN{�V;Bm����;�ꪾHh#�����Z�B>�k���*�!���~�=�5�l�4�>�I\턳gM��K2����G.��'�4�!nޏh���l����O���A=3,C��bh>��l�׵�ԓ�PՔ��q(�VW%��.=h��SǎhɃ��!����d�Gc�>�ʢ��5q��v���P�Y\��'�� �cB���~��
 2��)o�!P��0�L-l\<�h�ס4��aA8�x�B�&��ŠL)�A<�~�W�ԉ�
�w6����c���{�Jl���m����gd<4Ñ�5�&_,4Y&M��7� �[�Z�����
�!?h�g���6O�{c�F��e��:�ɴn��n�A� UD|�y�-Q�`G�A4��OpE!mIV�"O��	��V�!�w��tU��j��JqX��>��V!��#>�H�`�P8� �ݰq��.�k�4�cw�Dw��sOV�j�isT�x�՚��X �/�(i7��}|��(�+�K��o�₃`�ts����,��Y.�� �J��0"i�J�����V��"KBA!9D�9�gsp�y�
J�!N+��	04��!tT��fR���>����.�x�P�����F�|ո���n��0s��Cu[��xU�h��NLnst��OKh"�ći�>����ӆ�T
��D�.�U�!5�k	�iUx�����0�o�U�|H�W	µ�aB�&>����q��3��3w!�:4��$g:�F�I��8$΀*�$j�SN�����9����=���tL�EP蔪`���:����Sa���	�ޓ5����g����.      y   �  x��K��6����H�ff��dn)'��M��i�łHH��"�$8;����K|  �iK��lψ@7���C�7���(�F8����#���f(%~�d��i�/������x$�K����۱�d�n>��8�i$d����92|�1-%�l_'L3rD�g�f޴�2��'_���P����Q�����~(���+✕���E9��9቉:��ՎU��?+��&���w
(~��x/J�}��rE������dI\v������)h�����\�����,Z�h�8�;U�$�Z5��o��eEl�$�(�k�(<��Oqv$yN�xh��d>�NDq�o?�$�wO^ߢ��SO��/�P"i�I�%[e�x������׈,�ڔ���:)u�$�G��y�������?<{��_��?(��} 	Tk�S���),$�b��~-�fW�`�zI��LI3Q���a@I�N6�l�����4�)ǔ�x?o~���yߴC2��$�{�-i�j�Nk�h���WBS%X�\jv݊A���AE�ȕ�H�S�x6B�:ʞ�ց��D�~
���$!ud8��o5�4y �D�����U�6��e��ܳkS�N�6J�'�iG?f����ڃZ�+.?�ȒKÊ*�°��a7�0(|XaP�+
+�=q����C�I��������ew���{�$3F�T�-/,#$�V�A�ܠ	�ֆ� ��4YΉK����/)a3�o[���p����l���ˉ���5���;YkNd�^��t�nqO�K�/�9^ٿqΆ���c�v)���,CoQiW�ݢ�_�.d:�n�����I�9�8�]�	9{�U��}��G�y��#0wD�\\�Q��X+S��$
��L=�U�� �=.�P]�@�Z��uV�׳9%i�y���GIZ�ON�VIBN�p%���I�/ܪ4G����뗆����ҿT�|�E�ܵW���s.p�
�O?��Q�&��lH(�
6n������n 6�#��+�b�Q�)����Y�2؍�~&���&y&ae��:�#��982����]�n���beK3|��	�C^\�<�bK������P�p*0���1XGblE�KJ�.���e-�ݨ
dl��sK����a�yq��t�v���^I;�-��S�t	��_2+0����+ؔ�G�q��9+���}���vo�0+0gݽ�]���/�J� �w�\eZ�J�F�uk\	��%{]r��̊P���������e�r�������"'퀡oip<�d���,d�z���������-v��S`ӓ [$5+$FͪxE��F�ہJ��-ӎ���^���f��M K��7\�o� k�d���g{��|�J*p>Mb���0u=m~[�Ǩ<��Ǩ���8�㼂�
`^!g㼤��ph����I��Þfe=�iVIGw{ $1�Y���٢�de�0�?@�|��|�|��|�J�1�����W��-��t%^�r�ϸY�{{�|��� 9�I\��G>E���#�3���(�/�4�3ζ�Q�sm�����y`�R���,E%Ia}HZ�O���F$S���ϙ�"B��P�B"�l�2=�	L,��+��__Yn:�#?	^��rLµ.�8���!��DT�XG/�g�	�u�*��ny{�� D�>�U�����^$��׿������ �*����Fx��nQ>6,���m[@��Bʤ�Fx�*�W��]f�3I<�%���b?�k��y�i�� f*�f�l-QT��*YRMmn4���
�4��z ԙ�9�g��3j*x�I�կ?��N5���y9w����.��T6E�ތ�IX��_�En)�9i��4�5�r�Z����>;ꊭ��_EϪ1��Mª�T11ha6�����(�"�<�J��᩟��bqĈJ�� =k�.��Jصk?6jqv��s(DN�=e�B��~7�Q��rL�� `//��n�Dc�q3���Q7�s�Я3�d�ig��j�9��ۻ�j�����v}���k8vG�'��"@s�$������l<��$��̋�:�퉑<�⨦>��4�E�,ih�bL�5uhB�kZH%�=��
�e�����]&�g��gڒ���u�H�Υ�=-�Բ�bؠ��Z]q�������y�6.�k�Z�P]FK��_A���f���Z�R�F�Pg�6�6(,�aO�/�Jx�4h2ɻ|CO��}Zͣ?(�6h�����2v����]��L��pz��N#�����|�c��<(�To:A.���Њ�G�n;i���Dr:h7�.�ceg�����ݦIU�q@�l�8$�>n%Rprh#�'C4�6�5˒�`���7@���%l�4`��U��2�w��r���lyƯѪ�UyM�5iB�~nSR��0r��<1���+�q�=�X�X����:�L� �8��C��<�t��a$O�)Ц۪��3�"�9�9)zN�L6%��&�X`�j�~^��$%<�t�x�P�L��y�h7��x�nD�sĬ��}�ѰZ��6�IM��B}IsDIU��z�������a�X-�uCfز����M������RV;�y� ��3����1�B?OL��x|諻s�C�.Ϧ������1iB#1Bt��{Ψw!�Y��~��î\A�;��F�e2���b�xO3i�kK{�6Sٲ#�R]� �$[���y�Zƕ�κ��
4�YI��vAw"V��*�)&W�D$�-2h=)�]��M y���B�|�T2�Kcsb�UV����wY��k����~�B�Zc-P�������S[.V�o�p*+�R���kQM��y��k�d�dߚdʳIar��LJ���$��lQOZM)�Np�r�j��뫻���?���x���n�><�������W�>����ở���mpܾy`���0]�o^���ׯ_���c      w      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      }      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x���M�0��p
/@-?�[��x 6��-�x}1n�&h2������ˢy\�6B,�ܤ�5H�	� �)-��L(;e��+�R�8�̛�zq�C��Hk�������?x���)�o�i]w�R�,0I=��鵛�_�<$r�4zp�<�G0��Oe�p�__C���Q�k	��Z�8�e�8آ!q� g���      �   5   x���  ����$����ׁX�1����N�?-��n�M�-���&�cm	)      �   y   x�3�t,-�H�+�LN,IM�tIMK,�)Q(��IUH�,K�S(�WHDV�PZ�Z�ǉ"�id`d�k`�kd�`hnebnel�g`i�S<����8J�r2�qX[�����l&������� TEm      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     