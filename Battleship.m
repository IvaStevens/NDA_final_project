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
            obj.score = 20;
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
            obj.score = obj.score -1;
        end
        
        function str =  getHint2(obj)
            str = obj.faq.getHint2();
            obj.score = obj.score -1;
        end
        
        function str = getnextquest(obj)
            %str =  'Welcome to Battleship: Neuron';
            str = obj.faq.getNextQuestion;
        end
        
        function out = checkans(obj, str)
            obj.faq.setUserResponse(str); % write this. set new variable in Question function
            check = obj.faq.answerQuestion;
            scr = obj.score;
            if check
                out = 'Correct! Press Continue';
                obj.score = scr + 5;
                if strcmp(strtrim(getAnswer(obj.faq)), '@hard1')
                    out = 'Press Continue';
                    obj.score = scr;
                end
                if strcmp(strtrim(getAnswer(obj.faq)), '@KeyPressed')
                    out = 'Press Continue';
                    obj.score = scr;
                end
            else
                last = obj.faq.getQuestion(); %logic
                out = ['Sorry. Try again. ',last];                
                obj.score = scr - 2;
            end
        end
        
        function updateGuesses(obj, guess)
            % assert guess within range
            % assert guess not repeated
            obj.guesses = [obj.guesses, guess];
        end
        
        function A = getAxnLoc(obj)
            % returns boolean matrix that refernces whether or not the axon
            % hillock could be here
            % calculated by considering size of matrix and whether or not
            % the locations guessed would barr this loctation
            nrn = abs(obj.neuron.getNeuron); % neuron matrix
            [nLen, nWid] = size(nrn);
            [bLen, bWid] = size(obj.board.board);
            nrnMask = rot90(rot90(nrn == 0))+0; %1 => where it can be; +0 turns logical to int
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
            ind = find(obj.board.board);
            wng = obj.guesses;
            wng(ismember(wng,ind)) = [];
            sft = 5;
            bigTemp = zeros(sft+bWid,sft+bLen);
            bigTemp(sft:sft+bLen-1,sft:sft+bWid-1) = temp;
            if nGes > 0
                for j = 1: nGes
                    s = wng(j);
                    gX = mod(s,bWid);
                    gY = ceil(s/bWid);
                    bX = gX + sft;
                    bY = gY + sft;
                    k = nrn == 2;
                    nX = mod(k,nWid);
                    nY = ceil(k/nWid);
                    tp = bX + nX -1; 
                    lf = bY + nY -1; 
                    bigTemp(tp:tp+nLen-1,lf:lf+nWid-1)...
                        = bigTemp(tp:tp+nLen-1,lf:lf+nWid-1)+ nrnMask;
                end
                temp = bigTemp(sft:sft+bWid-1,sft:sft+bLen-1);
            end
            % %             if nGes > 0
            % %                 for j = 1: nGes
            % %                     if temp(obj.guesses(j)) ~= 0
            % %                         gX = mod(j,bWid);
            % %                         gY = ceil(j/bWid);
            % %                         k = nrn == 2;
            % %                         nX = mod(k,nWid);
            % %                         nY = ceil(k/nWid);
            % %                         tp = gX + nX -1; %logic?
            % %                         lf = gY + nY -1; %logic?
            % %                         temp(tp:tp+nLen-1,lf:lf+nWid-1)...
            % %                             = temp(tp:tp+nLen-1,lf:lf+nWid-1)+ nrnMask;
            % %                     end
            % %                 end
            % %             end
            A = find(temp);
        end
    end
    
end
