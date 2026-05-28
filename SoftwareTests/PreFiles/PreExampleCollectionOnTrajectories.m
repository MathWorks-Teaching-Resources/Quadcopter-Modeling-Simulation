%  Pre-run script for ExampleCollectionOnTrajectories.mlx
% ---- Known Issues     -----
KnownIssuesID = "MATLAB:Editor:Document:NotAvailable";
% ---- Pre-run commands -----
 
openExample = @(str)MyOpen(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the example " + str)
end