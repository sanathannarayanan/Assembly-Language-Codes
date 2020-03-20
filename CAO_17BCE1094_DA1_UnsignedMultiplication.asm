.text  # Subsequent instructions/items stored in 'Text Segment' at next available address

	li $v0, 6  # li = Load Immediate; $v0 = 6  (multiplicand)
	li $v1, 4  # multiplier
	li $s0, 0  # product

loop:
	beq $v1, 0 end  # (Branch If Equal) end the loop if multiplier = 0 (If v1=0)
	
	andi $t0, $v1, 1  # $t0 = ($v1 Bitwise And 1) ; To get the LSB of multiplier
	
	bne $t0, 0, addToProduct  # If $t0 = 1 ($t0 != 0) ; Branch to label addToProduct
	srl $v1, $v1, 1  # Shift Right Logical ($v1 = shift_right($v1) (by 1 bit)
	sll $v0, $v0, 1  # Shift Left Logical
	beq $t0, 0, loop  # If $t0 = 0, Branch to label loop
	
addToProduct:
	add $s0, $s0, $v0  # Addition with overflow ($s0 = $s0 + $v0)
	srl $v1, $v1, 1
	sll $v0, $v0, 1
	j loop  # Unconditional jump to label loop
	
end: