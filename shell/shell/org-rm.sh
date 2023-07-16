# Declare function
function action {
    if [[ -n ${ORGS_ID} ]];
    then
        curl --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            ${GF_SERVER_PROTOCOL}://${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD}@${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/orgs/${ORGS_ID}
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
    esac
    return 0
}

function short {
    echo "Delete Organization by ID"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Delete Organization by ID."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --id              Target organization ID for delete."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
