@echo off
REM Script para crear estructura de apuntes de Pentesting en AD
REM Autor: Adrián Prieto (para PNPT / OSCP)

set ROOT=Pentest-Notes

echo [+] Creando estructura en %ROOT% ...
mkdir %ROOT%

REM Carpetas principales
mkdir %ROOT%\00_Recon
mkdir %ROOT%\01_AD_Enumeration
mkdir %ROOT%\02_Creds
mkdir %ROOT%\03_Privesc
mkdir %ROOT%\04_Persistence
mkdir %ROOT%\05_DomainDominance
mkdir %ROOT%\06_LateralMovement
mkdir %ROOT%\Cheatsheets

REM Archivos Recon
echo # Nmap Recon > %ROOT%\00_Recon\Nmap.md
echo # Web Recon > %ROOT%\00_Recon\Web.md
echo # SMB Recon > %ROOT%\00_Recon\SMB.md
echo # RPC Recon > %ROOT%\00_Recon\RPC.md
echo # LDAP Recon > %ROOT%\00_Recon\LDAP.md

REM Archivos AD Enumeration
echo # Users & Groups > %ROOT%\01_AD_Enumeration\Users_Groups.md
echo # Policies > %ROOT%\01_AD_Enumeration\Policies.md
echo # SPNs > %ROOT%\01_AD_Enumeration\SPNs.md
echo # BloodHound > %ROOT%\01_AD_Enumeration\BloodHound.md
echo # ADCS > %ROOT%\01_AD_Enumeration\ADCS.md

REM Archivos Creds
echo # AS-REP Roasting > %ROOT%\02_Creds\ASREP.md
echo # Kerberoasting > %ROOT%\02_Creds\Kerberoast.md
echo # Password Spraying > %ROOT%\02_Creds\PasswordSpray.md
echo # PtH / PtT / Overpass > %ROOT%\02_Creds\PtH_PtT_Overpass.md
echo # Cracking > %ROOT%\02_Creds\Cracking.md

REM Archivos Privesc
echo # Group Policy Preferences > %ROOT%\03_Privesc\GPP.md
echo # Delegation > %ROOT%\03_Privesc\Delegation.md
echo # ACLs Misconfigs > %ROOT%\03_Privesc\ACLs.md
echo # Service Exploits > %ROOT%\03_Privesc\Services.md
echo # Misconfigurations > %ROOT%\03_Privesc\Misconfigs.md

REM Archivos Persistence
echo # Golden Ticket > %ROOT%\04_Persistence\GoldenTicket.md
echo # Silver Ticket > %ROOT%\04_Persistence\SilverTicket.md
echo # SID History > %ROOT%\04_Persistence\SIDHistory.md
echo # AdminSDHolder Abuse > %ROOT%\04_Persistence\AdminSDHolder.md
echo # Shadow Credentials > %ROOT%\04_Persistence\ShadowCreds.md

REM Archivos Domain Dominance
echo # DCSync > %ROOT%\05_DomainDominance\DCSync.md
echo # DCShadow > %ROOT%\05_DomainDominance\DCShadow.md
echo # NTDS Extraction > %ROOT%\05_DomainDominance\NTDS.md
echo # LSASS & LSA Secrets > %ROOT%\05_DomainDominance\LSASS_LSA.md

REM Archivos Lateral Movement
echo # WinRM > %ROOT%\06_LateralMovement\WinRM.md
echo # WMIExec & PsExec > %ROOT%\06_LateralMovement\WMIExec_PsExec.md
echo # RDP > %ROOT%\06_LateralMovement\RDP.md
echo # SMB Relay > %ROOT%\06_LateralMovement\SMB_Relay.md
echo # Pivoting > %ROOT%\06_LateralMovement\Pivoting.md

REM Cheatsheets
echo # UserAccountControl Flags > %ROOT%\Cheatsheets\uac_flags.md
echo # LDAP Filters > %ROOT%\Cheatsheets\ldap_filters.md
echo # Impacket Commands > %ROOT%\Cheatsheets\impacket.md
echo # CrackMapExec Commands > %ROOT%\Cheatsheets\cme.md
echo # Hashcat Modes > %ROOT%\Cheatsheets\hashcat.md
echo # Certipy Commands > %ROOT%\Cheatsheets\certipy.md

echo [+] Estructura creada con éxito en %ROOT%
pause
