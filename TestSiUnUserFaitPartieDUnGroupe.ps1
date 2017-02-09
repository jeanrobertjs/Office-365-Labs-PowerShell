## SAMPLE FUNCTION: TEST SI UN UTILISATEUR FAIT PARTIE D'UN GROUPE OU PAS

# Creaion d'une fonction qui permet de faire le test
Function IsMemberOfGroup($groupName, $userPrincipalName) {
  # Retourne le ou les groupes répondant au nom de la varible $groupName
  $group = Get-MsolGroup -SearchString $groupName -All

  # Test est ce qu'au moins un gropue a été trouvé
  if($group -eq $null){
    Write-Output $group
    Write-Host "Group not found"
    return
  }

  # Teste est-ce que le nom de groupe est unique
  if($group.count -gt 1){
    Write-Host "More than one matching group found"
    return
  }

  # Test est-ce que l'utilisateur existe
  $user = Get-MsolUser -UserPrincipalName $userPrincipalName

  if($user -eq $null){
    Write-Host "User not found"
    return
  }

  # Test pour voir si l'utilsateur fait bien partie du groupe
  $groupMember = Get-MsolGroupMember -GroupObjectId $group.ObjectId -All | Where-Object { $_.ObjectId -eq $user.ObjectId }

  if($groupMember -eq $null){
    Write-Output $false
  }else{
    write-Output $true
  }
}

# Exemple d'utilisation
IsMemberOfGroup "Liga AC Labs" martin@OurCustomerO365labsPStest.onmicrosoft.com










