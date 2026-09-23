import pandas as pd
import skfuzzy as fuzzy
import numpy as np
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

#EXERCÍCIO 2.7.1

#---------------------------------------------------------
# Definindo os domínios

agua = ctrl.Antecedent(np.arange(0, 67, 1), 'agua');
sol = ctrl.Antecedent(np.arange(0, 96, 1), 'sol');
vitalidade = ctrl.Consequent(np.arange(0, 1.01, 0.01), 'vitalidade');

#---------------------------------------------------------
# Definindo as faixas de pertinência

agua['pequena'] = fuzzy.trimf(agua.universe, [0, 0, 26]);
agua['media'] = fuzzy.trimf(agua.universe, [13, 33, 53]);
agua['grande'] = fuzzy.trimf(agua.universe, [40, 66, 66]);
sol['pequeno'] = fuzzy.trimf(sol.universe, [0, 0, 35]);
sol['medio'] = fuzzy.trimf(sol.universe, [20, 45, 70]);
sol['grande'] = fuzzy.trimf(sol.universe, [55, 95, 95]);
vitalidade['ruim'] = fuzzy.trimf(vitalidade.universe, [0, 0, 0.3]);
vitalidade['media'] = fuzzy.trimf(vitalidade.universe, [0.1, 0.5, 0.9]);
vitalidade['boa'] = fuzzy.trimf(vitalidade.universe, [0.7, 1, 1]);

#---------------------------------------------------------
# Salvando os gráficos em png
'''
agua.view();
sol.view();
vitalidade.view();
'''
#---------------------------------------------------------
# Definindo as regras

r1 = ctrl.Rule(agua['pequena'] & sol['pequeno'], vitalidade['media']);
r2 = ctrl.Rule(agua['pequena'] & sol['medio'], vitalidade['media']);
r3 = ctrl.Rule(agua['pequena'] & sol['grande'], vitalidade['ruim']);
r4 = ctrl.Rule(agua['media'] & sol['pequeno'], vitalidade['boa']);
r5 = ctrl.Rule(agua['media'] & sol['medio'], vitalidade['boa']);
r6 = ctrl.Rule(agua['media'] & sol['grande'], vitalidade['media']);
r7 = ctrl.Rule(agua['grande'] & sol['pequeno'], vitalidade['ruim']);
r8 = ctrl.Rule(agua['grande'] & sol['medio'], vitalidade['ruim']);
r9 = ctrl.Rule(agua['grande'] & sol['grande'], vitalidade['ruim']);

#---------------------------------------------------------
# Criando o sistema de regras do controle

vitalidade_ctrl = ctrl.ControlSystem([r1, r2, r3, r4, r5, r6, r7, r8, r9]);
vitalidade_simulacao = ctrl.ControlSystemSimulation(vitalidade_ctrl);

#---------------------------------------------------------
# Inputs

vitalidade_simulacao.input['agua'] = 40;
vitalidade_simulacao.input['sol'] = 60;

#---------------------------------------------------------
# Saída

vitalidade_simulacao.compute();
print(vitalidade_simulacao.output['vitalidade']);
# ERRO de ~0.2