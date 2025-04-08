## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Organization operation -----"
echo "==== list all ===="
api org ls
echo "==== create Organization ===="
orgname=demo-org
api org create --name=${orgname}
orgid=$(api org ls | grep ${orgname} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo "==== Organization information ===="
echo ${orgname} : ${orgid}
echo "==== remove Organization ===="
api org rm --id=${orgid}
[ $(api org ls | grep ${orgname} | wc -l) -eq 0 ] && echo ${orgname} not exists || echo $(api org ls | grep ${orgname})
