FROM python:3.9.0-slim
ARG APP_VERSION=0.1.0
RUN pip install telegram-group-bot==$APP_VERSION
