; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "WIWBBASIS"
#define MyAppVersion "2.108"
#define MyAppPublisher "Hydroconsult"
#define MyAppURL "http://www.sobek.tools"
#define SetupLocation "c:\DotnetSVN\meteobase\WIWBBASIS\InnoSetup"
#define BinLocation "c:\DotnetSVN\meteobase\WIWBBASIS\bin"
;; #define x64BitVersion
#define VsVersion = "2015" 
;; #define VsVersion = "2017" 
;#define mapwingis = "MapWinGIS-only-v4.9.6.1-Win32.exe"

#ifdef x64BitVersion
  #define CPU "x64"
  #define vcredist "vcredist_x64-" + VsVersion + ".exe"
  #define MySourceDir BinLocation + "\x64\"
  #define SystemFlag "64bit"
#else
  #define CPU "Win32"
  #define vcredist "vcredist_x86-" + VsVersion + ".exe"
  #define MySourceDir BinLocation + "\x86\"
  #define SystemFlag "32bit"
#endif

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{7960d4d1-06c9-48af-85a0-c6fe8d1345ea}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppPublisher}\{#MyAppName}
DisableProgramGroupPage=yes
DefaultGroupName={#MyAppName}
;LicenseFile={#BinLocation}\Licenses\MapWinGISLicense.rtf
InfoBeforeFile={#SetupLocation}\ReleaseNotes.txt
OutputDir={#SetupLocation}
OutputBaseFilename=WIWBBASIS-v{#MyAppVersion}-{#CPU}
SetupIconFile={#SetupLocation}\HYDRO_ICO_DEF.ico
Compression=lzma
SolidCompression=yes
;WizardImageFile={#SetupLocation}\WizImage-MW.bmp               HIER LATER NOG LOGO LET OP: SAME SIZE AS ORIGINAL
;WizardSmallImageFile={#SetupLocation}\WizSmallImage-MW.bmp     HIER LATER NOG LOGO LET OP: SAME SIZE AS ORIGINAL
AppCopyright={#MyAppPublisher}
PrivilegesRequired=none
MinVersion=0,6.0
ChangesEnvironment=no
AlwaysShowDirOnReadyPage=True
EnableDirDoesntExistWarning=True
;; UninstallDisplayName=MapWinGIS uninstall
CompressionThreads=2
LZMANumBlockThreads=2
UninstallDisplayIcon={uninstallexe}
AppComments=This package will install {#MyAppName} {#MyAppVersion}
AppContact=Siebe Bosch (siebe@hydroconsult.nl)
VersionInfoCompany=Hydroconsult [www.hydroconsult.nl]
VersionInfoCopyright=Copyright 2019, Hydroconsult
VersionInfoDescription=WIWB Basisdata [www.meteobase.nl]
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
#ifdef x64BitVersion
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
VersionInfoTextVersion={#MyAppVersion} 64Bit
VersionInfoProductTextVersion={#MyAppVersion} 64Bit
#else
VersionInfoTextVersion={#MyAppVersion}
VersionInfoProductTextVersion={#MyAppVersion}
#endif

[Files]
;Source: "{#SetupLocation}\MapWinGIS\*.*"; DestDir: "{app}\MapWinGIS"; Flags: ignoreversion recursesubdirs createallsubdirs {#SystemFlag}
;Source: "{#SetupLocation}\*.manifest"; DestDir: "{app}"; Flags: ignoreversion {#SystemFlag}
;; VC++ files
;Source: "{#SetupLocation}\{#vcredist}"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion {#SystemFlag};
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "{#MySourceDir}\*.*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs {#SystemFlag}; Excludes: "*.pdb,*.xml,*.ocx"
Source: "{#SetupLocation}\{#vcredist}"; DestDir: "{app}"
;Source: "{#SetupLocation}\{#mapwingis}"; DestDir: "{app}"

[Messages]
BeveledLabel=WIWB Basisdata by Hydroconsult

[Icons]
;; In start menu:
Name: "{commonstartmenu}\{#MyAppPublisher}\{#MyAppName}"; Filename: "{app}\WIWBBASIS.exe"; WorkingDir: "{app}"; Comment: "Start WIWBBASIS"
;; On desktop:
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\WIWBBASIS.exe"; WorkingDir: "{app}"; Comment: "Start WIWBBASIS"

[Run]
; Install VC++ redistributables if needed:
#ifdef x64BitVersion
Filename: "{app}\{#vcredist}"; Parameters: "/quiet"; Flags: waituntilterminated; Check: VCRedistNeedsInstall_x64()
#else
;Filename: "{#SetupLocation}\{#vcredist}"; Parameters: "/quiet"; Flags: waituntilterminated; Check: VCRedistNeedsInstall_x86()
Filename: "{app}\{#vcredist}"; Parameters: "/quiet"; Flags: waituntilterminated; Check: VCRedistNeedsInstall_x86()
#endif
;also install MapWinGIS
;Filename: "{app}\{#mapwingis}"; Parameters: "/verysilent /norestart /DIR=..\MapWinGIS"; Flags: waituntilterminated
;And (optionally) Channel Builder itself:
Filename: "{app}\WIWBBASIS.exe"; Flags: shellexec runasoriginaluser postinstall nowait skipifsilent; Description: "Start WIWBBASIS?"

[UninstallRun]
;Filename: "{app}\unregMapWinGIS.cmd"; WorkingDir: "{app}"; Flags: runhidden

[Registry]
;; Add location of MapWinGIS to path, needed for netcdf.dll
;; Root: "HKLM"; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: "expandsz"; ValueName: "Path"; ValueData: "{olddata};{app}"; Check: NeedsAddPath(ExpandConstant('{app}'))

[InstallDelete]
;; Old ECW driver, conflicts with new driver:
;Type: files; Name: "{app}\libecwj2.dll"; Components: MapWinGIS_Core

[Code]
#IFDEF UNICODE
  #DEFINE AW "W"
#ELSE
  #DEFINE AW "A"
#ENDIF
type
  INSTALLSTATE = Longint;
const
  INSTALLSTATE_INVALIDARG = -2;  // An invalid parameter was passed to the function.
  INSTALLSTATE_UNKNOWN = -1;     // The product is neither advertised or installed.
  INSTALLSTATE_ADVERTISED = 1;   // The product is advertised but not installed.
  INSTALLSTATE_ABSENT = 2;       // The product is installed for a different user.
  INSTALLSTATE_DEFAULT = 5;      // The product is installed for the current user.

  VC_2008_REDIST_X86 = '{FF66E9F6-83E7-3A3E-AF14-8DE9A809A6A4}';
  VC_2008_REDIST_X64 = '{350AA351-21FA-3270-8B7A-835434E766AD}';
  VC_2008_REDIST_IA64 = '{2B547B43-DB50-3139-9EBE-37D419E0F5FA}';
  VC_2008_SP1_REDIST_X86 = '{9A25302D-30C0-39D9-BD6F-21E6EC160475}';
  VC_2008_SP1_REDIST_X64 = '{8220EEFE-38CD-377E-8595-13398D740ACE}';
  VC_2008_SP1_REDIST_IA64 = '{5827ECE1-AEB0-328E-B813-6FC68622C1F9}';
  VC_2008_SP1_ATL_SEC_UPD_REDIST_X86 = '{1F1C2DFC-2D24-3E06-BCB8-725134ADF989}';
  VC_2008_SP1_ATL_SEC_UPD_REDIST_X64 = '{4B6C7001-C7D6-3710-913E-5BC23FCE91E6}';
  VC_2008_SP1_ATL_SEC_UPD_REDIST_IA64 = '{977AD349-C2A8-39DD-9273-285C08987C7B}';
  VC_2008_SP1_MFC_SEC_UPD_REDIST_X86 = '{9BE518E6-ECC6-35A9-88E4-87755C07200F}';
  VC_2008_SP1_MFC_SEC_UPD_REDIST_X64 = '{5FCE6D76-F5DC-37AB-B2B8-22AB8CEDB1D4}';
  VC_2008_SP1_MFC_SEC_UPD_REDIST_IA64 = '{515643D1-4E9E-342F-A75A-D1F16448DC04}';

  VC_2010_REDIST_X86 = '{196BB40D-1578-3D01-B289-BEFC77A11A1E}';
  VC_2010_REDIST_X64 = '{DA5E371C-6333-3D8A-93A4-6FD5B20BCC6E}';
  VC_2010_REDIST_IA64 = '{C1A35166-4301-38E9-BA67-02823AD72A1B}';
  VC_2010_SP1_REDIST_X86 = '{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}';
  VC_2010_SP1_REDIST_X64 = '{1D8E6291-B0D5-35EC-8441-6616F567A0F7}';
  VC_2010_SP1_REDIST_IA64 = '{88C73C1C-2DE5-3B01-AFB8-B46EF4AB41CD}';

  // http://stackoverflow.com/questions/27582762/inno-setup-for-visual-c-redistributable-package-for-visual-studio-2013
  VC_2013_REDIST_X86 = '{13A4EE12-23EA-3371-91EE-EFB36DDFFF3E}'; //Microsoft.VS.VC_RuntimeMinimumVSU_x86,v12
  VC_2013_REDIST_X64 = '{A749D8E6-B613-3BE3-8F5F-045C84EBA29B}'; //Microsoft.VS.VC_RuntimeMinimumVSU_amd64,v12

  VC_2015_REDIST_X86 = '{8F271F6C-6E7B-3D0A-951B-6E7B694D78BD}'; //Microsoft.VS.VC_RuntimeMinimumVSU_x86,v14
  VC_2015_REDIST_X64 = '{221D6DB4-46E2-333C-B09B-5F49351D0980}'; //Microsoft.VS.VC_RuntimeMinimumVSU_amd64,v14

  // https://bell0bytes.eu/inno-setup-vc/
  // { Visual C++ 2017 Redistributable 14.16.27024 }
  VC_2017_REDIST_X86 = '{5EEFCEFB-E5F7-4C82-99A5-813F04AA4FBD}';
  VC_2017_REDIST_X64 = '{F1B0FB3A-E0EA-47A6-9383-3650655403B0}';

function MsiQueryProductState(szProduct: string): INSTALLSTATE; 
  external 'MsiQueryProductState{#AW}@msi.dll stdcall';

function VCVersionInstalled(const ProductID: string): Boolean;
begin
  Result := MsiQueryProductState(ProductID) = INSTALLSTATE_DEFAULT;
end;



function VCRedistNeedsInstall_x86(): Boolean;
begin
  // here the Result must be True when you need to install your VCRedist
  // or False when you don't need to, so now it's upon you how you build
  // this statement, the following won't install your VC redist only when
  // the Visual C++ 2008 Redist (x86) and Visual C++ 2008 SP1 Redist(x86)
  // are installed for the current user
  Result := not (VCVersionInstalled(VC_2017_REDIST_X86));
end;

function VCRedistNeedsInstall_x64(): Boolean;
begin
  // here the Result must be True when you need to install your VCRedist
  // or False when you don't need to, so now it's upon you how you build
  // this statement, the following won't install your VC redist only when
  // the Visual C++ 2008 Redist (x86) and Visual C++ 2008 SP1 Redist(x86)
  // are installed for the current user
  Result := not (VCVersionInstalled(VC_2017_REDIST_X64));
end;

function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  // look for the path with leading and trailing semicolon
  // Pos() returns 0 if not found
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
;;Name: "afrikaans"; MessagesFile: "compiler:Languages\Afrikaans.isl"
;;Name: "albanian"; MessagesFile: "compiler:Languages\Albanian.isl"
;;Name: "arabic"; MessagesFile: "compiler:Languages\Arabic.isl"
;;Name: "basque"; MessagesFile: "compiler:Languages\Basque.isl"
;;Name: "belarusian"; MessagesFile: "compiler:Languages\Belarusian.isl"
;;Name: "bosnian"; MessagesFile: "compiler:Languages\Bosnian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
;;Name: "bulgarian"; MessagesFile: "compiler:Languages\Bulgarian.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
;;Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
;;Name: "chinesetrad"; MessagesFile: "compiler:Languages\ChineseTraditional.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
;;Name: "estonian"; MessagesFile: "compiler:Languages\Estonian.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
;;Name: "galician"; MessagesFile: "compiler:Languages\Galician.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
;;Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
;;Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
;;Name: "indonesian"; MessagesFile: "compiler:Languages\Indonesian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
;;Name: "korean"; MessagesFile: "compiler:Languages\Korean.isl"
;;Name: "lithuanian"; MessagesFile: "compiler:Languages\Lithuanian.isl"
;;Name: "luxemburgish"; MessagesFile: "compiler:Languages\Luxemburgish.isl"
;;Name: "macedonian"; MessagesFile: "compiler:Languages\Macedonian.isl"
;;Name: "malaysian"; MessagesFile: "compiler:Languages\Malaysian.isl"
;;Name: "nepali"; MessagesFile: "compiler:Languages\Nepali.islu"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
;;Name: "romanian"; MessagesFile: "compiler:Languages\Romanian.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
;;Name: "serbiancyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
;;Name: "serbianlatin"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
;;Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
;;Name: "swedish"; MessagesFile: "compiler:Languages\Swedish.isl"
;;Name: "tatarish"; MessagesFile: "compiler:Languages\Tatar.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"
