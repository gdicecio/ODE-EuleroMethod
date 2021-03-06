clear all;
clc;
close all;

%% Massa-Molla
% x'' = -k*x
%Scomposizione in un sistema differenziale
% x' = v
% x'' = (x')' = v' = -k*x

%Parametri
k=1;
m=1;

%Condizioni iniziali
t0=0; T=2;
x0=0; v0=1;
y0=[x0,v0];

%Passo di discretizzazione
N = [10^2 10^3 10^4 10^5 10^6 10^7];
%N = [7*10^4 8*10^4 9*10^4 10^5 2*10^5 3*10^5 4*10^5 5*10^5 6*10^5 7*10^5 8*10^5 9*10^5 10^6];  
h=(T-t0)./N;

%Soluzione anlitica
tempo = t0:h(end):T;
y_analitica = [sin(tempo); cos(tempo)];
plot(tempo, y_analitica(1,:), 'Color', 'Black', 'LineWidth',2);

%Inizializzazione degli errori
gte = zeros(1,length(N));
e_tot = zeros(1, length(N));
e_tot_equivalente = zeros(1, length(N));
roundoff = zeros(1,length(N));
plot(tempo,y_analitica(1,:));

%Soluzione numerica
hold on;
f = @(t,y) [y(2); -k/m*y(1)]; 
for i=1:length(N)
    t = t0:h(i):T;  %Asse dei tempi
    y_numerica = eulero32(f, y0, t0, T, h(i));
    y_numerica_double = eulero64(f, y0, t0, T, h(i));
    roundoff(i) = abs(y_numerica_double(1,end) - y_numerica(1,end));
    e_tot(i) = abs(y_analitica(1,end)-y_numerica(1,end));
    e_tot_equivalente(i) =  abs(y_numerica_double(1,end) - y_numerica(1,end) + y_analitica(1,end)-y_numerica_double(1,end));
    gte(i) = abs(y_analitica(1,end)-y_numerica_double(1,end));
    plot(t,y_numerica(1,:), 'LineWidth', 2);
end
legend('Soluzione Analitica', 'N=10^2', 'N=10^3','N=10^4', 'N=10^5', 'N=10^6', 'N=10^7');
xlabel('Tempo');
ylabel('Soluzione');
grid;

%% Errori
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

 

