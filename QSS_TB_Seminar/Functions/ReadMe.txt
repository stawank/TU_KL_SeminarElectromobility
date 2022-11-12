Seminar Electromobility SS 2021
------------------------------------------------------------------------------------------------------------
Energy Management System for Mild Parallel Hybrid Electric Vehicle
Group 2
Stawan Chandrashekhar Kulkarni 419106
Parth Rangani 419154
Pranav Balasaheb Mohite 419272
------------------------------------------------------------------------------------------------------------
Functionality

<qss_hybrid_electric_vehicle_example.slx>: Name of the simulink model consisting of vehicle model used for the simulation of energy management system.
<controller.m>: Matlab code file which is used as 'integrated MATLAB function' further connected to outport 'u' in the controller block of simulink model.
<State_CE.m>: Matlab code file which is used as 'integrated MATLAB function' further connected to outport 'state_CE' in the controller block of simulink model.

<interdependencies> : Controller unit block of simulink model is consisting of the above mentioned <controller.m> and <State_CE.m> codes. The path obtained from Simulink while opening the code shows the dependency which is qss_hybrid_electric_vehicle_example/Control Unit (seminar)/Controller and the 2 mentioned codes. 
