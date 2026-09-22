import skfuzzy as fuzz
import skfuzzy.control as ctrl
import numpy as np
import matplotlib.pyplot as plt

u = np.linspace(0, 500, 500)
v = np.linspace(-500, 500, 500)


# P-fuzzy system instance

pop = ctrl.Antecedent(u, "population")
speed = ctrl.Consequent(v, "increase-rate")

pop['low'] = fuzz.trapmf(pop.universe, [0, 0, 25, 50])
pop['lowmid'] = fuzz.trimf(pop.universe, [25, 50, 75])
pop['medium'] = fuzz.trimf(pop.universe, [50, 75, 125])
pop['highmid'] = fuzz.trimf(pop.universe, [75, 125, 375])
pop['high'] = fuzz.trapmf(pop.universe, [375, 450, 500, 500])

speed['nhigh'] = fuzz.trapmf(speed.universe, [-500, -500, -375, -250])
speed['nmedium'] = fuzz.trimf(speed.universe, [-375, -250, -125])
speed['nlow'] = fuzz.trimf(speed.universe, [-125, -50, 25])
speed['plow'] = fuzz.trimf(speed.universe, [-25, 50, 125])
speed['pmedium'] = fuzz.trimf(speed.universe, [125, 250, 375])
speed['phigh'] = fuzz.trapmf(speed.universe, [250, 375, 500, 500])


rule0 = ctrl.Rule(antecedent=(pop['low']),
                  consequent=speed['plow'], label='rule low')

rule1 = ctrl.Rule(antecedent=(pop['lowmid']),
                  consequent=speed['phigh'], label='rule low mid')

rule2 = ctrl.Rule(antecedent=(pop['medium']),
                  consequent=speed['plow'], label='rule medium')

rule3 = ctrl.Rule(antecedent=(pop['highmid']),
                  consequent=speed['nlow'], label='rule high mid')

rule4 = ctrl.Rule(antecedent=(pop['high']),
                  consequent=speed['nmedium'], label='rule high')

system = ctrl.ControlSystem(rules=[rule0, rule1, rule2, rule3, rule4])
sim = ctrl.ControlSystemSimulation(system, flush_after_run=21 * 21 + 1)


# Finite diference PVI approximation

tf = 2
n = 200
h = tf/n
time = np.linspace(0, tf, n)

p = np.zeros_like(time)
p[0] = 10

for i in range(n - 1):
    sim.input['population'] = p[i]
    sim.compute()
    p[i + 1] = p[i] + h * sim.output['increase-rate']

fig, ax = plt.subplots()
ax.set_xlabel('t')
ax.set_ylabel('P')
ax.set_title('P(t)')
ax.grid(True)
line1, = ax.plot(time, p)
# ax.plot(time, p, 'bo', markersize=5)
plt.show()

