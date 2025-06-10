#!/bin/bash
set -e

# 1) System prep
apt-get update -y
apt-get install -y software-properties-common curl apt-transport-https unzip

# 2) Suricata
add-apt-repository -y ppa:oisf/suricata-stable
apt-get update -y
apt-get install -y suricata

# 3) HOME_NET / EXTERNAL_NET
cat <<EOF > /etc/suricata/suricata.yaml
vars:
  address-groups:
    HOME_NET: ["${var.vpc_cidr}"]
    EXTERNAL_NET: ["!${var.vpc_cidr}"]
... (resto del yaml intacto) ...
EOF

# 4) Modo IPS inline
cat <<EOF > /etc/systemd/system/suricata.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/suricata -q 0 --af-packet=eth0:eth0 --pidfile /var/run/suricata.pid
EOF
systemctl daemon-reload

# 5) Reglas custom
echo 'alert tcp any any -> any 22 (msg:"SSH brute force"; sid:1000002; rev:1;)' >> /etc/suricata/rules/local.rules
echo 'alert udp any any -> any 53 (msg:"DNS tunneling"; sid:1000003; rev:1;)' >> /etc/suricata/rules/local.rules
# ya tienes la regla Telnet

# 6) Actualizar reglas oficiales
suricata-update

# 7) Instalar y configurar CloudWatch Agent
curl https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb -o cwagent.deb
dpkg -i cwagent.deb
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/suricata/eve.json",
            "log_group_name": "${var.cw_log_group}",
            "timestamp_format": "%Y-%m-%dT%H:%M:%S"
          }
        ]
      }
    }
  }
}
EOF
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

# 8) Arrancar Suricata en modo IPS
systemctl restart suricata
