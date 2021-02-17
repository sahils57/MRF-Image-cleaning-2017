clear all
% read teh image in the form of a matrix
image_mat = imread('Bayes-noise.png');

% get the r values to make the image black or white... i.e. a binary image
image_mat_need = image_mat(:,:,1);
% int8 makes it saturate at 127
image_mat_need = int8(image_mat_need);

% this is to give the value -1 or 1 to each value in matrix depemdig on
% whether the index has a red value or not
image_mat_binary = to_black_white(image_mat_need);

y = image_mat_binary;
[row, col] = size(image_mat_binary);
count = 0;

% variables of teh MRF function used
h = -.01;
beta = 15;
eta = 10;
cf=1;    


while (cf) 
    count = count + 1;
    cf=0;    
    for i=2:col - 1
        for j=2:row - 1
    
            no_flip_energy = energy(   image_mat_binary(j,i ), image_mat_binary( j, i+1 ), image_mat_binary( j, i-1), image_mat_binary( j+1, i ), image_mat_binary( j-1, i ), y(j,i), h, beta, eta );
            flip_energy = energy(-1*image_mat_binary(j,i), image_mat_binary( j, i+1), image_mat_binary( j, i-1), image_mat_binary( j+1, i ), image_mat_binary( j-1, i ), y(j,i), h, beta, eta );
            
            if flip_energy < no_flip_energy
                image_mat_binary(j, i) = -1 * image_mat_binary(j,i);
                cf = 1;
            end
        end
    end
    
end

% put original image in a mtrix and convert it into binary values as well
correct = imread('Bayes.png');
correct_need = int8(correct(:,:,1));
correct_binary = to_black_white(correct_need);

% Calculate Accuracy
accuracy = accuracy(correct_binary, image_mat_binary);

image_mat_binary = uint8(image_mat_binary);
imshow(255 * image_mat_binary);

figure();
imshow(uint8(y) * 255);

fprintf('the accuracy is %.2f \n', accuracy)