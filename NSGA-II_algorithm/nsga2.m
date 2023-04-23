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

clc;
clear;
close all;

%% Problem Definition
%Funtions
CostFunction = @(x) [5.*(x(1).^2)./x(2); 0.1.*x(1).^3 + 2.*x(2).^2; 50.*x(1)+3.*x(2).^3];

nVar = 2;             % Número de variables de desición 

VarSize = [1 nVar];   % Tamaño de la matrix de variables de desición 

VarMin = 1;          % Cota inferior de las variables de desición
VarMax = 5;          % Cota superior de las variables de desición

% Número de funciones objetivo
nObj = numel(CostFunction(unifrnd(VarMin, VarMax, VarSize)));


%% NSGA-II Parameters

MaxIt = 100;      % Número máximo de iteraciones

nPop = 100;        % Tamaño de la población 

pCrossover = 0.5;                         % Probabilidad de cruce
nCrossover = 2*round(pCrossover*nPop/2);  % % Número de padres (descendientes)

pMutation = 0.1;                          % Porcentaje de mutación
nMutation = round(pMutation*1/nPop);        % Número de mutantes

mu = 0.02;                    % Tasa de mutación

sigma = 0.1*(VarMax-VarMin);  % Tamaño del paso de mutación


%% Initialization

empty_individual.Position = []; 
% Se usará para almacenar las posiciones de las variables de decisión de cada individuo en la población.
empty_individual.Cost = []; 
% Se usará para almacenar el costo de cada individuo en la población
empty_individual.Rank = []; 
% Se usará para almacenar la clasificación de cada individuo en la población
empty_individual.DominationSet = []; 
% Se usará para almacenar el conjunto de individuos dominados por cada individuo en la población.
empty_individual.DominatedCount = []; 
% Se usará para almacenar la cantidad de individuos que dominan a cada individuo en la población.
empty_individual.CrowdingDistance = []; 
% Se usará para almacenar la distancia de agrupamiento de cada individuo en la población.

pop = repmat(empty_individual, nPop, 1)
%Crea una población de nPop individuos 

%Crea la población inicial de nPop individuos y les asigna una posición y un costo
for i = 1:nPop
    
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    
    pop(i).Cost = CostFunction(pop(i).Position);
    
end

% Clasificación no dominada
% Divide a la población en varias capas
[pop, F] = NonDominatedSorting(pop);
%pop es la población ordenada de manera no dominada
%F es una celda que contiene los índices de los miembros de cada frente de Pareto.

% Cálcula la distancia de agrupamiento
% La distancia de agrupación se utiliza para medir la diversidad de la población
pop = CalcCrowdingDistance(pop, F);
% Devuelve la misma población con el campo CrowdingDistance de cada individuo 

% Ordenar población
% Se utiliza para ordenar una población de individuos en orden ascendente 
% de acuerdo a su "rango", que se asigna durante el proceso de "non-dominated sorting" 
[pop, F] = SortPopulation(pop);
% pop es ahora la población ordenada
%

%% NSGA-II Main Loop

% Bucle por número de iteraciones definido
for it = 1:MaxIt
    
    % Cruce
    % Se realiza la operación de cruce o crossover entre los individuos 
    popc = repmat(empty_individual, nCrossover/2, 2);
    % Se usará para almacenar los nuevos individuos 
    for k = 1:nCrossover/2
    % Iterar sobre los pares de padres que se seleccionan de la población actual.
    % En cada iteración, se seleccionan 3 padres aleatorios (p1, p2 y p3)
    % Se utiliza el operador de crossover para generar dos nuevos individuos (hijos) a partir de ellos. 
        i1 = randi([1 nPop]);
        p1 = pop(i1);
        
        i2 = randi([1 nPop]);
        p2 = pop(i2);
        
        i3 = randi([1 nPop]);
        p3 = pop(i3);
        
        [popc(k, 1).Position, popc(k, 2).Position] = Crossover(p1.Position, p2.Position, p3.Position);
        
        % Costos de estos nuevos individuos son evaluados
        popc(k, 1).Cost = CostFunction(popc(k, 1).Position);
        popc(k, 2).Cost = CostFunction(popc(k, 2).Position);
        
    end
    popc = popc(:);
    % Los costos de los nuevos individuos se evalúan y se almacenan en el campo Cost de cada individuo en popc.
    
    % Mutation
    popm = repmat(empty_individual, nMutation, 1);
    % Se genera una población nueva
    
    for k = 1:nMutation
        
        i = randi([1 nPop]);
        p = pop(i);
        
        popm(k).Position = Mutate(p.Position, mu, sigma);
        
        popm(k).Cost = CostFunction(popm(k).Position);
        % El resultado es un nuevo individuo que se agrega a la población 
        % junto con su costo calculado por la función objetivo 
    end
    
    % Merge
    % Se unen las tres poblaciones generadas previamente 
    pop = [pop
         popc
         popm]; 
     
    % Clasificación no dominada
    [pop, F] = NonDominatedSorting(pop);
    % Eetorna la población actualizada y los frentes no dominado F 

    % Calculate distancia de agrupamiento
    pop = CalcCrowdingDistance(pop, F);
    
    % Sort Population
    % Se ordena la población de acuerdo a la distancia de hacinamiento 
    % De modo que los individuos más cercanos al centro del frente estén primero.
    pop = SortPopulation(pop);
    
    % Truncate
    pop = pop(1:nPop);
    
    % Clasificación no dominada
    % Se realiza nuevamente la clasificación no dominada para la población truncada
    [pop, F] = NonDominatedSorting(pop);

    % Cálculo de distancia de agrupamiento
    % Se calcula la distancia de agrupamiento para cada individuo en la población truncada
    pop = CalcCrowdingDistance(pop, F);

    % Sort Population
    % Se ordena la población truncada de acuerdo a la distancia de agrupamiento
    % Los individuos más cercanos al centro del frente están primero
    [pop, F] = SortPopulation(pop);
    
    % Store F1
    % Se almacena el frente no dominado más cercano al origen, 
    % que corresponde al frente de Pareto más óptimo.
    F1 = pop(F{1});
    
    % Muetra de información de iteración 
    % Se muestra en la consola el número de miembros del frente de Pareto más óptimo en la iteración actual.
    disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
    
    % Plot F1 Costs
    % Gráfica de los costos del frente de Pareto más óptimo en la iteración actual.
    figure(1);
    PlotCosts(F1);
    %Plot2(F1);
    pause(0.01);
    
end

%% Results






