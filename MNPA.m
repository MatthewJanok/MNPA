clc
clear

G1 = 1/1;
c = 0.25;
G2 = 1/2;
L = 0.2;
G3 = 1/10;
alpha = 100;
G4 = 1/0.1;
Go = 1/1000;
f = linspace(0,2e3,100);
s = 2*pi*f;
V = linspace (-10,10,100);
V1old = 0;
V3old = 0;
V5old = 0;
V3Cold = 0;
V5Cold = 0;
sold = 0;
gainold = 0;
V3CPold = 0;
V5CPold = 0;
gainCPold = 0;
cpOld = 0;
gainCPV = zeros(100,1);

for i = 1:100
    cp = c +(0.4-0.1)*rand(100,1);
    V1 = V(i);
    Vin = V1;
F = [0 0 0 0 0 0 Vin 0];

% X = [V1 V2 V3  V4 V5 IL I_Vin I_V4];

G = [G1 -G1 0 0 0 0 1 0;
     -G1 G1+G2 0 0 0 1 0 0;
     0 0 G3 0 0 -1 0 0;
     0 0 0 G4 -G4 0 0 1;
     0 0 0 -G4 G4+Go 0 0 0;
     0 1 -1 0 0 -1 0 0;
     1 0 0 0 0 0 0 0;
     0 0 -alpha*G3 1 0 0 0 0;];
 
% F = [Vin 0 0 0 0 0 0 0 0];
% % X = [I_Vin V1 V2 V3 I_V4 I3 V4 V5 IL];
%  G = [0 1 0 0 0 0 0 0 0;
%      1 G1 -G1 0 0 0 0 0 0;
%      0 -G1 G1+G2 0 0 0 0 0 1;
%      0 0 0 G3 0 0 0 0 -1;
%      0 0 0 alpha*G3 0 0 0 0 0;
%      0 0 0 G3 0 0 0 0 0;
%      0 0 0 0 1 0 G4 -G4 0;
%      0 0 0 0 0 0 -G4 G4+Go 0;
%      0 0 1 -1 0 0 0 0 1;];


C = [s(i)*c -s(i)*c 0 0 0 0 0 0;
     -s(i)*c s(i)*c 0 0 0 1 0 0;
     0 0 0 0 0 -1 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 1 -1 0 0 -s(i)*L 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;];


CP = [s(i)*cp(i) -s(i)*cp(i) 0 0 0 0 0 0;
     -s(i)*cp(i) s(i)*cp(i) 0 0 0 1 0 0;
     0 0 0 0 0 -1 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 1 -1 0 0 -s(i)*L 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;];








    
    Sols = G\F';
    V3new = Sols(3);
    V5new = Sols(5);
    figure(1)
    plot([V1old V1],[V3old V3new],'r', [V1old V1],[V5old V5new], 'b')
    hold on
    
    V3old = V3new;
    V5old = V5new;
    V1old = V1;  
    
    
    
    
    
    CSols = (G+C)\F';
    V3Cnew = CSols(3);
    V5Cnew = CSols(5);
    gain = V5Cnew/V1;
    
    figure(2)
    plot([sold s(i)], [V5Cold V5Cnew],'g',[sold s(i)],[gainold gain],'m')
    hold on
    
    V3Cold = V3Cnew;
    V5Cold = V5Cnew;
    sold = s(i);
    gainold = gain;

    
    
    
    
    
    CPSols = (G+CP)\F';
    V3CPnew = CPSols(3);
    V5CPnew = CPSols(5);
    gainCP = V5CPnew/V1;
    
    figure(3)
    plot([cpOld cp(i)],[gainCPold gainCP],'m')
    hold on
    
    gainCPV(i) = gainCP;
    

    
    V3CPold = V3CPnew;
    V5CPold = V5CPnew;
%     sold = s(i);
    gainCPold = gainCP;
    cpOld = cp(i);
end
    

    figure(4)
    histogram(gainCPV)








