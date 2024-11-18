#!/usr/bin/env julia

using CasADi
using Plots

g = 9.81 #gravity acc
M = 1 #mass of car
m = 0.2 #mass of objects
l = 1 #length of objects

Q = diag([2.5, 10, 0.01, 0.01])
Q_f = diag([2.5, 10, 0.01, 0.01])
R = diag([0.01])

K = 20
T = 1
dt = T/K

x_lb = [-np.inf, -np.inf, -np.inf, -np.inf]
x_ub = [np.inf, np.inf, np.inf, np.inf]

u_lb = [-15]
u_ub = [15]

nx = 4 #状態変数の次元
nu = 1 #制御入力の次元

#Ref
x_ref = DM([0.0, 0.0, 0.0])
u_ref = DM([0])

total = nx*(K+1) + nu*K

#状態方程式の作成

function state()
    states = cas.SX.sym("states", nx)
    ctrls = cas.SX.sym("ctrls", nu)

    x = states[0]
    theta = states[1]
    x_dot = states[2]
    theta_dot = states[3]
    u = ctrls[0]

    sin = sin(theta)
    cos = cos(theta)
    det = M+m*sin**2

    x_ddot = 
    theta_ddot =

    states_dot = cas.vertcat(x_dot, theta_dot, x_ddot, theta_ddot)

    f = Function("f", [states, ctrls], [states_dot], ["x", "u"], ["x_dot"])

    return f
end



##Use Runge–Kutta 4 to make bins
function RK4()
    states = SX("states", nx)
    ctrls = SX("ctrls", nu)

    f = state()

    r1 = f(x=states, u=ctrls)["x_dot"]
    r2 = f(x=states+dt*r1/2, u=ctrls)["x_dot"]
    r3 = f(x=states+dt*r2/2, u=ctrls)["x_dot"]
    r4 = f(x=states+dt*r3, u=ctrls)["x_dot"]

    states_next = states + dt*(r1+r2+r3+r4)/6

    RK4 = Function("RK4", [states, ctrls], [states_next], ["x","u"], ["x_next"])
    return RK4
end


#make integrator
function integrator()
    states = SX("states", nx)
    ctrls = SX("ctrls", nu)

    f = state()
    ode = f(x=states, u=ctrls)["x_dot"]
    dae = {"x":states, "p":ctrls, "ode":ode}
    I = integrator("I","cvodes",dae,0,dt)
    return I
end

function stage_cost(x,u)
	 x_diff = x - x_ref
	 u_diff = y - y_ref
	 cost = (dot(Q@x_diff,x_diff) + dot(R@u_diff,u_diff))/2
	 return cost
end

function terminal_cost(x)
	 x_diff = x - x_ref
	 cost = dot(Q_f@x_diff,x_diff) /2
	 return cost
end


function make_nlp()
	 RK4 = RK4()
	 U = [SX(
