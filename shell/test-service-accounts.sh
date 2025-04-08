## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Service Account operation -----"
echo "==== list all ===="
api sa ls
echo "==== create Service Account ===="
name=DemoSA
role=Admin
api sa create --name=${name} --role=${role}
id=$(api sa ls | grep ${name} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo "==== Service Account information ===="
echo ${name} : ${id}
echo "==== create API Keys ===="
tname=DemoTokenA
api sa token.create --id=${id} --name=${tname}
tid=$(api sa token.ls --id=${id} | grep ${tname} | tr ',' '\n' | awk '$0 ~ /"id"/ { split( $0, a, ":" ); print(a[2]) }')
echo "==== API Keys information ===="
echo ${tname} : ${tid}
echo "==== remove API keys ===="
api sa token.rm --id=${id} --tid=${tid}
[ $(api sa token.ls --id=${id} | grep ${tname} | wc -l) -eq 0 ] && echo ${tname} not exists || echo $(api sa token.ls --id=${id} | grep ${tname})
echo "==== remove Service Account ===="
api sa rm --id=${id}
[ $(api sa ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api sa ls | grep ${name})
