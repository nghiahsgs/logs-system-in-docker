# Hệ thống quản lý Log với Grafana, Loki và Promtail

Hệ thống này cho phép theo dõi và phân tích logs thông qua nền tảng Grafana, Loki và Promtail.

## Cấu trúc thư mục

```
.
├── config/
│   ├── grafana/      # Cấu hình Grafana
│   ├── loki/         # Cấu hình Loki
│   ├── promtail/     # Cấu hình Promtail
├── logs/             # Thư mục chứa file log
├── docker-compose.yml
├── generate-logs.sh  # Script tạo logs giả lập
└── README.md
```

## Cách sử dụng

### 1. Khởi động hệ thống

```bash
docker-compose up -d
```

### 2. Tạo logs giả lập (tùy chọn)

Để tạo logs giả lập liên tục, sử dụng script `generate-logs.sh`:

```bash
./generate-logs.sh
```

Script này sẽ liên tục tạo ra các log ngẫu nhiên và ghi vào file `logs/output.log`.

### 3. Truy cập dashboard

- **Grafana**: http://localhost:3000
  - Tài khoản: admin
  - Mật khẩu: admin

Sau khi đăng nhập vào Grafana, bạn có thể truy cập dashboard "Application Logs Dashboard" để xem và tra cứu logs.

### 4. Tìm kiếm logs

Trong dashboard Grafana, bạn có thể:
- Xem logs theo thời gian
- Tìm kiếm logs bằng cách sử dụng LogQL (Ví dụ: `{job="app_logs"} |= "ERROR"` để tìm tất cả logs có chứa "ERROR")
- Lọc logs theo nhiều tiêu chí khác nhau

## Dừng hệ thống

```bash
docker-compose down
```

## Lưu ý

- File logs được mount vào container Promtail tại đường dẫn `/var/log/app`
- Loki lưu trữ dữ liệu trong volume Docker để đảm bảo dữ liệu không bị mất khi container bị xóa
- Cấu hình đã được thiết lập để Promtail theo dõi file `output.log` và gửi logs tới Loki



docker-compose restart promtail
docker exec -it promtail rm /tmp/positions.yaml
docker restart promtail