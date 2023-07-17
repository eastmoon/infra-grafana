# Declare function
function action {
    ORGS_API_URL=/api/orgs
    if [ -z ${ORGS_NAME} ];
    then
        ORGS_API_URL=${ORGS_API_URL}/${ORGS_ID}
    else
        ORGS_API_URL=${ORGS_API_URL}/name/${ORGS_NAME}
    fi

    curl --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}${ORGS_API_URL}
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            ORGS_ID=${value}
            ;;
        "--name")
            ORGS_NAME=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve organization list or information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve organization list or information."
    echo "Only works with Basic Authentication (username and password)."
    echo "Use ID or Name to retrieve organization information."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --id              Use organization id to retrieve organization information."
    echo "    --name            Use organization name to retrieve organization information"
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
