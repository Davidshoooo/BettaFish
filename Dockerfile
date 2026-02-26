# 1. 使用我们验证过不会报错的极简老系统
FROM python:3.11-slim-bullseye

WORKDIR /app

# 2. 复制依赖清单
COPY requirements.txt .

# 3. 【核心脱水魔法】强行指定安装纯 CPU 版的 torch（如果项目用到 AI 库，这步能砍掉 2.5GB 体积！）
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu || true

# 4. 正常安装其他的包
RUN pip install --no-cache-dir -r requirements.txt

# 5. 精准安装浏览器，并立刻清理系统缓存垃圾
RUN playwright install chromium --with-deps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache/pip

COPY . .

EXPOSE 8000

CMD ["uvicorn", "coze_api:app", "--host", "0.0.0.0", "--port", "8000"]