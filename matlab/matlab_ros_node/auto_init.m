clear;
clc;
close all;
rosshutdown;

% Retrieve additional information
config_file;

% rosinit(ros_master_ip,ros_master_port);
rosinit
get_tf;
auto_transform;
%%
T_c_p0 = T_c_o * T_o_pb * T_pb_p0;
T_o_p0 = T_o_pb * T_pb_p0;

%instantiate psm
psml=psm(psmName);

%set camera frame as reference frame for PSM 
psml.set_base_frame(T_o_p0);

%home the PSM
% msg=strcat('Do you want to home ',psmName,'? Y/N');
% answer=input(msg,'s');
% if answer == 'Y'
% psml.home();    
% end

%perform test motion
% msg=strcat('Do you perform test motion on ',psmName,'? Y/N');
% answer=input(msg,'s');
% if answer == 'Y'
%     psml.dmove_translation([0.01,0.0,0.0]);
% pause(2.0)
% psml.dmove_translation([0.01 0.0 0.0]);
% pause(2.0)
% psml.dmove_translation([0.0 0.01 0.0]);
% pause(2.0)
% psml.dmove_translation([0.0 0.0 0.01]);
% 
% 
% end




