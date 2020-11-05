Param(
 
    [Parameter(Mandatory= $true)]  
    [String]$KeyRequired

)

$FullResponse = Invoke-RestMethod -Method GET -Uri http://169.254.169.254/metadata/instance?api-version=2017-04-02 -Headers @{“Metadata”=”True”} | ConvertTo-JSON -Depth 99
$convertedresponse = $FullResponse | convertfrom-json
if ($KeyRequired -ne "all"){
$counter = $KeyRequired.split("/")
$reverse = $null
foreach($key in $counter)
{
    $reverse =  $convertedresponse.$($key)
    $convertedresponse = $reverse
}
$finalresult = $convertedresponse | ConvertTo-Json
Write-Host "The Value For The Given Key is" $finalresult
}
else{
    Write-Host "The metadata value is" $FullResponse
}