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

%% Cross-correlation


for x = 16:16:16                   % change to 928 when actually running it
    for y = 16:16:16              % change to 1311 when actually running it
        window1 = A1(x:x+31,y:y+31);
        k = k + 1;
        window1_loc{k} = [x y];
        for i = x-8:8:x+39
            for j = y-8:8:y+39
                window2 = A2(i:i+31,j:j+31);
                r = r + 1;
                window2_loc{r} = [i j];     % I can take this out - just for testing that it's working
                mean_intensity1 = mean2(window1);
                mean_intensity2 = mean2(window2);
                cross_correlation = 0;
                for a = 1:32
                    for b = 1:32
                        intensity1 = window1(a,b);
                        intensity2 = window2(a,b);
                        cross_correlation = cross_correlation + (intensity1-mean_intensity1)*(intensity2-mean_intensity2);
                    end
                end
            end
        end         
    end
end

