import pandas as pd;
import skfuzzy as fuzzy;
import numpy as np;
from skfuzzy import control as ctrl;
import matplotlib.pyplot as plt;

#EXERCÍCIO 2.7.2

#---------------------------------------------------------
# Definindo os domínios

massa = ctrl.Antecedent(np.arange(47, 81.1, 0.1), 'Massa');
altura = ctrl.Antecedent(np.arange(157, 184, 1), 'Altura');
grau_risco = ctrl.Consequent(np.arange(18, 36, 1), 'Grau de Risco');

#---------------------------------------------------------
# Definindo as faixas de pertinência

massa['Baixa'] = fuzzy.trapmf(massa.universe, [47, 47, 55, 64]);
massa['Média Baixa'] = fuzzy.trimf(massa.universe, [50, 59, 68]);
massa['Média'] = fuzzy.trimf(massa.universe, [53, 62.5, 72]);
massa['Média Alta'] = fuzzy.trimf(massa.universe, [56, 66.5, 77]);
massa['Alta'] = fuzzy.trapmf(massa.universe, [59, 70, 81, 81]);

altura['Baixa'] = fuzzy.trapmf(altura.universe, [157, 157, 160, 163]);
altura['Média Baixa'] = fuzzy.trimf(altura.universe, [162, 165, 168]);
altura['Média'] = fuzzy.trimf(altura.universe, [167, 170, 173]);
altura['Média Alta'] = fuzzy.trimf(altura.universe, [172, 175, 178]);
altura['Alta'] = fuzzy.trapmf(altura.universe, [177, 180, 183, 183]);

grau_risco['Saudável'] = fuzzy.trapmf(grau_risco.universe, [18, 18, 23, 25]);
grau_risco['Moderado'] = fuzzy.trapmf(grau_risco.universe, [24, 25, 27, 30]);
grau_risco['Alto'] = fuzzy.trapmf(grau_risco.universe, [29, 30, 35, 35]);

#---------------------------------------------------------
# Salvando os gráficos em png
'''
massa.view();
altura.view();
grau_risco.view();
'''
#---------------------------------------------------------
# Definindo as regras

conjunto_regras = [];

conjunto_regras.append(ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Baixa'] & altura['Média Baixa'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Baixa'] & altura['Média'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Baixa'] & altura['Média Alta'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Baixa'] & altura['Alta'], grau_risco['Saudável']));

conjunto_regras.append(ctrl.Rule(massa['Média Baixa'] & altura['Média'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Média Baixa'] & altura['Média Baixa'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Média Baixa'] & altura['Média'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Média Baixa'] & altura['Média Alta'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Média Baixa'] & altura['Alta'], grau_risco['Saudável']));

conjunto_regras.append(ctrl.Rule(massa['Média'] & altura['Média'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Média'] & altura['Média Baixa'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Média'] & altura['Média'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Média'] & altura['Média Alta'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Média'] & altura['Alta'], grau_risco['Saudável']));

conjunto_regras.append(ctrl.Rule(massa['Média Alta'] & altura['Média'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Média Alta'] & altura['Média Baixa'], grau_risco['Moderado']));
conjunto_regras.append( ctrl.Rule(massa['Média Alta'] & altura['Média'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Média Alta'] & altura['Média Alta'], grau_risco['Saudável']));
conjunto_regras.append(ctrl.Rule(massa['Média Alta'] & altura['Alta'], grau_risco['Saudável']));

conjunto_regras.append(ctrl.Rule(massa['Alta'] & altura['Média'], grau_risco['Alto']));
conjunto_regras.append(ctrl.Rule(massa['Alta'] & altura['Média Baixa'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Alta'] & altura['Média'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Alta'] & altura['Média Alta'], grau_risco['Moderado']));
conjunto_regras.append(ctrl.Rule(massa['Alta'] & altura['Alta'], grau_risco['Saudável']));

#---------------------------------------------------------
# Criando o sistema de regras do controle

grau_risco_ctrl = ctrl.ControlSystem(conjunto_regras);
grau_risco_simulacao = ctrl.ControlSystemSimulation(grau_risco_ctrl);

#---------------------------------------------------------
# Inputs

grau_risco_simulacao.input['Massa'] = 59.0;  # (float(input()))
grau_risco_simulacao.input['Altura'] = 164; # (int(input()))

#---------------------------------------------------------
# Saída

grau_risco_simulacao.compute();
print(grau_risco_simulacao.output['Grau de Risco']);
# ERRO de ~0.5