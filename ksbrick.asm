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

ball_speed_x DW 1
ball_speed_y DW 1
;ball_speed_tour DW 10
arrow_y DW 100
tour DB 0
cpt_arrow DB 0
ball_x  DW 100
ball_y DW 150
bar_x DW 100
bar_y DW 180
bar_step DW 5

; ============- BALL ICONS =====================
ball DW   8,64
bl11 DB   0, 0, 0, 0, 0, 0, 0, 0
bl12 DB   0, 0, 31, 31, 31, 31, 0, 0
bl21 DB   0, 31, 31, 31, 31, 31, 31, 0
bl22 DB   0, 31, 31, 31, 31, 31, 31, 0
bl31 DB   0, 31, 31, 31, 31, 31, 31, 0
bl32 DB   0, 31, 31, 31, 31, 31, 31, 0
bl41 DB   0, 0, 31, 31, 31, 31, 0, 0
bl42 DB   0, 0, 0, 0, 0, 0, 0, 0

strt1 DW   14,140
st01 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
st11 DB   0, 31, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
st12 DB   31, 0, 0, 0, 31, 0, 0, 31, 0, 0, 0, 0, 0, 0
st21 DB   31, 0, 0, 0, 0, 0, 31, 31, 31, 31, 0, 0, 0, 31
st22 DB   0, 31, 31, 31, 0, 0, 0, 31, 0, 0, 0, 0, 0, 0
st31 DB   0, 0, 0, 0, 31, 0, 0, 31, 0, 0, 0, 0, 0, 31
st32 DB   31, 0, 0, 0, 31, 0, 0, 31, 0, 31, 0, 0, 31, 0
st41 DB   0, 31, 31, 31, 0, 0, 0, 0, 31, 0, 0, 0, 0, 31
st42 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
st51 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

strt2 DW   14,140
st012 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
st112 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
st122 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31, 0, 0
st212 DB   31, 31, 0, 0, 31, 0, 31, 31, 0, 0, 31, 31, 31, 31
st222 DB   0, 0, 31, 0, 0, 31, 0, 0, 31, 0, 0, 31, 0, 0
st312 DB   31, 31, 31, 0, 0, 31, 0, 0, 0, 0, 0, 31, 0, 0
st322 DB   0, 0, 31, 0, 0, 31, 0, 0, 0, 0, 0, 31, 0, 31
st412 DB   31, 31, 31, 0, 31, 31, 31, 0, 0, 0, 0, 0, 31, 0
st422 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
st512 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

arrow DW   14,140
ar01 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar11 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar12 DB   0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar21 DB   0, 0, 0, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar22 DB   0, 0, 0, 31, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0
ar31 DB   0, 0, 0, 31, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0
ar32 DB   0, 0, 0, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar41 DB   0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar42 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ar51 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

black DW   14,140
blc01 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc11 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc12 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc21 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc22 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc31 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc32 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc41 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc42 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
blc51 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

quit DW   14,140
qt01 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt11 DB   0, 31, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt12 DB   31, 0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt21 DB   31, 0, 0, 0, 31, 0, 31, 0, 0, 31, 0, 0, 0, 0
qt22 DB   31, 0, 0, 0, 31, 0, 31, 0, 0, 31, 0, 0, 0, 0
qt31 DB   31, 0, 31, 0, 31, 0, 31, 0, 0, 31, 0, 0, 0, 0
qt32 DB   31, 0, 0, 31, 0, 0, 31, 0, 31, 31, 0, 0, 0, 0
qt41 DB   0, 31, 31, 0, 31, 0, 0, 31, 0, 31, 0, 0, 0, 0
qt42 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt51 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

quit2 DW   14,140
qt012 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt112 DB   31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt122 DB   0, 0, 0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0
qt212 DB   31, 0, 0, 0, 31, 31, 31, 31, 0, 0, 0, 0, 0, 0
qt222 DB   31, 0, 0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0
qt312 DB   31, 0, 0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0
qt322 DB   31, 0, 0, 0, 0, 31, 0, 31, 0, 0, 0, 0, 0, 0
qt412 DB   31, 31, 0, 0, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0
qt422 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
qt512 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

bar DW   25,150
br01 DB   0, 0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0, 0
br11 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br12 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br21 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br22 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br31 DB   0, 0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0, 0

black2 DW   5,30
blc012 DB   0, 0, 0, 0, 0
blc112 DB   0, 0, 0, 0, 0
blc122 DB   0, 0, 0, 0, 0
blc212 DB   0, 0, 0, 0, 0
blc222 DB   0, 0, 0, 0, 0
blc312 DB   0, 0, 0, 0, 0

donnees ends

code    segment public    ; Segment de code
assume  cs:code,ds:donnees,es:code,ss:pile

myprog:			; debut de la zone instructions
; --------------- CODER ICI --------------
    mov AX, donnees
    mov DS, AX	
    mov tempo, 50
    CALL Video13h

menu:
    mov hX, 280
    mov hY, 100
    mov BX, offset strt1
    CALL drawIcon

    mov hX, 294
    mov hY, 100
    mov BX, offset strt2
    CALL drawIcon

    mov hX, 280
    mov hY, 120
    mov BX, offset quit
    CALL drawIcon

    mov hX, 294
    mov hY, 120
    mov BX, offset quit2
    CALL drawIcon

move_arrow:
    mov AX, arrow_y
    mov hX, 266
    mov hY, AX

    cmp tour, 1
    je blink

    mov BX, offset arrow
    mov tour, 1
    jmp draw_arrow
blink:
    mov BX, offset black
    mov tour, 0

draw_arrow:
    CALL drawIcon
    call sleep
    call peekKey
    cmp userinput, 'm'
    je menu_choice
    cmp userinput, 'H'
    je move_up_arrow
    cmp userinput, 'P'
    je move_down_arrow
    jmp move_arrow

move_up_arrow:
    mov AX, arrow_y
    mov hX, 266
    mov hY, AX
    mov BX, offset black
    call drawIcon

    cmp cpt_arrow, 0
    jne move_up_arrow_not_equal_to_0
    mov cpt_arrow, 1
    mov arrow_y, 120
    jmp move_arrow

move_up_arrow_not_equal_to_0:
    mov cpt_arrow, 0
    mov arrow_y, 100
    jmp move_arrow

move_down_arrow:
    mov AX, arrow_y
    mov hX, 266
    mov hY, AX
    mov BX, offset black
    call drawIcon

    cmp cpt_arrow, 0
    jne move_down_arrow_not_equal_to_0
    mov cpt_arrow, 1
    mov arrow_y, 120
    jmp move_arrow

move_down_arrow_not_equal_to_0:
    mov cpt_arrow, 0
    mov arrow_y, 100
    jmp move_arrow

menu_choice:
    cmp cpt_arrow, 0
    je terrain
    jmp fin

terrain:
    mov tempo, 10
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
    mov AX, ball_x
    mov hX, AX
    mov AX, ball_y
    mov hY, AX
    mov BX, offset ball
    CALL drawIcon

    mov AX, bar_x
    mov hX, AX
    mov AX, bar_y
    mov hY, AX
    mov BX, offset bar
    CALL drawIcon

    call sleep
    jmp dessine

move_bar_right:
    mov AX, bar_x
    add AX, 25
    sub AX, bar_step
    mov hX, AX
    mov AX, bar_y
    mov hY, AX
    mov BX, offset black2
    CALL drawIcon

    mov AX, bar_step
    sub bar_x, AX
    cmp bar_x, 7
    ja move_ball
    add bar_x, AX
    jmp move_ball

move_bar_left:
    mov AX, bar_x
    mov hX, AX
    mov AX, bar_y
    mov hY, AX
    mov BX, offset black2
    CALL drawIcon

    mov AX, bar_step
    add bar_x, AX 
    cmp bar_x, 225 ; 250 - 25 taille de la barre
    jb move_ball
    sub bar_x, AX
    jmp move_ball

go_to_move_bar_right:
    jmp move_bar_right
go_to_move_bar_left:
    jmp move_bar_left
move_ball:
; doit faire les comparaison des collisions ici
;comparer avec le terrain haut
    mov AX, ball_y 
    cmp AX, 8
    je ball_collision_vertical

    mov AX, ball_y
    add AX, 7 ; hauteur de la ball
    cmp AX, bar_y; 
    je if_collision_with_bar
end_if_collision_with_bar:
    mov AX, ball_y
    add AX, 7; hauteur de la ball
    cmp AX, 200
    je fin
    
    mov AX, ball_x
    cmp AX, 8
    je ball_collision_horizontal
    mov AX, ball_x
    add AX, 7 ;largeur de la ball
    cmp AX, 249
    je ball_collision_horizontal
end_if_collision_horizontal_with_terrain:
    
    mov AX, ball_x
    add AX, ball_speed_x
    mov ball_x, AX
    mov AX, ball_y
    add AX, ball_speed_y
    mov ball_y, AX
    jmp boucle

dessine:
    call peekKey
    cmp userinput, '*'
    je fin
    cmp userinput, 'a' ; a = droite
    je go_to_move_bar_right
    cmp userinput, 'd' ; d = gauche
    je go_to_move_bar_left
    jmp move_ball

ball_collision_horizontal:
    mov AX, ball_speed_x
    mov BX, -1
    imul BX
    mov ball_speed_x, AX
    jmp end_if_collision_horizontal_with_terrain

ball_collision_vertical:
    mov AX, ball_speed_y
    mov BX, -1
    imul BX
    mov ball_speed_y, AX
    jmp end_if_collision_with_bar

if_collision_with_bar:
    mov AX, bar_x
    cmp ball_x, AX
    jb end_if_collision_with_bar
    add AX, 22 ; largeur de la bar
    cmp ball_x, AX
    ja end_if_collision_with_bar
    jmp ball_collision_vertical

; --------------- FIN DU CODE ------------
fin:
    call VideoCMD
    mov AH,4Ch  ; 4Ch = fonction exit DOS
    mov AL,00h  ; code de sortie 0 (OK)
    int 21h

code    ends               ; Fin du segment de code
end myprog                 ; Fin du programme

