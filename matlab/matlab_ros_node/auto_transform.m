% rotation and translation matrices
left_R = quat2rotm([left_tf.Rotation.W, left_tf.Rotation.X, ...
                            left_tf.Rotation.Y, left_tf.Rotation.Z]);
left_T = [left_tf.Translation.X; left_tf.Translation.Y; ...
                                                left_tf.Translation.Z];
                                            
% homogeneous transform
T_l_o = ([left_R, left_T; [0 0 0 1]]);
T_o_l = invhform([left_R, left_T; [0 0 0 1]]);
T_c_l = [[eye(3); 0 0 0], [0; -0.0025; 0; 1]];

% Homogeneous transform from checkerboard to center of cameras
% T_o_c = T_o_l * T_l_c;

% Evaluate inverse matrix to find tf from center camer to checkerboard

% T_c_o = invhform(T_o_c);
