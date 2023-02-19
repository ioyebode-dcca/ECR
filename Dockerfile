FROM alpine:latest

RUN apk update && \
    apk add --no-cache python3 && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    rm -r /root/.cache

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

CMD [ "python3", "app.py" ]
