## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- Team operation -----"
### Create auth-token
saname=Admin-Demo
satoken=Admin-Token
sarole=Admin
satmpfile=/tmp/satoken
if [ -z $(api sys auth.token) ]; then
    echo "----- Auth create -----"
    [ $(api sa ls | grep ${saname} | wc -l) -eq 0 ] && api sa create --name=${saname} --role=${sarole} || true
    said=$(api sa ls | grep ${saname} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
    if [ $(api sa token.ls --id=${said} | grep ${satoken} | wc -l) -gt 0 ]; then
        satid=$(api sa token.ls --id=${said} | grep ${satoken} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
        api sa token.rm --id=${said} --tid=${satid}
    fi
    api sa token.create --id=${said} --name=${satoken} | tee ${satmpfile}
    api sys auth.token.save --file=${satmpfile}
    echo "----- Auth create END -----"
fi
### Show all team
api team ls
### Create new team and remove it
name=demo
email=demo@demo.org
api team create --name=${name} --email=${email}
id=$(api team ls | grep ${name} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
echo ${name} : ${id}
api team rm --id=${id}
[ $(api team ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api team ls | grep ${name})
