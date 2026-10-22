% Tarefa 1: Lavadeira
fis = mamfis(Name="Lavadeira");

% Definindo os domínios
fis = addInput(fis,[-2, 12],Name="Peso");
fis = addInput(fis,[-2, 12],Name="Sujeira");
fis = addOutput(fis,[0, 120],Name="Quantidade de Sabão em Pó");

% Definindo as faixas de pertinência
fis = addMF(fis,"Peso","trapmf",[-2, -1, 0, 2],Name="Muito Leve");
fis = addMF(fis,"Peso","trimf",[1, 3, 5],Name="Leve");
fis = addMF(fis,"Peso","trapmf",[4, 6, 5, 9],Name="Pesado");
fis = addMF(fis,"Peso","trapmf",[8, 9, 11, 12],Name="Muito Pesado");

fis = addMF(fis,"Sujeira","trapmf",[-2, -1, 0, 2],Name="Baixa");
fis = addMF(fis,"Sujeira","trimf",[1, 3, 5],Name="Média Baixa");
fis = addMF(fis,"Sujeira","trapmf",[4, 6, 5, 10],Name="Média");
fis = addMF(fis,"Sujeira","trapmf",[8, 10, 11, 12],Name="Alta");

fis = addMF(fis,"Quantidade de Sabão em Pó","trimf",[0, 10, 20],Name="Muito Pouco");
fis = addMF(fis,"Quantidade de Sabão em Pó","trimf",[20, 30, 40],Name="Pouco");
fis = addMF(fis,"Quantidade de Sabão em Pó","trimf",[40, 50, 60],Name="Moderado");
fis = addMF(fis,"Quantidade de Sabão em Pó","trimf",[60, 70, 80],Name="Exagerado");
fis = addMF(fis,"Quantidade de Sabão em Pó","trapmf",[80, 90, 100, 120],Name="Muito Exagerado");

% Definindo as regras [peso sujeira sabao peso operação]
baseRegras = [
    1, 1, 1, 1, 1;
    1, 2, 2, 1, 1;
    1, 3, 3, 1, 1;
    1, 4, 4, 1, 1;

    2, 1, 2, 1, 1;
    2, 2, 2, 1, 1;
    2, 3, 3, 1, 1;
    2, 4, 4, 1, 1;
    
    3, 1, 3, 1, 1;
    3, 2, 3, 1, 1;
    3, 3, 4, 1, 1;
    3, 4, 4, 1, 1;

    4, 1, 3, 1, 1;
    4, 2, 4, 1, 1;
    4, 3, 5, 1, 1;
    4, 4, 5, 1, 1;
    ];

fis = addRule(fis, baseRegras);

% Inputs
peso = [1, 7.8];
sujeira = [1.5, 8.2];

% Saída
fis.DefuzzificationMethod = 'mom';
sabao = [evalfis(fis, [peso(1), sujeira(1)]), evalfis(fis, [peso(2), sujeira(2)])];
sabao