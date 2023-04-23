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
% Cuanto mayor sea la distancia de agrupamiento de una solución, 
% mayor será la probabilidad de que se seleccione para la siguiente generación
function pop = CalcCrowdingDistance(pop, F)

    nF = numel(F); % Se inicializa con el número de frentes no dominados.
    
    for k = 1:nF % Itera sobre todos los frentes no dominados.
        
        Costs = [pop(F{k}).Cost]; 
        % Se inicializa con las costos de las soluciones en el k-ésimo frente no dominado.
        
        nObj = size(Costs, 1);
        % Se inicializa con el número de objetivos
        
        n = numel(F{k});
        % Se inicializa con el número de soluciones en el k-ésimo frente no dominado.
        
        d = zeros(n, nObj);
        % Se inicializa la matriz de distancias con ceros.
        
        for j = 1:nObj % Itera sobre todos los objetivos.
            
            [cj, so] = sort(Costs(j, :));
            % cj contiene los costos del objetivo j ordenados de menor a mayor, 
            % y so contiene los índices correspondientes.
            
            d(so(1), j) = inf;
            % Se establece la distancia de la primera solución en el objetivo 
            % j como infinito para evitar que se seleccione como la solución óptima.
            
            % Se calcula la distancia de hacinamiento de las soluciones restantes en el objetivo j.
            for i = 2:n-1
                
                % Se calcula la distancia de la i-ésima solución en el objetivo j.
                d(so(i), j) = abs(cj(i+1)-cj(i-1))/abs(cj(1)-cj(end));
                
            end
            
            d(so(end), j) = inf;
            % Se establece la distancia de hacinamiento de la última solución 
            % en el objetivo j como infinito para evitar que se seleccione como la solución óptima.
        end
        
        % Itera sobre todas las soluciones en el k-ésimo frente no dominado.
        for i = 1:n
            
            % Se establece la distancia de la i-ésima solución en el k-ésimo 
            % frente no dominado como la suma de todas las distancias de los objetivos.
            pop(F{k}(i)).CrowdingDistance = sum(d(i, :));
            
        end
        
    end


end

