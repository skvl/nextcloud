# Nextcloud Service based on Docker Compose

# Usage

1. Generate secrets according to metioned in docker-compose.yml.
2. Put down domains into `secrets/domains`.
3. Run with command:
```
docker-compose --env-file ./secrets/domains up -d --build
```

# Notes

Add `'overwriteprotocol' => 'https',` into `data/app/config/config.php` to allow "Grant Access" button work in Android App.

# Links

* https://github.com/nextcloud/docker/tree/master/.examples/docker-compose/with-nginx-proxy-self-signed-ssl/mariadb/fpm
* https://help.nextcloud.com/t/closed-both-the-android-and-the-linux-client-freeze-when-trying-to-grant-access-after-login/62383/7
* https://github.com/linuxlifepage/nextcloud
* https://github.com/nginx-proxy/nginx-proxy/issues/712#issuecomment-339868751
