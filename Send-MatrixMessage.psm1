<#
.SYNOPSIS
    Send a message to a Matrix room.
.DESCRIPTION
    Using this function/cmdlet you can send a message to a Matrix room, straight from PowerShell. Note that your account needs to be in the room first.
.PARAMETER HomeServer
    The homeserver your account is on. Note that sometimes you might have to specify a port, please check with the homeserver you're on if you need to do
.PARAMETER Message
    The message you want to send.
.PARAMETER Room
    The room you want to send the message to. Note that you cannot send a message to a room alias, for example #matrix:matrix.org. You need to use the room ID, for example !OGEhHVWSdvArJzumhm:matrix.org.
.PARAMETER Token
    Your access token. You can search online how to get it from your client.
.EXAMPLE
    # Send a message to !yKETMDJQlNREDygPyy:willy.club, from Matrix.org homeserver, with the message "Hello World!".
    Send-MatrixMessage -HomeServer matrix.org -Message "Hello World!" -Room "!yKETMDJQlNREDygPyy:willy.club" -Token "notokenhere"
#>
function Send-MatrixMessage {
    param(
        [Parameter(Mandatory=$true)]
        [string]$HomeServer,
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [Parameter(Mandatory=$true)]
        [string]$Room,
        [Parameter(Mandatory=$true)]
        [string]$Token
    )

    $random = Get-Random
    $endpoint = "https://$HomeServer/_matrix/client/v3/rooms/$Room/send/m.room.message/$random"
    $hash=@{
        msgtype="m.text"
        body=$Message
    }
    $json = $hash | ConvertTo-Json
    $headers = @{"Authorization" = "Bearer $Token"}

    # Say that the message is being sent.
    Write-Host -ForegroundColor Blue "Sending $Message to $Room on $HomeServer."
    try {
        $response = Invoke-WebRequest -Uri $endpoint -Method PUT -Body $json -Headers $headers -ContentType "application/json"
        $status = $response.StatusCode
    } catch {
        Write-Host -ForegroundColor Red "Failed to send $Message to $Room on $HomeServer. Status code: $($_.Exception.Response.StatusCode)."
    }

    if ($status -eq 200) {
        Write-Host -ForegroundColor Green "Successfully sent $Message to $Room on $HomeServer."
    }
}

Export-ModuleMember -Function Send-MatrixMessage