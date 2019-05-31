clear;
clc;
close all;

% Define rotation of PSMs on the bases
L_arm_rot = 0;
R_arm_rot = 0;

% Retrieve additional information
config_file;

% rosinit(ros_master_ip,ros_master_port);
rosinit()
get_tf;

T_c_o = get_camera_origin_transform(left_tf);

%instantiate psm
psml=psm(psmName);

%set camera frame as reference frame for PSM 
psm1.set_base_frame(T_c_p0);

%home the PSM
msg=strcat('Do you want to home ',psmName,'? Y/N');
answer=input(msg,'s');
if answer ~= 'Y'
    exit();
end
psml.home();

%perform test motion
msg=strcat('Do you perform test motion on ',psmName,'? Y/N');
answer=input(msg,'s');
if answer ~= 'Y'
    exit();
end
psml.dmove_translation([0.02,0.0,0.0]);
wait(2)
psml.dmove_translation([-0.02 0.02 0]);
wait(2)
psml.dmove_translation([0 -0.02 0.02]);
wait(2)
psml.dmove_translation([0 0 -0.02]);




