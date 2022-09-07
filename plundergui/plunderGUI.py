from tkinter import *
#from turtle import bgcolor
from PIL import ImageTk, Image


#----------JANELA CADASTRO----------#
def criaCadastro():
    global janelaCadastro
    janelaCadastro = Tk()
    janelaCadastro.title("Cadastro")
    janelaCadastro.geometry('320x350')
    janelaCadastro.resizable(width=False, height=False)
    janelaCadastro.config(bg=corBaseJanela)

    textoUsuario = Label(janelaCadastro,font=('', 15), bg=corBaseJanela, fg='white', text="Usuário:")
    textoUsuario.place(x=20, y=100)
    
    entradaUsuario = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaUsuario.place(x=110, y=105)

    textoEmail = Label(janelaCadastro,font=('', 15), bg=corBaseJanela, fg='white', text="E-mail:")
    textoEmail.place(x=25, y=150)

    entradaEmail = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaEmail.place(x=110, y=155)

    textoSenha = Label(janelaCadastro,font=('', 15),bg=corBaseJanela, fg='white', text="Senha:")
    textoSenha.place(x=25, y=200)

    entradaSenha = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaSenha.place(x=110, y=205)

    textoCadastroC = Label(janelaCadastro, font=('', 35), bd=0, bg=corBaseJanela, fg='white', text="CADASTRO")
    textoCadastroC.place(x=30, y=20)

    botaoCadastra = Button(janelaCadastro, width=20, height=4, text = "Cadastrar")
    botaoCadastra.config(bg = corBaseBotao)
    botaoCadastra.place(x=80, y = 245)



#----------JANELA LOGIN----------#
def criaLogin():
    global janelaLogin
    janelaLogin = Tk()
    janelaLogin.title("Login")
    janelaLogin.geometry('320x350')
    janelaLogin.resizable(width=False, height=False)
    janelaLogin.config(bg=corBaseJanela)

    textoUsuarioL = Label(janelaLogin,font=('', 15), bg=corBaseJanela, fg='white', text="Usuário:")
    textoUsuarioL.place(x=20, y=115)
    
    entradaUsuarioL = Entry(janelaLogin, width=30, justify='left', relief='solid')
    entradaUsuarioL.place(x=110, y=120)

    textoSenhaL = Label(janelaLogin,font=('', 15), bg=corBaseJanela, fg='white', text="Senha:")
    textoSenhaL.place(x=25, y=170)

    entradaSenhaL = Entry(janelaLogin, width=30, justify='left', relief='solid')
    entradaSenhaL.place(x=110, y=175)

    textoLoginL = Label(janelaLogin, font=('', 35), bd=0, bg=corBaseJanela, fg='white', text="LOGIN")
    textoLoginL.place(x=80, y=20)

    botaoLoga = Button(janelaLogin, width=20, height=4, text = "Login", command=criaHome)
    botaoLoga.config(bg = corBaseBotao)
    botaoLoga.place(x=80, y = 245)


#----------JANELA HOME----------#
def criaHome():
    global janelaHome

    #Se houver alguma outra janela aberta, fecha ela antes de abrir a Home
    try:
        if janelaCadastro.winfo_exists():
            janelaCadastro.destroy()

    except(NameError):
        pass

    try:
                
        if janelaLogin.winfo_exists():
            janelaLogin.destroy()

    except(NameError):
        pass

    

    inicial.destroy()
    janelaHome = Tk()
    janelaHome.title("Plunder")
    janelaHome.geometry('700x450')
    janelaHome.resizable(width=False, height=False)
    janelaHome.config(bg=corBaseJanela)

    textoNome = Label(janelaHome,font=('', 25), bg=corBaseJanela, fg='white', text="NOME")#Text TEMPORARIO, MUDAR COM A DATABASE
    textoNome.place(x=285, y=15)

    #Frame que segura as informações no centro da página
    infoFrame = LabelFrame(janelaHome, borderwidth=1, relief="solid", bg = corBaseJanela, fg='white')
    infoFrame.place(x=215, y=60, width = 250, height = 350)

    #Labels que vão mostrar as informações
    le1 = Label(infoFrame, text="Teste: VALORVALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le1.pack(anchor="w", pady= (90, 5))

    le2 = Label(infoFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le2.pack(anchor="w", pady= 5)

    le3 = Label(infoFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le3.pack(anchor="w", pady= 5)

    le4 = Label(infoFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le4.pack(anchor="w", pady= 5)

    #Botões do menu

    botaoLoja = Button(janelaHome, width=20, height=2, text = "Loja", relief='flat')
    botaoLoja.config(bg = corBaseBotao)
    botaoLoja.pack(anchor="w", pady=(70, 10), padx=(20, 0))

    botaoTripulacao = Button(janelaHome, width=20, height=2, text = "Tripulação", relief='flat')
    botaoTripulacao.config(bg = corBaseBotao)
    botaoTripulacao.pack(anchor="w", pady=10, padx=(20, 0))

    botaoNavio = Button(janelaHome, width=20, height=2, text = "Navio", relief='flat')
    botaoNavio.config(bg = corBaseBotao)
    botaoNavio.pack(anchor="w", pady=10, padx=(20, 0))

    botaoGuilda = Button(janelaHome, width=20, height=2, text = "Guilda", relief='flat')
    botaoGuilda.config(bg = corBaseBotao)
    botaoGuilda.pack(anchor="w", pady=10, padx=(20, 0))

    botaoMar = Button(janelaHome, width=14, height=5, text = "MAR", font=('', 15, 'bold'), relief='flat')
    botaoMar.config(bg = corBaseBotao)
    botaoMar.pack(anchor="w", pady=30, padx=(20, 0))

    #Frame de timer de atividades
    timerFrame = LabelFrame(janelaHome, borderwidth=1, relief="solid", bg = corBaseJanela, fg='white')
    timerFrame.place(x=490, y=25, width = 200, height = 400)

    leT1 = Label(timerFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 10))
    leT1.pack(anchor="w", pady= (90, 5), padx=(5, 0))
    leT2 = Label(timerFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 10))
    leT2.pack(anchor="w", pady= 5, padx=(5, 0))
    leT3 = Label(timerFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 10))
    leT3.pack(anchor="w", pady= 5, padx=(5, 0))
    leT4 = Label(timerFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 10))
    leT4.pack(anchor="w", pady= 5, padx=(5, 0))
    leT5 = Label(timerFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 10))
    leT5.pack(anchor="w", pady= 5, padx=(5, 0))
    leT6 = Label(timerFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 10))
    leT6.pack(anchor="w", pady= 5, padx=(5, 0))





#----------JANELA INICIAL----------#
corBaseJanela = '#434343' #Cinza escuro
corBaseBotao = '#B9a82b' #Cinza

inicial = Tk()

inicial.title('Plunder')
inicial.geometry('700x550')
inicial.resizable(width=False, height=False)
inicial.config(bg=corBaseJanela)

logo = ImageTk.PhotoImage(image = Image.open("Plunderlogo.png"))
plunderLogo = Label(image = logo)
plunderLogo.place(x=350, y =200, anchor=CENTER)
plunderLogo.config(bg = corBaseJanela)

#Abre a janela de cadastro
botaoCadastro = Button(inicial, width=20, height=4, relief='flat', text = "Cadastro", command=criaCadastro)
botaoCadastro.config(bg = corBaseBotao)
botaoCadastro.place(x=160, y = 350)

#Abre a janela de login
botaoLogin = Button(inicial, width=20, height=4, relief='flat', text = "Login", command= criaLogin)
botaoLogin.config(bg = corBaseBotao)
botaoLogin.place(x=400, y = 350)







inicial.mainloop()