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
ph['Adequado Baixo'] = fuzzy.trapmf(cor_aparente.universe, [5.6, 6, 6.3, 6.5);
ph['Bom'] = fuzzy.trapmf(cor_aparente.universe, [6.3, 6.7, 8.5, 9]);
ph['Adequado Alto'] = fuzzy.trapmf(cor_aparente.universe, [8.5, 8.9, 9.6, 10]);
ph['Inadequado Alto'] = fuzzy.trapmf(ph.universe, [9.6, 10 ,14 ,14 ]);

turbidez['Boa'] = fuzzy.trapmf(ph.universe, [0, 0, 0.5, 1.5]);
turbidez['Adequada'] = fuzzy.trapmf(ph.universe, [0.5, 1.5, 4.5, 5.5]);
turbidez['Inadequada'] = fuzzy.trapmf(ph.universe, [4.5, 5.5, 10, 10]);

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
r1 = ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r2 = ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r3 = ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r4 = ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Baixo'] & turbidez['Boa'], qualidade_agua['Adequada']);
r5 = ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Baixo'] & turbidez['Adequada'], qualidade_agua['Adequada']);
r6 = ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r7 = ctrl.Rule(cor_aparente['Boa'] & ph['Bom'] & turbidez['Boa'], qualidade_agua['Boa']);
r8 = ctrl.Rule(cor_aparente['Boa'] & ph['Bom'] & turbidez['Adequada'], qualidade_agua['Boa']);
r9 = ctrl.Rule(cor_aparente['Boa'] & ph['Bom'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r10 = ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Alto'] & turbidez['Boa'], qualidade_agua['Adequada']);
r11 = ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Alto'] & turbidez['Adequada'], qualidade_agua['Adequada']);
r12 = ctrl.Rule(cor_aparente['Boa'] & ph['Adequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r13 = ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r14 = ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r15 = ctrl.Rule(cor_aparente['Boa'] & ph['Inadequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);

r16 = ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r17 = ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r18 = ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r19 = ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Baixo'] & turbidez['Boa'], qualidade_agua['Adequada']);
r20 = ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Baixo'] & turbidez['Adequada'], qualidade_agua['Adequada']);
r21 = ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r22 = ctrl.Rule(cor_aparente['Adequada'] & ph['Bom'] & turbidez['Boa'], qualidade_agua['Boa']);
r23 = ctrl.Rule(cor_aparente['Adequada'] & ph['Bom'] & turbidez['Adequada'], qualidade_agua['Adequada']);
r24 = ctrl.Rule(cor_aparente['Adequada'] & ph['Bom'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r25 = ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Alto'] & turbidez['Boa'], qualidade_agua['Adequada']);
r26 = ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Alto'] & turbidez['Adequada'], qualidade_agua['Adequada']);
r27 = ctrl.Rule(cor_aparente['Adequada'] & ph['Adequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r28 = ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r29 = ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r30 = ctrl.Rule(cor_aparente['Adequada'] & ph['Inadequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);

r31 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r32 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r33 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r34 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Baixo'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r35 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Baixo'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r36 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Baixo'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r37 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Bom'] & turbidez['Boa'], qualidade_agua['Adequada']);
r38 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Bom'] & turbidez['Adequada'], qualidade_agua['Adequada']);
r39 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Bom'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r40 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r41 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r42 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Adequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);
r43 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Alto'] & turbidez['Boa'], qualidade_agua['Inadequada']);
r44 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Alto'] & turbidez['Adequada'], qualidade_agua['Inadequada']);
r45 = ctrl.Rule(cor_aparente['Inadequada'] & ph['Inadequado Alto'] & turbidez['Inadequada'], qualidade_agua['Inadequada']);

conjunto_regras = [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12];
#---------------------------------------------------------
# Criando o sistema de regras do controle
qualidade_agua_ctrl = ctrl.ControlSystem(conjunto_regras);
qualidade_agua_simulacao = ctrl.ControlSystemSimulation(qualidade_agua_ctrl);

#---------------------------------------------------------
# Inputs
qualidade_agua_simulacao.input['Cor Aparente'] = 15;  # (float(input()))
qualidade_agua_simulacao.input['pH'] = 7;
qualidade_agua_simulacao.input['Turbidez'] = 0; # (int(input()))

#---------------------------------------------------------
# Saída
qualidade_agua_simulacao.compute();
print(qualidade_agua_simulacao.output['Qualidade da Água']);