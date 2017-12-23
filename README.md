# Computational Fluid Dynamics with ANSYS Fluent
In this project, we used the Spalart-Allmaras RANS-based turbulence model to simulate flow over NACA 0012 and NACA 4412 airfoils. The simulations were run at varying angles of attack covering the entire lift curve for these airfoils including stall and stall recovery. The CFD simulations were made using ANSYS Fluent and compared to thin airfoil theory, vortex panel method, and NACA experimental data using MATLAB.

-------------



Simulation Automation
-------------
While the Spalart-Allmaras model is a relatively computationally inexpensive model to use, each simulation for these airfoils could take up to two hours to converge around stall. Since over 40 simulations were ran for each airfoil, it was necessary to automate this process. I did this by generating massive journal files with MATLAB that run through consecutive simulations and save all necessary data, reports, and plots.

-------------



Stall Analysis
-------------
The NACA 4412 exhibited a sharp drop-off in (negative) lift around -12.5 to -13 degrees angle of attack due to its camber. The explosion of flow separation below the airfoil can be visualized in the velocity contour plots produced in Fluent.

![StallVel125](/NACA4412_vel_AOA-12.5.jpg?raw=true "StallVel125") ![StallVel13](/NACA4412_vel_AOA-13.jpg?raw=true "StallVel13")

-------------



Vortex Panel Comparison
-------------
The results of the CFD simulations was compared to the vortex panel method (most pertinent were lift slope and zero-lift angle of attack). In this vortex panel method implementation, I utilized cosine spacing for placing panel edges. This allowed for more effective panel placement, where the panels are more dense where there are higher pressure gradients on the airfoil's surface.
![VPSpacing](/NACA4412_VP.jpg?raw=true "VPSpaceing4412")
> This image conveys the method; however, thousands of panels were used in the actual implementation.

-------------



Final Results
-------------
The final goal was to create lift curves that compare the results of CFD simulations with experimental data, analytical thin airfoil theory results, and the vortex panel method for each airfoil.
![liftCurve0012](/finalLiftCurve_0012.jpg?raw=true "liftCurve0012") ![liftCurve4412](/finalLiftCurve_4412.jpg?raw=true "liftCurve4412")






