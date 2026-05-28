%  Pre-run script for QuadcopterMovement.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
load plus_quad_params.mat quad_m W
assignin("base","quad_m",quad_m);
assignin("base","W",W);
assignin("base","w",[3990 3990 3990 3990]);