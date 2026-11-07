%  Pre-run script for ProjectileMotion.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);
% <matlab:ShareFeedback Share your feedback>

function MyOpen(str)
assert(exist(str,"file"))
disp("Open " + str)
end
