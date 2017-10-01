
% canadian citizen conditional CDF
% f(y|x) = 1-exp( exp((x-m)/l) * (1-exp(y/l) ) ) y >= 0

% if f(Y|X) = 0.5 -> 1/2 chance of living more than Y years if you are X
% years (in this specific case y = median)

%constants FEMALE
% m = 87.8;
% l = 9.5;

%constants MALE
m = 81.95;
l = 10.6;

% life expectancy

age = 1:100;
yearsToLiveMedian = l*log(1- exp((m-age)/l)*log(0.5));

figure;
plot(yearsToLiveMedian)

%if we retire at 65, that gives x = 65 = age
% now we have P[Y > totalRetirementValue / s | age = 65]; 
% note that the totalRetirementValue does not affect the distribution,
% since it only fluctuates with age and life expectancy.

y = 0:40;
PL = exp(exp((65-m)/l) * (1-exp(y/l))); 

figure;
plot(PL)
grid on;

probs = 0.1:0.1:0.9;
totalToSpend = zeros(size(probs));
yearsChosenToLive = zeros(size(probs));

%% caso (i) , gasto de 1000 reais por mes -> 12000 por ano
for k=1:length(probs)
    [~, index] = min(abs(PL-probs(k)));
    yearsChosenToLive(k) = y(index);
    totalToSpend(k) = 1000*12*y(index);
end

% se deve planejar viver yearsChosenToLive(k) para cada probabilidade k de
% se viver além da aposentadoria. Para isso é necessário juntar
% totalToSpend(k)

yearsChosenToLive
totalToSpend

%% caso (ii) , gasto de 10000 reais por mes -> 120000 por ano
for k=1:length(probs)
    [~, index] = min(abs(PL-probs(k)));
    yearsChosenToLive(k) = y(index);
    totalToSpend(k) = 10000*12*y(index);
end
% se deve planejar viver yearsChosenToLive(k) para cada probabilidade k de
% se viver além da aposentadoria. Para isso é necessário juntar
% totalToSpend(k)

yearsChosenToLive
totalToSpend

%% caso (iii) , gasto de 30000 reais por mes -> 360000 por ano

for k=1:length(probs)
    [~, index] = min(abs(PL-probs(k)));
    yearsChosenToLive(k) = y(index);
    totalToSpend(k) = 30000*12*y(index);
end

% se deve planejar viver yearsChosenToLive(k) para cada probabilidade k de
% se viver além da aposentadoria. Para isso é necessário juntar
% totalToSpend(k)

yearsChosenToLive
totalToSpend


% isso [e probabilidade de OUTLIVE a aposentadoria, ou seja, se essa
% probabilidade for baixa