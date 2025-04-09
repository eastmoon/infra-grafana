#@AUTH-TOKENS

# Declare function
function action {
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/dashboards/public-dashboards
    echo ""
}

function args {
    return 0
}

function short {
    echo "Get a list of all shared dashboards"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Get a list of all shared dashboards with pagination"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
