
%% Soluzione numerica ODE
% Equazione: y'(t)=2y(t)-y^2(t) - y(0)=4  con  t=[0,3]
% Soluzione: y(t) = 4/(2-e^-2t)

f = @(t,y) 2*y-y^2;
t0 = 0;
T = 1;
[y_eulero,t] = eulero(f, 4, t0, T, 10e-2);
y_analitica = 4./(2-exp(-2.*t));
hold on;
grid;

plot(t,y_eulero);
plot(t, y_analitica);
legend('Soluzione numerica (Eulero)', 'Soluzione analitica');
figure;
plot(t, y_analitica-y_eulero);

%% Interpretazione geometrica Eulero
f = @(t,y) 2*y-y^2;
t0 = 0;
T = 1;
h = 0.05;
[y_eulero,t] = eulero(f, 4, t0, T, h);
y = @(t) 4/(2-exp(-2*t));
y_analitica = 4./(2-exp(-2.*t));
r = @(t) y(0.2) + (t-0.2)*f(0.2, y(0.2));
hold on;
grid;
p1 = plot(t, y_analitica,'Color', 'red');
p2 = plot(t,r(t), 'Color', 'blue');
plot(0.2, y(0.2), '.', 'Color', 'black');
plot(0.3, y(0.3), '.', 'Color', 'black');
plot(0.3,r(0.3), '.','Color', 'black'); 
line([0 0.3], [r(0.3) r(0.3)], 'LineStyle','--');
line([0 0.3], [y(0.3) y(0.3)],'LineStyle','--');
line([0.2 0.2], [0 y(0.2)],'LineStyle','--');
line([0.3 0.3], [0 y(0.3)],'LineStyle','--');
legend([p1 p2], {'Soluzione analitica y(t)', 'Approssimazione numerica r(t)'});
axis([0 0.4 2 3.6]);

%% Errore globale di troncamento
f = @(t,y) -2*y+1;
t0 = 0;
y0 = 1;
T = 1;
h = [0.1 0.001 0.0001];
global_error = zeros(3,1);

t = 0:0.001:1;
y_analitica = (exp(-2.*t)+1)./2;
plot(t,y_analitica);

hold on;
grid;
for i=1:3
    [y_eulero,t] = eulero(f, y0, t0, T, h(i));
    y_analitica = (exp(-2.*t)+1)./2;
    plot(t,y_eulero);
    global_error(i,1) = max(y_analitica-y_eulero)
end
legend( 'Soluzione analitica','h=0.2', 'h=0.1', 'h=0.05');

%% Errore totale
T = 1;
t0 = 0;
L = 1;
E0 = 0;
R0 = 0;
C = 1;
p = 0.01;
h = 0:0.01:1;
e_tot = exp((T-t0)*L)*(E0-R0)+(exp((T-t0)*L)-1)/L*(C/2.*h+p./h);
plot(h,e_tot);
xlabel('h');
ylabel('E_{tot}');
grid;
axis([0 1 0 1]);

%% Stabilita
f = @(t,y) -15*y;
t0 = 0;
y0 = 0.6;
T = 0.8;
h = [0.04 0.08 0.16];

t = t0:0.001:T;
y_analitica = y0*(exp(-15.*t));
plot(t,y_analitica);

hold on;
grid;
for i=1:3
    [y_eulero,t] = eulero(f, y0, t0, T, h(i));
    y_analitica = y0*(exp(-15.*t));
    plot(t,y_eulero);
end
legend( 'Soluzione analitica','h=0.04', 'h=0.08', 'h=0.16');