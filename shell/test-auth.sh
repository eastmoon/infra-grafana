## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- Authentication operation -----"
### Show all auth
api auth ls
### Create new auth token and remove it
name=demo-auth
role=Admin
api auth create --name=${name} --token=${role}
id=$(api auth ls | grep ${name} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
echo ${name} : ${id}
api auth rm --id=${id}
[ $(api auth ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api auth ls | grep ${name})
