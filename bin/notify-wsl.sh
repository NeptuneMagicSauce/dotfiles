#!/bin/sh

cmd.exe /c powershell.exe -Command \
' [reflection.assembly]::loadwithpartialname("System.Windows.Forms") ;'\
' [reflection.assembly]::loadwithpartialname("System.Drawing")       ;'\
' $notify = new-object system.windows.forms.notifyicon               ;'\
' $notify.icon = [System.Drawing.SystemIcons]::Information           ;'\
' $notify.visible = $true                                            ;'\
' $notify.showballoontip(10,"You'\''ve been pinged"," ",[system.windows.forms.tooltipicon]::None)' \
  > /dev/null 2>&1
