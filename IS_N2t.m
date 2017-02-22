% Importance Sampling: Breaks.
% Simulate the 2nd Moment of a student's t-distribution given a normal
% proposals
% Jonas Latz, M.Sc.
% Lehrstuhl f?r Numerische Mathematik
% Fakult?t f?r Mathematik
% Technische Universit?t M?nchen
% jonas.latz@tum.de
% 2017 - 

%% Configurations

% Degrees of Freedom
%k = 3.5;
k = 200000;

% Exact 2nd Moment
true = k/(k-2);

%Number of Simulations
N = 100000;

%% Sample
X = normrnd(0,1,[N,1]); 
Y = X.^2;
w = tpdf(X,k)./normpdf(X,0,1);
Est = sum(Y.*w)/sum(w);

%% Normalise the weights (just used to plot the the Dist)
Norm = sum(w);
w = w/Norm;

%% Plot
% Plot requires the function histwv.m 
% (Copyright (c) 2016, Brent All rights reserved.) 
% that can be downloaded:
% https://de.mathworks.com/matlabcentral/fileexchange/58450-histwv-v--w--min--max--bins-/content/histwv.m
figure(5)
X_vals = min(X):0.5:max(X);
[histw, intervals] = histwv(X',w',min(X),max(X),length(X_vals));
bar(X_vals,histw)
hold on
x = min(X):0.05:max(X);
y = tpdf(x,k);
plot(x,y);
hold off



%% Return the relative error
rel_error = abs(Est-true)/true