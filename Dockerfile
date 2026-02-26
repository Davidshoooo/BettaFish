# 1. 使用微软官方 Playwright 镜像（自带完美无缺的浏览器和底层环境，直接跳过依赖报错坑！）
FROM mcr.microsoft.com/playwright/python:v1.42.0-jammy

# 2. 设置工作目录
WORKDIR /app

# 3. 复制依赖清单并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. 经过 .dockerignore 安检门后，拷贝纯净代码（体积不到几 MB）
COPY . .

# 5. 放行端口
EXPOSE 8000

# 6. 启动 API 服务
CMD ["uvicorn", "coze_api:app", "--host", "0.0.0.0", "--port", "8000"]