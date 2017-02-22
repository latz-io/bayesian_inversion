% Kalman Filter in 1D for a time-dependent linear inverse problem.
% Jonas Latz, M.Sc.
% Lehrstuhl f?r Numerische Mathematik
% Fakult?t f?r Mathematik
% Technische Universit?t M?nchen
% jonas.latz@tum.de
% 2017 - 

% Time steps
n = 1;
t = n*10;

% Linear forward operator
G = fliplr((1:1:t)/(t+1));
G = diag(G);

%Likelihood is centred Gaussian with Variance = gamma2.
gamma2 = 2;

% Generate Data
true = 4;  %true value = 2.
x_true = true*ones(t,1);
data = G*x_true + normrnd(0,sqrt(gamma2),t,1);

% The intermediate distributions are Gaussian and can thus be
% represented by their mean and variances.
mu = zeros(t,1);
sigma = zeros(t,1);

% Prior:
mu(1) = -2;
sigma(1) = 25;


% Plot the intermediate distributions.
x = -20:0.1:20;
y = zeros(t,size(x,2));

y(1,:) = normpdf(x, mu(1), sqrt(sigma(1)));
figure(2)
plot(x,y(1,:));
hold on;
for i = 2:t
    mu(i) = (mu(i-1)/sigma(i-1) + (data(i)/G(i,i))/(gamma2/G(i,i)^2))/(1/sigma(i-1) + (G(i,i)^2)/gamma2);
    sigma(i) = 1/(1/sigma(i-1) + G(i,i)^2/gamma2);
    y(i,:) = normpdf(x, mu(i), sqrt(sigma(i)));
    if mod(i,n)== 0
        plot(x,y(i,:)); %Plot only 10 intermediate distributions.
    end
end
plot(true*ones(size(0:0.01:max(max(y)))),0:0.01:max(max(y)));
legend('1','2','3','4','5','6','7','8','9','10','u=2');

hold off;





