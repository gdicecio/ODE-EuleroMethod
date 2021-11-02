function [y, t] = eulero32(f, y0, t0, T, h)
    t = single(t0:h:T);                 %Asse dei tempi discretizzata con passo h
    y = single(zeros(length(y0),length(t)));     %Vettore soluzione
    y(:,1) = y0;                  %Condizione iniziale
    
    for i=1:length(t)-1
        y(:,i+1) = y(:,i) + f(t(i), y(:,i))*h;    %Costruzione della soluzione
    end
end

