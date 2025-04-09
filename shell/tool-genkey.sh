# ref : How to generate a JWK representing a self-signed certificate, https://darutk.medium.com/jwk-representing-self-signed-certificate-65276d70021b
# ref : PEM to JWK, https://irrte.ch/jwt-js-decode/pem2jwk.html

## Execute Script
if [ -d ${1} ]; then
    #### 1. Create a private key
    ssh-keygen -t rsa -b 4096 -m PEM -f ${1}/private_key.pem -N ""
    #### 2. Extract the public key from the private key
    openssl rsa -in ${1}/private_key.pem -pubout -outform PEM -out ${1}/public_key.pem
fi
