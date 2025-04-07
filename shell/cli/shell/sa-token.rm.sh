# Declare function
function action {
    if [[ -n ${SA_ID} && -n ${SA_TOKEN_ID} ]];
    then
        # Send request
        curl --silent --request DELETE  \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/serviceaccounts/${SA_ID}/tokens/${SA_TOKEN_ID}
        echo ""
    else
        echo "Must given --id and --tid."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            SA_ID=${value}
            ;;
        "--tid")
            SA_TOKEN_ID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Remove API token"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Remove API token."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Service account ID number."
    echo "    --tid             Token ID which Service account had."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
