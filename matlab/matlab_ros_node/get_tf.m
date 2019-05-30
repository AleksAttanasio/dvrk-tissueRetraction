tf_sub = rossubscriber('/tf');
r_tf_rcv = 0;
l_tf_rcv = 0;

while (l_tf_rcv == 0 || r_tf_rcv == 0)
    
    msg = receive(tf_sub,4);
    
    if strcmp(msg.Transforms.ChildFrameId, 'endoscope/left_camera')
        left_tf = msg.Transforms.Transform;
        l_tf_rcv = 1;
    end

    if strcmp(msg.Transforms.ChildFrameId, 'endoscope/right_camera')
        right_tf = msg.Transforms.Transform;
        r_tf_rcv = 1;
    end
end




