%% Tile
% Joint Artificial Noise and Repetition Coding for Secure Wireless Communications in TDD Systems
% Hongliang He and Pinyi Ren, Member, Xi¡¯an Jiaotong University
% IEEE WIRELESS COMMUNICATIONS LETTERS, 2019, early access
% Jongseok Lee (suk2080@kw.ac.kr)

clear all
close all

%% Figure 2.(a)
% Parameter setting
P      = 10^(20/10); %dB
Delta = 8;
N0    = 1;
channel_gain = 1;
figure(2)
subplot(2,2,1)

% The proposed scheme
alpha = 0 : 0.001:1;
ach_secrecy_rate = zeros(length(alpha),1);
for i = 1 : length(alpha)
    % equation(24)
    a = (2 * channel_gain * alpha(i) * P)/N0;
    b = Delta*alpha(i)/(1-alpha(i));
    ach_secrecy_rate(i) = 0.5*log2( (1 +a )/ (1 + b));
end

plot(alpha,ach_secrecy_rate,'-b');

% Optimal value: simulation
hold on
plot(alpha(ach_secrecy_rate==max(ach_secrecy_rate)),ach_secrecy_rate(ach_secrecy_rate==max(ach_secrecy_rate)),'Ok')

% Optimal value: theory
mu    = 2*channel_gain*P/N0;
alpha_as = (-mu + sqrt(mu*Delta*(mu-Delta+1))) / (mu*(Delta-1)); % equation(28)
a = (2 * channel_gain * alpha_as * P)/N0;
b = Delta*alpha_as/(1-alpha_as);
Rs_as = 0.5*log2( (1 +a )/ (1 + b));

hold on
plot(alpha_as, Rs_as, '*r')

% Draw figure2(a)
title('(a)')
xlim([0 1])
ylim([0 2])
xticks([0 0.2 0.4 0.6 0.8 1])
yticks([0 0.5 1 1.5 2])
xlabel('\alpha')
ylabel('The achievable secrecy rate ')
grid on
legend('The proposed scheme','Optimal value: simulation','Optimal value: theory','Location','south')

%% Figure 2.(b)
f_delta = zeros(20,1);
delta = 0: 0.1:10;
for i = 1: length(delta)
    f_delta(i) = ((1+delta(i))^2)/((1-delta(i))^2);
end

% Draw figure2(b)
figure(2)
subplot(2,2,2)
plot(delta,f_delta,'-b');
title('(b)')
ylim([0 100])
xticks([0 2 4 6 8 10])
yticks([0 20 40 60 80 100])
ylabel('f(\delta)')
xlabel('\delta')
grid on

%% Figure 2.(c)

mu    = 2*channel_gain*P/N0;
Delta = 0 : 0.0001:10;
alpha_s = zeros(length(Delta),1);
for i = 1 : length(Delta)
    alpha_s(i) = (-mu + sqrt(mu*Delta(i)*(mu-Delta(i)+1))) / (mu*(Delta(i)-1));
end

% Draw figure2(c)
figure(2)
subplot(2,2,3)
plot(Delta,alpha_s,'-b');
hold on
plot(Delta(find(alpha_s<=0.5,1,'first')),0.5,'Or')
title('(c)')
ylim([0.2 1])
xticks([0 2 4 6 8 10])
yticks([0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1])
ylabel('\alpha^{*}')
xlabel('\Delta')
grid on

%% Figure 2.(d)
mu    = 2*channel_gain*P/N0;
Delta_ = 0 : 0.001:10;
Rs  = zeros(length(Delta_),1);
alp = zeros(length(Delta_),1);
for i = 1 : length(Delta_)
    mu    = 2*channel_gain*P/N0;
    alp(i) = (-mu + sqrt(mu*Delta_(i)*(mu-Delta_(i)+1))) / (mu*(Delta_(i)-1)); % equation(28)
    a = (2 * channel_gain * alp(i) * P)/N0;
    b = Delta_(i)*alp(i)/(1-alp(i));
    Rs(i)  = 0.5*log2( (1 +a )/ (1 + b));
end

% Draw figure2(d)
figure(2)
subplot(2,2,4)
plot(Delta_,Rs,'-b');
hold on
plot(Delta_(find(alp<=0.5,1,'first')),Rs(find(alp<=0.5,1,'first')),'Or')
title('(d)')
xlim([0.95 10])
ylim([1.5 3])
yticks([1.5 2 2.5 3])
xticks([2 4 6 8 10])
xlabel('\Delta')
ylabel('The achievable secrecy rate ')
grid on
fig = gcf;
fig.Color = 'white';
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
