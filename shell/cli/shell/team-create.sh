#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${TEAM_CREATE_NAME} ]];
    then
        # Generate request data
        data='{"name": "'${TEAM_CREATE_NAME}'", "email": "'${TEAM_CREATE_EMAIL}'"}'
        # Send request
        curl --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/teams
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
            TEAM_CREATE_NAME=${value}
            ;;
        "--email")
            TEAM_CREATE_EMAIL=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new team in current organization"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new team in current organization."
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --name            Team name."
    echo "    --email           [ Optional ] Team email."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
