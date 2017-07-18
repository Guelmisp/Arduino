clc;
clear all;
delete(instrfindall);

%Arduino Port on MacOS
s = serial('/dev/tty.usbmodem1411');
% Setup
set(s,'BaudRate',9600);
set(s,'DataBits',8);
set(s,'Parity','none');

%Output Data
File1           = '/Users/miguelpessoa/Desktop';
OutputFileName1 = sprintf('%04i%02i%02i-%02i%02i%02.0f_316904.log',clock);
FidMag1 = fopen(File1);
FidW1   = fopen(OutputFileName1,'w');

%save input data in
size = 90000;
rawTemp       = NaN([1 size]);
timeStamp     = NaN([1 size]);
index = 1;

%Open Serial Port
fopen(s);
pause(1);

%Running for 60 seconds
tic;
for t = 1:5
    while toc < t, pause(0.01); end;
    line = fscanf(s);
    line
    ttt = clock();
    timeStamp(index) = ttt(6) + ttt(5)*60 + ttt(4)*3600;
    rawTemp(index) = str2double(line);
    index = index + 1;
end;

% Calculate the final value for temperature in Celsius
tempCelsius   = NaN([1 index-1]);
for i = 1:index-1
    tempCelsius(i) = rawTemp(i)* 0.0048875855 * 100;
end

%Average
avg = mean(tempCelsius(1:index-1));

%Standard deviation
std = std(tempCelsius(1:index-1));

%Printing Mean and Average
fprintf('Temperature - Results \nMean: %9.2f\n', avg);
fprintf('Standard Deviation:  = %9.2f\n', std);

%Writing the data at the log file
%for i = 1 : index-1
%     fprintf(FidW1,'%9.2f  %9.2f\n', timeStamp(i), rawTemp(i));
%end

%Plotting Results
plot_data(timeStamp, tempCelsius, avg, std);

% close serial connection
delete(instrfindall);