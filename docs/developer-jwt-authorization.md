# JWT Authorization

+ [基於 Golang 的 Grafana Dashboard 與 JWT 認證的前後端實作](https://www.omegaatt.com/blogs/develop/2024/grafana_embed_example/)
+ [Make grafana with existing JWT token](https://community.grafana.com/t/make-grafana-with-existing-jwt-token/132260)
+ [Configure JWT Authentication with Grafana](https://tanmay-bhat.github.io/posts/configure-jwt-auth-grafana/)

JWT Token 需要配合主配置檔 ```/etc/grafana/grafana.ini``` 的 ```[auth.jwt]``` 區塊設定。

由於 JWT 設定依賴憑證，請於 Grafana 啟動前執行 ```grafana cert``` 建立憑證於緩存目錄，本項目使用 PEM-encoded key file
