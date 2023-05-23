# Hosts `/etc/hosts`
```bash
20.10.0.4 	api.prezo.box
```

# Server 
- docker-compose.yml:
- networks: prezo  `20.10.0.0/16`
```
  -3306/tcp    prezo-api-mysql      20.10.0.2
  -11211/tcp   prezo-api-memcached  20.10.0.3
  -80/tcp      prezo-api-nginx      20.10.0.4
  -9000/tcp    prezo-api-laravel    20.10.0.5
```

## Start
```bash
docker-compose up -d;
```
## Stop
```bash
docker-compose down;
```
# Composer

## install
```bash
docker-compose exec prezo-api composer install;
```
## update
```bash
docker-compose exec prezo-api composer update;
```
## dump-autoload
```bash
docker-compose exec prezo-api composer dump-autoload -o;
```

# Restore DB "dump, sql"

```bash
docker-compose exec prezo-mysql bash -c "mysql -udevelop -p123456 prezo < ./opt/prezo-backup.sql"
```
o con el mysql de tu maquina
```bash
mysql -udevelop -p123456 -h127.0.1.102 prezo < ./database/data/prezo.sql;
```
# Artisan

## rollback
```bash
docker-compose exec prezo-api php artisan migrate:rollback;
```
## migrate
```bash
docker-compose exec prezo-api php artisan migrate;
```
## seed
```bash
docker-compose exec prezo-api php artisan db:seed;
```

# Test
```bash
docker-compose exec prezo-api ./vendor/bin/phpunit;
```

## clear cache "memcached"

```bash
docker-compose exec prezo-api bash -c "{ echo flush_all; sleep 1; echo prezo; sleep 1; } | telnet prezo-memcached 11211 > /dev/null";
```
o desde tu pc con telnet
```bash
{ echo flush_all; sleep 1; echo quit; sleep 1; } | telnet 20.10.0.3 11211 > /dev/null;
```

# Docker (opcional)

## Clear ALL
```bash
docker system prune -a;
docker images purge;
docker volume prune;
```

## Build recreate
```bash
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-s3;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-redis;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-mysql-5.7;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-mysql-8.0;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-meilisearch;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-nginx-api;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-nginx-ocr;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-api;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-ocr;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-app;
docker-compose up -d --build --force-recreate --renew-anon-volumes prezo-home;
```

## List
```bash
docker ps;                #en uso
docker ps -a;             #todas 
docker system prune -a;   #borrar todo en docker 
```



#Docker Networks
# networks:
#     prezo:
#         name: prezo
#         driver: bridge
        # ipam:
        #     driver: default
        #     config:
        #         - subnet: 20.10.0.0/16


# cd docker/sources; 
#ln -s ../../api .
#ln -s ../../ocr .
#ln -s ../../app .
#ln -s ../../home .
#ln -s ../../panel .
