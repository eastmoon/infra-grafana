# Declare function
function action {
    if [[ -n ${AUTH_TOKEN_ID} ]];
    then
        # Send request
        curl --request DELETE \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --user ${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD} \
            --header "X-Grafana-Org-Id: ${AUTH_TOKEN_ORG}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/auth/keys/${AUTH_TOKEN_ID}
        # Delete cache file
        [ $(find ~/ -type f -iname .${AUTH_TOKEN_ID}_*.token | wc -l) -gt 0 ] && rm $(find ~/ -type f -iname .${AUTH_TOKEN_ID}_*.token)
        echo ""
    else
        echo "Must given --id."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            AUTH_TOKEN_ID=${value}
            ;;
        "--org")
            AUTH_TOKEN_ORG=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Remove API tokens list"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Remove API tokens list."
    echo "Only works with Basic Authentication (username and password)."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --id              API token ID number."
    echo "    --org             Organization ID, default will use current context organization."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
