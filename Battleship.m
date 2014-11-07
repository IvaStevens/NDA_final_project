classdef Battleship < handle
    
    properties
        notebook
        score
        board
        level
		neuron
		faq
		guesses % For simplicity sake: lets keep guesses as a single number to reference a location 
    end
	
	methods
	%startup code
		function  obj = Battleship()
			obj.level = Level.Easy; %syntax?
			obj.board = Board(level);
			obj.neuron = Neuron(level);
			obj.board.placeNeuron(obj.neuron);
			obj.score = 0;
			obj.Play
			obj.faq = Questions();
		end
		
		%This function should pull the next question.answer set
		%from the questions class. It will repeatively call for these
		% such that they can be displayed.
		function Play(obj)
			q = getNextQuestion()
			while ~isempty(q)
			%keep playing?
			end
		end
		
		function calc_probabilty_nrn(obj,guesses)
			% This function uses the design of the neuron, the size of the board, and previous guesses
			% to determine a matix of values that corresponds to the probability that the neuron is located
			% at any given spot.
		end
		
		function a = calc_probabilty_axn(obj,guesses)
			% This function uses the design of the neuron, the size of the board, and previous guesses
			% to determine a matix of values that corresponds to the probability that the neuron is located
			% at any given spot.
			H = hillock_locations(obj); % returns boolean matrix that refernces whether or not the axon hillock could be here
			H(guesses) = 0;
			uni = sum(sum(H)); % Cardinality of set for which axon could be. 
			a = H/uni;
		end
		
		function A = hillock_locations(obj)
		% returns boolean matrix that refernces whether or not the axon hillock could be here
		% calculated by considering size of matrix and whether
		end
	end
    
end