;******************************************************
;  CASSE-BRIQUE
;------------------------------------------------------
;  * --> Exit
;  w --> move up
;  s --> move down
;  a --> move left
;  d --> move right
;  m --> enter
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

	next_vertical_pixel_color DB 0
    next_horizontal_pixel_color DB 0

    pixel_x DW 0
    pixel_y DW 0

    array_bricks DW 50 dup(0)

    i DW 0
    j DW 0

    max_bricks DW 25

    brick_x DW 0
    brick_y DW 0

    arr_brick_index DW 0

    pixel_x_collision DW 0
    pixel_y_collision DW 0

    brick_deleted  DW 0

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
    cmp userinput, 'w'
    je move_up_arrow
    cmp userinput, 's'
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

    call generate_bricks_array
    call draw_game_bricks

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
    mov brick_deleted, 0
	ret
	
move_ball_with_collision:
	mov AX, ball_y 
    cmp AX, 10
    je go_to_ball_collision_vertical
	
	mov AX, ball_y
    add AX, 7 ; hauteur de la ball ; 2 mode de jeu , 7 ou 9
    cmp AX, bar_y; 
    je go_to_collision_with_bar
	end_if_collision_with_bar:
		mov AX, ball_y
	    add AX, 7; hauteur de la ball
	    cmp AX, 198
	    je game_lose
	    
	    mov AX, ball_x
	    cmp AX, 9
	    je go_to_ball_collision_horizontal
	    mov AX, ball_x
	    add AX, 7 ;largeur de la ball
	    cmp AX, 247
	    je go_to_ball_collision_horizontal
	end_if_collision_horizontal_with_terrain:
		call get_ball_next_pixel_color
        mov AL, next_vertical_pixel_color
        add AL, next_horizontal_pixel_color
		cmp AL, 0
		je end_collision_with_brick
        call ball_collision_with_brick
		 
	end_collision_with_brick:
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
    cmp ball_speed_x, 1
    jne left_direction
        cmp ball_speed_y, 1
        jne right_top_direction
        call get_down_right_next_pixel
        ret
        right_top_direction:
        call get_top_right_next_pixel
        ret
    left_direction:
    cmp ball_speed_y, 1
    jne left_top_direction
    call get_down_left_next_pixel
    ret
    left_top_direction:
    call get_top_left_next_pixel
    ret

get_top_left_next_pixel:
    mov BX, ball_x
    add BX, ball_speed_x
    mov pixel_x, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, ball_y
    int 10H
    mov next_horizontal_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_eight
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, ball_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_eight:

    mov BX, ball_y
    add BX, 8
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    cmp AL, 0
    je end_get_horizontal_top_left_next_pixel
    mov next_horizontal_pixel_color, AL
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_get_horizontal_top_left_next_pixel:
    
    ; get next vertical pixel
    mov BX, ball_x
    add BX, 8
    mov pixel_x, BX

    mov BX, ball_y
    add BX, ball_speed_y
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    mov next_vertical_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_seven
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_seven:

    ret

get_top_right_next_pixel:
    ; get next vertical pixel
    mov BX, ball_y
    add BX, ball_speed_y
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, ball_x
    mov DX, pixel_y
    int 10H
    mov next_vertical_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_six
    mov AX, ball_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_six:

    mov BX, ball_x
    add BX, 8
    mov pixel_x, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    cmp AL, 0
    je end_get_vertical_top_right_next_pixel
    mov next_vertical_pixel_color, AL
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_get_vertical_top_right_next_pixel:
    
    mov BX, ball_y
    add BX, 8
    mov pixel_y, BX

    mov BX, ball_x
    add BX, 8
    add BX, ball_speed_x
    mov pixel_x, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    mov next_horizontal_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_five
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_five:

    ret

get_down_left_next_pixel:
    mov BX, ball_x
    add BX, ball_speed_x
    mov pixel_x, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, ball_y
    int 10H
    mov next_horizontal_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_four
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, ball_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_four:

    mov BX, ball_y
    add BX, 7
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    cmp AL, 0
    je end_get_horizontal_down_left_next_pixel
    mov next_horizontal_pixel_color, AL
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_get_horizontal_down_left_next_pixel:
    
    mov BX, ball_x
    add BX, 8
    mov pixel_x, BX

    mov BX, ball_y
    add BX, 8
    add BX, ball_speed_y
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    mov next_vertical_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_three
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_three:

    ret

get_down_right_next_pixel:
    ; get next horizontal pixel
    mov BX, ball_x
    add BX, 8
    add BX, ball_speed_x
    mov pixel_x, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, ball_y
    int 10H
    mov next_horizontal_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_two
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, ball_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_two:

    mov BX, ball_y
    add BX, 8
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, pixel_x
    mov DX, pixel_y
    int 10H
    cmp AL, 0
    je end_get_horizontal_down_right_next_pixel
    mov next_horizontal_pixel_color, AL
    mov AX, pixel_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_get_horizontal_down_right_next_pixel:

    ; get next vertical pixel
    mov BX, ball_y
    add BX, 8
    add BX, ball_speed_y
    mov pixel_y, BX

    mov ah, 0Dh
    mov CX, ball_x
    mov DX, pixel_y
    int 10H
    mov next_vertical_pixel_color, AL
    cmp AL, 0
    je end_of_set_pixel_label_one
    mov AX, ball_x
    mov pixel_x_collision, AX
    mov AX, pixel_y
    mov pixel_y_collision, AX
    end_of_set_pixel_label_one:

    ret

ball_collision_with_brick:
    cmp next_vertical_pixel_color, 0
    jne collision_vertical
    cmp next_horizontal_pixel_color, 0
    jne collision_horizontal

    jmp end_direction_change
    collision_horizontal: 
    call ball_collision_horizontal ;changememt
    call delete_collision_brick ;delete brick toucher
    mov next_horizontal_pixel_color, 0
    jmp ball_collision_with_brick
    collision_vertical:
    call ball_collision_vertical
    call delete_collision_brick
    mov next_vertical_pixel_color, 0
    jmp ball_collision_with_brick

    end_direction_change:

    ret

delete_collision_brick:
    mov i, 0
    mov j, 0

    fori_delete_brick:
        mov CX, offset array_bricks
        mov j,0 
        forj_delete_brick:

        mov AX, i
        mov BX, 2
        mul BX
        add AX, j
        mov BX, 2
        mul BX
        mov arr_brick_index, AX
        add arr_brick_index, CX
        mov BX, arr_brick_index
        mov AX, [BX]
        mov brick_x, AX
    
        mov BX, pixel_x_collision
        cmp AX, BX
        ja end_of_forj_delete_brick

        mov brick_x, AX
        add AX, 30
        cmp AX, BX
        jb end_of_forj_delete_brick

        mov AX, i
        mov BX, 2
        mul BX
        add AX, 1
        mov BX, 2
        mul BX
        mov arr_brick_index, AX
        add arr_brick_index, CX
        mov BX, arr_brick_index
        mov AX, [BX]
        mov brick_y, AX
        mov BX, pixel_y_collision

        cmp AX, BX
        ja end_of_forj_delete_brick
        mov brick_y, AX
        add AX, 10
        cmp AX, BX
        jb end_of_forj_delete_brick

        mov AX, brick_x
        mov hX, AX
        mov AX, brick_y
        mov hY, AX
        mov BX, offset img_brick_cover
        call drawIcon

        inc brick_deleted
        mov AX, max_bricks
        cmp brick_deleted, AX
        jne end_of_forj_delete_brick

        call game_win

        end_of_forj_delete_brick:
        inc i
        mov AX, max_bricks
        cmp i, AX
        je end_of_delete_brick_loop
        jmp fori_delete_brick

    end_of_delete_brick_loop:

    ret 


generate_bricks_array:
    mov CX, offset array_bricks
    mov i, 0
    mov j, 0
    mov brick_x, 30
    mov brick_y, 30
    fori:
        mov j, 0 
        mov AX, max_bricks
        cmp i, AX
        je end_of_generate_bricks_array
        cmp brick_x, 215
        jna forj
        mov brick_x, 30
        add brick_y, 20
        forj:
            cmp j,1
            je insert_brick_y_to_array
    
            mov AX, i
            mov BX, 2
            mul BX
            add AX, j
            mov BX, 2
            mul BX
            mov arr_brick_index, AX
            add arr_brick_index, CX
            mov BX, arr_brick_index
            mov AX, brick_x
            mov word ptr [BX], AX
            add brick_x, 40
            inc j
            jmp forj
        insert_brick_y_to_array:
            mov AX, i
            mov BX, 2
            mul BX
            add AX, j
            mov BX, 2
            mul BX
            mov arr_brick_index, AX
            add arr_brick_index, CX
            mov BX, arr_brick_index
            mov AX, brick_y
            mov word ptr [BX], AX
            inc i
            jmp fori

    end_of_generate_bricks_array:

    ret

draw_game_bricks:
    mov i, 0
    mov j, 0

    fori_draw_bricks:
        mov CX, offset array_bricks
        mov j, 0 
        mov AX, max_bricks
        cmp i, AX
        je end_of_draw_bricks
        forj_draw_bricks:
            cmp j,1
            je get_brick_y_of_array
    
            mov AX, i
            mov BX, 2
            mul BX
            add AX, j
            mov BX, 2
            mul BX
            mov arr_brick_index, AX
            add arr_brick_index, CX
            mov BX, arr_brick_index
            mov AX, [BX]
            mov brick_x, AX
            inc j
            jmp forj_draw_bricks
        get_brick_y_of_array:
            mov AX, i
            mov BX, 2
            mul BX
            add AX, j
            mov BX, 2
            mul BX
            mov arr_brick_index, AX
            add arr_brick_index, CX
            mov BX, arr_brick_index
            mov AX, [BX]
            mov brick_y, AX
            inc i 

            mov AX, brick_x
            mov hX, AX
            mov AX, brick_y
            mov hY, AX
            mov BX, offset img_brick
            call drawIcon

            jmp fori_draw_bricks
    end_of_draw_bricks:
    ret

game_win:
    call ClearScreen
    mov tempo, 700
    mov hX, 150
    mov hY, 50
    mov BX, offset img_win
    call drawIcon
    call sleep
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
    mov brick_deleted, 0
    ret

;******************************************************
;  END_OF_FUNCTION
;******************************************************

code    ends               ; Fin du segment de code
end my_prog                 ; Fin du programme