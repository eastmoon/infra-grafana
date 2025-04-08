## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Dashboard and Folder operation -----"
### Create auth-token
source tool-get-auth.sh
echo "==== list all ===="
api dashboard folder ls
echo "==== create folder ===="
title=demo-folder
api dashboard folder create --title=${title}
uid=$(api dashboard folder ls | grep ${title} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== folder information ===="
echo ${title} : ${uid}
echo "==== remove folder ===="
api dashboard folder rm --uid=${uid}
[ $(api dashboard folder ls | grep ${title} | wc -l) -eq 0 ] && echo ${title} not exists || echo $(api dashboard folder ls | grep ${title})
