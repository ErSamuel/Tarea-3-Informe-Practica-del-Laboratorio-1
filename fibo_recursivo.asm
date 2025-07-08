.globl main
.data
	print: .asciiz "Escriba un numero de la serie Fibonacci:\n"
	Error: .asciiz "No es parte de la secuencia Fibonacci\n"
.text
	main:
		#imprime pedir valor n
		li $v0,4
		la $a0, print
		syscall
		#pide valor n
		li $v0,5
		syscall
		move $t0,$v0 		# t0=n (t0 en un auxiliar)
		addi $a0,$v0,-2 	# a0=n-2 (a0 es el n del for)
		
		li $s0,0	#Primer valor de la serie
		li $s1,1 	#Segundo valor de la serie
		
		beqz $a0,exit1	#si n-2 = 0 imprime 1
		blez $t0,error #si el numero no pertenece a la secuencia Fibonacci salta error
		
		jal fibo #salta a la funcion recursiva
		
		resultado:
		move $a0,$a1
		li $v0,1
		syscall
		
		fin:
		li $v0,10 	#fin del programa
		syscall
		
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	fibo:
	addi $sp,$sp,-16 	#guardar valores en pila
	sw $ra,12 ($sp)		#guarda diccion de memoria
	sw $a0,8 ($sp)
	sw $s0,4 ($sp)
	sw $s1,0 ($sp)
	
	blez $a0,exit 	# caso base si n=0
	
	add $a1,$s0,$s1	#a1=s0+s1
	move $s0,$s1	#s0=s1
	move $s1,$a1	#s1=a1
	
	
	addi, $a0,$a0,-1	#n=n-1
	j fibo 		#recuesividas
	
	exit:
	lw $s1,0 ($sp)
	lw $s0,4 ($sp)
	lw $a0,8 ($sp)
	lw $ra,12 ($sp)	#carga direccion de memoria
	addi $sp,$sp,-16 #vaciar pila
	jr $ra
	
	exit1:
	li $a1,1	#salida a1=1
	j resultado
	
	error:
	li $v0,4
	la $a0,Error
	syscall
	j fin
