#@AUTH-TOKENS


# Declare function
function action {
    if [[ -n ${DB_UID} ]]; then
        curl --silent --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/dashboards/uid/${DB_UID}
        echo ""
    else
        echo "Must given --uid."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--uid")
            DB_UID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Remove Dashboard information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Remove Dashboard information"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --uid            Target Dashboard UID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
