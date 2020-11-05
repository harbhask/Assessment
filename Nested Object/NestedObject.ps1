function Get-NestedObjectValue($nestedobject,$keys)
{
    $convertedobject = $nestedobject | convertfrom-json
    $counter = $keys.split("/")
    $reverse = $null
    foreach($key in $counter)
    {
        $reverse =  $convertedobject.$($key)
        $convertedobject = $reverse
    }
    $finalresult = $convertedobject | ConvertTo-Json
    Write-Host "The Value For The Given Key is" $finalresult
}

