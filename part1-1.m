A = [0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];
x0 = [0.9;0.1;0;0];
x=zeros(4,250);
for i=1:250
    x(:,i)=((A)^i)*x0;
end
figure;
hold on 
plot(x(1,:));
plot(x(2,:));
plot(x(3,:));
plot(x(4,:));
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
title('without reinfection')
hold off




A2 = [0.95 0.04 0.2 0; 
    0.05 0.85 0 0; 
    0 0.1 0.8 0; 0 0.01 0 1];
%to make recovered people be able to become succeptable and reinfected, i
%cahnged the 0 value int he firsgt row and 3rd column to 0.2 then i also
%changed the 3rd column and 3rd row from 1 to 0.8 to account for the people
%that are not reamining recovered

%before i changed the reinfection rate, the graph looked like the textbook
%where all the numbers reached a plateau and the recovered stayed that way
%and the deceased reamined the same with susceptible and infected rates
%going to zero. When I cahnged the reinfection stuff, there wasnt a plaetau
%like in the previous graph and the number of S keeps decreasing at a
%slower rate and the number of D increase at an inverse rate
x0 = [0.9;0.1;0;0];
x=zeros(4,250);
for i=1:250
    x(:,i)=((A2)^i)*x0;
end
figure;
hold on 
plot(x(1,:));
plot(x(2,:));
plot(x(3,:));
plot(x(4,:));
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
title('reinfection');
hold off


B = zeros(4,1);
sys_sir_base = ss(A,B,eye(4),zeros(4,1),1);
Y = lsim(sys_sir_base,zeros(250,1),linspace(0,249,250),x0);
figure;
hold on
plot(Y);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
title('done with ss and lsim')


