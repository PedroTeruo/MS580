% EXERCÍCIO: LAVADEIRA
fis_lavadeira = mamfis(Name="Lavadeira");

% Definindo os domínios
fis_lavadeira = addInput(fis_lavadeira,[-2, 12],Name="Peso");
fis_lavadeira = addInput(fis_lavadeira,[-2, 12],Name="Sujeira");
fis_lavadeira = addOutput(fis_lavadeira,[0, 120],Name="Quantidade de Sabão em Pó");

% Definindo as faixas de pertinência (Corrigidas conforme enunciado)
fis_lavadeira = addMF(fis_lavadeira,"Peso","trapmf",[-2, -1, 0, 2],Name="Muito Leve");
fis_lavadeira = addMF(fis_lavadeira,"Peso","trimf",[1, 3, 5],Name="Leve");
fis_lavadeira = addMF(fis_lavadeira,"Peso","trapmf",[4, 5, 6.5, 9],Name="Pesado");
fis_lavadeira = addMF(fis_lavadeira,"Peso","trapmf",[8, 9, 11, 12],Name="Muito Pesado");

fis_lavadeira = addMF(fis_lavadeira,"Sujeira","trapmf",[-2, -1, 0, 2],Name="Quase Limpo");
fis_lavadeira = addMF(fis_lavadeira,"Sujeira","trimf",[1, 3, 5],Name="Sujo");
fis_lavadeira = addMF(fis_lavadeira,"Sujeira","trapmf",[4, 5, 6.5, 10],Name="Muito Sujo");
fis_lavadeira = addMF(fis_lavadeira,"Sujeira","trapmf",[8, 10, 11, 12],Name="Extra Sujo");

fis_lavadeira = addMF(fis_lavadeira,"Quantidade de Sabão em Pó","trimf",[0, 10, 20],Name="Muito Pouco");
fis_lavadeira = addMF(fis_lavadeira,"Quantidade de Sabão em Pó","trimf",[20, 30, 40],Name="Pouco");
fis_lavadeira = addMF(fis_lavadeira,"Quantidade de Sabão em Pó","trimf",[40, 50, 60],Name="Moderado");
fis_lavadeira = addMF(fis_lavadeira,"Quantidade de Sabão em Pó","trimf",[60, 70, 80],Name="Exagerado");
fis_lavadeira = addMF(fis_lavadeira,"Quantidade de Sabão em Pó","trapmf",[80, 90, 100, 120],Name="Máximo");

% Definindo a matriz de regras [peso, sujeira, sabao, peso_regra, operação]
baseRegras_lavadeira = [
    1, 1, 1, 1, 1;  % Muito Leve, Quase Limpo -> Muito Pouco
    1, 2, 2, 1, 1;  % Muito Leve, Sujo -> Pouco
    1, 3, 3, 1, 1;  % Muito Leve, Muito Sujo -> Moderado
    1, 4, 3, 1, 1;  % Muito Leve, Extra Sujo -> Moderado

    2, 1, 2, 1, 1;  % Leve, Quase Limpo -> Pouco
    2, 2, 2, 1, 1;  % Leve, Sujo -> Pouco
    2, 3, 3, 1, 1;  % Leve, Muito Sujo -> Moderado
    2, 4, 4, 1, 1;  % Leve, Extra Sujo -> Exagerado
    
    3, 1, 3, 1, 1;  % Pesado, Quase Limpo -> Moderado
    3, 2, 3, 1, 1;  % Pesado, Sujo -> Moderado
    3, 3, 4, 1, 1;  % Pesado, Muito Sujo -> Exagerado
    3, 4, 4, 1, 1;  % Pesado, Extra Sujo -> Exagerado

    4, 1, 3, 1, 1;  % Muito Pesado, Quase Limpo -> Moderado
    4, 2, 4, 1, 1;  % Muito Pesado, Sujo -> Exagerado
    4, 3, 5, 1, 1;  % Muito Pesado, Muito Sujo -> Máximo
    4, 4, 5, 1, 1;  % Muito Pesado, Extra Sujo -> Máximo
];

fis_lavadeira = addRule(fis_lavadeira, baseRegras_lavadeira);

% Método de Defuzzificação por Centro de Gravidade (Centroid)
fis_lavadeira.DefuzzificationMethod = 'centroid';

% Inputs de teste (10 amostras cobrindo os testes do enunciado)
peso_in    = [1.0, 7.8, 0.0, 3.0, 5.0, 6.5, 9.0, 2.0, 8.5, 11.0];
sujeira_in = [1.5, 8.2, 0.0, 3.0, 2.0, 6.0, 9.5, 7.0, 4.0, 10.5];

n_amostras = length(peso_in);
sabao = zeros(1, n_amostras);
classificacoes = strings(n_amostras, 1);

% Processamento e exibição por amostra
for k = 1:n_amostras
    p_in = peso_in(k);
    s_in = sujeira_in(k);

    % 1. FUZZIFICAÇÃO
    mu_peso    = zeros(1, 4);
    mu_sujeira = zeros(1, 4);

    for i = 1:4
        mu_peso(i)    = evalmf(fis_lavadeira.Inputs(1).MembershipFunctions(i), p_in);
        mu_sujeira(i) = evalmf(fis_lavadeira.Inputs(2).MembershipFunctions(i), s_in);
    end

    % 2. DEFUZZIFICAÇÃO VIA EVALFIS
    sabao(k) = evalfis(fis_lavadeira, [p_in, s_in]);

    % 3. CLASSIFICAÇÃO LINGUÍSTICA
    if sabao(k) < 20
        classificacoes(k) = "Muito Pouco";
    elseif sabao(k) <= 40
        classificacoes(k) = "Pouco";
    elseif sabao(k) <= 60
        classificacoes(k) = "Moderado";
    elseif sabao(k) <= 80
        classificacoes(k) = "Exagerado";
    else
        classificacoes(k) = "Máximo";
    end

    % EXIBIÇÃO DOS RESULTADOS POR AMOSTRA
    fprintf('--- AMOSTRA %d ---\n', k);
    fprintf('Entradas: Peso = %g kg | Sujeira = %g\n', p_in, s_in);

    fprintf('1. GRAUS DE PERTINÊNCIA:\n');
    fprintf('   Peso    -> Muito Leve: %.3f | Leve: %.3f | Pesado: %.3f | Muito Pesado: %.3f\n', ...
        mu_peso(1), mu_peso(2), mu_peso(3), mu_peso(4));
    fprintf('   Sujeira -> Quase Limpo: %.3f | Sujo: %.3f | Muito Sujo: %.3f | Extra Sujo: %.3f\n', ...
        mu_sujeira(1), mu_sujeira(2), mu_sujeira(3), mu_sujeira(4));

    fprintf('2. REGRAS ATIVADAS:\n');
    nRegras = size(baseRegras_lavadeira, 1);
    nAtivadas = 0;
    for r = 1:nRegras
        idx_peso    = baseRegras_lavadeira(r, 1);
        idx_sujeira = baseRegras_lavadeira(r, 2);
        alpha = min(mu_peso(idx_peso), mu_sujeira(idx_sujeira));

        if alpha > 0
            nAtivadas = nAtivadas + 1;
            fprintf('   - Regra %d ativada com alpha = %.4f\n', r, alpha);
        end
    end
    fprintf('   Total de regras ativadas: %d\n', nAtivadas);

    fprintf('3. DEFUZZIFICAÇÃO:\n');
    fprintf('   Sabão em Pó = %.4f ml (%s)\n\n', sabao(k), classificacoes(k));
end

% TABELA RESUMO FINAL
fprintf('=========================================================================\n');
fprintf('RESUMO DOS RESULTADOS\n');
fprintf('=========================================================================\n');
T = table((1:n_amostras)', peso_in', sujeira_in', sabao', classificacoes, ...
    'VariableNames', {'Amostra', 'Peso_kg', 'Sujeira', 'Sabao_ml', 'Classificacao'});
disp(T);

% Gráficos das Funções de Pertinência
if false
    figure;
    plotmf(fis_lavadeira, "input", 1);
    title("Funções de pertinência de Peso");

    figure;
    plotmf(fis_lavadeira, "input", 2);
    title("Funções de pertinência de Sujeira");

    figure;
    plotmf(fis_lavadeira, "output", 1);
    title("Funções de pertinência da Quantidade de Sabão em Pó");
end

% Gráfico da Superfície de Saída com as 10 Amostras
if true
    figure;
    gensurf(fis_lavadeira);
    hold on;

    title("Superfície de saída do FIS - Lavadeira");
    xlabel("Peso (kg)");
    ylabel("Sujeira");
    zlabel("Sabão em Pó (ml)");
    grid on;
    box on;

    ax = gca;
    ax.XGrid = "on";
    ax.YGrid = "on";
    ax.ZGrid = "on";
    ax.GridAlpha = 0.3;
    ax.GridLineStyle = "--";

    surfHandle = findobj(gca, "Type", "Surface");
    zData = surfHandle.ZData;

    cData = ones(size(zData));
    cData(zData > 25 & zData <= 50) = 2;
    cData(zData > 50 & zData <= 75) = 3;
    cData(zData > 75) = 4;

    set(surfHandle, ...
        "CData", cData, ...
        "FaceColor", "flat", ...
        "EdgeColor", [0 0 0], ...
        "LineWidth", 0.3, ...
        "FaceAlpha", 0.5);

    colormap([0.20 0.70 0.20;
              0.95 0.85 0.20;
              0.85 0.50 0.20;
              0.85 0.20 0.20]);

    clim([1 4]);
    cb = colorbar;
    cb.Ticks = [1 2 3 4];
    cb.TickLabels = ["Pouco" "Moderado" "Exagerado" "Máximo"];

    % Plotagem dos 10 pontos amostrados na superfície
    scatter3(peso_in, sujeira_in, sabao, 80, "k", "filled");
    hold off;
end