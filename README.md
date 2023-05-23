# proyects

```bash
git clone https://github.com/jcarrizalez/proyects.git;
cd proyects;
```

```bash
git clone https://github.com/futureisanattitude/ocr.git;
git clone https://github.com/futureisanattitude/api.git;
git clone https://github.com/futureisanattitude/home.git;
git clone https://github.com/futureisanattitude/panel.git;
git clone https://github.com/futureisanattitude/prezo.git app;
```

```bash
cd docker;

docker-compose up -d;

docker-compose exec prezo-mysql-5.7 bash -c 'mysql -u$MYSQL_USER prezo < prezo.sql';

docker-compose exec prezo-mysql-8.0 bash -c 'mysql -u$MYSQL_USER ocr < ocr.sql';
```

add in : /etc/hosts
```bash
127.0.1.100     s3.prezo.box
127.0.1.101     redis.prezo.box
127.0.1.102     meilisearch.prezo.box
127.0.1.103     mysql-5.7.prezo.box
127.0.1.104     mysql-8.0.prezo.box

127.0.1.110     api.prezo.box
127.0.1.120     ocr.prezo.box
127.0.1.130     app.prezo.box
127.0.1.140     home.prezo.box
127.0.1.150     panel.prezo.box
```

add in : ~/.bashrc
```bash
#prezo
source ~/develop/prezo/sistemas/docker/bashrc
```

edit
```bash
ocr/.env;
api/.env;
home/.env;
panel/.env;
app/env.php;
```

new shell
```bash
prezo help
```