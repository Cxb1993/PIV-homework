%% PIV Homework
% Raquel Hakes
% ENME 712: Homework #4

clear all; 
clc
close all;

%% Load Images

A1 = imread('A1.tif');
A1 = im2double(A1);
A2 = imread('A2.tif');
A2 = im2double(A2);

%% Pre-allocation etc.

k = 0;
window1_loc = cell(1, 4800);
r = 0;
window2_loc = cell(36, 4800);           % I can take this out - just for testing that it's working
c = 0;
s = 0;
% important_stuff = cell(5, 4800);

R_max = zeros(58,82);

max_correlation = 0;
max_locationx = 0;
max_locationy = 0;
win_locationx = 0;
win_locationy = 0;
displacement_x = 0;
displacement_y = 0;

%% Cross-correlation


for x = 16:16:64                   % change to 928 when actually running it
    for y = 16:16:64              % change to 1311 when actually running it
        window1 = A1(x:x+31,y:y+31);
        k = k + 1;
        window1_loc{k} = [x y];
%         for i = 1:64
%             for j = 1:64
%                 mid_window = [x+15,y+15]; 
        for i = x-8:8:x+39
                s = s + 1;
            for j = y-8:8:y+39
                window2 = A2(i:i+31,j:j+31);
                r = r + 1;
                window2_loc{r} = [i j];     % I can take this out - just for testing that it's working
                mean_intensity1 = mean2(window1);
                mean_intensity2 = mean2(window2);
                cross_correlation = 0;
%                 R = sum(sum((window1 - mean(window1(:))).*(window2-mean(window2(:)))));
                for a = 1:32
                    for b = 1:32
                        intensity1 = window1(a,b);
                        intensity2 = window2(a,b);
                        cross_correlation = cross_correlation + (intensity1 - mean_intensity1)*(intensity2 - mean_intensity2);
                    end
                end
                R(r,s) = cross_correlation;
                    c = c + 1;
%                 cell_corr{i, j} = cross_correlation;
                if (cross_correlation > max_correlation)
                    max_correlation = cross_correlation;
%                     max_locationx = i;              % do I even need these next 4 lines?
%                     max_locationy = j;
%                     win_locationx = x;
%                     win_locationy = y;
                    displacement_x = x - i;
                    displacement_y = y - j;
                end
                for e = 1:58
                    for f = 1:82
                        dx(f,e) = displacement_x;
                        dy(f,e) = displacement_y;
                    end
                end
            end
        end  
    end
end

quiver(dy, dx)
