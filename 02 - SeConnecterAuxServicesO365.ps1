# Récupération du mot de passe crypté dans le fichier onCompteAADSecurestring.txt
$Password = Get-Content .\monCompteAADSecurestring.txt | convertto-securestring

# Authentification auprès de l'Azure Active Directory (AAD)
Import-Module MSOnline
$Credential = new-object -typename System.Management.Automation.PSCredential -argumentlist "admin@OurCustomerO365labsPStest.onmicrosoft.com",$Password
Connect-MsolService -Credential $Credential

# Créé une session PowerShell pour Skype Entreprise avec les info d'identification fournies
Import-Module LyncOnlineConnector
$SkypeForBusinessSession = New-CsOnlineSession -Credential $Credential

# Créé une session PowerShell pour SharePoint Online avec les info d'identification fournies
Import-Module Microsoft.Online.Sharepoint.PowerShell
Connect-SPOService -url https://OurCustomerO365labsPStest-admin.sharepoint.com -Credential $Credential

# Créé une session PowerShell pour Exchange Online avec les info d'identification fournies
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $Credential -Authentication "Basic" -AllowRedirection
Import-PSSession $ExchangeSession