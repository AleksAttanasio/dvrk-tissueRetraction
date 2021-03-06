function [T_ar_c] = ReadTransFromTopic(topic_name, child_frame_id, n_samples)

    sub = rossubscriber(topic_name);
    msg_received = false;
    ROT_AV = cell(n_samples,1); % matrix containing rotation matrix to average
    TRN_AV = []; % matrix containing translation matrix to average

    % read the message and store the message as soon as it's received
    for i = 1:n_samples
        while (msg_received == false)

            msg = receive(sub,4);

            if strcmp(msg.Transforms.ChildFrameId, child_frame_id)
                aruco_tf = msg.Transforms.Transform;
                msg_received = true;
            end
        end

        if(msg_received == true)

            fprintf(strcat('Read sample #', num2str(i), ' from -->', topic_name,...
                            child_frame_id, ' ... \n'))
        end

        % convert rotation quaternion to rotation matrix
        ar_c_rot = quat2rotm([aruco_tf.Rotation.W, aruco_tf.Rotation.X, ...
                                aruco_tf.Rotation.Y, aruco_tf.Rotation.Z]);

        % store translation matrix                                                
        ar_c_tr = [aruco_tf.Translation.X; aruco_tf.Translation.Y; ...
                                                    aruco_tf.Translation.Z];
        
        ROT_AV{i} = ar_c_rot;
        TRN_AV = [TRN_AV;ar_c_tr'];

        msg_received = false;
    end
    
    rot_av = zeros(3);
    tr_av = zeros(1,3);
    
    for k = 1:n_samples
       rot_av = rot_av + ROT_AV{k};
    end
    
    tr_av = mean(TRN_AV);
    rot_av = rot_av / n_samples;
    
    T_ar_c = [rot_av, tr_av'; [0 0 0 1]];
end

