# Declare function
function action {
    if [[ -n ${USER_INFO_ID} ]];
    then
        curl --silent --request GET \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/users/${USER_INFO_ID}
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
            USER_INFO_ID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve single user informaation"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve single user informaation."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Restrieve user with ID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
