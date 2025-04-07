# Declare function
function action {
    if [[ -n ${SA_ID} ]];
    then
        # Send request
        curl --request GET \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/serviceaccounts/${SA_ID}/tokens
        echo ""
    else
        echo "Must given --id."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            SA_ID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve tokens."
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve all tokens which service account had."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Service account ID number."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
