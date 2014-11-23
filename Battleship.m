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
            lvl = Level.Easy; %syntax?
            obj.level = lvl;
            obj.board = Board(lvl);
            obj.neuron = Neuron(lvl);
            nrn = obj.neuron.getNeuron;
            obj.board.placeNeuron(nrn);
            obj.score = 0;
            %obj.Play
            obj.faq = Questions(obj);
        end
        
        %This function should pull the next question/answer set
        %from the questions class. It will repetively call for these
        % such that they can be displayed.
        function Play(obj)
            q = obj.faq.getNextQuestion();
            while ~isempty(q)
                % keep playing?
                % wait for user response
                % send to questions class
                % update score
            end
            % Say GameOver ad show final score
        end
        
        function updateGuesses(obj, guess)
            % assert guess within range
            % assert guess not repeated
            obj.guesses = [obj.guesses, guess];
        end
        
        function calc_probabilty_nrn(obj)
            % This function uses the design of the neuron, the size of the board, and previous guesses
            % to determine a matix of values that corresponds to the probability that the neuron is located
            % at any given spot.
            
            nrn = []; % neuron matrix
            n = sum(nrn > 0);
            nrnMask = rot90(rot90(nrn));
            
            m = zeros(bLen, bwid, n);
            for i = 1:n
                
            end
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
            % returns boolean matrix that refernces whether or not the axon
            % hillock could be here
            % calculated by considering size of matrix and whether or not
            % the locations guessed would barr this loctation
        end
    end
    
end
