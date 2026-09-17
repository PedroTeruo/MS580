% EXERCÍCIO 2.7.2
fis_272 = mamfis(Name="Grau de Risco de Obesidade");

% Definindo os domínios
fis_272 = addInput(fis_272,[47 81],Name="Massa");
fis_272 = addInput(fis_272,[157 183],Name="Altura");
fis_272 = addOutput(fis_272,[18 35],Name="Grau");

% Definindo as faixas de pertinência
fis_272 = addMF(fis_272,"Massa","trapmf",[47 47 55.5 64],Name="Baixa");
fis_272 = addMF(fis_272,"Massa","trimf",[50 59 68],Name="Média Baixa");
fis_272 = addMF(fis_272,"Massa","trimf",[53 62.5 72],Name="Média");
fis_272 = addMF(fis_272,"Massa","trimf",[56 66.5 77],Name="Média Alta");
fis_272 = addMF(fis_272,"Massa","trapmf",[59 70 81 81],Name="Alta");

fis_272 = addMF(fis_272,"Altura","trapmf",[157 157 160 163],Name="Baixa");
fis_272 = addMF(fis_272,"Altura","trimf",[162 165 168],Name="Média Baixa");
fis_272 = addMF(fis_272,"Altura","trimf",[167 170 173],Name="Média");
fis_272 = addMF(fis_272,"Altura","trimf",[172 175 178],Name="Média Alta");
fis_272 = addMF(fis_272,"Altura","trapmf",[177 180 183 183],Name="Alta");

fis_272 = addMF(fis_272,"Grau","trapmf",[18 18 22.5 25],Name="Saudável");
fis_272 = addMF(fis_272,"Grau","trapmf",[24 25.5 28 30],Name="Moderado");
fis_272 = addMF(fis_272,"Grau","trapmf",[29 30.5 35 35],Name="Alto");

% Definindo as regras [massa altura grau peso operação]
ruleList_272 = [
    1 1 1 1 1  % Massa Baixa, Altura Baixa -> Saudável
    1 2 2 1 1  % Massa Baixa, Altura Média Baixa -> Moderado
    1 3 2 1 1  % Massa Baixa, Altura Média -> Moderado
    1 4 2 1 1  % Massa Baixa, Altura Média Alta -> Moderado
    1 5 3 1 1  % Massa Baixa, Altura Alta -> Alto
    
    2 1 1 1 1  % Massa Média Baixa, Altura Baixa -> Saudável
    2 2 1 1 1  % Massa Média Baixa, Altura Média Baixa -> Saudável
    2 3 2 1 1  % Massa Média Baixa, Altura Média -> Moderado
    2 4 2 1 1  % Massa Média Baixa, Altura Média Alta -> Moderado
    2 5 2 1 1  % Massa Média Baixa, Altura Alta -> Moderado
    
    3 1 1 1 1  % Massa Média, Altura Baixa -> Saudável
    3 2 1 1 1  % Massa Média, Altura Média Baixa -> Saudável
    3 3 1 1 1  % Massa Média, Altura Média -> Saudável
    3 4 2 1 1  % Massa Média, Altura Média Alta -> Moderado
    3 5 2 1 1  % Massa Média, Altura Alta -> Moderado
    
    4 1 1 1 1  % Massa Média Alta, Altura Baixa -> Saudável
    4 2 1 1 1  % Massa Média Alta, Altura Média Baixa -> Saudável
    4 3 1 1 1  % Massa Média Alta, Altura Média -> Saudável
    4 4 1 1 1  % Massa Média Alta, Altura Média Alta -> Saudável
    4 5 2 1 1  % Massa Média Alta, Altura Alta -> Moderado
    
    5 1 1 1 1  % Massa Alta, Altura Baixa -> Saudável
    5 2 1 1 1  % Massa Alta, Altura Média Baixa -> Saudável
    5 3 1 1 1  % Massa Alta, Altura Média -> Saudável
    5 4 1 1 1  % Massa Alta, Altura Média Alta -> Saudável
    5 5 1 1 1  % Massa Alta, Altura Alta -> Saudável
];

fis_272 = addRule(fis_272, ruleList_272);

% Inputs
massa = 59;
altura = 164;

% Saída
grau = evalfis(fis_272, [massa altura]);