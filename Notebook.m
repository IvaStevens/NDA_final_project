classdef Notebook < handle
    
    properties
        hints
        badges
        formulas
        level
    end
    
    methods
        
        function obj=Notebook(lvl)
            obj.level=lvl;
        end
        
        function note = getText(obj)
            
            load('Notebook_Text.mat');
            
            if obj.level==Level.Easy
                note=NotebookText{1,1};
            elseif obj.level==Level.Medium
                note=NotebookText{2,1};
            elseif obj.level==Level.Hard
                note=NotebookText{3,1};
            else
                note='';
            end
                
            
        end
    end
    
end