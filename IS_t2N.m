% Importance Sampling: Works.
% Simulate the 2nd Moment of a normal distribution given a  t-distributed
% samples
% Jonas Latz, M.Sc.
% Lehrstuhl f?r Numerische Mathematik
% Fakult?t f?r Mathematik
% Technische Universit?t M?nchen
% jonas.latz@tum.de
% 2017 - 

%% Configuration

k = 3.5;
true = 1;

%Number of Simulations
N = 100000

%% Sample

X = trnd(k,[N,1]); 
Y= X.^2;
w = normpdf(X,0,1)./tpdf(X,3);

Est = sum(Y.*w)/sum(w);
%% Plot
% Plot requires the function histwv.m 
% (Copyright (c) 2016, Brent All rights reserved.) 
% that can be downloaded:
% https://de.mathworks.com/matlabcentral/fileexchange/58450-histwv-v--w--min--max--bins-/content/histwv.m

figure(4)
X_vals = min(X):0.75:max(X);
[histw, intervals] = histwv(X',w',min(X),max(X),length(X_vals));
bar(X_vals,histw)
hold on
x = min(X):0.05:max(X);
y = tpdf(x,k);
plot(x,y);
hold off
figure(2)
histfit(X,100,'t')


%% Return the relative error
rel_error = abs(Est-true)/true
