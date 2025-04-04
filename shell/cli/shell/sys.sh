# Declare function
function action {
    help
}

function args {
    return 0
}

function short {
    echo "CLI system information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
