function [T_c_o] = get_camera_origin_transform(tf)
%GET_CAMERA_ORIGIN_TRANSFORM Summary of this function goes here
%   Detailed explanation goes here

% rotation and translation matrices
left_R = quat2rotm([tf.Rotation.W, tf.Rotation.X, ...
                            tf.Rotation.Y, tf.Rotation.Z]);
left_T = [tf.Translation.X; tf.Translation.Y; ...
                                                tf.Translation.Z];
                                            
% homogeneous transform                                          
T_o_l = [left_R, left_T; [0 0 0 1]];
T_l_c = [[eye(3); 0 0 0], [0; 0.0025; 0; 1]];

% Homogeneous transform from checkerboard to center of cameras
T_o_c = T_o_l * T_l_c;

% Evaluate inverse matrix to find tf from center camer to checkerboard
c_o_R = T_o_c(1:3,1:3)';
c_o_T = -(c_o_R * T_o_c(1:3,4));

T_c_o = [[c_o_R; [0 0 0]],[c_o_T; 1]];

end

