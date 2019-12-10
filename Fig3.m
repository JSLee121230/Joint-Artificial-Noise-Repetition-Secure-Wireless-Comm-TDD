%% Figure 3
clear all
% parameter setting
channel_gain = 1;
N0 = 1;

P = 10 : 5 : 30;
P = 10.^(P/10);
string = {['-*r'];['--ob'];['-.^k']};
Del = [2 5 10];
for j = 1: length(Del)
    delta = Del(j);
    Rs = zeros(length(P),1);
    for i = 1 : length(P)
        mu    = 2*channel_gain*P(i)/N0;
        alpha_as = (-mu + sqrt(mu*delta*(mu-delta+1))) / (mu*(delta-1));
        a = (2 * channel_gain * alpha_as*P(i))/N0;
        b = (delta*alpha_as)/(1-alpha_as);
        Rs(i) = log2((1 +a )/ (1 + b));
    end
    figure(3)
    hold on
    plot(10*log10(P),Rs, string{j})
end

% Draw Fig3.
xlim([10 30])
ylim([0 9])
xticks([10 12 14 16 18 20 22 24 26 28 30])
yticks([0 1 2 3 4 5 6 7 8 9])
ylabel('The achievable secrecy rate') 
xlabel('P (dB)')
legend('\Delta=2','\Delta=5','\Delta=10','Location','northwest')
grid on
fig = gcf;
fig.Color = 'white';
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];