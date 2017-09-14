
load SPM.mat
% i > s-f
con1 = [];
tmp = [];
for irun = 1:9
con1 = [ con1, 1 -1 0];
x = strfind(SPM.xX.name, sprintf('Sn(%d)', irun));
tmp = zeros(length(cell2mat(x)) - 1 - 3,1)';
con1 = [con1 tmp];
tmp = [];

end % end irun

% s-f > i
con2 = [];
tmp = [];
for irun = 1:9
con2 = [ con2, -1 1 0];
x = strfind(SPM.xX.name, sprintf('Sn(%d)', irun));
tmp = zeros(length(cell2mat(x)) - 1 - 3,1)';
con2 = [con2 tmp];
tmp = [];

end % end irun

% i & s-f > s-r
con3 = [];
tmp = [];
for irun = 1:9
con3 = [ con3, 1/2 1/2 -1];
x = strfind(SPM.xX.name, sprintf('Sn(%d)', irun));
tmp = zeros(length(cell2mat(x)) - 1 - 3,1)';
con3 = [con3 tmp];
tmp = [];

end % end irun

% i > s-r
con4 = [];
tmp = [];
for irun = 1:9
con4 = [ con4, 1 0 -1];
x = strfind(SPM.xX.name, sprintf('Sn(%d)', irun));
tmp = zeros(length(cell2mat(x)) - 1 - 3,1)';
con4 = [con4 tmp];
tmp = [];

end % end irun

% /Users/wbr/Documents/Matlab/spm12/canonical