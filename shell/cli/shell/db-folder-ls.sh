#@AUTH-TOKENS

# Declare function
function action {
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/folders/${FOLDER_UID} | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--uid")
            FOLDER_UID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Get folder information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Get all folders or retrieve folder information"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --uid              Target folder UID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
