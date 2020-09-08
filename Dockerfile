FROM python:3.7 AS builder
WORKDIR /temp
COPY apis /temp/apis
COPY main.py /temp
COPY setup.py /temp
RUN pip install cython
RUN python setup.py bdist_wheel
RUN unzip /temp/dist/app-1.0.0-cp37-cp37m-linux_x86_64.whl -d /app
RUN rm -rf /app/app-1.0.0.dist-info
RUN rm -f /app/**/*.py
FROM python:3.7
WORKDIR /app
COPY --from=builder /app /app
COPY requirements.txt /app
RUN pip install --no-cache-dir -r /app/requirements.txt
EXPOSE 3000
USER nobody
ENV GUNICORN_CMD_ARGS="--worker-class gthread --threads=100 --workers 3 --bind 0.0.0.0:3000 --access-logfile '-'"
ENTRYPOINT ["gunicorn", "main:app"]
