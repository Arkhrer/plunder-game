INSERT into item (`nome i`, `peso`, `preço de compra`, `preço de venda`) VALUES('Laranja', 2, 50, 45);

INSERT into item (`nome i`, `peso`, `preço de compra`, `preço de venda`) VALUES('Espada', 6, 300, 150);

INSERT into item (`nome i`, `peso`, `preço de compra`, `preço de venda`) VALUES('Martelo de Reparo', 4, 150, 100);

INSERT into item (`nome i`, `peso`, `preço de compra`, `preço de venda`) VALUES('Refeição', 3, 150, 100);

INSERT into item (`nome i`, `peso`, `preço de compra`, `preço de venda`) VALUES('Colete de Ferro', 7, 400, 250);

INSERT into navio (nome, vida, defesa, ataque, destreza, `preço compra`, `preço venda`) VALUES('Galeão', 300, 5, 5, 3, 5000, 2500);

INSERT into navio (nome, vida, defesa, ataque, destreza, `preço compra`, `preço venda`) VALUES('Corveta', 150, 3, 3, 5, 3000, 1500);

INSERT into navio (nome, vida, defesa, ataque, destreza, `preço compra`, `preço venda`) VALUES('Caravela', 100, 2, 2, 7, 2000, 1000);

INSERT into navio (nome, vida, defesa, ataque, destreza, `preço compra`, `preço venda`) VALUES('Brigue', 500, 3, 4, 2, 3500, 1750);

INSERT into navio (nome, vida, defesa, ataque, destreza, `preço compra`, `preço venda`) VALUES('Flyut', 400, 4, 5, 2, 4000, 2000);

INSERT into navio (nome, vida, defesa, ataque, destreza, `preço compra`, `preço venda`) VALUES('Galera', 150, 3, 2, 4, 2000, 1000);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(5, 3, 6, 10, 6);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(10, 2, 2, 6, 10);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(2, 15, 3, 9, 2);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(5, 5, 5, 5, 5);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(17, 25, 15, 26, 19);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(1, 2, 1, 3, 1);

INSERT into `npc inimigo` (ataque, defesa, destreza, sorte, velocidade) VALUES(2, 2, 2, 2, 2);

INSERT into tipo (descrição) VALUES('Combate em terra');

INSERT into tipo (descrição) VALUES('Combate em mar');

INSERT into tipo (descrição) VALUES('Tesouro em terra');

INSERT into tipo (descrição) VALUES('Tesouro marítimo');

INSERT into tipo (descrição) VALUES('Nada de notável');

INSERT into evento (tipo_idtipo, amigavel) VALUES(1, 0);

INSERT into evento (tipo_idtipo, amigavel) VALUES(2, 0);

INSERT into evento (tipo_idtipo, amigavel) VALUES(3, 1);

INSERT into evento (tipo_idtipo, amigavel) VALUES(4, 1);

INSERT into evento (tipo_idtipo, amigavel) VALUES(5, 1); 
