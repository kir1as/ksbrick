;******************************************************
;  CASSE-BRIQUE
;------------------------------------------------------
;  * --> Exit
;  
;
;  v 1.0  William LIN & Timoté VANNIER  20 Jan 2023
;******************************************************
include LIBGFX.INC

pile    segment stack     ; Segment de pile
pile    ends

donnees segment public    ; Segment de donnees
; vos variables

vitesse DB 0

; ============- BALL ICONS =====================
ball DW   14,140
bl01 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
bl11 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
bl12 DB   0, 0, 0, 0, 0, 31, 31, 31, 31, 0, 0, 0, 0, 0
bl21 DB   0, 0, 0, 0, 31, 31, 31, 31, 31, 31, 0, 0, 0, 0
bl22 DB   0, 0, 0, 0, 31, 31, 31, 31, 31, 31, 0, 0, 0, 0
bl31 DB   0, 0, 0, 0, 31, 31, 31, 31, 31, 31, 0, 0, 0, 0
bl32 DB   0, 0, 0, 0, 31, 31, 31, 31, 31, 31, 0, 0, 0, 0
bl41 DB   0, 0, 0, 0, 0, 31, 31, 31, 31, 0, 0, 0, 0, 0
bl42 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
bl51 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


donnees ends

code    segment public    ; Segment de code
assume  cs:code,ds:donnees,es:code,ss:pile

myprog:			; debut de la zone instructions
; --------------- CODER ICI --------------
    
    mov AX, donnees
    mov DS, AX	

    CALL Video13h

terrain:
    mov col, 31
    mov rX, 0
    mov Ry, 0
    mov Rw, 7
    mov Rh, 200
    call fillRect

    mov col, 31
    mov rX, 250
    mov Ry, 0
    mov Rw, 7
    mov Rh, 200
    call fillRect

    mov col, 31
    mov rX, 0
    mov Ry, 0
    mov Rw, 250
    mov Rh, 7
    call fillRect

boucle:
    mov hX, 100
    mov hY, 100
    mov BX, offset ball

dessine:
    CALL drawIcon
    call peekKey
    cmp userinput, '*'
    je fin
    jmp boucle


; --------------- FIN DU CODE ------------
fin:
    call VideoCMD
    mov AH,4Ch  ; 4Ch = fonction exit DOS
    mov AL,00h  ; code de sortie 0 (OK)
    int 21h

code    ends               ; Fin du segment de code
end myprog                 ; Fin du programme

