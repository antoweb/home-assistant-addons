#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

#####################
## USER PARAMETERS ##
#####################

# REQUIRED
BUCKET_NAME="s3://$(bashio::config 'bucketName')"
export ENDPOINT_URL="$(bashio::config 'endpointUrl')"
export REGION="$(bashio::config 'region')"
export AWS_ACCESS_KEY_ID="$(bashio::config 'accessKey')"
export AWS_SECRET_ACCESS_KEY="$(bashio::config 'secretKey')"
export SOURCE_DIR="$(bashio::config 'sourceDir')"
#RESTORE="$(bashio::config 'restore')"

#########USEFULE VARIABLES########
export NOW=`date '+%F_%H_%M_%S'`
export SOURCE_DIR_ABS="${SOURCE_DIR:1}"

###########
## MAIN  ##
###########


############################
## SET AWS CLI COMMAND  ##
############################

echo "Aws cli version: $(aws --version)"

#if [[ ${RESTORE} == "true" ]]; then
#    echo "Restoring backups from ${BUCKET_NAME}"
#    duplicity \
#    "${NO_ENCRYPTION}" \
#    --file-prefix-manifest manifest- \
#    --s3-endpoint-url "${ENDPOINT_URL}" \
#    --s3-region-name "${REGION}" \
#    --force \
#    restore \
#    "${BUCKET_NAME}" \
#    "${SOURCE_DIR}"
#else
#    echo "Backuping $(ls -l ${SOURCE_DIR}) to ${BUCKET_NAME}"

    #echo "aws s3 sync ${SOURCE_DIR} ${BUCKET_NAME} --endpoint-url ${ENDPOINT_URL} --region ${REGION}"
    #aws s3 sync "${SOURCE_DIR}" "${BUCKET_NAME}" --endpoint-url "${ENDPOINT_URL}" --region "${REGION}"
if [[ -z ${ENDPOINT_URL} ]]; then
    set -x
    tar cvzf /data/${NOW}_${SOURCE_DIR_ABS}.tar.gz "${SOURCE_DIR}"
    aws s3 sync /data/ "${BUCKET_NAME}" --exclude "*" --include "*.tar.gz" --region "${REGION}"
    rm -f /data/*.tar.gz
    set +x
else
    set -x
    tar cvzf /data/${NOW}_${SOURCE_DIR_ABS}.tar.gz "${SOURCE_DIR}"
    aws s3 sync /data/ "${BUCKET_NAME}" --exclude "*" --include "*.tar.gz" --endpoint-url "${ENDPOINT_URL}" --region "${REGION}"
    rm -f /data/*.tar.gz
    set +x
fi