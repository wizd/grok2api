FROM python:3.10-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 设置默认环境变量
ENV PORT=3000 \
    IS_TEMP_CONVERSATION=true \
    IS_CUSTOM_SSO=false \
    API_KEY=sk-123456 \
    SHOW_THINKING=false \
    ISSHOW_SEARCH_RESULTS=true

# 可选环境变量（在运行时可覆盖）
ENV PICGO_KEY="" \
    TUMY_KEY="" \
    PROXY="" \
    MANAGER_SWITCH="" \
    ADMINPASSWORD="" \
    CF_CLEARANCE=""

# 复制应用代码
COPY . .

EXPOSE 3000

CMD ["python", "app.py"]
