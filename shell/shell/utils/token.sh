# Declare variable

# Declare function
function current-token {
    for token_file in $(find ~/ -type f -iname .*.token | sort -r | head -n 1)
    do
        export UTILS_AUTH_TOKENS_FILE=${token_file}
        export UTILS_AUTH_TOKENS=$(cat ${token_file})
    done
}

# Execute script
current-token
