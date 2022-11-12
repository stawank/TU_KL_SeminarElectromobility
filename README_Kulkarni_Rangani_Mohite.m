%% Seminar Electromobility SS 2021 %%
------------------------------------------------------------------------------------------------------------
%% Energy Management System for Mild Parallel Hybrid Electric Vehicle
%% Group 2 - 
Stawan Chandrashekhar Kulkarni (419106)
Parth Rangani (419154)
Pranav Balasaheb Mohite (419272)
------------------------------------------------------------------------------------------------------------
%% Functionality
------------------------------------------------------------------------------------------------------------
1.<qss_hybrid_electric_vehicle_Kulkarni_Rangani_Mohite.mdl>: Name of the simulink model consisting of vehicle model used for the simulation of energy management system.
2.<Controller_Kulkarni_Rangani_Mohite.m>: Matlab code file which is used as 'integrated MATLAB function' further connected to outport 'u' in the controller block of simulink model.
3.<State_Kulkarni_Rangani_Mohite.m>: Matlab code file which is used as 'integrated MATLAB function' further connected to outport 'state_CE' in the controller block of simulink model.

%% Interdependencies
------------------------------------------------------------------------------------------------------------
1.Controller unit block of simulink model is consisting of the above mentioned <Controller_Kulkarni_Rangani_Mohite.m> and <State_Kulkarni_Rangani_Mohite.m> codes.
2.The path obtained from Simulink while opening the code shows the dependency which is qss_hybrid_electric_vehicle_example/Control Unit (seminar)/Controller and the 2 mentioned codes. 


%% Running the QSS program
------------------------------------------------------------------------------------------------------------
1. The Simulink file of energy management strategy is named as "qss_hybrid_electric_vehicle_Kulkarni_Rangani_Mohite.mdl" and located in the folder "QSS_TB_Seminar".
2. The above mentioned simulink file uses the controller named "Controller_Kulkarni_Rangani_Mohite" and located in the folder "QSS_TB_Seminar".
3. Simulink model uses state function named "State_Kulkarni_Rangani_Mohite" and located in the folder "QSS_TB_Seminar".
4. By double clicking on the file "qss_hybrid_electric_vehicle_Kulkarni_Rangani_Mohite.mdl" the simulation can be started.
5. With the help oft e display box the fuel consumption can be seen at the end of simulation.
6. In order to run the simulation for NEDC and FTP-75, selection of cycel can be done from Driving Cycle block in the simulink model.

-------------------------------------------------------------------------------------------------------------