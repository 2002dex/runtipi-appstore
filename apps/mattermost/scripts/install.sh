#!/bin/sh
set -e

mkdir -p "${APP_DATA_DIR}/db"

mkdir -p \
"${APP_DATA_DIR}/mattermost/config" \
"${APP_DATA_DIR}/mattermost/data" \
"${APP_DATA_DIR}/mattermost/logs" \
"${APP_DATA_DIR}/mattermost/plugins" \
"${APP_DATA_DIR}/mattermost/client/plugins" \
"${APP_DATA_DIR}/mattermost/bleve-indexes"

chmod -R 755 "${APP_DATA_DIR}/mattermost"