## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Dashboard shared short URL operation -----"
### Create auth-token
source tool-get-auth.sh
echo "==== get folder uid ===="
ftitle=demo-folder
if [ $(api db folder ls | grep ${ftitle} | wc -l) -eq 0 ]; then
    api db folder create --title=${ftitle}
fi
fuid=$(api db folder ls | grep ${ftitle} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== get shared dashboard uid ===="
dtitle=demo-shared-dashboard
template=${PWD}/db.d/demo-dashboard.json
if [ $(api db op search --db | grep ${dtitle} | wc -l) -eq 0 ]; then
    api db op create --title=${dtitle} --template=${template} --fuid=${fuid} --msg=new-dashboard
fi
duid=$(api db op search --db | grep ${dtitle} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== dashboard information ===="
echo ${dtitle} : ${duid}
url=$(api db op info --uid=${duid} | tr ',' '\n' | awk '$0 ~ /"url"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== get short url ===="
echo ${url}
api db shared embed --url=${url} --pid=3
