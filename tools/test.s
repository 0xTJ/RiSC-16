        movi    1,0
        movi    2,1
        movi    3,0
        jalr    0,0
loop:   movi    6,save
        jalr    7,6
        addi    3,3,2
        add     2,1,2
        add     1,2,1
        beq     0,0,loop

save:   sw      1,3,0
        sw      2,3,1
        jalr    0,7
