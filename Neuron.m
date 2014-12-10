classdef Neuron < handle
    properties
        level
    end
    
    methods
        function obj = Neuron(lvl)
            obj.level = lvl;
        end
    end
    
    methods
        function nrn = getNeuron(obj)
            lvl = obj.level;
            nrn = [];
            switch lvl
                case Level.Easy
                    nrn = [ 1 0 0 0 0;...
                            1 1 2 -1 -1;...
                            1 0 0 0 0];
                case Level.Medium
                    nrn = [ 0 1 0 0 0;...
                            1 1 2 -1 -1;...
                            0 0 0 -1 0];
                    
                case Level.Hard
                    nrn = [ 0 0 0 -1 0;...
                            1 1 2 -1 -1;...
                            0 0 1 0 0];
            end
        end
        
    end
end
