import pandas as pd
import skfuzzy as fuzzy
import numpy as np
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

#EXERCÍCIO 2.7.2

#---------------------------------------------------------
# Definindo os domínios
massa = ctrl.Antecedent(np.arange(47, 82, 0.1), 'Massa')
altura = ctrl.Antecedent(np.arange(157, 184, 1), 'Altura')
grau_risco = ctrl.Consequent(np.arange(18, 36, 1), 'Grau de Risco')

#---------------------------------------------------------
# Definindo as faixas de pertinência
massa['Baixa'] = fuzzy.trapmf(massa.universe, [47, 47, 55, 64])
massa['Média Baixa'] = fuzzy.trimf(massa.universe, [50, 59, 68])
massa['Média'] = fuzzy.trimf(massa.universe, [53, 62.5, 72])
massa['Média Alta'] = fuzzy.trimf(massa.universe, [56, 66.5, 77])
massa['Alta'] = fuzzy.trapmf(massa.universe, [59, 70, 81, 81])

altura['Baixa'] = fuzzy.trapmf(altura.universe, [157, 157, 160, 163])
altura['Média Baixa'] = fuzzy.trimf(altura.universe, [162, 165, 168])
altura['Média'] = fuzzy.trimf(altura.universe, [167, 170, 173])
altura['Média Alta'] = fuzzy.trimf(altura.universe, [172, 175, 178])
altura['Alta'] = fuzzy.trapmf(altura.universe, [177, 180, 183, 183])

grau_risco['Saudável'] = fuzzy.trapmf(grau_risco.universe, [18, 18, 23, 35])
grau_risco['Moderado'] = fuzzy.trapmf(grau_risco.universe, [24, 25, 27, 30])
grau_risco['Alto'] = fuzzy.trapmf(grau_risco.universe, [29, 30, 35, 35])

#---------------------------------------------------------
# Salvando os gráficos em png
'''
massa.view()
altura.view()
grau_risco.view()
'''
#---------------------------------------------------------
# Definindo as regras
r1 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Saudável'])
r2 = ctrl.Rule(massa['Baixa'] & altura['Média Baixa'], grau_risco['Saudável'])
r3 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Saudável'])
r4 = ctrl.Rule(massa['Baixa'] & altura['Média Alta'], grau_risco['Saudável'])
r5 = ctrl.Rule(massa['Baixa'] & altura['Alta'], grau_risco['Saudável'])

r6 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Moderado'])
r7 = ctrl.Rule(massa['Baixa'] & altura['Média Baixa'], grau_risco['Saudável'])
r8 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Saudável'])
r9 = ctrl.Rule(massa['Baixa'] & altura['Média Alta'], grau_risco['Saudável'])
r10 = ctrl.Rule(massa['Baixa'] & altura['Alta'], grau_risco['Saudável'])

r11 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Moderado'])
r12 = ctrl.Rule(massa['Baixa'] & altura['Média Baixa'], grau_risco['Moderado'])
r13 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Saudável'])
r14 = ctrl.Rule(massa['Baixa'] & altura['Média Alta'], grau_risco['Saudável'])
r15 = ctrl.Rule(massa['Baixa'] & altura['Alta'], grau_risco['Saudável'])

r16 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Moderado'])
r17 = ctrl.Rule(massa['Baixa'] & altura['Média Baixa'], grau_risco['Moderado'])
r18 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Moderado'])
r19 = ctrl.Rule(massa['Baixa'] & altura['Média Alta'], grau_risco['Saudável'])
r20 = ctrl.Rule(massa['Baixa'] & altura['Alta'], grau_risco['Saudável'])

r21 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Alto'])
r22 = ctrl.Rule(massa['Baixa'] & altura['Média Baixa'], grau_risco['Moderado'])
r23 = ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Moderado'])
r24 = ctrl.Rule(massa['Baixa'] & altura['Média Alta'], grau_risco['Moderado'])
r25 = ctrl.Rule(massa['Baixa'] & altura['Alta'], grau_risco['Saudável'])

conjunto_regras = [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25]
#---------------------------------------------------------
# Criando o sistema de regras do controle
grau_risco_ctrl = ctrl.ControlSystem(conjunto_regras)
grau_risco_simulacao = ctrl.ControlSystemSimulation(grau_risco_ctrl)

#---------------------------------------------------------
# Inputs
grau_risco_simulacao.input['Massa'] = 59.0  # (float(input()))
grau_risco_simulacao.input['Altura'] = 164 # (int(input()))

#---------------------------------------------------------
# Saída
grau_risco_simulacao.compute()
print(grau_risco_simulacao.output['Grau de Risco'])
# ERRO de ~1