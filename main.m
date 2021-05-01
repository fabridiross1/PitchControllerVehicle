m1f = 53;
m1r = 117;
J = 1067;
m2 = 663;
kr = 58636;
ktr = 310000;
kf = 58636;
ktf = 310000;
cf  =4165;
cr = 4165;
a = 1.233;
b = 1.327;
vkmh = 10;
vms = convvel(vkmh, 'km/h', 'm/s');

%syms m1f m1r J m2 kr kf ktr ktf cf cr a b
clear vkmh
%% Matrici sistema
%A
A11=zeros(4,4);
A12=eye(4,4);
A21= [-(kf+kr)/m1f,0,kf/m1f,-(a*kf)/m1f;...
    0, -(kr+ktf)/(m1r),kr/m1r,(b*kr)/m1r;....
    kf/m2, kr/m2,-(kf+kr)/(m2),((a*kf)-(b*kf))/(m2);...
    -(a*kf)/(J),(b*kr)/(J),((a*kf)-(b*kr))/(J),-((a^2*kf)+(b^2*kr))/(J)];
A22= [ -cf/m1f,0,cf/m1f,-(a*cf)/(m1f)   ;...
    0,-cr/m1r,cr/m1r,(b*cr)/(m1r)   ;...
    cf/m2,cr/m2,-(cf+cr)/(m2),((a*cf)-(b*cr))/(m2) ;...
    -a*cf/J,b*cr/J,(a*cf-b*cr)/(J),-(a^2*cf + b^2*cr)/J];

A = [A11,A12;A21,A22];

%B
B1 = zeros(4,2);
B2 = [1/m1f,0;0 1/m1f;-1/m2,-1/m2;a/J,-b/J];
B = [B1;B2];

%L
L = [zeros(4,2);ktf/m1f,0;0,ktr/m1r;zeros(2,2)];

%C
C = [zeros(2,2),eye(2),zeros(2,4);zeros(2,6),eye(2)];

veicoloConDisturbi = ss(A,[B,L],C,0);
veicoloPerControllo = ss(A,B,C,0);


set(veicoloConDisturbi,'inputname',{'ControlAteriore-{uf} [N]','ControlPosteriore-{ur} [N]','DisurbAnteriore-{df} [m]','DisurbPosteriore-{dr} [m]'},'OutputName', {'Zc [m]','phi [rad]','zc_{dot} [m/s]','phi_{dot} [rad/s]'},'statename',{'z1f','z1r','zc','phi','zif_dot','zir_dot','zc_dot','phi_dot'})
set(veicoloPerControllo,'inputname',{'ControlAteriore-(uf) [n]','ControlPosteriore-(ur) [n]'},'OutputName', {'Zc','phi','zc_dot','phi_dot'},'statename',{'z1f','z1r','zc','phi','zif_dot','zir_dot','zc_dot','phi_dot'})
clear A11 A12 A21 A22 L C B B1 B2 A L m1f m1r J m2 kr kf ktr ktf cf cr

%% ProprietàStrutturali
ContrMatrix = ctrb(veicoloPerControllo.A,veicoloPerControllo.B);
if rank(ContrMatrix) ~= max(size(veicoloPerControllo.A))
    disp('Sistema non completamente controllabile');
    return
else
    disp('Sistema completamente controllabile');
end

ObsvMa = obsv(veicoloPerControllo.A,veicoloPerControllo.C);
if rank(ObsvMa) ~= max(size(veicoloPerControllo.A))
    disp('Sistema non completamente osservabile');
    return
else
    disp('Sistema completamente osservabile');
end

clear ContrMatrix ObsvMa

%% Plot risposte gradino
% for i=1:1:min(size(veicoloConDisturbi.B))
%     figure(i)
%     step(transfer(:,i))
% end


%% State Feedback
% 1-Auovalore domninante
P = [ -4, -4.01,-20.0596-12.3175i,-20.0596+12.3175i,-44.0967-10.8565i, -44.0967+10.8565i,-20+48.9339i, -20-48.9339i];
%P = [ -4, -4.01,-42,-41,-39,-38,-39,-39.98];

%Bessel
%k = [-4.4554+9.9715i,-6.8554+6.9278i,-8.1682+4.1057i,-8.7693+1.3616i]
%P=[k,conj(k)];
%P = sort(P,'descend','ComparisonMethod','real')

KFeedb = place(veicoloPerControllo.A,veicoloPerControllo.B,P);
Kfeedback = struct('Kf',KFeedb(:,1:8),'P',P);
veicoloAutovalori = ss(veicoloPerControllo.A-veicoloPerControllo.B*KFeedb,veicoloConDisturbi.B,veicoloPerControllo.C,0);
set(veicoloAutovalori,'inputname',{'ControlAteriore-(uf) [n]','ControlPosteriore-(ur) [n]','DisurbAnteriore-(df) [m]','DisurbPosteriore-(dr) [m]'},'OutputName', {'Zc','phi','zc_dot','phi_dot'},'statename',{'z1f','z1r','zc','phi','zif_dot','zir_dot','zc_dot','phi_dot'})
clear P KFeedb
%% State Feedback + integratore
sysItg=ss(zeros(2,2),eye(2),eye(2),0); %Integratore
Controllo = [veicoloPerControllo.A,zeros(8,2);veicoloPerControllo.C(1:2,:),zeros(2,2)];
if (rank(Controllo) <8)
    return;
end

Aa  =[veicoloPerControllo.A,zeros(8,2);-veicoloPerControllo.C(1:2,:),sysItg.A];
Ba = [veicoloPerControllo.B(:,1:2);zeros(2,2)];
Ca = [veicoloPerControllo.C(1:2,:),zeros(2,2)];
veicoloStateIntegral = ss(Aa,Ba,Ca,0);

P = [ -4, -4.01,-20.0596-12.3175i,-20.0596+12.3175i,-44.0967-10.8565i, -44.0967+10.8565i,-20+48.9339i, -20-48.9339i];
K = place(veicoloStateIntegral.A,veicoloStateIntegral.B,[Kfeedback.P,-12.5-0.1i,-12.5+.1i ]);
KFeedbIntegratore = struct('Kfe',K(:,1:8),'Ki',K(:,9:10),'P',[P,-15-0.1i,-15+.1i ]);

clear Aa Ba Ca P K Controllo sysItg
%% Observer Design
EstFactor=4;
poleFeedb = Kfeedback.P;
L=place(veicoloConDisturbi.A',veicoloConDisturbi.C',poleFeedb*EstFactor)';
Aobs=veicoloConDisturbi.A-L*veicoloConDisturbi.C;
Bobs=[L, veicoloConDisturbi.B];
Cobs=eye(8);
Dobs=zeros(8,8);
Observer1 = ss(Aobs,Bobs,Cobs,Dobs);

clear Aaug Baug Caug clear state EstFactor poleFeedb L
%% LQR Design
Q=diag([0,0,800,800,0,0,10,10]);%8x8 ;
R= diag([1e-8,1e-8]);
[KLQ1,~,CLP] = lqr(veicoloPerControllo,Q,R);
KLQR = struct('KfeLQR',KLQ1(:,1:8),'Q',Q,'R',R,'CLP',CLP);
CLP;
clear S CLP KLQ1 Q R
%% LQI
VeicoloDueUscite = ss(veicoloPerControllo.A,veicoloPerControllo.B,veicoloPerControllo.C(1:2,:),0);
Q=diag([0,0,80,150,0,0,0,0,900,5000]);%8x8 ;
R= diag([1e-9,1e-9]);

[KLQInt,~,CLP] = lqi(VeicoloDueUscite,Q,R);
KLQI = struct('KfeLQR',KLQInt(:,1:8),'KiLQR',KLQInt(:,9:10),'Q',Q,'R',R,'CLP',CLP);

clear S CLP KLQInt Q R

%% Kalman Filter Design
Tkalman = 0.002;

varZc=1.0000e-3; %% Errore di 1cm
varZcDot=1.0000e-3;
varPhi=1.0000e-4;
varPhiDot=1.0000e-4;
Q_kalman = diag([0,0,varZc,varPhi,0,0,varZcDot,varPhiDot]);
R_kalman = diag([varZc,varPhi,varZcDot,varPhiDot]);
[L_kalman,P_kalman,~] = lqe(veicoloConDisturbi.A,eye(8),veicoloConDisturbi.C,Q_kalman,R_kalman);

A_kalman=veicoloConDisturbi.A-L_kalman*veicoloConDisturbi.C;
B_kalman=[L_kalman ,veicoloConDisturbi.B];
C_kalman=eye(8);
D_kalman=0;

kalmanFilter = ss(A_kalman,B_kalman,C_kalman,D_kalman);
KkalmanFilter = struct('KalmanFilter',kalmanFilter,'CLP',P_kalman,'Q',Q_kalman,'R',R_kalman);
clear A_kalman B_kalman C_kalman D_kalman L_kalman P_kalman E R_kalman Q_kalman P_kalman
%% Latex
% [Num,Den] = tfdata(transfer(4,2),'v');
% syms s
% sys_syms=poly2sym(Num,s)/poly2sym(Den,s);
% l = latex(sys_syms)

clear A_kalman Aobs Bobs Cobs Dobs ans out



