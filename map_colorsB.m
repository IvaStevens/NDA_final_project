function [ map, brd ] = map_colorsB( board )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    c = unique(board);
    if length(c) >= 3 %good
        map = [ .8 .8 1; 0 0 0; 1 1 1 ; 0 0 0; 1 1 1; 1 .8 .8 ; .8 .8 1; 0 0 0];
        brd = board;
    elseif length(c) == 2 && max(c) == 0 
        map = [ .8 .8 1; 0 0 0; 1 1 1 ; 0 0 0; 1 1 1; 1 .8 .8 ; .8 .8 1; 1 1 1];
        brd = ~board;
    elseif length(c) == 2 && max(c) > 0
        brd = ~board;
        map = [ .8 .8 1; 0 0 0; 1 1 1 ; 0 0 0; 1 1 1; 1 .8 .8 ; .8 .8 1; 1 1 1];
    else %good
        map =[ .8 .8 1; 0 0 0; 1 1 1 ; 0 0 0; 1 1 1; 1 .8 .8 ; .8 .8 1; 0 0 0];
        brd = board;
    end

end

