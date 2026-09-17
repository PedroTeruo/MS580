% EXERCÍCIO 2.7.3
fis_273 = mamfis(Name="Qualidade da Água");

% Definindo os domínios
fis_273 = addInput(fis_273,[0 30],Name="Cor Aparente");
fis_273 = addInput(fis_273,[0 14],Name="pH");
fis_273 = addInput(fis_273,[0 10],Name="Turbidez");
fis_273 = addOutput(fis_273,[0 1],Name="Qualidade da Água");

% Definindo as faixas de pertinência
fis_273 = addMF(fis_273,"Cor Aparente","trapmf",[0 0 5 15],Name="Boa");
fis_273 = addMF(fis_273,"Cor Aparente","trapmf",[5 15 15 30],Name="Adequada");
fis_273 = addMF(fis_273,"Cor Aparente","trapmf",[15 30 30 30],Name="Inadequada");

fis_273 = addMF(fis_273,"pH","trapmf",[0 0 0 6],Name="Inadequado Baixo");
fis_273 = addMF(fis_273,"pH","trapmf",[0 6 6 6.5],Name="Adequado Baixo");
fis_273 = addMF(fis_273,"pH","trapmf",[6.5 6.5 8.5 8.5],Name="Bom");
fis_273 = addMF(fis_273,"pH","trapmf",[8.5 10 10 14],Name="Adequado Alto");
fis_273 = addMF(fis_273,"pH","trapmf",[10 14 14 14],Name="Inadequado Alto");

fis_273 = addMF(fis_273,"Turbidez","trapmf",[0 0 1 5],Name="Boa");
fis_273 = addMF(fis_273,"Turbidez","trapmf",[1 5 5 10],Name="Adequada");
fis_273 = addMF(fis_273,"Turbidez","trapmf",[5 10 10 10],Name="Inadequada");

fis_273 = addMF(fis_273,"Qualidade da Água","trapmf",[0 0 0.2 0.5],Name="Inadequada");
fis_273 = addMF(fis_273,"Qualidade da Água","trapmf",[0.2 0.5 0.5 0.8],Name="Adequada");
fis_273 = addMF(fis_273,"Qualidade da Água","trapmf",[0.5 0.8 1 1],Name="Boa");

% Definindo as regras [Cor, pH, turbidez, qualidade, peso, operação]
ruleList_273 = [
    % 1. Se pH for Inadequado Baixo ou Inadequado Alto, a Qualidade é Inadequada
    0 1 0 1 1 1;
    0 5 0 1 1 1;

    % 2. Se a Cor Aparente OU a Turbidez forem Inadequadas, a Qualidade é Inadequada
    3 0 0 1 1 1;
    0 0 3 1 1 1;

    % 3. Condições para Qualidade BOA:
    % Cor Boa, pH Bom, Turbidez Boa
    1 3 1 3 1 1;

    % 4. Condições para Qualidade ADEQUADA:
    % pH Bom com combinação de termos Adequados em Cor e Turbidez
    1 3 2 2 1 1;
    2 3 1 2 1 1;
    2 3 2 2 1 1;
    
    % pH Adequado Baixo ou Adequado Alto com Cor e Turbidez de Boas a Adequadas
    1 2 1 2 1 1;
    1 2 2 2 1 1;
    2 2 1 2 1 1;
    2 2 2 2 1 1;
    1 4 1 2 1 1;
    1 4 2 2 1 1;
    2 4 1 2 1 1;
    2 4 2 2 1 1;
    ];

fis_273 = addRule(fis_273, ruleList_273);

% Inputs
cor = 15;
pH = 7;
turbidez = 0;

% Saída
qualidade = evalfis(fis_273, [cor pH turbidez]);