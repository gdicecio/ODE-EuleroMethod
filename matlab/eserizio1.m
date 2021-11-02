clear all;
clc;
close all;
%% Problema Semplice y'=lambda*y

lambda = -10;

f = @(t,y) lambda*y;    %Soluzione y(t) = e^(lambda*t)
N = [2*10^5 3*10^5 4*10^5 5*10^5 6*10^5 7*10^5 8*10^5 9*10^5 10^6 2*10^6 3*10^6];           %Numero di iterazioni
%N = [10^2 10^3 10^4 10^5 10^6 10^7];
t0 = 0; T=1; y0 =1; 
h=(T-t0)./N;            %Passo di discretizzazione

gte = zeros(1,length(N));
e_tot = zeros(1, length(N));
e_tot_alternativo = zeros(1, length(N));
roundoff = zeros(1,length(N));
t = t0:h(end):T;
y_analitica = exp(lambda.*t);
plot(t,y_analitica,'LineWidth', 2, 'Color', 'black');

hold on;
for i=1:length(N)
    t = t0:h(i):T;  %Asse dei tempi
    y_numerica = eulero32(f, y0, t0, T, h(i));
    y_numerica_double = eulero64(f, y0, t0, T, h(i));
    roundoff(i) = abs(y_numerica_double(end) - y_numerica(end));
    e_tot(i) = abs(y_analitica(end)-y_numerica(end));
    e_tot_alternativo(i) =  abs(y_numerica_double(end) - y_numerica(end) + y_analitica(end)-y_numerica_double(end));
    gte(i) = abs(y_analitica(end)-y_numerica_double(end));
    plot(t,y_numerica, 'LineWidth', 2);
end

xlabel('Tempo');
ylabel('Soluzione');
legend('N=10^2', 'N=10^3', 'N=10^4','N=10^5','N=10^6', 'N=10^7', 'Soluzione Analitica');
grid;

%% Errore
figure;
p1 = loglog(N, e_tot, 'LineWidth', 2);
hold on;
loglog(N, e_tot, 'o', 'Color', 'Black');
p2 = loglog(N, gte, '--', 'Color', 'Red', 'LineWidth', 2);
p3 = loglog(N, roundoff, '--','Color', 'Black', 'LineWidth', 2);
p4 = loglog(N, roundoff+gte,'Color', 'Green');
%p5 = loglog(N, e_tot_alternativo, '--','Color', 'Yellow', 'LineWidth', 2);
xlabel('Numero di Iterazioni (intervalli)');
ylabel('Errore Totale');

legend([p1 p2 p3 p4], {'Errore Totale', 'GTE', 'RoundOff', 'Roundoff+GTE'});
grid;