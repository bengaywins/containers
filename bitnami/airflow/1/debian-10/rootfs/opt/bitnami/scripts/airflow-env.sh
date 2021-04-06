#!/bin/bash
#
# Environment configuration for airflow

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-airflow}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
airflow_env_vars=(
    AIRFLOW_USERNAME
    AIRFLOW_PASSWORD
    AIRFLOW_FIRSTNAME
    AIRFLOW_LASTNAME
    AIRFLOW_EMAIL
    AIRFLOW_EXECUTOR
    AIRFLOW_FERNET_KEY
    AIRFLOW_WEBSERVER_HOST
    AIRFLOW_WEBSERVER_PORT_NUMBER
    AIRFLOW_LOAD_EXAMPLES
    AIRFLOW_BASE_URL
    AIRFLOW_HOSTNAME_CALLABLE
    AIRFLOW_POOL_NAME
    AIRFLOW_POOL_SIZE
    AIRFLOW_POOL_DESC
    AIRFLOW_DATABASE_HOST
    AIRFLOW_DATABASE_PORT_NUMBER
    AIRFLOW_DATABASE_NAME
    AIRFLOW_DATABASE_USERNAME
    AIRFLOW_DATABASE_PASSWORD
    AIRFLOW_DATABASE_USE_SSL
    AIRFLOW_REDIS_USE_SSL
    REDIS_HOST
    REDIS_PORT_NUMBER
    REDIS_USER
    REDIS_PASSWORD
    AIRFLOW_LDAP_ENABLE
    AIRFLOW_LDAP_URI
    AIRFLOW_LDAP_SEARCH
    AIRFLOW_LDAP_BIND_USER
    AIRFLOW_LDAP_BIND_PASSWORD
    AIRFLOW_LDAP_UID_FIELD
    AIRFLOW_LDAP_USE_TLS
    AIRFLOW_LDAP_ALLOW_SELF_SIGNED
    AIRFLOW_LDAP_TLS_CA_CERTIFICATE
    AIRFLOW_USER_REGISTRATION_ROLE
)
for env_var in "${airflow_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset airflow_env_vars

# Airflow paths
export AIRFLOW_BASE_DIR="${BITNAMI_ROOT_DIR}/airflow"
export AIRFLOW_HOME="${AIRFLOW_BASE_DIR}"
export AIRFLOW_BIN_DIR="${AIRFLOW_BASE_DIR}/venv/bin"
export AIRFLOW_VOLUME_DIR="/bitnami/airflow"
export AIRFLOW_DATA_DIR="${AIRFLOW_BASE_DIR}/data"
export AIRFLOW_LOGS_DIR="${AIRFLOW_BASE_DIR}/logs"
export AIRFLOW_LOG_FILE="${AIRFLOW_LOGS_DIR}/airflow-webserver.log"
export AIRFLOW_CONF_FILE="${AIRFLOW_BASE_DIR}/airflow.cfg"
export AIRFLOW_WEBSERVER_CONF_FILE="${AIRFLOW_BASE_DIR}/webserver_config.py"
export AIRFLOW_TMP_DIR="${AIRFLOW_BASE_DIR}/tmp"
export AIRFLOW_PID_FILE="${AIRFLOW_TMP_DIR}/airflow-webserver.pid"
export AIRFLOW_DATA_TO_PERSIST="$AIRFLOW_DATA_DIR"
export AIRFLOW_DAGS_DIR="${AIRFLOW_BASE_DIR}/dags"

# System users (when running with a privileged user)
export AIRFLOW_DAEMON_USER="airflow"
export AIRFLOW_DAEMON_GROUP="airflow"

# User configuration
export AIRFLOW_USERNAME="${AIRFLOW_USERNAME:-user}"
export AIRFLOW_PASSWORD="${AIRFLOW_PASSWORD:-bitnami}"
export AIRFLOW_FIRSTNAME="${AIRFLOW_FIRSTNAME:-Firstname}"
export AIRFLOW_LASTNAME="${AIRFLOW_LASTNAME:-Lastname}"
export AIRFLOW_EMAIL="${AIRFLOW_EMAIL:-user@example.com}"

# Airflow configuration
export AIRFLOW_EXECUTOR="${AIRFLOW_EXECUTOR:-SequentialExecutor}"
export AIRFLOW_FERNET_KEY="${AIRFLOW_FERNET_KEY:-}"
export AIRFLOW_WEBSERVER_HOST="${AIRFLOW_WEBSERVER_HOST:-127.0.0.1}"
export AIRFLOW_WEBSERVER_PORT_NUMBER="${AIRFLOW_WEBSERVER_PORT_NUMBER:-8080}"
export AIRFLOW_LOAD_EXAMPLES="${AIRFLOW_LOAD_EXAMPLES:-yes}"
export AIRFLOW_BASE_URL="${AIRFLOW_BASE_URL:-}"
export AIRFLOW_HOSTNAME_CALLABLE="${AIRFLOW_HOSTNAME_CALLABLE:-}"
export AIRFLOW_POOL_NAME="${AIRFLOW_POOL_NAME:-}"
export AIRFLOW_POOL_SIZE="${AIRFLOW_POOL_SIZE:-}"
export AIRFLOW_POOL_DESC="${AIRFLOW_POOL_DESC:-}"

# Airflow database configuration
export AIRFLOW_DATABASE_HOST="${AIRFLOW_DATABASE_HOST:-postgresql}"
export AIRFLOW_DATABASE_PORT_NUMBER="${AIRFLOW_DATABASE_PORT_NUMBER:-5432}"
export AIRFLOW_DATABASE_NAME="${AIRFLOW_DATABASE_NAME:-bitnami_airflow}"
export AIRFLOW_DATABASE_USERNAME="${AIRFLOW_DATABASE_USERNAME:-bn_airflow}"
export AIRFLOW_DATABASE_PASSWORD="${AIRFLOW_DATABASE_PASSWORD:-}"
export AIRFLOW_DATABASE_USE_SSL="${AIRFLOW_DATABASE_USE_SSL:-no}"
export AIRFLOW_REDIS_USE_SSL="${AIRFLOW_REDIS_USE_SSL:-no}"
export REDIS_HOST="${REDIS_HOST:-redis}"
export REDIS_PORT_NUMBER="${REDIS_PORT_NUMBER:-6379}"
export REDIS_USER="${REDIS_USER:-}"
export REDIS_PASSWORD="${REDIS_PASSWORD:-}"

# Airflow LDAP configuration
export AIRFLOW_LDAP_ENABLE="${AIRFLOW_LDAP_ENABLE:-no}"
export AIRFLOW_LDAP_URI="${AIRFLOW_LDAP_URI:-}"
export AIRFLOW_LDAP_SEARCH="${AIRFLOW_LDAP_SEARCH:-}"
export AIRFLOW_LDAP_BIND_USER="${AIRFLOW_LDAP_BIND_USER:-}"
export AIRFLOW_LDAP_BIND_PASSWORD="${AIRFLOW_LDAP_BIND_PASSWORD:-}"
export AIRFLOW_LDAP_UID_FIELD="${AIRFLOW_LDAP_UID_FIELD:-}"
export AIRFLOW_LDAP_USE_TLS="${AIRFLOW_LDAP_USE_TLS:-False}"
export AIRFLOW_LDAP_ALLOW_SELF_SIGNED="${AIRFLOW_LDAP_ALLOW_SELF_SIGNED:-True}"
export AIRFLOW_LDAP_TLS_CA_CERTIFICATE="${AIRFLOW_LDAP_TLS_CA_CERTIFICATE:-}"
export AIRFLOW_USER_REGISTRATION_ROLE="${AIRFLOW_USER_REGISTRATION_ROLE:-Public}"

# Custom environment variables may be defined below
