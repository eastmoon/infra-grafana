#@AUTH-TOKENS

# Declare function
function action {
    curl --request GET \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${UTILS_AUTH_TOKENS}" \
        ${GF_SERVER_PROTOCOL}://${GF_SERVER_HTTP_ADDR}:${GF_SERVER_HTTP_PORT}/api/org/users
    echo ""
}

function args {
    return 0
}

function short {
    echo "Retrieve all users within the current organization"
}

function help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Retrieve all users within the current organization."
    echo "Works with latest API Token."
    echo "Update users with user id, PATCH /api/org/users/:userId"
    echo "Delete user in users list, DELETE /api/org/users/:userId"
    echo ""
    echo "Options:"
    echo "    --help, -h        Show more information with UP Command."
    command-description ${BASH_SOURCE##*/}
}

# Execute script
"$@"
