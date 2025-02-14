load('msd_data_hw8.mat')
% import data %
time = msd.t;
y = msd.y;
yd = deriv(y,.01);
ydd = msd.ydd;
N = length(ydd);
bias = ones(N,1);
%%% OLS %%
x = [bias, y, yd];
T_hat = (x'*x)\x'*ydd;
Y_hat = x*T_hat;
R_sq = (T_hat'*x'*ydd - length(ydd)*mean(ydd)^2) / (ydd'*ydd - length(ydd) * mean(ydd)^2)
%% Setting up the model matrices %%
% initial guesses %
for k=1:length(y)
 x4(k) = T_hat(1)*.1;
 x5(k) = T_hat(2)*.1;
 x6(k) = T_hat(3)*.1;
end
%%
Xk = [y(k); yd(k); ydd(k); x4(k); x5(k); x6(k)];
dt = 0.01;
k = 1;
m = 2.75;
N = 6;
F = [1 dt dt^2/2 0 0 0; 0 1 dt 0 0 0; x5(k)/m x6(k)/m 0 -x4(k) y(k)/m yd(k)/m; 0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1];
G = [1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1];
P = eye(N)*1.0;
%QV = .001;
QV = 0.000001;
Q = [QV 0 0 0 0 0;
 0 QV 0 0 0 0;
 0 0 QV 0 0 0;
 0 0 0 QV 0 0;
 0 0 0 0 QV 0;
 0 0 0 0 0 QV];
R = [0.001 0 0 0 0 0;0 10 0 0 0 0;0 0 10 0 0 0, ;0 0 0 10 0 0;0 0 0 0 10 0;0 0 0 0 0 10];
P_diags(1,:) = diag(P);
%% Extended Kalman %%
for k = 2:length(time)
 %X_pred = F*Xk;
 X_pred(1,1) = Xk(1) + Xk(2)*dt + Xk(3)*(dt^2)/2;
 X_pred(2,1) = Xk(2) + Xk(3)*dt;
 X_pred(3,1) = -Xk(4)+Xk(5)/m*Xk(1) + Xk(6)/m*Xk(2);
 X_pred(4,1) = Xk(4);
 X_pred(5,1) = Xk(5);
 X_pred(6,1) = Xk(6);

 P_pred = F*P*F' + Q;
 Z = [y(k); yd(k); ydd(k); x4(k); x5(k); x6(k)];
 yk = Z - G*X_pred;
 Sk = G*P_pred*G' + R;
 Kk = P_pred*G'*Sk^-1;
 Xk = X_pred + Kk*yk;
 P = (eye(N) - Kk*G)*P_pred;
 P_diags(k,:) = diag(P);
 angle_kal(k) = Xk(1);
 rate_kal(k) = Xk(2);
 accel_kal(k) = -Xk(3);
 gravity_kal(k) = Xk(4);
 spring_over_mass_kal(k) = -Xk(5);
 damping_over_mass_kal(k) = Xk(6);
end
figure(1)
subplot(3,1,1)
plot(time, y, time, angle_kal)
title('(Position) Kalman Filter vs Measured')
xlabel('time [s]')
ylabel('position [m]')
subplot(3,1,2)
plot(time, yd, time, rate_kal)
title('(Velocity) Kalman Filter vs Measured')
xlabel('time [s]')
ylabel('velocity [m/s]')
subplot(3,1,3)
plot(time, ydd, time, accel_kal)
title('(Acceleration) Kalman Filter vs Measured')
xlabel('time [s]')
ylabel('acceleration [m/s^2]')
legend('data','kalman')
figure(2)
subplot(3,1,1)
plot(time, x4, time, gravity_kal)
title('(Gravity) Kalman Filter vs. Estimate')
xlabel('time [s]')
ylabel('gravity [m/s^2]')
subplot(3,1,2)
plot(time, x5, time, spring_over_mass_kal)
title('(Spring Coefficient) Kalman Filter vs. Estimate')
xlabel('time [s]')
ylabel('spring [1/s^2]')
subplot(3,1,3)
plot(time, x6, time, damping_over_mass_kal)
title('(Damping Coefficient) Kalman Filter vs. Estimate')
xlabel('time [s]')
ylabel('damping [1/s]')
legend('data','kalman')
