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

相關指令可在 ```grafana.bat into``` 後執行 ```bash api admin <command>``` 來測試，或執行 ```bash test-admin.sh``` 範本。

## 代碼驗證

+ [Authentication API](https://grafana.com/docs/grafana/latest/developers/http_api/auth/)
    - Grafana 在 11.3.0 版本後將移除 API Keys 的設定，改用 [Service accounts](https://grafana.com/docs/grafana/latest/administration/service-accounts/) 替代
    - [Configure JWT authentication](https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/jwt/)，詳細參考[開發 JWT 認證](./developer-jwt-authorization.md)範本說明。

#### API Keys

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

相關指令可在 ```grafana.bat into``` 後執行 ```bash api.sh auth <command>``` 來測試，或執行 ```bash test-auth.sh``` 範本；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

#### Service Accounts

依據官方文獻所述，在 Grafana v11 版本後會逐步將 API Key 改用 Service Account，這個服務設計本質上是 API Keys 的進階，先建立服務帳戶，在建立帳戶下保有的複數 API Keys。

Grafana 的設計中，用戶 ( User ) 與服務帳戶 ( Service Account ) 是不同的用途，其差異如下所述：

+ 用戶是經由供介面登入後，依據權限操作與閱覽相應的內容
+ 服務帳戶是提供 API 的操作權限

若用戶是規劃誰可以經由介面閱覽數據，服務帳戶則是規劃誰可以管理系統 API，其主要 API 包括兩部分：

+ 使用 ```/api/serviceaccounts/search``` 來搜尋並取回所有的服務帳戶
+ 使用 ```/api/serviceaccounts/:id``` 的 GET、POST、PATCH、DELETE 方式對指定服務帳號進行管理
+ 使用 ```/api/serviceaccounts/migrate``` 的方式將舊 API Keys 內容合併，本範本為實驗此功能
+ 使用 ```/api/serviceaccounts/:id/tokens``` 的 GET、POST、DELETE 方式來管理指定服務帳號的 API 代碼 ( Token )

相關指令可在 ```grafana.bat into``` 後執行 ```bash api.sh sa <command>``` 來測試，或執行 ```bash test-service-accounts.sh``` 範本，此外部分範本會使用此功能建立相關範本需要的 API 代碼；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

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
    - 使用 ```/api/org/users``` 來取得隸屬此組織的用戶，其後配合用戶登入名、編號可以操作用戶在此組織的加入、更新、移除動作

相關指令可在 ```grafana.bat into``` 後執行 ```bash api org <command>``` 來測試，或執行 ```bash test-org.sh``` 範本；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

## 用戶

+ [User API](https://grafana.com/docs/grafana/latest/developers/http_api/user/)

用戶的建立是管理者介面設計，然而建立的用戶清單、操作則要使用用戶應用程式介面，而其介面可區分為兩類：

+ 從用戶清單操作，使用管理者帳密的基礎驗證
    - 使用 ```api/users``` 的 GET 方式列出用戶清單
    - 基於 ```api/users``` 與用戶編號，列出用戶所在的組織、團隊
+ 從實際用戶操作，使用用戶帳密的基礎驗證
    - 使用 ```api/user``` 的 GET 方式取得驗證用戶的資訊
    - 使用 ```api/user``` 的 PUT 方式更新驗證用戶的密碼
    - 使用 ```api/user``` 與組織編號，切換驗證用戶對應組織的內容
    - 使用 ```api/user``` 與團隊編號，切換驗證用戶對應團隊的內容

相關指令可在 ```grafana.bat into``` 後執行 ```bash api user <command>``` 來測試，或執行 ```bash test-user.sh``` 範本；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

## 團隊

+ [Team API](https://grafana.com/docs/grafana/latest/developers/http_api/team/)

團隊是用戶的群組，可利用代碼驗證完成所有介面設計，但其操作都是對當前代碼所屬的組織進行，其主要可包括兩部分：

+ 團隊列表，基於 ```api/team``` 進行相關讀取、新增、更新、刪除
+ 成員管理，基於 ```api/team/:teamId/members``` 與用戶編號進行成員管理

目前並無法透過 API 更新成員為管理者。

相關指令可在 ```grafana.bat into``` 後執行 ```bash api team <command>``` 來測試，或執行 ```bash test-team.sh``` 範本；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。

## 儀表板

+ [Dashboard API](https://grafana.com/docs/grafana/latest/developers/http_api/dashboard/)
    - [Permissions](https://grafana.com/docs/grafana/latest/developers/http_api/dashboard_permissions/)
    - [Version](https://grafana.com/docs/grafana/latest/developers/http_api/dashboard_versions/)
    - [Shared](https://grafana.com/docs/grafana/latest/developers/http_api/dashboard_public/)、[Short URL](https://grafana.com/docs/grafana/latest/developers/http_api/short_url/)
+ [Folder API](https://grafana.com/docs/grafana/latest/developers/http_api/folder/)
    - [Permissions](https://grafana.com/docs/grafana/latest/developers/http_api/folder_permissions/)
+ [Folder/Dashboard Search API](https://grafana.com/docs/grafana/latest/developers/http_api/folder_dashboard_search/)

儀表板是 Grafana 主要的呈現介面，其運用可以參考整理文獻[儀表板 ( Dashboard ) 與面板 ( Panel )](./dashboards-and-panels.md)，對其操作可參閱上述 API 文獻，其主要可包括兩部分：

+ 目錄管理，用於整理儀表板的樹狀結構
    - 使用 ```api/folders``` 的 GET、POST、DELETE 方式管理目錄
    - 使用 ```api/folders/:id/permissions``` 來管理目錄的權限
+ 儀表板管理
    - 使用 ```api/dashboards/db``` 的 POST 方式新增與更新儀表板
        + 屬性 ```id``` 為 null 則表示為新增
        + 屬性 ```title``` 在新增時此數值不可有重複
        + 屬性 ```dashboard``` 的內容即為最終儀表板、面板的實際設定
    - 使用 ```api/dashboards/uid``` 的 GET、DELETE 方式管理儀表板
    - 使用 ```api/dashboards/uid/:id/permissions``` 來管理儀表板的權限
+ 全域功能
    - 使用 ```api/search``` 來搜尋目錄與儀表板的資訊
    - 使用 ```api/short-urls``` 將儀表板的 url 內容轉為短 URL

相關指令可在 ```grafana.bat into``` 後執行 ```bash api db <command>``` 來測試，或執行 ```bash test-dashboard-*.sh``` 等諸多範本；範例僅針對主要介面操作提供範本，其他文獻內容則依此設計延伸與修改。
