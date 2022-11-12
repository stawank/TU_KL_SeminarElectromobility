%%  Seminar Electromobility SS 2021
% Energy Management System for Mild Parallel Hybrid Electric Vehicle
% Group 2
% Stawan Chandrashekhar Kulkarni 419106
% Parth Rangani 419154
% Pranav Balasaheb Mohite 419272
%% Description
% (1) 
% This function is used in integrated matlab function the simulink model of the controller.
% The controller is given six inputs(w_MGB, dw_MGB,T_MGB,i,v,Q_BT), and it 
% calculates the state of the engine (state_CE) as an output. The output is
% always a boolean value.
% This output is calculated based on various conditions, which are
% implemented using if-else statements.
% (2)
%  Moreover, the values of the parameters depend on the driving cycle selected
%  for the analysis.
%  Therefore, function decides the driving cyle based on the simulation
%  time.
%  (3)
%  w_EM_max and T_EM_max are declared to be global variables

%%  Function Definition
function state_CE = State_CE(input)%.......%Fuction to calculate the value of State of Combustion Engine.

%Inputs List - 
w_MGB  = input(1);%...................%Flywheel Angular Velocity                
dw_MGB = input(2);%...................%Flywheel Angular Acceleration                
T_MGB  = input(3);%...................%Flywheel Torque                
i      = input(4);%...................%Gear number (Gearbox)                
v      = input(5);%...................%Velocity of the vehicle                
Q_BT   = input(6);%...................%Battery Charge   

%Global Input Vector - 
global w_EM_max;%.....................%Maximum motor angular velocity.              
global T_EM_max;%.....................%Maximum motor torque.             

%Standard Input Values (Flexible) - 
theta_EM       = 0.1;%......................%Motor Initial Inertia (cannot be changed)             
epsilon        = 0.01;%.....................%Constant for Torque calculation (cannot be changed)            
                      
current_system = get_param(0, 'CurrentSystem');%..............%% Now current_system refers to the simulink block.
stop_time= str2double(get_param(current_system, 'StopTime')); % Getting Simulation Stop Time of curremt system.
NEDC_Length = 1220;%..........................................% Time for NEDC cycle
if stop_time==NEDC_Length;%........% Selection of driving cycle as NEDC
     T_MGB_th=58;%.................% Define LPS Torque threshold for NEDC
     T = 29;%......................% Minimum torque require for LPS in Nm.
     Q_BT_min = 2500;%.............% Minimum charge in the battery in C.
     Q_BT_max = 16000;%............% Maximum charge in the battery in C.
     u_LPS_gen_max = -0.55;%.......% Maximum value of u in LPS(generator mode)
     u_LPS_mot_max = 0.2;%.........% Maximum value of u in LPS(motor mode)
else
     T_MGB_th=50;%.................% Define LPS Torque threshold for FTP-75 in Nm.
     T = 32;%......................% Minimum torque require for LPS in Nm.
     Q_BT_min = 2500;%.............% Minimum charge in the battery in C.
     Q_BT_max = 21000;%............% Maximum charge in the battery in C.
     u_LPS_gen_max = -0.65;%.......% Maximum value of u in LPS(generator mode)
     u_LPS_mot_max = 0.2;%.........% Maximum value of u in LPS(motor mode)
end
    

%Operation Modes-

%1)Mode 1- Regenerative Braking mode.

if(T_MGB<0 )%...............................% Operating condition for Regeneration            
    state_CE=0;%............................%State of Combustion engine during Regenerative braking mode.
    
                                      
%2)Mode 2- Electric Driving mode.
elseif ((T_MGB>0) && (T_MGB <= T)  && (Q_BT>Q_BT_min) )%........% Operating condition for Electric driving mode
    state_CE=0;%................................................%State of Combustion engine during Electric Driving mode.

%3)Mode 3- Engine Stop
elseif (w_MGB==0)%..........................%Operating condition to stop the engine
    state_CE=0;%............................%State of Combustion engine at the time of vehicle shutdown.

%4)Mode 4- Engine Only       
else %......................................%Operating condition for conventional driving                        
    state_CE=1;%............................%State of Combustion engine when vehicle is propelled by combustion engine only.
end

% End of the program
