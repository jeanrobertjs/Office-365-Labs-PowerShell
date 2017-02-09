## GESTION DES BOITES AUX LETTRES ##

# Voir toutes les boites aux lettres
Get-Mailbox

# Obtenir les détails de la boite aux lettres de l'utilsateur "admin"
Get-Mailbox -Identity admin | fl

# Obtenir les boites aux lettres qui ont la propriété 'CustomAttribute15' qui contient 'Test'
Get-Mailbox | Where-Object {$_.CustomAttribute15 -like "*Test*"}

# Obtenir les boites aux lettres qui ont la propriété 'CustomAttribute15' qui contient 'Test' et afficher les propriétés Name, Alias, et CustomAttribute15
Get-Mailbox | Where-Object {$_.CustomAttribute15 -like "*Test*"} | select Name, Alias, CustomAttribute15

# 
Get-Mailbox -Filter "CustomAttribute15 -like '*Test*'"



## Note sur l'utilisation de 'Where-Object' ou de '-Filter' :

## 'Where-Object' = exécution côté client --> Dans l'exemple précédent on récupère l'ensemble des boites aux lettres puis on filtre
## '-Filter' = exécution côté serveur --> Dans l'exemple prédécent, on récupére directement un résultat filtrer coté serveur. Donc moins d'opérations.

## Du coup -Filter est plus rapide sur des grands jeux de données. 