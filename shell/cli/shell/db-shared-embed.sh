#@AUTH-TOKENS

# Declare function
function action {
    if [[ -n ${DB_URL} ]]; then
        echo "${DB_URL//\/d\//\/d-solo\/}?panelId=${DB_PID}"
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
        "--pid")
            DB_PID=${value}
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
    echo "    --pid             Target Panel ID."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
