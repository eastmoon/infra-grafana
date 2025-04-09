# Declare function
function action {
    help
}

function args {
    return 0
}

function short {
    echo "Data Source API"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Data Source API"
    echo "Ref : https://grafana.com/docs/grafana/latest/developers/http_api/data_source/"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
