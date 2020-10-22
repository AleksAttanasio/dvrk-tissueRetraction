ros_master_ip='129.11.176.75';
ros_master_port=11311;
psmName='PSM3';

%homogeneus transform between base of the PSM and fulcrum of the mechanism
T_pb_p0 = [0 1 0 0.4864;-1 0 0 0;0 0 1 0.1524;0 0 0 1];
T_p0_pb = invhform(T_pb_p0);