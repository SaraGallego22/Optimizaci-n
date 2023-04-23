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
% Gráfica sus costos en un gráfico tridimensional.
function PlotCosts(pop)
    % Extrae los costos de cada individuo en la población 
    Costs = [pop.Cost];
    
    scatter3(Costs(1,:), Costs(2,:), Costs(3,:), 'r*', 'SizeData', 8);
    
    xlabel('1^{st} Prod energía eólica');
    ylabel('2^{nd} Prod energía solar');
    zlabel('3^{rd} Costos fijos del sistema');
    title('Optimizar planta de energía');
    grid on;
    
end