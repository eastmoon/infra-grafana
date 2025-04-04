# Declare function
function action {
    if [[ -n ${ADMIN_USERS_USERID} ]]; then
        curl --request DELETE  \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/admin/users/${ADMIN_USERS_USERID}
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
            ADMIN_USERS_USERID=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Remove user"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Remove user, if user have register in system."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              Target user ID."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
