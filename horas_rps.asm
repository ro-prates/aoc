#Implemente um programa em linguagem assembly que simule a atualização das horas
#de um relógio. O programa deve ler as entradas do teclado e mostrar o resultado em
#modo texto (veja os tutoriais de como utilizar esses recursos no Classroom).
#Primeiramente, o Mars deve exibir a mensagem: "Entre com as horas:".
#Depois, ele deve ler um valor de 0 a 23 do teclado. Se o valor não for válido,
#exiba a seguinte mensagem: "Valor inválido para as horas. Esperado número
#entre 0 e 23." e peça para o usuário entrar novamente. Essa mensagem deve ser
#repetida até que o valor seja válido.
#Depois, siga o mesmo procedimento com os minutos e com os segundos.
#Por fim, imprima a mensagem final: "Horário digitado: HH:MM:SS", onde
#HH, MM e SS são os valores de horas, minutos e segundos digitados,
#respectivamente.
#O programa pode então ser fechado.

.data 
	# Mensagens que serão utilizadas durante a execução do programa
	
	msg1: .asciiz "Entre com as horas: " #mensagem que será exibida para o usuário
	msg2: .asciiz "Valor inválido para as horas. Esperado número entre 0 e 23. Digite novamente: "
	msg3: .asciiz "A hora digitada foi: "
	msg4: .asciiz "certo"
	msg5: .asciiz "errado"
	msg6: .asciiz "o numero eh maior que 23"
	msg7: .asciiz "Entre com os minutos: "
	msg8: .asciiz "Entre com os segundos: "
	msg9: .asciiz "Valor inválido para os minutos. Esperado número entre 0 e 59. Digite novamente: "
	msg10: .asciiz "Valor inválido para os segundos. Esperado número entre 0 e 59. Digite novamente: "
	msg11: .asciiz "Horário digitado: "
	msg12: .asciiz ":"
	
.text
	# Instrução para impressão da mensagem das horas
	li $v0, 4 
	la $a0, msg1 
	syscall
	
	# Leitura do valor
	li $v0, 5 
	syscall 
	
	# Valor digitado está em t0
	move $t0, $v0 
	
	while1:
		# Caso o valor digitado seja >= 0, pule direto para o while2
		bge $t0, $zero, while2
		
		# Instrução para impressão da mensagem de erro
		li $v0, 4 
		la $a0, msg2 
		syscall
		
		# Leitura do valor
		li $v0, 5 
		syscall 
		
		# Valor digitado está em t0
		move $t0, $v0
		
		# Repita o laço while1
		j while1
		
	while2:
		# Caso valor seja <= 23, pule direto para o while3
		ble $t0, 23, while3
		
		# Instrução para impressão da mensagem de erro
		li $v0, 4 
		la $a0, msg2 
		syscall
		
		# Leitura do valor
		li $v0, 5 
		syscall 
		
		# Valor digitado está em t0
		move $t0, $v0
		
		# Volte para o laço while1
		j while1
		
	while3:
		# Instrução para impressão da mensagem dos minutos
		li $v0, 4 
		la $a0, msg7 
		syscall
		
		# Leitura do valor
		li $v0, 5 
		syscall 
		
		# Valor digitado está em t1
		move $t1, $v0
		
		# Caso o valor digitado seja >= 0, pule direto para o while5
		bge $t1, $zero, while5
		
		# Caso o valor digitado seja < 0, pule direto para o while4
		j while4
		
	while4:
		# Instrução para impressão da mensagem de erro
		li $v0, 4 
		la $a0, msg9
		syscall
		
		# Leitura do valor
		li $v0, 5 
		syscall 
		
		# Valor digitado está em t1
		move $t1, $v0
		
		# Caso o valor digitado seja >= 0, pule direto para o while5
		bge $t1, $zero, while5
		
		# Caso o valor digitado seja < 0, repita o while4
		j while4
	
	while5:
		# Caso o valor digitado seja <= 59, pule direto para o while6
		ble, $t1, 59, while6
		
		# Caso o valor digitado seja > 59, volte para o while4
		j while4

	while6:
		# Instrução para impressão da mensagem dos segundos
		li $v0, 4
		la $a0, msg8
		syscall
		
		# Leitura do valor
		li $v0, 5 
		syscall 
		
		# Valor digitado está em t2
		move $t2, $v0
		
		# Caso o valor digitado seja >= 0, pule direto para o while7
		bge $t2, $zero, while7
		
		# Caso o valor digitado seja < 0, pule direto para o while8
		j while8
	
	while7:
		# Caso o valor digitado seja <= 59, pule direto para o resultadofinal
		ble $t2, 59, resultadofinal
		
		# Caso o valor digitado seja > 59, pule direto para o while8
		j while8
		
	while8: 
		# Instrução para impressão da mensagem de erro
		li $v0, 4 
		la $a0, msg10 
		syscall
		
		# Leitura do valor
		li $v0, 5 
		syscall 
		
		# Valor digitado está em t2
		move $t2, $v0
		
		# Caso o valor digitado seja >= 0, pule direto para o while7
		bge, $t2, $zero, while7
		
		# Caso o valor digitado seja < 0, repita o while8
		j while8
	
	resultadofinal:
		# Instrução para impressão da mensagem final
		li $v0, 4
		la $a0, msg11
		syscall
		
		# Instrução para impressão do valor das horas
		li $v0, 1 
		la $a0, ($t0) 
		syscall
		
		# Instrução para impressão dos 2 pontos
		li $v0, 4
		la $a0, msg12
		syscall
		
		# Instrução para impressão do valor dos minutos
		li $v0, 1 
		la $a0, ($t1)
		syscall
		
		# Instrução para impressão dos 2 pontos
		li $v0, 4
		la $a0, msg12
		syscall
		
		# Instrução para impressão do valor dos segundos
		li $v0, 1 
		la $a0, ($t2)
		syscall
		
		# Instrução para finalizar o código
		li $v0, 10
		syscall