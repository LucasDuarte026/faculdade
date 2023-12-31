; Verme

PosicaoVerme:  	var #500
TamanhoVerme:	var #1
Dir:		var #1 

PosicaoCaaso:	var #1
PosicaoFederal:	var #1
PosicaoFederal_:	var #1
StatusCaaso:	var #1

FimDeJogoMensagem: 	string "   Voce pegou Esquistossomose!  "
ApagaFimDeJogo:		string "                              "
ReiniciaMensagem:	string "       RESTART:'SPACE' "
ApagaReinicia:		string "                       "


main:
	call Inicializa
	
	call DesenhaMapa
		
	
	loop:
		EmJogo_loop:
			call Desenha_Verme
			
			call Morta_Verme
			
			
			call Move_Verme
			call Substitui_Caaso
					
			call Delay
				
			jmp EmJogo_loop
			
		FimDeJogo_loop:
			call Reinicia_Jogo
			jmp FimDeJogo_loop
	
Inicializa:
		push r0
		push r1
		
		loadn r0, #3
		store TamanhoVerme, r0
		
		loadn 	r0, #PosicaoVerme
		loadn 	r1, #460
		storei 	r0, r1
		
		inc 	r0
		dec 	r1
		storei 	r0, r1
		
		inc 	r0
		dec 	r1
		storei 	r0, r1
		
		inc 	r0
		dec 	r1
		storei 	r0, r1
		
		inc 	r0
		loadn 	r1, #0
		storei 	r0, r1
				
		call PrimeiroImprimeVerme
		
		loadn r0, #0
		store Dir, r0
		
		pop r1
		pop r0
		
		rts
		
		
DesenhaCaaso:	

	push r4
	
	loadn 	r1, #253
	loadn 	r4, #2816 
	add r1,r1,r4
	outchar r1, r0
	store 	PosicaoCaaso, r0
	
	pop r4
	
	rts
	
DesenhaFederal:	

	push r4
	
	loadn 	r1, #253
	loadn 	r4, #2304 
	add r1,r1,r4
	outchar r1, r0
	store 	PosicaoFederal, r0
	
	pop r4
	
	rts	
			

PrimeiroImprimeVerme:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #PosicaoVerme		
	loadn r1, #'='			
	loadi r2, r0			
		
	loadn 	r3, #0			
	
	Imprime_Loop:
		outchar r1, r2
		inc 	r0
		loadi 	r2, r0
		cmp r2, r3
		
		jne Imprime_Loop
	
	loadn 	r0, #820	
	call DesenhaCaaso
	
	
	dec r0
	call DesenhaFederal
	
	
	pop	r3
	pop r2
	pop r1
	pop r0
	
	rts
	
ApagaVerme:
	push r0
	push r1
	push r2
	push r3
	
	loadn 	r0, #PosicaoVerme	
	inc 	r0
	loadn 	r1, #' '		
	loadi 	r2, r0		
		
	loadn 	r3, #0		
	
	Imprime_Loop:
		outchar r1, r2
		
		inc 	r0
		loadi 	r2, r0
		
		cmp r2, r3
		jne Imprime_Loop
	
	pop	r3
	pop r2
	pop r1
	pop r0
	
	rts

DesenhaMapa:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r0, #0
	loadn r1, #39
	
	loadn r2, #253  
	
	loadn r3, #40
	
	loadn r4, #3584 
	add r2, r2, r4 
	
	loadn r4, #1200
	
	Stage_Loop1:
		
		outchar r2, r0 
		outchar r2, r1	
		
		add r0, r0, r3
		add r1, r1, r3
		
		cmp r0, r4
		jle Stage_Loop1
		
	loadn r0, #1
	loadn r1, #1161
	
	Stage_Loop2:
		outchar r2, r0 
		outchar r2, r1	
		
		inc r0
		inc r1
		
		cmp r0, r3
		jle Stage_Loop2
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts

Move_Verme:
	push r0	
	push r1	
	push r2 
	push r3
	push r4
	
	
	loadn 	r0, #5000
	loadn 	r1, #0
	mod 	r0, r6, r0		
	cmp 	r0, r1
	jne Move_Fim

	
	Check_Caaso:
		load 	r0, PosicaoCaaso
		loadn 	r1, #PosicaoVerme
		loadi 	r2, r1
		
		cmp r0, r2
		jne Check_Federal
		
		
		load 	r0, TamanhoVerme
		inc 	r0
		store 	TamanhoVerme, r0
		
		loadn 	r0, #0
		dec 	r0
		store 	StatusCaaso, r0
		
		load 	r0, PosicaoFederal
		loadn 	r1, #' '
		outchar r1, r0
		
		jmp Espalhar_Move
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	Check_Federal:	
		
		load r0, PosicaoFederal	
		cmp r0, r2
		jne Espalhar_Move
		
		jmp FimDeJogo_Ativador
		
	Espalhar_Move:
		loadn 	r0, #PosicaoVerme
		loadn 	r1, #PosicaoVerme
		load 	r2, TamanhoVerme
		
		add 	r0, r0, r2		
		
		dec 	r2				
		add 	r1, r1, r2
		
		loadn 	r4, #0
		
		Espalhar_Loop:
			loadi 	r3, r1
			storei 	r0, r3
			
			dec r0
			dec r1
			
			cmp r2, r4
			dec r2
			
			jne Espalhar_Loop	
	
	Mudar_Dir:
		inchar 	r1
		
		loadn r2, #100	
		cmp r1, r2
		jeq Move_D
		
		loadn r2, #115	
		cmp r1, r2
		jeq Move_S
		
		loadn r2, #97	
		cmp r1, r2
		jeq Move_A
		
		loadn r2, #119	
		cmp r1, r2
		jeq Move_W		
		
		jmp Atualiza_Move
	
		Move_D:
			loadn 	r0, #0
			
			loadn 	r1, #2
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Esquerda
			
			store 	Dir, r0
			jmp 	Move_Direita
		Move_S:
			loadn 	r0, #1
			
			loadn 	r1, #3
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Cima
			
			store 	Dir, r0
			jmp 	Move_Baixo
		Move_A:
			loadn 	r0, #2
			
			loadn 	r1, #0
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Direita
			
			store 	Dir, r0
			jmp 	Move_Esquerda
		Move_W:
			loadn 	r0, #3
			
			loadn 	r1, #1
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Baixo
			
			store 	Dir, r0
			jmp 	Move_Cima
	
	Atualiza_Move:
		load 	r0, Dir
				
		loadn 	r2, #0
		cmp 	r0, r2
		jeq 	Move_Direita
		
		loadn 	r2, #1
		cmp 	r0, r2
		jeq 	Move_Baixo
		
		loadn 	r2, #2
		cmp 	r0, r2
		jeq 	Move_Esquerda
		
		loadn 	r2, #3
		cmp 	r0, r2
		jeq 	Move_Cima
		
		jmp Move_Fim
		
		Move_Direita:
			loadn 	r0, #PosicaoVerme	
			loadi 	r1, r0			
			inc 	r1				
			storei 	r0, r1
			
			jmp Move_Fim
				
		Move_Baixo:
			loadn 	r0, #PosicaoVerme	
			loadi 	r1, r0			
			loadn 	r2, #40
			add 	r1, r1, r2
			storei 	r0, r1
			
			jmp Move_Fim
		
		Move_Esquerda:
			loadn 	r0, #PosicaoVerme	
			loadi 	r1, r0			
			dec 	r1				
			storei 	r0, r1
			
			jmp Move_Fim
		Move_Cima:
			loadn 	r0, #PosicaoVerme	
			loadi 	r1, r0			
			loadn 	r2, #40
			sub 	r1, r1, r2
			storei 	r0, r1
			
			jmp Move_Fim
	
	Move_Fim:
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0

	rts

Substitui_Caaso:
	push r0
	push r1
	push r5

	loadn 	r0, #0
	dec 	r0
	load 	r1, StatusCaaso
	cmp 	r0, r1
	
	jne Substitui_Fim
	
	loadn r1, #0
	store StatusCaaso, r1
	load  r1, PosicaoCaaso
	
	load r0, Dir
	
	loadn r2, #0
	cmp r0, r2
	jeq Substitui_Direita
	
	loadn r2, #1
	cmp r0, r2
	jeq Substitui_Baixo
	
	loadn r2, #2
	cmp r0, r2
	jeq Substitui_Esquerda
	
	loadn r2, #3
	cmp r0, r2
	jeq Substitui_Cima
	
	Substitui_Direita:
		loadn r3, #355
		add r1, r1, r3
		jmp Substitui_Boundaries
	Substitui_Baixo:
		loadn r3, #445
		sub r1, r1, r3
		jmp Substitui_Boundaries
	Substitui_Esquerda:
		loadn r3, #395
		sub r1, r1, r3
		jmp Substitui_Boundaries
	Substitui_Cima:
		loadn r3, #485
		add r1, r1, r3
		jmp Substitui_Boundaries
	
	
	Substitui_Boundaries:
		loadn r2, #40
		cmp r1, r2
		jle Substitui_Lower
		
		loadn r2, #1160
		cmp r1, r2
		jgr Substitui_Cimaper
		
		loadn r0, #40
		loadn r3, #1
		mod r2, r1, r0
		cmp r2, r3
		jel Substitui_West
		
		loadn r0, #40
		loadn r3, #39
		mod r2, r1, r0
		cmp r2, r3
		jeg Substitui_East
		
		jmp Substitui_Atualiza
		
		Substitui_Cimaper:
			loadn r1, #215
			jmp Substitui_Atualiza
		Substitui_Lower:
			loadn r1, #1035
	
			jmp Substitui_Atualiza
		Substitui_East:
			loadn r1, #835
			jmp Substitui_Atualiza
		Substitui_West:
			loadn r1, #205
			jmp Substitui_Atualiza
			
		Substitui_Atualiza:
			push r4
				
			store PosicaoCaaso, r1
			loadn r0, #253
			loadn 	r4, #2816 	
			add r0,r0,r4
			outchar r0, r1
			
			loadn 	r4, #215
			cmp 	r1, r4
			jeq Posicao_Fed2
			
			loadn 	r4, #1035
			cmp 	r1, r4
			jeq Posicao_Fed3
			
			loadn 	r4, #835
			cmp 	r1, r4
			jeq Posicao_Fed4
			
			loadn 	r4, #205
			cmp 	r1, r4
			jeq Posicao_Fed1
			
			
			
			
	Posicao_Fed1:    
			inc r1
			loadn r5,#40
			add r1,r1,r5
			
			store PosicaoFederal, r1	
			loadn r0, #253
			loadn 	r4, #2304	
			add r0,r0,r4
			outchar r0, r1
			pop r4
			jmp Substitui_Fim	
			
	Posicao_Fed2: 
			dec r1
			loadn r5,#40
			add r1,r1,r5	
			
			store PosicaoFederal, r1	
			loadn r0, #253
			loadn 	r4, #2304		
			add r0,r0,r4
			outchar r0, r1
			pop r4	
			jmp Substitui_Fim
			
	Posicao_Fed3:  
			inc r1
			loadn r5,#40
			sub r1,r1,r5
	
			store PosicaoFederal, r1	
			loadn r0, #253
			loadn 	r4, #2304 		
			add r0,r0,r4
			outchar r0, r1
			pop r4	
			jmp Substitui_Fim
			
	Posicao_Fed4: 
			dec r1
			loadn r5,#40
			sub r1,r1,r5
	
			store PosicaoFederal, r1	
			loadn r0, #253
			loadn 	r4, #2304 		
			add r0,r0,r4
			outchar r0, r1
			pop r4	
			jmp Substitui_Fim								
	
	Substitui_Fim:
		pop r1
		pop r0
		pop r5
	
	rts

Morta_Verme:
	loadn r0, #PosicaoVerme
	loadi r1, r0
	
	
	loadn r2, #40
	loadn r3, #39
	mod r2, r1, r2		
	cmp r2, r3
	jeq FimDeJogo_Ativador
	
	
	loadn r2, #40
	loadn r3, #0
	mod r2, r1, r2		
	cmp r2, r3
	jeq FimDeJogo_Ativador
	
	
	loadn r2, #40
	cmp r1, r2
	jle FimDeJogo_Ativador
	
	loadn r2, #1160
	cmp r1, r2
	jgr FimDeJogo_Ativador
	
	
	Collision_Check:
		load 	r2, TamanhoVerme
		loadn 	r3, #1
		loadi 	r4, r0			
		
		Collision_Loop:
			inc 	r0
			loadi 	r1, r0
			cmp r1, r4
			jeq FimDeJogo_Ativador
			
			dec r2
			cmp r2, r3
			jne Collision_Loop
		
	
	jmp Morta_Verme_Fim
	
	FimDeJogo_Ativador:
	
		load 	r0, PosicaoCaaso
		loadn 	r1, #' '			
		outchar r1, r0
		
		load 	r0, PosicaoFederal			
		loadn 	r1, #' '
		outchar r1, r0
	
		loadn r0, #605
		loadn r1, #FimDeJogoMensagem
		loadn r2, #512	
		call Imprime
		
		loadn r0, #687
		loadn r1, #ReiniciaMensagem
		loadn r2, #2304		
		call Imprime
		
		jmp FimDeJogo_loop
	
	Morta_Verme_Fim:
	
	rts

Desenha_Verme:
	push r0
	push r1
	push r2
	push r3 
	push r4 
	
	; Sincronização
	loadn 	r0, #1000
	loadn 	r1, #0
	mod 	r0, r6, r0		
	cmp 	r0, r1
	jne Desenha_Fim
	; =============
	
	
	loadn 	r0, #PosicaoVerme	
	loadn 	r1, #'='		
	loadi 	r2, r0			
	outchar r1, r2			
	
	loadn 	r0, #PosicaoVerme	
	loadn 	r1, #' '		
	load 	r3, TamanhoVerme	
	add 	r0, r0, r3		
	loadi 	r2, r0			
	outchar r1, r2			
	
	Desenha_Fim:
		pop	r3
		pop r2
		pop r1
		pop r0
		pop r4 
	
	rts
;----------------------------------
Delay:
	push r0
	
	inc r6
	loadn r0, #10000000 
	cmp r6, r0
	jgr Reinicia_Tempo
	
	jmp Tempo_Fim
	
	Reinicia_Tempo:
		loadn r6, #0
	Tempo_Fim:		
		pop r0
	
	rts

Reinicia_Jogo:
	inchar 	r0	
	loadn 	r1, #' ' 
	
	cmp r0, r1
	jeq Reinicia_Ativador
	
	jmp Reinicia_Fim
	
	Reinicia_Ativador:
		loadn r0, #605
		loadn r1, #ApagaFimDeJogo
		loadn r2, #0
		call Imprime
		
		loadn r0, #687
		loadn r1, #ApagaReinicia
		loadn r2, #0
		call Imprime
	
		call ApagaVerme
		call Inicializa
		
		jmp EmJogo_loop
		
	Reinicia_Fim:
	
	rts

Imprime:
	push r0		
	push r1		
	push r2		
	push r3
	push r4

	
	loadn r3, #'\0'

	LoopImprime:	
		loadi r4, r1
		cmp r4, r3
		jeq SaiImprime
		add r4, r2, r4
		outchar r4, r0
		inc r0
		inc r1
		jmp LoopImprime
		
	SaiImprime:	
		pop r4	
		pop r3
		pop r2
		pop r1
		pop r0
		
	rts