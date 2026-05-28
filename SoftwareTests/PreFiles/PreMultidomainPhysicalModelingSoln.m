%  Pre-run script for MultidomainPhysicalModelingSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "MATLAB:Editor:Document:NotAvailable";
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