### Create auth-token
saname=Admin-Demo
satoken=Admin-Token
sarole=Admin
satmpfile=/tmp/satoken
if [ -z $(api sys auth.token) ]; then
    echo "----- Auth create -----"
    [ $(api sa ls | grep ${saname} | wc -l) -eq 0 ] && api sa create --name=${saname} --role=${sarole} || true
    said=$(api sa ls | grep ${saname} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
    if [ $(api sa token.ls --id=${said} | grep ${satoken} | wc -l) -gt 0 ]; then
        satid=$(api sa token.ls --id=${said} | grep ${satoken} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
        api sa token.rm --id=${said} --tid=${satid}
    fi
    api sa token.create --id=${said} --name=${satoken} | tee ${satmpfile}
    api sys auth.token.save --file=${satmpfile}
    echo "----- Auth create END -----"
fi
