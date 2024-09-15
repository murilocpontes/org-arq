        .data
aux:        .word 0
num:        .space 28
MAX:        .word 7

        .text
        .globl main

main:    
        jal     array		# declare num array
        la      t2, MAX		# t2 = &max
        lw      t0, 0(t2)	# t0 = max
        li      a3, 0           # i = 0
for:    
        bge     a3, t0, end_for
        jal     bubble
        addi    a3, a3, 1       # i += 1
        j       for
        
end_for: 
        jal     print_array
        addi    a7, x0, 10
        ecall
        
        li      a1, 0           # a1 = 0 = i 
        
array:  
        la      a2, num         # a5 = num[0]
        addi    t0, x0, 7
        sw      t0, 0(a2)       # num[0] = 7
        
        addi    t0, x0, 5 
        sw      t0, 4(a2)       # num[1] = 5
        
        addi    t0, x0, 2
        sw      t0, 8(a2)       # num[2] = 2
        
        addi    t0, x0, 1
        sw      t0, 12(a2)      # num[3] = 1
        
        sw      t0, 16(a2)      # num[4] = 1
        
        addi    t0, x0, 3
        sw      t0, 20(a2)      # num[5] = 3
        
        addi    t0, x0, 4
        sw      t0, 24(a2)      # num[6] = 4
        
        jr      ra
        
bubble:  
        lw      a4, 0(t2)       # j = max
        addi    a4, a4, -1      # j = max - 1
        addi    t1, a3, 1       # a3 = i + 1
        
bubble_for: 
        blt     a4, t1, end_bubble   # for(j = max - 1; j >= i + 1; j--)
        la      t3, num         # t3 = &num
        addi    t6, x0, 4       # t6 = 4
        mul     a5, a4, t6      # a5 = j * 4
        add     t3, t3, a5      # t3 = &num[j]
        lw      t6, (t3)        # t6 = num[j]
        addi    t4, t3, -4      # t4 = &num[j - 1]
        lw      t5, (t4)        # t5 = num[j - 1]
        blt     t5, t6, skip    # if(num[j - 1] > num[j])
        sw      t6, (t4)        # num[j - 1] = num[j]
        sw      t5, (t3)        # num[j] = num[j - 1]
        addi    a4, a4, -1      # j--
        j       bubble_for      # retorna para o começo do loop
        
end_bubble: 
        jr      ra

skip:   
        addi    a4, a4, -1      # j--
        j       bubble_for      # retorna para o começo do loop

print_array: 
        la      a4, num         # a0 = &num
        addi    a1, x0, 0       # a1 = i = 0
        li      a2, 4
        la      t0, MAX
        lw      t0, 0(t0)
        
loop_print: 
        bge     a1, t0, end_print_array  # for (a1 = 0; a1 < 7)
        mul     a3, a1, a2      # a3 = j = i * 4
        add     a3, a4, a3      # a3 = &num[j]
        lw      a0, 0(a3)       # a0 = num[j]
        li      a7, 1
        ecall
        addi    a1, a1, 1
        j       loop_print
        
end_print_array: 
        jr      ra
