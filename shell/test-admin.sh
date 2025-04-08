## Declare alias
api() {
  bash api ${@}
}
## Execute script
echo "----- Admin operation -----"
### Show grafana status by admin account
api admin stats
