import skfuzzy.control as ctrl
import numpy as np
import matplotlib.pyplot as plt

u = np.linspace(0, 100, 20)
v = np.linspace(0, 500, 20)


# P-fuzzy system instance

pop = ctrl.Antecedent(u, "population")
speed = ctrl.Consequent(v, "increase-rate")

names = ['ze', 'ps', 'pb']
pop.automf(names=names)
speed.automf(names=names)


rule0 = ctrl.Rule(antecedent=(pop['ze']),
                  consequent=speed['pb'], label='rule ze')

rule1 = ctrl.Rule(antecedent=(pop['ps']),
                  consequent=speed['ps'], label='rule ps')

rule2 = ctrl.Rule(antecedent=(pop['pb']),
                  consequent=speed['pb'], label='rule pb')

system = ctrl.ControlSystem(rules=[rule0, rule1, rule2])
sim = ctrl.ControlSystemSimulation(system, flush_after_run=21 * 21 + 1)


# Finite diference PVI approximation

tf = 1
n = 100
h = tf/100
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

