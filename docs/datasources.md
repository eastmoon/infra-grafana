## 數據源 ( Data Source )

Grafana 內建提供多種資料來源，倘若需要其他資料源但系統未提供，可以安裝資料源插件或自行開發資料源插件。

每個資料源提供一個查詢 ( Query ) 編輯，用於根據資料結構制定詢問規則，在完成資料源設定後，可將其最為輸入端並應用如下：

+ Explore 中用於查詢資料
+ Panel 中用於數據呈現
+ Alert 中的警告規則

### 資料源管理

+ [Data source management](https://grafana.com/docs/grafana/latest/administration/data-source-management/)

Grafana 可運用的資料源，可在 ```連結 ( Connections ) -> 數據源 ( Data Sources )``` 管理，若要運用於儀表板需於此先行設定，確保可以取得的相應設定。

Grafana 支援多種類的存儲後端 ( Storage backend )，以用於提供時序資料，但關於如何運用需參閱存儲後端的資訊，且僅有組織管理者才可添加資料源。

### 資料源插件

+ [Grafana Plugin](https://grafana.com/grafana/plugins/)
    - [Built-in core data sources](https://grafana.com/docs/grafana/latest/datasources/#built-in-core-data-sources)

Grafana 可利用插件來擴展其功能，諸如面板、資料源，若搜尋新的資料源插件，可至前述連結搜尋；以下為建議額外安裝的插件：

+ [Infinity](https://grafana.com/grafana/plugins/yesoreyeram-infinity-datasource)，經由 API 取回目標網址的內容，可為 JSON、CSV、XML 等格式。

### 查詢編輯

+ [Query and transform data](https://grafana.com/docs/grafana/latest/panels-visualizations/query-transform-data/)

查詢 ( Query ) 編輯會依據資料源有不同的設定面板，這取決於資料源與存儲後端本身的資料與機制，但通用的查詢與選項可參考前述連結。

### 特殊資料源

除了對應後存儲後端的資料源外，還有三個特殊資料源。

##### Grafana

Grafana 內建的資料源，其中包括隨機時序資料、串流資訊、檔案。

至 ```探索 ( Explore ) -> 選擇 Grafana```，可找到 Query type 來選擇不同的內建資料

+ Random Walk，隨機時序資料
+ Live measurements，隨機串流資訊，可透過變更 Channel 來改變訊息頻率
+ List publish files，以清單表格列舉安裝內容，相應目錄為 ```/usr/share/grafana/public``` 下的目錄

此內建資料源與 [TestData](https://grafana.com/docs/grafana/latest/datasources/testdata/) 資料源作用相同，但 TestData 可產生更多複雜的資料類型。

##### Mixed

Grafana 提供混合資料源已構成單一資料源。

##### Dashboard

Grafana 提供資料源來自儀表板 ( Dashboard ) 中的其他面板 ( Panel )，這個數據源僅限用於儀表板中的面板選擇資料源時才會出現。
