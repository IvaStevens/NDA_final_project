classdef Board < handle
    properties
        size
		brd
    end
	
	%Set up code
	methods 
		function obj = Board(level)
			switch level
				case level == 1
					brd = zeros(7,7);
				case level == 2
					brd = zeros(7,9);
				case level == 3
					brd = zeros(9,9);		
			end
		end
		
		function getBoard()
			return brd
		end
		
		%places neuron on the board
		function placeNeuron(obj,nrn)
			[nLen, nWid] = size(nrn);
			[bLen, bWid] = size(obj.brd);
			top = randi(bLen-nLen); %logic?
			left = randi(bWid-nWid); %logic?
			obj.brd(top:top+nLen,left:left+nWid) = nrn;
		end
		
	end
	
	%game play code
	methods
		%code tells if any part of the neuron is at this location
		function bl = isNrn(obj,x,y)
			bl = obj.brd(x,y) > 0;
		end		
	end
	
	
end