#@AUTH-TOKENS

# Declare varialbe

# Declare function
function action {
    if [[ -n ${DS_NAME} && -n ${DS_TEMPLATE_PATH} && -e ${DS_TEMPLATE_PATH} ]]; then
        # Generate request data
        data=$(cat ${DS_TEMPLATE_PATH} | sed -e "s/{DS_NAME}/${DS_NAME}/g" | tr '\r\n' ' ' | sed -e 's/ //g')
        # Send request
        curl --silent --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/datasources
        echo ""
    else
        echo "Must given --name, --template."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--name")
            DS_NAME=${value}
            ;;
        "--template")
            DS_TEMPLATE_PATH=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new Data Source"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new Data Source"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --name            Data Source name."
    echo "    --template        Data Source model template path."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
