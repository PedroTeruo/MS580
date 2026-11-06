import numpy as np


def composition(x, y, sum, product):
    z = []
    for x1 in x:
        for y1 in y.T:
            z.append(sum(product(x1, y1)))
    return np.array(z).reshape((x.shape[0], y.shape[1]))


def Godel(x, y):
    return (x <= y) + y*(x > y)

def Goguen(x, y):
    return (x <= y) + (y/x)*(x > y)


S = np.array([[.8, .4, .5, .8, .2, .1, .1, .9, .1, .1, .4], 
              [.3, .1, .4, .8, .9, .2, .1, .1, .1, .1, .3], 
              [.8, .3, .5, .8, .1, .2, .9, .1, .6, .3, .6],
              [.8, .7, .7, .2, .1, .9, .1, .1, .1, .9, .4]])
T = np.array([[.9, .3, .4, .2], 
              [.3, .9, .1, .1], 
              [.4, .1, .9, .3],
              [.2, .1, .3, .9]])

Dg = composition(S.T, T, min, Godel)

print('Diagnósticos de cada paciente (composição simples):\n')
P = composition(S, Dg, max, np.minimum)
for i in range(P.shape[0]):
    p_str = np.array2string(P[i, :], precision=1, separator=' ', floatmode="fixed")
    print('P{0}: {1}'.format(i + 1, p_str))

Dgg = composition(S.T, T, min, Goguen)
D_str = np.array2string(Dgg, precision=3, separator=' ', floatmode="fixed")
print('Matriz de diagnóstico por sintoma (sup-t com produto):\n')
print(' ' + D_str + '\n')

print('Diagnósticos de cada paciente (sup-t com mínimo):\n')
P = composition(S, Dgg, max, np.minimum)
for i in range(P.shape[0]):
    p_str = np.array2string(P[i, :], precision=1, separator=' ', floatmode="fixed")
    print('P{0}: {1}'.format(i + 1, p_str))