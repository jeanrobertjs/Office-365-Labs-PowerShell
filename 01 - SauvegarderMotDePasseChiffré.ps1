# Enregistrement d'un mot de passe crypté dans un fichier
read-host -prompt "Entrer un mot de passe qui sera crypté et enregistré dans monCompteAADSecurestring.txt" -assecurestring | convertfrom-securestring | out-file .\monCompteAADSecurestring.txt
