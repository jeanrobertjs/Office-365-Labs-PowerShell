
# Get Account SKUs
Get-MsolAccountSku

# Access information about the SKUs
(Get-MsolAccountSku).Count 

(Get-MsolAccountSku).ServiceStatus

(Get-MsolAccountSku)[2].ServiceStatus

# Create license option for Sales users. They will have all services, except Sway, Yammer, Project with an Office 365 Business Premium subscription
$LoSales = New-MsolLicenseOptions -AccountSkuID reseller-account:O365_BUSINESS_PREMIUM -DisabledPlans PROJECTWORKMANAGEMENT, SWAY, YAMMER_ENTERPRISE

# Create license option for Finance. They will have only Exchange Online service with an Office 365 Business Premium subscription
$LoFinance = New-MsolLicenseOptions -AccountSkuID reseller-account:O365_BUSINESS_PREMIUM -DisabledPlans PROJECTWORKMANAGEMENT, SWAY, YAMMER_ENTERPRISE, OFFICE_BUSINESS, MCOSTANDARD, SHAREPOINTWAC, SHAREPOINTSTANDARD

# Get all VIP users (CxO roles) and load them into a variable
$VIPUsers = Get-MsolUser | where-object {$_.Department -like "*VIP*"}

# Get all unlicensed Sales users and load them into a variable
$SalesUsers = Get-MsolUser -UnlicensedUsersOnly | where-object {$_.Department -like "*Sales*"}

# Get all unlicensed Fincance users and load them into a variable
$FinanceUsers = Get-MsolUser -UnlicensedUsersOnly | where-object {$_.Department -like "*Finance*"}

# Assign the LOSales license options to the Sales users 
$SalesUsers | Foreach-Object {Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalname -AddLicenses reseller-account:O365_BUSINESS_PREMIUM -LicenseOptions $LoSales}

# Assign the LoFinance license option to Finance users
$FinanceUsers | Foreach-Object {Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalname -AddLicenses reseller-account:O365_BUSINESS_PREMIUM -LicenseOptions $LoFinance}

# Change license SKU for VIP users. We will replace "Office 365 E3" by "Microsoft 365 E3" SKU with all service enabled.
$VIPUsers | Foreach-Object {Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalname -AddLicenses reseller-account:SPE_E3 -RemoveLicenses contoso:ENTERPRISEPACK}
