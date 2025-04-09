#@AUTH-TOKENS

# Declare function
function action {
    curl --silent --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/datasources | sed "s/\[{/\[\n{/" | sed "s/}\]/}\n\]/" | sed "s/},/},\n/g"
    echo ""
}

function args {
    return 0
}

function short {
    echo "Get all data sources"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Get all data sources"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
