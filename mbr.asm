
#make_boot#

org 7c00h 
start:   
    mov cx,0x10
    lea si, text1
    mov ah,0x0e 
l:
    lodsb
    int 10h
    test al,al
    loopnz l 
    xor bx,bx
    lea di,pass
    lea si,key 
    mov bh,[si]
    mov cx,8
l0:
    mov bl,[di]
    inc di
    xor bl,bh
    mov ah, 00h    
    int 16h    
    cmp al, bl     
    jne ProcessOtherKey   
    loop l0
    
    mov cx,0x0c
    lea si, text2
    mov ah,0x0e 
l1:
    lodsb
    int 10h
    test al,al
    loopnz l1 
;    INT 19h 
;   jmp to_os_load

    
ProcessOtherKey:                     
    jmp $


                    
text1 db 'Enter password: ',0    
pass db 0xdf, 0xef, 0xdc, 0xdc, 0xd8, 0x9f, 0xdd, 0xcb     
key db 0xaf      
text2 db 'Password OK!: ',0    
db (510-($-start)) dup (0)
db 0x55, 0xAA
