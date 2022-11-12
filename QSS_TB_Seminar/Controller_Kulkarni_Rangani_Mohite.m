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
% calculates the torque split ratio (u) as an output.
% This output is calculated based on various conditions, which are
% implemented using if-else statements.
%(2)
% Moreover, the values of the parameters depend on the driving cycle selected
% for the analysis.
% Therefore, function decides the driving cyle based on the simulation
% time.
% (3)
% w_EM_max and T_EM_max are declared to be global variables

%%  Function Definition

function u = Controller_Kulkarni_Rangani_Mohite(input)%.......%Fuction to calculate the value of Torque Split Factor u from given input vector.

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
     
%Standard Input Values - 
theta_EM       = 0.1;%................%Motor Initial Inertia (cannot be changed)           
epsilon        = 0.01;%...............%Constant for Torque calculation (cannot be changed)            

current_system = get_param(0, 'CurrentSystem');%.................... % Now current_system refers to the simulink block.
stop_time= str2double(get_param(current_system, 'StopTime')); %......% Getting Simulation Stop Time of curremt system.
NEDC_Length = 1220;%.................................................% Time for NEDC cycle

if stop_time==NEDC_Length;%........% Selection of driving cycle as NEDC
     T_MGB_th=58;%.................% Define LPS Torque threshold for NEDC in Nm.
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
     u_LPS_gen_max = -0.35;%.......% Maximum value of u in LPS(generator mode)
     u_LPS_mot_max = 0.2;%.........% Maximum value of u in LPS(motor mode)
end
      
 		         
%Operation Modes-

%1)Mode 1 - Regenerative Braking model 
if(T_MGB<0)%......................................................................................% Operating condition for Regeneration             
    u = min((interp1(w_EM_max,-T_EM_max,w_MGB)+abs(theta_EM*dw_MGB)+epsilon)/T_MGB,1);%...........%Calculation of 'u' (ref.3.8)
    
%2)Mode 2 - Electric Driving Mode
elseif ((T_MGB>0) && (T_MGB <= T)  && (Q_BT>Q_BT_min) )%..........................................% Operating condition for Electric driving mode 
    u =1; %.......................................................................................%'u'value remains constant in electric driving mode.                                  
 
%3)MOde 3 - Load Point Shifting in Generator mode   
elseif ((T_MGB >T) && (T_MGB< T_MGB_th) && (Q_BT < Q_BT_max))%....................................% Operating condition for load point shifting in generator mode       
    u= max((interp1(w_EM_max,-T_EM_max,w_MGB)+abs(theta_EM*dw_MGB)+epsilon)/T_MGB,u_LPS_gen_max);%% Calculation of 'u' for LPS (generator mode)(ref.3.8)

%4)Mode 4 - Load point Shifting in Motor mode
elseif ((T_MGB >= T_MGB_th)&& (Q_BT> Q_BT_max) && (i ==2))%.......................................% Operating condition for load point shifting in motor mode
    u = min((interp1(w_EM_max,T_EM_max,w_MGB)-abs(theta_EM*dw_MGB)-epsilon)/T_MGB,u_LPS_mot_max);%%Calculation of 'u' (ref.3.8)

%5)Mode 5 - Engine Mode       
else%.....................%Operation in conventional mode when above conditions are not satisfied                        
    u = 0;%...............%Vehicle is operated in engine mode only.
end

% End of the program
