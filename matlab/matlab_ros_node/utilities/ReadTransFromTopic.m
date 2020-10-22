function [T_ar_c] = ReadTransFromTopic(topic_name, child_frame_id)

    sub = rossubscriber(topic_name);
    msg_received = false;

    % read the message and store the message as soon as it's received
    while (msg_received == false)

        msg = receive(sub,4);

        if strcmp(msg.Transforms.ChildFrameId, child_frame_id)
            aruco_tf = msg.Transforms.Transform;
            msg_received = true;
        end
    end
    
    if(msg_received == true)

        fprintf(strcat(topic_name, ' correctly read. \n'))
    end
    
    % convert rotation quaternion to rotation matrix
    ar_c_rot = quat2rotm([aruco_tf.Rotation.W, aruco_tf.Rotation.X, ...
                            aruco_tf.Rotation.Y, aruco_tf.Rotation.Z]);

    % store translation matrix                                                
    ar_c_tr = [aruco_tf.Translation.X; aruco_tf.Translation.Y; ...
                                                aruco_tf.Translation.Z];
                                            
    T_ar_c = [ar_c_rot, ar_c_tr; [0 0 0 1]];

end

