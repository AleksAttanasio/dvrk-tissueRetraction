% get tf from ROS topic
get_tf;

%%

% rotation and translation matrices
left_R = quat2rotm([left_tf.Rotation.W, left_tf.Rotation.X, ...
                            left_tf.Rotation.Y, left_tf.Rotation.Z]);
left_T = [left_tf.Translation.X; left_tf.Translation.Y; ...
                                                left_tf.Translation.Z];
                                            
% homogeneous transform                                          
T_o_l = [left_R, left_T; [0 0 0 1]];
T_l_c = [[eye(3); 0 0 0], [0; 0.0025; 0; 1]];

% Homogeneous transform from checkerboard to center of cameras
T_o_c = T_o_l * T_l_c;

% find origin of center camera frame
p_c = T_o_c * or_pos';
p_l = T_o_l * or_pos';

% Evaluate inverse matrix to find tf from center camer to checkerboard
c_o_R = T_o_c(1:3,1:3)';
c_o_T = -(c_o_R * T_o_c(1:3,4));

T_c_o = [[c_o_R; [0 0 0]],[c_o_T; 1]];

p_o = T_c_o * [0 0 0 1]';
