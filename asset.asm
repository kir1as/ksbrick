;******************************************************
;  CASSE-BRIQUE ASSETS
;------------------------------------------------------
;  
;  v 1.1  William LIN & Timoté VANNIER 20 Jan 2023
;******************************************************

; public txt_start
public strt1
public strt2
;public txt_quit
public quit
public quit2
public img_menu_arrow
public img_menu_arrow_cover

public img_ball
public img_brick
public img_brick_cover

public img_bar
public img_bar_cover

donnees segment public    ; Segment de donnees

img_ball DW   8,64
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

img_menu_arrow DW   14,140
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

img_menu_arrow_cover DW   14,140
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

img_bar DW   25,150
br01 DB   0, 0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0, 0
br11 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br12 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br21 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br22 DB   0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0
br31 DB   0, 0, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 0, 0

img_bar_cover DW   5,30
blc012 DB   0, 0, 0, 0, 0
blc112 DB   0, 0, 0, 0, 0
blc122 DB   0, 0, 0, 0, 0
blc212 DB   0, 0, 0, 0, 0
blc222 DB   0, 0, 0, 0, 0
blc312 DB   0, 0, 0, 0, 0

img_brick DW   30, 300
brk01 DB   18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 21, 21, 21, 22, 22, 22, 22, 23, 23
brk11 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk12 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk21 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk22 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk31 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk32 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk41 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk42 DB   9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
brk51 DB   18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 26, 27, 27, 27, 28, 28

img_brick_cover DW   30, 300
ibc01 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc11 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc12 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc21 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc22 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc31 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc32 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc41 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc42 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ibc51 DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

donnees ends

code    segment public 
assume  cs:code,ds:donnees,es:code
myprog:


code    ends               ; Fin du segment de code
end myprog                 ; Fin du programme

