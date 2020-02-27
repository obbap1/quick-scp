#!/bin/sh


set -eu

# LARGE_SECRET_PASSPHRASE is the passphrase to decrypt the pem file.

# Create secrets folder for GPG decrypting
mkdir $HOME/secrets

# decrypt gpg file to .pem file

gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output $HOME/secrets/$PEM_FILE_NAME $NAME_OF_GPG

# pass souce, username, target and host as environmental variables

sudo chmod 600 ~/secrets/$PEM_FILE_NAME

sudo chmod 644 ~/.ssh/known_hosts

sudo chmod 755 ~/.ssh

sudo chmod a=rw /dev/tty

scp -o StrictHostKeyChecking=no -v -P $PORT -i $HOME/secrets/pbaba.pem $SOURCE $USERNAME@$HOST:$TARGET

echo "I am done baby!!!!" 