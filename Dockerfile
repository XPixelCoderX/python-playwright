
FROM python:3.13-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libnspr4 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libatspi2.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libxcb1 \
    libxkbcommon0 \
    libasound2 \
    libpango-1.0-0 \
    libcairo2 \
    libdbus-1-3 \
    libdrm2 \
    libxshmfence1 \
    libglib2.0-0 \
    libgdk-pixbuf-2.0-0 \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --no-cache-dir \
    playwright==1.63.0 \
    requests \
    flask \
    protobuf \
    cryptography \
    && python -m playwright install chromium --only-shell

RUN python -c "from cryptography.hazmat.primitives import hashes, serialization; print('cryptography installed successfully')"

WORKDIR /home/container

CMD ["python", "server.py"]
