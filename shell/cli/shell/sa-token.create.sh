# Declare varialbe
[ -z ${SA_TOKEN_NAME} ] && export SA_TOKEN_NAME=
[ -z ${SA_TOKEN_STL} ] && export SA_TOKEN_STL=604800

# Declare function
function action {
    if [[ -n ${SA_ID} && -n ${SA_TOKEN_NAME} ]];
    then
        # Generate request data
        data='{"name": "'${SA_TOKEN_NAME}'", "secondsToLive": '${SA_TOKEN_STL}'}'
        # Send request
        curl --silent --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/serviceaccounts/${SA_ID}/tokens
        echo ""
    else
        echo "Must given --id and --name."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            SA_ID=${value}
            ;;
        "--name")
            SA_TOKEN_NAME=${value}
            ;;
        "--stl")
            SA_TOKEN_STL=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new API token"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new API token."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Service account ID number."
    echo "    --name            The token name."
    echo "    --stl             Sets the token expiration in seconds. Default use ${AUTH_TOKEN_STL}, or set 0 for use 'api_key_max_seconds_to_live' value."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
