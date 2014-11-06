classdef Battleship < handle
    
    properties
        notebook
        score
        board
        level
		neuron
		faq
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
	end
    
end