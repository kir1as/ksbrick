;******************************************************
;  CASSE-BRIQUE
;------------------------------------------------------
;  * --> Exit
;  
;
;  v 1.1  William LIN & Timoté VANNIER 20 Jan 2023
;******************************************************
include LIBGFX.INC
include ASSET.INC

pile    segment stack     ; Segment de pile
pile    ends

donnees segment public    ; Segment de donnees
; vos variables

	ball_speed_x DW 1       ; Valeur d'avancement de la balle sur X
	ball_speed_y DW 1       ; Valeur d'avancement de la balle sur Y

	arrow_y DW 100          ; Position Y de la fleche du menu
	arrow_blink_turn DB 0 	; Boolean qui simule 2 phase
	arrow_index DB 0		; Valeur de l'index pour choisir un element du menu 

	ball_x  DW 100			; Position X de la balle
	ball_y DW 150			; Position Y de la balle

	bar_x DW 100			; Position X de la bar
	bar_y DW 180			; Position Y de la bar
	bar_step DW 5			; Valeur d'avancement de la bar sur X

	game_state DB 0         

	next_pixel_color DB 0

donnees ends

code    segment public    ; Segment de code
assume  cs:code,ds:donnees,es:code,ss:pile

;******************************************************
;  MAIN
;******************************************************
my_prog:			; debut de la zone instructions

	mov AX, donnees
    mov DS, AX	
    mov tempo, 50
    call Video13h
    call draw_menu

main_loop:
	call draw_arrow
	call peekKey
	call get_menu_input
	call sleep
	jmp main_loop

end_prog:
    call VideoCMD
    mov AH,4Ch  ; 4Ch = fonction exit DOS
    mov AL,00h  ; code de sortie 0 (OK)
    int 21h

;******************************************************
;  END_OF_MAIN
;******************************************************

;******************************************************
;  FUNCTION
;******************************************************

get_menu_input:
    cmp userinput, 'm'
    je menu_choice
    cmp userinput, 'H'
    je move_up_arrow
    cmp userinput, 'P'
    je move_down_arrow
    ret

get_userinput_ingame:
	call peekKey
    cmp userinput, '*'
    je end_prog
    cmp userinput, 'a' ; a = droite
    je go_to_move_bar_right
    cmp userinput, 'd' ; d = gauche
    je go_to_move_bar_left
    ; jmp move_ball
    ret

go_to_move_bar_left:
    call move_bar_left
    ret
go_to_move_bar_right:
    call move_bar_right
    ret

menu_choice:
 	mov arrow_blink_turn, 0
    call draw_arrow
    cmp arrow_index, 0
    je draw_game_field
    jmp end_prog

move_up_arrow:
    mov AX, arrow_y
    mov hX, 266
    mov hY, AX
    mov BX, offset img_menu_arrow_cover
    call drawIcon

    cmp arrow_index, 0
    jne move_up_arrow_not_equal_to_0
    mov arrow_index, 1
    mov arrow_y, 120
    jmp end_move_up_arrow
    move_up_arrow_not_equal_to_0:
	    mov arrow_index, 0
	    mov arrow_y, 100
	end_move_up_arrow:
    ret

move_down_arrow:
    mov AX, arrow_y
    mov hX, 266
    mov hY, AX
    mov BX, offset img_menu_arrow_cover
    call drawIcon

    cmp arrow_index, 0
    jne move_down_arrow_not_equal_to_0
    mov arrow_index, 1
    mov arrow_y, 120
    jmp end_move_down_arrow
    move_down_arrow_not_equal_to_0:
	    mov arrow_index, 0
	    mov arrow_y, 100
	end_move_down_arrow:
    ret

draw_game_field:
    mov tempo, 5
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

    mov hX, 50
    mov hY, 100
    mov BX, offset img_brick
    call drawIcon
    call game
    ret

draw_arrow: 
	mov AX, arrow_y
    mov hX, 266
    mov hY, AX

    cmp arrow_blink_turn, 1
    je blink

    mov BX, offset img_menu_arrow
    mov arrow_blink_turn, 1
    jmp end_draw_arrow

	blink:
	    mov BX, offset img_menu_arrow_cover
	    mov arrow_blink_turn, 0
	
	end_draw_arrow:
		call drawIcon
	ret

draw_menu:
	call ClearScreen

	mov hX, 280
    mov hY, 100
    mov BX, offset strt1
    call drawIcon

    mov hX, 294
    mov hY, 100
    mov BX, offset strt2
    call drawIcon

    mov hX, 280
    mov hY, 120
    mov BX, offset quit
    call drawIcon

    mov hX, 294
    mov hY, 120
    mov BX, offset quit2
    call drawIcon
    ret

game:
	mov game_state, 0
	draw_game_main_element:
		mov AX, ball_x
	    mov hX, AX
	    mov AX, ball_y
	    mov hY, AX
	    mov BX, offset img_ball
	    call drawIcon

	    mov AX, bar_x
	    mov hX, AX
	    mov AX, bar_y
	    mov hY, AX
	    mov BX, offset img_bar
	    call drawIcon
		call sleep
		call get_userinput_ingame
		call move_ball_with_collision
		cmp game_state, 1
		je end_game
		jmp draw_game_main_element
	end_game:
	ret
	
move_bar_right:
    mov AX, bar_x
    add AX, 25
    sub AX, bar_step
    mov hX, AX
    mov AX, bar_y
    mov hY, AX
    mov BX, offset img_bar_cover
    call drawIcon

    mov AX, bar_step
    sub bar_x, AX
    cmp bar_x, 7
    ja end_move_bar_right
    add bar_x, AX
    ; jmp move_ball
    end_move_bar_right:
    ret

move_bar_left:
    mov AX, bar_x
    mov hX, AX
    mov AX, bar_y
    mov hY, AX
    mov BX, offset img_bar_cover
    call drawIcon

    mov AX, bar_step
    add bar_x, AX 
    cmp bar_x, 225 ; 250 - 25 taille de la barre
    jb end_move_bar_left
    sub bar_x, AX
    ; jmp move_ball   
    end_move_bar_left:
    ret

game_lose:
	call draw_menu
	mov game_state, 1
	mov arrow_index, 0
	mov tempo, 50
	mov ball_x, 100
	mov ball_y, 150
	mov bar_x, 100
	mov bar_y, 180
	mov ball_speed_x, 1     
	mov ball_speed_y, 1
	ret
	
move_ball_with_collision:
	mov AX, ball_y 
    cmp AX, 8
    je go_to_ball_collision_vertical
	
	mov AX, ball_y
    add AX, 7 ; hauteur de la ball
    cmp AX, bar_y; 
    je go_to_collision_with_bar
	
	mov AX, ball_y
    add AX, 7; hauteur de la ball
    cmp AX, 200
    je game_lose
    
    mov AX, ball_x
    cmp AX, 8
    je go_to_ball_collision_horizontal
    mov AX, ball_x
    add AX, 7 ;largeur de la ball
    cmp AX, 249
    je go_to_ball_collision_horizontal
	end_if_collision_with_bar:
	end_if_collision_horizontal_with_terrain:


		mov AX, ball_x
	    add AX, ball_speed_x
	    mov ball_x, AX
	    mov AX, ball_y
	    add AX, ball_speed_y
	    mov ball_y, AX

	ret

go_to_collision_with_bar:
	call if_collision_with_bar
	jmp end_if_collision_with_bar

go_to_ball_collision_vertical:
	call ball_collision_vertical
	jmp end_if_collision_with_bar

go_to_ball_collision_horizontal:
	call ball_collision_horizontal
	jmp end_if_collision_horizontal_with_terrain

ball_collision_vertical:
    mov AX, ball_speed_y
    mov BX, -1
    imul BX
    mov ball_speed_y, AX
    ret

ball_collision_horizontal:
    mov AX, ball_speed_x
    mov BX, -1
    imul BX
    mov ball_speed_x, AX
    ret

if_collision_with_bar:
    mov AX, bar_x
    cmp ball_x, AX
    jb end_collision_with_bar
    add AX, 22 ; largeur de la bar
    cmp ball_x, AX
    ja end_collision_with_bar
    call ball_collision_vertical
    end_collision_with_bar:
    	ret

get_ball_next_pixel_color:
    mov ah, 0Dh
    mov CX, ball_x
    mov DX, ball_y
    int 10H
    mov next_pixel_color, AL
    ret

;******************************************************
;  END_OF_FUNCTION
;******************************************************

code    ends               ; Fin du segment de code
end my_prog                 ; Fin du programme