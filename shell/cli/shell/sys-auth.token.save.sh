#@AUTH-TOKENS

# Declare function
function action {
    # Parser token information to /home directory
    for str in $(cat ${TOKEN_FILE} | sed 's/{//g' | sed 's/}//g' | sed 's/\"//g' | sed 's/,/ /g')
    do
        IFS=':' read -ra ADDR <<< "${str}"
        key=${ADDR[0]}
        value=${ADDR[1]}
        echo ${key} : ${value}
        export AUTH_TOKEN_TMP_${key^^}="${value}"
    done
    find ~/ -type f -iname .[0-9]*_*.token -delete
    echo ${AUTH_TOKEN_TMP_KEY} > ~/.${AUTH_TOKEN_TMP_ID}_${AUTH_TOKEN_TMP_NAME}.token
    rm ${TOKEN_FILE}
    echo ""
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--file")
            TOKEN_FILE=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Save Grafana api token information"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Returns Grafana api token information"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --file            Token information temp file path."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
