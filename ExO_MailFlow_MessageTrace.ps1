# Exchange Online | Mail Flow > Message Trace

$dateEnd = get-date 
$dateStart = $dateEnd.AddHours(-720)

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Select-Object Received, SenderAddress, RecipientAddress, Subject, Status, ToIP, FromIP, Size, MessageID, MessageTraceID | Out-GridView 

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Select-Object Received, SenderAddress, RecipientAddress, Subject, Status, ToIP, FromIP, Size, MessageID, MessageTraceID | Where {$_.Status -eq "Failed"} | Out-GridView

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Where {$_.Status -eq "Failed"} | Get-MessageTraceDetail | Select-Object MessageID, Date, Event, Action, Detail, Data | Out-GridView

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Where {$_.Subject -like "*something from the subject*"} 