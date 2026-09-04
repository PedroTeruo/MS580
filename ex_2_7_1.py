import pandas as pd
import skfuzzy as fuzzy
import numpy as np
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

#Fazendo o exercicio 2.7.1 da atividade
agua = ctrl.Antecedent(np.arange(0, 71, 1), 'Água')
sol = ctrl.Antecedent(np.arange(0, 91, 1), 'Sol')
vitalidade = ctrl.Consequent(np.arange(0, 101, 1), 'Vitalidade')

agua['Pequena'] = fuzzy.trimf(agua.universe, [0, 0, 26])
agua['Média'] = fuzzy.trimf(agua.universe, [13, 33, 53])
agua['Grande'] = fuzzy.trimf(agua.universe, [40, 70, 70])
sol['Pequeno'] = fuzzy.trimf(sol.universe, [0, 0, 35])
sol['Médio'] = fuzzy.trimf(sol.universe, [20, 45, 70])
sol['Grande'] = fuzzy.trimf(sol.universe, [55, 90, 90])
vitalidade['Ruim'] = fuzzy.trimf(vitalidade.universe, [0, 0, 30])
vitalidade['Média'] = fuzzy.trimf(vitalidade.universe, [10, 50, 90])
vitalidade['Boa'] = fuzzy.trimf(vitalidade.universe, [70, 100, 100])

agua.view()
sol.view()
vitalidade.view()

r1 = ctrl.Rule(agua['Pequena'] & sol['Pequeno'], vitalidade['Média'])
r2 = ctrl.Rule(agua['Pequena'] & sol['Médio'], vitalidade['Média'])
r3 = ctrl.Rule(agua['Pequena'] & sol['Grande'], vitalidade['Ruim'])
r4 = ctrl.Rule(agua['Média'] & sol['Pequeno'], vitalidade['Boa'])
r5 = ctrl.Rule(agua['Média'] & sol['Médio'], vitalidade['Boa'])
r6 = ctrl.Rule(agua['Média'] & sol['Grande'], vitalidade['Média'])
r7 = ctrl.Rule(agua['Grande'] & sol['Pequeno'], vitalidade['Ruim'])
r8 = ctrl.Rule(agua['Grande'] & sol['Médio'], vitalidade['Ruim'])
r9 = ctrl.Rule(agua['Grande'] & sol['Grande'], vitalidade['Ruim'])

vitalidade_ctrl = ctrl.ControlSystem([r1, r2, r3, r4, r5, r6, r7, r8, r9])
vitalidade_simulacao = ctrl.ControlSystemSimulation(vitalidade_ctrl)

vitalidade_simulacao.input['Água'] = 40 # (int(input()))
vitalidade_simulacao.input['Sol'] = 60  # (int(input()))

vitalidade_simulacao.compute()
print(vitalidade_simulacao.output['Vitalidade'])