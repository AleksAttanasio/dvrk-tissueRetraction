clear;
clc;
close all;

addpath('utilities');
addpath('../dvrk_matlab');

% init ROS
rosshutdown;
ros_config;
rosinit

ARUCO_SET_POINT_FIXED = false; % true = marker on trocar, false = marker on EE
ARUCO_PLOT_TRANS = true; % shows plot of the current transformation
TF_CAM_ARUCO = false;
TF_CAM_PEE = true;
TF_PEE_P0 = true;

T_ar_c = ReadTransFromTopic('/tf','t0');
T_c_ar = invhform(T_ar_c);

T_p0_pee = ReadPSMCartesianCurrent('/dvrk/PSM3/position_cartesian_local_current');
T_pee_p0 = invhform(T_p0_pee);


pee_rot = T_ar_c(1:3,1:3) * rotx(270) * rotz(270);
pee_tr = T_ar_c(1:3,4);

T_c_pee = [pee_rot, pee_tr; [0 0 0 1]];

%     T_c_pb = T_pee_c * T_pee_p0 * T_p0_pb;

T_p0_c = T_c_pee * T_pee_p0;


if (ARUCO_PLOT_TRANS)

        figure
        frame3d([0,0,0], eye(3));
        text(0,0,0, 'endoscope');
        if(TF_CAM_ARUCO)
            hold on
            frame3d(T_ar_c(1:4,4), T_ar_c(1:3,1:3));
            text(T_ar_c(1,4),T_ar_c(2,4),T_ar_c(3,4), 'ArUco');
        elseif(TF_CAM_PEE)
            hold on
            frame3d(T_c_pee(1:4,4), T_c_pee(1:3,1:3));
            text(T_c_pee(1,4),T_c_pee(2,4),T_c_pee(3,4), 'pEE');
        end
        if(TF_PEE_P0)
            hold on
            frame3d(T_p0_c(1:4,4), T_p0_c(1:3,1:3));
            text(T_p0_c(1,4),T_p0_c(2,4),T_p0_c(3,4), 'P0');
        end

end

%%
% send transform to dVRK console
psml=psm(psmName);
psml.set_base_frame(T_p0_c); 

psml.get_position_current()
psml.get_position_local_current()

gogogo = psml.get_position_current() - psml.get_position_local_current();

%%

ref_pose = [eye(3), [0.0; 0.0; 0.05]; [0 0 0 1]];

psml.move(ref_pose)


                                            
                                            