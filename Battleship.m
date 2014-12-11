classdef Battleship < handle
    
    properties
        notebook
        click
        score
        board
        level
        neuron
        faq
        contNum
        guesses % For simplicity sake: Keeping guesses as an index
    end
    
    methods
        %startup code
        function  obj = Battleship()
            %lvl = Level.Easy; % Logic?
            obj.score = 102;
            %obj.setLevel(lvl)
        end
        
        function setLevel(obj,lName)
            if strcmp(lName,'Easy')
                lvl = Level.Easy;
                cNum = 0;
            end
            if strcmp(lName,'Medium')
                lvl = Level.Medium;
                cNum=42;
            end
            if strcmp(lName,'Hard')
                lvl = Level.Hard;
                cNum=69;
            end
            obj.level = lvl;
            obj.board = Board(lvl);
            obj.neuron = Neuron(lvl);
            nrn = obj.neuron.getNeuron;
            obj.board.placeNeuron(nrn);
            obj.faq = Questions(obj);
            obj.contNum=cNum;
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
            % Say GameOver and show final score
        end
        
        function str =  getHint1(obj)
            str = obj.faq.getHint1();
        end
        
        function str =  getHint2(obj)
            str = obj.faq.getHint2();
        end
        
        function str = getnextquest(obj)
            %str =  'Welcome to Battleship: Neuron';
            str = obj.faq.getNextQuestion;
        end
        
        function out = checkans(obj, str)
            obj.faq.setUserResponse(str); % write this. set new variable in Question function
            check = obj.faq.answerQuestion;
            if check
                out = 'Correct! Press Continue';
                if strcmp(strtrim(getAnswer(obj.faq)), '@hard1')
                    out = 'Press Continue';
                end
                if strcmp(strtrim(getAnswer(obj.faq)), '@KeyPressed')
                    out = 'Press Continue';
                end
            else
                last = obj.faq.getQuestion(); %logic
                out = ['Sorry. Try again. ',last];
            end
        end
        
        function updateGuesses(obj, guess)
            % assert guess within range
            % assert guess not repeated
            obj.guesses = [obj.guesses, guess];
        end
       
        function M = calcProbMat(obj)
            A = getAxnLoc(obj);
        end
        
        function A = getAxnLoc(obj)
            % returns boolean matrix that refernces whether or not the axon
            % hillock could be here
            % calculated by considering size of matrix and whether or not
            % the locations guessed would barr this loctation
            nrn = abs(obj.neuron.getNeuron); % neuron matrix
            [nLen, nWid] = size(nrn);
            [bLen, bWid] = size(obj.board.board);
            n = sum(nrn > 0);
            nrnMask = rot90(rot90(nrn == 0))+0; %1 => where it can be; +0 turns logical to int
            f = find(nrn);
            temp = ones(bLen, bWid); % 1 => where the point could be
            pt = find(rot90(rot90(nrn)) == 2);
            top = ceil(pt/nWid);
            
            % remove top row if necessary
            if top ~= 1
                temp(1:top-1,:) = 0;
            end
            
            % remove bottom row if necessary
            if top ~= bLen
                bot = nLen-top;
                temp(bLen-(bot-1):bLen,:) = 0;
            end
            
            % remove left side
            lft = mod(pt,nWid);
            if lft ~= 1
                temp(:,1:lft-1) = 0;
            end
            
            % remove right side
            if lft ~= nWid
                rgt = nWid - lft;
                temp(:, bWid - (rgt - 1): bWid) = 0;
            end
            
            % remove space around guesses
            nGes = length(obj.guesses);
            if nGes > 0
                for j = 1: nGes
                    if temp(obj.guesses(j)) ~= 0
                        gX = mod(j,bWid);
                        gY = ceil(j/bWid);
                        k = nrn == 2;
                        nX = mod(k,nWid);
                        nY = ceil(k/nWid);
                        tp = gX + nX -1; %logic?
                        lf = gY + nY -1; %logic?
                        temp(tp:tp+nLen-1,lf:lf+nWid-1)...
                            = temp(tp:tp+nLen-1,lf:lf+nWid-1)+ nrnMask;
                    end
                end
            end
        A = find(temp);  
        end
    end
    
end
