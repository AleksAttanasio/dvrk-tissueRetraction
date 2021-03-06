function [T_pee_p0] = ReadPSMCartesianCurrent(topic_name)

    sub = rossubscriber(topic_name);
    msg_received = false;

    % read the message and store the message as soon as it's received
    while (msg_received == false)

        msg = receive(sub,4);

    %     if strcmp(msg.Header.FrameId, 'PSM3')
            pee_p0_tr = [msg.Pose.Position.X; msg.Pose.Position.Y; msg.Pose.Position.Z];
            pee_p0_rot = quat2rotm([msg.Pose.Orientation.W, msg.Pose.Orientation.X, ...
                                msg.Pose.Orientation.Y, msg.Pose.Orientation.Z]);
            T_pee_p0 = [pee_p0_rot,pee_p0_tr; [0 0 0 1]];

            msg_received = true;
    %     end
    end
    
    if(msg_received == true)
       
        fprintf(strcat(topic_name, ' correctly read. \n'))
    end
end

