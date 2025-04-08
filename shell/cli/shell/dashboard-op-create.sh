#@AUTH-TOKENS

# Declare varialbe
[ -z ${DB_MSG} ] && export DB_MSG=
[ -z ${DB_ID} ] && export DB_ID=null
[ -z ${DB_FOLDER_UID} ] && export DB_FOLDER_UID=

# Declare function
function action {
    if [[ -n ${DB_TITLE} && -n ${DB_FOLDER_UID} && -n ${DB_MSG} ]]; then
        # Generate request data
        model='{ "id": '${DB_ID}', "title": "'${DB_TITLE}'", "tags": [], "timezone": "browser", "schemaVersion": 16, "refresh": "25s" }'
        if [[ -n ${DB_TEMPLATE_PATH} && -e ${DB_TEMPLATE_PATH} ]]; then
            model=$(cat ${DB_TEMPLATE_PATH} | sed -e "s/{DB_TITLE}/${DB_TITLE}/g" | tr '\r\n' ' ' | sed -e 's/ //g')
        fi
        data='{ "dashboard": '${model}', "folderUid": "'${DB_FOLDER_UID}'", "message": "'${DB_MSG}'", "overwrite": false }'
        # Send request
        curl --silent --request POST \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
            --data "${data}" \
            ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/dashboards/db
        echo ""
    else
        echo "Must given --title, --msg, --fuid."
    fi
}

function args {
    key=${1}
    value=${2}
    case ${key} in
        "--id")
            DB_ID=${value}
            ;;
        "--title")
            DB_TITLE=${value}
            ;;
        "--msg")
            DB_MSG=${value}
            ;;
        "--fuid")
            DB_FOLDER_UID=${value}
            ;;
        "--template")
            DB_TEMPLATE_PATH=${value}
            ;;
    esac
    return 0
}

function short {
    echo "Create new Dashboard"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Create new folder"
    echo "Works with latest API Token."
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with Command."
    echo "    --id              [Optional] Dashboard ID, given will update it."
    echo "    --title           Dashboard title."
    echo "    --template        Dashboard model template path."
    echo "    --msg             Dashboard version history message."
    echo "    --fuid            Folder UID which Dashboard will push in."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
