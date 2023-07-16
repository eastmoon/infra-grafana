# Declare function
function action {
    curl --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "X-Grafana-Org-Id: ${AUTH_TOKEN_ORG}" \
        ${GF_SERVER_PROTOCOL}://${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD}@${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/auth/keys
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--org")
            AUTH_TOKEN_ORG=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve API tokens list"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve API tokens list."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --org             Organization ID, default will use current context organization."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
