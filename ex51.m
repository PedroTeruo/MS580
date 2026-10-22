% Exercício 5.1
fis = mamfis(Name="Exercício 5.1");

% Definindo os domínios
fis = addInput(fis,[1 4],Name="A1");
fis = addInput(fis,[5 8],Name="A2");
fis = addOutput(fis,[3 6],Name="B");

% Definindo as faixas de pertinência
fis = addMF(fis,"A1","trimf",[1 2 3],Name="Baixo");
fis = addMF(fis,"A1","trimf",[2 3 4],Name="Alto");

fis = addMF(fis,"A2","trimf",[5 6 7],Name="Baixo");
fis = addMF(fis,"A2","trimf",[6 7 8],Name="Alto");

fis = addMF(fis,"B","trimf",[3 4 5],Name="Baixo");
fis = addMF(fis,"B","trimf",[4 5 6],Name="Alto");

% Definindo as regras [peso sujeira sabao peso operação]
baseRegras = [
    1 1 2 1 1
    2 2 1 1 1
    ];

fis = addRule(fis, baseRegras);

% Inputs
x = 2.3;
y = 6.8;

% Saída
fis.DefuzzificationMethod = 'mom';
z = evalfis(fis, [x y]);
z