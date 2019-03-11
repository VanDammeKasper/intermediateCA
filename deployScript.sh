#! /bin/bash
#variablen

cert_privateKey_destination="/opt/zimbra/ssl/zimbra/commercial/commercial.key"

cert_domain="mail.annabeltextiles.com"


# append fullchain
printf -- 'appending fullchain\n'
git clone https://github.com/vandammekasper/intermediateCA/

sleep 4

cat fullchain.cer intermediateCA/intermediate.cer > temp.cer

sleep 2
rm fullchain.cer

sleep 2
mv temp.cer fullchain.cer

sleep 1

# move privatekey

printf -- 'removing old private key\n'
rm $cert_privateKey_destination

sleep 1

printf -- 'copying private key\n'
cp $cert_domain.key $cert_privateKey_destination

sleep 1

printf -- 'making zimbra ownder of /opt/zimbra/ssl/zimbra/commercial/ file'
chown zimbra:zimbra $cert_privateKey_destination

sleep 3
# deploy certs

printf -- 'deploying certificates\n'
sudo -u zimbra /opt/zimbra/bin/zmcertmgr deploycrt comm $cert_domain.cer fullchain.cer
