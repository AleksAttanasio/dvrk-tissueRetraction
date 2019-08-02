clear;
clc;
close all;
rosshutdown;

% Retrieve additional information
config_file;

% rosinit(ros_master_ip,ros_master_port);
rosinit
% to run get_tf tuv checkerborad node must be running
get_tf;
auto_transform;
T_c_p0 = T_c_l * T_l_o * T_o_pb * T_pb_p0;
T_o_p0 = T_o_pb * T_pb_p0;
save last_ws.mat

%%
%instantiate psm
psml=psm(psmName);
%%

%set base frame to camera frame
psml.set_base_frame(T_c_p0);
curpos=psml.get_position_current();
tform = axang2tform([0 0 1 pi/2]);
curpos_vertical= [[0 0 1;1 0 0;0 1 0;0 0 0], [curpos(1:3,4);1]];

psml.move(curpos_vertical)
psml.close_jaw()

%save vertical rotation in global frame for later
vertical_rotation_global=psml.get_position_current;
vertical_rotation_global=vertical_rotation_global(1:3,1:3);

%%
grasp_pt_sub = rossubscriber('/endoscope/disparity/grasping_point');
tissue_pt_sub = rossubscriber('/endoscope/disparity/tissue_point');
background_pt_sub = rossubscriber('/endoscope/disparity/background_point');


%read grasping and tissue point x, y ,and z
grasp_pt_msg=receive(grasp_pt_sub,4);
tissue_pt_msg=receive(tissue_pt_sub,4);
background_pt_msg=receive(background_pt_sub,4);

pos=[tissue_pt_msg.Point.X,tissue_pt_msg.Point.Y;grasp_pt_msg.Point.X, grasp_pt_msg.Point.Y];
p=polyfit(pos(:,1),pos(:,2),1);
%compute euclidean distance
dist=norm(pos(:,1)-pos(:,2));
% want to move into background tissue of 10% of distance between the points
dist=dist*0.5;
%compute x and y of first point
if(pos(2,1)-pos(1,1)>0) % caso del flap a sinistra 
        xp = pos(2,1)+dist/sqrt(1+p(1));
        yp = polyval(p,xp);
else
        xp = pos(2,1)-dist/sqrt(1+p(1));
        yp = polyval(p,xp);
end
%%
%move to starting point but at Z closer to camera
grasp_pos=trvec2tform([xp yp tissue_pt_msg.Point.Z-(tissue_pt_msg.Point.Z*0.5)]);
grasp_orient=rotm2tform(vertical_rotation_global);
grasp_pose=grasp_pos*grasp_orient;
psml.move(grasp_pose)

%move to same x and y but z lower
grasp_pos=psml.get_position_current;
grasp_pos(3,4)=(background_pt_msg.Point.Z+tissue_pt_msg.Point.Z)/2;
psml.move(grasp_pos);

%move at same z to x and y of tissue point
grasp_pos=psml.get_position_current;
grasp_pos(1,4)=tissue_pt_msg.Point.X;
grasp_pos(2,4)=tissue_pt_msg.Point.Y;
psml.move(grasp_pos);
