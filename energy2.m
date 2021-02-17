function [value] = energy2(x,y,left,bottom, right, top, d_lambda, s_lambda)

%energy function
value = (-d_lambda * abs(x - y)) - (s_lambda * (abs(x - left) + abs(x - bottom) + abs(x - right) + abs(x - top)));
end