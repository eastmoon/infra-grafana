# Declare function
function action {
    curl --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/health
    echo ""
}

function args {
    return 0
}

function short {
    echo "Returns health information about Grafana"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Returns health information about Grafana"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
