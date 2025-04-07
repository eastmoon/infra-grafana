# Declare varialbe
[ -z ${SA_NAME} ] && export SA_NAME=
[ -z ${SA_ROLE} ] && export SA_ROLE=Viewer

# Declare function
function action {
    if [[ -n ${SA_NAME} ]];
    then
        # Generate request data
        data='{"name": "'${SA_NAME}'", "role": "'${SA_ROLE}'", "isDisabled": false}'
        # Send request
        curl --silent --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/serviceaccounts
        echo ""
    else
        echo "Must given --name."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--name")
            SA_NAME=${value}
            ;;
        "--role")
            SA_ROLE=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new service account"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new service account."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --name            The account name."
    echo "    --role            Sets the access level/Grafana Role for the key. Default use 'Viewer', could change 'Editor', 'Admin'"
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
