clear;
clc;
close all;
run(config_file);

%setup transformations
%compute trasformation from Camera frame to robot frame 0
T_c_p0=invhform(T_c_o)*T_o_pb*T_pb_p0;

disp('The trasformation matrix between the camera and the PSM base is:')
disp(T_c_p0)

%ROS init
rosinit(ros_master_ip,ros_master_port);

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
psm1.dmove_translation([0.05 0 0]);
wait(2)
psm1.dmove_translation([-0.05 0.05 0]);
wait(2)
psm1.dmove_translation([0 -0.05 0.05]);
wait(2)
psm1.dmove_translation([0 0 -0.05]);

