#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^left::
    send {home}
return

^right::
    send {end}
return

^up::
    send {pgup}
return

^down::
    send {pgdn}
return

; --- Smart Ctrl+A ---
$^a::
if (A_PriorHotkey == "$^a" and A_TimeSincePriorHotkey < 300) {  ; Check if it's a double press within 300ms
    ; If it's a double press, send Ctrl+A
    Send ^a
} else {
    ; If it's a single press (or a double press outside the time window), send Home
    Send {Home} 
}
Return

; --- Basic Cursor Movement ---
^e::Send, {End}        ; Ctrl+E - End of line

; --- Word Movement ---
!b::Send, ^{Left}       ; Alt+B - Back one word
!f::Send, ^{Right}      ; Alt+F - Forward one word


; --- Kill Line ---
^k::
Send, +{End}
Send, {Del}
return

; --- Kill Line Backward ---
^u::
Send, +{Home}
Send, {Del}
return

; --- Delete Char Under Cursor ---
^d::Send, {Del}
^h::Send, {BS}


; --- Undo ---
^_::Send, ^z           ; Ctrl+_ - Undo


; --- smart ctrl f ---
;^f::Send, {Right}   ; Ctrl+F - Forward char
$^f::
if (A_PriorHotkey == "$^f" and A_TimeSincePriorHotkey < 100) {  ; Check if it's a double press within 100ms
    ; If it's a double press, send Ctrl+f
    SendInput ^f
} else {
    ; If it's a single press (or a double press outside the time window), send Home
    Send {Right}
}
Return

; --- Move Cursor Backward ---
^b::Send, {Left}    ; Ctrl+B - Backward char


; --- Switch Workspace with CTRL+Num ---
^1::Send #^{Left}
^2::Send #^{Right}

; --- Reinsert last Argument ---
; Variable to track if Escape was pressed
escapeReleased := false

; When Escape is released, set the flag
$Esc Up::
    escapeReleased := true
    SetTimer, ResetEscapeFlag, -2000  ; Reset the flag after 2000 ms
return

; When period is pressed, check if Escape was released just before
$.::
    if (escapeReleased) {
        Send {AltDown}.
        Send {AltUp}
        escapeReleased := false
    } else {
        Send .
    }
return

ResetEscapeFlag:
    escapeReleased := false
return