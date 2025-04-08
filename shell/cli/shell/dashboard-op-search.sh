#@AUTH-TOKENS

# Declare varialbe
[ -z ${DB_SEARCH_TYPE} ] && export DB_SEARCH_TYPE=

# Declare function
function action {
    QS="type=${DB_SEARCH_TYPE}"
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/search?${QS} | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--db")
            DB_SEARCH_TYPE=dash-db
            ;;
        "--folder")
            DB_SEARCH_TYPE=dash-folder
            ;;
    esac
    return 0
}

function short {
    echo "Search Dashboard/Folder lists"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Search Dashboard/Folder lists"
    echo "Works with latest API Token."
    echo "Ref : https://grafana.com/docs/grafana/latest/developers/http_api/folder_dashboard_search/"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --db              Search type change to 'dash-db'"
    echo "    --folder          Search type change to 'dash-folder'"
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
