FROM python:3.11-slim

ENV TZ="Asia/Taipei"

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /usr/src/requirements.txt

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /usr/src/requirements.txt

EXPOSE 8080

COPY ./service /service
RUN ls -l service/config/config.yml

# Use the ping endpoint as a healthcheck,
# so Docker knows if the API is still running ok or needs to be restarted
HEALTHCHECK --interval=61s --timeout=3s --start-period=60s CMD curl --fail http://localhost:8080/ping || exit 1

CMD ["uvicorn", "service.main:app", "--host", "0.0.0.0", "--port", "8080", "--log-config", "service/config/log_conf.yml"]
