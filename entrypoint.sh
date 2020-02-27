#!/bin/sh


set -eu

# LARGE_SECRET_PASSPHRASE is the passphrase to decrypt the pem file.

# Create secrets folder for GPG decrypting
mkdir $HOME/secrets

# Find if a .gpg file exists
count=`ls -1 *.gpg 2>/dev/null | wc -l`
if [ $count != 0 ]
then
    # take the first gpg file that exists
    nameOfGpg=`echo *.gpg | awk '{print $1}'`
    echo "${nameofGpg}, file has been found"
    filename="${nameOfGpg%.*}"
    echo "${filename#**.} --- filename" 
    if [ "${filename#**.}" == "pem" ]
    then
        echo 'Valid pem file! Decrypting...'
    else
        echo 'Invalid pem file. Use naming system <filename>.pem.gpg'
    fi
else
    echo 'Invalid gpg file. Use naming system <filename>.pem.gpg'
fi

# decrypt gpg file to .pem file

gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" \
--output $HOME/secrets/$filename $nameOfGpg

# pass souce, username, target and host as environmental variables

sudo chmod 600 ~/secrets/$filename

sudo chmod 644 ~/.ssh/known_hosts

sudo chmod 755 ~/.ssh

sudo chmod a=rw /dev/tty

scp -o StrictHostKeyChecking=no -v -P $port -i $HOME/secrets/pbaba.pem $SOURCE $USERNAME@$HOST:$TARGET

echo "I am done baby!!!!" 