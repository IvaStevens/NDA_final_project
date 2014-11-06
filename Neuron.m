classdef Neuron < Board
    properties
                
    end
	
	methods 
		function obj = Neuron
		end
	end
	
	methods
		function nrn = getNueron(level)
			switch level
				case level == 1
					nrn = [ 1 0 0 0 0;...
							1 1 2 1 1;...
							1 0 0 0 0];
				
				case level == 2
					nrn = [ 0 1 0 0 0;...
							1 1 2 1 1;...
							0 0 0 1 0];
				
				case level == 3
					nrn = [ 0 0 0 1 0;...
							1 1 2 1 1;...
							0 0 1 0 0];			
		end
	end
	
end
