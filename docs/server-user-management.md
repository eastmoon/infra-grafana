# 用戶管理

+ [Server user management](https://grafana.com/docs/grafana/latest/administration/user-management/server-user-management/)
    - [Assign or remove Grafana server administrator privileges](https://grafana.com/docs/grafana/latest/administration/user-management/server-user-management/assign-remove-server-admin-privileges/)
    - [Add or remove a user in an organization](https://grafana.com/docs/grafana/latest/administration/user-management/server-user-management/add-remove-user-to-org/)
        + [Roles and permissions](https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/#organization-roles)
    - [Manage user preferences](https://grafana.com/docs/grafana/latest/administration/user-management/user-preferences/)
    - [Manage users in an organization](https://grafana.com/docs/grafana/latest/administration/user-management/manage-org-users/)
    - [Manage dashboard permissions](https://grafana.com/docs/grafana/latest/administration/user-management/manage-dashboard-permissions/)
        + [Team management](https://grafana.com/docs/grafana/latest/administration/team-management/)


## 管理者 ( Administrator )

依據官方文件說明，預設的管理者帳號與密碼皆為 admin，並第一次登入系統時要求重新設定密碼；倘若要修改預設帳號與密碼，則使用以下環境參數來改變：

+ GF_SECURITY_ADMIN_USER
+ GF_SECURITY_ADMIN_PASSWORD

使用上述環境參數修改密碼後，會視同已經重設密碼後的狀態。

## 用戶 ( User )

Grafana 用戶系統主要經由系統管理者處理，其中包括以下功能：

+ 新增、刪除、編輯用戶
+ 編輯用戶資訊
+ 設定用戶為最高管理者
+ 設定用戶所屬組織
+ 管理用戶登入資訊

## 組織 ( Organization )

Grafana 組織是全域的系統分類，每位用戶在其組織可擁有三類權限之一：

+ 管理者 ( Admin )，可管理組織所有資源，包括 Dashboard、Team、User 等
+ 編輯者 ( Editor )，可管理 Dashboard、Folder、Playerlist、Annotations
+ 閱覽者 ( Viewer )，可閱覽 Dashboardd 與 Playerlist

在組織這系統分類下，全系統的資源都是區分開來，也就是組織 A、組織 B 都用有 Grafana 的所有功能，但整體資源並無共通，唯一共通的僅有管理者系統設定與用戶資訊。

建立用戶是 Grafana 管理者的權限，組織管理者能做到的是修改用戶權限或將用戶從組織移除。

藉由此設計，可以將一套 Grafana 系統分給不同組織使用，讓其擁有組織所需的資訊視覺化系統；而其中用戶可擁有多個組織，這也可以依據用戶的職位讓其可以同時是某個組織的管理者，卻又是另一個組織的閱覽者。

## 團隊 ( Team )

Grafana 團隊是組織下的用戶群組，每位用戶在其組織可擁有兩類權限之一：

+ 管理者 ( Admin )，可管理團隊人員
+ 成員 ( Member )

在組織下的儀錶板 ( Dashboard ) 要不屬於全組織就是屬於團隊，透過這樣的分類，可以做到以下設計：

+ 組織管理者、團隊管理者或成員：組織最高管理者，可以管理用戶、團隊
+ 組織編輯者、團隊管理者：不可管理組織資源，但可以編輯儀表板與可以管理團隊
+ 組織編輯者、團隊成員：不可管理組織資源，但可以編輯儀表板
+ 組織閱覽者、團隊管理者：不可管理組織資源，但可以管理團隊
+ 組織閱覽者、團隊成員：僅能使用被規定儀表板等服務
