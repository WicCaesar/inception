#!/bin/sh

cd /var/www/

if [ ! -f "/var/www/wp-config.php" ]; then
	/usr/local/bin/wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASS}" --dbhost="${DB_HOST}" --force
	/usr/local/bin/wp config set FS_METHOD 'direct'
#FS_METHOD controls how WordPress handles file system operations (installing plug-ins, themes, updates, etc). With 'direct', it writes files directly to the system (if you give the appropriate file permissions). Alternatively, you could choose ssh2, ftpext or ftpsockets, to handle via SSH or FTP.
	/usr/local/bin/wp config set DB_CHARSET 'utf8mb4'
	/usr/local/bin/wp config set DB_COLLATE 'utf8mb4_unicode_ci'
#DB_CHARSET and DB_COLLATE are necessary to support diacritics from several world languages, and being able to sort content using such letters, to ensure compatibility. utf8mb4_unicode_ci (case insensitive) is a full language-agnostic set of 4-byte Unicode characters, which includes emoji, ideograms, special symbols, and also treats A, a, À, à, and variations as equal.
	/usr/local/bin/wp core install --url="https://${WP_HOST}" --title="${WP_TITLE}" --admin_user="${ADM_WP_NAME}" --admin_password="${ADM_WP_PASS}" --admin_email="${ADM_WP_EMAIL}"
	/usr/local/bin/wp user create "${WP_USERNAME}" "${WP_USEREMAIL}" --role="editor" --user_pass="${WP_USERPASS}"
fi

