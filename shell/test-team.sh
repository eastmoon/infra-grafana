## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- Team operation -----"
### Create auth-token
token=admin-token
role=Admin
if [ -z $(api sys auth.token) ]; then
    echo "----- Auth create -----"
    if [ $(api auth ls | grep ${token} | wc -l) -gt 0 ]; then
        tokenId=$(api auth ls | grep ${token} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
        api auth rm --id=${tokenId}
    fi
    api auth create --name=${token} --role=${role}
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
