# projects

```bash
git clone https://github.com/jcarrizalez/projects.git;
cd projects;
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
#prezo -> PATH_USER
source ~/develop/prezo/projects/docker/bashrc
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