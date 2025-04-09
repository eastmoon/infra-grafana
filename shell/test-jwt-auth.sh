## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Organization operation -----"
token=$(python3 -c \
"import jwt
import time

private_key = open('/usr/share/grafana/host/certs/private_key.pem', 'rb').read()

payload = {
    'sub': 'admin',
    'iat': int(time.time())
}

token = jwt.encode(payload, private_key, algorithm='RS256')
print(f'auth_token={token}')")

echo "${GF_SERVER_PROTOCOL}://localhost:${GF_SERVER_HTTP_PORT}?${token}"
