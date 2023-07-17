#@AUTH-TOKENS

# Declare function
function action {
    QS="perpage=${TEAM_LIST_PERPAGE}&page=${TEAM_LIST_PAGE}"
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/teams/search?${QS} | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--perpage")
            TEAM_LIST_PERPAGE=${value}
            ;;
        "--page")
            TEAM_LIST_PAGE=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Retrieve current team information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve current team information."
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --perpage         How many team every page need return."
    echo "    --page            Return page number."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
