%  Pre-run script for MultidomainPhysicalModeling.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open " + str)
end