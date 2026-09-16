# 婚禮賓客出席資訊查詢 API

這是一個 Docker 化的 FastAPI 婚禮賓客出席資訊查詢 API。使用者可依姓名查詢已登記的出席資訊；後端使用 SQLite `guest_list` 資料表儲存資料。

## API

- `GET /get_by_name?name=姓名`：依姓名查詢出席資訊。
- `GET /ping`：服務健康檢查。

## 執行方式

服務可透過 Docker 或 Uvicorn 啟動，並於 8080 連接埠提供服務。

```bash
docker build -t wedding-guest-api .
docker run -p 8080:8080 wedding-guest-api
```

或直接以 Uvicorn 啟動：

```bash
uvicorn service.main:app --host 0.0.0.0 --port 8080 --log-config service/config/log_conf.yml
```
