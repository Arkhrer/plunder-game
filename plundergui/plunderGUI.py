#from ssl import _PasswordType
from tkinter import *
from tkinter import ttk
import mysql.connector
#import mariadb
import datetime
import time
import numpy as np
import random
#from turtle import bgcolor
from PIL import ImageTk, Image

#Conector pra Windows
conn = mysql.connector.connect(user = "root", host = "localhost", passwd = "123456", database='plunderdb')
#cursor = conn.cursor()

#conector pro Jonas / comentar o mariadb se não for o Jonas
#conn = mariadb.connect(user = "arkhrer", host = "localhost", password = "Af1732ab!", database='plunderdb')
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

#=====FUNÇÃO DE CADASTRO---------#
def cadastraCheck(userEnt, passwordEnt, emailEnt, pergEnt, segEnt):

    usuario = userEnt.get()
    email = emailEnt.get()
    senha = passwordEnt.get()
    perguntaseg = pergEnt.get()
    respostaseg = segEnt.get()

    pergquery = "SELECT `idpergunta de segurança` from `pergunta de segurança` WHERE `pergunta de segurança`.`pergunta` = %s"

    cursor.execute(pergquery,(perguntaseg,))

    oqueachou = cursor.fetchall()

    if len(oqueachou) > 0:
        perguntasegID = oqueachou[0][0]
    else:
        perginquery = "INSERT INTO `pergunta de segurança`(`pergunta`) VALUES (%s)"
        cursor.execute(perginquery,(perguntaseg,))
        conn.commit()
        cursor.execute(pergquery,(perguntaseg,))
        oqueachou = cursor.fetchall()
        perguntasegID = oqueachou[0][0]

    dataagora = datetime.datetime.now()
    datacria = f"{dataagora.year}-{dataagora.month}-{dataagora.day}"
    create_account = ( """INSERT INTO `conta` (`usuário`, `senha`, `e-mail`,
    `data de criação`, `pergunta de segurança_idpergunta de segurança`, `resposta de segurança`) VALUES 
    (%s, %s, %s, %s, %s, %s)""")

    cursor.execute(create_account, (usuario, senha, email, datacria, perguntasegID, respostaseg))
    conn.commit()

    try:
        if janelaCadastro.winfo_exists():
            janelaCadastro.destroy()
    except(NameError):
        pass

    buscaID = "SELECT `idconta` FROM `conta` WHERE `usuário` = %s "
    cursor.execute(buscaID, (usuario,))
    oqueachou = cursor.fetchall()
    conID = oqueachou[0][0]

    janelaCriaPersonagem(conID)

#------CRIACAO DE PERSONAGEM-----#
def janelaCriaPersonagem(userID):
    global janelaPersonagem

    try:  
        if janelaPersonagem.winfo_exists():
            janelaPersonagem.destroy()
    except(NameError):
        pass

    janelaPersonagem = Tk()
    janelaPersonagem.title("Criação de Personagem")
    janelaPersonagem.geometry('320x350')
    janelaPersonagem.resizable(width=False, height=False)
    janelaPersonagem.config(bg=corBaseJanela)

    textoNome = Label(janelaPersonagem,font=('', 15), bg=corBaseJanela, fg='white', text="Nome do\nPersonagem:")
    textoNome.place(x=20, y=115)
    
    entradaNome = Entry(janelaPersonagem, width=30, justify='left', relief='solid')
    entradaNome.place(x=110, y=120)

    botaoPersonagem = Button(janelaPersonagem, width=20, height=4, text = "Criar", command=lambda: criaPersonagem(userID, entradaNome))
    botaoPersonagem.config(bg = corBaseBotao)
    botaoPersonagem.place(x=80, y = 245)

#-FUÇÃO DE CRIAÇÂO DE PERSONAGEM-#
def criaPersonagem(ID, entnome):
    nome = entnome.get()
    dataagora = datetime.datetime.now()
    datacria = f"{dataagora.year}-{dataagora.month}-{dataagora.day}"


    criaperquery = ("""INSERT INTO `personagem`(`conta_idconta`, `nome`, `nível`, `experiência`, `dinheiro`, `data de criação`) 
    VALUES (%s, %s, %s, %s, %s, %s)""")
    criaatributosquery = ("""INSERT INTO `atributos`(`personagem_idpersonagem`, `ataque`, `defesa`, `destreza`, `sorte`, `carisma`, `velocidade`)
    VALUES (%s, %s, %s, %s, %s, %s, %s)""")
    criainventarioquery = ("""INSERT INTO `inventário`(`personagem_idpersonagem`, `peso total`)
    VALUES (%s, %s)""")
    criaequipadoquery = ("""INSERT INTO `equipado`(`personagem_idpersonagem`)
    VALUES (%s)""")
    criatripulquery = ("""INSERT INTO `tripulação`(`personagem_idpersonagem`, `número`, `nível`, `experiência`)
    VALUES (%s, %s, %s, %s)""")

    cursor.execute(criaperquery, (ID, nome, 1, 0, 0, datacria))
    conn.commit()

    buscaID = "SELECT `idpersonagem` FROM `personagem` WHERE `conta_idconta` = %s"
    cursor.execute(buscaID, (ID,))
    oqueachou = cursor.fetchall()
    IDper = oqueachou[0][0]

    cursor.execute(criaatributosquery, (IDper, 1, 1, 1, 1, 1, 1))
    conn.commit()

    cursor.execute(criainventarioquery, (IDper, 350))
    conn.commit()

    cursor.execute(criaequipadoquery, (IDper,))
    conn.commit()

    cursor.execute(criatripulquery, (IDper, 0, 1, 0))
    conn.commit()

    try:  
        if janelaPersonagem.winfo_exists():
            janelaPersonagem.destroy()
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

    login = "SELECT * FROM `conta` WHERE `usuário`= %s AND `senha` = %s"

    cursor.execute(login, (username, password))

    oqueachou = cursor.fetchall()

    pegaid = "SELECT `idpersonagem` FROM `personagem` WHERE `conta_idconta` = %s"

    cursor.execute(pegaid, (oqueachou[0][0],))

    oqueachou2 = cursor.fetchall()

    idpersonagem = oqueachou2[0][0]

    if len(oqueachou2) > 0:
        try:  
            if janelaLogin.winfo_exists():
                janelaLogin.destroy()

        except(NameError):
            pass
        criaHome(oqueachou2[0][0])
    else:
        print("deuruim")
    
#----------JANELA HOME----------#
def criaHome(idpersonagem):
    global janelaHome
    
    #Se houver alguma outra janela aberta, fecha ela antes de abrir a Home

    try:
        if inicial.winfo_exists():
            inicial.destroy()
    except(NameError):
        pass
    
    janelaHome = Tk()
    janelaHome.title("Plunder")
    janelaHome.geometry('550x450')
    janelaHome.resizable(width=False, height=False)
    janelaHome.config(bg=corBaseJanela)

    nomequery = "SELECT `nome`, `nível`, `experiência`, `dinheiro`  from `personagem` WHERE `idpersonagem`= %s"
    cursor.execute(nomequery, (idpersonagem,))
    oqueachou = cursor.fetchall()
    
    textoNome = Label(janelaHome,font=('', 25), bg=corBaseJanela, fg='white', text=oqueachou[0][0])#Text TEMPORARIO, MUDAR COM A DATABASE
    textoNome.place(x=285, y=15)

    #Frame que segura as informações no centro da página
    infoFrame = LabelFrame(janelaHome, borderwidth=1, relief="solid", bg = corBaseJanela, fg='white')
    infoFrame.place(x=215, y=60, width = 250, height = 350)

    #Labels que vão mostrar as informações
    le1 = Label(infoFrame, text=f"Nível: {oqueachou[0][1]}", bg=corBaseJanela, fg= 'white', font=('', 15))
    le1.pack(anchor="w", pady= (90, 5))

    le2 = Label(infoFrame, text=f"Experiencia: {oqueachou[0][2]}", bg=corBaseJanela, fg= 'white', font=('', 15))
    le2.pack(anchor="w", pady= 5)

    le3 = Label(infoFrame, text=f"Dinheiro: {oqueachou[0][3]}", bg=corBaseJanela, fg= 'white', font=('', 15))
    le3.pack(anchor="w", pady= 5)

    #Botões do menu

    botaoLoja = Button(janelaHome, width=20, height=2, text = "Loja", relief='flat', command = lambda: criaLoja(idpersonagem))
    botaoLoja.config(bg = corBaseBotao)
    botaoLoja.pack(anchor="w", pady=(70, 10), padx=(20, 0))

    botaoTripulacao = Button(janelaHome, width=20, height=2, text = "Tripulação", relief='flat', command = lambda: criaTripulacao(idpersonagem))
    botaoTripulacao.config(bg = corBaseBotao)
    botaoTripulacao.pack(anchor="w", pady=10, padx=(20, 0))

    botaoNavio = Button(janelaHome, width=20, height=2, text = "Navio", relief='flat', command = lambda: criaNavio(idpersonagem))
    botaoNavio.config(bg = corBaseBotao)
    botaoNavio.pack(anchor="w", pady=10, padx=(20, 0))

    botaoGuilda = Button(janelaHome, width=20, height=2, text = "Guilda", relief='flat', command = lambda: criaGuilda(idpersonagem))
    botaoGuilda.config(bg = corBaseBotao)
    botaoGuilda.pack(anchor="w", pady=10, padx=(20, 0))

    botaoMar = Button(janelaHome, width=14, height=5, text = "MAR", font=('', 15, 'bold'), relief='flat', command = lambda: criaMar(idpersonagem))
    botaoMar.config(bg = corBaseBotao)
    botaoMar.pack(anchor="w", pady=30, padx=(20, 0))
    
    #Atualiza dados da HOME
    janelaHome.after(100,lambda: atualizahome(idpersonagem, le1, le2, le3))


#---------ATUALIZA HOME----------#
def atualizahome(idpersonagem, le1, le2, le3):
    nomequery = "SELECT `nome`, `nível`, `experiência`, `dinheiro`  from `personagem` WHERE `idpersonagem`= %s"
    cursor.execute(nomequery, (idpersonagem,))
    oqueachou = cursor.fetchall()

    le1.config(text=f"Nível: {oqueachou[0][1]}")

    le2.config(text=f"Experiencia: {oqueachou[0][2]}")

    le3.config(text=f"Dinheiro: {oqueachou[0][3]}")

    janelaHome.after(100,lambda: atualizahome(idpersonagem, le1, le2, le3))


#----------JANELA LOJA----------#
def criaLoja(idpersonagem):
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

    itensquery = "SELECT `nome i`, `preço de compra` FROM `item`"
    cursor.execute(itensquery)
    oqueachou = cursor.fetchall()

    tam = len(oqueachou)

    listaLoja = []

    for i in range(tam):
        listaLoja = listaLoja + [{'Nome': oqueachou[i][0], 'Preco': oqueachou[i][1]}]

    maxspace = len(max(listaLoja, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaLoja)):
        lojaLoja.insert(END, f"{listaLoja[i]['Nome'].ljust(maxspace)}{listaLoja[i]['Preco'].ljust(maxspace)}")

    #Botão de comprar itens
    botaoCompra = Button(janelaLoja, width=21, height=4, relief='flat', text = "Comprar") # COLOCAR COMANDO QUE EXECUTA A COMPRA DE ACORDO COM O PREÇO
    botaoCompra.config(bg = corBaseBotao)
    botaoCompra.place(x=87, y = 420)


    #Inventario para vender itens - POPULAR COM ITENS DO BANCO DE DADOS

    textoInv = Label(janelaLoja ,font=('', 25), bg=corBaseJanela, fg='white', text='INVENTÁRIO')#Text TEMPORARIO, MUDAR COM A DATABASE
    textoInv.place(x = 425, y = 10)

    lojaInventario = Listbox(janelaLoja, bg = corBaseJanela, selectmode = 'single', relief = 'flat', font =('TkDefaultFont 11', 13), fg = 'white')
    lojaInventario.place(x = 375, y = 60, width = 300, height = 350)

    invquery = "select `item`.`nome i`, `item`.`preço de venda` from `item` right join `inventário tem item` on `inventário tem item`.`item_iditem` = `item`.`iditem` where `inventário_personagem_idpersonagem` = %s"
    cursor.execute(invquery,(idpersonagem, ))
    oqueachou = cursor.fetchall()

    tam = len(oqueachou)

    listaInv = []

    for i in range(tam):
        listaInv = listaInv + [{'Nome': oqueachou[i][0], 'Preco': oqueachou[i][1]}]

    # listaInv = [{'Nome': 'Laranja', 'Preco': '500 Dobrões'},
    #            {'Nome': 'Espada', 'Preco': '5000 Dobrões' },]  # Lista de dicionários, cada item da lista é uma linha na loja - POPULAR COM ITENS DO BANCO DE DADOS

    maxspace = len(max(listaInv, key=lambda x:len(x['Nome']))['Nome']) + 6
    for i in range(len(listaInv)):
        lojaInventario.insert(END, f"{listaInv[i]['Nome'].ljust(maxspace)}{listaInv[i]['Preco'].rjust(maxspace)}")


    botaoVende = Button(janelaLoja, width=21, height=4, relief='flat', text = "Vender") # COLOCAR COMANDO QUE EXECUTA A VENDA DE ACORDO COM O PREÇO
    botaoVende.config(bg = corBaseBotao)
    botaoVende.place(x=450, y = 420)

#----------JANELA TRIPULAÇÃO----------#
def criaTripulacao(idpersonagem):
    janelaTripulacao = Tk()
    janelaTripulacao.title('Tripulação')
    janelaTripulacao.geometry('300x400')
    janelaTripulacao.resizable(width=False, height=False)
    janelaTripulacao.config(bg=corBaseJanela)

    tripQuery = "SELECT `número`  from `tripulação` WHERE `personagem_idpersonagem`= %s"
    cursor.execute(tripQuery, (idpersonagem,))
    oqueachou = cursor.fetchall()
    tripnum = int(oqueachou[0][0])

    dinheiroQuery = "SELECT `dinheiro`  from `personagem` WHERE `idpersonagem`= %s"
    cursor.execute(dinheiroQuery, (idpersonagem,))
    oqueachou2 = cursor.fetchall()
    dinheiro = int(oqueachou2[0][0])

    textoTrip = Label(janelaTripulacao ,font=('', 35), bg=corBaseJanela, fg='white', text='Tripulação')#Text TEMPORARIO, MUDAR COM A DATABASE
    textoTrip.pack(pady = 15)

    textoMembros = Label(janelaTripulacao ,font=('', 20), bg=corBaseJanela, fg='white', text=f'{oqueachou[0][0]} Membros')#Quantidade variável
    textoMembros.pack(pady = (30, 10))

    textoValorMembro = Label(janelaTripulacao ,font=('', 20), bg=corBaseJanela, fg='white', text='100 Dobrões\n por membro')#Quantidade variável
    textoValorMembro.pack(pady = (30, 10))

    botaoContrata = Button(janelaTripulacao, width=21, height=4, relief='flat', text = "Contratar\nMembro", font=('', 15, 'bold'), command =lambda: contrataTrip(oqueachou, dinheiro, botaoContrata, idpersonagem, textoMembros)) #CONTRATA MEMBRO TRIPULAÇÃO, VALOR AUMENTA A CADA MEMBRO
    botaoContrata.config(bg = corBaseBotao)
    botaoContrata.pack(pady = 30)

    if tripnum >= 20 or dinheiro < 100:
        botaoContrata["state"] = DISABLED
                

def contrataTrip(oqueachou, dinheiro, botaoContrata, idpersonagem, textoMembros):
    numeroAtual = oqueachou[0][0]
    if numeroAtual >= 20 or dinheiro < 100:
        botaoContrata["state"] = DISABLED
    else:
        dinheiro -= 100
        compraTrip = "UPDATE `tripulação` set `número` = `número` + 1 WHERE `personagem_idpersonagem`= %s"
        cursor.execute(compraTrip, (idpersonagem,))
        conn.commit()
        dinheiroUpdate = "UPDATE `personagem` set `dinheiro` = `dinheiro` - 100 WHERE `idpersonagem`= %s"
        cursor.execute(dinheiroUpdate, (idpersonagem,))
        conn.commit()
            
        tripQuery = "SELECT `número`  from `tripulação` WHERE `personagem_idpersonagem`= %s"
        cursor.execute(tripQuery, (idpersonagem,))
        numeroTrip = cursor.fetchall()
        textoMembros.config(text = f"{numeroTrip[0][0]} Membros")

#----------JANELA NAVIO----------#
def criaNavio(idpersonagem):
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
def criaGuilda(idpersonagem):
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
def criaMar(idpersonagem):
    arrayMar = criaMatrizMar()
    janelaMar = Toplevel(janelaHome)
    janelaMar.title('Plunder')
    janelaMar.geometry('1200x750')
    janelaMar.resizable(width=False, height=False)
    janelaMar.config(bg=corBaseJanela)

    #Mapa do jogo
    Mapa = ImageTk.PhotoImage(file = 'plundergui/PlunderMapa.png')
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

    botaoCoords = Button(janelaMar, width=19, height=3, relief='flat', text = "Viajar", command = lambda: viajaCoordenadas(entradaCoords, arrayMar, janelaMar))
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

def criaMatrizMar():
    arrayMar = np.zeros((21, 21), dtype=int)
    arrayMar[1:7,13:21] = 1
    arrayMar[7,2] = 1
    arrayMar[17,17] = 1
    arrayMar[8,2] = 1
    arrayMar[7,4] = 1
    arrayMar[7,1] = 1
    arrayMar[17,16] = 1
    arrayMar[17,18] = 1
    arrayMar[15,7] = 1
    arrayMar[14,17] = 1
    arrayMar[18,14] = 1
    arrayMar[18,19] = 1
    return arrayMar

def viajaCoordenadas(entradaCoords, arrayMar, janelaMar):
    x, y = map(int, entradaCoords.get().split(','))
    rand = random.randint(0, 15)

    #Se descer em terra
    if arrayMar[x][y] == 1:

        #Se o número aleatório for menor que 7, inicia combate.
        if rand <= 7:
            janelaEvento = Toplevel(janelaMar)
            janelaEvento.title('Combate!')
            janelaEvento.geometry('300x300')
            janelaEvento.resizable(width=False, height=False)
            janelaEvento.config(bg=corBaseJanela)

            le1 = Label(janelaEvento, text=f"Você ancora o navio e desce em terra firme. Se depara com um inimigo que possui x y z e é derrotado!", bg=corBaseJanela, fg= 'white', font=('', 15), justify='center', wraplength=250)
            le1.pack(anchor="n", pady=(40, 10))

        #Se o número aleatório for entre 8 e 9, acha tesouro.
        elif rand > 7 and rand <= 9:
            janelaEvento = Toplevel(janelaMar)
            janelaEvento.title('Tesouro!')
            janelaEvento.geometry('300x300')
            janelaEvento.resizable(width=False, height=False)
            janelaEvento.config(bg=corBaseJanela)
        
        #Se o número aleatório for entre 10 e 15, nada acontece.
        else:
            janelaEvento = Toplevel(janelaMar)
            janelaEvento.title('Nada!')
            janelaEvento.geometry('300x300')
            janelaEvento.resizable(width=False, height=False)
            janelaEvento.config(bg=corBaseJanela)
            le1 = Label(janelaEvento, text=f"Nada de notável acontece.", bg=corBaseJanela, fg= 'white', font=('', 30), justify='center', wraplength=250)
            le1.pack(anchor="n", pady=(70, 10))

        print('TERRA')

    #Se ficar no mar:
    else:

        #Se o número aleatório for menor ou igual a 7, inicia combate.
        if rand <= 7:
            janelaEvento = Toplevel(janelaMar)
            janelaEvento.title('Combate!')
            janelaEvento.geometry('300x300')
            janelaEvento.resizable(width=False, height=False)
            janelaEvento.config(bg=corBaseJanela)

            
            le1 = Label(janelaEvento, text=f"Você avista um navio se aproximando no horizonte e se prepara para o combate.\n\n o Navio inimigo possui x y z. Você é derrotado!", bg=corBaseJanela, fg= 'white', font=('', 15), justify='center', wraplength=250)
            le1.pack(anchor="n", pady=(40, 10))
        
        #Se o número aleatório for entre 8 e 15, nada acontece.
        else:
            janelaEvento = Toplevel(janelaMar)
            janelaEvento.title('Nada!')
            janelaEvento.geometry('300x300')
            janelaEvento.resizable(width=False, height=False)
            janelaEvento.config(bg=corBaseJanela)
            le1 = Label(janelaEvento, text=f"Nada de notável acontece.", bg=corBaseJanela, fg= 'white', font=('', 30), justify='center', wraplength=250)
            le1.pack(anchor="n", pady=(70, 10))
        print('MAR')


#----------JANELA INICIAL-------------#
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

corBaseJanela = '#434343' #Cinza escuro
corBaseBotao = '#B9a82b' #Cinza

pagInicial()

conn.close()