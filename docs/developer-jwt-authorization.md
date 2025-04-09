# JWT Authorization

+ [基於 Golang 的 Grafana Dashboard 與 JWT 認證的前後端實作](https://www.omegaatt.com/blogs/develop/2024/grafana_embed_example/)
+ [Make grafana with existing JWT token](https://community.grafana.com/t/make-grafana-with-existing-jwt-token/132260)
+ [Configure JWT Authentication with Grafana](https://tanmay-bhat.github.io/posts/configure-jwt-auth-grafana/)

考量第三方介面崁入 Grafana 面板，其操作流程中若無法提供登入的操作，則必需設定儀表板或面板為開放狀態，若此設定則無法透過權限有效管理可看到的內容與操作。

對此，Grafana 提供 JWT 認證的機制，讓網址的 Query 字串附加 ```auth_token=[JWT.TOKEN]```，以此來達成自動登入；其配置與操作流程如下所述：

#### 1、OpenSSL 金鑰

JWT 操作需要一組私鑰與公鑰，因此 Grafana 啟動前執行 ```grafana.bat cert``` 建立憑證於緩存目錄，本項目範本使用 PEM-encoded key。

其建立的金鑰結構範本參考 [genkey](../shell/tool-genkey.sh)，其程式約莫如下：

```
#### 1. Create a private key
ssh-keygen -t rsa -b 4096 -m PEM -f /private_key.pem -N ""
#### 2. Extract the public key from the private key
openssl rsa -in private_key.pem -pubout -outform PEM -out public_key.pem
```

#### 2、Grafana 服務設定

JWT Token 需要配合主配置檔 ```/etc/grafana/grafana.ini``` 設定，其主要設定如下：

```
[auth.jwt]
enabled = true
enable_login_token = true
header_name = X-JWT-Assertion
email_claim = sub
username_claim = sub
expect_claims = {}
key_file = /usr/share/grafana/host/certs/public_key.pem
role_attribute_path = role
role_attribute_strict = false
auto_sign_up = false
url_login = true
allow_assign_grafana_admin = false

[security]
allow_embedding = true
```

本項目範本參考 [grafana.ini](../conf/grafana/grafana.ini)，並啟動容器時配置環境參數 GF_PATHS_CONFIG 更換配置檔的位置。

#### 3、產生 JWT 代碼

產生 JWT 代碼，請於 Grafana 啟動後執行 ```grafana.bat into jwt``` 進入測試容器，並執行 ```bash test-jwt-auth.sh``` [範本](../shell/test-jwt-auth.sh)。

其運作原理概念如下：

+ 載入私鑰 ```private_key.pem```
+ 設定內容 ```payload = { 'sub': 'admin', 'iat': int(time.time()) }```
    - 屬性 ```sub``` 對應前述設定在 ```username_claim``` 的屬性，Grafana 會經由此值判斷登入用戶
    - 屬性 ```username_claim``` 經實驗若不設定為 ```sub``` 會無法正常執行，其議題參考 [Jwt authentication not working or showing in log](https://community.grafana.com/t/jwt-authentication-not-working-or-showing-in-log/85419/8)
+ 經由 JWT 函示庫產生代碼，將內容與私鑰由 RS256 進行編碼處理

若 ```grafana.ini``` 設定 ```auto_sign_up = true```，則內容若設定任何用戶名稱都會登入且主動註冊一個用戶帳號，但考量安全性問題不設定此值。
