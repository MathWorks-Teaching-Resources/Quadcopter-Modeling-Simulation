%  Pre-run script for MultidomainPhysicalModeling.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);
openExample = @(str)MyOpenExample(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open " + str)
end

function MyOpenExample(str)
disp("Open the example " + str)
end