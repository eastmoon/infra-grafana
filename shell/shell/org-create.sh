# Declare function
function action {
    if [[ -n ${ORGS_NAME} ]];
    then
        # Generate request data
        data='{"name": "'${ORGS_NAME}'"}'
        # Send request
        curl --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/orgs
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
            ORGS_NAME=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create Organization by Name"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create Organization by Name."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --name            New organization name"
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
