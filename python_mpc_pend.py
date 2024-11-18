#!/usr/bin/env python3

#This program is to make pend motion robot model using mpc

#Import required libraries
import numpy as np
import matplotlib.pyplot as plt
import casadi as cas
from matplotlib.animation import FuncAnimation
import matplotlib.patches as patches



#Set parameters
g = 9.81 #gravity acc
M = 1 #mass of car
m = 0.2 #mass of objects
l = 1 #length of objects

#Set Matrices
Q = cas.diag([2.5, 10, 0.01, 0.01])
Q_f = cas.diag([2.5, 10, 0.01, 0.01])
R = cas.diag([0.01])

#Set Horizon and Time
K = 20
T = 1
dt = T/K

#Set Conditions under which optimization conducted
x_lb = [-np.inf, -np.inf, -np.inf, -np.inf]
x_ub = [np.inf, np.inf, np.inf, np.inf]

u_lb = [-15]
u_ub = [15]

nx = 4 #degrees of states
nu = 1 #degrees of input

#References
x_ref = cas.DM([0.0, 0.0, 0.0, 0.0]) 
u_ref = cas.DM([0])

total = nx*(K+1) + nu*K

#State Equations
def state():
    states = cas.SX.sym("states", nx)
    ctrls = cas.SX.sym("ctrls", nu)

    x = states[0]
    theta = states[1]
    x_dot = states[2]
    theta_dot = states[3]
    u = ctrls[0]

    sin = cas.sin(theta)
    cos = cas.cos(theta)
    det = M+m*sin**2

    x_ddot = (-m*l*theta_dot**2*sin+m*g*sin*cos+u)/det
    theta_ddot = (-m*l*theta_dot**2*sin*cos+(M+m)*g*sin+u*cos)/(l*det)
    states_dot = cas.vertcat(x_dot, theta_dot, x_ddot, theta_ddot)

    f = cas.Function("f", [states, ctrls], [states_dot], ["x", "u"], ["x_dot"])

    return f

#Runge–Kutta 4 to make bins
def make_RK4():
    states = cas.SX.sym("states", nx)
    ctrls = cas.SX.sym("ctrls", nu)

    f = state()

    r1 = f(x=states, u=ctrls)["x_dot"]
    r2 = f(x=states+dt*r1/2, u=ctrls)["x_dot"]
    r3 = f(x=states+dt*r2/2, u=ctrls)["x_dot"]
    r4 = f(x=states+dt*r3, u=ctrls)["x_dot"]

    states_next = states + dt*(r1+r2+r3+r4)/6

    RK4 = cas.Function("RK4", [states, ctrls], [states_next], ["x","u"], ["x_next"])
    return RK4

#make integrator
def integrator():
    states = cas.SX.sym("states", nx)
    ctrls = cas.SX.sym("ctrls", nu)

    f = state()
    ode = f(x=states, u=ctrls)["x_dot"]
    dae = {"x":states, "p":ctrls, "ode":ode}
    I = cas.integrator("I","cvodes",dae,0,dt)
    return I

def stage_cost(x, u):
    x_diff = x - x_ref
    u_diff = u - u_ref
    cost = (cas.mtimes(Q, x_diff).T @ x_diff + cas.mtimes(R, u_diff).T @ u_diff) / 2
    return cost

def terminal_cost(x):
    x_diff = x - x_ref
    cost = (cas.mtimes(Q, x_diff).T @ x_diff) / 2  # 修正
    return cost

def make_nlp():
    RK4 = make_RK4()
    U = [cas.SX.sym(f"u_{k}", nu) for k in range(K)]
    X = [cas.SX.sym(f"x_{k}", nx) for k in range(K + 1)]
    G = []

    J = 0

    for k in range(K):
        J += stage_cost(X[k], U[k]) * dt
        eq = X[k + 1] - RK4(x=X[k], u=U[k])["x_next"]
        G.append(eq)
    J += terminal_cost(X[-1])

    option = {"print_time": False,
              "ipopt": {"max_iter": 10, "print_level": 0}}
    nlp = {"x": cas.vertcat(*X, *U), "f": J, "g": cas.vertcat(*G)}
    S = cas.nlpsol("S", "ipopt", nlp, option)
    return S

def optimal_ctrl(S, x_init, x0):
    x_init = x_init.full().ravel().tolist()

    lbx = x_init + x_lb * K + u_lb * K  # 修正
    ubx = x_init + x_ub * K + u_ub * K  # 修正
    lbg = [0] * nx * K
    ubg = [0] * nx * K

    res = S(lbx=lbx, ubx=ubx, lbg=lbg, ubg=ubg, x0=x0)

    offset = nx * (K + 1)
    x0 = res['x']
    u_opt = x0[offset:offset + nu]
    return u_opt, x0


def update_fig(i):
    x_lim_min = -4
    x_lim_max = 4
    y_lim_min = -2
    y_lim_max = 2
    u_scale = 15

    ax.cla()
    ax.set_xlim(x_lim_min, x_lim_max)
    ax.set_ylim(y_lim_min, y_lim_max)
    ax.set_aspect("equal")

    x,theta,_,_ = X[i]
    u, = U[i]

    points = np.array([
        [x,x-l*np.sin(theta)],
        [0,l*np.cos(theta)]
        ])

    ax.hlines(0,x_lim_min,x_lim_max,colors="black")
    ax.scatter(*points,color="blue",s=50)
    ax.plot(*points, color="blue", lw=2)
    ax.arrow(x,0,u/u_scale,9,width=0.02,
             head_width=0.06,head_length=0.12,
             length_includes_head=False,color="green",zorder=3)

    w = 0.2
    h = 0.1
    rect =patches.Rectangle(xy=(x-w/2,-h/2),width=w,height=h,color="black")
    ax.add_patch(rect)
    
    
    

if __name__ == '__main__':
    t_span = [0, 10]
    t_eval = np.arange(*t_span, dt)

    x_init = cas.DM([0, np.pi, 0, 0])
    x0 = cas.DM.zeros(total)

    S = make_nlp()
    I = integrator()

    X = [x_init]
    U = []
    x_current = x_init
    for t in t_eval:
        u_opt, x0 = optimal_ctrl(S, x_current, x0)
        x_current = I(x0=x_current, p=u_opt)["xf"]
        X.append(x_current)
        U.append(u_opt)

    X.pop()
    X = np.array(X).reshape(t_eval.size, nx)
    U = np.array(U).reshape(t_eval.size, nu)

    plt.figure(figsize=(12, 4))

    plt.subplot(1, 2, 1)
    for k in range(nx):
        plt.plot(t_eval, X[:, k], label=f"x_{k}")
    plt.legend()

    plt.subplot(1, 2, 2)
    for k in range(nu):
        plt.step(t_eval, U[:, k], linestyle="--", label=f"u_{k}")
    plt.legend()

    plt.show()

    fig = plt.figure(figsize = (12,6))
    ax = fig.add_subplot(111)
    frames = np.arange(0,t_eval.size)
    fps = 1/dt

    ani = FuncAnimation(fig, update_fig, frames=frames)
    ani.save("cart-pole_0.gif",writer="pillow",fps=fps)


    
