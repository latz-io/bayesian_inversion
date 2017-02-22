% Random-Walk-Metropolis-Hastings MCMC in 1D to sample from a Multimodal
% Probability distribution
% Jonas Latz, M.Sc.
% Lehrstuhl f?r Numerische Mathematik
% Fakult?t f?r Mathematik
% Technische Universit?t M?nchen
% jonas.latz@tum.de
% 2017 - 

%% Configurations

% Standarddeviation of the proposal

%propsigma = 0.1; % Breaks
propsigma = 5; % Works

% Initial state
x_start = 0;

% Number of generated samples
N = 100000;

%% Some Initialisations

X = zeros(1,N);
a = zeros(1,N);
accept = zeros(1,N);
X(1) = x_start;
a(1) = 1;
accept(1)=1;


%% PDF of the Multimodal Distribution

multimod = @(X)(0.25*normpdf(X,-5,0.5)+0.35*normpdf(X,8,1)+0.23*normpdf(X,15,0.4)+0.17*normpdf(X,0,0.7));


%% MCMC-run

for k=2:N
    % Proposal
    X_prop = X(k-1) + normrnd(0,propsigma);
    
    % Acceptance probability 
    a(k) =min(1,(multimod(X_prop))/(multimod(X(k-1))));
    
    % Accept?!
    if rand < a(k)
        X(k) = X_prop;
        accept(k) = 1;
    else
        X(k) = X(k-1);
    end

end

%% Plot the sample path, histogram, and correct pdf.

FigHandle = figure(22);
set(FigHandle, 'Position', [50, 600, 800, 400]);

subplot(1,2,1)
plot(X)

subplot(1,2,2)
h=histogram(X,'Normalization','probability');
h.NumBins = 30;
hold on
y = -10:0.1:20;
f = multimod(y);
plot(y,f,'LineWidth',1.5);
hold off

%% Derive the amount of accepted steps and estimate the 
% acceptance probability

rel_accept = sum(accept)/N;
estim_accept_prob = sum(a)/N;

%% Return the relative Error of the Mean of the distribution

Estim = sum(X)/N;

% The expected value could be derived analytically. It is done numerically
% for practical reasons.

true = integral(@(x)multimod(x).*x,-Inf,Inf,'AbsTol',1e-8);

rel_error = abs(Estim-true)/true