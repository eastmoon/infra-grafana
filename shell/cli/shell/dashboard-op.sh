# Declare function
function action {
    help
}

function args {
    return 0
}

function short {
    echo "Dashboard operation"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Dashboard operation"
    echo "Ref : https://grafana.com/docs/grafana/latest/developers/http_api/dashboard/"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
