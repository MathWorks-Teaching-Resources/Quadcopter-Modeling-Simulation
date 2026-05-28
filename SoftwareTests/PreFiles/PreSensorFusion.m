%  Pre-run script for SensorFusion.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
DownloadExampleFromFileExchange = @(dir,URL,proj) DownloadSpoof(dir,URL,proj);

function DownloadSpoof(dir)
disp("Pretend downloading example to " + dir + " from " + URL)
disp("Then pretend running the project: " + proj)
end
