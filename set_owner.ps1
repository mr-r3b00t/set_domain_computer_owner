$computers = Get-ADComputer -filter *
$syteminfo = (gwmi WIN32_ComputerSystem)
$syteminfo.Domain
$objUser = New-Object System.Security.Principal.NTAccount($syteminfo.Domain, "Domain Admins")

foreach($computer in $computers){


$path = "AD:$($computer.DistinguishedName.ToString())"
$acl = Get-Acl -Path $path

$computer.DNSHostName
$acl.Owner
$acl.Path
if($acl.Owner -notlike '*Domain Admins*')
{

write-host "Setting Owner!" -ForegroundColor Red

$acl.SetOwner($objUser)
Set-Acl -Path $path -AclObject $acl

}


}
