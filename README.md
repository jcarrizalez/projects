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

# mac os x, enabled up / disabled down
```bash
prezo alias up
```

```bash
cd docker/sources;

ln -s ../../api api
ln -s ../../ocr ocr
ln -s ../../app app
ln -s ../../home home
ln -s ../../panel panel

cd ../;
docker-compose up -d;
```

add in : /etc/hosts
```bash
127.0.0.2       s3.prezo.box
127.0.0.2       redis.prezo.box
127.0.0.3       meilisearch.prezo.box
127.0.0.2       mysql-5.7.prezo.box
127.0.0.3       mysql-8.0.prezo.box

127.0.0.4       api.prezo.box
127.0.0.5       ocr.prezo.box
127.0.0.8       app.prezo.box
127.0.0.6       home.prezo.box
127.0.0.7       panel.prezo.box
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

permissions
```bash
git config core.filemode false
```
