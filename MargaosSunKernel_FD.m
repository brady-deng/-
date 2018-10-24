function MSFD = MargaosSunKernel_FD (serie,type,h,Kmax)
%% Description:
%{
Function with the Kernel of Margaos-Sun Fractal Dimension (MSFD).

For more information see: Margaos and Sun, 'Measuring the Fractal Dimension
of Signals: Morphological Covers and Iterative Optimization'.

INPUT: 
    serie: the signal or part of the signal that we want to analyze by
    means of MS_FD.

    type: it can be 1, 2 or 3. This variable indicates the type of set 
    structuring element and its associated function g employed for
    computing the dilations and erosions of the signal. 
        '1': a segment.
        '2': a square.
        '3': a rhombus. 

    h: a parameter used in the cases of type '2' and type '3'. h >= 0.
    Recommended, h = 0.001 o h = 0.01.

    Kmax: the max. scale.

OUTPUT:
    MSFD: the Margaos-Sun fractal dimension of the signal.

PROJECT: Research Master in signal processing and bioengineering - University of Valladolid

DATE: 22/07/2014

AUTHOR: Jesús Monge Álvarez
%}

%% Selecting the structuring element: 
if type == 1 %The structure element is a segment. 
% Defining the associated function g: (STEP 1)
     g = [0 0 0]; %g[n] = 0 for n = -1, 0, 1
                 %g[n] = -Inf for n != -1, 0, 1  
else if type == 2
        g = [h h h]; %g[n] = 0 for n = -1, 0, 1
                     %g[n] = -Inf for n != -1, 0, 1
    else if type == 3
            g = [0 h 0]; %g[n] = 0 for n = -1, 1 y g[n] = h for n = 0
                         %g[n] = -Inf for n != -1, 0, 1
        end
    end
end

%% We perform recursively the support-limited dilations and erosions of the 
% signal by g at different scales. (STEP 2)
N = length(serie);
dilations = NaN(Kmax,N);
erosions = NaN(Kmax,N);
% The first scale is different:
aux = NaN(1,N);
aux2 = NaN(1,N-2);
for i = 2:(N-1)
    aux(i) = max([(serie(i-1) + g(1)), (serie(i) + g(2)), (serie(i+1) + g(3))]);
    aux2(i) = min([(serie(i-1) + g(1)), (serie(i) + g(2)), (serie(i+1) + g(3))]);
end
aux(1) = max((serie(1) + g(2)), (serie(2) + g(3)));
aux(N) = max((serie(N) + g(2)), (serie(N-1) + g(1)));
aux2(1) = min((serie(1) + g(2)), (serie(2) + g(3)));
aux2(N) = min((serie(N) + g(2)), (serie(N-1) + g(1)));
dilations(1,:) = aux;
erosions(1,:) = aux2;

% The remaining scales: 
previous_dila = NaN(1,N);
previous_eros = NaN(1,N);
for d = 2:Kmax
    aux = NaN(1,N);
    aux2 = NaN(1,N-2);
    previous_dila = dilations((d-1),:);
    previous_eros = erosions((d-1),:);
    for i = 2:(N-1)
        aux(i) = max([previous_dila(i-1), previous_dila(i), previous_dila(i+1)]);
        aux2(i) = min([previous_eros(i-1), previous_dila(i), previous_eros(i+1)]);
    end
    aux(1) = max((previous_dila(1) + g(2)), (previous_dila(2) + g(3)));
    aux(N) = max((previous_dila(N) + g(2)), (previous_dila(N-1) + g(1))); 
    aux2(1) = min((previous_dila(1) + g(2)), (previous_dila(2) + g(3)));
    aux2(N) = min((previous_dila(N) + g(2)), (previous_dila(N-1) + g(1)));
    
    dilations(d,:) = aux;
    erosions(d,:) = aux2;
end

%% Now, we compute the cover area for each scale (STEP 3):
Area = NaN(1,Kmax);

for i = 1:Kmax
    dif = NaN(1,N);
    dif = dilations(i,:) - erosions(i,:);
    Area(i) = sum(dif);
end

%% We estimate the MSFD as: (STEP 4)
d = [1:Kmax];
D = d .* 2 ./ N;
b = D.^2;
c = Area ./ b;
c2 = log(c);
e = log(1./D);

f = polyfit(e, c2, 1);
MSFD = f(1); %We only want the slope, not the independent term.

