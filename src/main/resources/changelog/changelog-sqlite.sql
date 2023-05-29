-- liquibase formatted sql
-- changeset jerry:1

CREATE TABLE `t_comment`
(
    `id`                INTEGER PRIMARY KEY        NOT NULL,
    `memo_id`           int       NOT NULL,
    `content`           text      NOT NULL,
    `user_id`           int       NOT NULL,
    `user_name`         TEXT      NOT NULL,
    `mentioned`         TEXT           DEFAULT NULL,
    `created`           timestamp NULL default(datetime(CURRENT_TIMESTAMP,'localtime')),
    `updated`           timestamp NULL ,
    `mentioned_user_id` TEXT           DEFAULT NULL
);

CREATE TABLE `t_dev_token`
(
    `id`      INTEGER PRIMARY KEY   NOT NULL,
    `name`    TEXT NOT NULL,
    `token`   TEXT DEFAULT NULL,
    `user_id` int  DEFAULT '1'
);

CREATE TABLE `t_memo`
(
    `id`             INTEGER PRIMARY KEY        NOT NULL,
    `user_id`        int       NOT NULL,
    `content`        text,
    `tags`           TEXT               DEFAULT NULL,
    `visibility`     TEXT      NOT NULL DEFAULT 'PUBLIC',
    `status`         TEXT      NOT NULL DEFAULT 'NORMAL',
    `created`        timestamp NULL     default(datetime(CURRENT_TIMESTAMP,'localtime')),
    `updated`        timestamp NULL,
    `priority`       int                DEFAULT '0',
    `comment_count`  int                DEFAULT '0',
    `like_count`     int                DEFAULT '0',
    `enable_comment` int                DEFAULT '0',
    `view_count`     int                DEFAULT '0'
);

CREATE TABLE `t_resource`
(
    `public_id`     TEXT      NOT NULL,
    `memo_id`       int       NOT NULL,
    `user_id`       int       NOT NULL,
    `file_type`     TEXT           DEFAULT NULL,
    `file_name`     TEXT      NOT NULL,
    `file_hash`     TEXT      NOT NULL,
    `size`          bigint    NOT NULL,
    `internal_path` TEXT           DEFAULT NULL,
    `external_link` text,
    `storage_type`  TEXT           DEFAULT NULL,
    `created`       timestamp NULL default(datetime(CURRENT_TIMESTAMP,'localtime')),
    `updated`       timestamp NULL,
    `suffix`        TEXT           DEFAULT NULL,
    PRIMARY KEY (`public_id`)
);

CREATE TABLE `t_sys_config`
(
    `key`           TEXT NOT NULL,
    `value`         text NOT NULL,
    `default_value` text,
    PRIMARY KEY (`key`)
);

CREATE TABLE `t_tag`
(
    `name`       TEXT      NOT NULL,
    `user_id`    int       NOT NULL,
    `created`    timestamp NULL default(datetime(CURRENT_TIMESTAMP,'localtime')),
    `updated`    timestamp NULL,
    `memo_count` int            DEFAULT NULL,
    `id`         INTEGER PRIMARY KEY        NOT NULL
);

CREATE TABLE `t_user`
(
    `id`                     INTEGER PRIMARY KEY        NOT NULL,
    `username`               TEXT      NOT NULL,
    `password_hash`          TEXT      NOT NULL,
    `email`                  TEXT           DEFAULT NULL,
    `display_name`           TEXT           DEFAULT NULL,
    `bio`                    text,
    `created`                timestamp NULL default(datetime(CURRENT_TIMESTAMP,'localtime')),
    `updated`                timestamp NULL,
    `role`                   TEXT           DEFAULT 'USER',
    `avatar_url`             TEXT           DEFAULT NULL,
    `last_clicked_mentioned` timestamp NULL DEFAULT NULL,
    `default_visibility`     TEXT           DEFAULT 'PUBLIC'
);

CREATE TABLE `t_user_memo_relation`
(
    `id`       INTEGER PRIMARY KEY        NOT NULL,
    `memo_id`  int       NOT NULL,
    `user_id`  int       NOT NULL,
    `fav_type` TEXT      NOT NULL DEFAULT 'LIKE',
    `created`  timestamp NULL     default(datetime(CURRENT_TIMESTAMP,'localtime')),
    `updated`  timestamp NULL
);



CREATE UNIQUE INDEX `t_tag_tag_IDX` ON `t_tag` (`user_id`);
CREATE UNIQUE INDEX `t_user_username` ON `t_user` (`username`);
CREATE UNIQUE INDEX `t_user_T_USER_UNI1` ON `t_user` (`display_name`);



INSERT INTO t_user (id, username, password_hash, email, display_name, bio, created, updated, role, avatar_url,
                         last_clicked_mentioned, default_visibility)
VALUES (1, 'admin', '$2a$10$sKRq1dB51BKam9IPO5GpSOase4L9JEjqlKLAulrnGWbw3OwBYebCy', 'yoyo@openmbox.net', 'JerryWang', 'free style!', CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, 'ADMIN',
        'http://127.0.0.1:38321/api/resource/veugjShdHhhfFYisKHcj', null, 'PUBLIC');

INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('AWSS3_PARAM', '{}', '{}');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('CORS_DOMAIN_LIST', 'http://127.0.0.1:3000,http://127.0.0.1:3333', null);
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('CUSTOM_CSS', '', '');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('CUSTOM_JAVASCRIPT', '', '');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('DOMAIN', 'http://127.0.0.1:38321', null);
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('INDEX_WIDTH', '50rem', '50rem');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('MEMO_MAX_LENGTH', '300', '300');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('OPEN_COMMENT', 'false', 'false');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('OPEN_LIKE', 'false', 'false');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('OPEN_REGISTER', 'false', 'false');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('QINIU_PARAM', '{}', '{}');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('STORAGE_TYPE', 'LOCAL', 'LOCAL');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('USER_MODEL', 'SINGLE', 'SINGLE');
INSERT INTO t_sys_config (`key`, value, default_value) VALUES ('WEBSITE_TITLE', '', '记录生活');