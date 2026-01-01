#!/bin/bash
apt-get update -y
apt-get upgrade -y

apt-get install -y nfs-common binutils
git clone https://github.com/aws/efs-utils /tmp/efs-utils
cd /tmp/efs-utils && ./build-deb.sh && apt-get install -y ./build/amazon-efs-utils*deb

mkdir -p /var/www/html/wp-content/uploads
mount -t efs -o tls ${efs_id}:/ /var/www/html/wp-content/uploads
echo "${efs_id}:/ /var/www/html/wp-content/uploads efs _netdev,tls 0 0" >> /etc/fstab

apt-get install -y software-properties-common
add-apt-repository ppa:ondrej/php -y
apt-get update -y
apt-get install -y nginx php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php8.3-xmlrpc php8.3-soap php8.3-intl php8.3-zip

cat > /etc/nginx/sites-available/wordpress <<EOF
server {
    listen 80;
    root /var/www/html;
    index index.php index.html index.htm;

    client_max_body_size 64M;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
    }
}
EOF

ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
systemctl restart nginx
systemctl restart php8.3-fpm

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html