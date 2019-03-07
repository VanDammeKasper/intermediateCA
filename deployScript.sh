#! bin/bash
#variablen

cert_privateKey_destination="/opt/zimbra/commercial/commercail.key"

cert_domain="mail.annabeltextiles.com"


# append fullchain
printf -- 'appending fullchain'
git clone https://github.com/vandammekasper/intermediateCA/


cat fullchain.cer intermediateCA/interemediate.cer > temp.cer
rm fullchain.cer
mv temp.cer fullchain.cer
rm temp.cer


# move privatekey

printf -- 'moving private key'
mv $cert_domain.cer $cert_privateKey_destination

# verify certs

/opt/zimbra/bin/zmcertmgr verifycrt comm $cert_privateKey_destination $cert_domain.cer fullchain.cer


# deploy certs

printf -- 'deploying certificates'
/opt/zimbra/bin/zmcertmgr deploycrt comm $cert_domain.cer fullchain.cer
