entrypoint.sh#!/bin/sh

#download
##sing-box
    curl -L https://codeberg.org/lockeyteam/lockey-sb-r/raw/branch/main/sing-box -o /home/sing-box
    cd /home
    chmod +x /home/sing-box

##config

cat > /home/config.json <<EOF
{
    "log": {
        "level": "trace",
        "timestamp": true
    },
    "inbounds": [
        {
            "type": "vless",
            "tag": "vless-in",
            "listen": "::",
            "listen_port": 443,
            "sniff": true,
            "sniff_override_destination": true,
            "users": [
                {
                    "uuid": "lockey",
                    "flow": "xtls-rprx-vision"
                }
            ],
            "tls": {
                "enabled": true,
                "server_name": "www.sega.com",
                "reality": {
                    "enabled": true,
                    "handshake": {
                        "server": "www.sega.com",
                        "server_port": 443
                    },
                    "private_key": "yMk9SQ44zv81q1Oau5tmZ3jy8NVnqS2ns_YkqXczeHI",
                    "short_id": [
                        "1b64346f695de160"
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "block",
            "tag": "block"
        }
    ],
    "route": {
        "rules": [
            {
                "geoip": "cn",
                "outbound": "block"
            },
            {
                "geosite": "category-ads-all",
                "outbound": "block"
            }
        ],
        "final": "direct"
    }
}                                                                                                                                                             60,1          Bot                                                                                                                                                     60,1          Bot
EOF

#run

/home/sing-box run
