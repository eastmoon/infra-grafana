# Declare function
function action {
    if [[ -n ${ADMIN_USERS_USERNAME} && -n ${ADMIN_USERS_PASSWORD} ]];
    then
        data='{"name": "'${ADMIN_USERS_USERNAME^}'", "email": "'${ADMIN_USERS_USERNAME,,}@example.com'", "login": "'${ADMIN_USERS_USERNAME,,}'", "password": "'${ADMIN_USERS_PASSWORD}'"}'
        curl --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/admin/users
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
            ADMIN_USERS_USERNAME=${value}
            ;;
        "--password")
            ADMIN_USERS_PASSWORD=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new user"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new user, this command must given necessary options."
    echo "Only works with Basic Authentication (username and password)."
    echo "Admin users command could do :"
    echo " - new user"
    echo " - update password"
    echo " - modify permissions"
    echo " - delete user"
    echo " - return session information and logout user."
    echo "But all users list, it need call User API."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --username        New username for user."
    echo "    --password        The password for user."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
