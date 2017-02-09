##  GESTION DES UTILISATEURS ##

# Importation d'un fichier .csv et creation des utilisateurs.
Import-Csv -Path .\ImportUsers.csv | ForEach-Object { New-Msoluser -UserPrincipalName $_.UserPrincipalName -FirstName $_.FirstName -LastName $_.LastName -Department $_.Department -Title $_.Title -Office $_.Office -PhoneNumber $_.PhoneNumber -Fax $_.Fax -StreetAddress $_.StreetAddress -MobilePhone $_.MobilePhone -City $_.city -State $_.State -Country $_.Country -DisplayName $_.DisplayName -PostalCode $_.PostalCode -UsageLocation "FR" }

# Supprimer tous les utilisateurs qui font partie du département "Technical Readiness"
Get-Msoluser -all | where-object {$_.Department -like "*Technical*"} | Remove-MsolUser -force

# Supprimer tous les comptes utilisateurs supprimés des "Utilisateurs supprimés"
Get-MsolUser -ReturnDeletedUsers | Remove-Msoluser -RemoveFromRecycleBin -force