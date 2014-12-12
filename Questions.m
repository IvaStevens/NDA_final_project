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
        h1List %hint 1:     {['h1'],['h2'],['h3'],...,['hN']}
        h2List %hint 2:     {['f1'],['f2'],['f3'],...,['fN']}
        qNum = 0;
        current = {}; % {['question'],['answerFunctionName'],['hint1'],['hint2']}
        game
        resp
    end
    
    methods
        function obj = Questions(g)
            obj.game = g; %handle back to main battleship game
            % upload matfile or excel file with all questions and answers
            % populate the lists.
            
            filename = 'questions.xlsx';
            if obj.game.level == Level.Easy
                % may need to add 'basic' after column range if using a
                % Unix system
                [~,obj.qList,~] = xlsread(filename, 'easy', 'A3:A40', 'basic'); % filename, level sheet, column
                [~,obj.aList,~] = xlsread(filename, 'easy', 'B3:B40', 'basic');
                [~,obj.h1List,~] = xlsread(filename, 'easy', 'C3:C40', 'basic');
                [~,obj.h2List,~] = xlsread(filename, 'easy', 'D3:D40', 'basic');
            end
            
            if obj.game.level == Level.Medium
                % may need to add 'basic' after column range if using a
                % Unix system
                [~,obj.qList,~] = xlsread(filename, 'medium', 'A3:A33'); % filename, level sheet, column
                [~,obj.aList,~] = xlsread(filename, 'medium', 'B3:B33');
                [~,obj.h1List,~] = xlsread(filename, 'medium', 'C3:C33');
                [~,obj.h2List,~] = xlsread(filename, 'medium', 'D3:D33');
            end
            
            if obj.game.level == Level.Hard
                % may need to add 'basic' after column range if using a
                % Unix system
                [~,obj.qList,~] = xlsread(filename, 'hard', 'A3:A40'); % filename, level sheet, column
                [~,obj.aList,~] = xlsread(filename, 'hard', 'B3:B40');
                [~,obj.h1List,~] = xlsread(filename, 'hard', 'C3:C40');
                [~,obj.h2List,~] = xlsread(filename, 'hard', 'D3:D40');
            end
            
            obj.current = cell(4);
        end
        
        function setUserResponse(obj,str)
            obj.resp = str;
        end
        % Determines what thte next question to display is and maintains
        % the current values for things such like the hints, question
        function q = getNextQuestion(obj)
            n = obj.qNum + 1;
            if n > length(obj.aList)
                q  = {};
                return
            end
            obj.current(1) = obj.qList(n); %Prolly a cleaner way to do this...
            obj.current(2) = obj.aList(n);
            obj.current(3) = obj.h1List(n);
            obj.current(4) = obj.h2List(n);
            obj.qNum = n;
            q = obj.getQuestion;
        end
        
        % Proably a cleaner way to handle these...
        function q = getQuestion(obj)
            q = obj.current(1);
        end
        
        function a = getAnswer(obj)
            a = obj.current{2};
        end
        
        function h = getHint1(obj)
            h = obj.current(3);
        end
        
        function f = getHint2(obj)
            f = obj.current(4);
        end
        
        function answer = answerQuestion(obj)
            % this is the main code body for determining what the correct
            % answer to a given question is.
            funcName = strtrim(getAnswer(obj));
            %funcName = 'KeyPressed'; % for Debugging
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
        
        function anr = findNrn(obj)
            anr = ginput2(5);
        end
        
        function anr = probNrn(obj)
            anr = false; %LOGIC
        end
        
        function anr = clickable(obj)
            %corrAnr = obj.game.Somehting;  %LOGIC
            corrAnr = [1 2 3]; %Logic
            l = length(corrAnr);
            temp = [];
            old = obj.game.board.board;
            while length(temp) ~= l
                [x,y] = ginput2(1);
                guess = obj.convertGuess(x,y);
                if ismember(guess,corrAnr) && ~ismember(guess,temp)
                    temp = [temp,guess];
                    %show correct guesses
                    obj.game.board.board(guess) = 1; %Logic does screen refresh?
                end
            end
            %reset board
            obj.game.board.board = old;
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
        
        % sets the new level at end of easy and medium levels
        function anr = setNextLevel(obj)
            if isempty(strfind(lower(obj.resp), 'ready'))
               anr = false;
            else
               anr = true;
               if obj.game.level == Level.Easy
                   obj.game.setLevel('Medium');
               else
                   obj.game.setLevel('Hard');
               end
            end
        end
        
    end
    
    %functions for Easy Level
    methods
        function anr = anrYes(obj)
            if isempty(strfind(lower(obj.resp), 'y'))
                anr = false;
            else
                anr = true;
            end
        end
        
        function anr = anrNo(obj)
            if isempty(strfind(lower(obj.resp), 'n'))
                anr = false;
            else
                anr = true;
            end
        end
        
        function anr = probArry(obj)
            [x, y] = size(obj.game.board.board);
            if str2num(obj.resp) == 1/(x * y)
                anr = true;
            else
                anr = false;
            end
        end
        
        function anr = sizeNrn(obj)
            %find the size of the neuron, and subtract the number of 0
            %cells
            ourNrn = obj.game.neuron.getNeuron;
            [x, y] = size(ourNrn);
            if str2num(obj.resp) == x * y - sum(ourNrn(:)==0)
                anr = true;
            else
                anr = false;
            end
        end
        
        function anr = probAxnNrn(obj)
            ourNrn = obj.game.neuron.getNeuron;
            [x, y] = size(ourNrn);
            if str2num(obj.resp) == (sum(ourNrn(:)==2))/(x * y - sum(ourNrn(:)==0))
                anr = true;
            else
                anr = false;
            end
        end
        
        function anr = probAxonAH(obj)
            ourNrn = obj.game.neuron.getNeuron;
            [x, y] = size(ourNrn);
            if str2num(obj.resp) == (sum(ourNrn(:)==2) + sum(ourNrn(:)==-1))/(x * y - sum(ourNrn(:)==0))
                anr = true;
            else
                anr = false;
            end
        end
        
        function anr = probDendriteAH(obj)
            ourNrn = obj.game.neuron.getNeuron;
            [x, y] = size(ourNrn);
            if str2num(obj.resp) == (sum(ourNrn(:)==2) + sum(ourNrn(:)==1))/(x * y - sum(ourNrn(:)==0))
                anr = true;
            else
                anr = false;
            end
        end
        
        function anr = probAxonDendrite(obj)
            if str2num(obj.resp) == 6/7
                anr = true;
            else
                anr = false;
            end
        end
        
        
        
    end
    
    %functions for Medium Level
    methods
        function anr = findAxnHil(obj)
            obj.game.click = true;
            obj.game.guesses = [];
            corrAnr = obj.game.getAxnLoc;
            len = length(corrAnr);
            old = obj.game.board.shown;
            while sum(ismember(corrAnr,obj.game.guesses)) < len
                good = obj.game.guesses(ismember(obj.game.guesses,corrAnr));
                obj.game.board.shown(good) = 1;
                pause(.001)
            end
            good = obj.game.guesses(ismember(obj.game.guesses,corrAnr));
            obj.game.board.shown(good) = 1;
            pause(.01);
            %reset old board
            %obj.game.board.shown = old;
            obj.game.guesses = [];
            %obj.game.click = false;
            anr = true;
        end
        function anr = probAxnHil(obj)
            obj.game.click = false;
            obj.game.guesses = [];
            [a,b] = size(obj.game.board.board);
            nElec =  a*b;%number of electrodes
            corrAnr = length(obj.game.getAxnLoc) / nElec;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
            obj.game.board.shown = zeros(size(obj.game.board.board));
            obj.game.board.shown(34) = .5;
            obj.game.board.shown(40) = 1;
        end
        
        % Number questions
        function anr = four25ths(obj)
            corrAnr = 4/25;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
        end
        function anr = four6ths(obj)
            corrAnr = 4/6;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
        end
        function anr = two9ths(obj)
            corrAnr = 2/9;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
        end
        function anr = six25ths(obj)
            corrAnr = 6/25;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
        end
        function anr = eighteen25ths(obj)
            corrAnr = 18/25;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
        end
        function anr = seven25ths(obj)
            corrAnr = 7/25;
            res = str2num(obj.resp);
            if  abs(res - corrAnr) <  8.0000e-04 %LOGIC
                anr = true;
            else
                anr = false;
            end
        end
    end
    
    %functions for Hard questions
    methods
        function anr = hard1(obj)
            global contNum
            % ask to click location
            obj.game.click = true;
            len = length(obj.game.guesses);
            while length(obj.game.guesses) == len
                pause(1);
            end
            % if part of the nrn was found let them click around until the
            ind = find(obj.game.board.board); %indices of nrn
            
            if sum(ismember(ind,obj.game.guesses)) > 0
                while sum(ismember(ind,obj.game.guesses)) < length(ind)
                    pause(.001)
                end
                contNum = 101; 
            end
            % rest of the nrn is found then game over.
            % turn off click
            obj.game.click = false;
            anr = true;
        end
        
        function anr = hard2(obj)
            % ask to calculate probability nrn is there
            I = obj.game.guesses(end);
            res = obj.resp;
            ind = find(obj.game.board.board); %indices of nrn
            if ismember(I,ind)
                corrAnr = 1/obj.game.getAxnLoc;
            else
                corrAnr = 0;
            end
            %check answer
            if  abs(res - corrAnr) <  8.0000e-04 
                anr = true;
            else
                anr = false;
            end
        end
        
        function anr = hard3(obj)
            I = obj.game.guesses(end);
            % told if nrn is there
            % change color for point of current guess
            if obj.game.board.board(I)
                obj.game.board.shown(I) = .5;
            end
            % set variable if entire nrn found to end game
            nrn = find(obj.game.board.board); %Logic
            nlen = length(nrn);
            if sum(ismember(nrn,obj.game.guesses)) == nlen
                obj.game.contNum = 102; %Logic
            end
            % edit shownBoard
            anr = true;
        end
        function anr = GameOver(obj)
            global contNum
            contNum = contNum + 101;
            anr = true;
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
        
        
        function I = convertGuess(obj, x, y)
            %function takes the x,y location and returns the index number for
            %the board square that it corresponds to.
            [r, ~] = size(obj.game.board.board);
            %I = round(x) + (round(y)-1) * c;
            I = (ceil(x-.5)-1)*r + ceil(y-.5);
        end
    end
end



