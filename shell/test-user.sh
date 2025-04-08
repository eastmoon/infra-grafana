## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- User operation -----"
echo "==== list all ===="
api user ls
echo "==== create User ===="
usrname=demo
usrpass=demo1234
api admin users --username=${usrname} --password=${usrpass}
userid=$(api user ls | grep ${usrname} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo "==== User information ===="
echo ${usrname} : ${userid}
echo "==== remove User ===="
api admin users.rm --id=${userid}
[ $(api user ls | grep ${usrname} | wc -l) -eq 0 ] && echo ${usrname} not exists || echo $(api user ls | grep ${usrname})
