# Pitch controller

## Active suspension system
Active suspension system (ASS) may be called ultimate suspension and provides many different functions, including vibration control (Skyhook control), posture control that reduces body roll, dive and squat, steering characteristics control, and body height control.

In this project, I developed a controller to **stabilises the pitch dynamics of a ground vehicle**.
To model the vehicle, an "hal car model" has been used, and the road displacement (*w1,2*) are modelled, supposing the car is travelling at a speed of *2.5 [m/s]* and encounter a road disturbance of *−0.1 [m]*.

## Control objectives
The following control objectives have been imposed:
- Ensure a bounded pitch displacement (*φ*) in an interval of ±10° ( *|φ|<10°*)
- When dealing with a speed bump, the vehicle needs to return in 1 sec (settling time *1[s]*) in a condition where no pitch displacement is present (*φ=0*) and with a zero vertical body displacement (*zc=0*).

## Implemented controllers
The controllers implemented are the following:
- **Pole-placement** on the augmented system (with integrators)
- **Pole-placement** on the augmented system (with integrators) enhanced with **Luenberger observer**
- **LQI** - *"Linear Quadratic Integral"*

Moreover, considering uncertainties on the state variable:

- **LQG** - *"Linear Quadratic Gaussian"* (**Kalman filter** + **LQI**)

## Final comparison
Utilising a cost function (*J*), a numeric comparison between different controllers has been carried out.

### Files
To use the project just open the *.prj* file. 

The presentation (only in italian) is also provided in *.pdf* format.

## Model Used
<img alt="formula" src="https://render.githubusercontent.com/render/math?math=\begin{equation}%20\begin{array}{l}%20m_{1%20f}%20\ddot{z_{1%20f}}-k_{f}\left(z_{2%20f}-z_{1%20f}\right)-c_{f}\left(\dot{z_{2%20f}}-\dot{z_{1%20f}}\right)-F_{1}%2Bk_{t%20f}\left(z_{1%20f}-q_{f}\right)=0%20\\%20m_{1%20r}%20\ddot{z_{1%20r}}-k_{r}\left(z_{2%20r}-z_{1%20r}\right)-c_{r}\left(\dot{z_{2%20r}}-\dot{z_{1%20r}}\right)-F_{2}%2Bk_{t%20r}\left(z_{1%20r}-q_{r}\right)=0%20\\%20m_{2}%20\ddot{z_{c}}%2Bk_{f}\left(z_{2%20f}-z_{1%20f}\right)%2Bc_{f}\left(%20\dot{z_{2%20f}}-\dot{z_{1%20f}}\right)%2BF_{1}%2Bk_{r}\left(z_{2%20r}-z_{1%20r}\right)%2Bc_{r}\left(z_{2}-z_{v}\right)%2BF_{2}=0%20\\%20J\ddot{\varphi}%2B%20b%20\left[%20k_{r}\left(z_{2%20r}-z_{1%20r}\right)%2Bc_{r}\left(\dot{z_{2%20r}}-\dot{z_{1%20r}}\right)%2BF_{2}\right]-d%20\left[%20k_{f}\left(z_{2%20f}-z_{1%20f}\right)%2Bc_{f}\left(z_{2%20f}-z_{1%20f}\right)%2BF_{1}\right]=0%20\end{array}%20\label{eqn:Equazioni%20dinamiche%20del%20veicolo}%20\end{equation}" />

With the assumption
<img alt="formula" src="https://render.githubusercontent.com/render/math?math=tg%20\varphi%20\approx%20\varphi" />
valid for
<img alt="formula" src="https://render.githubusercontent.com/render/math?math=|\varphi|%20<%2010{\deg}" />
we can get

<img alt="formula" src="https://render.githubusercontent.com/render/math?math=\begin{equation}%20\label{eqn:%20StateSpace}%20\begin{array}{l}%20\dot{x}=Ax%2BBu%2BLw%20\\%20y=Cx%2BDu\\%20x%20\in%20\mathbb{R}^{(8\times1)}\%20,\%20u%20\in%20\mathbb{R}^{(2\times1)}%20\\%20w%20\in%20\mathbb{R}^{(2\times1)}\%20,\%20y%20\in%20\mathbb{R}^{(4\times1)}%20\end{array}%20\end{equation}" />

## Pole placement

## LQR

## LQG



