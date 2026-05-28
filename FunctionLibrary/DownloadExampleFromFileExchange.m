function DownloadExampleFromFileExchange(ChooseDirName,URL,ProjName)
curloc = matlab.desktop.editor.getActiveFilename;
if contains(curloc,"Scripts")
    rootdir = extractBefore(curloc,filesep+"Scripts");
elseif contains(curloc,"InstructorResources")
    rootdir = extractBefore(curloc,filesep+"InstructorResources");
else
    error("Unexpected location: " + curloc)
end
rootdir = string(rootdir);
if ~exist(rootdir+filesep+ChooseDirName,"dir")
    mkdir(rootdir,ChooseDirName)
end
newloc = rootdir+filesep+ChooseDirName+filesep;
if ~exist(newloc+filesep+ProjName)
    gitclone(URL,newloc);
end
openProject(newloc+ProjName);
end

%[appendix]{"version":"1.0"}
%---
