# Declare variable
[ -z ${USER_LIST_PERPAGE} ] && export USER_LIST_PERPAGE=1000
[ -z ${USER_LIST_PAGE} ] && export USER_LIST_PAGE=1

# Declare function
function action {
    QS="perpage=${USER_LIST_PERPAGE}&page=${USER_LIST_PAGE}"
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/users?${QS} | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--perpage")
            USER_LIST_PERPAGE=${value}
            ;;
        "--page")
            USER_LIST_PAGE=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Search Users information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Search Users information."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --perpage         How many user every page need return."
    echo "    --page            Return page number."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
