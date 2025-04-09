## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Data Source operation -----"
### Create auth-token
source tool-get-auth.sh
echo "==== list all ===="
api ds ls
echo "==== create Data source ===="
name=demo-ds
template=${PWD}/ds.d/demo-testdata.json
api ds create --name=${name} --template=${template}
uid=$(api ds ls | grep ${name} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== Data source information ===="
echo ${name} : ${uid}
echo "==== remove Data source by uid ===="
api ds rm --uid=${uid}
[ $(api ds ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api ds ls | grep ${name})
echo "==== create Data source ===="
name=demo-ds
template=${PWD}/ds.d/demo-testdata.json
api ds create --name=${name} --template=${template}
echo "==== remove Data source by name ===="
api ds rm --name=${name}
[ $(api ds ls | grep ${name} | wc -l) -eq 0 ] && echo ${name} not exists || echo $(api ds ls | grep ${name})
