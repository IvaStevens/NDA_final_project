clear all;close all;clc;
response=startGUI;
% Will need to delay closing startGUI and calling projectGUI until after
% the user has made a level selection
if (strcmpi(response,'')) == 0
    h=findall(0,'type','figure');
    close(h)
else
end
projectGUI
