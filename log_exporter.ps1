$LOGFILE_NAME = "failed_rdp.log"
$IP_TABLE_NAME = "ip_table.txt"
$LOGFILE_PATH = "C:\ProgramData\$($LOGFILE_NAME)"
$IP_TABLE_PATH = "C:\ProgramData\$($IP_TABLE_NAME)"

#Filter for RDP events
$XMLFilter = @'
<QueryList> 
   <Query Id="0" Path="Security">
         <Select Path="Security">
              *[System[(EventID='4625')]]
          </Select>
    </Query>
</QueryList> 
'@

#check for log file
if ((Test-Path $LOGFILE_PATH) -eq $false) {
    New-Item -ItemType File -Path $LOGFILE_PATH
}

#check for IP table
if ((Test-Path $IP_TABLE_PATH) -eq $false) {
    New-Item -ItemType File -Path $IP_TABLE_PATH
}

Function check-IP($ip){
    #first check IP table if we've already recorded the IP
    $table_contents = Get-Content -Path $IP_TABLE_PATH
    if ($table_contents -match "$($ip)"){
        # Write-Host "FOUND"
        foreach ($line in $table_contents){
            if ($line -match $ip){
                # Write-Output $line.split("|")[1].split(",")
                $lattitude = $line.split("|")[1].split(",")[0]
                $longitude = $line.split("|")[1].split(",")[1]
                $country = $line.split("|")[1].split(",")[2]
                $city = $line.split("|")[1].split(",")[3]
            }
        }
    }
    else{#if we didn't find the IP address we'll query an API for the data
        Write-Host "Not Found"
        $API_ENDPOINT = "http://ip-api.com/json/$($ip)"
        $response = Invoke-WebRequest -UseBasicParsing -Uri $API_ENDPOINT
        $responseData = $response.Content | ConvertFrom-Json
        # Write-Output $responseData
        if($responseData.status -eq "success"){ #if the api finds the IP, record it to the table
            $lattitude = $responseData.lat
            $longitude = $responseData.lon
            $country = $responseData.country
            $city = $responseData.city
            "$($ip),|$($lattitude),$($longitude),$($country),$($city)" | Out-File $IP_TABLE_PATH -Append -Encoding utf8
        }
    }
    return "$($ip),$($lattitude),$($longitude),$($country),$($city)"
}





