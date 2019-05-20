function [ out_img ] = smoothMask( img, smooth_fact )

                kernel = ones(smooth_fact) / smooth_fact ^ 2;
                blurryImage = conv2(single(img), kernel, 'same');
                binaryImage = blurryImage > 0.5; % rethreshold
                
                out_img = binaryImage;
end

