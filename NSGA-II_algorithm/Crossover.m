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
% "Simulated Binary Crossover" (SBX),
% Combinar aleatoriamente elementos de los vectores de entrada para 
% crear nuevos vectores que combinen características de los vectores originales.
function [y1, y2,y3] = Crossover(x1, x2,x3)

    % vector de números aleatorios generados para cada elemento de los 
    % vectores de entrada, con una distribución que se centra alrededor de 0.5. 
    % Esto significa que los hijos tendrán en promedio la mitad de los valores de cada padre, 
    % pero con cierta variación aleatoria.
    alpha = rand(size(x1));
    
    y1 = alpha.*x1+(1-alpha).*x2;
    y2 = alpha.*x2+(1-alpha).*x1;
    y3 = alpha.*x3+(1-alpha).*x3;
    
end