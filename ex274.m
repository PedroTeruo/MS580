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

% Inputs
medidas = 0.1;
isolamento = 0.1;

% Saída
taxa = evalfis(fis_274, [medidas, isolamento]);

% Gráficos

if(false) % Funções de Pertinência
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

if(true) % Saída em Função dos Inputs
    figure
    gensurf(fis_274)
    hold on

    title("Superfície de saída do FIS")
    xlabel("Medidas de Proteção")
    ylabel("Isolamento Social")
    zlabel("Taxa de Infecção")
    grid on
    box on

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

    scatter3(medidas, isolamento, taxa, 80, "k", "filled")
    hold off
end