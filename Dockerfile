FROM postgres:11-alpine

LABEL "repo"="github.com/lesca/postgres-jieba"
LABEL "description"="add jieba to postgres 11 alpine"

RUN apk add --update --no-cache alpine-sdk cmake
RUN git clone --depth=1 https://github.com/jaiminpan/pg_jieba.git /usr/src/pg_jieba && \
    cd /usr/src/pg_jieba && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake .. && \
    USE_PGXS=1 make && USE_PGXS=1 make install

RUN sed -i "/^#shared_preload_libraries/c\shared_preload_libraries = 'pg_jieba.so'" /usr/local/share/postgresql/postgresql.conf.sample && \
    sed -i "/^default_text_search_config/c\default_text_search_config = 'jiebacfg'" /usr/local/share/postgresql/postgresql.conf.sample

RUN apk del alpine-sdk cmake && \
    rm -rf /usr/src/pg_jieba
