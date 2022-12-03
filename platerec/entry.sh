# This file updates the Plate Rec config.ini with any balenaCloud device variables
# 
# Do not edit the config.ini directly if you use any balenaCloud device variables!
# Rather, set USE_VARS to false (or delete it) and then edit config.ini

echo "Starting the config script."

#if [[ "$USE_VARS" = "true" || "$USE_VARS" = "True" ]] ; then
if [ "$USE_VARS" = true ]; then
  echo "Using config variables..."

  # sleep to allow for multiple device variable changes without a lot of false restarts
  echo "Sleeping for 8 seconds..."
  #sleep 8

  if [[ -z $REGIONS ]]; then
    regions0="# regions not set"
  else
    region0="regions = ${REGIONS}"
    echo "Using REGIONS value."
  fi

  if [[ -z $TIMEZONE ]]; then
    timezone0="timezone = UTC"
  else
    timezone0="timezone = ${TIMEZONE}"
    echo "Using TIMEZONE value."
  fi

  if [[ -z $MMC ]]; then
    mmc0="mmc = false"
  else
    mmc0="mmc = ${MMC}"
    echo "Using MMC value."
  fi

  if [[ -z $CAMERA1_URL ]]; then
    camera1_url0=""
  else
    camera1_url0="url = ${CAMERA1_URL}"
    echo "Using CAMERA1_URL value."
  fi

  if [[ -z $WEBHOOK_TARGETS ]]; then
    webhook_targets0="# webhook_targets not set"
  else
    webhook_targets0="webhook_targets = ${WEBHOOK_TARGETS}"
    echo "Using WEBHOOKS_TARGETS value."
  fi

  if [[ -z $WEBHOOK_IMAGE ]]; then
    webhook_image0=""
  else
    webhook_image0="webhook_image = ${WEBHOOK_IMAGE}"
    echo "Using WEBHOOK_IMAGE value."
  fi

  if [[ -z $WEBHOOK_HEADER ]]; then
    webhook_header0="# webhook_header not set"
  else
    webhook_header0="webhook_header = ${WEBHOOK_HEADER}"
    echo "Using WEBHOOK_HEADER value."
  fi
  
  # back up current config if not a generated file
  if grep -Fxq "# f6e3a22d3c114d21a3c3k" /user-data/config.ini
  then
    # do nothing
    echo "Current file is generated"
  else
    echo "Backing up current config."
    cp /user-data/config.ini /user-data/config.bak
  fi

  # overwrite config.ini with clean config var file 
  cp /app/config.var /user-data/config.ini
  # update config variables in ini file
  # using | in sed to allow for urls
  # https://stackoverflow.com/questions/40714970/escaping-forward-slashes-in-sed-command
  #echo "a1"
  sed -i "s|zmmc.*|${mmc0}|" /user-data/config.ini
  #echo "a2"
  sed -i "s|ztimezone.*|${timezone0}|" /user-data/config.ini
  #echo "a3"
  sed -i "s|zregions.*|${regions0}|" /user-data/config.ini
  #echo "a4"
  sed -i "s|zurl.*|${camera1_url0}|" /user-data/config.ini
  #echo "a5"  
  sed -i "s|zwebhook_targets.*|${webhook_targets0}|" /user-data/config.ini
  #echo "a6"
  sed -i "s|zwebhook_image.*|${webhook_image0}|" /user-data/config.ini
  #echo "a7"  
  sed -i "s|zwebhook_header.*|${webhook_header0}|" /user-data/config.ini
  #echo "a8"
else
  
  echo "Not using config variables."
  if grep -Fxq "# f6e3a22d3c114d21a3c3k" /user-data/config.ini
  then
    # we are using a generated file, so replace with the backup ini
    cp /user-data/config.bak /user-data/config.ini
    echo "Restored previous configuration."
  fi

fi

./start.sh
