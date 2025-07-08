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
		
		move $t1,$v0 		# t0=n (t0 en un auxiliar)
		blez $t1, error		#si t1<=0 salta a error
		addi $a0,$t1,-2 	# a0=n-2 (a0 es el n del for)
		
		li $t2,0	#Primer valor de la serie
		li $t3,1 	#Segundo valor de la serie
		
		bgt $t1,$t3, for	#si n>0 salta al for
		move $t3,$t2		#s1=0
		
		j exit
		
		for:
		blez $a0, exit 		#si n<=0 salta a exit
		
		add $t0,$t2,$t3 	#t0=t2+t3
		move $t2,$t3 		#t2=t3
		move $t3,$t0 		#t3=t0
		addi $a0,$a0,-1 	#n=n-1
		j for
		
		exit:
		move $a0,$t3
		la $v0,1
		syscall
		
		fin:
		li $v0,10 	#fin del programa
		syscall
######################################################################################################################
		error:
		li $v0,4	#imprime un mensaje de error al ingresar un numero menor a 1
		la $a0,Error
		syscall
		j fin
		
		
		
		
