import pandas as pd
import skfuzzy as fuzzy
import numpy as np
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

#EXERCÍCIO 2.7.2

#---------------------------------------------------------
# Definindo os domínios
cor_aparente = ctrl.Antecedent(np.arange(47, 82, 0.1), 'Cor Aparente')
ph = ctrl.Antecedent(np.arange(0, 15, 1), 'pH')
turbidez = ctrl.Antecedent(np.arange(157, 184, 1), 'Turbidez')
qualidade_agua = ctrl.Consequent(np.arange(18, 36, 1), 'Qualidade da Água')

#---------------------------------------------------------
# Definindo as faixas de pertinência
cor_aparente['Boa'] = fuzzy.trapmf(cor_aparente.universe, [0, 0, 4, 6])
cor_aparente['Adequada'] = fuzzy.trapmf(cor_aparente.universe, [4, 6, 14, 16])
cor_aparente['Inadequada'] = fuzzy.trapmf(cor_aparente.universe, [14, 16, 30, 30])

ph['Bom'] = fuzzy.trapmf(cor_aparente.universe, [56, 66.5, 77])
ph['Adequado'] = fuzzy.trapmf(cor_aparente.universe, [59, 70, 81, 81])
ph['Inadequado'] = fuzzy.trapmf(ph.universe, [157, 157, 160, 163])

turbidez['Boa'] = fuzzy.trimf(ph.universe, [162, 165, 168])
turbidez['Adequada'] = fuzzy.trapmf(ph.universe, [167, 170, 173])
turbidez['Inadequada'] = fuzzy.trapmf(ph.universe, [172, 175, 178])

qualidade_agua['Boa'] = fuzzy.trapmf(qualidade_agua.universe, [18, 18, 23, 35])
qualidade_agua['Adequada'] = fuzzy.trapmf(qualidade_agua.universe, [24, 25, 27, 30])
qualidade_agua['Inadequada'] = fuzzy.trapmf(qualidade_agua.universe, [29, 30, 35, 35])

#---------------------------------------------------------
# Salvando os gráficos em png
'''
cor_aparente.view()
ph.view()
turbidez.view()
qualidade_agua.view()
'''
#---------------------------------------------------------
# Definindo as regras
r1 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Saudável'])
r2 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Baixa'], qualidade_agua['Saudável'])
r3 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Saudável'])
r4 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Alta'], qualidade_agua['Saudável'])
r5 = ctrl.Rule(cor_aparente['Baixa'] & ph['Alta'], qualidade_agua['Saudável'])

r6 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Moderado'])
r7 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Baixa'], qualidade_agua['Saudável'])
r8 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Saudável'])
r9 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Alta'], qualidade_agua['Saudável'])
r10 = ctrl.Rule(cor_aparente['Baixa'] & ph['Alta'], qualidade_agua['Saudável'])

r11 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Moderado'])
r12 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Baixa'], qualidade_agua['Moderado'])
r13 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Saudável'])
r14 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Alta'], qualidade_agua['Saudável'])
r15 = ctrl.Rule(cor_aparente['Baixa'] & ph['Alta'], qualidade_agua['Saudável'])

r16 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Moderado'])
r17 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Baixa'], qualidade_agua['Moderado'])
r18 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Moderado'])
r19 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Alta'], qualidade_agua['Saudável'])
r20 = ctrl.Rule(cor_aparente['Baixa'] & ph['Alta'], qualidade_agua['Saudável'])

r21 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Alto'])
r22 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Baixa'], qualidade_agua['Moderado'])
r23 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média'], qualidade_agua['Moderado'])
r24 = ctrl.Rule(cor_aparente['Baixa'] & ph['Média Alta'], qualidade_agua['Moderado'])
r25 = ctrl.Rule(cor_aparente['Baixa'] & ph['Alta'], qualidade_agua['Saudável'])

conjunto_regras = [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25]
#---------------------------------------------------------
# Criando o sistema de regras do controle
qualidade_agua_ctrl = ctrl.ControlSystem(conjunto_regras)
qualidade_agua_simulacao = ctrl.ControlSystemSimulation(qualidade_agua_ctrl)

#---------------------------------------------------------
# Inputs
qualidade_agua_simulacao.input['Cor Aparente'] = 59.0  # (float(input()))
qualidade_agua_simulacao.input['pH'] = 0
qualidade_agua_simulacao.input['Turbidez'] = 164 # (int(input()))

#---------------------------------------------------------
# Saída
qualidade_agua_simulacao.compute()
print(qualidade_agua_simulacao.output['Qualidade da Água'])