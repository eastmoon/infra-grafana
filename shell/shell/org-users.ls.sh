# Declare function
function action {
    if [[ -n ${ORGS_ID} ]];
    then
        curl --silent --request GET \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/orgs/${ORGS_ID}/users | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
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
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Use organization id to retrieve organization information."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
