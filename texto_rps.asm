#Implemente um programa em linguagem assembly que leia como entrada um
#texto terminado no caractere ascii correspondente à tecla enter. Depois, o
#programa deve gerar as seguintes saídas nesta ordem:
#Número total de caracteres:
#Número total de palavras:
#A primeira linha deve imprimir a quantidade total de caracteres, sem contar o
#último enter. Os espaços e outros caracteres especiais também são contados.
#A segunda linha deve imprimir a quantidade de palavras. Números e símbolos
#não contam como palavras. As palavras devem aparecer separadas por espaços
#e pela pontuação das frases.

#Exemplo:
#Oi, desculpe por não te ligar hoje às 8:00. Estava muito frio e não te
#encontrei em casa.
#Saída:
#Número total de caracteres: 89
#Número total de palavras: 17
#Cada uma das saídas deve ser implementada em uma chamada de
#procedimento separada.

.data
	caracteres: .asciiz "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZãáàêíóúéÃÁÀÊÍÓÚÉ 0123456789/*-+.,;[]{}!?^`':~@#$%&()-_"
	espaco: .asciiz " "
	texto: .space 100
	msgcaracter: .asciiz "\Número total de caracteres: "
	msgpalavra: .asciiz "\nNúmero total de palavras: "
	msgentrada: .asciiz "Digite a frase:\n"
	
.text
	# Exibe a mensagem para o usuário digitar uma frase
	la $a0 msgentrada
	li $v0 4
	syscall
	
	# Armazena o que o usuário digitou em "texto"
	li $v0, 8
	la $a0, texto
	la $a1, 100
	syscall 
	
main:	
	li $t0 0 # Contador de bytes de texto
	li $t1 1 # Guarda o caracter do texto
	li $t2 0 # Contador de caracteres
	li $t3 1 # Guarda o caracter do texto
	li $t4 0 # Contador de caracteres
	
texto_loop:
	beqz $t1 mostrar
	# Carrega o próximo caracter do texto
	lb $t1 texto($t0)
	jal loop_caracteres
	# Incrementa o contador, tipo i += 1
	addi $t0 $t0 1
	b texto_loop
	
loop_caracteres:
	beqz $t3 retorna_caracteres
	# Caso sejam iguais, realiza-se o incremento do contador
	beq $t1 $t3 iguais
	lb $t3 caracteres($t2)
	# Percorre o vetor de caracteres, tipo i += 1
	addi $t2 $t2 1
	b loop_caracteres
	
iguais:
	addi $t4 $t4 1
	b retorna_caracteres
	
retorna_caracteres:
	li $t2 0
	li $t3 1
	jr $ra
	
mostrar:
	# Exibe a mensagem sobre caracteres na tela
	la $a0 msgcaracter
	li $v0 4
	syscall
	
	# Exibe a quantidade de caracteres na tela
	move $a0 $t4
	li $v0 1
	syscall
	
	b main1

main1:	
	li $t0 0 # Contador de bytes de texto
	li $t1 1 # Guarda o caracter do texto
	li $t2 0 # Contador de caracteres
	li $t3 1 # Guarda o caracter do texto
	li $t4 0 # Contador de caracteres
	
texto_loop1:
	beqz $t1 mostrar1
	# Carrega o próximo caracter do texto
	lb $t1 texto($t0)
	jal loop_caracteres1
	# Percorre o vetor de texto, tipo i += 1
	addi $t0 $t0 1
	
	b texto_loop1
	
loop_caracteres1:
	beqz $t3 retorna_caracteres1
	beq $t1 $t3 iguais1
	# Carrega o próximo caracter do vetor de caracteres
	lb $t3 espaco($t2)
	addi $t2 $t2 1
	b loop_caracteres1
	
iguais1:
	addi $t4 $t4 1
	b retorna_caracteres1
	
retorna_caracteres1:
	li $t2 0
	li $t3 1
	jr $ra
	
mostrar1:
	# Exibe a mensagem sobre palavras na tela
	la $a0 msgpalavra
	li $v0 4
	syscall
	
	addi $t4 $t4 1
	
	# Exibe a quantidade de palavras na tela
	move $a0 $t4
	li $v0 1
	syscall
	
	b final

final:	
	# Fim do algoritmo
	li $v0 10
	syscall