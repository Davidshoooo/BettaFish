# 1. 核心绝杀：使用 bullseye 版本的极简骨架（完美兼容旧字体包，体积只有 100 多 MB！）
FROM python:3.11-slim-bullseye

# 2. 设置工作目录
WORKDIR /app

# 3. 复制依赖清单并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. 只精准安装 Chromium 及其底层依赖 (bullseye 系统下绝对不会再报 ttf-unifont 错误！)
RUN playwright install chromium --with-deps

# 5. 经过 .dockerignore 安检后，拷贝纯净代码
COPY . .

# 6. 放行端口
EXPOSE 8000

# 7. 启动指令
CMD ["uvicorn", "coze_api:app", "--host", "0.0.0.0", "--port", "8000"]