classdef Battleship < handle
    
    properties
        notebook
        score
        board
        level
        neuron
        faq
        guesses % For simplicity sake: Keeping guesses as an index
    end
    
    methods
        %startup code
        function  obj = Battleship()
            %lvl = Level.Easy; % Logic?
            obj.score = 0;
            %obj.setLevel(lvl)
        end
        
        function setLevel(obj,lName)
            if strcmp(lName,'Easy')
                lvl = Level.Easy;
            end
            if strcmp(lName,'Medium')
                lvl = Level.Medium;
            end
            if strcmp(lName,'Hard')
                lvl = Level.Hard;
            end
            obj.level = lvl;
            obj.board = Board(lvl);
            obj.neuron = Neuron(lvl);
            nrn = obj.neuron.getNeuron;
            obj.board.placeNeuron(nrn);
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
            %check = true;
            if check
                out = 'Correct! Press Continue';
            else
                last = obj.faq.getQuestion(); %logic
                out = ['Sorry. Try again. \n',last];
            end
        end
        
        function updateGuesses(obj, guess)
            % assert guess within range
            % assert guess not repeated
            obj.guesses = [obj.guesses, guess];
        end
        
        function prob = calc_probabilty_nrn(obj)
            % This function uses the design of the neuron, the size of the board, and previous guesses
            % to determine a matix of values that corresponds to the probability that the neuron is located
            % at any given spot.
            nrn = abs(obj.neuron.getNeuron); % neuron matrix
            [nLen, nWid] = size(nrn);
            n = sum(nrn > 0);
            nrnMask = int(rot90(rot90(nrn == 0))); %1 => where it can be
            f = find(nrn);
            m = zeros(bLen, bWid, n);
            for i = 1:n
                temp = ones(bLen, bWid); % 1 => where the point could be
                pt = f(n);
                top = ceil(pt/bWid);
                
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
                if left ~= 1
                    temp(:,1:lft-1) = 0;
                end
                
                % remove right side
                if lft ~= nWid
                    rgt = nWid - lft;
                    temp(:, bWid - (rgt - 1): bWid) = 0;
                end
                
                % remove space around guesses
                nGes = length(obj.guesses);
                for j = 1: nGes
                    if temp(obj.guesses(j)) ~= 0
                        %gX = 
                        %gY = 
                        tp = -1; %logic?
                        lf = -1; %logic?
                        temp(tp:tp+nLen-1,lf:lf+nWid-1) = nrnMask;
                    end
                end
                m(:,:,i) = temp;
            end
            s = sum(m,3);
            tot = sum(sum(m));
            prob = s/tot;
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
