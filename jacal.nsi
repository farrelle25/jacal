; Install JACAL on Windows for current user
; Basic script generated by the HM NIS Edit Script Wizard.
; Augmented by Jerry van Dijk, march 2007
; placed in the public domain

; *** version numbers ***
!define PRODUCT_VERSION "1c7-1"

; ----------------[ NO CHANGES BELOW ]----------------

; *** unless files are added or removed ***
; *** remember to edit both 'file' and 'delete' sections!

; *** registry settings ***
!define KEY_VERSION "version"
!define SCM_KEY "Software\Voluntocracy\scm"
!define JACAL_KEY "Software\Voluntocracy\jacal"

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "JACAL"
!define PRODUCT_COMPANY "Voluntocracy"
!define PRODUCT_PUBLISHER "Aubrey Jaffer"
!define PRODUCT_WEB_SITE "http://people.csail.mit.edu/jaffer/JACAL"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\jacal-${PRODUCT_VERSION}.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "equal.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; License page
!insertmacro MUI_PAGE_LICENSE "COPYING"

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "jacal"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "jacal-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\jacal"
InstallDirRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
; Check that scm is installed
  ClearErrors
  ReadRegStr $0 ${PRODUCT_UNINST_ROOT_KEY} "${SCM_KEY}" "${KEY_VERSION}"
  IfErrors 0 +3
  MessageBox MB_OK|MB_ICONSTOP "No SCM found. Please install SCM before installing JACAL."
  Abort
FunctionEnd

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File "ANNOUNCE"
  File "builtin.scm"
  File "ChangeLog"
  File "combin.scm"
  File "COPYING"
  File "debug.scm"
  File "demo"
  SetOutPath "$INSTDIR\DOC"
  File "DOC\algdenom"
  File "DOC\eqalign.sty"
  File "DOC\grammar"
  File "DOC\history"
  File "DOC\lambda"
  File "DOC\ratint.pdf"
  File "DOC\ratint.tex"
  SetOutPath "$INSTDIR"
  File "elim.scm"
  File "English.scm"
  File "ext.scm"
  File "equal.ico"
  File "factors.scm"
  File "fdl.texi"
  File "ff.scm"
  File "func.scm"
  File "grammar.scm"
  File "HELP"
  File "hensel.scm"
  File "hist.scm"
  File "info.scm"
  File "interpolate.scm"
  File "jacal.html"
  File "jacal.nsi"
  File "jacal.spec"
  File "jacal.texi"
  File "jacalcat"
  File "Makefile"
  File "math.scm"
  File "modeinit.scm"
  File "norm.scm"
  File "poly.scm"
  File "README"
  File "rw.math"
  File "sexp.scm"
  File "sqfree.scm"
  File "tensor.scm"
  File "test.math"
  File "toploads.scm"
  File "types.scm"
  File "unparse.scm"
  File "uv-hensel.scm"
  File "vect.scm"
  File "version.txi"
  File "view.scm"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Manual.lnk" "$INSTDIR\jacal.html"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\JACAL.lnk" "scm.exe" '-iql"$INSTDIR\math.scm" -ie"(math)"' "$INSTDIR\equal.ico"
  CreateShortCut "$DESKTOP\JACAL.lnk" "scm.exe" '-iql"$INSTDIR\math.scm" -ie"(math)"' "$INSTDIR\equal.ico"
  !insertmacro MUI_STARTMENU_WRITE_END

; Jaffer jacal registry settings
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${JACAL_KEY}" "${KEY_VERSION}" "${PRODUCT_VERSION}"

SectionEnd

Section -AdditionalIcons
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninst.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\view.scm"
  Delete "$INSTDIR\version.txi"
  Delete "$INSTDIR\vect.scm"
  Delete "$INSTDIR\uv-hensel.scm"
  Delete "$INSTDIR\unparse.scm"
  Delete "$INSTDIR\types.scm"
  Delete "$INSTDIR\toploads.scm"
  Delete "$INSTDIR\test.math"
  Delete "$INSTDIR\tensor.scm"
  Delete "$INSTDIR\sqfree.scm"
  Delete "$INSTDIR\sexp.scm"
  Delete "$INSTDIR\rw.math"
  Delete "$INSTDIR\README"
  Delete "$INSTDIR\poly.scm"
  Delete "$INSTDIR\norm.scm"
  Delete "$INSTDIR\modeinit.scm"
  Delete "$INSTDIR\math.scm"
  Delete "$INSTDIR\Makefile"
  Delete "$INSTDIR\jacalcat"
  Delete "$INSTDIR\jacal.texi"
  Delete "$INSTDIR\jacal.spec"
  Delete "$INSTDIR\jacal.nsi"
  Delete "$INSTDIR\jacal.html"
  Delete "$INSTDIR\interpolate.scm"
  Delete "$INSTDIR\info.scm"
  Delete "$INSTDIR\hist.scm"
  Delete "$INSTDIR\hensel.scm"
  Delete "$INSTDIR\HELP"
  Delete "$INSTDIR\grammar.scm"
  Delete "$INSTDIR\func.scm"
  Delete "$INSTDIR\ff.scm"
  Delete "$INSTDIR\fdl.texi"
  Delete "$INSTDIR\factors.scm"
  Delete "$INSTDIR\ext.scm"
  Delete "$INSTDIR\equal.ico"
  Delete "$INSTDIR\English.scm"
  Delete "$INSTDIR\elim.scm"
  Delete "$INSTDIR\DOC\ratint.tex"
  Delete "$INSTDIR\DOC\ratint.pdf"
  Delete "$INSTDIR\DOC\lambda"
  Delete "$INSTDIR\DOC\history"
  Delete "$INSTDIR\DOC\grammar"
  Delete "$INSTDIR\DOC\eqalign.sty"
  Delete "$INSTDIR\DOC\algdenom"
  Delete "$INSTDIR\demo"
  Delete "$INSTDIR\debug.scm"
  Delete "$INSTDIR\COPYING"
  Delete "$INSTDIR\combin.scm"
  Delete "$INSTDIR\ChangeLog"
  Delete "$INSTDIR\builtin.scm"
  Delete "$INSTDIR\ANNOUNCE"

  Delete "$DESKTOP\JACAL.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Website.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\JACAL.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Manual.lnk"

  RMDir "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR\DOC"
  RMDir "$INSTDIR"

  ; remove Jaffer registry entries
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${JACAL_KEY}"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true

SectionEnd