## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- User operation -----"
### Show all user
api sa ls
### Create new service account
name=DemoSA
role=Admin
api sa create --name=${name} --role=${role}
id=$(api sa ls | grep ${name} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
echo ${name} : ${id}
### Create token and remove it
tname=DemoTokenA
api sa token.create --id=${id} --name=${tname}
tid=$(api sa token.ls --id=${id} | grep ${tname} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
echo ${tname} : ${tid}
api sa token.rm --id=${id} --tid=${tid}
[ $(api sa token.ls --id=${id} | grep ${tname} | wc -l) -eq 0 ] && echo ${tname} not exists || echo $(api sa token.ls --id=${id} | grep ${tname})
### Remove service account
api sa rm --id=${id}
[ $(api sa ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api sa ls | grep ${name})
