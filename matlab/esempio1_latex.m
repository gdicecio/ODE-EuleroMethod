clear all;
clc;
close all;
%% Stabilita

lambda = -10;

f = @(t,y) lambda*y;    %Soluzione y(t) = e^(lambda*t)
N = [5 20 10^7];           %Numero di iterazioni
t0 = 0; T=1; y0=1;      
h=(T-t0)./N;            %Passo di discretizzazione

t = t0:h(end):T;
y_analitica = exp(lambda.*t);
plot(t,y_analitica,'LineWidth', 2, 'Color', 'blue');

hold on;
t = t0:h(1):T;  %Asse dei tempi
y_numerica = eulero32(f, y0, t0, T, h(1));
plot(t,y_numerica, 'LineWidth', 2);
xlabel('Tempo');
ylabel('Soluzione');
legend('Soluzione Analitica', 'h=5');
grid;

figure;
t = t0:h(end):T;
y_analitica = exp(lambda.*t);
plot(t,y_analitica,'LineWidth', 2, 'Color', 'blue');

hold on;
t = t0:h(2):T;  %Asse dei tempi
y_numerica = eulero32(f, y0, t0, T, h(2));
plot(t,y_numerica, 'LineWidth', 2);
xlabel('Tempo');
ylabel('Soluzione');
legend('Soluzione Analitica', 'h=20 ');
grid;

%% Errore
lambda = -10;

f = @(t,y) lambda*y;    %Soluzione y(t) = e^(lambda*t)
N = [10^2 10^3 10^4 10^5 10^6 10^7];          
t0 = 0; T=1; y0=1; 
h=(T-t0)./N;            

e_tot = zeros(1,length(N));
e_tot2 = zeros(1,length(N));
t = t0:h(end):T;
y_analitica = single(exp(lambda.*t));
y_analitica2= exp(lambda.*t);
plot(t,y_analitica,'LineWidth', 2, 'Color', 'blue');

hold on;
for i=1:length(N)
    t = t0:h(i):T;  %Asse dei tempi
    y_numerica = eulero32(f, y0, t0, T, h(i));
    e_tot(i) = abs(y_numerica(end)-y_analitica(end));
    e_tot2(i) = abs(y_numerica(end)-y_analitica2(end));
    plot(t,y_numerica, 'LineWidth', 2);
end

xlabel('Tempo');
ylabel('Soluzione');
legend('Soluzione Analitica','h=10^2', 'h=10^3', 'h=10^4','h=10^5','h=10^6','h=10^7');
grid;

figure;
loglog(N, e_tot,'LineWidth',2);
hold on;
loglog(N, e_tot2,'LineWidth',2, 'Color', 'Green');
loglog(N, e_tot, 'o');
xlabel('Numero di iterazioni (intervalli)');
ylabel('Errore totale');
grid;

%% Round-off
lambda = -10;

f = @(t,y) lambda*y;    %Soluzione y(t) = e^(lambda*t)
N = [10^2 10^3 5*10^3 10^4 5*10^4 10^5 5*10^5  10^6 10^7];           %Numero di iterazioni
t0 = 0; T=1; y0=1; 
h=(T-t0)./N;            %Passo di discretizzazione

gte = zeros(1,length(N));
roundoff = zeros(1,length(N));
t = t0:h(end):T;
y_analitica = exp(lambda.*t);

hold on;
for i=1:length(N)
    t = t0:h(i):T;  %Asse dei tempi
    y_numerica = single(eulero(f, y0, t0, T, h(i)));
    y_numerica_double = eulero2(f, y0, t0, T, h(i));
    roundoff(i) = abs(max(y_numerica_double - y_numerica));
    gte(i) = abs(y_numerica_double(end)-y_analitica(end));
end
figure;
loglog(N, gte,'LineWidth',2, 'Color', 'blue');
hold on;
loglog(N, gte, '+');
loglog(N, roundoff,'LineWidth',2, 'Color', 'yellow');
grid;
