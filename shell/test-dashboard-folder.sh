## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Dashboard and Folder operation -----"
### Create auth-token
source tool-get-auth.sh
echo "==== list all ===="
api db folder ls
echo "==== create folder ===="
title=demo-folder
api db folder create --title=${title}
uid=$(api db folder ls | grep ${title} | tr ',' '\n' | awk '$0 ~ /"uid"/ { split( $0, a, ":" ); print(a[2]) }' | sed 's/\"//g')
echo "==== folder information ===="
echo ${title} : ${uid}
echo "==== remove folder ===="
api db folder rm --uid=${uid}
[ $(api db folder ls | grep ${title} | wc -l) -eq 0 ] && echo ${title} not exists || echo $(api db folder ls | grep ${title})
