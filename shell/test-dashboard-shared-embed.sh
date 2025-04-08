## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Dashboard shared short URL operation -----"
echo "==== get folder uid ===="
ftitle=demo-folder
if [ $(api dashboard folder ls | grep ${ftitle} | wc -l) -eq 0 ]; then
    api dashboard folder create --title=${ftitle}
fi
fuid=$(api dashboard folder ls | grep ${ftitle} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== get shared dashboard uid ===="
dtitle=demo-shared-dashboard
template=${PWD}/db.d/demo-dashboard.json
if [ $(api dashboard op search --db | grep ${dtitle} | wc -l) -eq 0 ]; then
    api dashboard op create --title=${dtitle} --template=${template} --fuid=${fuid} --msg=new-dashboard
fi
duid=$(api dashboard op search --db | grep ${dtitle} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== dashboard information ===="
echo ${dtitle} : ${duid}
url=$(api dashboard op info --uid=${duid} | tr ',' '\n' | awk '$0 ~ /"url"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== get short url ===="
echo ${url}
api dashboard shared embed --url=${url} --pid=3
