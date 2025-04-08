## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Team operation -----"
### Create auth-token
source tool-get-auth.sh
echo "==== list all ===="
api team ls
echo "==== create Team ===="
name=demo
email=demo@demo.org
api team create --name=${name} --email=${email}
id=$(api team ls | grep ${name} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo "==== Team information ===="
echo ${name} : ${id}
echo "==== remove Team ===="
api team rm --id=${id}
[ $(api team ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api team ls | grep ${name})
