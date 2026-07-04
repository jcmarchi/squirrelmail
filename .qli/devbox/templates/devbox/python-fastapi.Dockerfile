FROM python:3.12-slim

ARG DEVBOX_UID=1000
ARG DEVBOX_GID=1000

RUN apt-get update \
    && apt-get install -y --no-install-recommends git curl build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${DEVBOX_GID} devbox \
    && useradd -m -u ${DEVBOX_UID} -g ${DEVBOX_GID} -s /bin/bash devbox

RUN git config --system --add safe.directory /app

WORKDIR /app

COPY requirements*.txt ./
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
