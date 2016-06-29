
calib='C:\Users\Vandiver\Documents\HiFU\Efficiency _vs_frequency_for_Vandy.xlsx';

%1.2MHz
av=xlsread(calib,'F3:F15');
Pac=xlsread(calib,'H3:H15');
Pel=xlsread(calib,'G3:G15');

[av,sI]=sort(av);
Pac=Pac(sI);
Pel=Pel(sI);
model2 = @(c,x) 0*c(1) + c(2)*x + c(3)*x.^2 ;
cfit = lsqcurvefit(model2, [0 1 1], av, Pac);
dfit = lsqcurvefit(model2, [0 1 1], av, Pel);

figure;
hold on;
plot(av,Pac,'o');
plot(av,model2(cfit,av),'-');


av2Wac = @(av) model2(cfit