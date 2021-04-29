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
