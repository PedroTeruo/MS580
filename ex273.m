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

% Definindo as regras [Cor, pH, Turbidez, Qualidade, Peso, Operação]
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

% Inputs de teste (10 amostras de Cor Aparente, pH e Turbidez)
cor_in      = [ 2, 15, 20,  5,  8, 10,  3, 12, 18, 25];
ph_in       = [7.0, 7.0, 4.5, 6.2, 8.8, 7.5, 9.8, 6.0, 7.0, 11.0];
turbidez_in = [0.2, 0.0, 2.0, 1.0, 3.0, 6.0, 0.8, 4.0, 8.0, 0.5];

n_amostras = length(cor_in);
qualidades = zeros(1, n_amostras);
classificacoes = strings(n_amostras, 1);

% Processamento e exibição por amostra
for k = 1:n_amostras
    c_in = cor_in(k);
    p_in = ph_in(k);
    t_in = turbidez_in(k);

    % 1. FUZZIFICAÇÃO
    mu_cor = zeros(1, 3);
    for i = 1:3
        mu_cor(i) = evalmf(fis_273.Inputs(1).MembershipFunctions(i), c_in);
    end

    mu_ph = zeros(1, 5);
    for i = 1:5
        mu_ph(i) = evalmf(fis_273.Inputs(2).MembershipFunctions(i), p_in);
    end

    mu_turbidez = zeros(1, 3);
    for i = 1:3
        mu_turbidez(i) = evalmf(fis_273.Inputs(3).MembershipFunctions(i), t_in);
    end

    % 2. DEFUZZIFICAÇÃO VIA EVALFIS
    qualidades(k) = evalfis(fis_273, [c_in, p_in, t_in]);

    % 3. CLASSIFICAÇÃO LINGUÍSTICA
    if qualidades(k) < 0.5
        classificacoes(k) = "Inadequada";
    elseif qualidades(k) <= 0.7
        classificacoes(k) = "Adequada";
    else
        classificacoes(k) = "Boa";
    end

    % EXIBIÇÃO DOS RESULTADOS POR AMOSTRA
    fprintf('--- AMOSTRA %d ---\n', k);
    fprintf('Entradas: Cor = %g UH | pH = %g | Turbidez = %g UT\n', c_in, p_in, t_in);

    fprintf('1. GRAUS DE PERTINÊNCIA:\n');
    fprintf('   Cor Aparente -> Boa: %.3f | Adequada: %.3f | Inadequada: %.3f\n', ...
        mu_cor(1), mu_cor(2), mu_cor(3));
    fprintf('   pH           -> Inadeq. Baixo: %.3f | Adeq. Baixo: %.3f | Bom: %.3f | Adeq. Alto: %.3f | Inadeq. Alto: %.3f\n', ...
        mu_ph(1), mu_ph(2), mu_ph(3), mu_ph(4), mu_ph(5));
    fprintf('   Turbidez     -> Boa: %.3f | Adequada: %.3f | Inadequada: %.3f\n', ...
        mu_turbidez(1), mu_turbidez(2), mu_turbidez(3));

    fprintf('2. REGRAS ATIVADAS:\n');
    nRegras = size(baseRegras_273, 1);
    for r = 1:nRegras
        idx_cor  = baseRegras_273(r, 1);
        idx_ph   = baseRegras_273(r, 2);
        idx_turb = baseRegras_273(r, 3);

        alpha_cor  = 1; if idx_cor  > 0, alpha_cor  = mu_cor(idx_cor); end
        alpha_ph   = 1; if idx_ph   > 0, alpha_ph   = mu_ph(idx_ph); end
        alpha_turb = 1; if idx_turb > 0, alpha_turb = mu_turbidez(idx_turb); end

        alpha = min([alpha_cor, alpha_ph, alpha_turb]);

        if alpha > 0
            fprintf('   - Regra %d ativada com alpha = %.4f\n', r, alpha);
        end
    end

    fprintf('3. DEFUZZIFICAÇÃO:\n');
    fprintf('   Qualidade da Água = %.4f (%s)\n\n', qualidades(k), classificacoes(k));
end

% TABELA RESUMO FINAL
fprintf('=========================================================================\n');
fprintf('RESUMO DOS RESULTADOS\n');
fprintf('=========================================================================\n');
T = table((1:n_amostras)', cor_in', ph_in', turbidez_in', qualidades', classificacoes, ...
    'VariableNames', {'Amostra', 'Cor_UH', 'pH', 'Turbidez_UT', 'Qualidade', 'Classificação'});
disp(T);

% GRÁFICO DA SAÍDA DAS 10 AMOSTRAS
figure;
hold on; grid on; box on;

% Faixas de classificação no fundo do gráfico
rectangle('Position', [0.5, 0.0, 10, 0.45], 'FaceColor', [0.95 0.80 0.80], 'EdgeColor', 'none'); % Inadequada
rectangle('Position', [0.5, 0.45, 10, 0.30], 'FaceColor', [0.98 0.95 0.75], 'EdgeColor', 'none'); % Adequada
rectangle('Position', [0.5, 0.75, 10, 0.25], 'FaceColor', [0.80 0.93 0.80], 'EdgeColor', 'none'); % Boa

% Linha ligando os pontos e plotagem dos marcadores
plot(1:n_amostras, qualidades, '--k', 'LineWidth', 1.2);
scatter(1:n_amostras, qualidades, 100, 'k', 'filled');

% Adiciona os rótulos de valores em cada ponto
for k = 1:n_amostras
    text(k, qualidades(k) + 0.03, sprintf('%.3f', qualidades(k)), ...
        'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 9);
end

title('Saídas Defuzzificadas da Qualidade da Água para as 10 Amostras');
xlabel('Número da Amostra');
ylabel('Qualidade da Água (Q)');
xlim([0.5, 10.5]);
ylim([0, 1]);
xticks(1:10);

% Legendas das faixas
legend('', '', '', 'Trajetória', 'Amostra Defuzzificada', 'Location', 'northeastoutside');
hold off;