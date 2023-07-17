# Declare function
function action {
    help
}

function args {
    return 0
}

function short {
    echo "Organization API"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Execute Organization API"
    echo "Ref : https://grafana.com/docs/grafana/latest/developers/http_api/user"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
