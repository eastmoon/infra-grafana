# Declare function
function action {
    if [[ -n ${ORGS_ID} ]];
    then
        curl --request GET \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            ${GF_SERVER_PROTOCOL}://${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD}@${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/orgs/${ORGS_ID}/users
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
            ORGS_ID=${value}
            ;;
        "--name")
            ORGS_NAME=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve users in organization"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve users in organization."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --id              Use organization id to retrieve organization information."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
