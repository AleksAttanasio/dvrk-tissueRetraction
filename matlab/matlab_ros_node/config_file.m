%init section with session-constant matrices
%homogeneus transform between base of the PSM and fulcrum of the mechanism
T_pb_p0=[0 1 0 0.4864;-1 0 0 0;0 0 1 0.1524;0 0 0 1];

%Position of PSM1 base wrt zero point
r_o_pb=[-0.3 -0.285 0.025]';
%Orientation of PSM1 +base wrt zero point
R_o_pb=[1 0 0; 0 1 0; 0 0 pi/];
%hom trasf 
T_o_pb=[[R_o_pb; 0 0 0] , [r_o_pb ; 1]];

%Position of zero point wrt camera
% r_c_o=[0 0 0]';
% %Orientation of zero point wrt camera
% R_c_o=eye(3);
% %hom trasf 
% T_c_o=[[R_c_o;0 0 0], [r_c_o;1]];

ros_master_ip='129.11.176.75';
ros_master_port=11311;

psmName='PSM3';