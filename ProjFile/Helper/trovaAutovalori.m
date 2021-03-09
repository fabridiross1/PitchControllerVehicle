function P = trovaAutovalori(ts,PO)
ts = 5; PO = 0;
term = pi^2 + log(PO/100)^2;
zeta1 = log(PO/100)/sqrt(term); % Damping ratio from PO

if isnan(zeta1)
    zeta = 1;
else
    zeta = zeta1;
end

wn = 4/(zeta*ts);

P1 = -zeta*wn + i*wn*sqrt(1-zeta^2);
if imag(P1) ~= 0
    P1 = -zeta*wn + i*wn*sqrt(1-zeta^2);
    P2 = conj(P1);
    P3 = -10*abs(P1);
    P5 = P3 - .01*rand(1)-.01;
    P6 = P3 - .01*rand(1)-.01;
    P7 = P3 - .01*rand(1)-.01;
    P8 = P3 - .01*rand(1)-.01;
else
    P1 = -zeta*wn + i*wn*sqrt(1-zeta^2);
    P2 = -10*abs(P1);
    P3 = P2-2;
    P4 = P2-1;
    P5 = .01*rand(1)-.01;
    P6 = .01*rand(1)-.01;
    P7 = .01*rand(1)-.01;
    P8 = .01*rand(1)-.01;
    P9 = .01*rand(1)-.01;
end
P = [P1,P2,P3,P4,P5,P6,P7,P8]
end

