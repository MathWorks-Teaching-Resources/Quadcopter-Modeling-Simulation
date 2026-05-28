%  Pre-run script for QuadcopterFromFEX.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
DownloadExampleFromFileExchange = @(dir,URL,proj) DownloadSpoof(dir,URL,proj);

function DownloadSpoof(dir,URL,proj)
disp("Pretend downloading example to " + dir + " from " + URL)
disp("Then pretend running the project: " + proj)
end