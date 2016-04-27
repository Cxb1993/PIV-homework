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
centerx = cell(57, 80);
centery = cell(57, 80);
% r = 0;
% window2_loc = cell(36, 4800);           % I can take this out - just for testing that it's working
% c = 0;
% s = 0;
% important_stuff = cell(5, 4800);
% 
% R_max = zeros(58,82);

max_correlation = 0;
% max_locationx = 0;
% max_locationy = 0;
% win_locationx = 0;
% win_locationy = 0;
displacement_x = 0;
displacement_y = 0;

%% Cross-correlation
[sizex, sizey] = size(A1);
window = 32/2; % size of interrogation window with 50% overlap
nx = round(sizex/window)-6;
ny = round(sizey/window)-6;

qx = 16:16:912;
N1 = 80;
qx = qx(repmat(1:size(qx,1),N1,1),:);
qx = qx';
qy = 16:16:1280;
N2 = 57;
qy = qy(repmat(1:size(qy,1),N2,1),:);

% nx = 58; % number of interrogation windows
% ny = 82; % number of interrogation windows

for k = 1:nx
    x = k*window
%     centerx = x + 15;
% for x = 1:window:(nx*window)
% for x = 16:16:128                   % change to 928 when actually running it
%     for y = 1:window:(ny*window)
       for l = 1:ny
           y = l*window
%            centery = y + 15;
%            centers = [centerx, centery];
        %     for y = 16:16:128              % change to 1311 when actually running it
        window1 = A1(x:x+(2*window-1),y:y+(2*window-1));
%         k = k + 1;
%         centerx{k} = centerx;
%         centery{k} = centery;
%         for i = 1:64
%             for j = 1:64
%                 mid_window = [x+15,y+15]; 
%         for i = 1:window*4
%             x1 = i
        for i = x-15:4:x+47
%                 s = s + 1;
            for j = y-15:4:y+47
                window2 = A2(i:i+31,j:j+31);
%                 r = r + 1;
%                 window2_loc{r} = [i j];     % I can take this out - just for testing that it's working
                mean_intensity1 = mean2(window1);
                mean_intensity2 = mean2(window2);
                cross_correlation = 0;
                R = sum(sum((window1 - mean(window1(:))).*(window2 - mean(window2(:)))));
%                 for a = 1:32
%                     for b = 1:32
%                         intensity1 = window1(a,b);
%                         intensity2 = window2(a,b);
%                         cross_correlation = cross_correlation + (intensity1 - mean_intensity1)*(intensity2 - mean_intensity2);
%                     end
%                 end
%                 R(r,s) = cross_correlation;
%                     c = c + 1;
%                 cell_corr{i, j} = cross_correlation;
                if (R > max_correlation)
                    max_correlation = R;
%                     max_locationx = i;              % do I even need these next 4 lines?
%                     max_locationy = j;
%                     win_locationx = x;
%                     win_locationy = y;
                    displacement_x = x - i;
                    displacement_y = y - j;
                end
                
                dx(x,y) = displacement_x;
                dy(x,y) = displacement_y;
                                
%                 for e = 1:58
%                     for f = 1:82
%                         dx(f,e) = displacement_x;
%                         dy(f,e) = displacement_y;
%                     end
%                 end
            end
        end  
    end
end

dx( ~any(dx,2), : ) = [];  %rows
dx( :, ~any(dx,1) ) = [];  %columns
dy( ~any(dy,2), : ) = [];  %rows
dy( :, ~any(dy,1) ) = [];  %columns

% quiver(dy,dx)
quiver(qy,qx,dy,dx)