FROM postgres:14-alpine3.15

LABEL "repo"="github.com/lesca/postgres-jieba"
LABEL "description"="add jieba to postgres 14 alpine"

RUN apk add --no-cache --virtual .build-deps \
    alpine-sdk \
    cmake \
    build-base \
    postgresql-dev

RUN git clone --depth=1 https://github.com/jaiminpan/pg_jieba.git /usr/src/pg_jieba && \
    cd /usr/src/pg_jieba && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake .. && \
    USE_PGXS=1 make && USE_PGXS=1 make install

RUN git clone git://git.osdn.net/gitroot/pgbigm/pg_bigm.git /usr/src/pg_bigm && \
    cd /usr/src/pg_bigm && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install

RUN sed -i "/^#shared_preload_libraries/c\shared_preload_libraries = 'pg_jieba.so,pg_bigm'" /usr/local/share/postgresql/postgresql.conf.sample && \
    sed -i "/^default_text_search_config/c\default_text_search_config = 'jiebacfg'" /usr/local/share/postgresql/postgresql.conf.sample

RUN git clone https://github.com/postgrespro/rum /usr/src/rum && \
    cd /usr/src/rum && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install

RUN apk del .build-deps && \
    rm -rf /usr/src/pg_jieba && \
    rm -rf /usr/src/rum && \
    rm -rf /usr/src/pg_bigm
