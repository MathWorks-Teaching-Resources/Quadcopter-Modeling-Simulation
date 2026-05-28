%  Pre-run script for SensorFusionSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
DownloadExampleFromFileExchange = @(dir,URL,proj) DownloadSpoof(dir,URL,proj);
open = @(str)MyOpen(str);

function DownloadSpoof(dir)
disp("Pretend downloading example to " + dir + " from " + URL)
disp("Then pretend running the project: " + proj)
end

function MyOpen(str)
assert(exist(str,"file"))
disp("Open " + str)
end