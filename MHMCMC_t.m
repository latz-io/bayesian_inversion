% Random-Walk-Metropolis-Hastings MCMC in 1D to sample from a student's t
% distribution
% Jonas Latz, M.Sc.
% Lehrstuhl f?r Numerische Mathematik
% Fakult?t f?r Mathematik
% Technische Universit?t M?nchen
% jonas.latz@tum.de
% 2017 - 

%% Configurations

% Degrees of Freedom
n = 3.5;

% Initial state
x_start = 0;

% Number of simulations
N = 100000;


%% Some Initialisations

X = zeros(1,N);
a = zeros(1,N);
accept = zeros(1,N);
X(1) = x_start;
a(1) = 1;
accept(1)=1;

%% MCMC-Run

for k=2:N
    % Proposal
    X_prop = X(k-1) + normrnd(0,0.85);
    
    % Acceptance Probability
    a(k) =min(1,(tpdf(X_prop,n)/tpdf(X(k-1),n)));
    
    % Accept?!
    if rand < a(k)
        X(k) = X_prop;
        accept(k) = 1;
    else
        X(k) = X(k-1);
    end

end

%% Plot the sample path, histogram, and correct pdf.

FigHandle = figure(21);
set(FigHandle, 'Position', [50, 50, 800, 400]);
subplot(1,2,1)
plot(X)

subplot(1,2,2)
h=histogram(X(-10 < X <10),'Normalization','probability');
h.NumBins = 40;
hold on
y = -10:0.1:10;
f = tpdf(y,n);
plot(y,f,'LineWidth',1.5)
hold off

%% Derive the amount of accepted steps and estimate the 
% acceptance probability

rel_accept = sum(accept)/N
estim_accept_prob = sum(a)/N

%% Estimate the Second Moment

% Exact 2nd Moment
Estimate = sum(X.^2)/N;
true = n/(n-2);
rel_error = abs(Estimate-true)/true