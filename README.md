# Nextcloud Service based on Docker Compose

# Usage

1. Generate secrets according to metioned in docker-compose.yml.
2. Put down domains into `secrets/domains`.
3. Run with command:
```bash
docker-compose --env-file ./secrets/domains up -d --build
```

# Notes

## Notifications

### Telegram

There is a script `scripts/telegram-sen.sh` used to send files. To use it one should:
* Create telegram bot.
** Go to @BotFather and create bot with `\start`.
** Save bot's token in form `1234567890:123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ` into `./secrets/tg_bot`.
* Create new private Channel. (May be one should create open channel and make it private as last step).
** Add bot into channel as admin. One could remove all privileges except sending messages.
** Send some message into channel.
** Open `https://api.telegram.org/bot[YourBOTToken]/getUpdates` in your browser and read JSON response.
** Save chat's id from `result.chat.id` in form `-1001234567890` (`-100` prefix for private channels) in `./secrets/tg_some_chat`.
* Prepare Docker service.
** Pass Docker Secrets `./secrets/tg_bot` and `./secrets/tg_some_chat` into service been setup.
** Create environment variables `TG_BOT_FILE=/run/secrets/tg_bot` and `TG_CHAT_FILE=/run/secrets/tg_some_chat`.

See https://bogomolov.tech/Telegram-notification-on-SSH-login/

## Nextcloud

To connect from Android client do either:
* Create a token and connect via QR-code
* Add `'overwriteprotocol' => 'https',` into `data/app/config/config.php` to allow "Grant Access" button work in Android App.

## qBittorrent

### WebUI error Unauthorized

If you get a `Unauthorized` then add `WebUI\HostHeaderValidation=false` into `./data/qbittorrent/config/qBittorrent/qBittorrent.conf`

See https://github.com/qbittorrent/qBittorrent/issues/8095#issuecomment-614602695

### WebUI default credentials

* Login: admin
* Password: adminadmin

# Links

* https://github.com/nextcloud/docker/tree/master/.examples/docker-compose/with-nginx-proxy-self-signed-ssl/mariadb/fpm
* https://help.nextcloud.com/t/closed-both-the-android-and-the-linux-client-freeze-when-trying-to-grant-access-after-login/62383/7
* https://github.com/linuxlifepage/nextcloud
* https://github.com/nginx-proxy/nginx-proxy/issues/712#issuecomment-339868751
