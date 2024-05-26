; multi-segment executable file template.

data segment
    ; add your data here!     
    A DB ? 
    X DB ?
    Y DB ?   
    y1 db ?
    y2 db ?
    pkey db "press any key...$"  
    VIVOD_Y DB "Y=$"          
    VVOD_X DB 13,10,"VVEDITE X=$",13,10
    VVOD_A DB 13,10,"VVEDITE A=$",13,10      
    PERENOS DB 13,10,"$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    XOR AX, AX 
    MOV DX, OFFSET VVOD_A 
    MOV AH, 9
    INT 21H 
    SLED2:
        MOV Ah, 1 
        INT 21H
        CMP AL, "-" 
        JNZ SLED1 
        MOV BX, 1
        JMP SLED2
    SLED1:
        SUB AL, 30H
        TEST BX, BX
        JZ SLED3 
        NEG AL
    
    SLED3:
        MOV A, AL
        XOR AX, AX
        XOR BX, BX
        MOV DX, OFFSET VVOD_X 
        MOV AH, 9 
        INT 21H 
    SLED4:
        MOV AH, 1 
        INT 21H
        CMP AL, "-" 
        JNZ SLED5
        MOV BX, 1
        JMP SLED4 
    SLED5:
        SUB AL, 30H 
        TEST BX, BX
        JZ SLED6
        NEG AL 
    SLED6:
        MOV X, AL 
         mov ah,0 
         mov dl,3h 
        div dl  
        cmp ah,1h
        je @h
        jmp @v 
            @h:
        mov y1,3h
        jmp @h2
            @v: 
        mov al,X
        mov ah,A
        sub al,ah
        mov y1,al
            @h2:  
        mov al,X
        cmp X,0
        je @u 
        jmp @vi
            @u:
        mov y2,4h
        jmp @hj
            @vi:
        mov al,A  
        mov ah,0
        mov bh,X
        div bh
        mov y2, ah
           
            @hj:
        xor ax,ax
        mov al,y2
        cmp y2,0
        jge @vse  
        neg al
        mov y2,al
            @vse:     
        mov bl,y1
        add al,bl
        mov Y,al             
        MOV DX, OFFSET PERENOS 
        MOV AH, 9 
        INT 21H 
        MOV DX, OFFSET VIVOD_Y 
        MOV AH, 9 
        INT 21H
        CMP Y, 0 
        JGE SLED7
        NEG AL
        MOV BL, AL 
        MOV DL, "-"
        MOV AH, 2 
        INT 21H 
        MOV DL, BL 
        ADD DL, 30H 
        INT 21H 
        JMP SLED8 ;
           SLED7:
        MOV DL, Y
        ADD DL, 30H
        MOV AH, 2 
        INT 21H
            SLED8:
        MOV DX, OFFSET PERENOS 
        MOV AH, 9
        INT 21H
        
        MOV AH, 1 
        INT 21H
        MOV AX, 4C00H
        INT 21H 
        ENDS
        END START