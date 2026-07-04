<?php

/**
 * DevBox runtime configuration for SquirrelMail.
 *
 * This file is mounted into the container as config/config.php.
 * It overrides config_default.php settings for the DevBox environment.
 *
 * Do NOT commit secrets to this file.
 * This file uses test-only IMAP and SMTP services.
 *
 * @package squirrelmail
 * @subpackage config
 */

/**
 * Organization preferences
 */
$org_name      = 'SquirrelMail (DevBox)';
$org_title     = 'SquirrelMail DevBox';
$domain        = 'devbox.local';
$provider_name = '';
$provider_uri  = '';

/**
 * Server settings — use Docker service names for internal networking
 */
$imapServerAddress = 'imap';
$imapPort          = 143;
$imap_server_type  = 'dovecot';
$use_imap_tls      = 0;
$imap_auth_mech    = 'login';

$smtpServerAddress = 'smtp';
$smtpPort          = 1025;
$use_smtp_tls      = 0;
$smtp_auth_mech    = 'none';
$useSendmail       = false;

/**
 * Canonical base URL.
 * Required for post-login redirects to preserve the HTTPS host
 * when SquirrelMail is behind a Caddy reverse proxy.
 */
$config_location_base = 'https://squirrelmail.qlidemo.com';

/**
 * Data and attachment directories (outside web root, inside Docker volume)
 */
$data_dir       = '/var/local/squirrelmail/data/';
$attachment_dir = '/var/local/squirrelmail/attach/';

/**
 * Disallow remote configtest access.
 * Must remain false for public-route safety.
 * Use docker compose exec for local diagnostics.
 */
$allow_remote_configtest = false;

/**
 * Debug mode — simple for DevBox
 */
$sm_debug_mode = SM_DEBUG_MODE_SIMPLE;

/**
 * Disable plugins by default for minimal DevBox runtime
 */
$plugins = array();

/**
 * Session name
 */
$session_name = 'SQMSESSID';
