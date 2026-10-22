% EXERCÍCIO 2.7.3
fis_273 = mamfis(Name="Qualidade da Água");

% Definindo os domínios
fis_273 = addInput(fis_273,[0, 30],Name="Cor Aparente");
fis_273 = addInput(fis_273,[0, 14],Name="pH");
fis_273 = addInput(fis_273,[0, 10],Name="Turbidez");
fis_273 = addOutput(fis_273,[0, 1],Name="Qualidade da Água");

% Definindo as faixas de pertinência
fis_273 = addMF(fis_273,"Cor Aparente","trapmf",[0, 0, 4, 6],Name="Boa");
fis_273 = addMF(fis_273,"Cor Aparente","trapmf",[4, 6, 14, 16],Name="Adequada");
fis_273 = addMF(fis_273,"Cor Aparente","trapmf",[14, 16, 30, 30],Name="Inadequada");

fis_273 = addMF(fis_273,"pH","trapmf",[0, 0, 5.3, 6],Name="Inadequado Baixo");
fis_273 = addMF(fis_273,"pH","trapmf",[5.6, 6, 6.3, 6.5],Name="Adequado Baixo");
fis_273 = addMF(fis_273,"pH","trapmf",[6.3, 6.7, 8.5, 9],Name="Bom");
fis_273 = addMF(fis_273,"pH","trapmf",[8.5, 9, 9.6, 10],Name="Adequado Alto");
fis_273 = addMF(fis_273,"pH","trapmf",[9.5, 10, 14, 14],Name="Inadequado Alto");

fis_273 = addMF(fis_273,"Turbidez","trapmf",[0, 0, 0.5, 1.5],Name="Boa");
fis_273 = addMF(fis_273,"Turbidez","trapmf",[0.5, 1.5, 4.5, 5.5],Name="Adequada");
fis_273 = addMF(fis_273,"Turbidez","trapmf",[4.5, 5.5, 10, 10],Name="Inadequada");

fis_273 = addMF(fis_273,"Qualidade da Água","trapmf",[0, 0, 0.4, 0.5],Name="Inadequada");
fis_273 = addMF(fis_273,"Qualidade da Água","trapmf",[0.4, 0.5, 0.7, 0.8],Name="Adequada");
fis_273 = addMF(fis_273,"Qualidade da Água","trapmf",[0.7, 0.8, 1, 1],Name="Boa");

% Definindo as regras [Cor, pH, turbidez, qualidade, peso, operação]
baseRegras_273 = [
    0, 1, 0, 1, 1, 1;
    0, 5, 0, 1, 1, 1;

    3, 0, 0, 1, 1, 1;
    0, 0, 3, 1, 1, 1;

    1, 3, 1, 3, 1, 1;

    1, 3, 2, 2, 1, 1;
    2, 3, 1, 2, 1, 1;
    2, 3, 2, 2, 1, 1;
    
    1, 2, 1, 2, 1, 1;
    1, 2, 2, 2, 1, 1;
    2, 2, 1, 2, 1, 1;
    2, 2, 2, 2, 1, 1;
    1, 4, 1, 2, 1, 1;
    1, 4, 2, 2, 1, 1;
    2, 4, 1, 2, 1, 1;
    2, 4, 2, 2, 1, 1;
    ];

fis_273 = addRule(fis_273, baseRegras_273);

% Inputs
cor = 15;
pH = 7;
turbidez = 0;

% Saída
qualidade = evalfis(fis_273, [cor, pH, turbidez]);

if(false) % Funções de Pertinência
    figure;
    plotmf(fis_273, "input", 1);
    title("Funções de pertinência de Cor Aparente");

    figure;
    plotmf(fis_273, "input", 2);
    title("Funções de pertinência de pH");

    figure;
    plotmf(fis_273, "input", 3);
    title("Funções de pertinência de Turbidez");

    figure;
    plotmf(fis_273, "output", 1);
    title("Funções de pertinência de Qualidade");
end