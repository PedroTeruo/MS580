% EXERCÍCIO 2.7.4
fis_274 = mamfis(Name="Taxa de Infecção: Coronavírus");

% Definindo os domínios
fis_274 = addInput(fis_274,[0, 1],Name="Medidas de Proteção");
fis_274 = addInput(fis_274,[0, 1],Name="Isolamento Social");
fis_274 = addOutput(fis_274,[0, 1],Name="Taxa de Infecção");

% Definindo as faixas de pertinência
fis_274 = addMF(fis_274,"Medidas de Proteção","trapmf",[0, 0, 0.04, 0.36],Name="Inadequada");
fis_274 = addMF(fis_274,"Medidas de Proteção","trapmf",[0.14, 0.46, 0.54, 0.86],Name="Média");
fis_274 = addMF(fis_274,"Medidas de Proteção","trapmf",[0.64, 0.96, 1, 1],Name="Eficiente");

fis_274 = addMF(fis_274,"Isolamento Social","trapmf",[0, 0, 0.04, 0.26],Name="Pequeno");
fis_274 = addMF(fis_274,"Isolamento Social","trapmf",[0.14, 0.46, 0.54, 0.86],Name="Médio");
fis_274 = addMF(fis_274,"Isolamento Social","trapmf",[0.74, 0.96, 1, 1],Name="Grande");

fis_274 = addMF(fis_274,"Taxa de Infecção","trapmf",[0, 0, 0.03, 0.1],Name="Baixa");
fis_274 = addMF(fis_274,"Taxa de Infecção","trapmf",[0.06, 0.47, 0.59, 0.98],Name="Média");
fis_274 = addMF(fis_274,"Taxa de Infecção","trapmf",[0.94, 0.99, 1, 1],Name="Alta");

% Definindo as regras [medidas, isolamento, taxa, peso, operação]
baseRegras_274 = [
    1, 1, 3, 1, 1;
    1, 2, 3, 1, 1;
    1, 3, 2, 1, 1;
    2, 1, 3, 1, 1;
    2, 2, 2, 1, 1;
    2, 3, 1, 1, 1;
    3, 1, 2, 1, 1;
    3, 2, 1, 1, 1;
    3, 3, 1, 1, 1;
];

fis_274 = addRule(fis_274, baseRegras_274);

% Inputs de teste (10 amostras dentro do domínio [0, 1])
medidas_in   = [0.10, 0.80, 0.30, 0.50, 0.70, 0.90, 0.20, 0.40, 0.85, 0.05];
isolamento_in = [0.10, 0.20, 0.50, 0.50, 0.80, 0.90, 0.85, 0.15, 0.40, 0.95];

n_amostras = length(medidas_in);
taxas = zeros(1, n_amostras);
classificacoes = strings(n_amostras, 1);

% Processamento e exibição por amostra
for k = 1:n_amostras
    m_in = medidas_in(k);
    i_in = isolamento_in(k);

    % 1. FUZZIFICAÇÃO
    mu_medidas   = zeros(1, 3);
    mu_isolamento = zeros(1, 3);

    for i = 1:3
        mu_medidas(i)   = evalmf(fis_274.Inputs(1).MembershipFunctions(i), m_in);
        mu_isolamento(i) = evalmf(fis_274.Inputs(2).MembershipFunctions(i), i_in);
    end

    % 2. DEFUZZIFICAÇÃO VIA EVALFIS
    taxas(k) = evalfis(fis_274, [m_in, i_in]);

    % 3. CLASSIFICAÇÃO LINGUÍSTICA
    if taxas(k) < 0.30
        classificacoes(k) = "Baixa";
    elseif taxas(k) <= 0.70
        classificacoes(k) = "Média";
    else
        classificacoes(k) = "Alta";
    end

    % EXIBIÇÃO DOS RESULTADOS POR AMOSTRA
    fprintf('--- AMOSTRA %d ---\n', k);
    fprintf('Entradas: Medidas de Proteção = %g | Isolamento Social = %g\n', m_in, i_in);

    fprintf('1. GRAUS DE PERTINÊNCIA:\n');
    fprintf('   Medidas de Proteção -> Inadequada: %.3f | Média: %.3f | Eficiente: %.3f\n', ...
        mu_medidas(1), mu_medidas(2), mu_medidas(3));
    fprintf('   Isolamento Social   -> Pequeno: %.3f | Médio: %.3f | Grande: %.3f\n', ...
        mu_isolamento(1), mu_isolamento(2), mu_isolamento(3));

    fprintf('2. REGRAS ATIVADAS:\n');
    nRegras = size(baseRegras_274, 1);
    for r = 1:nRegras
        idx_medidas   = baseRegras_274(r, 1);
        idx_isolamento = baseRegras_274(r, 2);
        alpha = min(mu_medidas(idx_medidas), mu_isolamento(idx_isolamento));

        if alpha > 0
            fprintf('   - Regra %d ativada com alpha = %.4f\n', r, alpha);
        end
    end

    fprintf('3. DEFUZZIFICAÇÃO:\n');
    fprintf('   Taxa de Infecção = %.4f (%s)\n\n', taxas(k), classificacoes(k));
end

% TABELA RESUMO FINAL
fprintf('=========================================================================\n');
fprintf('RESUMO DOS RESULTADOS\n');
fprintf('=========================================================================\n');
T = table((1:n_amostras)', medidas_in', isolamento_in', taxas', classificacoes, ...
    'VariableNames', {'Amostra', 'Medidas_Protecao', 'Isolamento_Social', 'Taxa_Infeccao', 'Classificacao'});
disp(T);

% Gráficos das Funções de Pertinência
if false
    figure;
    plotmf(fis_274, "input", 1);
    title("Funções de pertinência das Medidas de Proteção");

    figure;
    plotmf(fis_274, "input", 2);
    title("Funções de pertinência do Isolamento Social");

    figure;
    plotmf(fis_274, "output", 1);
    title("Funções de pertinência da Taxa de Infecção");
end

% Gráfico da Superfície de Saída com as 10 Amostras
if true
    figure;
    gensurf(fis_274);
    hold on;

    title("Superfície de saída do FIS");
    xlabel("Medidas de Proteção");
    ylabel("Isolamento Social");
    zlabel("Taxa de Infecção");
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
    cData(zData > 0.30 & zData <= 0.70) = 2;
    cData(zData > 0.70) = 3;

    set(surfHandle, ...
        "CData", cData, ...
        "FaceColor", "flat", ...
        "EdgeColor", [0 0 0], ...
        "LineWidth", 0.3, ...
        "FaceAlpha", 0.5);

    colormap([0.20 0.70 0.20;
              0.95 0.85 0.20;
              0.85 0.20 0.20]);

    clim([1 3]);
    cb = colorbar;
    cb.Ticks = [1 2 3];
    cb.TickLabels = ["Baixa" "Média" "Alta"];

    % Plotagem dos 10 pontos amostrados na superfície
    scatter3(medidas_in, isolamento_in, taxas, 80, "k", "filled");
    hold off;
end