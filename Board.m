classdef Board < handle
    properties
        shown
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
            obj.shown=zeros(size(obj.board));
        end
        
        		function brd = getBoard(obj)
        			brd=obj.board;
                end
                
                function shwn = getShown(obj)
                    shwn = obj.shown;
                end
                
                function map = getMap(obj)
                    map = [ .8 .8 1; 0 0 0; 1 1 1 ; 0 0 0; 1 1 1; 1 .8 .8 ; .8 .8 1; 1 1 1];
                end
                
                function mapn = getMapn(obj)
                    mapn = [ 1 .8 .8; 1 1 .98 ; .8 .8 1; .1 .4 .4];
                end
        
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
