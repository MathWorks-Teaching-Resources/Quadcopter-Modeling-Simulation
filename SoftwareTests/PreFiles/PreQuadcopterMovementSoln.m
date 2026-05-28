%  Pre-run script for QuadcopterMovementSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
load plus_quad_params.mat quad_m W
assignin("base","quad_m",quad_m);
assignin("base","W",W);
assignin("base","w",[4010 4010 4010 4010]);