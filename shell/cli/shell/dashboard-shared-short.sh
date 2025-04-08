#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${DB_URL} ]]; then
        # Generate request data
        data='{ "path": '${DB_URL}' }'
        # Send request
        curl --silent --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/short-urls
        echo ""
    else
        echo "Must given --url."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--url")
            DB_URL=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Short URL API"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Dashboard shared short URL API"
    echo "Ref : https://grafana.com/docs/grafana/latest/developers/http_api/short_url/"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --url             Target Dashboard URL."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
