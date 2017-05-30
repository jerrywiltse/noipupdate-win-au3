FileInstall("C:\Users\owner\Documents\dev\noip-config.ini",@scriptdir & "\noip-config.ini")
$iniFile = @scriptdir & "\noip-config.ini"
$username = Iniread($iniFile,"credentials","username","customer@domain.com")
$username = StringReplace($username,"@","%40")
$password = Iniread($iniFile,"credentials","password","defaultpassword")
$iniHostnameArray = IniReadSection($iniFile,"Hostnames")
$iniIpAddressArray = IniReadSection($iniFile,"IPAddresses")

While 1
If @error Then 
    MsgBox(4096, "", "Error occurred, probably no INI file.")
Else
	For $i = 1 To $iniHostnameArray[0][0]
		inetget("http://" & $username & ":" & $password & "@dynupdate.no-ip.com/nic/update?hostname=" & $iniHostnameArray[$i][1] & "&myip=1.1.1.1",@scriptdir & "\" & $iniHostnameArray[$i][1] & "-noip-updatelog01" & ".log",1)
		Sleep(5000)
		If $iniIpAddressArray[$i][1] <> "" OR $iniIpAddressArray[$i][1] = "0.0.0.0" Then 
			inetget("http://" & $username & ":" & $password & "@dynupdate.no-ip.com/nic/update?hostname=" & $iniHostnameArray[$i][1] & "&myip=" & $iniIpAddressArray[$i][1],@scriptdir & "\" & $iniHostnameArray[$i][1] & "-noip-updatelog02" & ".log",1)
		Else
			inetget("http://" & $username & ":" & $password & "@dynupdate.no-ip.com/nic/update?hostname=" & $iniHostnameArray[$i][1],@scriptdir & "\" & $iniHostnameArray[$i][1] & "-noip-updatelog02" & ".log",1)
		EndIf
	Next
EndIf	
Sleep(86400000)
Wend
	
