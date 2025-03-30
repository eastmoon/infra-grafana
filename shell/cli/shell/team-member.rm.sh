#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${TEAM_INFO_ID} && -n ${TEAM_ADD_USERID} ]];
    then
        curl --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/teams/${TEAM_INFO_ID}/members/${TEAM_ADD_USERID}
        echo ""
    else
        echo "Must given --id, --userId."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            TEAM_INFO_ID=${value}
            ;;
        "--userId")
            TEAM_ADD_USERID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Remove user from team member"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Remove user from team member."
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Team ID."
    echo "    --userId          User ID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
