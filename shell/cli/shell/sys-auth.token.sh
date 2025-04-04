#@AUTH-TOKENS

# Declare function
function action {
    echo ${UTILS_AUTH_TOKENS}
}

function args {
    return 0
}

function short {
    echo "Returns Grafana api token information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Returns Grafana api token information"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
