%  Pre-run script for SensorFusionSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
DownloadExampleFromFileExchange = @(dir,URL,proj) DownloadSpoof(dir,URL,proj);
openExample = @(str)MyOpen(str);

function DownloadSpoof(dir,URL,proj)
disp("Pretend downloading example to " + dir + " from " + URL)
disp("Then pretend running the project: " + proj)
end

function MyOpen(str)
disp("Open the example " + str)
end