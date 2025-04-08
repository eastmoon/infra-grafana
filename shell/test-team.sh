## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- Team operation -----"
### Create auth-token
source tool-get-auth.sh
### Show all team
api team ls
### Create new team and remove it
name=demo
email=demo@demo.org
api team create --name=${name} --email=${email}
id=$(api team ls | grep ${name} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo ${name} : ${id}
api team rm --id=${id}
[ $(api team ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api team ls | grep ${name})
