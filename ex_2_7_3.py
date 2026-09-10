import pandas as pd;
import skfuzzy as fuzzy;
import numpy as np;
from skfuzzy import control as ctrl;
import matplotlib.pyplot as plt;

#EXERCÍCIO 2.7.2

#---------------------------------------------------------
# Definindo os domínios

cor_aparente = ctrl.Antecedent(np.arange(0, 31, 1), 'Cor Aparente');
ph = ctrl.Antecedent(np.arange(0, 14.1, 0.1), 'pH');
turbidez = ctrl.Antecedent(np.arange(0, 10.1, 0.1), 'Turbidez');
qualidade_agua = ctrl.Consequent(np.arange(0, 1.1, 0.1), 'Qualidade da Água');

#---------------------------------------------------------
# Definindo as faixas de pertinência

cor_aparente['Boa'] = fuzzy.trapmf(cor_aparente.universe, [0, 0, 4, 6]);
cor_aparente['Adequada'] = fuzzy.trapmf(cor_aparente.universe, [4, 6, 14, 16]);
cor_aparente['Inadequada'] = fuzzy.trapmf(cor_aparente.universe, [14, 16, 30, 30]);

ph['Inadequado Baixo'] = fuzzy.trapmf(ph.universe, [0, 0, 5.3,6 ]);
ph['Adequado Baixo'] = fuzzy.trapmf(ph.universe, [5.6, 6, 6.3, 6.5]);
ph['Bom'] = fuzzy.trapmf(ph.universe, [6.3, 6.7, 8.5, 9]);
ph['Adequado Alto'] = fuzzy.trapmf(ph.universe, [8.5, 8.9, 9.6, 10]);
ph['Inadequado Alto'] = fuzzy.trapmf(ph.universe, [9.6, 10 ,14 ,14 ]);

turbidez['Boa'] = fuzzy.trapmf(turbidez.universe, [0, 0, 0.5, 1.5]);
turbidez['Adequada'] = fuzzy.trapmf(turbidez.universe, [0.5, 1.5, 4.5, 5.5]);
turbidez['Inadequada'] = fuzzy.trapmf(turbidez.universe, [4.5, 5.5, 10, 10]);

qualidade_agua['Boa'] = fuzzy.trapmf(qualidade_agua.universe, [0, 0, 0.4, 0.5]);
qualidade_agua['Adequada'] = fuzzy.trapmf(qualidade_agua.universe, [0.4, 0.5, 0.7, 0.8]);
qualidade_agua['Inadequada'] = fuzzy.trapmf(qualidade_agua.universe, [0.7, 0.8, 1, 1]);

#---------------------------------------------------------
# Salvando os gráficos em png
'''
cor_aparente.view();
ph.view();
turbidez.view();
qualidade_agua.view();
'''
#---------------------------------------------------------
# Definindo as regras

conjunto_regras = [];

conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Baixo'] & turbidez['Boa'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Baixo'] & turbidez['Adequada'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Bom'] & turbidez['Boa'], qualidade_agua['Boa']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Bom'] & turbidez['Adequada'], qualidade_agua['Boa']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Bom'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Alto'] & turbidez['Boa'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Alto'] & turbidez['Adequada'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));

conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Baixo'] & turbidez['Boa'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Baixo'] & turbidez['Adequada'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Bom'] & turbidez['Boa'], qualidade_agua['Boa']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Bom'] & turbidez['Adequada'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Bom'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Alto'] & turbidez['Boa'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Alto'] & turbidez['Adequada'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));

conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Bom'] & turbidez['Boa'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Bom'] & turbidez['Adequada'], qualidade_agua['Adequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Bom'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']));
conjunto_regras.append(ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']));

#---------------------------------------------------------
# Criando o sistema de regras do controle

qualidade_agua_ctrl = ctrl.ControlSystem(conjunto_regras);
qualidade_agua_simulacao = ctrl.ControlSystemSimulation(qualidade_agua_ctrl);

#---------------------------------------------------------
# Inputs

qualidade_agua_simulacao.input['Cor Aparente'] = 15;  # (float(input()))
qualidade_agua_simulacao.input['pH'] = 7;             # (float(input()))
qualidade_agua_simulacao.input['Turbidez'] = 0;       # (float(input()))

#---------------------------------------------------------
# Saída

qualidade_agua_simulacao.compute();
print(qualidade_agua_simulacao.output['Qualidade da Água']);
# ERRO de ~0.12