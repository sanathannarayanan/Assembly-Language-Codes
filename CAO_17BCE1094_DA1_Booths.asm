.text 0x400000
main:
    li $v0, 5
    syscall
    move $s0, $v0
    li $v0, 5
    syscall
    andi $s1, $v0, 0x0000ffff
    sll $s0, $s0, 16                    # into Upper-Halfword (for addition)
    li $s4,0                            # saving the last bit
    li $s5,16                           # counter
loop:
    andi $s3, $s1, 1                    # $s3 = LSB($s1)
    beq $s3, $s4, endloop               # 00 or 11 -> cont
    beq $s3, $zero, runend              # 01 -> runend
    sub $s1, $s1, $s0                   # beginning of a run
    j endloop
runend:
    add $s1, $s1, $s0
endloop:
    sra $s1, $s1, 1                     # arithmetic right shift
    addi $s5, $s5, -1
    move $s4, $s3
    bne $s5, $zero, loop 
    
    li $v0, 1
    move $a0, $s1
    syscall   
end:
    li $v0, 10
    syscall
    
