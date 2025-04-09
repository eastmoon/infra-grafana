#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${FOLDER_NAME} ]]; then
        # Generate request data
        data='{"title": "'${FOLDER_NAME}'", "parentUid": "'${FOLDER_PARENT_UID}'"}'
        # Send request
        curl --silent --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/folders
        echo ""
    else
        echo "Must given --title."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--title")
            FOLDER_NAME=${value}
            ;;
        "--puid")
            FOLDER_PARENT_UID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new folder"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new folder"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --title           New folder title."
    echo "    --puid            [Optional] New folder parent UID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
