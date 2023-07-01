FROM python:3.11 AS builder
ARG APP_NAME=app
ARG APP_VERSION=1.0.0
WORKDIR /temp
COPY apis /temp/apis
COPY main.py /temp
COPY setup.py /temp
RUN --mount=type=secret,id=mysecret sed -i "s/#SECRET/$(cat /run/secrets/mysecret)/" /temp/apis/hello_world.py
RUN pip install cython
RUN python setup.py bdist_wheel
RUN unzip /temp/dist/$APP_NAME-$APP_VERSION-*.whl -d /app
RUN rm -rf /app/$APP_NAME-$APP_VERSION.dist-info
RUN rm -f /app/**/*.py
FROM python:3.11
WORKDIR /app
COPY --from=builder /app /app
COPY requirements.txt /app
RUN pip install --no-cache-dir -r /app/requirements.txt
EXPOSE 3000
USER nobody
ENV GUNICORN_CMD_ARGS="--worker-class gthread --threads=100 --workers 3 --bind 0.0.0.0:3000 --access-logfile '-'"
ENTRYPOINT ["gunicorn", "main:app"]
