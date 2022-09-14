#from ssl import _PasswordType
from tkinter import *
from tkinter import ttk
import mysql.connector
import mariadb
import datetime
#from turtle import bgcolor
from PIL import ImageTk, Image


#conn = mysql.connector.connect(user = "root", host = "localhost", passwd = "123456", database='mydb')

#conector pro Jonas
conn = mariadb.connect(user = "arkhrer", host = "localhost", password = "Af1732ab!", database='plunder')
cursor = conn.cursor()

#----------JANELA CADASTRO----------#
def criaCadastro():
    global janelaCadastro

    try:
        if janelaCadastro.winfo_exists():
            janelaCadastro.destroy()

    except(NameError):
        pass

    janelaCadastro = Tk()
    janelaCadastro.title("Cadastro")
    janelaCadastro.geometry('500x500')
    janelaCadastro.resizable(width=False, height=False)
    janelaCadastro.config(bg=corBaseJanela)
    
    textoUsuario = Label(janelaCadastro,font=('', 15), bg=corBaseJanela, fg='white', text="Usuário:")
    textoUsuario.place(x=20, y=90)
    
    entradaUsuario = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaUsuario.place(x=110, y=95)

    textoEmail = Label(janelaCadastro,font=('', 15), bg=corBaseJanela, fg='white', text="E-mail:")
    textoEmail.place(x=20, y=128)

    entradaEmail = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaEmail.place(x=110, y=133)

    textoSenha = Label(janelaCadastro,font=('', 15),bg=corBaseJanela, fg='white', text="Senha:")
    textoSenha.place(x=20, y=166)

    entradaSenha = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaSenha.place(x=110, y=171)

    textoPergunta = Label(janelaCadastro,font=('', 10),bg=corBaseJanela, fg='white', text="Pergunta de\n Segurança:")
    textoPergunta.place(x=20, y=204)

    entradaPergunta = ttk.Combobox(janelaCadastro, width=30, values = ["Pet", "Bairro", "Escola", "Nome do meio"])
    entradaPergunta.place(x = 110, y = 209)


    textoSeguranca = Label(janelaCadastro,font=('', 10),bg=corBaseJanela, fg='white', text="Resposta de\n Segurança:")
    textoSeguranca.place(x=20, y=242)

    entradaSeguranca = Entry(janelaCadastro, width=30, justify='left', relief='solid')
    entradaSeguranca.place(x=110, y=247)

    textoCadastroC = Label(janelaCadastro, font=('', 35), bd=0, bg=corBaseJanela, fg='white', text="CADASTRO")
    textoCadastroC.place(x=30, y=20)

    botaoCadastra = Button(janelaCadastro, width=20, height=4, text = "Cadastrar", command = lambda: cadastraCheck(entradaUsuario, entradaSenha, entradaEmail, entradaPergunta, entradaSeguranca))
    botaoCadastra.config(bg = corBaseBotao)
    botaoCadastra.place(x=80, y = 300)

#Ações a serem executadas quando o botão for pressionado
def cadastraCheck(userEnt, passwordEnt, emailEnt, pergEnt, segEnt):

    usuario = userEnt.get()
    email = emailEnt.get()
    senha = passwordEnt.get()
    perguntaseg = pergEnt.get()
    respostaseg = segEnt.get()

    pergquery = "SELECT `idPergunta de Segurança` from `pergunta de segurança` WHERE `pergunta de segurança`.`Pergunta` = %s"

    cursor.execute(pergquery,(perguntaseg,))

    oqueachou = cursor.fetchall()

    if len(oqueachou) > 0:
        perguntasegID = oqueachou[0][0]
    else:
        perginquery = "INSERT INTO `pergunta de segurança`(`Pergunta`) VALUES (%s)"
        cursor.execute(perginquery,(perguntaseg,))
        conn.commit()
        cursor.execute(pergquery,(perguntaseg,))
        oqueachou = cursor.fetchall()
        perguntasegID = oqueachou[0][0]

    dataagora = datetime.datetime.now()
    datacria = f"{dataagora.year}-{dataagora.month}-{dataagora.day}"
    create_account = ( """INSERT INTO `conta` (`Usuário`, `Senha`, `E-mail`,
    `Data de Criação`, `Pergunta de Segurança_idPergunta de Segurança`, `Resposta de Segurança`) VALUES 
    (%s, %s, %s, %s, %s, %s)""")

    cursor.execute(create_account, (usuario, senha, email, datacria, perguntasegID, respostaseg))
    conn.commit()

    try:
        if janelaCadastro.winfo_exists():
            janelaCadastro.destroy()

    except(NameError):
        pass


#----------JANELA LOGIN----------#
def criaLogin():
    global janelaLogin

    try:  
        if janelaLogin.winfo_exists():
            janelaLogin.destroy()

    except(NameError):
        pass

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

    botaoLoga = Button(janelaLogin, width=20, height=4, text = "Login", command=lambda: loginCheck(entradaUsuarioL, entradaSenhaL))
    botaoLoga.config(bg = corBaseBotao)
    botaoLoga.place(x=80, y = 245)
    
#--------FUNCAO DE LOGIN-----------#

def loginCheck(userEnt, passwordEnt):
    username = userEnt.get()
    password = passwordEnt.get()

    login = "SELECT `Usuário`, `Senha` from `conta` WHERE  `conta`.`Usuário`= %s AND `conta`.`Senha` = %s"

    cursor.execute(login, (username, password))

    # oqueachou = cursor.fetchall()

    if len(cursor.fetchall()) > 0:
        try:  
            if janelaLogin.winfo_exists():
                janelaLogin.destroy()

        except(NameError):
            pass
        criaHome(username)
    else:
        print("deuruim")

    
    

#----------JANELA HOME----------#
def criaHome(user):
    global janelaHome

    #Se houver alguma outra janela aberta, fecha ela antes de abrir a Home

    try:
                
        if inicial.winfo_exists():
            inicial.destroy()

    except(NameError):
        pass

    janelaHome = Tk()
    janelaHome.title("Plunder")
    janelaHome.geometry('700x450')
    janelaHome.resizable(width=False, height=False)
    janelaHome.config(bg=corBaseJanela)

    nomequery = "SELECT `Usuário` from `conta` WHERE  `conta`.`Usuário`= %s"

    cursor.execute(nomequery, (user,))
    oqueachou = cursor.fetchall()
    
    textoNome = Label(janelaHome,font=('', 25), bg=corBaseJanela, fg='white', text=oqueachou[0][0])#Text TEMPORARIO, MUDAR COM A DATABASE
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

    botaoLoja = Button(janelaHome, width=20, height=2, text = "Loja", relief='flat', command = criaLoja)
    botaoLoja.config(bg = corBaseBotao)
    botaoLoja.pack(anchor="w", pady=(70, 10), padx=(20, 0))

    botaoTripulacao = Button(janelaHome, width=20, height=2, text = "Tripulação", relief='flat', command = criaTripulacao)
    botaoTripulacao.config(bg = corBaseBotao)
    botaoTripulacao.pack(anchor="w", pady=10, padx=(20, 0))

    botaoNavio = Button(janelaHome, width=20, height=2, text = "Navio", relief='flat', command = criaNavio)
    botaoNavio.config(bg = corBaseBotao)
    botaoNavio.pack(anchor="w", pady=10, padx=(20, 0))

    botaoGuilda = Button(janelaHome, width=20, height=2, text = "Guilda", relief='flat', command = criaGuilda)
    botaoGuilda.config(bg = corBaseBotao)
    botaoGuilda.pack(anchor="w", pady=10, padx=(20, 0))

    botaoMar = Button(janelaHome, width=14, height=5, text = "MAR", font=('', 15, 'bold'), relief='flat', command = criaMar)
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


#----------JANELA LOJA----------#
def criaLoja():
    janelaLoja = Tk()
    janelaLoja.title('Loja')
    janelaLoja.geometry('700x550')
    janelaLoja.resizable(width=False, height=False)
    janelaLoja.config(bg=corBaseJanela)

    textoLoja = Label(janelaLoja ,font=('', 25), bg=corBaseJanela, fg='white', text='LOJA')#Text TEMPORARIO, MUDAR COM A DATABASE
    textoLoja.place(x = 120, y = 10)

    #Loja para comprar itens
    lojaLoja = Listbox(janelaLoja, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    lojaLoja.place(x = 25, y = 60, width = 300, height = 350)

    #Popula a lista da loja
    listaLoja = [{'Nome': 'Laranja', 'Preco': '500 Dobrões'},
               {'Nome': 'Espada', 'Preco': '5000 Dobrões' },]  # Lista de dicionários, cada item da lista é uma linha na loja - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaLoja, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaLoja)):
        lojaLoja.insert(END, f"{listaLoja[i]['Nome'].ljust(maxspace)}{listaLoja[i]['Preco'].rjust(maxspace)}")

    #Botão de comprar itens
    botaoCompra = Button(janelaLoja, width=21, height=4, relief='flat', text = "Comprar") # COLOCAR COMANDO QUE EXECUTA A COMPRA DE ACORDO COM O PREÇO
    botaoCompra.config(bg = corBaseBotao)
    botaoCompra.place(x=87, y = 420)


    #Inventario para vender itens - POPULAR COM ITENS DO BANCO DE DADOS

    textoInv = Label(janelaLoja ,font=('', 25), bg=corBaseJanela, fg='white', text='INVENTÁRIO')#Text TEMPORARIO, MUDAR COM A DATABASE
    textoInv.place(x = 425, y = 10)

    lojaInventario = Listbox(janelaLoja, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    lojaInventario.place(x = 375, y = 60, width = 300, height = 350)

    listaInv = [{'Nome': 'Laranja', 'Preco': '500 Dobrões'},
               {'Nome': 'Espada', 'Preco': '5000 Dobrões' },]  # Lista de dicionários, cada item da lista é uma linha na loja - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaInv, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaInv)):
        lojaInventario.insert(END, f"{listaInv[i]['Nome'].ljust(maxspace)}{listaInv[i]['Preco'].rjust(maxspace)}")


    botaoVende = Button(janelaLoja, width=21, height=4, relief='flat', text = "Vender") # COLOCAR COMANDO QUE EXECUTA A VENDA DE ACORDO COM O PREÇO
    botaoVende.config(bg = corBaseBotao)
    botaoVende.place(x=450, y = 420)


#----------JANELA TRIPULAÇÃO----------#
def criaTripulacao():
    janelaTripulacao = Tk()
    janelaTripulacao.title('Tripulação')
    janelaTripulacao.geometry('300x400')
    janelaTripulacao.resizable(width=False, height=False)
    janelaTripulacao.config(bg=corBaseJanela)

    textoTrip = Label(janelaTripulacao ,font=('', 35), bg=corBaseJanela, fg='white', text='Tripulação')#Text TEMPORARIO, MUDAR COM A DATABASE
    textoTrip.pack(pady = 15)

    textoMembros = Label(janelaTripulacao ,font=('', 20), bg=corBaseJanela, fg='white', text='0 Membros')#Quantidade variável
    textoMembros.pack(pady = (30, 10))

    textoValorMembro = Label(janelaTripulacao ,font=('', 20), bg=corBaseJanela, fg='white', text='100 Dobrões\n por membro')#Quantidade variável
    textoValorMembro.pack(pady = (30, 10))

    botaoContrata = Button(janelaTripulacao, width=21, height=4, relief='flat', text = "Contratar\nMembro", font=('', 15, 'bold')) #CONTRATA MEMBRO TRIPULAÇÃO, VALOR AUMENTA A CADA MEMBRO
    botaoContrata.config(bg = corBaseBotao)
    botaoContrata.pack(pady = 30)


#----------JANELA NAVIO----------#
def criaNavio():
    janelaNavio = Tk()
    janelaNavio.title('Cais')
    janelaNavio.geometry('1200x550')
    janelaNavio.resizable(width=False, height=False)
    janelaNavio.config(bg=corBaseJanela)

    textoCais = Label(janelaNavio, font=('', 25), bg=corBaseJanela, fg='white', text='Cais')
    textoCais.place(x = 120, y = 10)

    #-------------------Cais para comprar navios
    lojaCais = Listbox(janelaNavio, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    lojaCais.place(x = 25, y = 60, width = 300, height = 350)

    #Popula a lista do cais
    listaCais = [{'Nome': 'Escuna', 'Preco': '15000 Dobrões'},
               {'Nome': 'Galeão', 'Preco': '50000 Dobrões' },
               {'Nome': 'Canoa', 'Preco': '2000 Dobrões'}]  # Lista de dicionários, cada item da lista é uma linha na loja - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaCais, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaCais)):
        lojaCais.insert(END, f"{listaCais[i]['Nome'].ljust(maxspace)}{listaCais[i]['Preco'].rjust(maxspace)}")

    #Botão de comprar navios
    botaoCompra = Button(janelaNavio, width=21, height=4, relief='flat', text = "Comprar") # COLOCAR COMANDO QUE EXECUTA A COMPRA DE ACORDO COM O PREÇO
    botaoCompra.config(bg = corBaseBotao)
    botaoCompra.place(x=87, y = 420)


    #-----------------Descrição do navio selecionado no Cais
    #ALTERAR ESSES VALORES DE ACORDO COM O ITEM SELECIONADO NA LISTBOX
    infoCaisFrame = LabelFrame(janelaNavio, borderwidth=1, relief="solid", bg = corBaseJanela, fg='white')
    infoCaisFrame.place(x=345, y=60, width = 225, height = 350)

    le1 = Label(infoCaisFrame, text="Teste: VALORVALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le1.pack(anchor="w", pady= (90, 5))

    le2 = Label(infoCaisFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le2.pack(anchor="w", pady= 5)

    le3 = Label(infoCaisFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le3.pack(anchor="w", pady= 5)

    le4 = Label(infoCaisFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le4.pack(anchor="w", pady= 5)



    #----------------------Inventario para equipar navios - POPULAR COM ITENS DO BANCO DE DADOS

    textoFrota = Label(janelaNavio ,font=('', 25), bg=corBaseJanela, fg='white', text='Sua Frota')
    textoFrota.place(x = 670, y = 10)

    lojaFrota = Listbox(janelaNavio, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    lojaFrota.place(x = 605, y = 60, width = 300, height = 350)

    listaInv = [{'Nome': 'Laranja', 'Preco': '500 Dobrões'},
               {'Nome': 'Espada', 'Preco': '5000 Dobrões' },]  # Lista de dicionários, cada item da lista é uma linha na loja - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaInv, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaInv)):
        lojaFrota.insert(END, f"{listaInv[i]['Nome'].ljust(maxspace)}{listaInv[i]['Preco'].rjust(maxspace)}")


    botaoEquipa = Button(janelaNavio, width=21, height=4, relief='flat', text = "Definir como\nprincipal") # COLOCAR COMANDO QUE ALTERA O NAVIO PRINCIPAL
    botaoEquipa.config(bg = corBaseBotao)
    botaoEquipa.place(x=675, y = 420)

    #-----------------Descrição do navio selecionado na Frota
    #ALTERAR ESSES VALORES DE ACORDO COM O ITEM SELECIONADO NA LISTBOX
    infoInvFrame = LabelFrame(janelaNavio, borderwidth=1, relief="solid", bg = corBaseJanela, fg='white')
    infoInvFrame.place(x=925, y=60, width = 225, height = 350)

    le1 = Label(infoInvFrame, text="Teste: VALORVALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le1.pack(anchor="w", pady= (90, 5))

    le2 = Label(infoInvFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le2.pack(anchor="w", pady= 5)

    le3 = Label(infoInvFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le3.pack(anchor="w", pady= 5)

    le4 = Label(infoInvFrame, text="Teste: VALOR", bg=corBaseJanela, fg= 'white', font=('', 15))
    le4.pack(anchor="w", pady= 5)


#----------JANELA GUILDA----------#
def criaGuilda():
    janelaGuilda = Tk()
    janelaGuilda.title('Guilda')
    janelaGuilda.geometry('700x450')
    janelaGuilda.resizable(width=False, height=False)
    janelaGuilda.config(bg=corBaseJanela)

    nomeGuilda = Label(janelaGuilda ,font=('', 25), bg=corBaseJanela, fg='white', text='NOME')#Text TEMPORARIO, MUDAR COM A DATABASE
    nomeGuilda.place(x = 120, y = 10)

    guildaMembros = Listbox(janelaGuilda, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    guildaMembros.place(x = 25, y = 60, width = 300, height = 350)

    #Popula a lista de membros da guilda
    listaGuilda = [{'Nome': 'Du'},
               {'Nome': 'Dudu'},
               {'Nome': 'Edu'}]  # Lista de dicionários, cada item da lista é um membro da guilda - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaGuilda, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaGuilda)):
        guildaMembros.insert(END, f"{listaGuilda[i]['Nome'].ljust(maxspace)}")

    #Criação de Guilda
    textoCriaG = Label(janelaGuilda ,font=('', 25), bg=corBaseJanela, fg='white', text='Criar Guilda')
    textoCriaG.place(x = 375, y = 60)

    entradaNovoNome = Entry(janelaGuilda, width=30, justify='left', relief='solid')
    entradaNovoNome.place(x=375, y=110)

    botaoCriaG = Button(janelaGuilda, width=21, height=4, relief='flat', text = "Criar\nGuilda") # COLOCAR COMANDO QUE CRIA UMA GUILDA COM O NOME NO BANCO DE DADOS
    botaoCriaG.config(bg = corBaseBotao)
    botaoCriaG.place(x=385, y = 150)

    #Entrar em guilda
    textoEntraG = Label(janelaGuilda ,font=('', 25), bg=corBaseJanela, fg='white', text='Entrar em Guilda')
    textoEntraG.place(x = 375, y = 250)

    entradanomeGuilda = Entry(janelaGuilda, width=30, justify='left', relief='solid')
    entradanomeGuilda.place(x=375, y=300)

    botaoEntraG = Button(janelaGuilda, width=21, height=4, relief='flat', text = "Entrar em\nGuilda") # COLOCAR COMANDO QUE ENTRA EM UMA GUILDA JÁ EXISTENTE
    botaoEntraG.config(bg = corBaseBotao)
    botaoEntraG.place(x=385, y = 340)

#----------JANELA MAR-------------#
def criaMar():
    janelaMar = Toplevel(janelaHome)
    janelaMar.title('Plunder')
    janelaMar.geometry('1200x750')
    janelaMar.resizable(width=False, height=False)
    janelaMar.config(bg=corBaseJanela)

    #Mapa do jogo
    Mapa = ImageTk.PhotoImage(file = 'PlunderMapa.png')
    plunderMapa = Label(janelaMar, image = Mapa)
    plunderMapa.pack()
    plunderMapa.config(bg = corBaseJanela)
    plunderMapa.image_names = Mapa

    #Inventário do personagem
    textoInventario = Label(janelaMar, font=('', 25), bg=corBaseJanela, fg='white', text='Inventário')
    textoInventario.place(x = 40, y = 50)   

    botaoUsa = Button(janelaMar, width=21, height=4, relief='flat', text = "Usar") 
    botaoUsa.place(x= 30, y = 570)

    inventario = Listbox(janelaMar, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    inventario.place(x = 10, y = 100, width = 200, height = 450)

    #Popula a lista do Inventário
    listaInventario = [{'Nome': 'Laranja'},
               {'Nome': 'Martelo de Reparo'}]  # Lista de dicionários, cada item da lista é um item - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaInventario, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaInventario)):
        inventario.insert(END, f"{listaInventario[i]['Nome'].ljust(maxspace)}")


    #Coordenadas para viajar
    textoCoords = Label(janelaMar, font=('', 20), bg=corBaseJanela, fg='white', text='Coordenadas')
    textoCoords.place(x = 945, y = 305)

    entradaCoords = Entry(janelaMar, width=30, justify='left', relief='solid')
    entradaCoords.place(x=950, y=350)
    entradaCoords.insert(END, '0, 0')

    botaoCoords = Button(janelaMar, width=19, height=3, relief='flat', text = "Viajar")
    botaoCoords.config(bg = corBaseBotao)
    botaoCoords.place(x= 970, y = 395)

    #Informações do personagem
    textoChar = Label(janelaMar, font=('', 25), bg=corBaseJanela, fg='white', text='NOME')#Text TEMPORARIO, MUDAR COM A DATABASE
    textoChar.place(x = 950, y = 50)

    infoCharFrame = LabelFrame(janelaMar, borderwidth=1, relief="solid", bg = corBaseJanela, fg='white')
    infoCharFrame.place(x=950, y=95, width = 235, height = 100)

    le1 = Label(infoCharFrame, text="HP do personagem: XXX", bg=corBaseJanela, fg= 'white', font=('', 15))
    le1.pack(anchor="w", pady= (15, 5))

    le2 = Label(infoCharFrame, text="HP do navio: XXX", bg=corBaseJanela, fg= 'white', font=('', 15))
    le2.pack(anchor="w", pady= 5)
   

#----------JANELA INICIAL-------------#
corBaseJanela = '#434343' #Cinza escuro
corBaseBotao = '#B9a82b' #Cinza

def pagInicial():

    global inicial
    inicial = Tk()

    inicial.title('Plunder')
    inicial.geometry('700x550')
    inicial.resizable(width=False, height=False)
    inicial.config(bg=corBaseJanela)

    logo = ImageTk.PhotoImage(image = Image.open(r'plundergui/Plunderlogo.png'))
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


pagInicial()




#conn.close()