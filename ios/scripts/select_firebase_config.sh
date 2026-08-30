#!/bin/sh
set -e

case "${CONFIGURATION}" in
  *-dev)  FLAVOR="Dev" ;;
  *-prod) FLAVOR="Prod" ;;
  *)
    echo "warning: CONFIGURATION '${CONFIGURATION}' has no flavor suffix; skipping Firebase plist copy."
    exit 0
    ;;
esac

SOURCE="${SRCROOT}/Runner/GoogleService-Info-${FLAVOR}.plist"
DESTINATION="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

if [ ! -f "${SOURCE}" ]; then
  echo "error: ${SOURCE} not found."
  exit 1
fi

cp "${SOURCE}" "${DESTINATION}"
echo "Copied GoogleService-Info-${FLAVOR}.plist -> ${DESTINATION}"
