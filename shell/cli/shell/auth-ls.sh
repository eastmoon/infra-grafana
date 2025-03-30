# Declare function
function action {
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
        --header "X-Grafana-Org-Id: ${AUTH_TOKEN_ORG}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/auth/keys | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
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
    echo "    --help, -h        Show more information with Command."
    echo "    --org             Organization ID, default will use current context organization."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
