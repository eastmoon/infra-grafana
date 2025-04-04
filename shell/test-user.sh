## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- User operation -----"
### Show all user
api user ls
### Create new user and remove it
usrname=demo
usrpass=demo1234
api admin users --username=${usrname} --password=${usrpass}
userid=$(api user ls | grep ${usrname} | awk '{split($0,a, ","); split(a[1], b, ":"); print b[2]}')
echo ${usrname} : ${userid}
api admin users.rm --id=${userid}
[ $(api user ls | grep ${usrname} | wc -l) -eq 0 ] && echo ${usrname} not exists || echo $(api user ls | grep ${usrname})
