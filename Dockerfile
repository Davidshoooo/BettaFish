# 1. 使用极简版 Python 骨架
FROM python:3.11-slim

# 2. 设置工作目录
WORKDIR /app

# 3. 复制依赖清单并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. 仅安装 Chromium 及必需底层库 (极大节省体积)
RUN playwright install chromium --with-deps

# 5. 经过顶级安检门后，拷贝纯净代码
COPY . .

# 6. 放行端口
EXPOSE 8000

# 7. 启动 API 服务
CMD ["uvicorn", "coze_api:app", "--host", "0.0.0.0", "--port", "8000"]