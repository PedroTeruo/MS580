%% EXERCICIO 6
% PVI:
% y'(t) = 0.2*y(t)*(100-y(t))
% y(0) = 10

clear;
clc;
close all;

%% Criacao do sistema fuzzy
fis = mamfis("Name","Sistema_p_fuzzy");

fis = addInput(fis,[0 100],"Name","y");

% Muito Baixo
fis = addMF(fis,"y","trapmf",[0 0 10 25], ...
    "Name","MuitoBaixo");

% Baixo
fis = addMF(fis,"y","trimf",[10 30 50], ...
    "Name","Baixo");

% Medio
fis = addMF(fis,"y","trimf",[30 50 70], ...
    "Name","Medio");

% Alto
fis = addMF(fis,"y","trimf",[50 70 90], ...
    "Name","Alto");

% Muito Alto
fis = addMF(fis,"y","trapmf",[75 90 100 100], ...
    "Name","MuitoAlto");

fis = addOutput(fis,[0 500],"Name","dy");

% Muito Baixa
fis = addMF(fis,"dy","trapmf",[0 0 30 80], ...
    "Name","MuitoBaixa");

% Baixa
fis = addMF(fis,"dy","trimf",[30 100 180], ...
    "Name","Baixa");

% Media
fis = addMF(fis,"dy","trimf",[100 220 340], ...
    "Name","Media");

% Alta
fis = addMF(fis,"dy","trimf",[250 350 450], ...
    "Name","Alta");

% Muito Alta
fis = addMF(fis,"dy","trapmf",[380 450 500 500], ...
    "Name","MuitoAlta");

rules = [...
    1 5 1 1;
    2 4 1 1;
    3 3 1 1;
    4 2 1 1;
    5 1 1 1];

fis = addRule(fis,rules);

%% 2. Metodo de Euler p-fuzzy
h = 0.01;
t_final = 1;
t = 0:h:t_final;
N = length(t);
y = zeros(1,N);
dy = zeros(1,N);
y(1) = 10;
dominio = [0, 100];

for n = 1:N-1
    dy(n) = evalfis(fis,y(n));
    y(n+1) = y(n) + h*dy(n);

    if y(n+1) > dominio(2)
        y(n+1) = dominio(2);
    elseif y(n+1) < dominio(1)
        y(n+1) = dominio(1);
    end
end

dy(N) = evalfis(fis,y(N));

%% 3. Solucao exata para comparacao
y_exata = 100 ./ (1 + 9*exp(-20*t));

%% 4. Tabela com 20 valores

fprintf('   Solução Numérica por P-Fuzzy\n');
fprintf('   n        t              y_n\n');

indices = round(linspace(1,N,20));
for k = 1:20
    i = indices(k);
    fprintf('%4d     %7.4f       %10.6f\n', ...
        k-1,t(i),y(i));
end

%% 6. Grafico somente da solucao p-fuzzy

figure('Color','w');
plot(t,y,'b','LineWidth',2);
grid on;
box on;

ax = gca;
ax.Color = 'w';
ax.XColor = 'k';
ax.YColor = 'k';
ax.GridColor = 'k';

xlabel('t', 'Color', 'k');
ylabel('y_n', 'Color', 'k');
title('Solução numérica - Método p-fuzzy', 'Color', 'k');
ylim([0 105]);
