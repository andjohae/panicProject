function [] = GetGraph()
data1 = load('/chalmers/users/timmyf/Documents/MATLAB/ProjectSOCS/panicProject-master/code/Time_2016-01-07_12:56.txt');
data2 = load('/chalmers/users/timmyf/Documents/MATLAB/ProjectSOCS/panicProject-master/code/Time_2016-01-07_13:27.txt');
data3 = load('/chalmers/users/timmyf/Documents/MATLAB/ProjectSOCS/panicProject-master/code/Time_2016-01-07_15:22.txt');

% data4 = load(
% data5 = load(
% data6 = load(
% data7 = load(
% data8 = load(
% data10 = load(
% data11 = load(
% data12 = load(
% data13 = load(
% data14 = load(
% data15 = load(
% data16 = load(
% data17 = load(
% data18 = load(
% data19 = load(
% data20 = load(

data1(1,:) = [];
data2(1,:) = [];
data3(1,:) = [];
%data4(1,:) = []; + data5(1,:) = []; + data6(1,:) = []; +data7(1,:) = []; + data8(1,:) = []; + data10(1,:) = []; + data11(1,:) = []; + data12(1,:) = []; + data13(1,:) = [];+data14(1,:) = []; + data15(1,:) = []; + data16(1,:) = [];+data17(1,:) = []; + data18(1,:) = []; + data19(1,:) = []; +data20(1,:) = []; 
average = data1 + data2 + data3/3;% +data4 + data5 + data6 +data7 + data8 + data10 + data11 + data12 + data13+data14 + data15 + data16+data17 + data18 + data19+data20 
average(:,1) = data1(:,1);
differenceFromAverage1 = average - data1;
differenceFromAverage2 = average - data2;
differenceFromAverage3 = average - data3;
variance = (differenceFromAverage1.^2 + differenceFromAverage2.^2 + differenceFromAverage3.^2)./3;
std = variance.^0.5;
std(:,1) = data1(:,1);
GetGraphsFromData(average,std);
end

