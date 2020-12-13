FROM python:3.8.1-alpine3.11

# Install MkDocs
COPY ./requirements.txt /tmp/requirements.txt
WORKDIR /tmp
RUN apk add --no-cache \
    bash && \
    apk add --no-cache --virtual .build gcc musl-dev && \
    pip install --no-cache-dir \
    -r requirements.txt && \
    rm requirements.txt && \
    apk del .build

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]