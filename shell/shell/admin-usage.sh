# Declare function
function action {
    curl --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        ${GF_SERVER_PROTOCOL}://${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD}@${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/admin/usage-report-preview
    echo ""
}

function args {
    return 0
}

function short {
    echo "Grafana Usage Report preview"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Grafana Usage Report preview."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
