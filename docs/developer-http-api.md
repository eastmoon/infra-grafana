# HTTP API

+ [Developers](https://grafana.com/docs/grafana/latest/developers/)
    - [HTTP API reference](https://grafana.com/docs/grafana/latest/developers/http_api/)
    - [Create API tokens and dashboards for an organization](https://grafana.com/docs/grafana/latest/developers/http_api/create-api-tokens-for-org/)

參考上述文獻，Grafana 系統對於存取其 HTTP API 提供兩使用方式：

+ 基礎驗證 ( Basic authentication )
使用帳號與密碼來驅動的 API，主要是用於管理者帳號相關的 HTTP API

+ 應用程式介面代碼 ( API Tokens )
經過基礎驗證申請的代碼 ( Token )，主要用於特定組織的功能操作


## 基礎驗證

+ [Admin API](https://grafana.com/docs/grafana/latest/developers/http_api/admin)

基礎驗證是使用帳戶與密碼操作 API，原則上用於管理者應用程式介面操作，其中相關管理者主要介面包括以下功能：

+ 取得、更新系統設定，```/api/admin/settings```
+ 取得系統狀態，```/api/admin/stats```
+ 操作用戶資訊，```api/admin/users```
    - 用戶清單、資訊需使用 User API 來執行

相關指令可在 ```grafana.bat into``` 後執行 ```bash api.sh admin <command>``` 來測試。

## 代碼驗證

+ [Authentication API](https://grafana.com/docs/grafana/latest/developers/http_api/auth/)

運用 HTTP API 時，若不是使用基礎驗證就需取得應用應用程式介面代碼 ( API Tokens ) 做為應用程式介面的代碼驗證，使 API 呼叫時可以提供如下資訊：

```
curl --request GET \
--header "Authorization: Bearer eyJrIjoiVjBkSmV3ZjVJc2NxZjUxR0k3a3ZLZGVYWklQcmpaeloiLCJuIjoibXlrZXkiLCJpZCI6MX0=" \
http://localhost:3000/api/org
```

而代碼驗證是依據組織 ( Organization ) 來取得，其過程如下：

+ 使用 ```/api/orgs``` 確認組織與代號
+ 使用 ```/api/auth/keys``` 的 POST 方式註冊並取得代碼
+ 使用 ```/api/auth/keys``` 的 GET 方式取得註冊代碼清單
+ 使用 ```/api/auth/keys``` 的 DELETE 方式來移除代碼

相關指令可在 ```grafana.bat into``` 後執行 ```bash api.sh auth <command>``` 來測試；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

## 組織

+ [Organization API](https://grafana.com/docs/grafana/latest/developers/http_api/org/)

組織是建立驗證代碼的主要資訊，而大量系統功能也圍繞在此資訊上，而組織的應用程式介面也分為兩類：

+ 管理者應用程式介面，使用基礎驗證
    - 使用 ```/api/orgs``` 的 GET 來取得組織清單
    - 使用 ```/api/orgs``` 的 POST 來新增組織
    - 使用 ```/api/orgs``` 的 UPDATE 與組織編號來更新組織資訊
    - 使用 ```/api/orgs``` 的 DELETE 與組織編號來刪除組織
    - 使用 ```/api/orgs/:id/users``` 的 GET 與組織編號來取得隸屬組的用戶
+ 組織管理應用程式介面，使用代碼驗證
    - 使用 ```/api/org``` 來取得現在組織的資訊
    - 使用 ```/api/org/users``` 來取得隸屬此組織的用戶，其後配合用戶編號可以操作用戶在此組織的更新資訊、移除等動作

相關指令可在 ```grafana.bat into``` 後執行 ```bash api.sh org <command>``` 來測試；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

## 用戶系統

+ [User API](https://grafana.com/docs/grafana/latest/developers/http_api/user/)
+ [Team API](https://grafana.com/docs/grafana/latest/developers/http_api/team/)
