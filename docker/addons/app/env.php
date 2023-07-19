<?php
date_default_timezone_set("Europe/Madrid");
// Application
$_ENV['APP_URL'] = 'http://app.prezo.box';
$_ENV['APP_ENV'] = 'dev';
$_ENV['APP_DEBUG'] = false;
$_ENV['APP_MAINTENANCE'] = false;
$_ENV['ASSETS_VERSION'] = date('ymdhis');

// Database
$_ENV['DB_HOST'] = 'prezo-mysql-5.7';
$_ENV['DB_NAME'] = 'prezo';
$_ENV['DB_PORT'] = 3306;
$_ENV['DB_USERNAME'] = 'develop';
$_ENV['DB_PASSWORD'] = 123456;

// Database replica
$_ENV['DB_REPLICA_HOST'] = $_ENV['DB_HOST'];
$_ENV['DB_REPLICA_NAME'] = $_ENV['DB_NAME'];
$_ENV['DB_REPLICA_PORT'] = $_ENV['DB_PORT'];
$_ENV['DB_REPLICA_USERNAME'] = $_ENV['DB_USERNAME'];
$_ENV['DB_REPLICA_PASSWORD'] = $_ENV['DB_PASSWORD'];


// Prezo
$_ENV['SECRET_KEY'] = 'asd';
$_ENV['GOOGLE_ANALYITCS'] = false;
$_ENV['SUPPORT_CHAT_ON'] = false;

// API Prezo
//$_ENV['API_URL'] = 'http://api.prezo.box';
$_ENV['API_URL'] = 'http://prezo-nginx-api';
$_ENV['API_TOKEN'] = '591|uKcPr6kcejPtw2eZk1GbDS4hwJLli7Y8MSWWzyCk';

// OCR Prezo
$_ENV['OCR_ON'] = true;
$_ENV['OCR_API_URL'] = 'http://ocr.prezo.box/api';
$_ENV['OCR_APP_URL'] = 'http://ocr.prezo.box/app';

// YII Mail
$_ENV['YII_MAIL_HOST'] = 'localhost';
$_ENV['YII_MAIL_USERNAME'] = 'username';
$_ENV['YII_MAIL_PASSWORD'] = 'password';
$_ENV['YII_MAIL_PORT'] = '465';
$_ENV['YII_MAIL_ENCRYPTION'] = 'ssl';

//  Mailersend
$_ENV['MAIL_ON'] = false;
$_ENV['MAIL_FROM'] = 'info@prezo.es';
$_ENV['MAIL_URL'] = 'https://api.mailersend.com/v1';
$_ENV['MAIL_TOKEN'] = 'MAILERSENDTOKEN';

// Integrations
$_ENV['LAST_ON'] = true;
$_ENV['LAST_URL'] = 'https://api.last.app/v1';
$_ENV['SOFYMAN_ON'] = true;
$_ENV['MISSTIPSI_ON'] = true;
$_ENV['REVO_ON'] = false;
$_ENV['REVO_URL'] = 'https://integrations.revoxef.works/api/external/v2';
$_ENV['REVO_TOKEN'] = 'd2jMfMKraKK8Td0TRF8tDL3zZpAzGDQnoRHhGVRkUZxcwu8PYBc2aPmZazfc';
$_ENV['CONTASIMPLE_ON'] = true;
$_ENV['CONTASIMPLE_URL'] = 'https://api.contasimple.com/api/';
$_ENV['CONTASIMPLE_VERSION'] = 'v2';
$_ENV['ICS_ON'] = true;
$_ENV['ICS_URL'] = '/test/api';
$_ENV['ICS_PREFIX'] = '/ElementoGestion';
$_ENV['ICS_PREZO_PREFIX'] = '/plugins/prezo/Gestion';
$_ENV['AWS_CDN_PATH'] = '';
$_ENV['AWS_ACCESS_KEY_ID'] = '';
$_ENV['AWS_SECRET_ACCESS_KEY'] = '';
$_ENV['AWS_DEFAULT_REGION'] = '';
$_ENV['AWS_BUCKET'] = '';
$_ENV['AWS_USE_PATH_STYLE_ENDPOINT'] = '';
