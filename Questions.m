classdef Questions < handle
% This class is responsible for observing teh users response and determinig
% if it is correct by calculating the correct response.
% During main game play of the 'hard' level this class will obtain the
% probability distributions for each square and report back to the
% Battleship class what the user guessed such that it can change the color
% of the squares depending on if the guess was good or not.
% Otherwise this class will return 'true' or 'false' to the Battleship class
% such thhat the player's score can be updated and teh next question can be
% asked
    properties
        qList %questions:   {['q1'],['q2'],['q3'],...,['qN']}
        aList %answers:     {['a1'],['a2'],['a3'],...,['aN']}
        hList %hints:       {['h1'],['h2'],['h3'],...,['hN']}
        fList %formulas:    {['f1'],['f2'],['f3'],...,['fN']}
		qNum = 0;
        current = {}; % {['question'],['answerFunctionName'],['formuls'],['hints']} 
        game
    end        
     
	methods
		function obj = Questions(g)
            obj.game = g; %handle back to main battleship game
            % upload matfile or excel file with all questions and answers
            % populate the lists.
            
            obj.current = cell(4);
        end
        
        % Determines what thte next question to display is and maintains
        % the current values for things such like the hints, question
        function q = getNextQuestion(obj)
            n = obj.qNum + 1;
            if n > len(alist)
                q  = {};
                return
            end
            obj.current(1) = obj.qList(n); %Prolly a cleaner way to do this...
            obj.current(2) = obj.aList(n);
            obj.current(3) = obj.hList(n);
            obj.current(4) = obj.fList(n);
            obj.qNum = n;
            q = getQuestion;
        end
        
        % Proably a cleaner way to handle these...
        function q = getQuestion(obj)
            q = obj.current(1);
        end
        
        function a = getAnswer(obj)
            a = obj.current(2);
        end
        
        function h = getHint(obj)
            h = obj.current(3);
        end
        
        function f = getFormula(obj)
            f = obj.current(4);
        end
        
        function answer = answerQuestion(obj)
            % this is the main code body for determining what the correct
            % answer to a given question is.
            
            % funcName = getAnswer(obj); 
            funcName = 'KeyPressed'; % for Debugging
            funcptr = str2func(funcName);
            answer = funcptr(obj);
        end
    end
    
    % Resolution functions, all main functions return a value anr which is
    % the correct answer to the question, and they only take in the obj.
    % resolution function are in charge of determinig the correct response,
    % and if the user response anr is a boolean
    methods
        % Go to next question. null answer
        function anr = KeyPressed(obj)
            anr = true; 
        end
        
        % Count squares of Neuron
        function anr = NeuronSize(obj)
            corrAns = sum(obj.game.neuron.getNeuron);    
            userAns = frac2num(); % Logic
            anr = corrAns == userAns;
        end
        
        % include recent location guess to the guesses array
        function anr = NewGuess(obj)
            % wait for user response
            % save in guess array of Battleship
            % return null answer
            anr = [];
        end
        
    end
    
    %Various helper functions
    methods
        % I want this function to parse the string response from the user
        % and evaluate it in matlab it if contains a division symbol. '\'
        % and otherwise just return the decimal value
        function numResult = frac2num(str)
            numResult = str2num(str);
        end
    end
end



