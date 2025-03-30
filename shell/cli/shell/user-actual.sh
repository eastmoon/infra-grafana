# Declare function
function action {
    if [[ -n ${USER_ACTUAL_USERNAME} && -n ${USER_ACTUAL_PASSWORD} ]];
    then
        curl --silent --request GET \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${USER_ACTUAL_USERNAME}:${USER_ACTUAL_PASSWORD} \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/user
        echo ""
    else
        echo "Must given --username and --passwrod."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--username")
            USER_ACTUAL_USERNAME=${value}
            ;;
        "--password")
            USER_ACTUAL_PASSWORD=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve actual user informaation"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve actual user informaation."
    echo "Only works with Basic Authentication (username and password)."
    echo "This api is for single user operate, like"
    echo "  - update password"
    echo "  - switch user context to the given organization"
    echo "  - List organizations of the actual user"
    echo "  - List teams of the actual user"
    echo "  - etc."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --username        The username for actual target."
    echo "    --password        The password for actual target."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
