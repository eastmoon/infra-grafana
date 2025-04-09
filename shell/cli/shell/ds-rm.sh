#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${DS_UID} ]]; then
        curl --silent --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/datasources/uid/${DS_UID}
        echo ""
    elif [[ -n ${DS_NAME} ]]; then
        curl --silent --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/datasources/name/${DS_NAME}
        echo ""
    else
        echo "Must given --uid or --name."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--uid")
            DS_UID=${value}
            ;;
        "--name")
            DS_NAME=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Delete an existing data source"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Delete an existing data source by uid or name"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --uid             Target Data Source UID."
    echo "    --name            Target Data Source name."

    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
