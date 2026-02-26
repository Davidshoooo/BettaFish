# 1. 直接使用微软官方的 Playwright 镜像，自带所有浏览器和底层依赖！直接跳过 10 分钟下载！
FROM mcr.microsoft.com/playwright/python:v1.42.0-jammy

# 2. 设置工作目录
WORKDIR /app

# 3. 把本地的依赖清单复制进去并安装（加上 --no-cache-dir 避免云端缓存过大）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. 把项目里的所有代码复制进兵工厂
COPY . .

# 5. 声明放行 8000 端口
EXPOSE 8000

# 6. 启动指令：用 uvicorn 跑起我们写的 coze_api.py (FastAPI) 接口
CMD ["uvicorn", "coze_api:app", "--host", "0.0.0.0", "--port", "8000"]