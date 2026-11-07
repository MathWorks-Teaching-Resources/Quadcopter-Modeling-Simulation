%[text] %[text:anchor:H_703AB718] # Sensor Fusion & Filtering
%[text] [⇦ Main Menu](file:../MainMenu.m)
%[text] In the simulations so far, we have assumed perfect knowledge of the quadcopter's position and orientation for our control purposes. However, in real life, sensors are not ideal and may experience drift or sensor noise. The [Sensor Fusion and Tracking Toolbox](https://www.mathworks.com/help/fusion/) offers a variety of algorithms and techniques to address a few of these issues. 
%%
%[text] **Sensor Fusion**
%[text] Robotics systems often use more than one sensor reading and utilize sensor fusion to get an accurate and precise estimate of the position and orientation of the device. A typical quadcopter carries a variety of sensors related to navigation, perception, and mission-related objectives. For navigation, almost all UAVs will have an inertial measurement unit (IMU) consisting of one or more accelerometers, gyroscopes, and perhaps a magnetometer, to track linear acceleration, angular rate, and heading. In addition, a GPS receiver measures the absolute position and the velocity. A barometer can be used to estimate altitude and thus help stabilize vertical motion. All of these sensors are used together for state estimation to allow the UAV to control its flight. 
%[text] For example, the readings from a gyroscope tend to be precise, but may lose accuracy over time due to integration drift. An accelerometer is frequently noisy, and may exhibit bias instability, even while presenting precise output. Conversely, the position reading from a GPS system tends to be very accurate, but its precision is limited. By combining the strengths of both methods, we can arrive at a solution that offers a good balance of precision and accuracy, without sensor drift. 
%[text] - **(Recommended)** Here is an [explanatory Tech Talk video](https://www.mathworks.com/videos/sensor-fusion-part-2-fusing-a-mag-accel-and-gyro-to-estimate-orientation-1569411056638.html) on how a magnetic sensor, accelerometer, and gyroscope can be fused to estimate the orientation of a low-cost microcontroller.
%[text] - Here is a quadcopter example of fusing the readings from an [inertial measurement unit (IMU) with a GPS](https://www.mathworks.com/help/fusion/ug/imu-and-gps-fusion-for-inertial-navigation.html). \
% Open on desktop
openExample('shared_positioning/IMUandGPSFusionExample')
  %[control:button:9fb9]{"position":[1,2]}
%%
%[text] **When you are done**
  %[control:button:9bab]{"position":[1,2]}
%%
%[text] **Kalman Filtering (Recommended):** 
%[text] - Read the article on [Introduction to Estimation Filters](https://www.mathworks.com/help/fusion/ug/introduction-to-estimation-filters.html)
%[text] - Watch the video series on [Understanding Kalman Filters](https://www.mathworks.com/videos/series/understanding-kalman-filters.html)
%[text] - Run the Kalman Filter Virtual Lab to understand the impact of filtering. You can [open the lab in MATLAB Online](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Kalman-filter-virtual-lab&project=project.prj&line=1) or download it locally: \
ChooseDirName = "Kalman-Filter-Virtual-Lab"; %[control:editfield:86e7]{"position":[17,44]}
URL = "https://github.com/MathWorks-Teaching-Resources/Kalman-filter-virtual-lab.git";
ProjName = "project.prj";

% Use a local helper function to download the File Exchange directory
DownloadExampleFromFileExchange(ChooseDirName,URL,ProjName);
  %[control:button:0245]{"position":[1,2]}
%[text] **When you are done**
  %[control:button:84f9]{"position":[1,2]}
%[text] **Also Explore:** 
%[text] - The [Virtual Controls Laboratory](https://www.mathworks.com/matlabcentral/fileexchange/100064-virtual-hardware-and-labs-for-controls) has more examples on control systems design, including sensor noise.
%[text] - [Digital Signal Processing: Signals and Filter Design](https://www.mathworks.com/matlabcentral/fileexchange/171574-digital-signal-processing-signals-and-filter-design) explores signals and different types of filters. \
%[text] [⇦ Main Menu](file:../MainMenu.m)
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
function ReturnHere() %#ok<DEFNU>
curloc = matlab.desktop.editor.getActiveFilename;
if contains(curloc,"Scripts")
    rootdir = extractBefore(curloc,filesep+"Scripts");
elseif contains(curloc,"InstructorResources")
    rootdir = extractBefore(curloc,filesep+"InstructorResources");
else
    error("Unexpected location: " + curloc)
end
cd(rootdir)
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"hidecode","rightPanelPercent":40}
%---
%[control:button:9fb9]
%   data: {"label":"Open IMU and GPS Fusion Example","run":"Section"}
%---
%[control:button:9bab]
%   data: {"callbackCode":"curloc = matlab.desktop.editor.getActiveFilename; if contains(curloc,\"Scripts\"), rootdir = extractBefore(curloc,filesep+\"Scripts\"); cd(rootdir); elseif contains(curloc,\"InstructorResources\"), rootdir = extractBefore(curloc,filesep+\"InstructorResources\"); cd(rootdir); else, error(\"Unexpected location: \" + curloc); end","label":"Return Here","run":"Callback"}
%---
%[control:editfield:86e7]
%   data: {"defaultValue":"\"Kalman-Filter-Virtual-Lab\"","label":"Choose a directory name: ","run":"Nothing","valueType":"String"}
%---
%[control:button:0245]
%   data: {"label":"Download the Kalman Filter Virtual Lab","run":"Section"}
%---
%[control:button:84f9]
%   data: {"callbackCode":"curloc = matlab.desktop.editor.getActiveFilename; if contains(curloc,\"Scripts\"), rootdir = extractBefore(curloc,filesep+\"Scripts\"); cd(rootdir); elseif contains(curloc,\"InstructorResources\"), rootdir = extractBefore(curloc,filesep+\"InstructorResources\"); cd(rootdir); else, error(\"Unexpected location: \" + curloc); end","label":"Return Here","run":"Callback"}
%---
