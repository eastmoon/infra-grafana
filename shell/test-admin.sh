## Declare alias
api() {
  bash api ${@}
}
## Execute initial grafana server admin account
echo "----- Admin operation -----"
### Show grafana status by admin account
api admin stats
