%  Pre-run script for RigidTransformsSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
openExample = @(str)MyOpen(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the example " + str)
end