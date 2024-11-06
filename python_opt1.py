#!/usr/bin/env python3
import numpy as np
import scipy.optimize as opt


#1. 無制約最適化問題をScipyで解く
print("1. 無制約最適化問題をScipyで解く")
x0 = np.array([3., 1.])

obj_function = lambda x : (0.5 * (x[0]**4)) - (2. * (x[0]**2) * x[1]) + (4. * (x[1]**2)) + (8. * (x[0])) +  (8. * (x[1]))

result = opt.minimize(obj_function, x0, method='BFGS', options={'disp': True})
print('x = ', result.x)

#2. 制約付き最適化問題をScipyで解く
print("\n 2. 制約付き最適化問題をScipyで解く")
x0 = np.array([3., 1.])

obj_function = lambda x : (x[0]) + (2. * x[1])

cons_function = lambda x : [(-4. * x[0]) -x[1], x[0] - (3. * x[1]), ((x[0] -3.)**2) + (x[1]**2)]

lb = np.array([-np.inf, -np.inf, 4])
ub = np.array([6, 4, np.inf])

nonlin_const = opt.NonlinearConstraint(cons_function, lb, ub)

result = opt.minimize(obj_function, x0, options={'disp': True}, constraints={nonlin_const})
print('x = ', result.x)
