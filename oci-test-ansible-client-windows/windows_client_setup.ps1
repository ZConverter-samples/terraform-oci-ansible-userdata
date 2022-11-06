<powershell>
net use Z: \\192.168.0.123\share "Dc7kQy]W2NFo" /user:ubuntu
$var = (Get-Content Z:\windows.yaml)
$ip = (nslookup myip.opendns.com resolver1.opendns.com)[4].Substring(10) + ":"
Set-Content Z:\windows.yaml $nul -Encoding ascii
foreach ($line in $var)
{
	if ( 'true' -eq $line.Contains("hosts:") )
	{
		$line = $line.Insert( $line.length, "
                $ip
                        ansible_connection: winrm
                        ansible_port: 5985
                        ansible_user: opc
                        ansible_password: Dc7kQy]W2NFo
" )
	}
	Write-Output $line | Add-Content Z:\windows.yaml -Encoding ascii
}
net use Z: /delete
Set-Item -Force WSMan:\localhost\Client\AllowUnencrypted $True
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true
Set-LocalUser -Name opc -Password (ConvertTo-SecureString "Dc7kQy]W2NFo" -AsPlainText -Force)
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
</powershell>