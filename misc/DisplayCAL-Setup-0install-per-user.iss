; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#include ReadReg(HKEY_LOCAL_MACHINE,'Software\Sherlock Software\InnoTools\Downloader','ScriptPath','')

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppID={{4714199A-0D66-4E69-97FF-7B54BFF80B88}
AppCopyright=%(AppCopyright)s
AppName=%(AppName)s
AppPublisher=%(AppPublisher)s
AppPublisherURL=%(AppPublisherURL)s
AppReadmeFile=%(URL)s
AppSupportURL=%(AppSupportURL)s
AppUpdatesURL=%(AppUpdatesURL)s
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
DefaultDirName={userpf}\%(AppName)s
DefaultGroupName=%(AppName)s
LicenseFile=..\LICENSE.txt
OutputDir=.
OutputBaseFilename=%(AppName)s-0install-Setup-per-user
SetupIconFile=..\%(AppName)s\theme\icons\%(AppName)s.ico
Compression=lzma/Max
SolidCompression=true
VersionInfoVersion=%(VersionInfoVersion)s
VersionInfoDescription=%(AppName)s Setup
VersionInfoTextVersion=0install
WizardImageFile=..\misc\media\install.bmp
WizardSmallImageFile=..\misc\media\icon-install.bmp
AppVersion=0install
UninstallDisplayName={cm:UninstallProgram,%(AppName)s}
UninstallDisplayIcon={app}\%(AppName)s-uninstall.ico
AlwaysShowComponentsList=false
ShowLanguageDialog=auto
MinVersion=0,6.1.2600
DisableDirPage=yes
UsePreviousGroup=False
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
SignTool=sign.cmd
SignedUninstaller=yes

[Languages]
Name: english; MessagesFile: ..\misc\InnoSetup\v5\Default.isl;
Name: french; MessagesFile: ..\misc\InnoSetup\v5\Languages\French.isl;
Name: german; MessagesFile: ..\misc\InnoSetup\v5\Languages\German.isl;
Name: italian; MessagesFile: ..\misc\InnoSetup\v5\Languages\Italian.isl;
Name: spanish; MessagesFile: ..\misc\InnoSetup\v5\Languages\Spanish.isl;

[Files]
Source: ..\%(AppName)s\theme\icons\%(AppName)s-uninstall.ico; DestDir: {app};

[Icons]
Name: {group}\{cm:SelectVersion}; Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "run --refresh --customize --no-wait %(HTTPURL)s0install/%(AppName)s.xml";
Name: {group}\{cm:ChangeIntegration}; Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "integrate %(HTTPURL)s0install/%(AppName)s.xml";
Name: {group}\{cm:UninstallProgram,%(AppName)s}; Filename: {uninstallexe}; IconFilename: {app}\%(AppName)s-uninstall.ico;
Name: {group}\LICENSE; Filename: %(URL)sLICENSE.txt;
Name: {group}\README; Filename: %(URL)s;
Name: {userstartup}\%(AppName)s Profile Loader; Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "run --batch --no-wait --offline --command=run-apply-profiles %(HTTPURL)s0install/%(AppName)s.xml";

[Run]
Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "integrate --refresh %(HTTPURL)s0install/%(AppName)s.xml"; Description: {cm:LaunchProgram,%(AppName)s}; Flags: runasoriginaluser
Filename: %(URL)s; Description: {code:Get_RunEntryShellExec_Message|README}; Flags: nowait postinstall shellexec skipifsilent;
Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "run %(HTTPURL)s0install/%(AppName)s.xml"; Description: {cm:LaunchProgram,%(AppName)s}; Flags: nowait postinstall skipifsilent
Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "run --batch --no-wait --command=run-apply-profiles %(HTTPURL)s0install/%(AppName)s.xml";
; Filename: {reg:HKCU\Software\Zero Install,InstallLocation|{reg:HKLM\Software\Zero Install,InstallLocation}}\0install-win.exe; Parameters: "integrate --add=auto-start --batch %(HTTPURL)s0install/%(AppName)s.xml"; Description: {cm:LaunchProgram,%(AppName)s}; Flags: runasoriginaluser

[Code]
function Get_RunEntryShellExec_Message(Value: string): string;
begin
	Result := FmtMessage(SetupMessage(msgRunEntryShellExec), [Value]);
end;

function Get_UninstallString(AppId: string): string;
var
	UninstallString: string;
begin
	if not RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + AppId + '_is1', 'UninstallString', UninstallString) and
		not RegQueryStringValue(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\' + AppId + '_is1', 'UninstallString', UninstallString) and
			not RegQueryStringValue(HKCU, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + AppId + '_is1', 'UninstallString', UninstallString) then
				RegQueryStringValue(HKCU, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\' + AppId + '_is1', 'UninstallString', UninstallString);
	Result := RemoveQuotes(UninstallString);
end;

function Get_ZeroInstall_InstallLocation: string;
begin
	if not RegQueryStringValue(HKLM, 'SOFTWARE\Zero Install', 'InstallLocation', Result) then
		RegQueryStringValue(HKCU, 'SOFTWARE\Zero Install', 'InstallLocation', Result);
end;

function Get_ZeroInstall_Exe: string;
begin
	Result := Get_ZeroInstall_InstallLocation() + '\0install-win.exe';
end;

function ZeroInstall_IsInstalled: boolean;
var
	ExePath: string;
begin
	ExePath := Get_ZeroInstall_Exe();
	Result := (ExePath <> '') and FileExists(ExePath);
end;

procedure InitializeWizard();
begin
	if not ZeroInstall_IsInstalled() then begin
		ITD_Init;
		ITD_AddFile('http://0install.de/files/zero-install-per-user.exe', ExpandConstant('{tmp}\zero-install-per-user.exe'));
		ITD_DownloadAfter(wpReady);
	end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
	ErrorCode: integer;
	ZeroInstall: string;
begin
	if CurStep=ssInstall then begin
		if not ZeroInstall_IsInstalled() then begin
			if not Exec(ExpandConstant('{tmp}\zero-install-per-user.exe'), 'maintenance deploy', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode) then
				SuppressibleMsgBox(SysErrorMessage(ErrorCode), mbCriticalError, MB_OK, MB_OK);
			if not ZeroInstall_IsInstalled() then
				Abort();
		end;
	end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
	ErrorCode: integer;
	ZeroInstall: string;
	UninstallString: string;
begin
	if CurUninstallStep=usUninstall then begin
		if ZeroInstall_IsInstalled() then begin
			ZeroInstall := Get_ZeroInstall_Exe();
			if not Exec(ZeroInstall, 'remove --batch %(HTTPURL)s0install/%(AppName)s.xml', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode) then
				SuppressibleMsgBox(SysErrorMessage(ErrorCode), mbError, MB_OK, MB_OK);
		end;
	end;
	if CurUninstallStep=usDone then begin
		if ZeroInstall_IsInstalled() then begin
			UninstallString := Get_UninstallString('Zero Install');
			if (UninstallString <> '') and (SuppressibleMsgBox(FmtMessage(CustomMessage('AskRemove'), ['Zero Install']), mbConfirmation, MB_YESNO, IDNO) = IDYES) then
				Exec(UninstallString, '', '', SW_SHOW, ewNoWait, ErrorCode);
		end;
	end;
end;
