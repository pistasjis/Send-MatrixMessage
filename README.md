# Send-MatrixMessage

A PowerShell module/cmdlet to send messages to a Matrix room.

## Installation

### PowerShell Gallery

```powershell
Install-Module Send-MatrixMessage
```

### Manual

```powershell
git clone https://github.com/Odyssey346/Send-MatrixMessage.git ~/Documents/PowerShell/Modules/Send-MatrixMessage
Install-Module Send-MatrixMessage
```

## Usage

You need a Matrix access token. You can find out how to find yours by going online and checking how to retrieve it in your client.

Also, you need to be in the room you want to send the message to. Plus, you need a room ID. It is not the same as a room alias (for example, #matrix:matrix.org is not a valid room ID)

Send a message to !yKETMDJQlNREDygPyy:willy.club, from Matrix.org homeserver, with the message "Hello World!".
`Send-MatrixMessage -HomeServer matrix.org -Message "Hello World!" -Room "!yKETMDJQlNREDygPyy:willy.club" -Token "yourtokenhere"`