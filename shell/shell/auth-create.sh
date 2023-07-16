# Declare varialbe
[ -z ${AUTH_TOKEN_NAME} ] && export AUTH_TOKEN_NAME=
[ -z ${AUTH_TOKEN_ROLE} ] && export AUTH_TOKEN_ROLE=Viewer
[ -z ${AUTH_TOKEN_STL} ] && export AUTH_TOKEN_STL=86400
[ -z ${AUTH_TOKEN_ORG} ] && export AUTH_TOKEN_ORG=

# Declare function
function action {
    if [[ -n ${AUTH_TOKEN_NAME} ]];
    then
        # Generate request data
        data='{"name": "'${AUTH_TOKEN_NAME}'", "role": "'${AUTH_TOKEN_ROLE}'", "secondsToLive": '${AUTH_TOKEN_STL}'}'
        # Send request
        curl --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "X-Grafana-Org-Id: ${AUTH_TOKEN_ORG}" \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD}@${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/auth/keys | tee ~/.tokentmp
        # Parser token information to /home directory
        for str in $(cat ~/.tokentmp | sed 's/{//g' | sed 's/}//g' | sed 's/\"//g' | sed 's/,/ /g')
        do
            IFS=':' read -ra ADDR <<< "${str}"
            key=${ADDR[0]}
            value=${ADDR[1]}
            export AUTH_TOKEN_TMP_${key^^}="${value}"
        done
        echo ${AUTH_TOKEN_TMP_KEY} > ~/.${AUTH_TOKEN_TMP_ID}_${AUTH_TOKEN_TMP_NAME}.token
        rm ~/.tokentmp
        echo ""
    else
        echo "Must given --name."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--name")
            AUTH_TOKEN_NAME=${value}
            ;;
        "--role")
            AUTH_TOKEN_ROLE=${value}
            ;;
        "--stl")
            AUTH_TOKEN_STL=${value}
            ;;
        "--org")
            AUTH_TOKEN_ORG=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new API token"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new API token."
    echo "Only works with Basic Authentication (username and password)."
    echo "Admin users command could do :"
    echo " - new user"
    echo " - update password"
    echo " - modify permissions"
    echo " - delete user"
    echo " - return session information and logout user."
    echo "But all users list, it need call User API."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    echo "    --name            The key name."
    echo "    --role            Sets the access level/Grafana Role for the key. Default use 'Viewer', could change 'Editor', 'Admin'"
    echo "    --stl             Sets the key expiration in seconds. Default use 86400, or set 0 for use 'api_key_max_seconds_to_live' value."
    echo "    --org             Organization ID, default will use current context organization."
    command-description ${BASH_SOURCE##*/}
}


# Execute script
"$@"
