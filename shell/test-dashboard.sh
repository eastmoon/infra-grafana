## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Dashboard operation -----"
### Create auth-token
source tool-get-auth.sh
echo "==== list all ===="
api dashboard op search --db
echo "==== get folder uid ===="
ftitle=demo-folder
if [ $(api dashboard folder ls | grep ${ftitle} | wc -l) -eq 0 ]; then
    api dashboard folder create --title=${ftitle}
fi
fuid=$(api dashboard folder ls | grep ${ftitle} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== create dashboard ===="
title=demo-dashboard
api dashboard op create --title=${title} --fuid=${fuid} --msg=new-dashboard
uid=$(api dashboard op search --db | grep ${title} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== dashboard information ===="
echo ${title} : ${uid}
api dashboard op info --uid=${uid}
echo "==== remove dashboard ===="
api dashboard op rm --uid=${uid}
[ $(api dashboard op search --db | grep ${title} | wc -l) -eq 0 ] && echo ${title} not exists || echo $(api dashboard op search --db | grep ${title})
