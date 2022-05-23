#!/bin/sh
#/usr/bin/mysqld_safe --skip-grant-tables &
#sleep 5

mysql -uroot -p"$MARIADB_ROOT_PASSWORD" -e "CREATE DATABASE wordpress;CREATE DATABASE drupal;CREATE DATABASE cogip;"

mysql -uroot -p cogip -p"$MARIADB_ROOT_PASSWORD" << "EOF"
CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `vat` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `contact_company_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `number` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `invoice_company_id` int(11) DEFAULT NULL,
  `invoice_contact_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

ALTER TABLE `company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vat` (`vat`);

ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contact_company_id` (`contact_company_id`) USING BTREE;

ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_contact_id` (`invoice_contact_id`),
  ADD KEY `invoice_company_id` (`invoice_company_id`) USING BTREE;

ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `contact`
  ADD CONSTRAINT `fk_contact_company_id` FOREIGN KEY (`contact_company_id`) REFERENCES `company` (`id`) ON DELETE SET NULL;

ALTER TABLE `invoice`
  ADD CONSTRAINT `fk_invoice_company_id` FOREIGN KEY (`invoice_company_id`) REFERENCES `company` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_invoice_contact_id` FOREIGN KEY (`invoice_contact_id`) REFERENCES `contact` (`id`) ON DELETE SET NULL;

INSERT INTO `user` (`username`, `password`, `mode`) VALUES('admin', 'admin123', 'winner');

EOF




#USERS/DATABASES=(cogip wordpress drupal)

#PASSWORDS=(
#rahng9duWuuw6phi8eewooshi5aichiewiedaXahShuuY4Od8ahp8wiva3quu9ai
#muegiezei7ithoo4Va8IepeiS3nooj7dooP7neepeghoophae8QuooChooG4rie2
#ooqu5quah3lainahphozaeKahshien5aip7seeHeiFah4zoothi9Oozeen7jahWi
#)

#for i in "${USERS[@]}" do
#  for p in "${PASSWORDS[@]}" do
#     mysql < CREATE USER $i@localhost IDENTIFIED by $p;
#     mysql < GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on $i to $i@'localhost;
#  done
#done


mysql -uroot -p"$MARIADB_ROOT_PASSWORD" <<EOF
CREATE USER 'cogip'@'full-stack-cogip_php-1.full-stack_backend' IDENTIFIED BY '$COGIP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON cogip.* TO 'cogip'@'full-stack-cogip_php-1.full-stack_backend';
CREATE USER 'wordpress'@'full-stack-wordpress-1.full-stack_backend' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'full-stack-wordpress-1.full-stack_backend';
CREATE USER 'drupal'@'full-stack-drupal-1.full-stack_backend' IDENTIFIED BY '$DRUPAL_PASSWORD';
GRANT ALL PRIVILEGES ON drupal.* TO 'drupal'@'full-stack-drupal-1.full-stack_backend';
FLUSH PRIVILEGES;
EOF

