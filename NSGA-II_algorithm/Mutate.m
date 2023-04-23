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

function y = Mutate(x, mu, sigma)

    nVar = numel(x); % Cálcula el número de variables en el individuo 
    
    nMu = ceil(mu*nVar); % Calcula el número de variables que se van a mutar

    j = randsample(nVar, nMu); % Selecciona al azar nMu índices sin reemplazo
    % Si sigma es un vector con más de un elemento, 
    % se selecciona un subconjunto de sigma correspondiente a los índices j
    if numel(sigma)>1
        sigma = sigma(j);
    end
    
    y = x;
    
    % Agrega ruido gaussiano a los valores seleccionados de y
    % Para aumentar la diversidad de la población
    y(j) = x(j)+sigma.*randn(size(j));

end