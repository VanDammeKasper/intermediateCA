#! /bin/bash
#variablen

cert_privateKey_destination="/opt/zimbra/ssl/zimbra/commercial/commercial.key"

cert_domain="mail.annabeltextiles.com"


# append fullchain
printf -- 'appending fullchain\n'
git clone https://github.com/vandammekasper/intermediateCA/

sleep 5

cat fullchain.cer intermediateCA/intermediate.cer > temp.cer

sleep 3
rm fullchain.cer

sleep 3
mv temp.cer fullchain.cer



# move privatekey

printf -- 'removing old private key\n'
rm $cert_privateKey_destination

printf -- 'copying private key\n'
cp $cert_domain.key $cert_privateKey_destination

chown zimbra:zimbra $cert_privateKey_destination

# verify certs
sleep 3

printf -- 'verifying certificates \n'
sudo -u zimbra /opt/zimbra/bin/zmcertmgr verifycrt comm $cert_domain.key $cert_privateKey_destination fullchain.cer

sleep 3
# deploy certs

printf -- 'deploying certificates\n'
sudo -u zimbra /opt/zimbra/bin/zmcertmgr deploycrt comm $cert_domain.cer fullchain.cer
