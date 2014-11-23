classdef Board < handle
    properties
        sze
        board
        axn % location of axon hillock on board
    end
    
    %Set up code
    methods
        function obj = Board(level)
            brd = [];
            switch level
                case Level.Easy
                    brd = zeros(7,7);
                case Level.Medium
                    brd = zeros(7,9);
                case Level.Hard
                    brd = zeros(9,9);
                otherwise
                    brd = zeros(7,7);
            end
            obj.board = brd;
        end
        
        % 		function brd = getBoard(obj)
        % 			return obj.brd
        % 		end
        
        %places neuron on the board
        function placeNeuron(obj,nrn)
            [nLen, nWid] = size(nrn);
            [bLen, bWid] = size(obj.board);
            top = randi(bLen-nLen); %logic?
            left = randi(bWid-nWid); %logic?
            obj.board(top:top+nLen-1,left:left+nWid-1) = nrn;
            obj.axn = find(obj.board == 2);
        end
        
    end
    
    %game play code
    methods
        %code tells if any part of the neuron is at this location
        function bl = isNrn(obj,x,y)
            bl = abs(obj.board(x,y)) > 0;
        end
    end
    
    
end
