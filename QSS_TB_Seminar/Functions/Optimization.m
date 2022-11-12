clear all
close all
clc

f_consumption=[];

global w_EM_max;%.....................%Maximum motor angular velocity.              
global T_EM_max;%.....................%Maximum motor torque.             
global T_MGB_th                % Define LPS Torque threshold for NEDC
global T
global Q_BT_max
global Q_BT_min
global u_LPS_gen_max
global u_LPS_mot_max
c=1;
d=1;
for T_MGB_th = 58:0.5:61
    for T=29:0.33:30
        for u_LPS_gen_max=-0.35:-0.1:-0.65
            for u_LPS_mot_max=0.2:0.1:0.4
                for Q_BT_min=2500:1000:5500
                    for Q_BT_max= 12000:1000:16000
                        d=d+1;
                         sim('seminar_example');
                         f_consumption=[f_consumption, V_CE_equiv(end)];
                         if length (cycle)==1221
                            f_c(c) = f_consumption(end);
                            charge(c)=Q_BT(end)*0.001;
                            format short
                             fprintf ('%f          %f           %f            %f        %f      %f        %f       %f         %f  \n',c,T_MGB_th,T,f_consumption(end),Q_BT(end)*0.001,Q_BT_min*0.001,Q_BT_max*0.001,u_LPS_gen_max,u_LPS_mot_max)
                            c=c+1;            
                         else
                             break
                         end
                     end
                end
            end
        end
    end
end


[min_value,index]=min(f_c);
index
min_value