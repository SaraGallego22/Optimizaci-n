%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA120
% Project Title: Non-dominated Sorting Genetic Algorithm II (NSGA-II)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, NSGA-II in MATLAB (URL: https://yarpiz.com/56/ypea120-nsga2), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [pop, F] = NonDominatedSorting(pop)

    % Se determina el tamaño de la población.
    nPop = numel(pop);

    % Se inicializan los conjuntos de dominación 
    % y los recuentos de dominación para cada individuo en la población.
    for i = 1:nPop
        pop(i).DominationSet = [];
        pop(i).DominatedCount = 0;
    end
    
    % Se inicializa la matriz de frentes no dominados.
    F{1} = [];
    
    % Se itera sobre cada par de individuos en la población 
    % y se determina quién domina a quién utilizando la función Dominates
    for i = 1:nPop
        for j = i+1:nPop
            p = pop(i);
            q = pop(j);
            
            % Si el individuo p domina al individuo q, se agrega j
            % al conjunto de dominación de p y se incrementa el recuento de dominación de q
            if Dominates(p, q)
                p.DominationSet = [p.DominationSet j];
                q.DominatedCount = q.DominatedCount+1;
            end
            
            % Si q domina a p, se agrega i al conjunto de dominación de q 
            % y se incrementa el recuento de dominación de p
            if Dominates(q.Cost, p.Cost)
                q.DominationSet = [q.DominationSet i];
                p.DominatedCount = p.DominatedCount+1;
            end
            
            pop(i) = p;
            pop(j) = q;
        end
    
        % Si un individuo no es dominado por ningún otro en la población, 
        % se agrega al frente no dominado F{1} y se le asigna un rango de 1.
        if pop(i).DominatedCount == 0
            F{1} = [F{1} i];
            pop(i).Rank = 1;
        end
    end
    
    k = 1;

    while true
        
        Q = [];
        
        % Se itera sobre cada individuo en el frente no dominado actual F{k} 
        % y se disminuye el recuento de dominación de cada uno de los individuos en su conjunto de dominación.
        for i = F{k}
            p = pop(i);
            
            for j = p.DominationSet
                q = pop(j);
                
                q.DominatedCount = q.DominatedCount-1;
                
                % Si el recuento de dominación de algún individuo se reduce a cero, 
                % se agrega a la siguiente matriz de frentes no dominados F{k+1} y se le asigna un rango de k+1
                if q.DominatedCount == 0
                    Q = [Q j]; 
                    q.Rank = k+1;
                end
                
                pop(j) = q;
            end
        end
        
        if isempty(Q)
            break;
        end
        
        F{k+1} = Q; %#ok
        
        k = k+1;
        
    end
    % El proceso se repite hasta que no haya más frentes no dominados a los que agregar individuos.

end