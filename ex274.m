% EXERCÍCIO 2.7.4
fis_274 = mamfis(Name="Taxa de Infecção: Coronavírus");

% Definindo os domínios
fis_274 = addInput(fis_274,[0 1],Name="Medidas de Proteção");
fis_274 = addInput(fis_274,[0 1],Name="Isolamento Social");
fis_274 = addOutput(fis_274,[0 1],Name="Taxa de Infecção");

% Definindo as faixas de pertinência
fis_274 = addMF(fis_274,"Medidas de Proteção","trapmf",[0 0 0.04 0.36],Name="Inadequada");
fis_274 = addMF(fis_274,"Medidas de Proteção","trapmf",[0.14 0.46 0.54 0.86],Name="Média");
fis_274 = addMF(fis_274,"Medidas de Proteção","trapmf",[0.64 0.96 1 1],Name="Eficiente");

fis_274 = addMF(fis_274,"Isolamento Social","trapmf",[0 0 0.04 0.26],Name="Pequeno");
fis_274 = addMF(fis_274,"Isolamento Social","trapmf",[0.14 0.46 0.54 0.86],Name="Médio");
fis_274 = addMF(fis_274,"Isolamento Social","trapmf",[0.74 0.96 1 1],Name="Grande");

fis_274 = addMF(fis_274,"Taxa de Infecção","trapmf",[0 0 0.03 0.1],Name="Baixa");
fis_274 = addMF(fis_274,"Taxa de Infecção","trapmf",[0.06 0.47 0.59 0.98],Name="Média");
fis_274 = addMF(fis_274,"Taxa de Infecção","trapmf",[0.94 0.99 1 1],Name="Alta");

% Definindo as regras [medidas, isolamento, taxa, peso, operação]
ruleList_274 = [
    1 1 3 1 1;
    1 2 3 1 1;
    1 3 2 1 1;
    2 1 3 1 1;
    2 2 2 1 1;
    2 3 1 1 1;
    3 1 2 1 1;
    3 2 1 1 1;
    3 3 1 1 1;
    ];

fis_274 = addRule(fis_274, ruleList_274);

% Inputs
medidas = 0.1;
isolamento = 0.1;

% Saída
taxa = evalfis(fis_274, [medidas isolamento]);