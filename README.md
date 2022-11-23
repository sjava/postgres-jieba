# Docker Image on Docker Hub
https://hub.docker.com/r/lesca/postgres-jieba

# Get started
```
docker run -e POSTGRES_PASSWORD=password -e POSTGRES_USER=test -e POSTGRES_DB=testdb lesca/postgres11-jieba
```

# For Developers
## Build
```bash
. build
```

## Run
```bash
. run
```

## Clean up
**Attention**: this removes all unused images and dead containers. 
```bash
. clean
```

# Try it out

```
psql (11.18)
Type "help" for help.

wiki=# SELECT * FROM to_tsvector('jiebacfg', '李小福是创新办主任也是云计算方面的专家');
                            to_tsvector
-------------------------------------------------------------------
 '专家':11 '主任':5 '云计算':8 '创新':3 '办':4 '方面':9 '李小福':1
(1 row)
```

# Credit
Thanks to `pg_jieba`
* https://github.com/jaiminpan/pg_jieba