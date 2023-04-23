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

function [pop, F] = SortPopulation(pop)

    % Se ordenan por la distancia de agrupamiento, de manera descendente
    [~, CDSO] = sort([pop.CrowdingDistance], 'descend');
    % CDSO es un vector con los índices de los individuos de pop ordenados por distancia de agrupamiento.
    pop = pop(CDSO);
    
    % Se ordenan por su rango (Rank), de manera ascendente.
    [~, RSO] = sort([pop.Rank]);
    pop = pop(RSO);
    
    % Actualizar fronteras
    % Se busca el valor máximo del rango en la población y se itera desde 1 
    % hasta ese valor, obteniendo los índices de los individuos 
    % que pertenecen a cada frente y almacenándolos en un elemento de la celda.
    Ranks = [pop.Rank];
    MaxRank = max(Ranks);
    F = cell(MaxRank, 1);
    for r = 1:MaxRank
        F{r} = find(Ranks == r);
    end

end