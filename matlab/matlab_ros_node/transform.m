% get tf from ROS topic
get_tf;

%%
% checker board frame
or_pos = [0, 0, 0 ,1];
or_rot = [1 0 0; 0 1 0; 0 0 1];
T_orig = [[eye(3); 0 0 0], [0 0 0 1]'];

% rotation and translation matrices
left_R = quat2rotm([left_tf.Rotation.W, left_tf.Rotation.X, ...
                            left_tf.Rotation.Y, left_tf.Rotation.Z]);
left_T = [left_tf.Translation.X; left_tf.Translation.Y; ...
                                                left_tf.Translation.Z];
right_R = quat2rotm([right_tf.Rotation.W, right_tf.Rotation.X, ...
                            right_tf.Rotation.Y, right_tf.Rotation.Z]);
right_T = [right_tf.Translation.X, right_tf.Translation.Y, ...
                                                right_tf.Translation.Z]';

% homogeneous transforms                                           
T_cb_left = [left_R, left_T; [0 0 0 1]];
T_cb_right = [right_R, right_T; [0 0 0 1]];
% % T_cb_right = [right_R, right_T; [0 0 0 1]];
T_left_center = [[eye(3); 0 0 0], [0; 0.0025; 0; 1]];

% Homogeneous transform from checkerboard to center of cameras
T_cb_center = T_cb_left * T_left_center;

% find origin of center camera frame
p_center = T_cb_center * or_pos';
p_left = T_cb_left * or_pos';
p_right = T_cb_right * or_pos';

test_rot = left_R * or_rot;

% plot frames 
figure
frame3d(p_left, test_rot)
hold on 
frame3d(or_pos, or_rot)

% Evaluate inverse matrix to find tf from center camer to checkerboard
center_cb_R = T_cb_center(1:3,1:3)';
center_cb_T = -(center_cb_R * T_cb_center(1:3,4));

T_center_cb = [[center_cb_R; [0 0 0]],[center_cb_T; 1]];

p_cb = T_center_cb * p_center;