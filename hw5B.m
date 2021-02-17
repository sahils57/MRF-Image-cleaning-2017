close all
clear all
image_mat = imread('Lena-noise.png');
image_mat = int16(image_mat);

y1 = image_mat;
[row, col] = size(image_mat);

d_lambda = 2.0;
s_lambda = 2.0;
step_in = 3;

cf=1;    
count = 0;
while (cf && count < 1000) 
    count = count + 1;
    cf=0;    
    for i=2:col -1
        for j=2:row -1
  
            x = image_mat(j,i);
            y = y1(j,i);
            left = image_mat(j - 1, i);
            bottom = image_mat(j, i + 1);
            right = image_mat(j+1, i);
            top = image_mat(j, i - 1);
            
            no = energy2(x,y,left,bottom, right, top, d_lambda, s_lambda);
            x = min(255, x + step_in);  
            pos = energy2(x,y,left,bottom, right, top, d_lambda, s_lambda);
            x = image_mat(j,i);
            x = max(0, x - step_in);
            neg = energy2(x,y,left,bottom, right, top, d_lambda, s_lambda);
            x = image_mat(j,i);
            
            if pos > no
                cf = 1;
                image_mat(j,i) = min(255, x + step_in);
            end
            if neg > no
                cf = 1;
                image_mat(j,i) = max(0, x - step_in);
            end
            
        end
    end
    
end

correct = imread('Lena.png');

imshow(uint8(image_mat));
figure();
imshow(uint8(y1));
