#!/bin/bash
echo "Creating tutor plugins dir"
mkdir -p "$(tutor plugins printroot)"

echo "transfering the premade plugins to the $(tutor plugins printroot)"
cp /home/$USER/Desktop/install_scripts/fro-auth.py /home/$USER/.local/share/tutor-plugins/

echo "tutor config set"
tutor config save \
  --set LMS_HOST="local.openedx.io" \
  --set CMS_HOST="studio.local.openedx.io" \
  --set PLATFORM_NAME="Aavapti Dev Server" \
  --set CONTACT_EMAIL="$USER@afidigitalservices.com" \
  --set ENABLE_HTTPS="false"


echo "tutor plugins list"
echo "enabling custom auth"

pip install pluggy --break-system-packages
tutor plugins enable fro-auth

echo "building the mfe image"

tutor images build mfe

tutor local launch --non-interactive

echo "transfering custom indigo theme to the env/build openedx/themes"

rm -rf /home/$USER/.local/share/tutor/env/build/openedx/themes/indigo
cp -r /home/$USER/Desktop/install_scripts/indigo /home/$USER/.local/share/tutor/env/build/openedx/themes/

echo "building the image"

tutor images build openedx





# tutor config save --set RUN_MODE=production
# tutor local launch --non-interactive
