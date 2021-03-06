clear;
clc;
close all;

% add libraries and utils
addpath('utilities');
addpath('../dvrk_matlab');

% init ROS
rosshutdown;
ros_config;
rosinit


% --- FLAGS --- %
RESET_FG = true;
ARUCO_SET_POINT_FIXED = false; % true = marker on trocar, false = marker on EE
ARUCO_PLOT_TRANS = true; % shows plot of the current transformation

% show different frames on the ARUCO_PLOT_TRANSTF_PEE_P0
TF_CAM_ARUCO = false; 
TF_CAM_PEE = true;
TF_PEE_P0 = true;
TF_ORIGIN = true;

% read and save transform topic
T_ar_c = ReadTransFromTopic('/tf','t0',5);
% T_c_ar = invhform(T_ar_c);

% read and save PSM current cartesian position
T_p0_pee = ReadPSMCartesianCurrent('/dvrk/PSM3/position_cartesian_local_current');
T_pee_p0 = invhform(T_p0_pee);

% rotate aruco marker frame to match the tool orientation
pee_rot = T_ar_c(1:3,1:3) * rotx(270) * rotz(270);
pee_tr = T_ar_c(1:3,4);
T_c_pee = [pee_rot, pee_tr; [0 0 0 1]];

T_p0_c = T_c_pee * T_pee_p0;

% translate to the tool origin
ORIGIN_TR = [eye(3),[0 0 0.0125]'; [0 0 0 1]];
T_OR = T_p0_c * ORIGIN_TR;

% plot 3D frames
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
        if(TF_ORIGIN)
            hold on
            frame3d(T_OR(1:4,4), T_OR(1:3,1:3));
            text(T_OR(1,4),T_OR(2,4),T_OR(3,4), 'ORIGIN');
        end

end

%% SEND TF TO dVRK
% send transform to dVRK console
psml=psm(psmName); % init PSM
psml.set_base_frame(T_OR);
pause(1);
fprintf('WARNING: new base frame set.\n')

RESET_POSE = psml.get_position_current(); % for lazy people

%% TEST POSE
% define test pose and move there
ref_pose = [eye(3), [0.0; 0; 0.05]; [0 0 0 1]];
psml.move(ref_pose)

%% RESET POSE IF NECESSARY

if(RESET_FG)
    pause(5)
    psml.move(RESET_POSE)
end




                                            
                                            