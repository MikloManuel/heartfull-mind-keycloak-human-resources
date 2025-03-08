--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO heartfullmind;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO heartfullmind;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO heartfullmind;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO heartfullmind;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO heartfullmind;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO heartfullmind;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO heartfullmind;

--
-- Name: client; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO heartfullmind;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO heartfullmind;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO heartfullmind;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO heartfullmind;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO heartfullmind;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO heartfullmind;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO heartfullmind;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO heartfullmind;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO heartfullmind;

--
-- Name: component; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO heartfullmind;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO heartfullmind;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO heartfullmind;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO heartfullmind;

--
-- Name: databasechangelog_custom_jpa; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.databasechangelog_custom_jpa (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog_custom_jpa OWNER TO heartfullmind;

--
-- Name: databasechangelog_example_en; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.databasechangelog_example_en (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog_example_en OWNER TO heartfullmind;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO heartfullmind;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO heartfullmind;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO heartfullmind;

--
-- Name: example_company; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.example_company (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.example_company OWNER TO heartfullmind;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO heartfullmind;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO heartfullmind;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO heartfullmind;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO heartfullmind;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO heartfullmind;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO heartfullmind;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO heartfullmind;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO heartfullmind;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO heartfullmind;

--
-- Name: friends_requests; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.friends_requests (
    id uuid NOT NULL,
    user_id character varying(36) NOT NULL,
    related_user_id character varying(36) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.friends_requests OWNER TO heartfullmind;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO heartfullmind;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO heartfullmind;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO heartfullmind;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO heartfullmind;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO heartfullmind;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO heartfullmind;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.jgroups_ping (
    ip character varying(200),
    name character varying(200) NOT NULL,
    address character varying(200) NOT NULL,
    cluster_name character varying(200) NOT NULL,
    ping_data boolean,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO heartfullmind;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO heartfullmind;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO heartfullmind;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO heartfullmind;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO heartfullmind;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO heartfullmind;

--
-- Name: org; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO heartfullmind;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO heartfullmind;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO heartfullmind;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO heartfullmind;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO heartfullmind;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO heartfullmind;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO heartfullmind;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO heartfullmind;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO heartfullmind;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO heartfullmind;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO heartfullmind;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO heartfullmind;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO heartfullmind;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO heartfullmind;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO heartfullmind;

--
-- Name: relationships; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.relationships (
    id uuid NOT NULL,
    user_id character varying(36) NOT NULL,
    related_user_id character varying(36) NOT NULL,
    relationship_type character varying(255) NOT NULL,
    relationship_status character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.relationships OWNER TO heartfullmind;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO heartfullmind;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO heartfullmind;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO heartfullmind;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO heartfullmind;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO heartfullmind;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO heartfullmind;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO heartfullmind;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO heartfullmind;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO heartfullmind;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO heartfullmind;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO heartfullmind;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO heartfullmind;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO heartfullmind;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO heartfullmind;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO heartfullmind;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO heartfullmind;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO heartfullmind;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO heartfullmind;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO heartfullmind;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO heartfullmind;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO heartfullmind;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO heartfullmind;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO heartfullmind;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO heartfullmind;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO heartfullmind;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO heartfullmind;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO heartfullmind;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: heartfullmind
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO heartfullmind;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
8ba195db-2f2b-4cea-afb0-36e2ef67db14	6ed573fe-3ec2-4958-81c3-c83e0d5c8982
9dd168b9-7f0b-4d45-99af-6f62e3a6c68b	1d9e61b7-2874-4a7c-b7d6-f72e571cec9e
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
4d157d5a-38d9-4540-93d4-41ac09ae9239	\N	auth-cookie	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	582602f7-7c64-487d-8be4-3a05eb876d48	2	10	f	\N	\N
ea9bb8e2-518f-4db8-be15-db4bd8bd53fc	\N	auth-spnego	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	582602f7-7c64-487d-8be4-3a05eb876d48	3	20	f	\N	\N
6289833d-a3e3-4cab-a666-5e7fbaafe133	\N	identity-provider-redirector	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	582602f7-7c64-487d-8be4-3a05eb876d48	2	25	f	\N	\N
15b91f3a-f7b3-4899-b441-8ef214f00dce	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	582602f7-7c64-487d-8be4-3a05eb876d48	2	30	t	e3c91a86-e26d-4b9a-aaa2-4a599fe6da6e	\N
d4f03cd3-4d23-414b-9f2b-ab49ba102367	\N	auth-username-password-form	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	e3c91a86-e26d-4b9a-aaa2-4a599fe6da6e	0	10	f	\N	\N
0f632bf3-c4e5-4aaf-bff5-22dd128ba769	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	e3c91a86-e26d-4b9a-aaa2-4a599fe6da6e	1	20	t	e9c63712-1d45-4f72-80ac-0658ff901537	\N
5929c658-98a4-4102-ae41-ae4dad868bdc	\N	conditional-user-configured	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	e9c63712-1d45-4f72-80ac-0658ff901537	0	10	f	\N	\N
74bea1eb-c48b-41a5-b0b2-c2a40c309846	\N	auth-otp-form	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	e9c63712-1d45-4f72-80ac-0658ff901537	0	20	f	\N	\N
decd1f0c-e791-4ae9-8f7d-65686cbcd293	\N	direct-grant-validate-username	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	cb05c7bc-3b8d-4e34-aaa6-2f8e1679aca3	0	10	f	\N	\N
1dd78fff-fb7c-413e-84e3-974d609bbf8d	\N	direct-grant-validate-password	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	cb05c7bc-3b8d-4e34-aaa6-2f8e1679aca3	0	20	f	\N	\N
3986c3e7-1525-41a1-be9f-2053ef398406	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	cb05c7bc-3b8d-4e34-aaa6-2f8e1679aca3	1	30	t	fdebbcef-5016-4a58-9290-abd98ea56cbe	\N
79291d8c-bd6e-46dc-9281-0111a56e8317	\N	conditional-user-configured	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	fdebbcef-5016-4a58-9290-abd98ea56cbe	0	10	f	\N	\N
abd46f37-4174-4e78-9ea2-1a55ae464f69	\N	direct-grant-validate-otp	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	fdebbcef-5016-4a58-9290-abd98ea56cbe	0	20	f	\N	\N
b1036034-70ea-43d1-9d9e-aabe57e87bc8	\N	registration-page-form	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	4769f0a4-49ba-420d-881a-fe69002f2a5b	0	10	t	dfb19ac5-a5a5-4915-a238-fbd5878d8a1a	\N
69a7c174-9167-4d7b-a51e-dd674a1ea9ce	\N	registration-user-creation	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	dfb19ac5-a5a5-4915-a238-fbd5878d8a1a	0	20	f	\N	\N
2bd77900-6853-4b99-91df-f45ab0865a04	\N	registration-password-action	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	dfb19ac5-a5a5-4915-a238-fbd5878d8a1a	0	50	f	\N	\N
45d9456d-8804-4cf1-a713-0df104ab6c53	\N	registration-recaptcha-action	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	dfb19ac5-a5a5-4915-a238-fbd5878d8a1a	3	60	f	\N	\N
d6db24e8-027b-4d92-b78b-a9eadef958c1	\N	registration-terms-and-conditions	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	dfb19ac5-a5a5-4915-a238-fbd5878d8a1a	3	70	f	\N	\N
ff8a626e-fbe9-4ad8-82ca-5f3547a6e256	\N	reset-credentials-choose-user	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ddcb76c2-a6e7-4ce1-b131-c89688b4a1c6	0	10	f	\N	\N
e0bad882-ce76-4797-9f19-669f0072fc38	\N	reset-credential-email	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ddcb76c2-a6e7-4ce1-b131-c89688b4a1c6	0	20	f	\N	\N
39d63a49-c697-4981-bc63-ebfe453c2a07	\N	reset-password	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ddcb76c2-a6e7-4ce1-b131-c89688b4a1c6	0	30	f	\N	\N
34126de2-54f3-48ac-8098-b5c81c5dbabe	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ddcb76c2-a6e7-4ce1-b131-c89688b4a1c6	1	40	t	629a20ac-af4b-488d-9146-9955823f7598	\N
e11e78ab-2e53-4a51-b056-a014df3d6179	\N	conditional-user-configured	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	629a20ac-af4b-488d-9146-9955823f7598	0	10	f	\N	\N
8658fc87-f1d2-4e64-88d8-c3c648d4e9e7	\N	reset-otp	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	629a20ac-af4b-488d-9146-9955823f7598	0	20	f	\N	\N
2b081144-4d1e-40df-ad37-24f8a6385687	\N	client-secret	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5478677e-0214-4975-a140-346576191016	2	10	f	\N	\N
8d4a7bb4-50c7-4f44-bd3e-1da7ea1003d4	\N	client-jwt	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5478677e-0214-4975-a140-346576191016	2	20	f	\N	\N
d6bd608e-99d6-4c7c-898d-a117398f9034	\N	client-secret-jwt	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5478677e-0214-4975-a140-346576191016	2	30	f	\N	\N
ae817cb0-871f-4b82-8a1e-3ca7601db306	\N	client-x509	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5478677e-0214-4975-a140-346576191016	2	40	f	\N	\N
f119d697-e203-4684-a4ee-e987594bb64e	\N	idp-review-profile	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	c65e56ec-02bd-479f-b6d1-f5c94fcf9841	0	10	f	\N	df1d1d3f-1e04-4d85-a4ff-e067d464d517
e4989bdb-b70b-4492-9001-13a08934adf9	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	c65e56ec-02bd-479f-b6d1-f5c94fcf9841	0	20	t	9ba04a88-4ef3-42e2-b06f-72c627c7ae0b	\N
cfe0bf3e-60bb-48c4-8256-0d7dcd0b85ba	\N	idp-create-user-if-unique	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	9ba04a88-4ef3-42e2-b06f-72c627c7ae0b	2	10	f	\N	4f829705-5909-440f-ad82-4a0ca2337cde
89223b2b-0553-4463-9331-3545e0f6801a	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	9ba04a88-4ef3-42e2-b06f-72c627c7ae0b	2	20	t	e57046b3-69a0-44b8-b793-f5799a97fbde	\N
8da0f89f-ba01-4785-b488-e1830b291740	\N	idp-confirm-link	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	e57046b3-69a0-44b8-b793-f5799a97fbde	0	10	f	\N	\N
4cba9cd0-73b3-41d0-a8b8-e67070664b05	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	e57046b3-69a0-44b8-b793-f5799a97fbde	0	20	t	5a7fe78f-88fd-4882-8661-e053a79e81df	\N
46071c77-c095-420b-bf30-116ced9d31cc	\N	idp-email-verification	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5a7fe78f-88fd-4882-8661-e053a79e81df	2	10	f	\N	\N
bdcc40dc-17b0-4b93-b880-b1fd6f75c6e1	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5a7fe78f-88fd-4882-8661-e053a79e81df	2	20	t	31c54f08-c39b-4458-a764-e8961dfa8202	\N
5d961947-d1aa-4fbb-8ff5-8ea047745d76	\N	idp-username-password-form	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	31c54f08-c39b-4458-a764-e8961dfa8202	0	10	f	\N	\N
2a301b59-9366-4821-8655-b793d3ae1e16	\N	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	31c54f08-c39b-4458-a764-e8961dfa8202	1	20	t	6aad27bd-0912-4775-acaa-8fb7ed6259a4	\N
705c537a-83c5-4945-a55f-cbb3b45576f4	\N	conditional-user-configured	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	6aad27bd-0912-4775-acaa-8fb7ed6259a4	0	10	f	\N	\N
79d19710-8ade-44c4-9adc-71670483127c	\N	auth-otp-form	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	6aad27bd-0912-4775-acaa-8fb7ed6259a4	0	20	f	\N	\N
3567e57d-5094-4774-89b5-d75d74999966	\N	http-basic-authenticator	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	65a5d6eb-344a-4306-b7a4-2b9e2915eac7	0	10	f	\N	\N
a1fc7410-5265-4aaf-8e51-6d9f8882614b	\N	docker-http-basic-authenticator	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	da93d782-72c3-4991-a54e-f414de321148	0	10	f	\N	\N
713e80e3-0360-4fac-a5d4-0046e6420852	\N	idp-email-verification	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	5673feb9-ece8-437b-8c38-77302fdcc098	2	10	f	\N	\N
5de9f787-234c-471f-addc-7af0fa0be8f2	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	5673feb9-ece8-437b-8c38-77302fdcc098	2	20	t	d8f57f1e-9c14-48b3-ad28-ec6b229c2026	\N
46ff26e5-bcf5-4e57-881c-4ec2668d8e10	\N	conditional-user-configured	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	95e9f783-2c9c-48e3-bcc8-02030a49ab26	0	10	f	\N	\N
f3bd4f8b-6b97-454b-8ac9-59fd391a9988	\N	auth-otp-form	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	95e9f783-2c9c-48e3-bcc8-02030a49ab26	0	20	f	\N	\N
4d2b9d56-6a25-4cbc-93b7-864124e630ec	\N	conditional-user-configured	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	b059580e-2a2c-432e-9fb7-63ed765dc025	0	10	f	\N	\N
b79364c3-eb5f-450b-ba8f-5bf03a222cdb	\N	direct-grant-validate-otp	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	b059580e-2a2c-432e-9fb7-63ed765dc025	0	20	f	\N	\N
47ff97b3-e61c-4bd5-aaf7-bc833b6e29e1	\N	conditional-user-configured	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	3f49c112-65fe-48ef-a2d1-688936b95f00	0	10	f	\N	\N
04686d7c-9a8a-4bc2-8899-602e9e0b39e1	\N	auth-otp-form	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	3f49c112-65fe-48ef-a2d1-688936b95f00	0	20	f	\N	\N
7de9f70f-fd8a-4bb6-9949-ab9e67af8b41	\N	idp-confirm-link	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	050f976c-9a4f-4f57-b962-0a5872fda742	0	10	f	\N	\N
4acf1f81-0fce-4189-808c-4ea2f8b1cbdc	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	050f976c-9a4f-4f57-b962-0a5872fda742	0	20	t	5673feb9-ece8-437b-8c38-77302fdcc098	\N
c51f80d0-758b-4a19-afb8-4b93b6f2fe26	\N	conditional-user-configured	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	b6dbb997-9bfb-481e-83af-65247075e8a8	0	10	f	\N	\N
0e7d3f78-8a27-4718-9731-a2b55042aa7a	\N	reset-otp	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	b6dbb997-9bfb-481e-83af-65247075e8a8	0	20	f	\N	\N
1f5eb52d-8c87-4387-a5aa-64716c700ccb	\N	idp-create-user-if-unique	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	9bfa0b9f-9b07-4538-8f4a-20a83283ea42	2	10	f	\N	f701c97c-6675-41d4-8f9c-ed4991b73c5a
f1d1f2a0-49cc-4347-aac5-f2cfe32f8eca	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	9bfa0b9f-9b07-4538-8f4a-20a83283ea42	2	20	t	050f976c-9a4f-4f57-b962-0a5872fda742	\N
bacf0809-7d16-44c4-9b0a-672d12fc382a	\N	idp-username-password-form	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d8f57f1e-9c14-48b3-ad28-ec6b229c2026	0	10	f	\N	\N
b1a9b8d0-1028-49f5-beb3-c369087f1ade	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d8f57f1e-9c14-48b3-ad28-ec6b229c2026	1	20	t	3f49c112-65fe-48ef-a2d1-688936b95f00	\N
a056b3f6-ee5e-4b40-bd98-373ea6fe9477	\N	auth-cookie	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	31f488c9-84e6-4d73-9bdf-49bf767e2761	2	10	f	\N	\N
ca991e63-a480-4040-8299-6f31afc2a0b2	\N	auth-spnego	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	31f488c9-84e6-4d73-9bdf-49bf767e2761	3	20	f	\N	\N
ad1b5f96-3bb5-4c47-bed9-102c5402422d	\N	identity-provider-redirector	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	31f488c9-84e6-4d73-9bdf-49bf767e2761	2	25	f	\N	\N
adbf9c1c-cdd6-41f7-ab46-4063ebb1ed73	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	31f488c9-84e6-4d73-9bdf-49bf767e2761	2	30	t	328e9bc4-4c8e-409b-9a86-3225aaae161f	\N
3d11b390-c148-43b2-8f4a-604ca052ed4e	\N	client-secret	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f71f75a7-6384-4ceb-91b4-48cb94a69260	2	10	f	\N	\N
f6a6dfb8-3c5a-4ba2-975e-f04c3064e6b6	\N	client-jwt	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f71f75a7-6384-4ceb-91b4-48cb94a69260	2	20	f	\N	\N
50a517a8-12ce-4334-9133-8355b40fddef	\N	client-secret-jwt	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f71f75a7-6384-4ceb-91b4-48cb94a69260	2	30	f	\N	\N
e369a436-7722-406f-9783-ab6a53487120	\N	client-x509	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f71f75a7-6384-4ceb-91b4-48cb94a69260	2	40	f	\N	\N
2362ed32-8101-4095-ac0f-0e1510a563f3	\N	direct-grant-validate-username	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2f17e380-7659-43eb-8a06-f84dc0ba1d8b	0	10	f	\N	\N
d940ae58-bcee-4582-9114-05c161e6e2ef	\N	direct-grant-validate-password	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2f17e380-7659-43eb-8a06-f84dc0ba1d8b	0	20	f	\N	\N
79009457-0ac8-4d22-8922-0be8e44b7e9a	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2f17e380-7659-43eb-8a06-f84dc0ba1d8b	1	30	t	b059580e-2a2c-432e-9fb7-63ed765dc025	\N
0af6dc01-5408-4f71-93a2-227231efb577	\N	docker-http-basic-authenticator	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	20a77515-6765-465f-bff2-98408578062c	0	10	f	\N	\N
6550d2e3-ad07-4d5a-a049-119efd20c41b	\N	idp-review-profile	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	a116be67-51ee-45cf-8b4b-703ce965c4ce	0	10	f	\N	61fd70c0-d06f-45a6-9a5d-6b7f6bdf2d84
948a6c3b-d4b3-4cac-90c4-e93b455c92ea	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	a116be67-51ee-45cf-8b4b-703ce965c4ce	0	20	t	9bfa0b9f-9b07-4538-8f4a-20a83283ea42	\N
4a96024b-f3ee-4c73-b8c9-d535dd00c5fd	\N	auth-username-password-form	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	328e9bc4-4c8e-409b-9a86-3225aaae161f	0	10	f	\N	\N
c215b29d-b0cf-4650-91d2-474c27839384	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	328e9bc4-4c8e-409b-9a86-3225aaae161f	1	20	t	95e9f783-2c9c-48e3-bcc8-02030a49ab26	\N
41c806e2-3d68-48ba-be0c-5bc5ee82cf28	\N	registration-page-form	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef0844e-0a7f-48ef-8afe-117d2c0c2f21	0	10	t	e58dc4be-3d5d-42e3-8dd1-f1bf5e126545	\N
750f9bc5-1725-4f28-969e-39daa43f83b3	\N	registration-user-creation	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	e58dc4be-3d5d-42e3-8dd1-f1bf5e126545	0	20	f	\N	\N
de0dd16e-e3ab-408e-85c7-73c153dff715	\N	registration-password-action	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	e58dc4be-3d5d-42e3-8dd1-f1bf5e126545	0	50	f	\N	\N
439ef966-25b9-490f-98e0-278784888547	\N	registration-recaptcha-action	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	e58dc4be-3d5d-42e3-8dd1-f1bf5e126545	3	60	f	\N	\N
696807dd-93a7-4690-849b-1bcb08f73010	\N	registration-terms-and-conditions	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	e58dc4be-3d5d-42e3-8dd1-f1bf5e126545	3	70	f	\N	\N
0076df4e-c397-47ca-9581-90cd0679ab1d	\N	reset-credentials-choose-user	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	48fc5fc5-77c6-4585-a0ce-bf99d2b63254	0	10	f	\N	\N
780c9ae6-3226-40d7-89c8-5150a46b778e	\N	reset-credential-email	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	48fc5fc5-77c6-4585-a0ce-bf99d2b63254	0	20	f	\N	\N
2fd4753e-cb5f-47d3-8a30-66d80db1e04d	\N	reset-password	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	48fc5fc5-77c6-4585-a0ce-bf99d2b63254	0	30	f	\N	\N
ab28766a-840b-4322-972c-ca6112637f3b	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	48fc5fc5-77c6-4585-a0ce-bf99d2b63254	1	40	t	b6dbb997-9bfb-481e-83af-65247075e8a8	\N
14a1ea24-6dc5-48f2-8fc2-61a7bf12a3ee	\N	http-basic-authenticator	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	7d4860bd-e995-4f44-9a96-4b4a424ef9b2	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
582602f7-7c64-487d-8be4-3a05eb876d48	browser	Browser based authentication	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
e3c91a86-e26d-4b9a-aaa2-4a599fe6da6e	forms	Username, password, otp and other auth forms.	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
e9c63712-1d45-4f72-80ac-0658ff901537	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
cb05c7bc-3b8d-4e34-aaa6-2f8e1679aca3	direct grant	OpenID Connect Resource Owner Grant	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
fdebbcef-5016-4a58-9290-abd98ea56cbe	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
4769f0a4-49ba-420d-881a-fe69002f2a5b	registration	Registration flow	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
dfb19ac5-a5a5-4915-a238-fbd5878d8a1a	registration form	Registration form	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	form-flow	f	t
ddcb76c2-a6e7-4ce1-b131-c89688b4a1c6	reset credentials	Reset credentials for a user if they forgot their password or something	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
629a20ac-af4b-488d-9146-9955823f7598	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
5478677e-0214-4975-a140-346576191016	clients	Base authentication for clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	client-flow	t	t
c65e56ec-02bd-479f-b6d1-f5c94fcf9841	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
9ba04a88-4ef3-42e2-b06f-72c627c7ae0b	User creation or linking	Flow for the existing/non-existing user alternatives	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
e57046b3-69a0-44b8-b793-f5799a97fbde	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
5a7fe78f-88fd-4882-8661-e053a79e81df	Account verification options	Method with which to verity the existing account	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
31c54f08-c39b-4458-a764-e8961dfa8202	Verify Existing Account by Re-authentication	Reauthentication of existing account	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
6aad27bd-0912-4775-acaa-8fb7ed6259a4	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	f	t
65a5d6eb-344a-4306-b7a4-2b9e2915eac7	saml ecp	SAML ECP Profile Authentication Flow	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
da93d782-72c3-4991-a54e-f414de321148	docker auth	Used by Docker clients to authenticate against the IDP	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	basic-flow	t	t
5673feb9-ece8-437b-8c38-77302fdcc098	Account verification options	Method with which to verity the existing account	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
95e9f783-2c9c-48e3-bcc8-02030a49ab26	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
b059580e-2a2c-432e-9fb7-63ed765dc025	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
3f49c112-65fe-48ef-a2d1-688936b95f00	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
050f976c-9a4f-4f57-b962-0a5872fda742	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
b6dbb997-9bfb-481e-83af-65247075e8a8	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
9bfa0b9f-9b07-4538-8f4a-20a83283ea42	User creation or linking	Flow for the existing/non-existing user alternatives	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
d8f57f1e-9c14-48b3-ad28-ec6b229c2026	Verify Existing Account by Re-authentication	Reauthentication of existing account	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
31f488c9-84e6-4d73-9bdf-49bf767e2761	browser	browser based authentication	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
f71f75a7-6384-4ceb-91b4-48cb94a69260	clients	Base authentication for clients	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	client-flow	t	t
2f17e380-7659-43eb-8a06-f84dc0ba1d8b	direct grant	OpenID Connect Resource Owner Grant	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
20a77515-6765-465f-bff2-98408578062c	docker auth	Used by Docker clients to authenticate against the IDP	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
a116be67-51ee-45cf-8b4b-703ce965c4ce	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
328e9bc4-4c8e-409b-9a86-3225aaae161f	forms	Username, password, otp and other auth forms.	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	f	t
fef0844e-0a7f-48ef-8afe-117d2c0c2f21	registration	registration flow	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
e58dc4be-3d5d-42e3-8dd1-f1bf5e126545	registration form	registration form	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	form-flow	f	t
48fc5fc5-77c6-4585-a0ce-bf99d2b63254	reset credentials	Reset credentials for a user if they forgot their password or something	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
7d4860bd-e995-4f44-9a96-4b4a424ef9b2	saml ecp	SAML ECP Profile Authentication Flow	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
df1d1d3f-1e04-4d85-a4ff-e067d464d517	review profile config	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474
4f829705-5909-440f-ad82-4a0ca2337cde	create unique user config	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474
f701c97c-6675-41d4-8f9c-ed4991b73c5a	create unique user config	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7
61fd70c0-d06f-45a6-9a5d-6b7f6bdf2d84	review profile config	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
4f829705-5909-440f-ad82-4a0ca2337cde	false	require.password.update.after.registration
df1d1d3f-1e04-4d85-a4ff-e067d464d517	missing	update.profile.on.first.login
61fd70c0-d06f-45a6-9a5d-6b7f6bdf2d84	missing	update.profile.on.first.login
f701c97c-6675-41d4-8f9c-ed4991b73c5a	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
26888d86-910c-41fb-8ce5-29d04c068510	t	f	master-realm	0	f	\N	\N	t	\N	f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
1247f9f5-471b-43e3-a468-0090c66d9756	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
124e0ebc-264a-4040-baf0-75742f76e176	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ab28a178-3d71-46a1-a1ec-75aa16f8d563	t	f	broker	0	f	\N	\N	t	\N	f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
20445d48-11b7-412b-96d2-48b9964852c2	t	t	admin-cli	0	t	\N	\N	f	\N	f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
387ca314-961f-445b-a3ae-283df119b373	t	f	heartfull-mind-ecosystems-realm	0	f	\N	\N	t	\N	f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	0	f	f	heartfull-mind-ecosystems Realm	f	client-secret	\N	\N	\N	t	f	f	f
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	t	t	security-admin-console	0	t	\N	/admin/master/console/	f		f	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	http://localhost:9080		\N	t	f	f	f
fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	f	account	0	t	\N	/realms/heartfull-mind-ecosystems/account/	f	\N	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
68ba78c7-2a44-4adb-b3c8-0907759d3266	t	t	createyourhumanity-eco1	0	f	oqwZ1QBUiB9iIZ4O6YlPUFxRl92BZ3yw		f		f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	-1	t	f	Heartfull Mind Human Resource Management für Create Your Humanity	t	client-secret		Benutzerverwaltung für Create Your Humanity	\N	t	t	f	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	t	f	realm-management	0	f	\N	\N	t	\N	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
d8022315-1de9-4c99-a5a5-d0f1b7561889	t	t	heartfullmind-registry	0	f	c1ozaKSM5xrhJ2G4n22lo8mH5J8tRh7L	http://localhost:8761	f	http://localhost:8761	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	-1	t	f	Heartfull Mind Registry Server	t	client-secret	http://localhost:8761	Heartfull-Mind-Registry	\N	t	f	f	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	t	t	security-admin-console	0	t	\N	/admin/heartfull-mind-ecosystems/console/	f	\N	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a1d6d92c-61a4-4995-b335-575ff839e6e4	t	f	account-console	0	t	\N	/realms/heartfull-mind-ecosystems/account/	f	\N	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
64817668-7035-42ef-8559-1af0d4635314	t	f	broker	0	f	\N	\N	t	\N	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
4c952db3-8b92-454e-a70c-89a7ea051a12	t	t	admin-cli	0	t	\N	\N	f	\N	f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
279c38e5-81e9-4a81-82e9-031f5878374e	t	t	heartfull-mind-eco1	0	f	m8dx8mvrNiO3Naqsx0XcQ0WX4HsqImz3		f		f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	-1	t	f	Heartfull Mind Human Resource Management	t	client-secret		Head Quarter User Management für alle Einheiten von MMMM - Heartfull Mind SwPL.	\N	t	t	f	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	t	t	heartfullmind-gateway	0	f	k752aiCIv8ovV5ZceH8NaozBY7Yo5ygI		f		f	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	openid-connect	-1	t	f	Heartfull Mind Gateway für Create Your Humanity	t	client-secret		Gateway for heartfullmind apps	\N	t	f	t	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
1247f9f5-471b-43e3-a468-0090c66d9756	post.logout.redirect.uris	+
124e0ebc-264a-4040-baf0-75742f76e176	post.logout.redirect.uris	+
124e0ebc-264a-4040-baf0-75742f76e176	pkce.code.challenge.method	S256
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	post.logout.redirect.uris	+
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	pkce.code.challenge.method	S256
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	client.use.lightweight.access.token.enabled	true
20445d48-11b7-412b-96d2-48b9964852c2	client.use.lightweight.access.token.enabled	true
fef5fa01-fb03-428b-a87e-ab41930d6e8d	post.logout.redirect.uris	+
a1d6d92c-61a4-4995-b335-575ff839e6e4	post.logout.redirect.uris	+
a1d6d92c-61a4-4995-b335-575ff839e6e4	pkce.code.challenge.method	S256
4c952db3-8b92-454e-a70c-89a7ea051a12	post.logout.redirect.uris	+
64817668-7035-42ef-8559-1af0d4635314	post.logout.redirect.uris	+
279c38e5-81e9-4a81-82e9-031f5878374e	oidc.ciba.grant.enabled	false
279c38e5-81e9-4a81-82e9-031f5878374e	backchannel.logout.session.required	true
279c38e5-81e9-4a81-82e9-031f5878374e	oauth2.device.authorization.grant.enabled	false
279c38e5-81e9-4a81-82e9-031f5878374e	backchannel.logout.revoke.offline.tokens	false
279c38e5-81e9-4a81-82e9-031f5878374e	post.logout.redirect.uris	+
8501b471-8e28-4e4f-aff9-39f0dceb1315	post.logout.redirect.uris	+
7131682d-2564-4e5e-afa9-4979a1b8d08a	post.logout.redirect.uris	+
7131682d-2564-4e5e-afa9-4979a1b8d08a	pkce.code.challenge.method	S256
7131682d-2564-4e5e-afa9-4979a1b8d08a	client.use.lightweight.access.token.enabled	true
4c952db3-8b92-454e-a70c-89a7ea051a12	client.use.lightweight.access.token.enabled	true
279c38e5-81e9-4a81-82e9-031f5878374e	client.secret.creation.time	1730020299
279c38e5-81e9-4a81-82e9-031f5878374e	realm_client	false
279c38e5-81e9-4a81-82e9-031f5878374e	display.on.consent.screen	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	realm_client	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	oidc.ciba.grant.enabled	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	backchannel.logout.session.required	true
68ba78c7-2a44-4adb-b3c8-0907759d3266	display.on.consent.screen	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	oauth2.device.authorization.grant.enabled	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	backchannel.logout.revoke.offline.tokens	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	client.secret.creation.time	1730034206
68ba78c7-2a44-4adb-b3c8-0907759d3266	use.refresh.tokens	true
68ba78c7-2a44-4adb-b3c8-0907759d3266	client_credentials.use_refresh_token	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	token.response.type.bearer.lower-case	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	tls.client.certificate.bound.access.tokens	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	require.pushed.authorization.requests	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	client.use.lightweight.access.token.enabled	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	client.introspection.response.allow.jwt.claim.enabled	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	acr.loa.map	{}
68ba78c7-2a44-4adb-b3c8-0907759d3266	jwks.url	http://localhost:9080/realms/heartfull-mind-ecosystems/protocol/openid-connect/certs
d8022315-1de9-4c99-a5a5-d0f1b7561889	client.introspection.response.allow.jwt.claim.enabled	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	post.logout.redirect.uris	+
d8022315-1de9-4c99-a5a5-d0f1b7561889	oauth2.device.authorization.grant.enabled	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	backchannel.logout.revoke.offline.tokens	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	use.refresh.tokens	true
d8022315-1de9-4c99-a5a5-d0f1b7561889	realm_client	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	oidc.ciba.grant.enabled	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	client.use.lightweight.access.token.enabled	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	backchannel.logout.session.required	true
d8022315-1de9-4c99-a5a5-d0f1b7561889	client_credentials.use_refresh_token	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	jwks.url	http://localhost:9080/realms/heartfull-mind-ecosystems/protocol/openid-connect/certs
d8022315-1de9-4c99-a5a5-d0f1b7561889	acr.loa.map	{}
d8022315-1de9-4c99-a5a5-d0f1b7561889	require.pushed.authorization.requests	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	tls.client.certificate.bound.access.tokens	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	display.on.consent.screen	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	client.secret.creation.time	1730045413
d8022315-1de9-4c99-a5a5-d0f1b7561889	use.jwks.url	false
68ba78c7-2a44-4adb-b3c8-0907759d3266	use.jwks.url	false
d8022315-1de9-4c99-a5a5-d0f1b7561889	token.response.type.bearer.lower-case	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	client.introspection.response.allow.jwt.claim.enabled	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	post.logout.redirect.uris	+
2bdc627e-50a0-493e-a38c-f0b8def716cd	oauth2.device.authorization.grant.enabled	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	use.jwks.url	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	backchannel.logout.revoke.offline.tokens	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	use.refresh.tokens	true
2bdc627e-50a0-493e-a38c-f0b8def716cd	realm_client	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	oidc.ciba.grant.enabled	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	client.use.lightweight.access.token.enabled	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	backchannel.logout.session.required	true
2bdc627e-50a0-493e-a38c-f0b8def716cd	client_credentials.use_refresh_token	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	jwks.url	http://localhost:9080/realms/heartfull-mind-ecosystems/protocol/openid-connect/certs
2bdc627e-50a0-493e-a38c-f0b8def716cd	tls.client.certificate.bound.access.tokens	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	require.pushed.authorization.requests	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	acr.loa.map	{}
2bdc627e-50a0-493e-a38c-f0b8def716cd	display.on.consent.screen	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	token.response.type.bearer.lower-case	false
2bdc627e-50a0-493e-a38c-f0b8def716cd	client.secret.creation.time	1730438290
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	realm_client	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	oauth2.device.authorization.grant.enabled	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	oidc.ciba.grant.enabled	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	display.on.consent.screen	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	backchannel.logout.session.required	true
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	backchannel.logout.revoke.offline.tokens	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	use.refresh.tokens	true
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	client_credentials.use_refresh_token	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	token.response.type.bearer.lower-case	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	tls.client.certificate.bound.access.tokens	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	require.pushed.authorization.requests	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	client.introspection.response.allow.jwt.claim.enabled	false
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	acr.loa.map	{}
68ba78c7-2a44-4adb-b3c8-0907759d3266	frontchannel.logout.session.required	true
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
95e52084-9f72-418b-8354-b2be90c8057e	offline_access	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect built-in scope: offline_access	openid-connect
1e18cda9-723d-4c61-a0b7-c73f93c9ef0a	role_list	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	SAML role list	saml
92963282-93b8-4146-b943-92938929c255	saml_organization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	Organization Membership	saml
d0dcc7cf-dbf8-4926-955c-d3b8c732528f	profile	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect built-in scope: profile	openid-connect
32f9707e-06f2-4c76-9ab5-419fe1da1107	email	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect built-in scope: email	openid-connect
2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	address	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect built-in scope: address	openid-connect
6bb6342d-4413-4217-bcd9-cc398ab3ecdd	phone	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect built-in scope: phone	openid-connect
19f16ba1-df56-4156-babf-9b088b3b44f9	roles	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect scope for add user roles to the access token	openid-connect
955bf1e3-e373-4abb-90b5-9b72e4a7a58e	web-origins	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect scope for add allowed web origins to the access token	openid-connect
d1204b7b-5ecf-4be6-a33b-0d1845ccb082	microprofile-jwt	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	Microprofile - JWT built-in scope	openid-connect
94bd7db0-c724-4481-9198-8b06e78614f4	acr	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
59bcb9aa-5864-4ed5-9acc-6eb09283af11	basic	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	OpenID Connect scope for add all basic claims to the token	openid-connect
6d0c424a-24e3-4d76-b1c9-d214f09c13f5	organization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	Additional claims about the organization a subject belongs to	openid-connect
bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	web-origins	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect scope for add allowed web origins to the access token	openid-connect
87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	acr	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ff4c9fb7-c7a0-45ae-b03b-d23c82f5144d	role_list	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	SAML role list	saml
12a0bd96-8f01-47c7-a1ad-164b61c2d62c	address	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect built-in scope: address	openid-connect
aa3785a5-bbd9-4690-9566-f830dd2cb090	basic	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect scope for add all basic claims to the token	openid-connect
70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	offline_access	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect built-in scope: offline_access	openid-connect
2df458fa-5cb1-40a6-b17d-992edf1927f6	phone	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect built-in scope: phone	openid-connect
f54a3ac4-e891-40bf-ae03-41a2524b74d7	email	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect built-in scope: email	openid-connect
a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	microprofile-jwt	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	Microprofile - JWT built-in scope	openid-connect
fdd6bffe-6613-4ed5-ac11-03ffca40384e	roles	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect scope for add user roles to the access token	openid-connect
d75af507-a2e9-4e6e-bd46-193169812613	profile	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	OpenID Connect built-in scope: profile	openid-connect
b416fe2a-d004-42bf-95aa-323ddb13dd0a	picture	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	picture	openid-connect
df5454a7-d0b0-4eea-b0b5-291c10620733	openid	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7		openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
95e52084-9f72-418b-8354-b2be90c8057e	true	display.on.consent.screen
95e52084-9f72-418b-8354-b2be90c8057e	${offlineAccessScopeConsentText}	consent.screen.text
1e18cda9-723d-4c61-a0b7-c73f93c9ef0a	true	display.on.consent.screen
1e18cda9-723d-4c61-a0b7-c73f93c9ef0a	${samlRoleListScopeConsentText}	consent.screen.text
92963282-93b8-4146-b943-92938929c255	false	display.on.consent.screen
d0dcc7cf-dbf8-4926-955c-d3b8c732528f	true	display.on.consent.screen
d0dcc7cf-dbf8-4926-955c-d3b8c732528f	${profileScopeConsentText}	consent.screen.text
d0dcc7cf-dbf8-4926-955c-d3b8c732528f	true	include.in.token.scope
32f9707e-06f2-4c76-9ab5-419fe1da1107	true	display.on.consent.screen
32f9707e-06f2-4c76-9ab5-419fe1da1107	${emailScopeConsentText}	consent.screen.text
32f9707e-06f2-4c76-9ab5-419fe1da1107	true	include.in.token.scope
2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	true	display.on.consent.screen
2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	${addressScopeConsentText}	consent.screen.text
2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	true	include.in.token.scope
6bb6342d-4413-4217-bcd9-cc398ab3ecdd	true	display.on.consent.screen
6bb6342d-4413-4217-bcd9-cc398ab3ecdd	${phoneScopeConsentText}	consent.screen.text
6bb6342d-4413-4217-bcd9-cc398ab3ecdd	true	include.in.token.scope
19f16ba1-df56-4156-babf-9b088b3b44f9	true	display.on.consent.screen
19f16ba1-df56-4156-babf-9b088b3b44f9	${rolesScopeConsentText}	consent.screen.text
19f16ba1-df56-4156-babf-9b088b3b44f9	false	include.in.token.scope
955bf1e3-e373-4abb-90b5-9b72e4a7a58e	false	display.on.consent.screen
955bf1e3-e373-4abb-90b5-9b72e4a7a58e		consent.screen.text
955bf1e3-e373-4abb-90b5-9b72e4a7a58e	false	include.in.token.scope
d1204b7b-5ecf-4be6-a33b-0d1845ccb082	false	display.on.consent.screen
d1204b7b-5ecf-4be6-a33b-0d1845ccb082	true	include.in.token.scope
94bd7db0-c724-4481-9198-8b06e78614f4	false	display.on.consent.screen
94bd7db0-c724-4481-9198-8b06e78614f4	false	include.in.token.scope
59bcb9aa-5864-4ed5-9acc-6eb09283af11	false	display.on.consent.screen
59bcb9aa-5864-4ed5-9acc-6eb09283af11	false	include.in.token.scope
6d0c424a-24e3-4d76-b1c9-d214f09c13f5	true	display.on.consent.screen
6d0c424a-24e3-4d76-b1c9-d214f09c13f5	${organizationScopeConsentText}	consent.screen.text
6d0c424a-24e3-4d76-b1c9-d214f09c13f5	true	include.in.token.scope
2df458fa-5cb1-40a6-b17d-992edf1927f6	true	include.in.token.scope
2df458fa-5cb1-40a6-b17d-992edf1927f6	${phoneScopeConsentText}	consent.screen.text
2df458fa-5cb1-40a6-b17d-992edf1927f6	true	display.on.consent.screen
f54a3ac4-e891-40bf-ae03-41a2524b74d7	true	include.in.token.scope
f54a3ac4-e891-40bf-ae03-41a2524b74d7	${emailScopeConsentText}	consent.screen.text
f54a3ac4-e891-40bf-ae03-41a2524b74d7	true	display.on.consent.screen
a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	true	include.in.token.scope
a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	false	display.on.consent.screen
bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	false	include.in.token.scope
bc2c025f-9b58-44f5-9a9a-e8bb86203b5a		consent.screen.text
bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	false	display.on.consent.screen
87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	false	include.in.token.scope
87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	false	display.on.consent.screen
ff4c9fb7-c7a0-45ae-b03b-d23c82f5144d	${samlRoleListScopeConsentText}	consent.screen.text
ff4c9fb7-c7a0-45ae-b03b-d23c82f5144d	true	display.on.consent.screen
12a0bd96-8f01-47c7-a1ad-164b61c2d62c	true	include.in.token.scope
12a0bd96-8f01-47c7-a1ad-164b61c2d62c	${addressScopeConsentText}	consent.screen.text
12a0bd96-8f01-47c7-a1ad-164b61c2d62c	true	display.on.consent.screen
aa3785a5-bbd9-4690-9566-f830dd2cb090	false	include.in.token.scope
aa3785a5-bbd9-4690-9566-f830dd2cb090	false	display.on.consent.screen
70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	${offlineAccessScopeConsentText}	consent.screen.text
70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	true	display.on.consent.screen
fdd6bffe-6613-4ed5-ac11-03ffca40384e	${rolesScopeConsentText}	consent.screen.text
fdd6bffe-6613-4ed5-ac11-03ffca40384e	true	display.on.consent.screen
d75af507-a2e9-4e6e-bd46-193169812613	true	include.in.token.scope
d75af507-a2e9-4e6e-bd46-193169812613	${profileScopeConsentText}	consent.screen.text
d75af507-a2e9-4e6e-bd46-193169812613	true	display.on.consent.screen
fdd6bffe-6613-4ed5-ac11-03ffca40384e		gui.order
fdd6bffe-6613-4ed5-ac11-03ffca40384e	true	include.in.token.scope
b416fe2a-d004-42bf-95aa-323ddb13dd0a	true	display.on.consent.screen
b416fe2a-d004-42bf-95aa-323ddb13dd0a		consent.screen.text
b416fe2a-d004-42bf-95aa-323ddb13dd0a	true	include.in.token.scope
b416fe2a-d004-42bf-95aa-323ddb13dd0a		gui.order
df5454a7-d0b0-4eea-b0b5-291c10620733	true	display.on.consent.screen
df5454a7-d0b0-4eea-b0b5-291c10620733		consent.screen.text
df5454a7-d0b0-4eea-b0b5-291c10620733	false	include.in.token.scope
df5454a7-d0b0-4eea-b0b5-291c10620733		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
1247f9f5-471b-43e3-a468-0090c66d9756	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
1247f9f5-471b-43e3-a468-0090c66d9756	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
1247f9f5-471b-43e3-a468-0090c66d9756	19f16ba1-df56-4156-babf-9b088b3b44f9	t
1247f9f5-471b-43e3-a468-0090c66d9756	94bd7db0-c724-4481-9198-8b06e78614f4	t
1247f9f5-471b-43e3-a468-0090c66d9756	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
1247f9f5-471b-43e3-a468-0090c66d9756	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
1247f9f5-471b-43e3-a468-0090c66d9756	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
1247f9f5-471b-43e3-a468-0090c66d9756	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
1247f9f5-471b-43e3-a468-0090c66d9756	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
1247f9f5-471b-43e3-a468-0090c66d9756	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
1247f9f5-471b-43e3-a468-0090c66d9756	95e52084-9f72-418b-8354-b2be90c8057e	f
124e0ebc-264a-4040-baf0-75742f76e176	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
124e0ebc-264a-4040-baf0-75742f76e176	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
124e0ebc-264a-4040-baf0-75742f76e176	19f16ba1-df56-4156-babf-9b088b3b44f9	t
124e0ebc-264a-4040-baf0-75742f76e176	94bd7db0-c724-4481-9198-8b06e78614f4	t
124e0ebc-264a-4040-baf0-75742f76e176	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
124e0ebc-264a-4040-baf0-75742f76e176	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
124e0ebc-264a-4040-baf0-75742f76e176	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
124e0ebc-264a-4040-baf0-75742f76e176	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
124e0ebc-264a-4040-baf0-75742f76e176	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
124e0ebc-264a-4040-baf0-75742f76e176	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
124e0ebc-264a-4040-baf0-75742f76e176	95e52084-9f72-418b-8354-b2be90c8057e	f
20445d48-11b7-412b-96d2-48b9964852c2	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
20445d48-11b7-412b-96d2-48b9964852c2	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
20445d48-11b7-412b-96d2-48b9964852c2	19f16ba1-df56-4156-babf-9b088b3b44f9	t
20445d48-11b7-412b-96d2-48b9964852c2	94bd7db0-c724-4481-9198-8b06e78614f4	t
20445d48-11b7-412b-96d2-48b9964852c2	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
20445d48-11b7-412b-96d2-48b9964852c2	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
20445d48-11b7-412b-96d2-48b9964852c2	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
20445d48-11b7-412b-96d2-48b9964852c2	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
20445d48-11b7-412b-96d2-48b9964852c2	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
20445d48-11b7-412b-96d2-48b9964852c2	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
20445d48-11b7-412b-96d2-48b9964852c2	95e52084-9f72-418b-8354-b2be90c8057e	f
ab28a178-3d71-46a1-a1ec-75aa16f8d563	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
ab28a178-3d71-46a1-a1ec-75aa16f8d563	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
ab28a178-3d71-46a1-a1ec-75aa16f8d563	19f16ba1-df56-4156-babf-9b088b3b44f9	t
ab28a178-3d71-46a1-a1ec-75aa16f8d563	94bd7db0-c724-4481-9198-8b06e78614f4	t
ab28a178-3d71-46a1-a1ec-75aa16f8d563	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
ab28a178-3d71-46a1-a1ec-75aa16f8d563	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
ab28a178-3d71-46a1-a1ec-75aa16f8d563	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
ab28a178-3d71-46a1-a1ec-75aa16f8d563	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
ab28a178-3d71-46a1-a1ec-75aa16f8d563	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
ab28a178-3d71-46a1-a1ec-75aa16f8d563	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
ab28a178-3d71-46a1-a1ec-75aa16f8d563	95e52084-9f72-418b-8354-b2be90c8057e	f
26888d86-910c-41fb-8ce5-29d04c068510	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
26888d86-910c-41fb-8ce5-29d04c068510	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
26888d86-910c-41fb-8ce5-29d04c068510	19f16ba1-df56-4156-babf-9b088b3b44f9	t
26888d86-910c-41fb-8ce5-29d04c068510	94bd7db0-c724-4481-9198-8b06e78614f4	t
26888d86-910c-41fb-8ce5-29d04c068510	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
26888d86-910c-41fb-8ce5-29d04c068510	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
26888d86-910c-41fb-8ce5-29d04c068510	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
26888d86-910c-41fb-8ce5-29d04c068510	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
26888d86-910c-41fb-8ce5-29d04c068510	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
26888d86-910c-41fb-8ce5-29d04c068510	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
26888d86-910c-41fb-8ce5-29d04c068510	95e52084-9f72-418b-8354-b2be90c8057e	f
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	19f16ba1-df56-4156-babf-9b088b3b44f9	t
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	94bd7db0-c724-4481-9198-8b06e78614f4	t
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	95e52084-9f72-418b-8354-b2be90c8057e	f
279c38e5-81e9-4a81-82e9-031f5878374e	d75af507-a2e9-4e6e-bd46-193169812613	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	d75af507-a2e9-4e6e-bd46-193169812613	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
fef5fa01-fb03-428b-a87e-ab41930d6e8d	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
fef5fa01-fb03-428b-a87e-ab41930d6e8d	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
fef5fa01-fb03-428b-a87e-ab41930d6e8d	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
fef5fa01-fb03-428b-a87e-ab41930d6e8d	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
a1d6d92c-61a4-4995-b335-575ff839e6e4	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
a1d6d92c-61a4-4995-b335-575ff839e6e4	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
a1d6d92c-61a4-4995-b335-575ff839e6e4	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
a1d6d92c-61a4-4995-b335-575ff839e6e4	d75af507-a2e9-4e6e-bd46-193169812613	t
a1d6d92c-61a4-4995-b335-575ff839e6e4	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
a1d6d92c-61a4-4995-b335-575ff839e6e4	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
a1d6d92c-61a4-4995-b335-575ff839e6e4	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
a1d6d92c-61a4-4995-b335-575ff839e6e4	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
a1d6d92c-61a4-4995-b335-575ff839e6e4	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
a1d6d92c-61a4-4995-b335-575ff839e6e4	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
68ba78c7-2a44-4adb-b3c8-0907759d3266	d75af507-a2e9-4e6e-bd46-193169812613	t
68ba78c7-2a44-4adb-b3c8-0907759d3266	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
4c952db3-8b92-454e-a70c-89a7ea051a12	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
4c952db3-8b92-454e-a70c-89a7ea051a12	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
4c952db3-8b92-454e-a70c-89a7ea051a12	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
4c952db3-8b92-454e-a70c-89a7ea051a12	d75af507-a2e9-4e6e-bd46-193169812613	t
4c952db3-8b92-454e-a70c-89a7ea051a12	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
4c952db3-8b92-454e-a70c-89a7ea051a12	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
4c952db3-8b92-454e-a70c-89a7ea051a12	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
4c952db3-8b92-454e-a70c-89a7ea051a12	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
4c952db3-8b92-454e-a70c-89a7ea051a12	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
4c952db3-8b92-454e-a70c-89a7ea051a12	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
68ba78c7-2a44-4adb-b3c8-0907759d3266	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
68ba78c7-2a44-4adb-b3c8-0907759d3266	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	t
64817668-7035-42ef-8559-1af0d4635314	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
64817668-7035-42ef-8559-1af0d4635314	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
64817668-7035-42ef-8559-1af0d4635314	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
64817668-7035-42ef-8559-1af0d4635314	d75af507-a2e9-4e6e-bd46-193169812613	t
64817668-7035-42ef-8559-1af0d4635314	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
64817668-7035-42ef-8559-1af0d4635314	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
64817668-7035-42ef-8559-1af0d4635314	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
64817668-7035-42ef-8559-1af0d4635314	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
64817668-7035-42ef-8559-1af0d4635314	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
64817668-7035-42ef-8559-1af0d4635314	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
2bdc627e-50a0-493e-a38c-f0b8def716cd	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	2df458fa-5cb1-40a6-b17d-992edf1927f6	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	d75af507-a2e9-4e6e-bd46-193169812613	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
2bdc627e-50a0-493e-a38c-f0b8def716cd	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
68ba78c7-2a44-4adb-b3c8-0907759d3266	df5454a7-d0b0-4eea-b0b5-291c10620733	t
279c38e5-81e9-4a81-82e9-031f5878374e	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
279c38e5-81e9-4a81-82e9-031f5878374e	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
279c38e5-81e9-4a81-82e9-031f5878374e	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
279c38e5-81e9-4a81-82e9-031f5878374e	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
279c38e5-81e9-4a81-82e9-031f5878374e	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
279c38e5-81e9-4a81-82e9-031f5878374e	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
279c38e5-81e9-4a81-82e9-031f5878374e	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
279c38e5-81e9-4a81-82e9-031f5878374e	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
279c38e5-81e9-4a81-82e9-031f5878374e	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
d8022315-1de9-4c99-a5a5-d0f1b7561889	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
d8022315-1de9-4c99-a5a5-d0f1b7561889	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
d8022315-1de9-4c99-a5a5-d0f1b7561889	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
d8022315-1de9-4c99-a5a5-d0f1b7561889	d75af507-a2e9-4e6e-bd46-193169812613	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	d75af507-a2e9-4e6e-bd46-193169812613	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
8501b471-8e28-4e4f-aff9-39f0dceb1315	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
8501b471-8e28-4e4f-aff9-39f0dceb1315	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
8501b471-8e28-4e4f-aff9-39f0dceb1315	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
8501b471-8e28-4e4f-aff9-39f0dceb1315	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
d8022315-1de9-4c99-a5a5-d0f1b7561889	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
d8022315-1de9-4c99-a5a5-d0f1b7561889	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
d8022315-1de9-4c99-a5a5-d0f1b7561889	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
d8022315-1de9-4c99-a5a5-d0f1b7561889	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
d8022315-1de9-4c99-a5a5-d0f1b7561889	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
d8022315-1de9-4c99-a5a5-d0f1b7561889	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
2bdc627e-50a0-493e-a38c-f0b8def716cd	b416fe2a-d004-42bf-95aa-323ddb13dd0a	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	d75af507-a2e9-4e6e-bd46-193169812613	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
7131682d-2564-4e5e-afa9-4979a1b8d08a	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
7131682d-2564-4e5e-afa9-4979a1b8d08a	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
7131682d-2564-4e5e-afa9-4979a1b8d08a	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
7131682d-2564-4e5e-afa9-4979a1b8d08a	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
95e52084-9f72-418b-8354-b2be90c8057e	b04ce985-00d1-41f3-aec8-0e8150d9f30b
70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	4bcb9852-3ccb-46d3-b2a0-a54ef1194650
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
90055758-98df-4166-863e-0b9845a4900e	Trusted Hosts	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	anonymous
599b8f5d-71ad-4138-9e22-233be8f6f2c0	Consent Required	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	anonymous
42b776f3-be61-47a8-9bb8-092e3693af90	Full Scope Disabled	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	anonymous
f1ba4551-3007-40ca-afe6-50e86aeed4e9	Max Clients Limit	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	anonymous
29ea0035-4967-432f-a6ee-4dfc251f5361	Allowed Protocol Mapper Types	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	anonymous
973066be-834b-4a15-a2f5-9f44d99cedc6	Allowed Client Scopes	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	anonymous
49c3ed11-bc35-4790-a70b-3ae033578ded	Allowed Protocol Mapper Types	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	authenticated
db060f1c-998f-4abe-aeaf-b70796040778	Allowed Client Scopes	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	authenticated
b31340fc-18f0-41d0-b392-9137dc05ca83	rsa-generated	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	rsa-generated	org.keycloak.keys.KeyProvider	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N
36729fcd-a758-49e0-a8e6-e7c17efe3516	rsa-enc-generated	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	rsa-enc-generated	org.keycloak.keys.KeyProvider	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N
059c2e51-1f91-4314-b227-f78a109c3114	hmac-generated-hs512	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	hmac-generated	org.keycloak.keys.KeyProvider	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N
72f094f8-eaa1-483b-b7ef-405f98edaa7e	aes-generated	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	aes-generated	org.keycloak.keys.KeyProvider	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N
1fb5e973-671c-49bc-a13e-df42242717de	\N	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N
b84f170f-17a8-49cc-8473-1dacaaffe136	Allowed Client Scopes	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	anonymous
e825f257-289e-46e2-8972-54cf4f588f18	Full Scope Disabled	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	anonymous
b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	Allowed Protocol Mapper Types	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	authenticated
85fcc3fd-0c6c-4464-b7d3-96058c029870	Trusted Hosts	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	anonymous
14617ebe-01f3-48bd-9e4f-8555e95cb52f	Consent Required	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	anonymous
cfeed3a7-9d43-4d4b-bf21-034173968a43	Allowed Protocol Mapper Types	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	anonymous
b25842e7-a7ca-4764-8dd5-1e5de8e3265a	Allowed Client Scopes	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	authenticated
271d4101-56b5-494d-82fc-20fcefcbd521	Max Clients Limit	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	anonymous
cf4bb6c6-d2fe-46ce-b531-227f4d777952	rsa-generated	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	rsa-generated	org.keycloak.keys.KeyProvider	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N
12025d44-f0d8-4814-8f05-1717bca89715	rsa-enc-generated	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	rsa-enc-generated	org.keycloak.keys.KeyProvider	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N
4e65bd13-9ab0-43eb-a501-975af50fe898	aes-generated	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	aes-generated	org.keycloak.keys.KeyProvider	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N
eceb9132-e8c8-48d5-a3c1-2595b6455ff9	hmac-generated-hs512	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	hmac-generated	org.keycloak.keys.KeyProvider	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N
2e4ae263-a222-4f5e-a3c9-5f276ac4f2df	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
74410548-74ea-4298-8f30-6f88d3e66f5b	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3d779444-6b4e-420a-9087-2f577e8d3e3c	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2d91a684-7188-4473-bfa8-08ef51905ca9	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	saml-role-list-mapper
bf5f00f8-4062-413b-a6a2-02031fb23f46	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	oidc-address-mapper
95638d6b-e738-4742-8037-a73465f83be6	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	oidc-full-name-mapper
09d3c7eb-e8e8-48ef-8bb7-7b3f3924b3c2	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	saml-user-attribute-mapper
7d4431f6-c8b7-4b16-9629-9d9ad883ed75	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
cc78661d-1150-457f-b607-b54cb7db2fba	29ea0035-4967-432f-a6ee-4dfc251f5361	allowed-protocol-mapper-types	saml-user-property-mapper
d04c8501-6066-4b6b-8a39-57d27338563b	973066be-834b-4a15-a2f5-9f44d99cedc6	allow-default-scopes	true
7536a5d3-d9cf-4ace-aae2-2acfe4fb210e	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	saml-user-property-mapper
74c68161-773f-4db2-a252-5931d812942e	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	oidc-full-name-mapper
eecda240-f14d-4db0-b979-63e270a038d3	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	saml-user-attribute-mapper
f26d7678-c3f4-44ad-a233-bdc4d0ef6492	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	saml-role-list-mapper
165393e5-a66b-4067-b7a0-8367491b5b8d	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
170ae33e-c45b-46e4-bf04-8d083efb22c9	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f596ca48-9c79-4903-a97e-9ede999fcdae	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f0ca0b5a-6deb-41aa-9c3b-0c31f46db3d2	49c3ed11-bc35-4790-a70b-3ae033578ded	allowed-protocol-mapper-types	oidc-address-mapper
3459d97d-263c-4c92-994a-0e63e4907840	90055758-98df-4166-863e-0b9845a4900e	client-uris-must-match	true
c85bb21a-a1db-490b-9f3a-12afdfab02a5	90055758-98df-4166-863e-0b9845a4900e	host-sending-registration-request-must-match	true
3a012477-c32f-4b5c-9d0f-379b0876a794	db060f1c-998f-4abe-aeaf-b70796040778	allow-default-scopes	true
6f56d0db-b8c8-4dd7-bc71-a1a51077d49e	f1ba4551-3007-40ca-afe6-50e86aeed4e9	max-clients	200
243552dd-ea57-4d06-9a88-ae67e75155a0	72f094f8-eaa1-483b-b7ef-405f98edaa7e	secret	c-1VF1yTfyzWYPoz5fqBDA
aecca824-0f1b-4ad2-abc4-792e5774590f	72f094f8-eaa1-483b-b7ef-405f98edaa7e	priority	100
5ff4b6ee-6ed8-4e0d-bc87-b8aefc49ceb2	72f094f8-eaa1-483b-b7ef-405f98edaa7e	kid	83236de6-950e-46f0-a062-3a6d6e396111
86cfcc75-a408-4b91-9818-669d67a3f633	b31340fc-18f0-41d0-b392-9137dc05ca83	priority	100
c47e8fcc-27fc-4540-85a2-29159ee180d6	b31340fc-18f0-41d0-b392-9137dc05ca83	keyUse	SIG
4bee19f2-ea24-474a-a2c1-0a1ddef66e2b	b31340fc-18f0-41d0-b392-9137dc05ca83	privateKey	MIIEogIBAAKCAQEAhfEM6/8HDKQVDe2FsW8B2eVUKXE0jQmp37tTnTOfz2EvJe46wJahggXqXmAHWRFhJh9T6oAl/twOxycQ34zfCQ9HWFWqWOzugnv+fncdj7+b526ztAArm8gqOgOIfxwnq0Lm+fdxweyNSOfIKjzhvMa+oHsLz6TlPSL2FCmt4BZP5aF4F6BkqO6TA+HXg4jpqSEPXbeQB7exstiXGJuaCYs4esTjritYpkydESvB6N/EjZf9RZIcFEIHhlXLCkKKwYm1ZVb5fbr4omBh8m2J/lpnxQX34u4rhz50UcIT8hNGukF8g7p7hY2Vk5xNLoOsB0a0gUtLgTTwTKcBll1lxQIDAQABAoIBAA3YbYwFmD5zxaNjbqL5RRk3jfwcsiB0I8W3UPzahcYDl0KV/ifDSl2s692mkovf8olkyqFebs8KA1MN1D4viyyeEjNs44d+smb1l0iOWpVt6plBRb0xGVDon4jQra7qA6W97C9hpzYzFCW5o+TN103Sw4jGP2HO+01XDFXoOwuDTKWKuZ1QBLkAbaaR9sB7x669rFqTlKcQlqTkbYzHVNl5FF2wuQBQr9Ej8JPbIp4MWiox119QGLl898GHthle+MG15kdcZipZO8LowicA9urWpnASM8Yt2OHraN/NKDABCFyrQRqojZ7yPKb9DOHiLV7RS74v4dq7ez4lAKW8rEECgYEAua6kRAjbwpEqlAHMy/QdVA9Y8vabIieSjgq2A0o+OQi14YNpa+i0qRL80HDQoEGnDThCYNJzYzfSt/ibdzUlZqYWiChS63fQSvuB93WUgnVpcR6OR2KvMT8Lrrxp4Hk6EDCm8LSeEhUmnb+sL2LYfvBCwYRkkxBNyWv+t+bEGaUCgYEAuKpObKUbDgRMdul1YB1VssqvkEXIqWgBZvC+U3GsY/B0YTwNzgD+InqM5UDkvYGMG595ypV9dQbrxxk1GSmM1v4LWjwj1YnXU4oELvq3vZIj6UPCC3GxV9FqzSvC9GpZIhE5IqCWSfrdmijvph79mky0/LzwZJCE+kNfCsvfIaECgYAM19SK1CYHJi1QwXMd5EunBcy8OWxvh1cutfTy806seTrDV2iSSy07yJFuBW+YthHM60hEFCphAXp0uSBftXBZ0kEat9dMbCQfG5hYumxEPcTGSzvCGkRN3rN7KZMVMK1gc00ItyV70LS0Eo7hVC/vT8T+R58BQQ5wUST0KWUE9QKBgD9nikHXdrCbXT2+7uQvbktTOHCK5Vj1MvYLVu4Dq7MszmjMW9kNkjR4a4QTgfZnUpnxabnbFhZmZ/IWf5rCH296Dp/O4mbhSyON0d3ni8r1MItZDnkrcj660rbbfba6BRyjWUDAbpm8HvZdc9tP7Ldb+xCENu3wiRf8pddpJJXBAoGABWuTRo4tziDNl5O8Utc3vl78Ott9EJpZx3SmlKavtRqP9NNosubpX/8tN9ZjckMUPVcsNmwxcWAu0Hp3Si5+3o0Q0nsxI+ZYgRmFWDiAmGLH/Rp4q1GxDq55lHSQM1QRAfEDKf/xDtPMqoE69RXphGz0hHIVFSdjJdFo0p8nrRo=
2b1972f7-d310-4367-acd2-42e10858cb59	b31340fc-18f0-41d0-b392-9137dc05ca83	certificate	MIICmzCCAYMCBgGSzHRHLDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMDI3MDUyODQ1WhcNMzQxMDI3MDQzMDI1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCF8Qzr/wcMpBUN7YWxbwHZ5VQpcTSNCanfu1OdM5/PYS8l7jrAlqGCBepeYAdZEWEmH1PqgCX+3A7HJxDfjN8JD0dYVapY7O6Ce/5+dx2Pv5vnbrO0ACubyCo6A4h/HCerQub593HB7I1I58gqPOG8xr6gewvPpOU9IvYUKa3gFk/loXgXoGSo7pMD4deDiOmpIQ9dt5AHt7Gy2JcYm5oJizh6xOOuK1imTJ0RK8Ho38SNl/1FkhwUQgeGVcsKQorBibVlVvl9uviiYGHybYn+WmfFBffi7iuHPnRRwhPyE0a6QXyDunuFjZWTnE0ug6wHRrSBS0uBNPBMpwGWXWXFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABm+pzqDcs74lizJ3woVeO5g0SWarPPmxHmsj3WjcLbuIzofiS7HGi/B6z/4A1UHJS9TaYpqsR+/hKOkjt+JxUOmgmFgystCGT5l9Wc12fscuC0XwtHNJss/grWbS5n2Om+oRT+9Dwcy+KLliDCHd9d6cx+thC8U0VyFRilmnTt6vxbmAG81jALJS70cy33VBwJLD3BMDakc14bh2Ieo0WrYVex1MYaNcyhVWtStmSv8Xa96De1GE4yjR3VHSH8QbnSX8xWIOmBZhKgT5dZhryPyeekExVkdc0h8zDnJWovPwbUj4N4ih1pBTFpKqSdCSiuucoMS7aA3DReW8ikg+Kw=
b088acf0-76f6-46be-900c-480f8b59d70d	36729fcd-a758-49e0-a8e6-e7c17efe3516	privateKey	MIIEowIBAAKCAQEAm3hfIWzc3Kt+sbb9oM0hNZPA8AyhzG7j8r6cDb+KHH59HtdbYpmmjG1Zcdg4fpBnh9xl40c4Hw6H4rSJyz6X4xu11fHoeaJ6k4U/z8KHkTkh6fc7M/lPuPQ2JSQEfmNP/PM0BTgsCbJvdEhZ7mxozSyEEiE5kMuY2DxK6rehoquW+9WcpL4mr22uwlbEmEhL8mX7zSLzp2RkPxbRwhV+MURKxnTzsIVsnBKRO/9PHVlCNU15BMT9RUdebGzYOkxYfqDZrjhdc6WO2mr4TNXsN4DaPDNVdTlysX2ZGsjjOmonTTi9S1PqQVI7IUGyO9jz3M86XvGRHl68rwuRX3Li4QIDAQABAoIBABLYb96hP7H7k01XP04GQ4HnNcZbX6MEZ5r5jjjP6J3M2t2Z0QzmD2VbDXIyeaGk3zndplebHtNL636YcBIMFbT8u0lSbCHPZ1CZwLsOS2jX/jOKSZnCnS5wIt6Ua7uGzg+9SsddsF/iCmbT7NvM9hS10lIQxzW1KkM+5r1mMkCBn/J8PkcqW487gKxJExcP43FppoaY+MkQf1NxY76+fgUUEcsjPL45jRbqHidpeeAMBPk/VC38hsleP9Hm7BAclZWrnVlsJqzOsLqoMHHn5LdzvTGsQPryrK6WmYq7D+9uqniHsSBEDHYCjNG91rXWpEPFv3q33iLP4xyTs9KsLNkCgYEA2GG5RREZ1FtZCZCR4at7aRktfd1uwSNH3c74ck53YwOeNDeCMEhl7B9Bza4/EIRqbaFmMKF7bT9qwZfyRn2uhykYr4omCqAVqsUnSkH7CD8Kh+qkHMXJoSYuCXp0+E75+Xmc2YsKcz/vuvJyyuFJitvTcqtAxA9Nw4Pa9TlHz6kCgYEAt++X+ijAP9xOXQqPLu516yYbT2IddMw/Bo8IGnIE0rjUe/jZ2V+U/QjXxUfkD73MO2lUEquqkT8vW0RprznFFvfjMRaW4uPS7xzsqztSnmrvZP3orFzfBN/Q5GVQ+c3GmgpGBmLpyQxt91yltq0Uz4Kyc64e4OVJJvIRof95XHkCgYB0ITaS19O6AfCuTnXM3QDV7hpZM89uPqYiaCM1DeHLNTTiJ2xqx2BUMo5ZegwErFyGTBoRPYmFn4SHNCpmJKvXhHnoNEeoajRWu4sTsoes7FCVk5vSiWBmaZxJn/xJC/HjL567roDES+s4tUhglDqpGMPKBhkzYFdG+Gw6MizVSQKBgFHaARuFfufsNcMZq9YKr9bQwl51Hv6W1YUpqUV7b8IGFiiE+QzOiBKCGOLltwt6PqRBnvQgCGtSXtSSgSVE4/vwm92AW+zjzT4y9O7OG1n75ERg6WWqfmRA5Uh9/absd3CdGcRFyBt7uIPXarb8FsKxOpBX783Mutzl5ArfETahAoGBALkZx8zucV7BUktNrWd93gHkI4AqcOxlzCeMGjg6XMlg9Ld4HqL+v7nzBqTkKqUR+IQw+YsxRpfiBVoDcirlc7zCZ1u+wZvpSdKYlb4PIHD4se78ji/C4qVPWplsL027NMvHvKieK8oYUSk/3VYK1YVq0G24iwG1ESvZWqEGU5gL
9859930b-b10e-4306-a229-fc7748e7bb75	36729fcd-a758-49e0-a8e6-e7c17efe3516	keyUse	ENC
87f0d08d-f7d9-459c-98f2-2ac27e386974	36729fcd-a758-49e0-a8e6-e7c17efe3516	certificate	MIICmzCCAYMCBgGSzHRIQjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMDI3MDUyODQ1WhcNMzQxMDI3MDQzMDI1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCbeF8hbNzcq36xtv2gzSE1k8DwDKHMbuPyvpwNv4ocfn0e11timaaMbVlx2Dh+kGeH3GXjRzgfDofitInLPpfjG7XV8eh5onqThT/PwoeROSHp9zsz+U+49DYlJAR+Y0/88zQFOCwJsm90SFnubGjNLIQSITmQy5jYPErqt6Giq5b71Zykviavba7CVsSYSEvyZfvNIvOnZGQ/FtHCFX4xRErGdPOwhWycEpE7/08dWUI1TXkExP1FR15sbNg6TFh+oNmuOF1zpY7aavhM1ew3gNo8M1V1OXKxfZkayOM6aidNOL1LU+pBUjshQbI72PPczzpe8ZEeXryvC5FfcuLhAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFusa7z5NLwP366xv7vnkklQzvfcVAOMmCCN8fj++f7NgBN/7T8vbLG6qip9ieyDDRI2/x9gB1WLCw9nnMSbScumMf/UuVjvXJqf/IFuZbTO3bA1vpoMptL5ktOMkx2hondNvQ8NEWjhGD/wJ0HSKNVTCw6nq+0/9cDPq9xDvlzdLT9WUh/QmfPadzJ/y9gdU1bZzRYvVvmQal7LVHlgmyOhBYjyAYwEUSQbeAqGsLwKN4x0Vguqt8qtfUbQPEYelqiGLF20ADBSUdO9rP+OligNW+o5so2OFRzF9vMWEtwc+pstGk45eY7/EiNHJPKrL4sHKIdqaLIrruXhsNqZA94=
3442bf61-2761-4273-8120-4a874df957c4	36729fcd-a758-49e0-a8e6-e7c17efe3516	priority	100
17bd5fd4-8402-430c-8cb0-387385d5eabf	36729fcd-a758-49e0-a8e6-e7c17efe3516	algorithm	RSA-OAEP
9312acd3-37d2-4e93-92ab-71ace59bf677	1fb5e973-671c-49bc-a13e-df42242717de	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
1b117edc-fd88-4ac0-90d4-3cf648b2ad8f	059c2e51-1f91-4314-b227-f78a109c3114	priority	100
f067352d-beb9-4ca4-9f96-581d88eed867	059c2e51-1f91-4314-b227-f78a109c3114	secret	8Nbpbfk30HZG-EgRy3aBALlaWgzZ33DY02Nz7OmRJOHxa92kkMOSJsjf7y5VSfUTPmBnXc3j0POcj5JxGU150fJc_7Vvz874BcqR9adOsOmqHl-6pEmYOL3rsVack2rh7hG0DJy2vW2nDF8t6Szvu4eaeLB_BG-NW9wipxgzBX8
1ecc4a7c-34eb-4287-93a1-3e17c1d0da5f	059c2e51-1f91-4314-b227-f78a109c3114	algorithm	HS512
2ad08b40-0a04-4499-8961-8f4dfbd66310	059c2e51-1f91-4314-b227-f78a109c3114	kid	85d8757f-1190-4a1e-8f1a-50a06804b7b7
7e620438-26db-429e-b637-3ff454ebaa08	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	saml-user-attribute-mapper
81f4a110-3b46-4410-8afb-2dfb9719b4f8	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	saml-role-list-mapper
a01143e2-7cdc-4601-acd8-3f5e8514f960	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b79c5aca-5e7d-4038-9366-24a67d53a126	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	oidc-address-mapper
3d9a95b9-172e-47d7-8cc7-245acbe7e240	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	saml-user-property-mapper
01957ce7-4afd-410f-ba3e-fc42def1aa52	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3cf531d4-5239-4b14-b771-0ee16b79a9a6	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	oidc-full-name-mapper
e531b090-4812-4ca5-a2dd-ab943b8f8a46	cfeed3a7-9d43-4d4b-bf21-034173968a43	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9c03b5ae-c0cf-468b-9c12-fe59463004aa	b25842e7-a7ca-4764-8dd5-1e5de8e3265a	allow-default-scopes	true
cba41410-e287-40a7-807f-572a2ec91081	cf4bb6c6-d2fe-46ce-b531-227f4d777952	certificate	MIICwTCCAakCBgGSzK9ZpjANBgkqhkiG9w0BAQsFADAkMSIwIAYDVQQDDBloZWFydGZ1bGwtbWluZC1lY29zeXN0ZW1zMB4XDTI0MTAyNzA2MzMxNloXDTM0MTAyNzA1MzQ1NlowJDEiMCAGA1UEAwwZaGVhcnRmdWxsLW1pbmQtZWNvc3lzdGVtczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIgHpQepbTOQ4tv7VTW25ZyNAuXD/P/+Vt55Sl1ZNA+sYXZIqahNqfbJipFaDCfLWvO7bWMPII6kn2HomJ8G/DgD1ss0AYWe9dRoTb7r1qhYgKaq0LgKyAlyTV2FCzA7H2nnanTwBvb2O80EfLYiR842v9aN/HLJHdoJjZesQFjnIPr5qY1sbIr+gmN4j+P5h/ryDj3xCRLr7ZxIkdDnWzAYA2ePwPnkx4LhnWgZkiTHT+cqfjRlUgA1E3HPdlkrEDOUJ1arb9DN7HnxYirL1K+9/p6Rm0YFyhWHkqqckrexlySK4gGthVaJWbH3B00DTh3kmmkcPc07SXc5Oh6wJA8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAWtrw57TEZL6us2c+/EKx22wQeB2O3itAUerMz+5VCfCDisNtsQOYNckyxPCzQ5EL+XNXdSTBlWE3N65LdgzyZwGgWI9OD+Sd5lBE/02Sdrk9r8vH1be8RSTIFONvtFhMmhLbGfQiS+j9a6iUKPgMVxQycF1mFCJlPtaXktDTBWoJXqDVp+z6m7evHeBoNIr/lxzL0yI2Ua49UzyRfbu+uB1hzqg7xGJqviEPjhcBILGpoR2K6opFBzPEGYy0Qwb2q2BcAGGtWuqOhv63qEsgDyoRJSZF82ueMi+piSc6VioBHGPA/qrKeY+DslIE7DBFVnGWvdT2mEhhWjiM9ykOyg==
c1001245-8e2b-47cc-940d-14f651ba084d	cf4bb6c6-d2fe-46ce-b531-227f4d777952	privateKey	MIIEpAIBAAKCAQEAiAelB6ltM5Di2/tVNbblnI0C5cP8//5W3nlKXVk0D6xhdkipqE2p9smKkVoMJ8ta87ttYw8gjqSfYeiYnwb8OAPWyzQBhZ711GhNvuvWqFiApqrQuArICXJNXYULMDsfaedqdPAG9vY7zQR8tiJHzja/1o38cskd2gmNl6xAWOcg+vmpjWxsiv6CY3iP4/mH+vIOPfEJEuvtnEiR0OdbMBgDZ4/A+eTHguGdaBmSJMdP5yp+NGVSADUTcc92WSsQM5QnVqtv0M3sefFiKsvUr73+npGbRgXKFYeSqpySt7GXJIriAa2FVolZsfcHTQNOHeSaaRw9zTtJdzk6HrAkDwIDAQABAoIBACR8OG1nqhyMnex26xHvLoLg54gNG0zmQRKG4cVL6cTSbYm2T5sOyamhwQLfbic2SfzZpqtNIWRhD0bJhjYRP5Eepnv2RPo7+p+wIjo1M2wP4OHTKwxSB/lQqSOOTcPv96sGIO2ge529yahhrbmEVFIhKS85Ah8fhlw2971YvCGb6IS28mBKzOFzrw21CHzt19qEk+HHr0F4IAQXA7CF/bAhw/bhmjNJXjo8ga43T0n4II8CjEqvioySgi1IVOKP5SMDF2tCJ9KHvR64YrW6DTQCzwjdUryYsR1GXeSHkPddZmHrsHAxLdXvFuXnM1apGSOO2GjmEwjSwvkP+NnXp5ECgYEAvX6DMAEtdI78pjS33vbN8ehgOhfEhmOZtJWr17UH7k5GeSjN/j/fT8/jq+CniaxfYAdeSmmW1FLyxFsHpGcGqxcQ/I/oi42OCKzA16O9tbEtpc5xBUnkldA/VdJh7INZcjJ3sibnCEf6gZyJmh4G+JV4vij385mvYQA1F/3FwnMCgYEAt8WFmujiAZ8zDHwOKrzI8yEKJdiVwvO4nN8DX/dwawQjcdO4ZSCsHK6ct7rer2jU1hvt8SGFZHrh6m2SkqsW2usNBTnoZFNVkM+kvQDpq1Qyr/d5HA8hCJv4/o6wxJIZjasPvqNwY0NSvgeIQ4iTL/ptBqJwfOYhCvu8Tn3/xPUCgYBSNKMW3Tvp9+n09KPbzzfyvPuZ2BvCrUzOAaxF7Nwe7sg14ZTTusPW7Pn444HrAONzVl76ayoqvD1jH5aGJMfIyz3sQ0X/3I4Eh2U1Z2xyeQWzi4aOY8sNjwUa5yTiJO1V1D0HBUdu2UL8nXs4Z9RgXP+/hyhh/ocNzrg5yzbSrwKBgQCa6Lmy11SMIXKat4gJppGNwPAY7vVvHJsmQSdLIf11eEuYi+wH8v6iPt6EUdWc7zVaNrjgZm1XQe5l+m9viyD88N5M5X9r8oNSSnaHi9ltPtBrXKSOboJeC3xcuFNxn+ZCcUwYWxVF115MKXVH2DyaWPLGgO9pmWOJKqKVV8jecQKBgQCnwBSWHdNFfm3Waq6iTskrsCXEP/s9/+Vx1kBD8PNOVCpi/yNKFX9My1wFR5pc4a6zc50B/tnV3lEFfMtMZmOCukhVXUzFv5bInCzmEQMWI/VwgJv33WUAVUjR3gd6j2rd9Yo+0mYkzaf31+rI7zBPTJ0E4UDEmYxVWrri4TdQeQ==
264ba34c-744a-44ce-8282-ff6caf886460	cf4bb6c6-d2fe-46ce-b531-227f4d777952	priority	100
18e02757-fadd-41fd-86be-2ecb1b27df01	271d4101-56b5-494d-82fc-20fcefcbd521	max-clients	200
696d5e2b-c48e-434b-8478-2555b27ca3b2	b84f170f-17a8-49cc-8473-1dacaaffe136	allow-default-scopes	true
59037057-e42e-4a8b-a34b-deb62442a2bb	12025d44-f0d8-4814-8f05-1717bca89715	certificate	MIICwTCCAakCBgGSzK9aajANBgkqhkiG9w0BAQsFADAkMSIwIAYDVQQDDBloZWFydGZ1bGwtbWluZC1lY29zeXN0ZW1zMB4XDTI0MTAyNzA2MzMxN1oXDTM0MTAyNzA1MzQ1N1owJDEiMCAGA1UEAwwZaGVhcnRmdWxsLW1pbmQtZWNvc3lzdGVtczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJTfelx3zx9Yw24xeVYKZlNqJrTX1mvxSX3UvjmH3JfVfjgFHlGMdx3okGdBfZOpNm/k/H/xSoAcC+8WKOC4Ug5l0LffY0Y7ognio6sXe6OOUq4xLZDCnmCS9O5I4q0IDcoY9T7zkTj2etmGf6txO4W6AA2qCwRh2vFf7Yqa4dpU90LXAmLAZvUroewG4WSU9vU4U2IQx0gDSMo+EzKX7rkYHzLizpsoHtqpRNoTrvHEHUwXx8avIlM4ec/IlnuFyqWfGdh8+PMupTovmbXvIbdEJqLL6CcXJ7aPPiQnAsYNoMVHdAx+mR5QbO4YvJWqzsVMex+O87ydFLGgN6ckdAECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAUDwI3GIY4Yp3va8e3GtrLsIG4BuPEiCbWcSPHWCBPSiKBv+z/Y0y9qRnSx0S3xWEGLG96oKiYQRiSuk4ZW5PqYuVA8nZ19XTQ/oLgjOOrFVJVxjR83YkljNplfh30TeddwgMhaxGCeQi0qeUgdHWavHRy6+LYuMWKPw1tpJ+AQPEJKjJI5HpsYIurdP1LigbkvvOMz4CQKNailS2YZnSV4PN14HbkUEQqhu+1aeScOU0UV5lhnyK56GUAYlOfQmQbfvGXrtkdhaRkqz/Iian2HXSvG2L34EM057B6CLowoNLB6+SqO01RwqnSbIT/XKk0JNvXTJXuJFzOQJ7sa7Fvg==
98ba5142-28d5-42e1-9284-0f000be82ffd	12025d44-f0d8-4814-8f05-1717bca89715	algorithm	RSA-OAEP
ee97dae7-d807-41c0-b912-4ecf90ce3d0f	12025d44-f0d8-4814-8f05-1717bca89715	priority	100
a6ce3f4f-b5ef-4052-878d-d9b94c74637d	12025d44-f0d8-4814-8f05-1717bca89715	privateKey	MIIEogIBAAKCAQEAlN96XHfPH1jDbjF5VgpmU2omtNfWa/FJfdS+OYfcl9V+OAUeUYx3HeiQZ0F9k6k2b+T8f/FKgBwL7xYo4LhSDmXQt99jRjuiCeKjqxd7o45SrjEtkMKeYJL07kjirQgNyhj1PvOROPZ62YZ/q3E7hboADaoLBGHa8V/tiprh2lT3QtcCYsBm9Suh7AbhZJT29ThTYhDHSANIyj4TMpfuuRgfMuLOmyge2qlE2hOu8cQdTBfHxq8iUzh5z8iWe4XKpZ8Z2Hz48y6lOi+Zte8ht0QmosvoJxcnto8+JCcCxg2gxUd0DH6ZHlBs7hi8larOxUx7H47zvJ0UsaA3pyR0AQIDAQABAoIBAA18z7en7R5washFeDI43/tnrxkMQvNlmVxqlU9eBTjGUVie8he+S55sjwSj1M43cuShUNUAldjUcapYDh0J5flC9S1rcjGPPod5vo1GI9/2CXyZnQCz+ShTuBgMh2jYxXMNXs60v2/zOL8TZeaw7A0aBF44jSX4/Z6Hq9w2WwbuL0r54pV/m9hwNbBeGQW7oIVm+v0DwCmCnFKVqP/jDjrYJ142UnCDty21eIFIMz+EAUAlS9Ck2cMLdm7tAcoEOrrk2gO6+scKVzDQuQHilfaoa/SyWtHfzBn0LZ7Wv04rFlNF4a78szsYs/tj8f07XxM0XlRLlQEAZ6BJGS/wnicCgYEAzYSky4WpMm+WY1YVp8woFmMGvyCsoLk4l/CgADqBzJjsEGc9jmRjEcZqwga9fiZRLWWZrNMtJYv9cwjT6u0JyqfF8coYNYdMmp2SzXnAhFxY9FRjDqV0kwi5HQmjvZ4KU1vnLUy1m0aXWykVfFJWgwgLcWTt8eX+I4yP47Y6n0cCgYEAuXDhwfXPKlgt/4wOcM/+v6EcliGVQHsN9WrVCwij+q3Vg+dcW2fOqFegsrHZMlZr++bQXzTBoWCVcPRhfDFgAdca7v0rSihLO+hvcpe8BPkzpc7yJrIBhdYduEnRBfPC3bnoTv1slcUZiaCgSK87iL6t52bb2Or5t32ir4RxRncCgYBcGTokfnRxRrJVN8milYnNZnkqg4D40ag75rg9AfsS7eC0BR//xJrk508GPjEC7DbqqiIw4b3UmqRsvaMCH1GJAKBjF1a7/jLlAwI7lHkil6PBcmOlt53DGmCiU6SOH9muu3ugwESOHhdL4eBgAyIDvEIsgbdj9NZrpd0BhbNFlwKBgFl+TLVad5wr6icF5II1HvBERJN/qZPwzw+9ewtUJC76bay2ny/NrUI45+jVQ8izRHHRNoZ742aKQhS9G77f5UF+GhV0QMwNHiHPTtmyuJ591ZsTgHGEPo/kgXtKxIFm3og7DA3y59Bvyp9M0Y3CY6zeuPaQAVFyNQmErFqgRDqJAoGAWAFqEsufxiEJpZhaJFwodZDQH9DFxmGIGVMBczv5DpKJ5er4yxvx8i/mxWgcEreFlU1rOweQXf44Zh1fi6kKT8lu0eq3vSmAZxGFCZ1XxaNCvrkyvltOTE5qeX+00uCYmFQCMZGVuMJDMejXUtJmsQ46NKRfRbfwLJ5JZZF6tPY=
92e0f58a-e2ae-4272-a69c-ad140c6b2a58	4e65bd13-9ab0-43eb-a501-975af50fe898	secret	ca_yeUduR46N-E4uEjT45A
847659c1-a859-4786-92e0-d9a823669bf2	4e65bd13-9ab0-43eb-a501-975af50fe898	kid	01c78ad8-e6c4-4e04-a914-0674a0740a6e
adb97b34-c3c8-42b6-8139-fb86b166c953	4e65bd13-9ab0-43eb-a501-975af50fe898	priority	100
2787c53f-f106-42da-843d-d364ad45a5a8	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	saml-user-property-mapper
9cbbef21-56ee-46e6-9400-526aba9c58f6	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	saml-role-list-mapper
ddfd79f4-6989-4457-910e-adb0c7d87b36	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
149e9f4a-849d-4f85-b3fa-714799fd13b1	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
398f9ff4-acb3-4344-a838-23422f02c416	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	saml-user-attribute-mapper
2ff7f7d9-f9a4-411e-842d-c888ebc29ead	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	oidc-full-name-mapper
9a9504b5-5dcd-4824-bd7d-69eb100c1059	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	oidc-address-mapper
1a198dd1-472f-44fb-881c-b38f967fbd7d	b0dcac3f-e550-40a3-a96b-0e550ddc1f9e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
41a8bea2-56e9-4b92-898a-c8715449d989	85fcc3fd-0c6c-4464-b7d3-96058c029870	host-sending-registration-request-must-match	true
4842a8e9-419d-4fd5-bc6d-1bcbb4df5e71	85fcc3fd-0c6c-4464-b7d3-96058c029870	client-uris-must-match	true
30b43701-e5e9-40b1-a5c3-a8a683529f3c	eceb9132-e8c8-48d5-a3c1-2595b6455ff9	priority	100
07945626-cfef-492d-bb19-bce05b3eba18	eceb9132-e8c8-48d5-a3c1-2595b6455ff9	secret	zNd7Cym9ehMjNxHhouGDjIL5P-e7KrALmQkC3ji8atBgn2LUT5h5FrmW7ZpIIJ_Di4Et5OtAKjOxdwrLR-wcPY-H5M1KlsVEVcg0OUIlPVG8cd8q2743nAl94VvQkXhJ8Kbdl7ku5HIzijV-3KLon7rrvBizF6wDZoFWQqYbPZk
7a6322c2-7833-432b-bce0-880b49d59c1b	eceb9132-e8c8-48d5-a3c1-2595b6455ff9	algorithm	HS512
4c68dd88-5a97-452b-ad91-96240d71e0e3	eceb9132-e8c8-48d5-a3c1-2595b6455ff9	kid	47d150a1-a9c3-449f-902e-64379cb59063
0f713fc5-9e7d-4a80-8e51-4d82fb85ffe4	2e4ae263-a222-4f5e-a3c9-5f276ac4f2df	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"picture","displayName":"Profilpicture","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.composite_role (composite, child_role) FROM stdin;
d1fb81f9-635b-43eb-a999-ab905cce9295	e38dea8c-944e-4f57-801e-5730c05427a3
d1fb81f9-635b-43eb-a999-ab905cce9295	a4febe02-d874-4ec4-b726-81297eb5b171
d1fb81f9-635b-43eb-a999-ab905cce9295	19d7d028-794a-4c36-a4cd-e327e54b425e
d1fb81f9-635b-43eb-a999-ab905cce9295	e5f26260-37db-4dca-ac03-7d1b49d6eaf9
d1fb81f9-635b-43eb-a999-ab905cce9295	8b4c7182-52c1-4ef5-a4a5-0a9190e2707a
d1fb81f9-635b-43eb-a999-ab905cce9295	4b92914a-9bc2-4f0b-a5bf-a2654b5612ef
d1fb81f9-635b-43eb-a999-ab905cce9295	e823f359-03e4-4ffa-adbc-4a5a9cc2544e
d1fb81f9-635b-43eb-a999-ab905cce9295	f0d5a5ce-1b3e-46df-84c8-7ea6e44bf1f0
d1fb81f9-635b-43eb-a999-ab905cce9295	bd217b82-9afc-4f4a-88bf-081d7e6afe78
d1fb81f9-635b-43eb-a999-ab905cce9295	59f32ed0-d785-44c1-a7bd-13619e5be6b0
d1fb81f9-635b-43eb-a999-ab905cce9295	4a9d7645-5ffd-41fa-9205-8672bb0bf2f9
d1fb81f9-635b-43eb-a999-ab905cce9295	e7d6b67c-3ed5-4ac4-87d9-b12a0bf1fe9d
d1fb81f9-635b-43eb-a999-ab905cce9295	550d465b-59af-4476-9d84-4b91779332bd
d1fb81f9-635b-43eb-a999-ab905cce9295	fa0647f2-c702-4140-b71c-f9f8b6647827
d1fb81f9-635b-43eb-a999-ab905cce9295	f68612c2-3c81-4e40-b138-f3b213ea00c8
d1fb81f9-635b-43eb-a999-ab905cce9295	646212a3-aa2d-4f83-830a-97d6175cec31
d1fb81f9-635b-43eb-a999-ab905cce9295	eb87501c-cd44-4227-a678-d37be100c890
d1fb81f9-635b-43eb-a999-ab905cce9295	c1130730-0678-440e-a238-799e3b736f15
8b4c7182-52c1-4ef5-a4a5-0a9190e2707a	646212a3-aa2d-4f83-830a-97d6175cec31
9da3e296-2ec9-475e-9b0d-c6014bfd4c44	eb35da88-eae9-48a3-a31e-6e7d4a0e1007
e5f26260-37db-4dca-ac03-7d1b49d6eaf9	f68612c2-3c81-4e40-b138-f3b213ea00c8
e5f26260-37db-4dca-ac03-7d1b49d6eaf9	c1130730-0678-440e-a238-799e3b736f15
9da3e296-2ec9-475e-9b0d-c6014bfd4c44	272b7ba3-0ede-47aa-a8a0-cee2a986a5e7
272b7ba3-0ede-47aa-a8a0-cee2a986a5e7	77e19fdb-f87b-47b8-aaed-23e9b9d7f677
a9967f5e-1856-4c82-bd84-10271bcd7368	5f67d52d-59ef-4fc0-8fa3-448b57ef8cae
d1fb81f9-635b-43eb-a999-ab905cce9295	7349abd4-9c2c-47a2-be7c-9e3182828eea
9da3e296-2ec9-475e-9b0d-c6014bfd4c44	b04ce985-00d1-41f3-aec8-0e8150d9f30b
9da3e296-2ec9-475e-9b0d-c6014bfd4c44	40b579ae-5fa2-4c4b-969c-58258473dbfe
d1fb81f9-635b-43eb-a999-ab905cce9295	48ba143c-920d-4e6f-9269-95ce2cd68429
d1fb81f9-635b-43eb-a999-ab905cce9295	3d1741fc-e2b4-4b90-accb-988a9f714f22
d1fb81f9-635b-43eb-a999-ab905cce9295	43dc5f01-17cb-408c-a7a0-036e4d73568e
d1fb81f9-635b-43eb-a999-ab905cce9295	9536f65d-3baa-4c30-b901-bb3784386c48
d1fb81f9-635b-43eb-a999-ab905cce9295	1f692249-0214-4051-97e5-21d2a602ca43
d1fb81f9-635b-43eb-a999-ab905cce9295	6f56fd4e-58e1-4836-849e-e8408f8f4f32
d1fb81f9-635b-43eb-a999-ab905cce9295	b1488019-b041-45ce-a5f2-b62b94ad8710
d1fb81f9-635b-43eb-a999-ab905cce9295	7adf4073-297f-4846-a439-d2b820df8cb1
d1fb81f9-635b-43eb-a999-ab905cce9295	1fb3d34a-8a5a-4fa8-b9da-9911109f9e2f
d1fb81f9-635b-43eb-a999-ab905cce9295	e316b8b0-e70d-4eb5-b8dd-e1238f50f55f
d1fb81f9-635b-43eb-a999-ab905cce9295	8b7824f7-ec41-4ebd-b71f-a2ae6dc7350a
d1fb81f9-635b-43eb-a999-ab905cce9295	189bafb3-c872-4bd7-b760-98f9d3959350
d1fb81f9-635b-43eb-a999-ab905cce9295	910bcebc-fadf-4bb7-88c8-dcc0eb4b6c9a
d1fb81f9-635b-43eb-a999-ab905cce9295	79f13cd6-1256-4f8e-a993-94c60abe855e
d1fb81f9-635b-43eb-a999-ab905cce9295	cc13c810-39d6-4c18-b375-d19badf3a7e3
d1fb81f9-635b-43eb-a999-ab905cce9295	ee109e23-37d9-47f7-9751-e85c9e74a753
d1fb81f9-635b-43eb-a999-ab905cce9295	602b318e-7fb7-4d96-89b0-2ef51c716ccd
43dc5f01-17cb-408c-a7a0-036e4d73568e	602b318e-7fb7-4d96-89b0-2ef51c716ccd
43dc5f01-17cb-408c-a7a0-036e4d73568e	79f13cd6-1256-4f8e-a993-94c60abe855e
9536f65d-3baa-4c30-b901-bb3784386c48	cc13c810-39d6-4c18-b375-d19badf3a7e3
15faf388-dafd-4caf-af9d-53071e97b62f	02c1fd67-a827-46d9-b2a6-33e58814cf3e
38a9a276-661d-4383-aa70-bcb5c335fb37	79f3ac8e-13c4-4ce5-b606-423d7ebaf2c0
8743c44d-92c6-4a7d-8449-e594521241cb	5ddddbd3-d105-4e49-85a2-eaaa82b145cf
97c70393-a1db-48f9-b95c-265aa571cf20	799f58fd-a439-46c8-8164-3048fdd18b07
97c70393-a1db-48f9-b95c-265aa571cf20	b047d35d-97e1-483e-92f7-535f163c76fc
97c70393-a1db-48f9-b95c-265aa571cf20	8f549ea5-cc37-496d-b85a-fc8d3620b0b6
97c70393-a1db-48f9-b95c-265aa571cf20	f5b01b06-5032-4689-b67e-ba000e7ccc35
97c70393-a1db-48f9-b95c-265aa571cf20	79f3ac8e-13c4-4ce5-b606-423d7ebaf2c0
97c70393-a1db-48f9-b95c-265aa571cf20	ed74b7d3-576f-4c40-9907-65a9b0010124
97c70393-a1db-48f9-b95c-265aa571cf20	fe78251b-a519-4c3f-9c04-7b02a74bba83
97c70393-a1db-48f9-b95c-265aa571cf20	d290ad47-dffa-4b93-a979-94a441b15344
97c70393-a1db-48f9-b95c-265aa571cf20	80a3ab47-9f8e-4ec9-b834-53385885144e
97c70393-a1db-48f9-b95c-265aa571cf20	5a543e62-8b31-4897-a900-47f1e2588405
97c70393-a1db-48f9-b95c-265aa571cf20	d7bd61dc-9d2d-4bc6-a5ec-6602a4c8bbe2
97c70393-a1db-48f9-b95c-265aa571cf20	3e553391-4025-4202-bce4-dce3fa73fcfa
97c70393-a1db-48f9-b95c-265aa571cf20	d1e09978-fff1-4ce8-845d-6b8336223596
97c70393-a1db-48f9-b95c-265aa571cf20	cdc4f95f-694f-4081-9cc6-ef733c3240d6
97c70393-a1db-48f9-b95c-265aa571cf20	dbb39cb2-fa69-494e-9803-0311d20dfdc2
97c70393-a1db-48f9-b95c-265aa571cf20	dfb2d59a-ab8e-414c-b311-a4f8b76dcbaf
97c70393-a1db-48f9-b95c-265aa571cf20	38a9a276-661d-4383-aa70-bcb5c335fb37
97c70393-a1db-48f9-b95c-265aa571cf20	1ecf6c28-13f0-4b17-832f-6af16775bb89
a068e2db-1dd1-4728-a059-f6ffa5b9509e	f01045e9-ea5f-4da5-a4fb-4245e9e228a6
a068e2db-1dd1-4728-a059-f6ffa5b9509e	99528dfc-0bd6-467b-abd0-ed77614fc3ec
a068e2db-1dd1-4728-a059-f6ffa5b9509e	4bcb9852-3ccb-46d3-b2a0-a54ef1194650
a068e2db-1dd1-4728-a059-f6ffa5b9509e	8743c44d-92c6-4a7d-8449-e594521241cb
fe78251b-a519-4c3f-9c04-7b02a74bba83	3e553391-4025-4202-bce4-dce3fa73fcfa
fe78251b-a519-4c3f-9c04-7b02a74bba83	cdc4f95f-694f-4081-9cc6-ef733c3240d6
d1fb81f9-635b-43eb-a999-ab905cce9295	667e772a-7f57-49d4-a897-d2d60754e7ee
a068e2db-1dd1-4728-a059-f6ffa5b9509e	9a5094e6-aa1a-4000-92f3-14529adde708
a068e2db-1dd1-4728-a059-f6ffa5b9509e	b4580b8f-cebc-476b-a0cc-6507bccb9ff9
a068e2db-1dd1-4728-a059-f6ffa5b9509e	bf8039b0-2383-46a2-8984-70181183fe9d
ea99cd2e-298f-42ac-9e84-78c9ac306471	f01045e9-ea5f-4da5-a4fb-4245e9e228a6
ea99cd2e-298f-42ac-9e84-78c9ac306471	9a5094e6-aa1a-4000-92f3-14529adde708
ea99cd2e-298f-42ac-9e84-78c9ac306471	b4580b8f-cebc-476b-a0cc-6507bccb9ff9
ea99cd2e-298f-42ac-9e84-78c9ac306471	8743c44d-92c6-4a7d-8449-e594521241cb
ea99cd2e-298f-42ac-9e84-78c9ac306471	bf8039b0-2383-46a2-8984-70181183fe9d
0490d337-ce56-49e4-9271-6e0a0911d121	9a5094e6-aa1a-4000-92f3-14529adde708
0490d337-ce56-49e4-9271-6e0a0911d121	b4580b8f-cebc-476b-a0cc-6507bccb9ff9
0490d337-ce56-49e4-9271-6e0a0911d121	bf8039b0-2383-46a2-8984-70181183fe9d
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
eee3eebd-390a-43e8-8cf9-e90d8a4e93c6	\N	password	e1de8244-6459-4324-9899-18c439bd2bb2	1730011051696	My password	{"value":"feelR1CpKT6vb62Im4koa1OQATrDuLwM+WIbuKfrIKs=","salt":"3L/YQUKpxMBBPgIQ1fKUoA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
3e7c21b2-3e75-49d0-9255-38d86d7d8bec	\N	password	d66621eb-6fff-4972-a0cd-1c23818b9fb3	1730019495801	My password	{"value":"jVkTjjFvyHn1q+++engZjTlCK5gdi7yekkjOuCnBdN0=","salt":"QP2JT1N0qubVIwExb8sCZg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
07ffc61c-d82e-4ad9-aeab-6967cb370cf5	\N	password	ff27cc46-149a-4854-9da1-468e391a3176	1730365452942	My password	{"value":"Gw+ADruR20qrEyK4Wa9W+b0/BWqxkqJAzSIVvBXcTHo=","salt":"+wJqWrrpR8JbZONsTjTv7A==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
7af09fec-c80a-470f-a4ac-dccbfbea2ec4	\N	password	1d2fcd71-0a16-4420-a90b-ddfbf7822168	1730365510355	My password	{"value":"HMn+ENRFBZeUH5ew0kNfEcpw4iIOTfucj95dZensNeM=","salt":"S2LUbtDhQ7dYXnygEtSTgw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
4ce4c612-6cf9-4617-b9e7-db5f3a3097ee	\N	password	f5582653-d8b6-40ec-8fd3-d75c8c89be07	1730618140027	\N	{"value":"hUIMaVNIPbW4xCnQCUqs/MYb78vlZgs6qBXTp7e+yF4=","salt":"ZCFPjrOOiPwoOOjsJRo4yg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
fa14abcb-9223-4fd5-94c2-9d7958f91dae	\N	password	995c90fc-53da-4281-b872-c816c9813419	1733718197314	My password	{"value":"rnLUT3bXZqTQUBqaXcrmbUqfPP2LtkNZBhtj1h1/S6w=","salt":"QthiOuOc2ULwuDsQEGv5Ww==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog_custom_jpa; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.databasechangelog_custom_jpa (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
user-relationships-1	manuel	META-INF/jpa-changelog-custom-relations.xml	2024-12-10 13:11:29.850456	1	EXECUTED	9:17b966adb8dd63d96771f2ca4c0d0ff7	createTable tableName=RELATIONSHIPS; addForeignKeyConstraint baseTableName=RELATIONSHIPS, constraintName=FK_USER_RELATIONSHIP, referencedTableName=USER_ENTITY; addForeignKeyConstraint baseTableName=RELATIONSHIPS, constraintName=FK_RELATED_USER, re...		\N	4.29.1	\N	\N	3832689559
friends-requests-1	manuel	META-INF/jpa-changelog-friends-requests.xml	2024-12-10 13:11:29.966162	2	EXECUTED	9:d65d6c74daff72f1d506862aef8ecfa8	createTable tableName=FRIENDS_REQUESTS; addForeignKeyConstraint baseTableName=FRIENDS_REQUESTS, constraintName=FK_USER_FRIENDS_REQUEST, referencedTableName=USER_ENTITY; addForeignKeyConstraint baseTableName=FRIENDS_REQUESTS, constraintName=FK_RELA...		\N	4.29.1	\N	\N	3832689559
\.


--
-- Data for Name: databasechangelog_example_en; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.databasechangelog_example_en (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
example-1.0	erik.mulder@docdatapayments.com	META-INF/example-changelog.xml	2024-12-18 06:08:12.234357	1	EXECUTED	9:791f8d6f8d47367ce4d7215dc59704da	createTable tableName=EXAMPLE_COMPANY; addPrimaryKey constraintName=PK_COMPANY, tableName=EXAMPLE_COMPANY		\N	4.29.1	\N	\N	4498492100
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	95e52084-9f72-418b-8354-b2be90c8057e	f
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1e18cda9-723d-4c61-a0b7-c73f93c9ef0a	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	92963282-93b8-4146-b943-92938929c255	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	d0dcc7cf-dbf8-4926-955c-d3b8c732528f	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	32f9707e-06f2-4c76-9ab5-419fe1da1107	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64	f
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	6bb6342d-4413-4217-bcd9-cc398ab3ecdd	f
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	19f16ba1-df56-4156-babf-9b088b3b44f9	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	955bf1e3-e373-4abb-90b5-9b72e4a7a58e	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	d1204b7b-5ecf-4be6-a33b-0d1845ccb082	f
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	94bd7db0-c724-4481-9198-8b06e78614f4	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	59bcb9aa-5864-4ed5-9acc-6eb09283af11	t
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	6d0c424a-24e3-4d76-b1c9-d214f09c13f5	f
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	ff4c9fb7-c7a0-45ae-b03b-d23c82f5144d	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d75af507-a2e9-4e6e-bd46-193169812613	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f54a3ac4-e891-40bf-ae03-41a2524b74d7	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	aa3785a5-bbd9-4690-9566-f830dd2cb090	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	70dc2523-9cc5-45df-b7f0-a0eab7ed68f0	f
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	12a0bd96-8f01-47c7-a1ad-164b61c2d62c	f
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2df458fa-5cb1-40a6-b17d-992edf1927f6	f
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8	f
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fdd6bffe-6613-4ed5-ac11-03ffca40384e	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	b416fe2a-d004-42bf-95aa-323ddb13dd0a	t
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	df5454a7-d0b0-4eea-b0b5-291c10620733	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: example_company; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.example_company (id, name, realm_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: friends_requests; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.friends_requests (id, user_id, related_user_id, created_at) FROM stdin;
24d46f23-2b98-4956-8cec-e6c7c9a54afe	e1de8244-6459-4324-9899-18c439bd2bb2	d66621eb-6fff-4972-a0cd-1c23818b9fb3	2025-01-06 16:33:42.927839
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
8f549ea5-cc37-496d-b85a-fc8d3620b0b6	2c726557-b7d6-43da-a82d-1d9f593cf394
3e553391-4025-4202-bce4-dce3fa73fcfa	2c726557-b7d6-43da-a82d-1d9f593cf394
fe78251b-a519-4c3f-9c04-7b02a74bba83	2c726557-b7d6-43da-a82d-1d9f593cf394
bf8039b0-2383-46a2-8984-70181183fe9d	2c726557-b7d6-43da-a82d-1d9f593cf394
ee82eea5-a77e-4957-ac7d-d101ebf8d6b6	2c726557-b7d6-43da-a82d-1d9f593cf394
9a5094e6-aa1a-4000-92f3-14529adde708	2c726557-b7d6-43da-a82d-1d9f593cf394
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	2c726557-b7d6-43da-a82d-1d9f593cf394
bf8039b0-2383-46a2-8984-70181183fe9d	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
9a5094e6-aa1a-4000-92f3-14529adde708	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	ac61b8f5-26a9-464a-82cd-c23e956e91ca
bf8039b0-2383-46a2-8984-70181183fe9d	ac61b8f5-26a9-464a-82cd-c23e956e91ca
38a9a276-661d-4383-aa70-bcb5c335fb37	2c726557-b7d6-43da-a82d-1d9f593cf394
552bf6cf-ab99-41b7-a52f-b8a0fa9ab072	2c726557-b7d6-43da-a82d-1d9f593cf394
15684013-5798-4086-a1a8-be405032793f	2c726557-b7d6-43da-a82d-1d9f593cf394
7c1e8490-c4f0-42c2-a505-598d10ae184a	2c726557-b7d6-43da-a82d-1d9f593cf394
80d7cb45-1fb6-450e-aed0-81ec7f8e75d7	2c726557-b7d6-43da-a82d-1d9f593cf394
d2460f21-4313-4d9b-bb20-d6d91efeb98a	2c726557-b7d6-43da-a82d-1d9f593cf394
425b2a0d-c498-4874-bef4-d5d28b0ce805	2c726557-b7d6-43da-a82d-1d9f593cf394
aaa2f021-de84-4adf-9365-ed62bec2a092	2c726557-b7d6-43da-a82d-1d9f593cf394
aaa2f021-de84-4adf-9365-ed62bec2a092	ac61b8f5-26a9-464a-82cd-c23e956e91ca
7c1e8490-c4f0-42c2-a505-598d10ae184a	ac61b8f5-26a9-464a-82cd-c23e956e91ca
ee82eea5-a77e-4957-ac7d-d101ebf8d6b6	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
15684013-5798-4086-a1a8-be405032793f	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
7c1e8490-c4f0-42c2-a505-598d10ae184a	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
425b2a0d-c498-4874-bef4-d5d28b0ce805	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
552bf6cf-ab99-41b7-a52f-b8a0fa9ab072	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
aaa2f021-de84-4adf-9365-ed62bec2a092	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
552bf6cf-ab99-41b7-a52f-b8a0fa9ab072	ac61b8f5-26a9-464a-82cd-c23e956e91ca
ee82eea5-a77e-4957-ac7d-d101ebf8d6b6	ac61b8f5-26a9-464a-82cd-c23e956e91ca
e5f26260-37db-4dca-ac03-7d1b49d6eaf9	981cb719-795e-4aa9-803f-2b4a8a05e72e
19d7d028-794a-4c36-a4cd-e327e54b425e	981cb719-795e-4aa9-803f-2b4a8a05e72e
4b92914a-9bc2-4f0b-a5bf-a2654b5612ef	981cb719-795e-4aa9-803f-2b4a8a05e72e
8b4c7182-52c1-4ef5-a4a5-0a9190e2707a	981cb719-795e-4aa9-803f-2b4a8a05e72e
f0d5a5ce-1b3e-46df-84c8-7ea6e44bf1f0	981cb719-795e-4aa9-803f-2b4a8a05e72e
e823f359-03e4-4ffa-adbc-4a5a9cc2544e	981cb719-795e-4aa9-803f-2b4a8a05e72e
f68612c2-3c81-4e40-b138-f3b213ea00c8	981cb719-795e-4aa9-803f-2b4a8a05e72e
eb87501c-cd44-4227-a678-d37be100c890	981cb719-795e-4aa9-803f-2b4a8a05e72e
c1130730-0678-440e-a238-799e3b736f15	981cb719-795e-4aa9-803f-2b4a8a05e72e
646212a3-aa2d-4f83-830a-97d6175cec31	981cb719-795e-4aa9-803f-2b4a8a05e72e
59f32ed0-d785-44c1-a7bd-13619e5be6b0	981cb719-795e-4aa9-803f-2b4a8a05e72e
bd217b82-9afc-4f4a-88bf-081d7e6afe78	981cb719-795e-4aa9-803f-2b4a8a05e72e
550d465b-59af-4476-9d84-4b91779332bd	981cb719-795e-4aa9-803f-2b4a8a05e72e
e7d6b67c-3ed5-4ac4-87d9-b12a0bf1fe9d	981cb719-795e-4aa9-803f-2b4a8a05e72e
4a9d7645-5ffd-41fa-9205-8672bb0bf2f9	981cb719-795e-4aa9-803f-2b4a8a05e72e
a4febe02-d874-4ec4-b726-81297eb5b171	981cb719-795e-4aa9-803f-2b4a8a05e72e
fa0647f2-c702-4140-b71c-f9f8b6647827	981cb719-795e-4aa9-803f-2b4a8a05e72e
7349abd4-9c2c-47a2-be7c-9e3182828eea	981cb719-795e-4aa9-803f-2b4a8a05e72e
3d1741fc-e2b4-4b90-accb-988a9f714f22	981cb719-795e-4aa9-803f-2b4a8a05e72e
43dc5f01-17cb-408c-a7a0-036e4d73568e	981cb719-795e-4aa9-803f-2b4a8a05e72e
6f56fd4e-58e1-4836-849e-e8408f8f4f32	981cb719-795e-4aa9-803f-2b4a8a05e72e
1f692249-0214-4051-97e5-21d2a602ca43	981cb719-795e-4aa9-803f-2b4a8a05e72e
b1488019-b041-45ce-a5f2-b62b94ad8710	981cb719-795e-4aa9-803f-2b4a8a05e72e
9536f65d-3baa-4c30-b901-bb3784386c48	981cb719-795e-4aa9-803f-2b4a8a05e72e
ee109e23-37d9-47f7-9751-e85c9e74a753	981cb719-795e-4aa9-803f-2b4a8a05e72e
602b318e-7fb7-4d96-89b0-2ef51c716ccd	981cb719-795e-4aa9-803f-2b4a8a05e72e
79f13cd6-1256-4f8e-a993-94c60abe855e	981cb719-795e-4aa9-803f-2b4a8a05e72e
cc13c810-39d6-4c18-b375-d19badf3a7e3	981cb719-795e-4aa9-803f-2b4a8a05e72e
7adf4073-297f-4846-a439-d2b820df8cb1	981cb719-795e-4aa9-803f-2b4a8a05e72e
1fb3d34a-8a5a-4fa8-b9da-9911109f9e2f	981cb719-795e-4aa9-803f-2b4a8a05e72e
189bafb3-c872-4bd7-b760-98f9d3959350	981cb719-795e-4aa9-803f-2b4a8a05e72e
8b7824f7-ec41-4ebd-b71f-a2ae6dc7350a	981cb719-795e-4aa9-803f-2b4a8a05e72e
e316b8b0-e70d-4eb5-b8dd-e1238f50f55f	981cb719-795e-4aa9-803f-2b4a8a05e72e
910bcebc-fadf-4bb7-88c8-dcc0eb4b6c9a	981cb719-795e-4aa9-803f-2b4a8a05e72e
48ba143c-920d-4e6f-9269-95ce2cd68429	981cb719-795e-4aa9-803f-2b4a8a05e72e
667e772a-7f57-49d4-a897-d2d60754e7ee	981cb719-795e-4aa9-803f-2b4a8a05e72e
5fefcdb1-2a74-4e4a-919a-8f601066915b	981cb719-795e-4aa9-803f-2b4a8a05e72e
191a1e3c-81d8-4528-9b76-e0522764c3df	981cb719-795e-4aa9-803f-2b4a8a05e72e
eb35da88-eae9-48a3-a31e-6e7d4a0e1007	981cb719-795e-4aa9-803f-2b4a8a05e72e
4c84b836-c8ac-407d-9b6e-d3af82f899d3	981cb719-795e-4aa9-803f-2b4a8a05e72e
a9967f5e-1856-4c82-bd84-10271bcd7368	981cb719-795e-4aa9-803f-2b4a8a05e72e
5f67d52d-59ef-4fc0-8fa3-448b57ef8cae	981cb719-795e-4aa9-803f-2b4a8a05e72e
502b8c04-ae3b-4350-9441-5e08edc4bc30	981cb719-795e-4aa9-803f-2b4a8a05e72e
272b7ba3-0ede-47aa-a8a0-cee2a986a5e7	981cb719-795e-4aa9-803f-2b4a8a05e72e
77e19fdb-f87b-47b8-aaed-23e9b9d7f677	981cb719-795e-4aa9-803f-2b4a8a05e72e
7a7913d1-d521-4598-afc6-deb6652f72e8	2c726557-b7d6-43da-a82d-1d9f593cf394
8f4bdc48-4488-4cd7-a117-361fd3fc7e42	2c726557-b7d6-43da-a82d-1d9f593cf394
15faf388-dafd-4caf-af9d-53071e97b62f	2c726557-b7d6-43da-a82d-1d9f593cf394
f01045e9-ea5f-4da5-a4fb-4245e9e228a6	2c726557-b7d6-43da-a82d-1d9f593cf394
02c1fd67-a827-46d9-b2a6-33e58814cf3e	2c726557-b7d6-43da-a82d-1d9f593cf394
8743c44d-92c6-4a7d-8449-e594521241cb	2c726557-b7d6-43da-a82d-1d9f593cf394
b6c4b649-3d8e-4eb6-820f-d43ca1aa5c7f	2c726557-b7d6-43da-a82d-1d9f593cf394
5ddddbd3-d105-4e49-85a2-eaaa82b145cf	2c726557-b7d6-43da-a82d-1d9f593cf394
37ab42d7-b7b7-4db9-b460-2d1bede311d7	2c726557-b7d6-43da-a82d-1d9f593cf394
5727bec0-d9ed-498b-8277-dcf99336844a	2c726557-b7d6-43da-a82d-1d9f593cf394
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.jgroups_ping (ip, name, address, cluster_name, ping_data, coord) FROM stdin;
uuid://e18a3f01-267b-4223-a73b-1da2c52287d4	manuel-oman-48319	ISPN	172.17.0.1:7800	f	\N
uuid://35b53468-7a24-4921-994a-bda200ecfc8b	manuel-oman-12857	ISPN	172.23.0.1:7800	t	\N
uuid://59ef5ec3-83ce-4097-9208-310fe1de0698	manuel-oman-2312	ISPN	172.18.0.1:7800	f	\N
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
2c726557-b7d6-43da-a82d-1d9f593cf394	Admins	 	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	Users	 	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
ac61b8f5-26a9-464a-82cd-c23e956e91ca	Anonymous	 	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
981cb719-795e-4aa9-803f-2b4a8a05e72e	ROLE_ADMIN	 	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
00eebfef-553f-490c-8878-860221d94083	ROLE_USER	 	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
2bdb95db-a3d8-4197-85c9-fc4edfbacdbf	ROLE_ANONYMOUS	 	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
9da3e296-2ec9-475e-9b0d-c6014bfd4c44	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	${role_default-roles}	default-roles-master	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	\N
d1fb81f9-635b-43eb-a999-ab905cce9295	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	${role_admin}	admin	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	\N
e38dea8c-944e-4f57-801e-5730c05427a3	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	${role_create-realm}	create-realm	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	\N
a4febe02-d874-4ec4-b726-81297eb5b171	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_create-client}	create-client	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
19d7d028-794a-4c36-a4cd-e327e54b425e	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_view-realm}	view-realm	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
e5f26260-37db-4dca-ac03-7d1b49d6eaf9	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_view-users}	view-users	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
8b4c7182-52c1-4ef5-a4a5-0a9190e2707a	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_view-clients}	view-clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
4b92914a-9bc2-4f0b-a5bf-a2654b5612ef	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_view-events}	view-events	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
e823f359-03e4-4ffa-adbc-4a5a9cc2544e	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_view-identity-providers}	view-identity-providers	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
f0d5a5ce-1b3e-46df-84c8-7ea6e44bf1f0	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_view-authorization}	view-authorization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
bd217b82-9afc-4f4a-88bf-081d7e6afe78	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_manage-realm}	manage-realm	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
59f32ed0-d785-44c1-a7bd-13619e5be6b0	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_manage-users}	manage-users	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
4a9d7645-5ffd-41fa-9205-8672bb0bf2f9	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_manage-clients}	manage-clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
e7d6b67c-3ed5-4ac4-87d9-b12a0bf1fe9d	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_manage-events}	manage-events	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
550d465b-59af-4476-9d84-4b91779332bd	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_manage-identity-providers}	manage-identity-providers	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
fa0647f2-c702-4140-b71c-f9f8b6647827	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_manage-authorization}	manage-authorization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
f68612c2-3c81-4e40-b138-f3b213ea00c8	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_query-users}	query-users	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
646212a3-aa2d-4f83-830a-97d6175cec31	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_query-clients}	query-clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
eb87501c-cd44-4227-a678-d37be100c890	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_query-realms}	query-realms	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
a068e2db-1dd1-4728-a059-f6ffa5b9509e	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f	${role_default-roles}	default-roles-heartfull-mind-ecosystems	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N	\N
48ba143c-920d-4e6f-9269-95ce2cd68429	387ca314-961f-445b-a3ae-283df119b373	t	${role_create-client}	create-client	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
3d1741fc-e2b4-4b90-accb-988a9f714f22	387ca314-961f-445b-a3ae-283df119b373	t	${role_view-realm}	view-realm	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
43dc5f01-17cb-408c-a7a0-036e4d73568e	387ca314-961f-445b-a3ae-283df119b373	t	${role_view-users}	view-users	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
9536f65d-3baa-4c30-b901-bb3784386c48	387ca314-961f-445b-a3ae-283df119b373	t	${role_view-clients}	view-clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
1f692249-0214-4051-97e5-21d2a602ca43	387ca314-961f-445b-a3ae-283df119b373	t	${role_view-events}	view-events	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
6f56fd4e-58e1-4836-849e-e8408f8f4f32	387ca314-961f-445b-a3ae-283df119b373	t	${role_view-identity-providers}	view-identity-providers	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
b1488019-b041-45ce-a5f2-b62b94ad8710	387ca314-961f-445b-a3ae-283df119b373	t	${role_view-authorization}	view-authorization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
7adf4073-297f-4846-a439-d2b820df8cb1	387ca314-961f-445b-a3ae-283df119b373	t	${role_manage-realm}	manage-realm	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
c1130730-0678-440e-a238-799e3b736f15	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_query-groups}	query-groups	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
eb35da88-eae9-48a3-a31e-6e7d4a0e1007	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_view-profile}	view-profile	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
272b7ba3-0ede-47aa-a8a0-cee2a986a5e7	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_manage-account}	manage-account	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
77e19fdb-f87b-47b8-aaed-23e9b9d7f677	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_manage-account-links}	manage-account-links	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
4c84b836-c8ac-407d-9b6e-d3af82f899d3	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_view-applications}	view-applications	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
5f67d52d-59ef-4fc0-8fa3-448b57ef8cae	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_view-consent}	view-consent	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
a9967f5e-1856-4c82-bd84-10271bcd7368	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_manage-consent}	manage-consent	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
191a1e3c-81d8-4528-9b76-e0522764c3df	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_view-groups}	view-groups	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
502b8c04-ae3b-4350-9441-5e08edc4bc30	1247f9f5-471b-43e3-a468-0090c66d9756	t	${role_delete-account}	delete-account	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1247f9f5-471b-43e3-a468-0090c66d9756	\N
5fefcdb1-2a74-4e4a-919a-8f601066915b	ab28a178-3d71-46a1-a1ec-75aa16f8d563	t	${role_read-token}	read-token	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ab28a178-3d71-46a1-a1ec-75aa16f8d563	\N
7349abd4-9c2c-47a2-be7c-9e3182828eea	26888d86-910c-41fb-8ce5-29d04c068510	t	${role_impersonation}	impersonation	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	26888d86-910c-41fb-8ce5-29d04c068510	\N
b04ce985-00d1-41f3-aec8-0e8150d9f30b	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	${role_offline-access}	offline_access	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	\N
40b579ae-5fa2-4c4b-969c-58258473dbfe	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	${role_uma_authorization}	uma_authorization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	\N	\N
1fb3d34a-8a5a-4fa8-b9da-9911109f9e2f	387ca314-961f-445b-a3ae-283df119b373	t	${role_manage-users}	manage-users	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
e316b8b0-e70d-4eb5-b8dd-e1238f50f55f	387ca314-961f-445b-a3ae-283df119b373	t	${role_manage-clients}	manage-clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
8b7824f7-ec41-4ebd-b71f-a2ae6dc7350a	387ca314-961f-445b-a3ae-283df119b373	t	${role_manage-events}	manage-events	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
189bafb3-c872-4bd7-b760-98f9d3959350	387ca314-961f-445b-a3ae-283df119b373	t	${role_manage-identity-providers}	manage-identity-providers	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
910bcebc-fadf-4bb7-88c8-dcc0eb4b6c9a	387ca314-961f-445b-a3ae-283df119b373	t	${role_manage-authorization}	manage-authorization	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
79f13cd6-1256-4f8e-a993-94c60abe855e	387ca314-961f-445b-a3ae-283df119b373	t	${role_query-users}	query-users	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
cc13c810-39d6-4c18-b375-d19badf3a7e3	387ca314-961f-445b-a3ae-283df119b373	t	${role_query-clients}	query-clients	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
ee109e23-37d9-47f7-9751-e85c9e74a753	387ca314-961f-445b-a3ae-283df119b373	t	${role_query-realms}	query-realms	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
602b318e-7fb7-4d96-89b0-2ef51c716ccd	387ca314-961f-445b-a3ae-283df119b373	t	${role_query-groups}	query-groups	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
99528dfc-0bd6-467b-abd0-ed77614fc3ec	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f	${role_uma_authorization}	uma_authorization	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N	\N
4bcb9852-3ccb-46d3-b2a0-a54ef1194650	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f	${role_offline-access}	offline_access	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N	\N
799f58fd-a439-46c8-8164-3048fdd18b07	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_query-realms}	query-realms	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
b047d35d-97e1-483e-92f7-535f163c76fc	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_manage-events}	manage-events	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
8f549ea5-cc37-496d-b85a-fc8d3620b0b6	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_manage-users}	manage-users	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
f5b01b06-5032-4689-b67e-ba000e7ccc35	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_create-client}	create-client	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
79f3ac8e-13c4-4ce5-b606-423d7ebaf2c0	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_query-clients}	query-clients	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
ed74b7d3-576f-4c40-9907-65a9b0010124	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_view-authorization}	view-authorization	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
d290ad47-dffa-4b93-a979-94a441b15344	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_manage-realm}	manage-realm	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
fe78251b-a519-4c3f-9c04-7b02a74bba83	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_view-users}	view-users	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
97c70393-a1db-48f9-b95c-265aa571cf20	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_realm-admin}	realm-admin	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
80a3ab47-9f8e-4ec9-b834-53385885144e	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_view-identity-providers}	view-identity-providers	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
5a543e62-8b31-4897-a900-47f1e2588405	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_manage-clients}	manage-clients	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
d7bd61dc-9d2d-4bc6-a5ec-6602a4c8bbe2	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_manage-authorization}	manage-authorization	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
3e553391-4025-4202-bce4-dce3fa73fcfa	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_query-users}	query-users	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
cdc4f95f-694f-4081-9cc6-ef733c3240d6	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_query-groups}	query-groups	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
d1e09978-fff1-4ce8-845d-6b8336223596	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_view-events}	view-events	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
dbb39cb2-fa69-494e-9803-0311d20dfdc2	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_manage-identity-providers}	manage-identity-providers	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
dfb2d59a-ab8e-414c-b311-a4f8b76dcbaf	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_impersonation}	impersonation	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
38a9a276-661d-4383-aa70-bcb5c335fb37	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_view-clients}	view-clients	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
1ecf6c28-13f0-4b17-832f-6af16775bb89	8501b471-8e28-4e4f-aff9-39f0dceb1315	t	${role_view-realm}	view-realm	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	8501b471-8e28-4e4f-aff9-39f0dceb1315	\N
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	68ba78c7-2a44-4adb-b3c8-0907759d3266	t		ROLE_ANONYMOUS	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
8f4bdc48-4488-4cd7-a117-361fd3fc7e42	64817668-7035-42ef-8559-1af0d4635314	t	${role_read-token}	read-token	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	64817668-7035-42ef-8559-1af0d4635314	\N
5ddddbd3-d105-4e49-85a2-eaaa82b145cf	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_manage-account-links}	manage-account-links	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
37ab42d7-b7b7-4db9-b460-2d1bede311d7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_view-applications}	view-applications	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
f01045e9-ea5f-4da5-a4fb-4245e9e228a6	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_view-profile}	view-profile	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
5727bec0-d9ed-498b-8277-dcf99336844a	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_delete-account}	delete-account	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
15faf388-dafd-4caf-af9d-53071e97b62f	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_manage-consent}	manage-consent	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
7a7913d1-d521-4598-afc6-deb6652f72e8	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_view-groups}	view-groups	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
8743c44d-92c6-4a7d-8449-e594521241cb	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_manage-account}	manage-account	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
02c1fd67-a827-46d9-b2a6-33e58814cf3e	fef5fa01-fb03-428b-a87e-ab41930d6e8d	t	${role_view-consent}	view-consent	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	fef5fa01-fb03-428b-a87e-ab41930d6e8d	\N
667e772a-7f57-49d4-a897-d2d60754e7ee	387ca314-961f-445b-a3ae-283df119b373	t	${role_impersonation}	impersonation	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	387ca314-961f-445b-a3ae-283df119b373	\N
ee82eea5-a77e-4957-ac7d-d101ebf8d6b6	279c38e5-81e9-4a81-82e9-031f5878374e	t	\N	uma_protection	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	279c38e5-81e9-4a81-82e9-031f5878374e	\N
bf8039b0-2383-46a2-8984-70181183fe9d	68ba78c7-2a44-4adb-b3c8-0907759d3266	t	\N	uma_protection	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
ea99cd2e-298f-42ac-9e84-78c9ac306471	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f		ROLE_ADMIN	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N	\N
8398d143-8ee7-4e9b-8871-6e3efc86cf17	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f		ROLE_USER	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N	\N
c6942ee1-1ae7-4359-b070-abbbe88d2ab9	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f		ROLE_ANONYMOUS	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	\N	\N
9a5094e6-aa1a-4000-92f3-14529adde708	68ba78c7-2a44-4adb-b3c8-0907759d3266	t		ROLE_USER	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
552bf6cf-ab99-41b7-a52f-b8a0fa9ab072	d8022315-1de9-4c99-a5a5-d0f1b7561889	t	\N	uma_protection	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
d2460f21-4313-4d9b-bb20-d6d91efeb98a	d8022315-1de9-4c99-a5a5-d0f1b7561889	t		ROLE_ADMIN	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
15684013-5798-4086-a1a8-be405032793f	d8022315-1de9-4c99-a5a5-d0f1b7561889	t		ROLE_USER	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
7c1e8490-c4f0-42c2-a505-598d10ae184a	d8022315-1de9-4c99-a5a5-d0f1b7561889	t		ROLE_ANONYMOUS	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
80d7cb45-1fb6-450e-aed0-81ec7f8e75d7	279c38e5-81e9-4a81-82e9-031f5878374e	t		ROLE_ADMIN	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	279c38e5-81e9-4a81-82e9-031f5878374e	\N
425b2a0d-c498-4874-bef4-d5d28b0ce805	279c38e5-81e9-4a81-82e9-031f5878374e	t		ROLE_USER	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	279c38e5-81e9-4a81-82e9-031f5878374e	\N
aaa2f021-de84-4adf-9365-ed62bec2a092	279c38e5-81e9-4a81-82e9-031f5878374e	t		ROLE_ANONYMOUS	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	279c38e5-81e9-4a81-82e9-031f5878374e	\N
b6c4b649-3d8e-4eb6-820f-d43ca1aa5c7f	2bdc627e-50a0-493e-a38c-f0b8def716cd	t		ROLE_ADMIN	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2bdc627e-50a0-493e-a38c-f0b8def716cd	\N
813f572a-58be-40b9-b77a-8708795eddc2	2bdc627e-50a0-493e-a38c-f0b8def716cd	t		ROLE_USER	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2bdc627e-50a0-493e-a38c-f0b8def716cd	\N
4ec19010-b333-4792-a2c7-21d0da80295b	2bdc627e-50a0-493e-a38c-f0b8def716cd	t		ROLE_ANONYMOUS	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	2bdc627e-50a0-493e-a38c-f0b8def716cd	\N
0490d337-ce56-49e4-9271-6e0a0911d121	68ba78c7-2a44-4adb-b3c8-0907759d3266	t		ROLE_ADMIN	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.migration_model (id, version, update_time) FROM stdin;
umpuv	999.0.0	1730007023
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
9d710682-f516-485b-93eb-1c4cb31ca43a	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737911917	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737911917","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737911917","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"6rqrJbPOXrsvMWk0hRTYNvcqgkJMBWILKWGdKeiHGyo=","nonce":"qHitw7kTjsO5EZTC2qQvZi98YfOoDHERQpd7-kr-fsw"}}	local	local	0
00bdbb28-2add-49cd-a4ce-32d3929ec102	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737912016	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737912016","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737912016","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"fc99tVHbLZ1pOqswejDjw1YjjadcMiBkM0Bf9KxbbBk=","nonce":"aMhgq-7Gf_GiWSOmUDVjQjsE0zO0Aq1FnK-s9XDOC7k"}}	local	local	0
2e9e4e05-c666-4c79-9c25-e9a722d077cd	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737906834	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737905308","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737905308","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"O0psiSka5La2me2lSE2vS-JQxGRLQUuc8jIzRrjcBB0=","nonce":"iSdXlEWmPczfA2iJ1JiQI7IZq_eWzprdWlupiPMTulg"}}	local	local	4
8793ba51-c7cb-4099-a303-d272601fc8d4	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737904644	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737903682","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737903682","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"t89gHR-30RnFGBxI4yj1YCMD31s3r6hX6LUb5MVRWco=","nonce":"fKuhynLgBGHIlqS7cSUIDC4nKwV0F6rgVZidgtcKXDY"}}	local	local	3
c5226789-7cd7-432f-b0ae-1792421440e7	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737907224	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737907223","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737907223","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"Zx9QDenNcpB7v0lc5RdRWvEpi9X85Rcd8QJFsBvdglo=","nonce":"hjvgdB3wJEFcd5V6LtXz7Qx0J5qHG-S_6zRfT2hEPKI"}}	local	local	0
0ec2d160-78ce-477e-bc17-48453e99d5e1	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737915099	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737915099","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737915099","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"icgBt7b1dRPNI6vVv_7JBnlVo75i3Yq5Zi5HEHheue4=","nonce":"qqJqCXPIQJo6aBeu90f69RJDrWSKeBMvCwrdX1LWXgg"}}	local	local	0
42c2c1a9-8d3e-4842-afd9-505416c401ce	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737923977	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737923977","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737923977","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"h0B8M5rlhSpvzUyYaJD0yjACWT0_KumII9zZOKiiDMs=","nonce":"geOBiQeKqr9_2YsQo_X1IMSJNJV32EG-xli3bJEARi0"}}	local	local	0
49606c17-7603-406c-b25e-9b4bf6e3c04e	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737932247	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737931540","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737931540","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"AdfadwZQQV-9iHjXfk1cW7UgTnFucTlT0r-LUb9tc64=","nonce":"lXzoBuJwedEsaIQXdxusaWu2BaHTJHORRxfACxJhkmM"}}	local	local	1
0feeeb1d-c9ed-4458-933b-236d07bc9de8	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737933862	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737932333","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737932333","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"16JJ0VSnkIrN5-J4OWmbpRoFvM39CvNUJcgRAQ9yL88=","nonce":"5hgKXg30C-DoUzSloqWDr39UgIKZqPHzppZKgXmLIxc"}}	local	local	3
85960658-3d6e-49e1-b788-05af008f21fd	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737934261	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737934261","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737934261","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"KwklNTJN24pNqQhwidy087ReYaUiarbURqBMA1JgvOk=","nonce":"CT0y3EMsuArz4XtL9s1m9Urb8AZGrQaQqmHTDlEx33g"}}	local	local	0
ad8bbf72-3932-4c3e-a164-be61bedd654d	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737934564	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737934564","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737934564","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"wIR60dwl8G8SucacsQ8zaYtzyj-EHoFvqAQ2ivrCUYE=","nonce":"U5PbE0Ku9R9IZgvvqD5XMgESHqdC35gGnWVKfgyT0ik"}}	local	local	0
ab47a593-0103-40c6-b68e-b5f5a24db2a5	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737934662	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737934662","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737934662","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"VaXDXon9aUvFQxFa3lAHOv57w75BeLvhXKB_u-y4kA8=","nonce":"vzBah5c3pcg7hxeDdkdNSID2Pga3vGSM50nhpOhslRw"}}	local	local	0
0ca55b74-54f9-4d5d-96ac-3f65d76c7530	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737935442	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737935197","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737935197","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"_34r-JQw0kkMPxs9PdD0BsRreTdKIfnbdUUK4HpRsWw=","nonce":"ggbpvUMJjjW6iUaRMzBGERqQOBvmD9vlSiqBmj-tivU"}}	local	local	1
82ed9718-93cf-43ca-99fe-506b2229186c	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737946078	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737945681","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737945681","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"STa2mjon_dj0SXgM2zEr4np8JJrP9uyMKtv9CreplGo=","nonce":"D0lC5LcAjiaVlbz_8OimV205d-QYiEbGypZZV1fvlbA"}}	local	local	1
1a2a9746-4261-4543-82cb-a210905b37c3	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737947220	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737946112","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737946112","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"JRjDRYtiCAuclgJdwa0BgVK7hNXxVirZerxNy3l0mUU=","nonce":"sZOh1RiMixC5uuvYHSwdan2v-QDq-sSQkNF4vvxd0Bc"}}	local	local	2
ada9189a-c661-4b51-bd1d-49b9e2b6f0e4	68ba78c7-2a44-4adb-b3c8-0907759d3266	1	1737950607	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/login/oauth2/code/oidc","notes":{"clientId":"68ba78c7-2a44-4adb-b3c8-0907759d3266","scope":"openid profile email roles offline_access","userSessionStartedAt":"1737950607","iss":"http://localhost:9080/realms/heartfull-mind-ecosystems","startedAt":"1737950607","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:9000/login/oauth2/code/oidc","state":"bvw-ZmzslwqHH6J6cvb7lQ7qD-IMKNkmnD7h9Pjx1k4=","nonce":"O6PB1-Qw8Cs6z9o_Yph8d8qHvbLlqMQ8UNjlSTmnBKs"}}	local	local	0
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
2e9e4e05-c666-4c79-9c25-e9a722d077cd	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737905308	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737905308","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737905308}"},"state":"LOGGED_IN"}	1737906834	\N	4
c5226789-7cd7-432f-b0ae-1792421440e7	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737907224	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737907223","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737907223}"},"state":"LOGGED_IN"}	1737907224	\N	0
9d710682-f516-485b-93eb-1c4cb31ca43a	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737911917	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737911917","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737911917}"},"state":"LOGGED_IN"}	1737911917	\N	0
00bdbb28-2add-49cd-a4ce-32d3929ec102	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737912016	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737912016","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737912016}"},"state":"LOGGED_IN"}	1737912016	\N	0
0ec2d160-78ce-477e-bc17-48453e99d5e1	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737915099	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737915099","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737915099}"},"state":"LOGGED_IN"}	1737915099	\N	0
42c2c1a9-8d3e-4842-afd9-505416c401ce	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737923977	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737923977","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737923977}"},"state":"LOGGED_IN"}	1737923977	\N	0
8793ba51-c7cb-4099-a303-d272601fc8d4	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737903682	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737903682","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737903682}"},"state":"LOGGED_IN"}	1737904644	\N	3
49606c17-7603-406c-b25e-9b4bf6e3c04e	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737931540	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737931540","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737931540}"},"state":"LOGGED_IN"}	1737932247	\N	1
0feeeb1d-c9ed-4458-933b-236d07bc9de8	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737932333	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737932333","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737932333}"},"state":"LOGGED_IN"}	1737933862	\N	3
85960658-3d6e-49e1-b788-05af008f21fd	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737934261	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737934261","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737934261}"},"state":"LOGGED_IN"}	1737934261	\N	0
ad8bbf72-3932-4c3e-a164-be61bedd654d	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737934564	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737934564","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737934564}"},"state":"LOGGED_IN"}	1737934564	\N	0
ab47a593-0103-40c6-b68e-b5f5a24db2a5	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737934662	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737934662","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737934662}"},"state":"LOGGED_IN"}	1737934662	\N	0
0ca55b74-54f9-4d5d-96ac-3f65d76c7530	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737935197	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737935197","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737935197}"},"state":"LOGGED_IN"}	1737935442	\N	1
82ed9718-93cf-43ca-99fe-506b2229186c	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737945681	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737945681","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737945681}"},"state":"LOGGED_IN"}	1737946078	\N	1
1a2a9746-4261-4543-82cb-a210905b37c3	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737946112	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737946112","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737946112}"},"state":"LOGGED_IN"}	1737947220	\N	2
ada9189a-c661-4b51-bd1d-49b9e2b6f0e4	1d2fcd71-0a16-4420-a90b-ddfbf7822168	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1737950607	1	{"ipAddress":"127.0.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJvcyI6IlVidW50dSIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xMjguMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1737950607","authenticators-completed":"{\\"4a96024b-f3ee-4c73-b8c9-d535dd00c5fd\\":1737950607}"},"state":"LOGGED_IN"}	1737950607	\N	0
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
6ed573fe-3ec2-4958-81c3-c83e0d5c8982	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
8ba195db-2f2b-4cea-afb0-36e2ef67db14	defaultResourceType	urn:heartfullmind-registry:resources:default
1d9e61b7-2874-4a7c-b7d6-f72e571cec9e	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
9dd168b9-7f0b-4d45-99af-6f62e3a6c68b	defaultResourceType	urn:createyourhumanity-eco1:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
5eeaa4d0-c6b9-44d1-a2f2-6169b718bf42	audience resolve	openid-connect	oidc-audience-resolve-mapper	124e0ebc-264a-4040-baf0-75742f76e176	\N
f1066148-ac12-4912-a6e8-8d89bbe279f0	locale	openid-connect	oidc-usermodel-attribute-mapper	3a18b29a-cb33-406c-b8ca-60d3131f4f1b	\N
a8b7d2ba-3ca6-4ecf-aa72-7bc18da74f36	role list	saml	saml-role-list-mapper	\N	1e18cda9-723d-4c61-a0b7-c73f93c9ef0a
e2bdf5dc-e36f-4c9c-a836-6feb96cab7f7	organization	saml	saml-organization-membership-mapper	\N	92963282-93b8-4146-b943-92938929c255
9c6cfac2-becd-4515-82e9-136263aea32a	full name	openid-connect	oidc-full-name-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
4594d2a6-9128-4182-af9a-4ce14be8865b	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
c4816116-2d46-4e19-a0b9-b54d869b641d	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
a86e377e-57f1-4e44-83af-4f742a435e45	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
0371fb62-a4dc-4837-b28a-ed143a69b144	username	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
0e4a2cd4-2697-47e6-b99f-595c748a59c9	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
02bf9399-3122-4c5d-825e-374dc44e8286	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
a037c9e8-c370-4537-9b21-005df01d91b9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
303b6f3e-0016-48a0-9b7a-4698edab5341	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
2f0aef21-648d-4696-a3fb-db68bbeba210	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
480028a6-d4a6-42fb-96ab-6db9de91d793	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dcc7cf-dbf8-4926-955c-d3b8c732528f
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	email	openid-connect	oidc-usermodel-attribute-mapper	\N	32f9707e-06f2-4c76-9ab5-419fe1da1107
4ca27446-24a0-44c6-bcec-b38367ecd863	email verified	openid-connect	oidc-usermodel-property-mapper	\N	32f9707e-06f2-4c76-9ab5-419fe1da1107
2db09125-f210-4267-94cd-135fff007c5c	address	openid-connect	oidc-address-mapper	\N	2d9cea3d-af78-4dbb-9e4d-d6ea9badbc64
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	6bb6342d-4413-4217-bcd9-cc398ab3ecdd
7264f49e-43e1-4c03-a260-18c2ff4057e7	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	6bb6342d-4413-4217-bcd9-cc398ab3ecdd
cd834af9-0d12-4d50-9fbc-9ad085ad5067	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	19f16ba1-df56-4156-babf-9b088b3b44f9
d5feb763-bcf1-4587-8bf4-ee2670adeb82	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	19f16ba1-df56-4156-babf-9b088b3b44f9
ecccce27-8c7b-4ae3-b218-e87ec72ae01d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	19f16ba1-df56-4156-babf-9b088b3b44f9
7f7edd41-2494-4441-95de-658a8312f23f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	955bf1e3-e373-4abb-90b5-9b72e4a7a58e
e5fea836-16db-4b07-b1d7-f661b8dd10a7	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	d1204b7b-5ecf-4be6-a33b-0d1845ccb082
8e1a5075-57b5-48c5-b753-6e121f27781f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	d1204b7b-5ecf-4be6-a33b-0d1845ccb082
c0363157-3661-4876-bdb9-c090ea19d36e	acr loa level	openid-connect	oidc-acr-mapper	\N	94bd7db0-c724-4481-9198-8b06e78614f4
004ffe3d-452b-452a-a2d4-d877f42a9021	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	59bcb9aa-5864-4ed5-9acc-6eb09283af11
17113bd2-ac68-4f54-9582-f5aa9ddf1b2d	sub	openid-connect	oidc-sub-mapper	\N	59bcb9aa-5864-4ed5-9acc-6eb09283af11
162ed62a-9972-4d8f-b3d2-5abb27068198	organization	openid-connect	oidc-organization-membership-mapper	\N	6d0c424a-24e3-4d76-b1c9-d214f09c13f5
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	2df458fa-5cb1-40a6-b17d-992edf1927f6
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	2df458fa-5cb1-40a6-b17d-992edf1927f6
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	email	openid-connect	oidc-usermodel-attribute-mapper	\N	f54a3ac4-e891-40bf-ae03-41a2524b74d7
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f54a3ac4-e891-40bf-ae03-41a2524b74d7
b43de8a8-1fa8-4b55-ad25-28b45af55489	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8
7c4c8737-fa4a-4c1c-b035-261f0376024b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a2132ba7-51a5-4f5d-a227-6fa6ec848fb8
d65e1b73-6816-4b18-b4ee-1fe063fc0c8d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	bc2c025f-9b58-44f5-9a9a-e8bb86203b5a
c08ae454-0b71-4aa3-98a2-032750a295d1	acr loa level	openid-connect	oidc-acr-mapper	\N	87ad1672-4dd5-4a4b-b7bc-5228626ed5d0
8645d0a9-09dd-4343-886c-04d6bb1544da	role list	saml	saml-role-list-mapper	\N	ff4c9fb7-c7a0-45ae-b03b-d23c82f5144d
75d3d699-bc4d-4731-b4f0-e255ea66fa35	address	openid-connect	oidc-address-mapper	\N	12a0bd96-8f01-47c7-a1ad-164b61c2d62c
a5460e53-d8c9-4000-bc5e-a6b10b51a814	sub	openid-connect	oidc-sub-mapper	\N	aa3785a5-bbd9-4690-9566-f830dd2cb090
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	aa3785a5-bbd9-4690-9566-f830dd2cb090
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	fdd6bffe-6613-4ed5-ac11-03ffca40384e
d6c73972-3875-48d9-ab09-0d12e6c4d00f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
00c31218-f64e-4ebf-a8f5-410aec471b2b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
b4a5d76a-1fda-4619-9557-6798e74e130a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
73e91052-5d0f-4453-803c-f33dd3bb95f7	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
bc00de3d-4455-4ff3-a9e7-9d15cf416516	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
06eabb79-df9c-44e7-a0fb-a6580df0b231	username	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
e451d5b9-3989-48b4-af93-6151927ed66d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
5abc5b17-3fda-4135-8321-61d47c495271	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
a5ae9279-9495-484c-995d-633d9d37f37d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
4a8091e2-a351-44ee-8897-822d245ceb16	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
45df4105-53b5-4e52-a452-7da5b85bebb6	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
1e98e351-ebfe-458d-9678-197189a42944	full name	openid-connect	oidc-full-name-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
0f390a36-29dc-4b2d-81b5-29d45176eb38	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d75af507-a2e9-4e6e-bd46-193169812613
4e9b9201-a805-48a7-a415-26825a1b62c2	audience resolve	openid-connect	oidc-audience-resolve-mapper	a1d6d92c-61a4-4995-b335-575ff839e6e4	\N
b257c2e3-9d8c-4ee2-aeac-4392d342263b	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	279c38e5-81e9-4a81-82e9-031f5878374e	\N
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	279c38e5-81e9-4a81-82e9-031f5878374e	\N
17afb72e-3956-4373-883c-e19ab344fbba	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	279c38e5-81e9-4a81-82e9-031f5878374e	\N
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	locale	openid-connect	oidc-usermodel-attribute-mapper	7131682d-2564-4e5e-afa9-4979a1b8d08a	\N
6af086dc-8eeb-4a2e-9264-934924073c45	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
d51e3b2f-ec97-4150-bc26-0a647a886cee	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
7c03bcef-01ad-4539-860c-f608cdc3ffb1	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
5ea89859-f72a-402c-9da3-b92f221a8ab3	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
643df8e9-febc-477d-bf99-31c8ed984ff8	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
76595108-8bbd-4738-90c6-628e8a2775da	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b416fe2a-d004-42bf-95aa-323ddb13dd0a
a7b91c9f-a618-405b-818f-fc74977f46da	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	2bdc627e-50a0-493e-a38c-f0b8def716cd	\N
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	2bdc627e-50a0-493e-a38c-f0b8def716cd	\N
4eb5a50c-71d0-4b15-b621-63177ed093e7	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	2bdc627e-50a0-493e-a38c-f0b8def716cd	\N
9322796d-84b4-477b-9ab7-74325d1ee1b8	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	fdd6bffe-6613-4ed5-ac11-03ffca40384e
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
f1066148-ac12-4912-a6e8-8d89bbe279f0	true	introspection.token.claim
f1066148-ac12-4912-a6e8-8d89bbe279f0	true	userinfo.token.claim
f1066148-ac12-4912-a6e8-8d89bbe279f0	locale	user.attribute
f1066148-ac12-4912-a6e8-8d89bbe279f0	true	id.token.claim
f1066148-ac12-4912-a6e8-8d89bbe279f0	true	access.token.claim
f1066148-ac12-4912-a6e8-8d89bbe279f0	locale	claim.name
f1066148-ac12-4912-a6e8-8d89bbe279f0	String	jsonType.label
a8b7d2ba-3ca6-4ecf-aa72-7bc18da74f36	false	single
a8b7d2ba-3ca6-4ecf-aa72-7bc18da74f36	Basic	attribute.nameformat
a8b7d2ba-3ca6-4ecf-aa72-7bc18da74f36	Role	attribute.name
02bf9399-3122-4c5d-825e-374dc44e8286	true	introspection.token.claim
02bf9399-3122-4c5d-825e-374dc44e8286	true	userinfo.token.claim
02bf9399-3122-4c5d-825e-374dc44e8286	picture	user.attribute
02bf9399-3122-4c5d-825e-374dc44e8286	true	id.token.claim
02bf9399-3122-4c5d-825e-374dc44e8286	true	access.token.claim
02bf9399-3122-4c5d-825e-374dc44e8286	picture	claim.name
02bf9399-3122-4c5d-825e-374dc44e8286	String	jsonType.label
0371fb62-a4dc-4837-b28a-ed143a69b144	true	introspection.token.claim
0371fb62-a4dc-4837-b28a-ed143a69b144	true	userinfo.token.claim
0371fb62-a4dc-4837-b28a-ed143a69b144	username	user.attribute
0371fb62-a4dc-4837-b28a-ed143a69b144	true	id.token.claim
0371fb62-a4dc-4837-b28a-ed143a69b144	true	access.token.claim
0371fb62-a4dc-4837-b28a-ed143a69b144	preferred_username	claim.name
0371fb62-a4dc-4837-b28a-ed143a69b144	String	jsonType.label
0e4a2cd4-2697-47e6-b99f-595c748a59c9	true	introspection.token.claim
0e4a2cd4-2697-47e6-b99f-595c748a59c9	true	userinfo.token.claim
0e4a2cd4-2697-47e6-b99f-595c748a59c9	profile	user.attribute
0e4a2cd4-2697-47e6-b99f-595c748a59c9	true	id.token.claim
0e4a2cd4-2697-47e6-b99f-595c748a59c9	true	access.token.claim
0e4a2cd4-2697-47e6-b99f-595c748a59c9	profile	claim.name
0e4a2cd4-2697-47e6-b99f-595c748a59c9	String	jsonType.label
2f0aef21-648d-4696-a3fb-db68bbeba210	true	introspection.token.claim
2f0aef21-648d-4696-a3fb-db68bbeba210	true	userinfo.token.claim
2f0aef21-648d-4696-a3fb-db68bbeba210	locale	user.attribute
2f0aef21-648d-4696-a3fb-db68bbeba210	true	id.token.claim
2f0aef21-648d-4696-a3fb-db68bbeba210	true	access.token.claim
2f0aef21-648d-4696-a3fb-db68bbeba210	locale	claim.name
2f0aef21-648d-4696-a3fb-db68bbeba210	String	jsonType.label
303b6f3e-0016-48a0-9b7a-4698edab5341	true	introspection.token.claim
303b6f3e-0016-48a0-9b7a-4698edab5341	true	userinfo.token.claim
303b6f3e-0016-48a0-9b7a-4698edab5341	birthdate	user.attribute
303b6f3e-0016-48a0-9b7a-4698edab5341	true	id.token.claim
303b6f3e-0016-48a0-9b7a-4698edab5341	true	access.token.claim
303b6f3e-0016-48a0-9b7a-4698edab5341	birthdate	claim.name
303b6f3e-0016-48a0-9b7a-4698edab5341	String	jsonType.label
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	true	introspection.token.claim
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	true	userinfo.token.claim
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	nickname	user.attribute
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	true	id.token.claim
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	true	access.token.claim
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	nickname	claim.name
43a4f7f5-8b3c-4aa0-aa78-82742e39b7d4	String	jsonType.label
4594d2a6-9128-4182-af9a-4ce14be8865b	true	introspection.token.claim
4594d2a6-9128-4182-af9a-4ce14be8865b	true	userinfo.token.claim
4594d2a6-9128-4182-af9a-4ce14be8865b	lastName	user.attribute
4594d2a6-9128-4182-af9a-4ce14be8865b	true	id.token.claim
4594d2a6-9128-4182-af9a-4ce14be8865b	true	access.token.claim
4594d2a6-9128-4182-af9a-4ce14be8865b	family_name	claim.name
4594d2a6-9128-4182-af9a-4ce14be8865b	String	jsonType.label
480028a6-d4a6-42fb-96ab-6db9de91d793	true	introspection.token.claim
480028a6-d4a6-42fb-96ab-6db9de91d793	true	userinfo.token.claim
480028a6-d4a6-42fb-96ab-6db9de91d793	updatedAt	user.attribute
480028a6-d4a6-42fb-96ab-6db9de91d793	true	id.token.claim
480028a6-d4a6-42fb-96ab-6db9de91d793	true	access.token.claim
480028a6-d4a6-42fb-96ab-6db9de91d793	updated_at	claim.name
480028a6-d4a6-42fb-96ab-6db9de91d793	long	jsonType.label
9c6cfac2-becd-4515-82e9-136263aea32a	true	introspection.token.claim
9c6cfac2-becd-4515-82e9-136263aea32a	true	userinfo.token.claim
9c6cfac2-becd-4515-82e9-136263aea32a	true	id.token.claim
9c6cfac2-becd-4515-82e9-136263aea32a	true	access.token.claim
a037c9e8-c370-4537-9b21-005df01d91b9	true	introspection.token.claim
a037c9e8-c370-4537-9b21-005df01d91b9	true	userinfo.token.claim
a037c9e8-c370-4537-9b21-005df01d91b9	gender	user.attribute
a037c9e8-c370-4537-9b21-005df01d91b9	true	id.token.claim
a037c9e8-c370-4537-9b21-005df01d91b9	true	access.token.claim
a037c9e8-c370-4537-9b21-005df01d91b9	gender	claim.name
a037c9e8-c370-4537-9b21-005df01d91b9	String	jsonType.label
a86e377e-57f1-4e44-83af-4f742a435e45	true	introspection.token.claim
a86e377e-57f1-4e44-83af-4f742a435e45	true	userinfo.token.claim
a86e377e-57f1-4e44-83af-4f742a435e45	middleName	user.attribute
a86e377e-57f1-4e44-83af-4f742a435e45	true	id.token.claim
a86e377e-57f1-4e44-83af-4f742a435e45	true	access.token.claim
a86e377e-57f1-4e44-83af-4f742a435e45	middle_name	claim.name
a86e377e-57f1-4e44-83af-4f742a435e45	String	jsonType.label
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	true	introspection.token.claim
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	true	userinfo.token.claim
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	website	user.attribute
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	true	id.token.claim
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	true	access.token.claim
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	website	claim.name
bc888262-7c5d-4d13-8eb2-e115ed9d1c73	String	jsonType.label
c4816116-2d46-4e19-a0b9-b54d869b641d	true	introspection.token.claim
c4816116-2d46-4e19-a0b9-b54d869b641d	true	userinfo.token.claim
c4816116-2d46-4e19-a0b9-b54d869b641d	firstName	user.attribute
c4816116-2d46-4e19-a0b9-b54d869b641d	true	id.token.claim
c4816116-2d46-4e19-a0b9-b54d869b641d	true	access.token.claim
c4816116-2d46-4e19-a0b9-b54d869b641d	given_name	claim.name
c4816116-2d46-4e19-a0b9-b54d869b641d	String	jsonType.label
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	true	introspection.token.claim
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	true	userinfo.token.claim
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	zoneinfo	user.attribute
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	true	id.token.claim
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	true	access.token.claim
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	zoneinfo	claim.name
c77b8aa6-9dc7-4784-9c13-c4ccc6d869e4	String	jsonType.label
4ca27446-24a0-44c6-bcec-b38367ecd863	true	introspection.token.claim
4ca27446-24a0-44c6-bcec-b38367ecd863	true	userinfo.token.claim
4ca27446-24a0-44c6-bcec-b38367ecd863	emailVerified	user.attribute
4ca27446-24a0-44c6-bcec-b38367ecd863	true	id.token.claim
4ca27446-24a0-44c6-bcec-b38367ecd863	true	access.token.claim
4ca27446-24a0-44c6-bcec-b38367ecd863	email_verified	claim.name
4ca27446-24a0-44c6-bcec-b38367ecd863	boolean	jsonType.label
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	true	introspection.token.claim
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	true	userinfo.token.claim
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	email	user.attribute
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	true	id.token.claim
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	true	access.token.claim
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	email	claim.name
fbc3cdb1-e4b8-4c07-bbc3-e5004fdc1e8a	String	jsonType.label
2db09125-f210-4267-94cd-135fff007c5c	formatted	user.attribute.formatted
2db09125-f210-4267-94cd-135fff007c5c	country	user.attribute.country
2db09125-f210-4267-94cd-135fff007c5c	true	introspection.token.claim
2db09125-f210-4267-94cd-135fff007c5c	postal_code	user.attribute.postal_code
2db09125-f210-4267-94cd-135fff007c5c	true	userinfo.token.claim
2db09125-f210-4267-94cd-135fff007c5c	street	user.attribute.street
2db09125-f210-4267-94cd-135fff007c5c	true	id.token.claim
2db09125-f210-4267-94cd-135fff007c5c	region	user.attribute.region
2db09125-f210-4267-94cd-135fff007c5c	true	access.token.claim
2db09125-f210-4267-94cd-135fff007c5c	locality	user.attribute.locality
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	true	introspection.token.claim
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	true	userinfo.token.claim
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	phoneNumber	user.attribute
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	true	id.token.claim
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	true	access.token.claim
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	phone_number	claim.name
67cce2ee-3c70-49cf-bfbb-d039d29bdde4	String	jsonType.label
7264f49e-43e1-4c03-a260-18c2ff4057e7	true	introspection.token.claim
7264f49e-43e1-4c03-a260-18c2ff4057e7	true	userinfo.token.claim
7264f49e-43e1-4c03-a260-18c2ff4057e7	phoneNumberVerified	user.attribute
7264f49e-43e1-4c03-a260-18c2ff4057e7	true	id.token.claim
7264f49e-43e1-4c03-a260-18c2ff4057e7	true	access.token.claim
7264f49e-43e1-4c03-a260-18c2ff4057e7	phone_number_verified	claim.name
7264f49e-43e1-4c03-a260-18c2ff4057e7	boolean	jsonType.label
cd834af9-0d12-4d50-9fbc-9ad085ad5067	true	introspection.token.claim
cd834af9-0d12-4d50-9fbc-9ad085ad5067	true	multivalued
cd834af9-0d12-4d50-9fbc-9ad085ad5067	foo	user.attribute
cd834af9-0d12-4d50-9fbc-9ad085ad5067	true	access.token.claim
cd834af9-0d12-4d50-9fbc-9ad085ad5067	realm_access.roles	claim.name
cd834af9-0d12-4d50-9fbc-9ad085ad5067	String	jsonType.label
d5feb763-bcf1-4587-8bf4-ee2670adeb82	true	introspection.token.claim
d5feb763-bcf1-4587-8bf4-ee2670adeb82	true	multivalued
d5feb763-bcf1-4587-8bf4-ee2670adeb82	foo	user.attribute
d5feb763-bcf1-4587-8bf4-ee2670adeb82	true	access.token.claim
d5feb763-bcf1-4587-8bf4-ee2670adeb82	resource_access.${client_id}.roles	claim.name
d5feb763-bcf1-4587-8bf4-ee2670adeb82	String	jsonType.label
ecccce27-8c7b-4ae3-b218-e87ec72ae01d	true	introspection.token.claim
ecccce27-8c7b-4ae3-b218-e87ec72ae01d	true	access.token.claim
7f7edd41-2494-4441-95de-658a8312f23f	true	introspection.token.claim
7f7edd41-2494-4441-95de-658a8312f23f	true	access.token.claim
8e1a5075-57b5-48c5-b753-6e121f27781f	true	introspection.token.claim
8e1a5075-57b5-48c5-b753-6e121f27781f	true	multivalued
8e1a5075-57b5-48c5-b753-6e121f27781f	foo	user.attribute
8e1a5075-57b5-48c5-b753-6e121f27781f	true	id.token.claim
8e1a5075-57b5-48c5-b753-6e121f27781f	true	access.token.claim
8e1a5075-57b5-48c5-b753-6e121f27781f	groups	claim.name
8e1a5075-57b5-48c5-b753-6e121f27781f	String	jsonType.label
e5fea836-16db-4b07-b1d7-f661b8dd10a7	true	introspection.token.claim
e5fea836-16db-4b07-b1d7-f661b8dd10a7	true	userinfo.token.claim
e5fea836-16db-4b07-b1d7-f661b8dd10a7	username	user.attribute
e5fea836-16db-4b07-b1d7-f661b8dd10a7	true	id.token.claim
e5fea836-16db-4b07-b1d7-f661b8dd10a7	true	access.token.claim
e5fea836-16db-4b07-b1d7-f661b8dd10a7	upn	claim.name
e5fea836-16db-4b07-b1d7-f661b8dd10a7	String	jsonType.label
c0363157-3661-4876-bdb9-c090ea19d36e	true	introspection.token.claim
c0363157-3661-4876-bdb9-c090ea19d36e	true	id.token.claim
c0363157-3661-4876-bdb9-c090ea19d36e	true	access.token.claim
004ffe3d-452b-452a-a2d4-d877f42a9021	AUTH_TIME	user.session.note
004ffe3d-452b-452a-a2d4-d877f42a9021	true	introspection.token.claim
004ffe3d-452b-452a-a2d4-d877f42a9021	true	id.token.claim
004ffe3d-452b-452a-a2d4-d877f42a9021	true	access.token.claim
004ffe3d-452b-452a-a2d4-d877f42a9021	auth_time	claim.name
004ffe3d-452b-452a-a2d4-d877f42a9021	long	jsonType.label
17113bd2-ac68-4f54-9582-f5aa9ddf1b2d	true	introspection.token.claim
17113bd2-ac68-4f54-9582-f5aa9ddf1b2d	true	access.token.claim
162ed62a-9972-4d8f-b3d2-5abb27068198	true	introspection.token.claim
162ed62a-9972-4d8f-b3d2-5abb27068198	true	multivalued
162ed62a-9972-4d8f-b3d2-5abb27068198	true	id.token.claim
162ed62a-9972-4d8f-b3d2-5abb27068198	true	access.token.claim
162ed62a-9972-4d8f-b3d2-5abb27068198	organization	claim.name
162ed62a-9972-4d8f-b3d2-5abb27068198	String	jsonType.label
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	true	introspection.token.claim
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	true	userinfo.token.claim
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	phoneNumber	user.attribute
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	true	id.token.claim
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	true	access.token.claim
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	phone_number	claim.name
2dc6ac18-06d4-4e05-b2d3-dfff6dce7c5d	String	jsonType.label
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	true	introspection.token.claim
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	true	userinfo.token.claim
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	phoneNumberVerified	user.attribute
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	true	id.token.claim
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	true	access.token.claim
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	phone_number_verified	claim.name
a6937700-a7e7-45b3-9ac8-dc7997ef6bdf	boolean	jsonType.label
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	true	introspection.token.claim
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	true	userinfo.token.claim
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	email	user.attribute
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	true	id.token.claim
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	true	access.token.claim
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	email	claim.name
148f2340-eaa5-4f05-8a2b-d14dcccf3ea9	String	jsonType.label
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	true	introspection.token.claim
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	true	userinfo.token.claim
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	emailVerified	user.attribute
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	true	id.token.claim
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	true	access.token.claim
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	email_verified	claim.name
2a1c4f0c-b095-4594-9dcc-814582c5f5d6	boolean	jsonType.label
7c4c8737-fa4a-4c1c-b035-261f0376024b	true	introspection.token.claim
7c4c8737-fa4a-4c1c-b035-261f0376024b	true	multivalued
7c4c8737-fa4a-4c1c-b035-261f0376024b	true	userinfo.token.claim
7c4c8737-fa4a-4c1c-b035-261f0376024b	foo	user.attribute
7c4c8737-fa4a-4c1c-b035-261f0376024b	true	id.token.claim
7c4c8737-fa4a-4c1c-b035-261f0376024b	true	access.token.claim
7c4c8737-fa4a-4c1c-b035-261f0376024b	groups	claim.name
7c4c8737-fa4a-4c1c-b035-261f0376024b	String	jsonType.label
b43de8a8-1fa8-4b55-ad25-28b45af55489	true	introspection.token.claim
b43de8a8-1fa8-4b55-ad25-28b45af55489	true	userinfo.token.claim
b43de8a8-1fa8-4b55-ad25-28b45af55489	username	user.attribute
b43de8a8-1fa8-4b55-ad25-28b45af55489	true	id.token.claim
b43de8a8-1fa8-4b55-ad25-28b45af55489	true	access.token.claim
b43de8a8-1fa8-4b55-ad25-28b45af55489	upn	claim.name
b43de8a8-1fa8-4b55-ad25-28b45af55489	String	jsonType.label
d65e1b73-6816-4b18-b4ee-1fe063fc0c8d	true	introspection.token.claim
d65e1b73-6816-4b18-b4ee-1fe063fc0c8d	true	access.token.claim
c08ae454-0b71-4aa3-98a2-032750a295d1	true	id.token.claim
c08ae454-0b71-4aa3-98a2-032750a295d1	true	introspection.token.claim
c08ae454-0b71-4aa3-98a2-032750a295d1	true	access.token.claim
c08ae454-0b71-4aa3-98a2-032750a295d1	true	userinfo.token.claim
8645d0a9-09dd-4343-886c-04d6bb1544da	false	single
8645d0a9-09dd-4343-886c-04d6bb1544da	Basic	attribute.nameformat
8645d0a9-09dd-4343-886c-04d6bb1544da	Role	attribute.name
75d3d699-bc4d-4731-b4f0-e255ea66fa35	formatted	user.attribute.formatted
75d3d699-bc4d-4731-b4f0-e255ea66fa35	country	user.attribute.country
75d3d699-bc4d-4731-b4f0-e255ea66fa35	true	introspection.token.claim
75d3d699-bc4d-4731-b4f0-e255ea66fa35	postal_code	user.attribute.postal_code
75d3d699-bc4d-4731-b4f0-e255ea66fa35	true	userinfo.token.claim
75d3d699-bc4d-4731-b4f0-e255ea66fa35	street	user.attribute.street
75d3d699-bc4d-4731-b4f0-e255ea66fa35	true	id.token.claim
75d3d699-bc4d-4731-b4f0-e255ea66fa35	region	user.attribute.region
75d3d699-bc4d-4731-b4f0-e255ea66fa35	true	access.token.claim
75d3d699-bc4d-4731-b4f0-e255ea66fa35	locality	user.attribute.locality
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	AUTH_TIME	user.session.note
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	true	introspection.token.claim
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	true	userinfo.token.claim
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	true	id.token.claim
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	true	access.token.claim
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	auth_time	claim.name
66f56ca6-15fc-44a4-88f9-e3d28c8a2eb9	long	jsonType.label
a5460e53-d8c9-4000-bc5e-a6b10b51a814	true	introspection.token.claim
a5460e53-d8c9-4000-bc5e-a6b10b51a814	true	access.token.claim
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	true	multivalued
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	foo	user.attribute
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	true	access.token.claim
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	String	jsonType.label
00c31218-f64e-4ebf-a8f5-410aec471b2b	true	introspection.token.claim
00c31218-f64e-4ebf-a8f5-410aec471b2b	true	userinfo.token.claim
00c31218-f64e-4ebf-a8f5-410aec471b2b	picture	user.attribute
00c31218-f64e-4ebf-a8f5-410aec471b2b	true	id.token.claim
00c31218-f64e-4ebf-a8f5-410aec471b2b	true	access.token.claim
00c31218-f64e-4ebf-a8f5-410aec471b2b	picture	claim.name
00c31218-f64e-4ebf-a8f5-410aec471b2b	String	jsonType.label
06eabb79-df9c-44e7-a0fb-a6580df0b231	true	introspection.token.claim
06eabb79-df9c-44e7-a0fb-a6580df0b231	true	userinfo.token.claim
06eabb79-df9c-44e7-a0fb-a6580df0b231	username	user.attribute
06eabb79-df9c-44e7-a0fb-a6580df0b231	true	id.token.claim
06eabb79-df9c-44e7-a0fb-a6580df0b231	true	access.token.claim
06eabb79-df9c-44e7-a0fb-a6580df0b231	preferred_username	claim.name
06eabb79-df9c-44e7-a0fb-a6580df0b231	String	jsonType.label
0f390a36-29dc-4b2d-81b5-29d45176eb38	true	introspection.token.claim
0f390a36-29dc-4b2d-81b5-29d45176eb38	true	userinfo.token.claim
0f390a36-29dc-4b2d-81b5-29d45176eb38	profile	user.attribute
0f390a36-29dc-4b2d-81b5-29d45176eb38	true	id.token.claim
0f390a36-29dc-4b2d-81b5-29d45176eb38	true	access.token.claim
0f390a36-29dc-4b2d-81b5-29d45176eb38	profile	claim.name
0f390a36-29dc-4b2d-81b5-29d45176eb38	String	jsonType.label
1e98e351-ebfe-458d-9678-197189a42944	true	id.token.claim
1e98e351-ebfe-458d-9678-197189a42944	true	introspection.token.claim
1e98e351-ebfe-458d-9678-197189a42944	true	access.token.claim
1e98e351-ebfe-458d-9678-197189a42944	true	userinfo.token.claim
45df4105-53b5-4e52-a452-7da5b85bebb6	true	introspection.token.claim
45df4105-53b5-4e52-a452-7da5b85bebb6	true	userinfo.token.claim
45df4105-53b5-4e52-a452-7da5b85bebb6	website	user.attribute
45df4105-53b5-4e52-a452-7da5b85bebb6	true	id.token.claim
45df4105-53b5-4e52-a452-7da5b85bebb6	true	access.token.claim
45df4105-53b5-4e52-a452-7da5b85bebb6	website	claim.name
45df4105-53b5-4e52-a452-7da5b85bebb6	String	jsonType.label
4a8091e2-a351-44ee-8897-822d245ceb16	true	introspection.token.claim
4a8091e2-a351-44ee-8897-822d245ceb16	true	userinfo.token.claim
4a8091e2-a351-44ee-8897-822d245ceb16	updatedAt	user.attribute
4a8091e2-a351-44ee-8897-822d245ceb16	true	id.token.claim
4a8091e2-a351-44ee-8897-822d245ceb16	true	access.token.claim
4a8091e2-a351-44ee-8897-822d245ceb16	updated_at	claim.name
4a8091e2-a351-44ee-8897-822d245ceb16	long	jsonType.label
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	true	introspection.token.claim
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	true	userinfo.token.claim
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	middleName	user.attribute
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	true	id.token.claim
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	true	access.token.claim
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	middle_name	claim.name
5a6df7b0-644e-45eb-83c7-7c4806d7ca50	String	jsonType.label
5abc5b17-3fda-4135-8321-61d47c495271	true	introspection.token.claim
5abc5b17-3fda-4135-8321-61d47c495271	true	userinfo.token.claim
5abc5b17-3fda-4135-8321-61d47c495271	lastName	user.attribute
5abc5b17-3fda-4135-8321-61d47c495271	true	id.token.claim
5abc5b17-3fda-4135-8321-61d47c495271	true	access.token.claim
5abc5b17-3fda-4135-8321-61d47c495271	family_name	claim.name
5abc5b17-3fda-4135-8321-61d47c495271	String	jsonType.label
73e91052-5d0f-4453-803c-f33dd3bb95f7	true	introspection.token.claim
73e91052-5d0f-4453-803c-f33dd3bb95f7	true	userinfo.token.claim
73e91052-5d0f-4453-803c-f33dd3bb95f7	gender	user.attribute
73e91052-5d0f-4453-803c-f33dd3bb95f7	true	id.token.claim
73e91052-5d0f-4453-803c-f33dd3bb95f7	true	access.token.claim
73e91052-5d0f-4453-803c-f33dd3bb95f7	gender	claim.name
73e91052-5d0f-4453-803c-f33dd3bb95f7	String	jsonType.label
a5ae9279-9495-484c-995d-633d9d37f37d	true	introspection.token.claim
a5ae9279-9495-484c-995d-633d9d37f37d	true	userinfo.token.claim
a5ae9279-9495-484c-995d-633d9d37f37d	locale	user.attribute
a5ae9279-9495-484c-995d-633d9d37f37d	true	id.token.claim
a5ae9279-9495-484c-995d-633d9d37f37d	true	access.token.claim
a5ae9279-9495-484c-995d-633d9d37f37d	locale	claim.name
a5ae9279-9495-484c-995d-633d9d37f37d	String	jsonType.label
b4a5d76a-1fda-4619-9557-6798e74e130a	true	introspection.token.claim
b4a5d76a-1fda-4619-9557-6798e74e130a	true	userinfo.token.claim
b4a5d76a-1fda-4619-9557-6798e74e130a	birthdate	user.attribute
b4a5d76a-1fda-4619-9557-6798e74e130a	true	id.token.claim
b4a5d76a-1fda-4619-9557-6798e74e130a	true	access.token.claim
b4a5d76a-1fda-4619-9557-6798e74e130a	birthdate	claim.name
b4a5d76a-1fda-4619-9557-6798e74e130a	String	jsonType.label
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	roles	claim.name
bc00de3d-4455-4ff3-a9e7-9d15cf416516	true	introspection.token.claim
bc00de3d-4455-4ff3-a9e7-9d15cf416516	true	userinfo.token.claim
bc00de3d-4455-4ff3-a9e7-9d15cf416516	firstName	user.attribute
bc00de3d-4455-4ff3-a9e7-9d15cf416516	true	id.token.claim
bc00de3d-4455-4ff3-a9e7-9d15cf416516	true	access.token.claim
bc00de3d-4455-4ff3-a9e7-9d15cf416516	given_name	claim.name
bc00de3d-4455-4ff3-a9e7-9d15cf416516	String	jsonType.label
d6c73972-3875-48d9-ab09-0d12e6c4d00f	true	introspection.token.claim
d6c73972-3875-48d9-ab09-0d12e6c4d00f	true	userinfo.token.claim
d6c73972-3875-48d9-ab09-0d12e6c4d00f	nickname	user.attribute
d6c73972-3875-48d9-ab09-0d12e6c4d00f	true	id.token.claim
d6c73972-3875-48d9-ab09-0d12e6c4d00f	true	access.token.claim
d6c73972-3875-48d9-ab09-0d12e6c4d00f	nickname	claim.name
d6c73972-3875-48d9-ab09-0d12e6c4d00f	String	jsonType.label
e451d5b9-3989-48b4-af93-6151927ed66d	true	introspection.token.claim
e451d5b9-3989-48b4-af93-6151927ed66d	true	userinfo.token.claim
e451d5b9-3989-48b4-af93-6151927ed66d	zoneinfo	user.attribute
e451d5b9-3989-48b4-af93-6151927ed66d	true	id.token.claim
e451d5b9-3989-48b4-af93-6151927ed66d	true	access.token.claim
e451d5b9-3989-48b4-af93-6151927ed66d	zoneinfo	claim.name
e451d5b9-3989-48b4-af93-6151927ed66d	String	jsonType.label
17afb72e-3956-4373-883c-e19ab344fbba	clientHost	user.session.note
17afb72e-3956-4373-883c-e19ab344fbba	true	introspection.token.claim
17afb72e-3956-4373-883c-e19ab344fbba	true	id.token.claim
17afb72e-3956-4373-883c-e19ab344fbba	true	access.token.claim
17afb72e-3956-4373-883c-e19ab344fbba	clientHost	claim.name
17afb72e-3956-4373-883c-e19ab344fbba	String	jsonType.label
b257c2e3-9d8c-4ee2-aeac-4392d342263b	clientAddress	user.session.note
b257c2e3-9d8c-4ee2-aeac-4392d342263b	true	introspection.token.claim
b257c2e3-9d8c-4ee2-aeac-4392d342263b	true	userinfo.token.claim
b257c2e3-9d8c-4ee2-aeac-4392d342263b	true	id.token.claim
b257c2e3-9d8c-4ee2-aeac-4392d342263b	true	access.token.claim
b257c2e3-9d8c-4ee2-aeac-4392d342263b	clientAddress	claim.name
b257c2e3-9d8c-4ee2-aeac-4392d342263b	String	jsonType.label
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	client_id	user.session.note
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	true	introspection.token.claim
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	true	id.token.claim
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	true	access.token.claim
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	client_id	claim.name
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	String	jsonType.label
cd2f5b38-77e2-4504-8b31-ca2dee4973c5	true	userinfo.token.claim
17afb72e-3956-4373-883c-e19ab344fbba	true	userinfo.token.claim
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	true	introspection.token.claim
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	true	userinfo.token.claim
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	locale	user.attribute
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	true	id.token.claim
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	true	access.token.claim
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	locale	claim.name
f3d88b16-a2ac-4c9c-8be7-db04df34fd28	String	jsonType.label
6af086dc-8eeb-4a2e-9264-934924073c45	clientAddress	user.session.note
6af086dc-8eeb-4a2e-9264-934924073c45	true	introspection.token.claim
6af086dc-8eeb-4a2e-9264-934924073c45	true	userinfo.token.claim
6af086dc-8eeb-4a2e-9264-934924073c45	true	id.token.claim
6af086dc-8eeb-4a2e-9264-934924073c45	true	access.token.claim
6af086dc-8eeb-4a2e-9264-934924073c45	clientAddress	claim.name
6af086dc-8eeb-4a2e-9264-934924073c45	String	jsonType.label
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	true	userinfo.token.claim
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	true	id.token.claim
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	false	lightweight.claim
7c03bcef-01ad-4539-860c-f608cdc3ffb1	clientHost	user.session.note
7c03bcef-01ad-4539-860c-f608cdc3ffb1	true	introspection.token.claim
7c03bcef-01ad-4539-860c-f608cdc3ffb1	true	userinfo.token.claim
7c03bcef-01ad-4539-860c-f608cdc3ffb1	true	id.token.claim
7c03bcef-01ad-4539-860c-f608cdc3ffb1	true	access.token.claim
7c03bcef-01ad-4539-860c-f608cdc3ffb1	clientHost	claim.name
7c03bcef-01ad-4539-860c-f608cdc3ffb1	String	jsonType.label
d51e3b2f-ec97-4150-bc26-0a647a886cee	client_id	user.session.note
d51e3b2f-ec97-4150-bc26-0a647a886cee	true	introspection.token.claim
d51e3b2f-ec97-4150-bc26-0a647a886cee	true	userinfo.token.claim
d51e3b2f-ec97-4150-bc26-0a647a886cee	true	id.token.claim
d51e3b2f-ec97-4150-bc26-0a647a886cee	true	access.token.claim
d51e3b2f-ec97-4150-bc26-0a647a886cee	client_id	claim.name
d51e3b2f-ec97-4150-bc26-0a647a886cee	String	jsonType.label
5ea89859-f72a-402c-9da3-b92f221a8ab3	clientAddress	user.session.note
5ea89859-f72a-402c-9da3-b92f221a8ab3	true	introspection.token.claim
5ea89859-f72a-402c-9da3-b92f221a8ab3	true	userinfo.token.claim
5ea89859-f72a-402c-9da3-b92f221a8ab3	true	id.token.claim
5ea89859-f72a-402c-9da3-b92f221a8ab3	true	access.token.claim
5ea89859-f72a-402c-9da3-b92f221a8ab3	clientAddress	claim.name
5ea89859-f72a-402c-9da3-b92f221a8ab3	String	jsonType.label
643df8e9-febc-477d-bf99-31c8ed984ff8	clientHost	user.session.note
643df8e9-febc-477d-bf99-31c8ed984ff8	true	introspection.token.claim
643df8e9-febc-477d-bf99-31c8ed984ff8	true	userinfo.token.claim
643df8e9-febc-477d-bf99-31c8ed984ff8	true	id.token.claim
643df8e9-febc-477d-bf99-31c8ed984ff8	true	access.token.claim
643df8e9-febc-477d-bf99-31c8ed984ff8	clientHost	claim.name
643df8e9-febc-477d-bf99-31c8ed984ff8	String	jsonType.label
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	client_id	user.session.note
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	true	introspection.token.claim
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	true	userinfo.token.claim
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	true	id.token.claim
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	true	access.token.claim
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	client_id	claim.name
b0061a07-fb62-4e5a-b36e-d0370cb9de9b	String	jsonType.label
76595108-8bbd-4738-90c6-628e8a2775da	true	introspection.token.claim
76595108-8bbd-4738-90c6-628e8a2775da	true	userinfo.token.claim
76595108-8bbd-4738-90c6-628e8a2775da	picture	user.attribute
76595108-8bbd-4738-90c6-628e8a2775da	true	id.token.claim
76595108-8bbd-4738-90c6-628e8a2775da	true	access.token.claim
76595108-8bbd-4738-90c6-628e8a2775da	picture	claim.name
76595108-8bbd-4738-90c6-628e8a2775da	String	jsonType.label
76595108-8bbd-4738-90c6-628e8a2775da	false	aggregate.attrs
76595108-8bbd-4738-90c6-628e8a2775da	false	multivalued
76595108-8bbd-4738-90c6-628e8a2775da	false	lightweight.claim
4eb5a50c-71d0-4b15-b621-63177ed093e7	client_id	user.session.note
4eb5a50c-71d0-4b15-b621-63177ed093e7	true	introspection.token.claim
4eb5a50c-71d0-4b15-b621-63177ed093e7	true	userinfo.token.claim
4eb5a50c-71d0-4b15-b621-63177ed093e7	true	id.token.claim
4eb5a50c-71d0-4b15-b621-63177ed093e7	true	access.token.claim
4eb5a50c-71d0-4b15-b621-63177ed093e7	client_id	claim.name
4eb5a50c-71d0-4b15-b621-63177ed093e7	String	jsonType.label
a7b91c9f-a618-405b-818f-fc74977f46da	clientAddress	user.session.note
a7b91c9f-a618-405b-818f-fc74977f46da	true	introspection.token.claim
a7b91c9f-a618-405b-818f-fc74977f46da	true	userinfo.token.claim
a7b91c9f-a618-405b-818f-fc74977f46da	true	id.token.claim
a7b91c9f-a618-405b-818f-fc74977f46da	true	access.token.claim
a7b91c9f-a618-405b-818f-fc74977f46da	clientAddress	claim.name
a7b91c9f-a618-405b-818f-fc74977f46da	String	jsonType.label
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	clientHost	user.session.note
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	true	introspection.token.claim
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	true	userinfo.token.claim
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	true	id.token.claim
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	true	access.token.claim
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	clientHost	claim.name
f5a8d13f-bbe8-4fd1-921a-f45cc730e71d	String	jsonType.label
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	false	introspection.token.claim
9322796d-84b4-477b-9ab7-74325d1ee1b8	true	id.token.claim
9322796d-84b4-477b-9ab7-74325d1ee1b8	foo	user.attribute
9322796d-84b4-477b-9ab7-74325d1ee1b8	true	access.token.claim
9322796d-84b4-477b-9ab7-74325d1ee1b8	String	jsonType.label
9322796d-84b4-477b-9ab7-74325d1ee1b8	true	multivalued
9322796d-84b4-477b-9ab7-74325d1ee1b8	true	userinfo.token.claim
9322796d-84b4-477b-9ab7-74325d1ee1b8	false	introspection.token.claim
9322796d-84b4-477b-9ab7-74325d1ee1b8	false	lightweight.claim
9322796d-84b4-477b-9ab7-74325d1ee1b8	roles	claim.name
9322796d-84b4-477b-9ab7-74325d1ee1b8	ROLE_	usermodel.realmRoleMapping.rolePrefix
82eab3f6-852a-4b4e-96d4-e9a5e9c4ce8e	createyourhumanity-eco1	usermodel.clientRoleMapping.clientId
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	NONE	1800	36000	f	f	26888d86-910c-41fb-8ce5-29d04c068510	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	582602f7-7c64-487d-8be4-3a05eb876d48	4769f0a4-49ba-420d-881a-fe69002f2a5b	cb05c7bc-3b8d-4e34-aaa6-2f8e1679aca3	ddcb76c2-a6e7-4ce1-b131-c89688b4a1c6	5478677e-0214-4975-a140-346576191016	2592000	f	900	t	f	da93d782-72c3-4991-a54e-f414de321148	0	t	0	0	9da3e296-2ec9-475e-9b0d-c6014bfd4c44
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	60	300	300		keycloak.v2		t	f	0		heartfull-mind-ecosystems	1730626266	\N	t	f	t	f	NONE	1800	36000	f	t	387ca314-961f-445b-a3ae-283df119b373	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	31f488c9-84e6-4d73-9bdf-49bf767e2761	fef0844e-0a7f-48ef-8afe-117d2c0c2f21	2f17e380-7659-43eb-8a06-f84dc0ba1d8b	48fc5fc5-77c6-4585-a0ce-bf99d2b63254	f71f75a7-6384-4ceb-91b4-48cb94a69260	86400	f	900	t	f	20a77515-6765-465f-bff2-98408578062c	0	f	0	0	a068e2db-1dd1-4728-a059-f6ffa5b9509e
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
bruteForceProtected	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
permanentLockout	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
maxTemporaryLockouts	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
maxFailureWaitSeconds	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	900
minimumQuickLoginWaitSeconds	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	60
waitIncrementSeconds	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	60
quickLoginCheckMilliSeconds	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1000
maxDeltaTimeSeconds	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	43200
failureFactor	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	30
realmReusableOtpCode	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
firstBrokerLoginFlowId	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	c65e56ec-02bd-479f-b6d1-f5c94fcf9841
displayName	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	Keycloak
defaultSignatureAlgorithm	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	RS256
offlineSessionMaxLifespanEnabled	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
offlineSessionMaxLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5184000
displayNameHtml	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	<div class="kc-logo-text"><span>Heartfull-Mind Keycloak</span></div>
bruteForceProtected	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
permanentLockout	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
maxTemporaryLockouts	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
maxFailureWaitSeconds	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	900
minimumQuickLoginWaitSeconds	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	60
waitIncrementSeconds	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	60
quickLoginCheckMilliSeconds	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1000
maxDeltaTimeSeconds	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	43200
failureFactor	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	30
realmReusableOtpCode	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
defaultSignatureAlgorithm	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	RS256
offlineSessionMaxLifespanEnabled	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
offlineSessionMaxLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	5184000
clientSessionIdleTimeout	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
clientSessionMaxLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
clientOfflineSessionIdleTimeout	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
clientOfflineSessionMaxLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
actionTokenGeneratedByAdminLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	43200
actionTokenGeneratedByUserLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	300
oauth2DeviceCodeLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	600
oauth2DevicePollingInterval	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	5
webAuthnPolicyRpEntityName	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	keycloak
webAuthnPolicySignatureAlgorithms	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	ES256
webAuthnPolicyRpId	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	
webAuthnPolicyAttestationConveyancePreference	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyAuthenticatorAttachment	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyRequireResidentKey	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyUserVerificationRequirement	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyCreateTimeout	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
webAuthnPolicyAvoidSameAuthenticatorRegister	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
webAuthnPolicyRpEntityNamePasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	ES256
webAuthnPolicyRpIdPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	
webAuthnPolicyAttestationConveyancePreferencePasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyRequireResidentKeyPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	not specified
webAuthnPolicyCreateTimeoutPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
cibaBackchannelTokenDeliveryMode	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	poll
cibaExpiresIn	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	120
cibaInterval	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	5
organizationsEnabled	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	true
cibaAuthRequestedUserHint	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	login_hint
parRequestUriLifespan	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	60
firstBrokerLoginFlowId	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	a116be67-51ee-45cf-8b4b-703ce965c4ce
client-policies.profiles	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	{"profiles":[]}
client-policies.policies	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	{"policies":[]}
acr.loa.map	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	{}
_browser_header.contentSecurityPolicyReportOnly	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	
_browser_header.xContentTypeOptions	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	nosniff
_browser_header.referrerPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	no-referrer
_browser_header.xRobotsTag	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	none
_browser_header.xFrameOptions	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	SAMEORIGIN
_browser_header.contentSecurityPolicy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	frame-src 'self' http://localhost:5173 http://localhost:9080; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	1; mode=block
_browser_header.strictTransportSecurity	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	max-age=31536000; includeSubDomains
frontendUrl	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	http://localhost:9080
frontendUrl	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	
displayName	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	MMMM - Heartfull Mind et @AII
displayNameHtml	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	MMMM - Heartfull Mind et @AII
acr.loa.map	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	{}
cibaBackchannelTokenDeliveryMode	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	poll
cibaExpiresIn	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	120
cibaAuthRequestedUserHint	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	login_hint
parRequestUriLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	60
cibaInterval	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5
actionTokenGeneratedByAdminLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	43200
actionTokenGeneratedByUserLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	300
oauth2DeviceCodeLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	600
oauth2DevicePollingInterval	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	5
clientSessionIdleTimeout	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
clientSessionMaxLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
clientOfflineSessionIdleTimeout	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
clientOfflineSessionMaxLifespan	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
webAuthnPolicyRpEntityName	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	keycloak
webAuthnPolicySignatureAlgorithms	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ES256,RS256
webAuthnPolicyRpId	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	
webAuthnPolicyAttestationConveyancePreference	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyAuthenticatorAttachment	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyRequireResidentKey	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyUserVerificationRequirement	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyCreateTimeout	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
webAuthnPolicyAvoidSameAuthenticatorRegister	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
webAuthnPolicyRpEntityNamePasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	ES256,RS256
webAuthnPolicyRpIdPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	
webAuthnPolicyAttestationConveyancePreferencePasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
bruteForceStrategy	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	MULTIPLE
adminPermissionsEnabled	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
verifiableCredentialsEnabled	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
organizationsEnabled	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	true
webAuthnPolicyRequireResidentKeyPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	not specified
webAuthnPolicyCreateTimeoutPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	false
client-policies.profiles	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	{"profiles":[]}
client-policies.policies	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	
_browser_header.xContentTypeOptions	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	nosniff
_browser_header.referrerPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	no-referrer
_browser_header.xRobotsTag	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	none
_browser_header.xFrameOptions	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	SAMEORIGIN
_browser_header.contentSecurityPolicy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	frame-src 'self' http://localhost:9000 http://localhost:4040; frame-ancestors 'self' http://localhost:9000 http://localhost:4040; script-src 'self' 'unsafe-eval'
_browser_header.xXSSProtection	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	1; mode=block
_browser_header.strictTransportSecurity	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	max-age=31536000; includeSubDomains
bruteForceStrategy	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	MULTIPLE
adminPermissionsEnabled	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
verifiableCredentialsEnabled	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	false
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	ac61b8f5-26a9-464a-82cd-c23e956e91ca
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	14d80ddb-700c-4ca2-90f4-fdee3504ab6f
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	jboss-logging
b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474
password	password	t	t	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.redirect_uris (client_id, value) FROM stdin;
1247f9f5-471b-43e3-a468-0090c66d9756	/realms/master/account/*
124e0ebc-264a-4040-baf0-75742f76e176	/realms/master/account/*
fef5fa01-fb03-428b-a87e-ab41930d6e8d	/realms/heartfull-mind-ecosystems/account/*
a1d6d92c-61a4-4995-b335-575ff839e6e4	/realms/heartfull-mind-ecosystems/account/*
7131682d-2564-4e5e-afa9-4979a1b8d08a	/admin/heartfull-mind-ecosystems/console/*
d8022315-1de9-4c99-a5a5-d0f1b7561889	*
279c38e5-81e9-4a81-82e9-031f5878374e	*
2bdc627e-50a0-493e-a38c-f0b8def716cd	*
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	http://localhost:9080/*
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	/admin/master/console/*
68ba78c7-2a44-4adb-b3c8-0907759d3266	*
\.


--
-- Data for Name: relationships; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.relationships (id, user_id, related_user_id, relationship_type, relationship_status, created_at) FROM stdin;
c81c2f68-65df-4609-8463-1985af7c16d0	e1de8244-6459-4324-9899-18c439bd2bb2	d66621eb-6fff-4972-a0cd-1c23818b9fb3	NONE	ACCEPTED	2024-12-17 21:56:51.847882
d08c0b3a-6a42-45d0-9127-56e257cbdb0f	e1de8244-6459-4324-9899-18c439bd2bb2	1d2fcd71-0a16-4420-a90b-ddfbf7822168	NONE	ACCEPTED	2024-12-17 22:00:02.50317
e3e880fc-1b19-4c0c-afff-f8c26d4d8f51	1d2fcd71-0a16-4420-a90b-ddfbf7822168	e1de8244-6459-4324-9899-18c439bd2bb2	NONE	ACCEPTED	2024-12-17 22:00:02.503249
e785940a-24fb-40e3-a571-096453c60370	e1de8244-6459-4324-9899-18c439bd2bb2	f5582653-d8b6-40ec-8fd3-d75c8c89be07	NONE	ACCEPTED	2024-12-17 22:16:33.631624
96027e9c-b05f-4a71-884a-8ea4178a9861	f5582653-d8b6-40ec-8fd3-d75c8c89be07	e1de8244-6459-4324-9899-18c439bd2bb2	NONE	ACCEPTED	2024-12-17 22:16:33.631724
c0308338-5b9a-4569-879a-e9acc11f803f	e1de8244-6459-4324-9899-18c439bd2bb2	ff27cc46-149a-4854-9da1-468e391a3176	NONE	ACCEPTED	2024-12-17 22:17:40.545336
164271cf-c7a7-4c78-ac89-b1773558f126	ff27cc46-149a-4854-9da1-468e391a3176	1d2fcd71-0a16-4420-a90b-ddfbf7822168	NONE	ACCEPTED	2024-12-17 22:46:18.375533
00542644-e147-4b68-b079-a4a68bde9298	1d2fcd71-0a16-4420-a90b-ddfbf7822168	ff27cc46-149a-4854-9da1-468e391a3176	NONE	ACCEPTED	2024-12-17 22:46:18.375611
6ed9ad0e-2c4a-40f6-8438-e4da72c13272	d66621eb-6fff-4972-a0cd-1c23818b9fb3	1d2fcd71-0a16-4420-a90b-ddfbf7822168	NONE	ACCEPTED	2024-12-18 02:21:43.37826
32d794d1-e74b-4e5a-8b8b-bf75f6acd9cd	1d2fcd71-0a16-4420-a90b-ddfbf7822168	d66621eb-6fff-4972-a0cd-1c23818b9fb3	NONE	ACCEPTED	2024-12-18 02:21:43.378397
85702a2b-4a7a-4b49-b1c5-5c57f5a004f2	ff27cc46-149a-4854-9da1-468e391a3176	f5582653-d8b6-40ec-8fd3-d75c8c89be07	NONE	ACCEPTED	2024-12-19 08:37:28.19517
5013261b-5d46-4ecc-b48c-b231846afb07	f5582653-d8b6-40ec-8fd3-d75c8c89be07	ff27cc46-149a-4854-9da1-468e391a3176	NONE	ACCEPTED	2024-12-19 08:37:28.195262
2cbeca06-5a24-4e8a-b812-3b19d46b3870	1d2fcd71-0a16-4420-a90b-ddfbf7822168	f5582653-d8b6-40ec-8fd3-d75c8c89be07	NONE	ACCEPTED	2024-12-21 13:02:43.189185
89cf566a-a9f9-439b-bea8-7c972474df84	f5582653-d8b6-40ec-8fd3-d75c8c89be07	1d2fcd71-0a16-4420-a90b-ddfbf7822168	NONE	ACCEPTED	2024-12-21 13:02:43.189343
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
0c26e79a-2245-4524-9c3b-8e940f495547	VERIFY_EMAIL	Verify Email	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	VERIFY_EMAIL	50
3cf187da-870f-4b5f-a7f2-137e5b81ad21	UPDATE_PROFILE	Update Profile	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	UPDATE_PROFILE	40
c66030e6-9283-4753-be3a-bc241ca74899	CONFIGURE_TOTP	Configure OTP	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	CONFIGURE_TOTP	10
ab4dc832-f231-494b-b8b2-2e66715bff27	UPDATE_PASSWORD	Update Password	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	UPDATE_PASSWORD	30
b1286175-d3d1-4830-bc97-25733746828f	TERMS_AND_CONDITIONS	Terms and Conditions	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	f	TERMS_AND_CONDITIONS	20
31d062bb-caed-4e89-972f-d69b660f0f79	delete_account	Delete Account	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	f	f	delete_account	60
11346f08-2b68-4987-86c9-40124305ebc5	delete_credential	Delete Credential	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	delete_credential	100
29e1f866-781a-4150-b54d-e028e823e35e	update_user_locale	Update User Locale	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	update_user_locale	1000
a577e081-e48a-4162-9d01-8f922e5a3eb2	webauthn-register	Webauthn Register	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	webauthn-register	70
bf6f31f1-2805-482f-a308-4f0643e6a29d	webauthn-register-passwordless	Webauthn Register Passwordless	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	webauthn-register-passwordless	80
badadce9-b693-4edc-a93e-cf3de0485044	VERIFY_PROFILE	Verify Profile	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	t	f	VERIFY_PROFILE	90
2aa51d74-b00d-4bba-b951-3e3b729b6a4c	CONFIGURE_TOTP	Configure OTP	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	CONFIGURE_TOTP	10
959afb8f-024b-49f2-b766-133b00fb5e22	TERMS_AND_CONDITIONS	Terms and Conditions	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f	f	TERMS_AND_CONDITIONS	20
e499b29e-dc36-4f2f-9067-023616eb3c86	UPDATE_PASSWORD	Update Password	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	UPDATE_PASSWORD	30
19bc797c-88ad-4b62-b51c-6312f9c56cfa	UPDATE_PROFILE	Update Profile	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	UPDATE_PROFILE	40
f7d9d91b-c82b-4452-b124-acfca848c56e	VERIFY_EMAIL	Verify Email	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	VERIFY_EMAIL	50
35d13bb3-93f3-47e3-8dc7-b5bcc1f83f1d	delete_account	Delete Account	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	f	f	delete_account	60
aad58720-0969-4740-ab0e-4e1addcb40f2	webauthn-register	Webauthn Register	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	webauthn-register	70
6ad75a27-cec7-4270-97ee-c2607be0fd86	webauthn-register-passwordless	Webauthn Register Passwordless	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	webauthn-register-passwordless	80
38e3e19b-3af6-4532-983a-f3c320cbefc9	VERIFY_PROFILE	Verify Profile	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	VERIFY_PROFILE	90
c6f86c85-35ad-47f4-90b0-708a7de269f4	delete_credential	Delete Credential	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	delete_credential	100
b6dd8eef-d1f0-46a9-a006-18e7718a468f	update_user_locale	Update User Locale	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
d8022315-1de9-4c99-a5a5-d0f1b7561889	t	0	1
68ba78c7-2a44-4adb-b3c8-0907759d3266	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
1d9e61b7-2874-4a7c-b7d6-f72e571cec9e	Default Policy	A policy that grants access only for users within this realm	js	0	0	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
9dd168b9-7f0b-4d45-99af-6f62e3a6c68b	Default Permission	A permission that applies to the default resource type	resource	1	0	68ba78c7-2a44-4adb-b3c8-0907759d3266	\N
6ed573fe-3ec2-4958-81c3-c83e0d5c8982	Default Policy	A policy that grants access only for users within this realm	js	0	0	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
8ba195db-2f2b-4cea-afb0-36e2ef67db14	Default Permission	A permission that applies to the default resource type	resource	1	0	d8022315-1de9-4c99-a5a5-d0f1b7561889	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
9dc8fbeb-066a-4566-9562-54982ee88e6c	Default Resource	urn:heartfullmind-registry:resources:default	\N	d8022315-1de9-4c99-a5a5-d0f1b7561889	d8022315-1de9-4c99-a5a5-d0f1b7561889	f	\N
14ebb36b-504b-4fba-a17a-3cb1ee5c0001	Default Resource	urn:createyourhumanity-eco1:resources:default	\N	68ba78c7-2a44-4adb-b3c8-0907759d3266	68ba78c7-2a44-4adb-b3c8-0907759d3266	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.resource_uris (resource_id, value) FROM stdin;
9dc8fbeb-066a-4566-9562-54982ee88e6c	/*
14ebb36b-504b-4fba-a17a-3cb1ee5c0001	/*
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
124e0ebc-264a-4040-baf0-75742f76e176	191a1e3c-81d8-4528-9b76-e0522764c3df
124e0ebc-264a-4040-baf0-75742f76e176	272b7ba3-0ede-47aa-a8a0-cee2a986a5e7
a1d6d92c-61a4-4995-b335-575ff839e6e4	7a7913d1-d521-4598-afc6-deb6652f72e8
a1d6d92c-61a4-4995-b335-575ff839e6e4	8743c44d-92c6-4a7d-8449-e594521241cb
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
a7aa34ea-3e45-4a61-b739-8964209a5624	\N	97a2d81d-869e-490c-b248-e1f0418e9786	f	t	\N	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	service-account-heartfull-mind-eco1	1726113052015	279c38e5-81e9-4a81-82e9-031f5878374e	0
e1de8244-6459-4324-9899-18c439bd2bb2	miklo.manuel@gmail.com	miklo.manuel@gmail.com	t	t	\N	Manuel Matthias	Miklo	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	miklo.manuel@gmail.com	1730011027418	\N	0
d66621eb-6fff-4972-a0cd-1c23818b9fb3	ceo@heartfull-mind.space	ceo@heartfull-mind.space	t	t	\N	Manuel Matthias	Miklo	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	ceo@heartfull-mind.space	1730019474820	\N	0
a222cddc-acd2-4c68-873a-5b4fe79112ce	\N	8d81a903-f567-434a-8c91-0a22eaf19883	f	t	\N	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	service-account-heartfullmind-registry	1730045396614	d8022315-1de9-4c99-a5a5-d0f1b7561889	0
ff27cc46-149a-4854-9da1-468e391a3176	m.lukic@gmx.ch	m.lukic@gmx.ch	t	t	\N	Mirjana	Lukic	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	m.lukic@gmx.ch	1730365409860	\N	0
1d2fcd71-0a16-4420-a90b-ddfbf7822168	manuelmiklo@outlook.com	manuelmiklo@outlook.com	t	t	\N	Manuel Matthias	Miklo	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	manuelmiklo@outlook.com	1730365483119	\N	0
792e4095-1b5e-4458-b3f1-f53160b257cc	\N	de847e27-adf4-42dc-8d6a-f3bd62a2fa70	f	t	\N	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	service-account-heartfullmind-gateway	1730438273902	2bdc627e-50a0-493e-a38c-f0b8def716cd	0
f5582653-d8b6-40ec-8fd3-d75c8c89be07	manuelmiklo@gmx.ch	manuelmiklo@gmx.ch	f	t	\N	Manuel	Miklo	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	mikimaus	1730618139948	\N	0
7ae7e312-5d22-4493-a3f4-efc514f62fa6	\N	81ad6254-492e-4d5d-82ad-fc69a66da49d	f	t	\N	\N	\N	b9ca8624-c415-4a5f-92b0-bfb1a5be1dc7	service-account-createyourhumanity-eco1	1730031334251	68ba78c7-2a44-4adb-b3c8-0907759d3266	0
995c90fc-53da-4281-b872-c816c9813419	manuelmiklo@outlook.com	manuelmiklo@outlook.com	t	t	\N	Manuel Matthias	Miklo	e0a9b24b-6d9b-4cc1-9f59-f7000e0c4474	manuelmiklo@outlook.com	1733718043921	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
2c726557-b7d6-43da-a82d-1d9f593cf394	e1de8244-6459-4324-9899-18c439bd2bb2	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	e1de8244-6459-4324-9899-18c439bd2bb2	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	e1de8244-6459-4324-9899-18c439bd2bb2	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	d66621eb-6fff-4972-a0cd-1c23818b9fb3	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	d66621eb-6fff-4972-a0cd-1c23818b9fb3	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	ff27cc46-149a-4854-9da1-468e391a3176	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	ff27cc46-149a-4854-9da1-468e391a3176	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	1d2fcd71-0a16-4420-a90b-ddfbf7822168	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	1d2fcd71-0a16-4420-a90b-ddfbf7822168	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	792e4095-1b5e-4458-b3f1-f53160b257cc	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	792e4095-1b5e-4458-b3f1-f53160b257cc	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	f5582653-d8b6-40ec-8fd3-d75c8c89be07	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	f5582653-d8b6-40ec-8fd3-d75c8c89be07	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	a7aa34ea-3e45-4a61-b739-8964209a5624	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	a7aa34ea-3e45-4a61-b739-8964209a5624	UNMANAGED
2c726557-b7d6-43da-a82d-1d9f593cf394	a7aa34ea-3e45-4a61-b739-8964209a5624	UNMANAGED
981cb719-795e-4aa9-803f-2b4a8a05e72e	995c90fc-53da-4281-b872-c816c9813419	UNMANAGED
2bdb95db-a3d8-4197-85c9-fc4edfbacdbf	995c90fc-53da-4281-b872-c816c9813419	UNMANAGED
00eebfef-553f-490c-8878-860221d94083	995c90fc-53da-4281-b872-c816c9813419	UNMANAGED
2c726557-b7d6-43da-a82d-1d9f593cf394	1d2fcd71-0a16-4420-a90b-ddfbf7822168	UNMANAGED
ac61b8f5-26a9-464a-82cd-c23e956e91ca	7ae7e312-5d22-4493-a3f4-efc514f62fa6	UNMANAGED
14d80ddb-700c-4ca2-90f4-fdee3504ab6f	7ae7e312-5d22-4493-a3f4-efc514f62fa6	UNMANAGED
2c726557-b7d6-43da-a82d-1d9f593cf394	7ae7e312-5d22-4493-a3f4-efc514f62fa6	UNMANAGED
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
f5582653-d8b6-40ec-8fd3-d75c8c89be07	VERIFY_EMAIL
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
4bcb9852-3ccb-46d3-b2a0-a54ef1194650	1d2fcd71-0a16-4420-a90b-ddfbf7822168
a068e2db-1dd1-4728-a059-f6ffa5b9509e	1d2fcd71-0a16-4420-a90b-ddfbf7822168
99528dfc-0bd6-467b-abd0-ed77614fc3ec	1d2fcd71-0a16-4420-a90b-ddfbf7822168
8398d143-8ee7-4e9b-8871-6e3efc86cf17	1d2fcd71-0a16-4420-a90b-ddfbf7822168
c6942ee1-1ae7-4359-b070-abbbe88d2ab9	1d2fcd71-0a16-4420-a90b-ddfbf7822168
ea99cd2e-298f-42ac-9e84-78c9ac306471	1d2fcd71-0a16-4420-a90b-ddfbf7822168
a068e2db-1dd1-4728-a059-f6ffa5b9509e	a7aa34ea-3e45-4a61-b739-8964209a5624
a068e2db-1dd1-4728-a059-f6ffa5b9509e	e1de8244-6459-4324-9899-18c439bd2bb2
a068e2db-1dd1-4728-a059-f6ffa5b9509e	d66621eb-6fff-4972-a0cd-1c23818b9fb3
ee82eea5-a77e-4957-ac7d-d101ebf8d6b6	a7aa34ea-3e45-4a61-b739-8964209a5624
a068e2db-1dd1-4728-a059-f6ffa5b9509e	a222cddc-acd2-4c68-873a-5b4fe79112ce
552bf6cf-ab99-41b7-a52f-b8a0fa9ab072	a222cddc-acd2-4c68-873a-5b4fe79112ce
bf8039b0-2383-46a2-8984-70181183fe9d	d66621eb-6fff-4972-a0cd-1c23818b9fb3
9a5094e6-aa1a-4000-92f3-14529adde708	d66621eb-6fff-4972-a0cd-1c23818b9fb3
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	d66621eb-6fff-4972-a0cd-1c23818b9fb3
15684013-5798-4086-a1a8-be405032793f	e1de8244-6459-4324-9899-18c439bd2bb2
d2460f21-4313-4d9b-bb20-d6d91efeb98a	e1de8244-6459-4324-9899-18c439bd2bb2
552bf6cf-ab99-41b7-a52f-b8a0fa9ab072	e1de8244-6459-4324-9899-18c439bd2bb2
ee82eea5-a77e-4957-ac7d-d101ebf8d6b6	e1de8244-6459-4324-9899-18c439bd2bb2
7c1e8490-c4f0-42c2-a505-598d10ae184a	e1de8244-6459-4324-9899-18c439bd2bb2
7c1e8490-c4f0-42c2-a505-598d10ae184a	a222cddc-acd2-4c68-873a-5b4fe79112ce
d2460f21-4313-4d9b-bb20-d6d91efeb98a	a222cddc-acd2-4c68-873a-5b4fe79112ce
15684013-5798-4086-a1a8-be405032793f	a222cddc-acd2-4c68-873a-5b4fe79112ce
425b2a0d-c498-4874-bef4-d5d28b0ce805	a7aa34ea-3e45-4a61-b739-8964209a5624
80d7cb45-1fb6-450e-aed0-81ec7f8e75d7	a7aa34ea-3e45-4a61-b739-8964209a5624
aaa2f021-de84-4adf-9365-ed62bec2a092	a7aa34ea-3e45-4a61-b739-8964209a5624
8743c44d-92c6-4a7d-8449-e594521241cb	a7aa34ea-3e45-4a61-b739-8964209a5624
f01045e9-ea5f-4da5-a4fb-4245e9e228a6	a7aa34ea-3e45-4a61-b739-8964209a5624
38a9a276-661d-4383-aa70-bcb5c335fb37	a7aa34ea-3e45-4a61-b739-8964209a5624
fe78251b-a519-4c3f-9c04-7b02a74bba83	a7aa34ea-3e45-4a61-b739-8964209a5624
fe78251b-a519-4c3f-9c04-7b02a74bba83	a222cddc-acd2-4c68-873a-5b4fe79112ce
38a9a276-661d-4383-aa70-bcb5c335fb37	a222cddc-acd2-4c68-873a-5b4fe79112ce
f01045e9-ea5f-4da5-a4fb-4245e9e228a6	a222cddc-acd2-4c68-873a-5b4fe79112ce
8743c44d-92c6-4a7d-8449-e594521241cb	a222cddc-acd2-4c68-873a-5b4fe79112ce
bf8039b0-2383-46a2-8984-70181183fe9d	e1de8244-6459-4324-9899-18c439bd2bb2
9a5094e6-aa1a-4000-92f3-14529adde708	e1de8244-6459-4324-9899-18c439bd2bb2
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	e1de8244-6459-4324-9899-18c439bd2bb2
a068e2db-1dd1-4728-a059-f6ffa5b9509e	ff27cc46-149a-4854-9da1-468e391a3176
a068e2db-1dd1-4728-a059-f6ffa5b9509e	792e4095-1b5e-4458-b3f1-f53160b257cc
fe78251b-a519-4c3f-9c04-7b02a74bba83	792e4095-1b5e-4458-b3f1-f53160b257cc
38a9a276-661d-4383-aa70-bcb5c335fb37	792e4095-1b5e-4458-b3f1-f53160b257cc
813f572a-58be-40b9-b77a-8708795eddc2	792e4095-1b5e-4458-b3f1-f53160b257cc
4ec19010-b333-4792-a2c7-21d0da80295b	792e4095-1b5e-4458-b3f1-f53160b257cc
8743c44d-92c6-4a7d-8449-e594521241cb	792e4095-1b5e-4458-b3f1-f53160b257cc
b6c4b649-3d8e-4eb6-820f-d43ca1aa5c7f	792e4095-1b5e-4458-b3f1-f53160b257cc
f01045e9-ea5f-4da5-a4fb-4245e9e228a6	792e4095-1b5e-4458-b3f1-f53160b257cc
813f572a-58be-40b9-b77a-8708795eddc2	e1de8244-6459-4324-9899-18c439bd2bb2
4ec19010-b333-4792-a2c7-21d0da80295b	e1de8244-6459-4324-9899-18c439bd2bb2
b6c4b649-3d8e-4eb6-820f-d43ca1aa5c7f	e1de8244-6459-4324-9899-18c439bd2bb2
a068e2db-1dd1-4728-a059-f6ffa5b9509e	f5582653-d8b6-40ec-8fd3-d75c8c89be07
fe78251b-a519-4c3f-9c04-7b02a74bba83	e1de8244-6459-4324-9899-18c439bd2bb2
3e553391-4025-4202-bce4-dce3fa73fcfa	e1de8244-6459-4324-9899-18c439bd2bb2
38a9a276-661d-4383-aa70-bcb5c335fb37	e1de8244-6459-4324-9899-18c439bd2bb2
8743c44d-92c6-4a7d-8449-e594521241cb	e1de8244-6459-4324-9899-18c439bd2bb2
799f58fd-a439-46c8-8164-3048fdd18b07	e1de8244-6459-4324-9899-18c439bd2bb2
cdc4f95f-694f-4081-9cc6-ef733c3240d6	e1de8244-6459-4324-9899-18c439bd2bb2
19d7d028-794a-4c36-a4cd-e327e54b425e	995c90fc-53da-4281-b872-c816c9813419
c1130730-0678-440e-a238-799e3b736f15	995c90fc-53da-4281-b872-c816c9813419
fa0647f2-c702-4140-b71c-f9f8b6647827	995c90fc-53da-4281-b872-c816c9813419
3d1741fc-e2b4-4b90-accb-988a9f714f22	995c90fc-53da-4281-b872-c816c9813419
602b318e-7fb7-4d96-89b0-2ef51c716ccd	995c90fc-53da-4281-b872-c816c9813419
48ba143c-920d-4e6f-9269-95ce2cd68429	995c90fc-53da-4281-b872-c816c9813419
4c84b836-c8ac-407d-9b6e-d3af82f899d3	995c90fc-53da-4281-b872-c816c9813419
e5f26260-37db-4dca-ac03-7d1b49d6eaf9	995c90fc-53da-4281-b872-c816c9813419
646212a3-aa2d-4f83-830a-97d6175cec31	995c90fc-53da-4281-b872-c816c9813419
4a9d7645-5ffd-41fa-9205-8672bb0bf2f9	995c90fc-53da-4281-b872-c816c9813419
9536f65d-3baa-4c30-b901-bb3784386c48	995c90fc-53da-4281-b872-c816c9813419
cc13c810-39d6-4c18-b375-d19badf3a7e3	995c90fc-53da-4281-b872-c816c9813419
e316b8b0-e70d-4eb5-b8dd-e1238f50f55f	995c90fc-53da-4281-b872-c816c9813419
eb35da88-eae9-48a3-a31e-6e7d4a0e1007	995c90fc-53da-4281-b872-c816c9813419
77e19fdb-f87b-47b8-aaed-23e9b9d7f677	995c90fc-53da-4281-b872-c816c9813419
0490d337-ce56-49e4-9271-6e0a0911d121	e1de8244-6459-4324-9899-18c439bd2bb2
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	7ae7e312-5d22-4493-a3f4-efc514f62fa6
0490d337-ce56-49e4-9271-6e0a0911d121	1d2fcd71-0a16-4420-a90b-ddfbf7822168
0490d337-ce56-49e4-9271-6e0a0911d121	7ae7e312-5d22-4493-a3f4-efc514f62fa6
bf8039b0-2383-46a2-8984-70181183fe9d	7ae7e312-5d22-4493-a3f4-efc514f62fa6
9a5094e6-aa1a-4000-92f3-14529adde708	7ae7e312-5d22-4493-a3f4-efc514f62fa6
9a5094e6-aa1a-4000-92f3-14529adde708	1d2fcd71-0a16-4420-a90b-ddfbf7822168
97c70393-a1db-48f9-b95c-265aa571cf20	1d2fcd71-0a16-4420-a90b-ddfbf7822168
4b92914a-9bc2-4f0b-a5bf-a2654b5612ef	995c90fc-53da-4281-b872-c816c9813419
f68612c2-3c81-4e40-b138-f3b213ea00c8	995c90fc-53da-4281-b872-c816c9813419
550d465b-59af-4476-9d84-4b91779332bd	995c90fc-53da-4281-b872-c816c9813419
43dc5f01-17cb-408c-a7a0-036e4d73568e	995c90fc-53da-4281-b872-c816c9813419
79f13cd6-1256-4f8e-a993-94c60abe855e	995c90fc-53da-4281-b872-c816c9813419
189bafb3-c872-4bd7-b760-98f9d3959350	995c90fc-53da-4281-b872-c816c9813419
191a1e3c-81d8-4528-9b76-e0522764c3df	995c90fc-53da-4281-b872-c816c9813419
272b7ba3-0ede-47aa-a8a0-cee2a986a5e7	995c90fc-53da-4281-b872-c816c9813419
b4580b8f-cebc-476b-a0cc-6507bccb9ff9	1d2fcd71-0a16-4420-a90b-ddfbf7822168
bf8039b0-2383-46a2-8984-70181183fe9d	1d2fcd71-0a16-4420-a90b-ddfbf7822168
f0d5a5ce-1b3e-46df-84c8-7ea6e44bf1f0	995c90fc-53da-4281-b872-c816c9813419
eb87501c-cd44-4227-a678-d37be100c890	995c90fc-53da-4281-b872-c816c9813419
7349abd4-9c2c-47a2-be7c-9e3182828eea	995c90fc-53da-4281-b872-c816c9813419
6f56fd4e-58e1-4836-849e-e8408f8f4f32	995c90fc-53da-4281-b872-c816c9813419
7adf4073-297f-4846-a439-d2b820df8cb1	995c90fc-53da-4281-b872-c816c9813419
667e772a-7f57-49d4-a897-d2d60754e7ee	995c90fc-53da-4281-b872-c816c9813419
a9967f5e-1856-4c82-bd84-10271bcd7368	995c90fc-53da-4281-b872-c816c9813419
9da3e296-2ec9-475e-9b0d-c6014bfd4c44	995c90fc-53da-4281-b872-c816c9813419
e823f359-03e4-4ffa-adbc-4a5a9cc2544e	995c90fc-53da-4281-b872-c816c9813419
bd217b82-9afc-4f4a-88bf-081d7e6afe78	995c90fc-53da-4281-b872-c816c9813419
e7d6b67c-3ed5-4ac4-87d9-b12a0bf1fe9d	995c90fc-53da-4281-b872-c816c9813419
1f692249-0214-4051-97e5-21d2a602ca43	995c90fc-53da-4281-b872-c816c9813419
1fb3d34a-8a5a-4fa8-b9da-9911109f9e2f	995c90fc-53da-4281-b872-c816c9813419
910bcebc-fadf-4bb7-88c8-dcc0eb4b6c9a	995c90fc-53da-4281-b872-c816c9813419
5f67d52d-59ef-4fc0-8fa3-448b57ef8cae	995c90fc-53da-4281-b872-c816c9813419
8b4c7182-52c1-4ef5-a4a5-0a9190e2707a	995c90fc-53da-4281-b872-c816c9813419
59f32ed0-d785-44c1-a7bd-13619e5be6b0	995c90fc-53da-4281-b872-c816c9813419
a4febe02-d874-4ec4-b726-81297eb5b171	995c90fc-53da-4281-b872-c816c9813419
b1488019-b041-45ce-a5f2-b62b94ad8710	995c90fc-53da-4281-b872-c816c9813419
ee109e23-37d9-47f7-9751-e85c9e74a753	995c90fc-53da-4281-b872-c816c9813419
8b7824f7-ec41-4ebd-b71f-a2ae6dc7350a	995c90fc-53da-4281-b872-c816c9813419
5fefcdb1-2a74-4e4a-919a-8f601066915b	995c90fc-53da-4281-b872-c816c9813419
502b8c04-ae3b-4350-9441-5e08edc4bc30	995c90fc-53da-4281-b872-c816c9813419
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: heartfullmind
--

COPY public.web_origins (client_id, value) FROM stdin;
7131682d-2564-4e5e-afa9-4979a1b8d08a	+
d8022315-1de9-4c99-a5a5-d0f1b7561889	*
279c38e5-81e9-4a81-82e9-031f5878374e	*
2bdc627e-50a0-493e-a38c-f0b8def716cd	*
3a18b29a-cb33-406c-b8ca-60d3131f4f1b	http://localhost:5173
68ba78c7-2a44-4adb-b3c8-0907759d3266	http://localhost:8080
68ba78c7-2a44-4adb-b3c8-0907759d3266	http://localhost:9080
68ba78c7-2a44-4adb-b3c8-0907759d3266	http://localhost:4040
68ba78c7-2a44-4adb-b3c8-0907759d3266	+
68ba78c7-2a44-4adb-b3c8-0907759d3266	http://localhost:9000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: friends_requests FRIENDS_REQUESTS_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.friends_requests
    ADD CONSTRAINT "FRIENDS_REQUESTS_pkey" PRIMARY KEY (id);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: relationships RELATIONSHIPS_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT "RELATIONSHIPS_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: jgroups_ping jgroups_ping_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT jgroups_ping_pkey PRIMARY KEY (address, cluster_name);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: example_company pk_company; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.example_company
    ADD CONSTRAINT pk_company PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: heartfullmind
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: relationships fk_related_user; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_related_user FOREIGN KEY (related_user_id) REFERENCES public.user_entity(id);


--
-- Name: friends_requests fk_related_user_friends_request; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.friends_requests
    ADD CONSTRAINT fk_related_user_friends_request FOREIGN KEY (related_user_id) REFERENCES public.user_entity(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: friends_requests fk_user_friends_request; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.friends_requests
    ADD CONSTRAINT fk_user_friends_request FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: relationships fk_user_relationship; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT fk_user_relationship FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: heartfullmind
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

