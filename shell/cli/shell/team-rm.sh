#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${TEAM_INFO_ID} ]];
    then
        curl --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/teams/${TEAM_INFO_ID}
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
            TEAM_INFO_ID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Remove team"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Remove team by ID."
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Retrieve team with ID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
