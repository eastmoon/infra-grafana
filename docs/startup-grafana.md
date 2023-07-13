# 啟用 Grafana

+ [Grafana Docker image](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/)
    - [ggrafana - Dockerhub](https://hub.docker.com/r/grafana/grafana)
    - [grafana-enterprise - Dockerhub](https://hub.docker.com/r/grafana/grafana-enterprise)

## 啟用伺服器

```
docker run -d --name=grafana -p 3000:3000 grafana/grafana
```
> 若使用企業版則改為 ```grafana/grafana-enterprise```

## 掛載資訊目錄

```
docker volume create grafana-storage
docker run -d -p 3000:3000 --name=grafana \
  --volume grafana-storage:/var/lib/grafana \
  grafana/grafana-enterprise
```

## [Configuration](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#override-configuration-with-environment-variables)

Grafana 環境變數來源可分為設定檔 ( *.ini ) 或環境變數名稱，且兩者可同時設定，並利用環境變數覆蓋或新增動態設定。

設定檔規則參考文獻，對應到環境變數名規則如下：

```
# configuration file
[SectionName]
KeyName-SubKeyName.ExtKeyName = Value
# environment variable
GF_<SectionName>_<KeyName>_<SubKeyName>_<ExtKeyName>=<Value>
```
> 依據文件說明，文件是基於設定檔的名稱規則撰寫，若置換成環境變數，其中關鍵字用到的```-```或```.```皆替換成```_```並置換為全大寫

設定檔可藉由環境變數動態補充，也可以自環境變數 ( ```$__env{VARIABLE_NAME}``` ) 或檔案 ( ```$__file{FILE_PATH}``` )，在企業版 7.1 後可以使用 [Hashicorp Vault](https://www.hashicorp.com/products/vault) 為來源。

### 管理者 ( Administrator )

依據官方文件說明，預設的管理者帳號與密碼皆為 admin，並第一次登入系統時要求重新設定密碼；倘若要修改預設帳號與密碼，則使用以下環境參數來改變：

+ GF_SECURITY_ADMIN_USER
+ GF_SECURITY_ADMIN_PASSWORD

使用上述環境參數修改密碼後，會視同已經重設密碼後的狀態。

## Plugins

Grafana 插件可以利用設定檔 ( Configuration ) 或[命令介面 ( Command line interface )](https://grafana.com/docs/grafana/latest/cli/)

```
# Configuration
GF_INSTALL_PLUGINS=grafana-clock-panel, grafana-simple-json-datasource
# Command line interface
grafana cli plugins install grafana-clock-panel
grafana cli plugins install grafana-simple-json-datasource
```
