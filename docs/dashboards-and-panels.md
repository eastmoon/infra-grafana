# 儀表板 ( Dashboard ) 與面板 ( Panel )

+ [Dashboards](https://grafana.com/docs/grafana/latest/dashboards/)
    - [Import dashboards](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/import-dashboards/)
    - [Dashboard JSON model](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/view-dashboard-json-model/)
+ [Panels and visualizations](https://grafana.com/docs/grafana/latest/panels-visualizations/)
+ [Share dashboards and panels](https://grafana.com/docs/grafana/latest/dashboards/share-dashboards-panels/)
+ [How to embed Grafana dashboards into web applications](https://grafana.com/blog/2023/10/10/how-to-embed-grafana-dashboards-into-web-applications/)

儀表版是將一個以上的面板，並在一行或多行排列，以構成總覽的界面；面板則會用查詢 ( Query ) 句將資料源的原始資料提煉後，以圖表 ( charts )、圖形 ( graphs )、或其他視覺化 ( visualizations ) 呈現內容。

面板是一個視覺化呈現的容器，並提供相應的操作，然而面板可呈現的內容需要有相應的資料格式，若面板無法呈現特定格式，應切換為適當的面板來呈現數據。

每個面板會對應一個資料源，其可以是 SQL 資料庫、[Grafana Loki](https://grafana.com/oss/loki/)、[Grafana Mimir](https://grafana.com/oss/mimir/)、回應 JSON 格式的 API，甚至可以是 CSV 格式的檔案；Grafana 提供 150 個資料源插件 ( Data Source Plugin )，讓不同的資料格式可轉換成供儀表板呈現的數據。

### 儀表板

##### [建立](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/create-dashboard/)

透過主選單的儀表板 ( Dashboard ) 選項，並點擊新增 ( New ) 下的新增儀表板 ( New Dashboard )，其介面主要可以選擇三個項目

+ 新增視覺化 ( Add Visualizations )，亦即新增面板
+ 新增排 ( Add Row )，亦即建立一個排元件，用來對面板分群
+ 新增自面板庫，亦即新增一個繼承已經建立且設定共享的面板，當基礎面板變更則所有繼承面板皆變更

##### [匯入](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/import-dashboards/)

透過主選單的儀表板 ( Dashboard ) 選項，並點擊新增 ( New ) 下的匯入 ( Import )，其介面主要有三個來源操作

+ 上傳 JSON 檔案
+ 貼上 [Grafana.com Dashboard](https://grafana.com/grafana/dashboards/) 的網址
+ 貼上儀表板的 JSON 設定內容

##### [網址變數](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/create-dashboard-url-variables/)

儀表板可以透過網址後面的 Query 字串，提供諸如查詢規則、顯示時間段，其結構如下：

```
https://${your-domain}/path/to/your/dashboard?from=now-5m&to=now
```

##### [面板庫](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/manage-library-panels/)

面板庫管理共用面板，儀表板可在建立視覺化時自面板庫選擇，建立的面板在共用面板被修改時，相關面板會一併修改，但建立好的面板也可以選擇斷連 ( Unlink ) 讓面板修改後不影響共用面板也不再受共用面板影響。

##### [版本紀錄](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/manage-version-history/)

面板的調整在存檔時會留下修改紀錄，並可以在 ```設定 ( Setting ) --> 版本 ( Version )``` 中查閱並回退到該版本。


##### [共享](https://grafana.com/docs/grafana/latest/dashboards/share-dashboards-panels/shared-dashboards/)

儀表板或面板可以透過 Shared 來共享內容，透過設定可以選擇訪問者透過電子信箱、用戶、任何人在有限的時間內詢問內容；需要注意，實際測試不同版本的 Grafana 可能會提供不同的功能，請依據當前版本對應的文件說明為準。

原則上共享仍建議基於帳戶，倘若考量其他網站崁入，則應該建立 JWT 代碼來自動登入介面，詳情參閱 [Configure JWT authentication
](https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/jwt/)。

##### [JSON 模型](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/view-dashboard-json-model/)

Grafana 的儀表板與面板都有對應的 JSON 設定，透過該設定可以直接建立一個儀表板，相關的 JSON 設定可參考文獻的相關連結，但實際關鍵字與數值應以當前版本匯出的設定為準。

鑒於 JSON 模型的複雜度，雖考量自行設定的可能，但實務上應以下列方式運用：

1. 建立開發環境，基於使用需要設定儀表板與面板
2. 匯出儀表板的 JSON 模型
3. 產品更新會基於目錄中的 JSON 模型逐一匯入
