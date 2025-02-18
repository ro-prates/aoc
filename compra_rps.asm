# 1) Implemente um programa em linguagem assembly que simule o valor total de uma compra
# no mercado. O programa deve ler as entradas do teclado dadas pelo usuário e fornecer no
# final o valor total do pedido.
# Primeiramente, o Mars deve exibir a mensagem: "Digite o nome do produto: ".
# Depois, ele deve ler como entrada um texto (nome do produto) terminado no
# caractere ascii correspondente à tecla enter.
# Em seguida, o programa deve exibir a mensagem: "Insira o valor unitário deste
# produto: " e ler como entrada um número do tipo float.
# Posteriormente, o programa deve exibir a mensagem: "Insira a quantidade desejada
# deste produto: " e ler como entrada um número do tipo inteiro.
# Após o usuário passar estas informações sobre o produto, o programa deve exibir a
# seguinte mensagem: “Deseja comprar algo a mais? Se sim, digite 1. Caso contrário,
# digite 0. Resposta: ”. Em seguida, ele deve ler como entrada a resposta do usuário. Se
# a resposta for “1”, o programa deve retornar às mensagens iniciais, pedindo nome,
# valor unitário e quantidade do produto.
# O usuário pode pedir até cinco produtos por compra. Após o quinto produto, o
# programa já deve encerrar a compra.
# Quando a resposta for “0” ou a compra for encerrada pelo programa, o Mars deve
# gerar como saída uma lista contendo a quantidade de cada produto pedido, com o
# respectivo valor unitário e valor total do produto, bem como o valor total do pedido
# de compra, conforme mostrado no exemplo abaixo. No exemplo, em azul está a
# informação digitada pelo usuário.
# Exemplo:
# Digite o nome do produto: caixa de uva
# Insira o valor unitário deste produto: 6.25
# Insira a quantidade desejada deste produto: 5
# Deseja comprar algo a mais? Se sim, digite 1. Caso contrário, digite 0. Resposta: 1
# Digite o nome do produto: leite
# Insira o valor unitário deste produto: 4.30
# Insira a quantidade desejada deste produto: 12
# Deseja comprar algo a mais? Se sim, digite 1. Caso contrário, digite 0. Resposta: 0
# 
# 2
# 
# Saída:
# Pedido:
# 5x caixa de uva
# Valor unitário: R$ 6.25
# Valor total do produto: R$ 31.25
# 12x leite
# Valor unitário: R$ 4.30
# Valor total do produto: 51.60
# Valor total do pedido: R$ 82.85

# PARA AJUDAR COM OS VALORES:

# COMPRA 1:
# Quantidade em inteiro: $t1
# Quantidade em float: $f0
# Nome do produto: p1
# Valor em float multiplicado: $f2

# COMPRA 2:
# Quantidade em inteiro: $t3
# Quantidade em float: $f0
# Nome do produto: p2
# Valor em float multiplicado: $f4
# Valor total da compra: $f5

# COMPRA 3:
# Quantidade em inteiro: $t4
# Quantidade em float: $f0
# Nome do produto: p3
# Valor em float multiplicado: $f7
# Valor total da compra: $f8

# COMPRA 4:
# Quantidade em inteiro: $t5
# Quantidade em float: $f0
# Nome do produto: p4
# Valor em float multiplicado: $f11
# Valor total da compra: $f13

# COMPRA 5:
# Quantidade em inteiro: $t6
# Quantidade em float: $f0
# Nome do produto: p5
# Valor em float multiplicado: $f15
# Valor total da compra: $f16

.data
	msg1: .asciiz "Digite o nome do produto:\n"
	valor: .asciiz "Insira o valor unitário deste produto:\n"
	quantidade: .asciiz "Insira a quantidade desejada deste produto:\n"
	novamente: .asciiz "Deseja comprar algo a mais? Se sim, digite 1. Caso contrário,digite 0. Resposta:\n"
	zeroFloat: .float 0.0
	p1: .space 30
	p2: .space 30
	p3: .space 30
	p4: .space 30
	p5: .space 30
	parabens: .asciiz "\nVoce digitou 1"
	pedido: .asciiz "\nPedido:\n\n"
	letrax: .asciiz "x "
	valor_unitario: .asciiz "Valor unitário: "
	valor_total: .asciiz "\nValor total do produto: "
	cifrao: .asciiz "R$ "
	duaslinhas: .asciiz "\n\n"
	valor_total_pedido: .asciiz "\n\nValor total do pedido: "
.text
	# Passando o valor 0.0 para $f10
	lwc1 $f10, zeroFloat 
	
	# Instrução para impressão da mensagem de digitar o nome do produto
	li $v0, 4 
	la $a0, msg1 
	syscall
	
	# Armazena o que o usuário digitou em p1
	li $v0, 8
	la $a0, p1
	la $a1, 30
	syscall
	
	# Instrução para impressão da mensagem de valor
	li $v0, 4 
	la $a0, valor 
	syscall
	
	# Armazena o valor em float que foi digitado
	li $v0, 6 # O valor lido está em $f0
	syscall 
	
	# O primeiro valor está em $f1
	add.s $f1, $f0, $f10 
	
	# Instrução para impressão da mensagem de digitar a quantidade
	li $v0, 4 
	la $a0, quantidade 
	syscall
	
	# Leitura da quantidade
	li $v0, 5 
	syscall 
	
	# A primeira quantidade inteira está em $t1
	move $t1, $v0
	
	mtc1 $t1, $f0
	cvt.s.w $f0, $f0 # A quantidade em float está em $f0
	
	mul.s $f2, $f0, $f1 # O primeiro valor final está em $f2
	
	# Instrução para impressão da mensagem perguntando se deseja continuar com a compra
	li $v0, 4 
	la $a0, novamente 
	syscall
	
	# Leitura da resposta
	li $v0, 5 
	syscall
	
	# A resposta está em $t2
	move $t2, $v0
	
	# Verificando se o usuário deseja continuar com a compra ou não
	beq $t2, 1, continua
	
	# Caso a compra tenha sido encerrada com apenas 1 produto
	li $v0, 4 
	la $a0, pedido 
	syscall
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t1)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p1
	li $v0, 4 
	la $a0, p1 
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela
	add.s $f12, $f1, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela
	add.s $f12, $f2, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para finalizar o código
	li $v0, 10
	syscall
	
continua:
	# Instrução para impressão da mensagem de digitar o nome do produto
	li $v0, 4 
	la $a0, msg1 
	syscall
	
	# Armazena o que o usuário digitou em p2
	li $v0, 8
	la $a0, p2
	la $a1, 30
	syscall
	
	# Instrução para impressão da mensagem de valor
	li $v0, 4 
	la $a0, valor 
	syscall
	
	# Armazena o valor em float que foi digitado
	li $v0, 6 # O valor lido está em $f0
	syscall 
	
	add.s $f3, $f0, $f10 # O segundo valor está em $f3
	
	# Instrução para impressão da mensagem de digitar a quantidade
	li $v0, 4 
	la $a0, quantidade 
	syscall
	
	# Leitura da quantidade
	li $v0, 5 
	syscall 
	
	# A segunda quantidade inteira está em $t3
	move $t3, $v0
	
	mtc1 $t3, $f0
	cvt.s.w $f0, $f0 # A quantidade em float está em $f0
	
	mul.s $f4, $f0, $f3 # O segundo valor final está em $f4
	
	# Instrução para impressão da mensagem perguntando se deseja continuar com a compra
	li $v0, 4 
	la $a0, novamente 
	syscall
	
	# Leitura da resposta
	li $v0, 5 
	syscall
	
	# A resposta está em $t2
	move $t2, $v0
	
	# Verificando se o usuário deseja continuar com a compra ou não
	beq $t2, 1, continua1
	
	# Caso a compra tenha sido encerrada com 2 produtos
	
	# PRODUTO 1
	li $v0, 4 
	la $a0, pedido 
	syscall
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t1)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p1
	li $v0, 4 
	la $a0, p1 
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela
	add.s $f12, $f1, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela
	add.s $f12, $f2, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	# PRODUTO 2
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t3)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p2
	li $v0, 4 
	la $a0, p2
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f3, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f4, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Exibe o valor total do pedido
	li $v0, 4 
	la $a0, valor_total_pedido
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Cálculo do valor total do pedido
	add.s $f5, $f4, $f2
	
	# Passa o resultado para $f12, para ser exibido na tela
	add.s $f12, $f5, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para finalizar o código
	li $v0, 10
	syscall

continua1:
	# Instrução para impressão da mensagem de digitar o nome do produto
	li $v0, 4 
	la $a0, msg1 
	syscall
	
	# Armazena o que o usuário digitou em p3
	li $v0, 8
	la $a0, p3
	la $a1, 30
	syscall
	
	# Instrução para impressão da mensagem de valor
	li $v0, 4 
	la $a0, valor 
	syscall
	
	# Armazena o valor em float que foi digitado
	li $v0, 6 # O valor lido está em $f0
	syscall 
	
	add.s $f6, $f0, $f10 # O terceiro valor está em $f6
	
	# Instrução para impressão da mensagem de digitar a quantidade
	li $v0, 4 
	la $a0, quantidade 
	syscall
	
	# Leitura da quantidade
	li $v0, 5 
	syscall 
	
	# A terceira quantidade inteira está em $t4
	move $t4, $v0
	
	mtc1 $t4, $f0
	cvt.s.w $f0, $f0 # A quantidade em float está em $f0
	
	mul.s $f7, $f0, $f6 # O terceiro valor final está em $f7
	
	# Instrução para impressão da mensagem perguntando se deseja continuar com a compra
	li $v0, 4 
	la $a0, novamente 
	syscall
	
	# Leitura da resposta
	li $v0, 5 
	syscall
	
	# A resposta está em $t2
	move $t2, $v0
	
	# Verificando se o usuário deseja continuar com a compra ou não
	beq $t2, 1, continua2
	
	# PRODUTO 1
	
	# Caso a compra tenha sido encerrada com 3 produtos
	li $v0, 4 
	la $a0, pedido 
	syscall
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t1)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p1
	li $v0, 4 
	la $a0, p1 
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela  
	add.s $f12, $f1, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela  
	add.s $f12, $f2, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	# PRODUTO 2
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t3)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p2
	li $v0, 4 
	la $a0, p2
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	add.s $f12, $f3, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	add.s $f12, $f4, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Cálculo do valor total do pedido
	add.s $f5, $f4, $f2
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 3
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t4)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p3
	li $v0, 4 
	la $a0, p3
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela  
	add.s $f12, $f6, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela  
	add.s $f12, $f7, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Exibe o valor total do pedido
	li $v0, 4 
	la $a0, valor_total_pedido
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Cálculo do valor total do pedido
	add.s $f8, $f7, $f5
	
	# Passa o resultado para $f12, para ser exibido na tela
	add.s $f12, $f8, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para finalizar o código
	li $v0, 10
	syscall
	
continua2:
	# Instrução para impressão da mensagem de digitar o nome do produto
	li $v0, 4 
	la $a0, msg1 
	syscall
	
	# Armazena o que o usuário digitou em p4
	li $v0, 8
	la $a0, p4
	la $a1, 30
	syscall
	
	# Instrução para impressão da mensagem de valor
	li $v0, 4 
	la $a0, valor 
	syscall
	
	# Armazena o valor em float que foi digitado
	li $v0, 6 # O valor lido está em $f0
	syscall 
	
	# O quarto valor está em $f9
	add.s $f9, $f0, $f10 
	
	# Instrução para impressão da mensagem de digitar a quantidade
	li $v0, 4 
	la $a0, quantidade 
	syscall
	
	# Leitura da quantidade
	li $v0, 5 
	syscall 
	
	# A quarta quantidade inteira está em $t5
	move $t5, $v0
	
	mtc1 $t5, $f0
	cvt.s.w $f0, $f0 # A quantidade em float está em $f0
	
	mul.s $f11, $f0, $f9 # O quarto valor final está em $f11
	
	# Instrução para impressão da mensagem perguntando se deseja continuar com a compra
	li $v0, 4 
	la $a0, novamente 
	syscall
	
	# Leitura da resposta
	li $v0, 5 
	syscall
	
	# A resposta está em $t2
	move $t2, $v0
	
	# Verificando se o usuário deseja continuar com a compra ou não
	beq $t2, 1, continua3
	
	# PRODUTO 1
	
	# Caso a compra tenha sido encerrada com 3 produtos
	li $v0, 4 
	la $a0, pedido 
	syscall
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t1)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p1
	li $v0, 4 
	la $a0, p1 
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	add.s $f12, $f1, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	add.s $f12, $f2, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 2
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t3)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p2
	li $v0, 4 
	la $a0, p2
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f3, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f4, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Cálculo do valor total do pedido
	add.s $f5, $f4, $f2
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 3
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t4)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p3
	li $v0, 4 
	la $a0, p3
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f6, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f7, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Cálculo do valor total do pedido
	add.s $f8, $f7, $f5
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 4
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t5)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p4
	li $v0, 4 
	la $a0, p4
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f9, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f11, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Exibe o valor total do pedido
	li $v0, 4 
	la $a0, valor_total_pedido
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Cálculo do valor total do pedido
	add.s $f13, $f8, $f11
	
	# Passa o resultado para $f12, para ser exibido na tela
	add.s $f12, $f13, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para finalizar o código
	li $v0, 10
	syscall
	
	
continua3:
	# Instrução para impressão da mensagem de digitar o nome do produto
	li $v0, 4 
	la $a0, msg1 
	syscall
	
	# Armazena o que o usuário digitou em p5
	li $v0, 8
	la $a0, p5
	la $a1, 30
	syscall
	
	# Instrução para impressão da mensagem de valor
	li $v0, 4 
	la $a0, valor 
	syscall
	
	# Armazena o valor em float que foi digitado
	li $v0, 6 # O valor lido está em $f0
	syscall 
	
	add.s $f14, $f0, $f10 # O quinto valor está em $f14
	
	# Instrução para impressão da mensagem de digitar a quantidade
	li $v0, 4 
	la $a0, quantidade 
	syscall
	
	# Leitura da quantidade
	li $v0, 5 
	syscall 
	
	# A quinta quantidade inteira está em $t6
	move $t6, $v0
	
	mtc1 $t6, $f0
	cvt.s.w $f0, $f0 # A quantidade em float está em $f0
	
	mul.s $f15, $f0, $f14 # O quinto valor final está em $f2
	
	# COMEÇA A EXIBIR O RESUMO DA COMPRA

	# PRODUTO 1
	
	# Caso a compra tenha sido encerrada com 3 produtos
	li $v0, 4 
	la $a0, pedido 
	syscall
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t1)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p1
	li $v0, 4 
	la $a0, p1 
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f1, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f2, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 2
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t3)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p2
	li $v0, 4 
	la $a0, p2
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f3, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f4, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Cálculo do valor total do pedido
	add.s $f5, $f4, $f2
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 3
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t4)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p3
	li $v0, 4 
	la $a0, p3
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f6, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f7, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Cálculo do valor total do pedido
	add.s $f8, $f7, $f5	
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 4
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t5)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p4
	li $v0, 4 
	la $a0, p4
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f9, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f11, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	
	# Cálculo do valor total do pedido
	add.s $f13, $f8, $f11	
	
	# Instrução para pular duas linhas
	li $v0, 4 
	la $a0, duaslinhas
	syscall
	
	#PRODUTO 5
	
	# Instrução para impressão da quantidade em inteiro
	li $v0, 1 
	la $a0, ($t6)
	syscall
	
	# Instrução para impressão da letra x
	li $v0, 4 
	la $a0, letrax 
	syscall
	
	# Instrução para impressão do nome do produto p5
	li $v0, 4 
	la $a0, p5
	syscall
	
	# Instrução para impressão do valor unitario
	li $v0, 4 
	la $a0, valor_unitario
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f14, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para impressão do valor total
	li $v0, 4 
	la $a0, valor_total
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Passando o valor para $f12, para poder ser exibido na tela   
	add.s $f12, $f15, $f10
			
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Exibe o valor total do pedido
	li $v0, 4 
	la $a0, valor_total_pedido
	syscall
	
	# Instrução para impressão do cifrão
	li $v0, 4 
	la $a0, cifrao
	syscall
	
	# Cálculo do valor total do pedido
	add.s $f16, $f15, $f13
	
	# Passa o resultado para $f12, para ser exibido na tela
	add.s $f12, $f16, $f10
	
	# Exibe o valor em float
	li $v0, 2
	syscall 
	
	# Instrução para finalizar o código
	li $v0, 10
	syscall