#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${FOLDER_UID} ]]; then
        curl --silent --request GET \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/folders/${FOLDER_UID}/permissions | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
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
            FOLDER_UID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Get folder permissions"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Get folder permissions"
    echo "Works with latest API Token."
    echo "Update folder permissions, can reference https://grafana.com/docs/grafana/latest/developers/http_api/folder_permissions/."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --uid              Target folder UID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
