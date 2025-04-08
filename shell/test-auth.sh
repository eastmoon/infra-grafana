## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Authentication operation -----"
echo "==== list all ===="
api auth ls
echo "==== create API keys ===="
name=demo-auth
role=Admin
api auth create --name=${name} --token=${role}
id=$(api auth ls | grep ${name} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo "==== API keys information ===="
echo ${name} : ${id}
echo "==== remove API keys ===="
api auth rm --id=${id}
[ $(api auth ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api auth ls | grep ${name})
