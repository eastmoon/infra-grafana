## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- Organization operation -----"
### Show all organization
api org ls
### Create new organization and remove it
orgname=demo-org
api org create --name=${orgname}
orgid=$(api org ls | grep ${orgname} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo ${orgname} : ${orgid}
api org rm --id=${orgid}
[ $(api org ls | grep ${orgname} | wc -l) -eq 0 ] && echo ${orgname} not exists || echo $(api org ls | grep ${orgname})
