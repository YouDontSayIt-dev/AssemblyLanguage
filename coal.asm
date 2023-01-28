 .model small

.stack 100h

.data

inputBuffer db  100 ;MAX NUMBER OF CHARACTERS ALLOWED (25).
            db  ?         ;NUMBER OF CHARACTERS ENTERED BY USER.
            db  100 dup(0) ;CHARACTERS ENTERED BY USER.

enterString db 'INPUT: $'
            db 0dh
            db 0ah
            db '$'

outputString db 'OUTPUT: $'
             db 0dh
             db 0ah
             db '$'

descString db 'THIS IS A PROGRAM THAT ACCEPTS A STRING AND OUTPUTS IT. $'
             db 0dh
             db 0ah
             db '$'

newLine db 0dh 
        db 0ah
        db '$'


.code

main:
            mov ax, @data ;WE NEED THIS TO STORE DATA IN DATA SEGMENT.
            mov ds, ax

; PRINT DESCRIPTION PROMPT
            mov ah, 9
            mov dx, offset descString
            int 21h

; NEWLINE
            mov ah, 9
            mov dx, offset newLine
            int 21h

; PRINT INPUT PROMPT
            mov ah, 9
            mov dx, offset enterString
            int 21h                      

;CAPTURE STRING FROM KEYBOARD.                                    
            mov ah, 0Ah ;SERVICE TO CAPTURE STRING FROM KEYBOARD.
            mov dx, offset inputBuffer
            int 21h                 

;CHANGE CHR(13) BY '$'.
            mov si, offset inputBuffer + 1 ;NUMBER OF CHARACTERS ENTERED.
            mov cl, [ si ] ;MOVE LENGTH TO CL.
            mov ch, 0      ;CLEAR CH TO USE CX. 
            inc cx ;TO REACH CHR(13).
            add si, cx ;NOW SI POINTS TO CHR(13).
            mov al, '$'
            mov [ si ], al ;REPLACE CHR(13) BY '$'. 

; NEWLINE
            mov ah, 9
            mov dx, offset newLine
            int 21h

; PRINT OUTPUT PROMPT
            mov ah, 9
            mov dx, offset outputString
            int 21h

;DISPLAY STRING.                   
            mov ah, 9 ;SERVICE TO DISPLAY STRING.
            mov dx, offset inputBuffer + 2 ;MUST END WITH '$'.
            int 21h

            mov ah, 4ch
            int 21h

            end main
