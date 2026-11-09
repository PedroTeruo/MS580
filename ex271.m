% EXERCÍCIO 2.7.1
fis_271 = mamfis(Name="Vitalidade das Violetas");

% Definindo os domínios
fis_271 = addInput(fis_271,[0, 66],Name="Água");
fis_271 = addInput(fis_271,[0, 95],Name="Sol");
fis_271 = addOutput(fis_271,[0, 1],Name="Vitalidade");

% Definindo as faixas de pertinência
fis_271 = addMF(fis_271,"Água","trimf",[0, 0, 26],Name="Pequena");
fis_271 = addMF(fis_271,"Água","trimf",[13, 33, 53],Name="Média");
fis_271 = addMF(fis_271,"Água","trimf",[40, 66, 66],Name="Grande");

fis_271 = addMF(fis_271,"Sol","trimf",[0, 0, 35],Name="Pequeno");
fis_271 = addMF(fis_271,"Sol","trimf",[20, 45, 70],Name="Médio");
fis_271 = addMF(fis_271,"Sol","trimf",[55, 95, 95],Name="Grande");

fis_271 = addMF(fis_271,"Vitalidade","trimf",[0, 0, 0.3],Name="Ruim");
fis_271 = addMF(fis_271,"Vitalidade","trimf",[0.1, 0.5, 0.9],Name="Média");
fis_271 = addMF(fis_271,"Vitalidade","trimf",[0.7, 1, 1],Name="Boa");

% Base de regras
baseRegras_271 = [
    1, 1, 2, 1, 1;
    1, 2, 2, 1, 1;
    1, 3, 1, 1, 1;
    
    2, 1, 3, 1, 1;
    2, 2, 3, 1, 1;
    2, 3, 2, 1, 1;

    3, 1, 3, 1, 1;
    3, 2, 3, 1, 1;
    3, 3, 3, 1, 1;
];

fis_271 = addRule(fis_271, baseRegras_271);

% Inputs de teste
agua_in = [10, 20, 30, 40, 50, 60, 5, 25, 45, 65];
sol_in  = [15, 30, 45, 60, 75, 90, 10, 50, 70, 85];

n_amostras = length(agua_in);

vitalidades = zeros(1, n_amostras);

% Saída
for k = 1:n_amostras
    a_in = agua_in(k);
    s_in = sol_in(k);

    % 1. FUZZIFICAÇÃO
    mu_agua = zeros(1, 3);
    mu_sol  = zeros(1, 3);

    for i = 1:3
        mu_agua(i) = evalmf(fis_271.Inputs(1).MembershipFunctions(i), a_in);
        mu_sol(i)  = evalmf(fis_271.Inputs(2).MembershipFunctions(i), s_in);
    end

    % 2. DEFUZZIFICAÇÃO VIA EVALFIS
    vitalidades(k) = evalfis(fis_271, [a_in, s_in]);

    % EXIBIÇÃO DOS RESULTADOS POR AMOSTRA
    fprintf('--- AMOSTRA %d ---\n', k);
    fprintf('Entradas: Água = %g ml | Sol = %g min\n', a_in, s_in);

    fprintf('1. GRAUS DE PERTINÊNCIA:\n');
    fprintf('   Água -> Pequena: %.3f | Média: %.3f | Grande: %.3f\n', mu_agua(1), mu_agua(2), mu_agua(3));
    fprintf('   Sol  -> Pequeno: %.3f | Médio: %.3f | Grande: %.3f\n', mu_sol(1), mu_sol(2), mu_sol(3));

    fprintf('2. REGRAS ATIVADAS:\n');
    nRegras = size(baseRegras_271, 1);
    for r = 1:nRegras
        idx_agua = baseRegras_271(r, 1);
        idx_sol  = baseRegras_271(r, 2);
        alpha = min(mu_agua(idx_agua), mu_sol(idx_sol));

        if alpha > 0
            fprintf('   - Regra %d ativada com alpha = %.4f\n', r, alpha);
        end
    end

    fprintf('3. DEFUZZIFICAÇÃO:\n');
    fprintf('   Vitalidade = %.4f\n\n', vitalidades(k));
end

% TABELA RESUMO FINAL
fprintf('=========================================================\n');
fprintf('RESUMO DOS RESULTADOS\n');
fprintf('=========================================================\n');
T = table((1:n_amostras)', agua_in', sol_in', vitalidades', ...
    'VariableNames', {'Amostra', 'Agua_ml', 'Sol_min', 'Vitalidade'});
disp(T);

% Gráficos
if false % Funções de pertinência
    figure;
    plotmf(fis_271, "input", 1);
    title("Funções de pertinência de Água");

    figure;
    plotmf(fis_271, "input", 2);
    title("Funções de pertinência de Sol");

    figure;
    plotmf(fis_271, "output", 1);
    title("Funções de pertinência de Vitalidade");
end

if true % Saída em função dos inputs
    figure;
    gensurf(fis_271);
    hold on;

    title("Superfície de saída do FIS");
    xlabel("Água");
    ylabel("Sol");
    zlabel("Vitalidade");
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
    cData(zData > 0.33 & zData <= 0.66) = 2;
    cData(zData > 0.66) = 3;

    set(surfHandle, ...
        "CData", cData, ...
        "FaceColor", "flat", ...
        "EdgeColor", [0 0 0], ...
        "LineWidth", 0.3, ...
        "FaceAlpha", 0.5)

    colormap([0.20 0.70 0.20;
        0.95 0.85 0.20;
        0.85 0.20 0.20])

    clim([1 3])
    cb = colorbar;
    cb.Ticks = [1 2 3];
    cb.TickLabels = ["Baixa" "Média" "Alta"];

    scatter3(agua_in, sol_in, vitalidades, 80, "k", "filled")
    hold off;
end