%[text] # Example Collection On Trajectories
%[text] [⇦ Main Menu](file:../../MainMenu.m)
%[text] We can look at a 3D Simscape™ Multibody™ model of a Quadcopter that delivers a package from one point to another. The next challenge is to create a trajectory of points between the starting and ending positions.
%[text] In general, for many robotics and autonomous systems applications, we can use [splines](https://www.mathworks.com/matlabcentral/fileexchange/111490-numerical-methods-with-applications/files/Scripts/Interpolation.mlx) to generate smooth curves between waypoints that a robot can follow. Recall that [jerk](https://en.wikipedia.org/wiki/Jerk_(physics)) is the rate of change of an object's acceleration over time. Given a position function $\\mathbf{p}(t)${"altText":"vector p (t)"} which defines the location in space of our UAV at time $t${"altText":"t"}:
%[text]{"align":"center"} $\\matrix{&&\\cr \\hline \\textbf{Name} & \\textbf{Formula} & \\textbf{Description} \\cr \\hline \\text{Position} & \\mathbf{p}(t) & \\text{location in space} \\cr \\text{Velocity} & \\frac{d\\mathbf{p}}{dt} & \\text{speed and direction} \\cr \\text{Acceleration} & \\frac{d^2\\mathbf{p}}{dt^2} & \\text{rate of change of speed and direction} \\cr \\text{Jerk} & \\frac{d^3\\mathbf{p}}{dt^3} & \\text{rate of change of acceleration} \\cr \\text{Snap} & \\frac{d^4\\mathbf{p}}{dt^4} & \\text{rate of change of jerk}}${"altText":"matrix with rows (Name, Formula, Description); (Position, vector p (t), location in space); (Velocity, (d vector p)\/(dt), speed and direction); (Acceleration, (d^2 vector p)\/(dt^2), rate of change of speed and direction); (Jerk, (d^3 vector p)\/(dt^3), rate of change of acceleration); (Snap, (d^4 vector p)\/(dt^4), rate of change of jerk)"}
%[text] Minimizing the jerk (and other higher-order derivatives) results in a smoother ride. 
%[text] %[text:anchor:M_083a] ![](text:image:4fd9) **Try**. Run the code below to explore B-spline trajectories for waypoints. What happens when you change, add, or remove waypoints? 
% Waypoints (each column is a point in 2D)
wpts = [0  0  2  1;   % x coordinates
        0  1  1  0];  % y coordinates
  %[control:button:567c]{"position":[1,2]}
%[text] The local function [`ComputeAndPlotTrajectory`](internal:M_99cc) is defined at the end of this script. 
[q,qd,qdd,tvec] = ComputeAndPlotTrajectory(wpts);
%[text] Compute and plot the velocity, acceleration, and jerk of the trajectory. Ignore the fact that at the beginning and end of the trajectory there is an abrupt jump from being stopped to being in motion. 
%[text] %[text:anchor:M_71f3] The local function [`PlotDerivatives`](internal:M_637f) is defined at the end of the script. Set `UseComputedValues` to true to use the velocity and acceleration vectors returned by the built-in `bsplinepolytraj` function. When `UseComputedValues` is false, the velocity and acceleration are numerically computed from the points of the trajectory using `diff`.
UseComputedValues = false; %[control:checkbox:79b2]{"position":[21,26]}
PlotDerivatives(UseComputedValues,q,qd,qdd,tvec);
%%
%[text] Each example will open in a new tab and switch to a new file location. When you are done exploring the example, close the files that were opened, return to this script, and click the "Return Here" button. This will reset your file location to the root folder for this content collection.
  %[control:button:0204]{"position":[1,2]}
%%
%[text] ## B-Spline Trajectories
%[text] For more details on the `bsplinepolytraj` function, you can read the [documentation](https://www.mathworks.com/help/robotics/ref/bsplinepolytraj.html) or open another example of its use. 
openExample("robotics/ComputeBSplineTrajectoryFor2DPlanarMotionExample")
  %[control:button:94f1]{"position":[1,2]}
%%
  %[control:button:5426]{"position":[1,2]}
%%
%[text] ## Generate Minimum Jerk Trajectory Example
%[text] An example is given here for **Minimum Jerk Trajectories** to minimize the abrupt changes in acceleration experienced by the system.
openExample('shared_uav_robotics/GenerateMinimumJerkTrajectoryExample')
  %[control:button:9f79]{"position":[1,2]}
%[text] Open the scopes, dock them using the ![Dock All Scopes icon](text:image:2cf2) icon, and display them as a grid so you can follow all the output at once. Then run the simulation.
%[text]{"align":"center"} ![A screenshot showing that in a set of docked scopes, the breadcrumbs menu offers a "Tile All" option with an option to select a grid layout in different dimensions such as 2x2.](text:image:9e01)
%%
  %[control:button:1b1a]{"position":[1,2]}
%%
%[text] ## Package Delivery Quadcopter Example
%[text] Simscape Multibody provides tools for designing, simulating, and testing robotic systems, such as manipulators, humanoid robots, and drones. The **Package Delivery Quadcopter Example** simulates a complete flight by a package delivery drone.
openExample('sm/QuadcopterExample')
  %[control:button:6547]{"position":[1,2]}
%%
  %[control:button:74fc]{"position":[1,2]}
%%
%[text] [⇦ Main Menu](file:../../MainMenu.m)
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
%%
%[text] ## Local Helper Functions
%[text] %[text:anchor:M_99cc] Details of the `ComputeAndPlotTrajectory` function.  [$\\uparrow${"altText":"up arrow"}Return to text](internal:M_083a)
function [q, qd, qdd, tvec] = ComputeAndPlotTrajectory(wpts)
L = size(wpts,2) - 1;            % number of spline segments

% Build linear system A * dInterior = r to compute interior control points
% See standard construction for cubic B-spline interpolation
A = eye(L+1);
r = zeros(L+1, size(wpts,1));

% Fill interior rows
for i = 1:(L-1)
    A(i+1, i:(i+2)) = [1 4 1];
    r(i+1,:) = 6 * wpts(:,i+1)';      % note transpose to row
end

% Boundary rows (end conditions for cubic interpolation)
A(2,1:3)      = [3/2 7/2 1];
A(L, (L-1):(L+1)) = [1 7/2 3/2];

% Right-hand side for boundaries
r(1,:)   = (wpts(:,1) + (wpts(:,2) - wpts(:,1))/2)';   % r0
r(end,:) = (wpts(:,end-1) + (wpts(:,end) - wpts(:,end-1))/2)'; % rL

% Solve for the complete control polygon (columns are control pts)
dInterior = (A \ r)';                 % returns (2 x (L+1)) then transpose
cpts = [wpts(:,1), dInterior(:,2:end-1), wpts(:,end)]; % 2 x (nCtrlPts)

% Time vector and trajectory generation (piecewise cubic)
t0 = 0; tf = 5;
tvec = linspace(t0, tf, 501);
[q, qd, qdd, ~] = bsplinepolytraj(cpts, [t0 tf], tvec);

% Plot control points and resulting spline trajectory
figure
plot(cpts(1,:), cpts(2,:), '*--', 'DisplayName','Control Points') 
hold on
plot(q(1,:), q(2,:), 'LineWidth',1.5, 'DisplayName','Cubic B-spline Trajectory');
plot(wpts(1,:), wpts(2,:), 'ro', 'DisplayName','Waypoints');
hold off
legend
axis equal 
grid on
xlabel("X") 
ylabel("Y") 
title("Cubic B-spline Interpolating Waypoints")
end
%[text] %[text:anchor:M_637f] Details of the `PlotDerivatives` function       [$\\uparrow${"altText":"up arrow"} Return to text](internal:M_71f3)
function PlotDerivatives(UseComputedValues,q,qd,qdd,tvec)
tiledlayout(3,1);
if UseComputedValues
    TrajVel = qd(:,1:end-1);
    TrajAcc = qdd(:,1:end-1);
    TrajJerk = diff(TrajAcc,1,2)./diff(tvec(:,1:end-1),1);
else
    TrajVel = diff(q,1,2)./diff(tvec,1);
    TrajAcc = diff(q,2,2)./diff(tvec(:,1:end-1),1);
    TrajJerk = diff(q,3,2)./diff(tvec(:,1:end-2),1);
end

nexttile
plot(TrajVel(1,:),TrajVel(2,:))
title("Velocity")
nexttile
plot(TrajAcc(1,:),TrajAcc(2,:))
title("Acceleration")
nexttile
plot(TrajJerk(1,:),TrajJerk(2,:))
title("Jerk")
end

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
%   data: {"layout":"inline","rightPanelPercent":40}
%---
%[text:image:4fd9]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[control:button:567c]
%   data: {"label":"Run","run":"Section"}
%---
%[control:checkbox:79b2]
%   data: {"defaultValue":true,"label":"Use computed values? ","run":"Section"}
%---
%[control:button:0204]
%   data: {"callbackCode":"curloc = matlab.desktop.editor.getActiveFilename; if contains(curloc,\"Scripts\"), rootdir = extractBefore(curloc,filesep+\"Scripts\"); cd(rootdir); elseif contains(curloc,\"InstructorResources\"), rootdir = extractBefore(curloc,filesep+\"InstructorResources\"); cd(rootdir); else, error(\"Unexpected location: \" + curloc); end","label":"Return Here","run":"Callback"}
%---
%[control:button:94f1]
%   data: {"label":"Open example","run":"Section"}
%---
%[control:button:5426]
%   data: {"callbackCode":"curloc = matlab.desktop.editor.getActiveFilename; if contains(curloc,\"Scripts\"), rootdir = extractBefore(curloc,filesep+\"Scripts\"); cd(rootdir); elseif contains(curloc,\"InstructorResources\"), rootdir = extractBefore(curloc,filesep+\"InstructorResources\"); cd(rootdir); else, error(\"Unexpected location: \" + curloc); end","label":"Return Here","run":"Callback"}
%---
%[control:button:9f79]
%   data: {"label":"Open example","run":"Section"}
%---
%[text:image:2cf2]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAYCAYAAAAPtVbGAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG\/lYGhm2XEWKf\/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7DAAAOwwHHb6hkAAABuUlEQVRIie3Uv0sbYRjA8e9rVOoQKuQdSnSoGXIH0rgICkEoRep4KTi5OOQv6BL\/gNDlIFPn63\/g5uQoeUuxGWoCoZHq4ZDS4T1LgyhaUp28ejVH3lN06rPd++P58L7Pc694+27zkgeOkYcGAEbjJuZns6w5i4kTBse\/2P74jc\/No+HImrOI53kEQZAIsSyL10svhyMzz8YBUEolAq7DcZzI96PU5D+SKGK762bYto1lWZExrbVxYxghmUwmRKSUSClRdWWMGF2XUgrXdVFKIaVEa40OtBFgjAAUi0XK5TKe56G1ORCLBD9PcF13IHCXHzSsiRCwMPecp+kJ\/vw+5bz3hHw+T6vVotPpRAClVKLnJkTW3yyQm56k2\/0OpLnM2ggEpVKJarUaOUHS04TICytLrVaj3W5HFmxUNigUCvi+b5Tw31aPIAD9fj92s23bVCoVI2h37zAGEWLwDiEYS09zmjrj\/YetoYD\/4+LW2N\/Cx24TjIxO0DsfpzcggUmEiD7ukcvlIpOpVIqpqSzNw\/07Jb+F7DR8Xi2vsDqZBkR4e82vXT59MSv6UKTeOKDeOLhXsrh4lKf+Cjk8kfT6dittAAAAAElFTkSuQmCC","width":25}
%---
%[text:image:9e01]
%   data: {"align":"baseline","height":297,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWkAAAF1CAYAAAAqbxuuAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG\/lYGhm2XEWKf\/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO3de1wTd7438A8X5eaVBkHBukS37W7nlNOguOoSQ8Eeq+0q1NrdpcdGS+tK93nOea3o+uqz5OXGPj1shX3O2bPF7dZL6sru1lrQXlxXUWMs2lpNm9PY22KoVapI6rXcVOD5IwSSEG5hwgzJ5\/168WqZzMzvNxg+\/PKd38yEtLe3t4OIiGQpVOoOEBFRzxjSREQyxpAmIpIxhjQRkUhsNhs2btwIm80m2j4Z0kREInnjjTfw6aef4o033hBtnwxpIiKRPProo\/je976HRx99VLR9hnAKHhGRfHEkTUQkYwxpIiKR8MQhEZGM8cQhEZGM8cQhEVGQ4UiaiEjGGNJERCLhiUMiIhnjiUMiIhnjiUMioiDDkTQRkYwxpImIZIwhTUQkYwxpIiIZY0gTEckYQ5qISMbCjUaj1H0g6ubQoUNSd4FoyD3wwAPdloUkJydznjTJzhNPPIF169ZJ3Q2iIVNUVIQdO3Z0W85yBxGRjDGkiYhkjCFNRCRjDGkiIhljSBMRyRhDmohIxhjSREQyxpAmIpIxhjQRkYwxpClA2FG+SoBQYul5FXMxBEFAsVmkFivyIawqh93H7S0lffRXanXlyBcECC5f3X92dljMvf8EfDtOC4o92vbcR1\/77f7v47LPEku\/+u6xxyF\/jwFA+L59+8TbG5FIvF0e2x\/q6peRX6FHabbC4xULil+xQT34rnVSZJfCmu379imrrbCK1x1RWUoE5G5TQ3\/QitL4joV15cjPFJC\/wdjx87WjfJUGlQ8aUaoSsfG6cuRn6qDcboW1c7+OtoRVehg35cDzX9cbz38fe8XLMKQ7t\/e970P5HgOA8FmzZomyo+PHj0Osfcm93WA6VqnaffbZZ33b8MEsKPebYM\/2+EU2H4DtwSwoj5rE6F5gMxd3BHQpcuJdlsfnoHS7DcIyHcpne7w2YC4h6RF29mOVMKXroXcLTwVy1utRmVkJU12OT23X2kzAtJX9CHgLioVcYLsVBd4CfIjfYyx3UIBRY960SpjqXJfZUf6KDVmzp3Zb21Li8ZFayEd5x7b2ivxuH10d6xfDAo+P03XlyBfyUV5R7LIvx3pubbh8VO76uN7xMdrz473Xtrv3U2yWwwZg+UrvQagqgNVaipx4R8jqjgKmQk3nz8FSIiC\/oryzrODzx\/6jNtR6LovPQanV84\/DGfefncvPt+vfx\/Hzzd0GYFsuBCEPv1rRve\/9N7D32GAxpCngpGQoodvhUjesM6ESWVB7hI69Ih+51XoYrVZYrVZYrUbo003QrXf80iqyS1G2HDAsc4Rt1wizACleWzZBt1\/ZsT8j9OkG5AoCDmR07P+gHuptuV6CS4GcTc4+OL7KlgNI10OrApwhnouyrnW2K6HL9EdQ23GmGlArE\/tYT4GcTUbo0wH1BiOsLiUIU2EllAcd\/fQ6Eu1rz9kroYXjZycIAvIreonQbTrYnnb+3Mqg3ZbrZX3Hz7dsOYDlZbBaN+P5rd773l\/9fY+JYdiH9ObNm6XuwpAJpmMdFNU8aLcdgPNXyH6sEnhQ3e0XUZFd6vELqoD6QfeKYsrqMmhhwMslxchfZoB6g77Xj9rap53769hXZ9ACiJ8KZT+6b6\/IR+42LcqcfaszofKoFmWrXf40qApQttzkHhQiUk4ZaGy5SO85rLo+DbiMZLuFcQoKrFYYNzj+LVzX6fYHzvXnixTMWw6YbN3G4P3g+mkmFwYAhmW9nDDt53tMDOF+2OeQ2rJli9RdGDLBdKyDk4J5y3NxwFyAFJUdpv1A1noF0P0DtIO5GMIyQ9f36Vlu+yrYrnW8nq6HsdvJIldq9DkA7Yu5GJpCuI\/Wa20wwQCTYOi+\/vJBttcD21k7oPIxcqZN7TGsUlZbYV0N9FaTdnI\/8eeoExuW5UPpWivvpa2BcYy2c1za6rEm7TiSgb3HBmHYj6SJvEnJ0MJw2NLrx1BnzVlYZoO+4+O5c\/Tmtt5Zm+N\/vNVJxVRXjvxlBmi3u9ddHe1rUWZ1L4lYrVZYV3svvPhOganTehuNOkacYk4x658UFFjLoIUJlcd8nfQorv68x8TAkKbA1PFxtLzHj6F2mPabHDVJl5NRtTaPM\/N15dAVmqDeUOaoMfttXrMFxZk6YIOx2+hNMUUJwIYzfjpR6CnlCT3U2172Xu82G6A7KsInhh455jJ7r0MnQpnur3Z90Od7TByihfQ777wj1q5kL5iOFRiux5sIZboBukIga3bPvz6uI0ZHLdj1VTvK1+tgWl6G0uwU5Kzv6cTfYNlRvioXhnQ99N4++qu0bic0HXoLs0GKz8HK5abuJyY7Rvpddfm+Rt29cZQXupc6UqDdoIapUNP952w2QHdUi5W9lpz6337PfXfUxPs+6dm\/99hgiVaT3rt3r1i7kr1gOlZguB6v8yRgTx9DFcjZVAabkAvBGczpehi3K6FZ5piLO3WHBrqjWpRt6igpxOdAv6ESmo66qGgXLZgN0B0FAB00gs7tJXXHhSM5m4zAKo3b6+oNPddzBytltRXWjGIImQJce6T1qNOmZGiBZbkQtmlRZi0QpW1Fdimssx0XzgiuL6TrYbQOfCZGTzz7PvDCUV\/vMXGExMbGivIgWpVKBbN5yAtVkgimYwWkOd5nn32WD6KloMIH0RIRDUPhKpV4F92LuS+5C6ZjBYLveInkIlysj7HBVAIIpmMFpDleKe5RQiRHLHcQEckYQ5qISMYY0kREMsaQJiKSMYY0EZGMMaSJiGRs2N+qlALXiRMnpO4CkeQY0iRbaWlpUneBaMgcOnTI63KWO4iIZIwhTUQkYwxpIiIZY0gTEckYQ5qISMYY0kREMsaQJiKSMYY0EZGMMaSJiGSMIU1EJGMMaQo49op8CILg8lUMi9saFhQLAoqD5wloNIwxpCmAOMJXsz8LRqsV1o4v4wYbcoV8lNdJ3T+igWNIU8CwlOTCkK6HcVMOFC7LFdmlKFtugm59OeyS9Y7INwxpChAWHNgGaJ92D2inlNVWWDd5fw0AYC52K5HkV7jGuR3lq1zLJ91H5ZaS3l8n8hVDmgJD3RnYoIYyceCb2ivyISyzQX+wo0RyUA8UajqD2lKigW5amUv5BC6jckeA56Lrdet2JXSZDGoSB0OaAogSU+MHuo0dpv0mqDfokePcNj4H+g1qmPabYIcdZ6rdt1Bkl3aNyutMqDyqRdnqlK4VVAWO8soO99OVRL5gSFMAseHMgEevtbAdBZRT3AshitlZUB+1oRYK5DytBbblei9l1NpgggG5brNJBORuG+ShEHXgk1koMMRPhRI62GoBeBtN15UjP9OGldYCpHh5uZtaG0wAVgKAqgBWawEcpQ0NdJkCdFBDf7AU6rM2AFqU9Xe\/RAPEkTQFiBRoN6hheMX7DA7LDh1M6Up0L1knQpkO2M66b2U\/awO6ra9AziYrrFYj9OkmVB6zQzFFCd9G8ET9w5CmgKHIXgntUR00q9yD2l6Rj9xtaujXe5vdoYD6QTVMhbquMkZdOXSFJqgfVEPhnNlR4lJfrjOh8qgaWbMVgEoLfbrn9D7HfG33GSJEvmG5gwJICgqsVswrEaARdC7Ley9HKLJLYZ1SDCFTgHMr9QYjSrMdkZ6zqQw2IReCS51Zu93acaJRgZxNRmCVxq1N1+2JBoMhTQEnZbUV1tW9roECq9V9UWfduef1e3rVWQbJGWhHifqB5Q4iIhljSBMRyRhDmohIxhjSREQyxpAmIpIxhjQRkYwxpImIZIwhTUQkYwxpIiIZY0gTEckYQ5qISMYY0kREMsaQJiKSMYY0EZGMMaSJiGSMIU1EJGPhKpVKtJ2JuS+5C6ZjBYLveInkItxsNouyI5VKBbH2JXfBdKyANMc7a9asIW2PSK5Y7iAikjGGNAUce0U+BEFw+SqGxW0Nx9O8i6X+MFRXjnxBgODxdPOu1\/I7nmAuk\/6SJBjSFEAcYabZnwWj1Qprx5dxgw25nYEnH5YdOpjS1VAf1cHAAKYeMKQpYFhKcmFI18O4KQcKl+WK7FKULTdBt97LiFUyFhzYBmif1iMrHTActvS9CQUlhjQFCGfouQe0U8pqK6ybvL8GADAXu5VI8itc49yO8lWu5ZPuo3JLSe+vd2\/vAAzQYp5KAfWDamDbATCmyRuGNAWGujOwQQ1l4sA3tVfkQ1hmg\/5gR4nkoB4o1HQGtaVEA920MpfyCVxG5Y4Az0XX69btSugyewtqO8pfMQDL5yEFgCJ7JbQw4ABLHuQFQ5oCiBJT4we6jR2m\/SaoN+iR49w2Pgf6DWqY9ptghx1nqt23UGSXdo3K60yoPKpF2eqUrhVUBY7yyo4exsZ1JlQeVUP\/hHObFMxbDhhekVM5huSCIU0BxIYzAz45WAvbUUA5xb0QopidBfVRG2qhQM7TWmBbrvdSRq0NJhiQ6zabREDutp5btB+rhCk9C2qXPygpGVrgaCVMMju5SdILl7oDRKKInwoldLDVAvA2mq4rR36mDSutBUjx8nI3tTaYAKwEAFUBrNYCOEobGugyBeighv5gKdRnbQC0KOvvfmGBodAEwASNoOv2auUxO3Kye6ycUxDiSJoCRAq0G9Q9lgwc092U6F6yToQyHbCddd\/KftYGdFtfgZxNVlitRujTTag8ZodiihIDGsGbD8AAdVf92+WrbDlgKjTwBCK5YUhTwFBkr4T2qA4aj4tD7BX5yN2mhn69t9kdjtkVpkJdVxmjrhy6QhPUD6qhcM7sKHGJzo6actZsBaDSQp\/uOb3PMV\/bfYZIxyuHDcDylV31bxcpGVqAJxDJA8sdFEBSUGC1Yl6J4FFK6L0cocguhXVKMYRMAc6t1BuMKO0oO+RsKoNNyIXgUmfWbrd2BK0COZuMwCqNW5uu23eqK8fL2wDt9h56otJCn26A7rAFBU\/0\/6gpsIXExsa2i7GjYLrpUDAdKyDN8T777LNYt27dkLZJJKWioiLs2LGj23KWO4iIZIwhTUQkYwxpIiIZY0gTEckYQ5qISMYY0kREMsaQJiKSMYY0EZGMMaSJiGSMl4WTbJ04cULqLhBJrltIP\/vssz7vbNasWYPqzHASTMcKSHO8Go1myNskksqhQ4e8Lvc6kuY9E0hqRUVFUneBSBZYkyYikjGGNBGRjDGkiYhkjCFNRCRjDGkiIhljSBMRyZjfLmZpbm5GVVUVrFYrzp8\/j6amJkRHRSMxKRGCIGDOnDmIjIz0V\/NERAHBLyFdVVWFPXv2QKVS4ZFHHkFycjJiYmLQ0NCAmpoanDhxAoWFhVi8eDHmzJnjjy4QEQUE0UP67bffxunTp7F69WokJye7vRYTEwNBECAIAjIyMmAwGHDlyhU8\/PDDYneDiCggiFqTrqqqwunTp7F27dpuAe0pOTkZa9euxenTp1FVVSVmNygImYuUUCp7+VqxE\/UXd2KFcgV2XgQAM15QKvHCyUG3jBeUSiiVL6D789Td2zAXKaEsCp6nzJM4RAvp5uZm7N69G1qtFjExMf3aJiYmBlqtFnv27EFzc\/Og2rdX5HeO0h1f+Sivc1mhrhz5nssGQ+z90aCo1tlgs3V8HSuCBhoUHXNZtnUp4hKWYqttK5YmiNdu\/a7fY7NGAw024\/e76sXbMVEH0UK6qqoKqampfY6gPSUnJ0OlUg1qNG0pEaDZnwWj1Qqr82u7ErpMAcXOgUt8DkqtpciJ97kZIg\/1OLzXCM2C3+DnzwDGvYfBmCaxiRbSVqsVaWlpPm2blpYGq9XqY8sWHNgGaJ\/OgcJ1saoAZcsBw2GLj\/ulgONW7vDi5AtuJZIVfY2MLx7GPqMG838YB1VWHmDch8M97ZvIR6HjZ6zE2O89iug75yB87GSfd1R7vnbAo2in5ORknD9\/3ue2AcB21t5tWcpqK6yrUxzfeJQnLCUChBKL47\/OEsmqcrjuxb2EUozyivxu67gxF7uVXPIrelyTZKZ+1woolwK7nOUR2y5MWzuz16A2G9bBqJmPjAQA059GkcaIfe9yLB3s9uzZI+r+QmOn\/wwKza8wceHvMeWnb\/q8o8amxn7Xoj3FxMSgqanJx5ZToN2ghqlQ0xmm\/R47b8vFgQxniaQM2qM66JzBai6GphDQH3SWTwBdoanHXdkr8iEsA8qsXftTFmoY1MOCo2yRt\/M5qDqXqfDczjwY177i5YQgAJix749AXv5SxAEA4pCxQNPL+hQs9uzZI2pQh175cCtufP4WGms\/QOttX4MSiIqKQkNDg0\/bNjQ0IDoq2ue2FdmljpAFABiQ28PIuJt0PbSdv5UpmLccMNlqAdhR\/ooB6g36rhp2R\/nEOztM+03Qbi9ASueyFBRs18JUaOj\/Hw2SyDlUG4HNSz1mhCzd3PMmJ\/dhM\/Iwf3rXorgfzocGm7Fv0DNGaLgTM6jDL7\/33+5LfHwyS1JSEmpqaiAIwoC3rampQWJSok\/tdklBgdWKgo7v7BX50BTqoCmZ2lXy8DRtqnsdu1MtbEcB5dPuryYq1UB1z+sbjgowdHtN298DIKlcrEY1gLydNjw3vc+1AdRjZ6kjwJcouwe5sdKM56arui0n8oVoF7MIgoATJ074FNK+btcbRXYpjMiHpvAALKtT0ENMi6PuDGwAtNutKODv5vCTMA3TAFR\/WQ9Mj+t7\/YuHsc\/oPdTrd63AzLW\/x06tuFP9aHhZtGgRFi1aJMq+RJvdMWfOHJjNZtTU1Axou5qaGpw6dcrny8MdJ\/e816EVU5Q+7RNIhDK9+8nIWlsPNen4qVDC+8lLGg5UePpFDYxrf+k288Nc1HERjMfa9e\/ug1FThKe9jLodJQ+eQAxmYgY0IGJIR0ZGYtGiRTAYDP2uTTc0NMBgMGDx4sU+32xJkb0SWhiQ263+7Kwra30YRSuQ87QWpkJd18Uq5mLkbutpfefJS53bxS2Wkn7UxUkW4pZsxfsvAutmd9Wkl3xRhPe3Ok8MOpnxylojNAsy4HXMnbCUc6aDnJgBDYh87445c+bgypUrePHFF6HVanudkldTUwODwYB77713kDdZctSi55UI0Ag6t1e0260o9bX8oCqAcUM+NJkCHHvVQr9BDd1+76t3llc61weQrodxU04PdW\/ym4Sl2Gpb2sdyFZ6z2dxejluyFbYlfe28+3bd1lhng3MN13VdlxP1V0hWVla764JZs2YN+mnhVVVV2L17N1JTU5GWlub1LnhmsxmLFi0aVnfBs1fkQ2Nb2fOJSBJNUVER9Hq91N0gGjI6nQ47duzotjzcbHaf1Tlr1qxBNzZnzhykpqaiqqoKb731FmrP16KxqRFRUVFISkqCIAjQ6\/Uyvp+0HeWrNNBNK3O7GEZXaIJ2e6m0XSOioOK3m\/5HRkYiMzMTmZmZ\/mrCjxTI2VQGm5ALwaUOzdkbRDTU\/BbSw5\/7vGsiIinwGYdERDLGkCYikjGGNBGRjDGkiYhkjCFNRCRjDGkiIhnjFDySrcbGRqm7QCQ5jqSJiGSMIU1EJGMMaSIiGWNIExHJGEOaiEjGGNJERDLmtyl4zc3NqKqqgtVqxfnz59HU1IToqGgkJiVCEATMmTNHxveTJiKSB7+EdFVVFfbs2QOVSoVHHnnE65NZCgsLsXjx4mH1ZBYioqEmeki\/\/fbbOH36NFavXt3tGYcxMTEQBAGCICAjIwMGgwFXrlzBww8\/LHY3iIgCgqg16aqqKpw+fRpr167t9SG0AJCcnIy1a9fi9OnTqKqqGkSrFhQLAorNfa\/ZG3tFfscfkPyOJ35bYPHcZ1058leVww47ylcJnX9wPL\/c+lJXjvzOffazH30+YdxL34goIIk2km5ubsbu3btRUFCAmJiYfm0TExMDrVaLkpISpKamSlijtsBQaHJ5PJYFxUIusN0K10fO2o9VAg\/qO5\/+rd5gRGm2x7PAzcUQlgmAc1\/xOSi15ojaV299C3aWEgG523pZoc8nt3f9XPv9iDRzMYRlBu+vLS8T7YHFlhIBuXDZn9kCiyrF8e9fV478zEpkHSxFTrwozZHMiBbSVVVVSE1N7XME7Sk5ORkqlQpVVVXSPQ+x7gxsUCMrsbeV7DDtB7LWK4DexrmqApQtNyD3sAUFKsboUElZbYV1dcc3QxpcWpRZCzz+YDoCP1\/p5Y+4D1JWW2F1fmMuhrAMKLN2tCj6IIDkRrRyh9VqRVpamk\/bpqWlwWq19r3iYJiL3UoS+RX2ruWZOphggi5TgFCyC8VCLgwADMsECCWWjh3UwnZUial9\/tLbcaba5Vsv5Q5LiUt5ZFU5yktc23Eweazj6K2lh76RvKRAu0EN035TH2Uror6JFtK152sHPIp2Sk5Oxvnz58XqSjf2ivyO0YcVVqsVVmsZlIUaR1CrCmA9qIcaaugPWmFdvQQF1jJo4Xg6eNdHzAMwLJ\/Xd4nBbIDuqBr6J7yvaa\/IR+42bWdfjA9WQuf5Mf2oDpVKY0dfjdBDB02JBY6H43rpG\/WL2x9Ht\/MPLs6WI7+n8wuDUee+X88\/sF3nRDwGEc5+l1hcyisG5Dr71tcgwOM15zkPi1t7xeCfe\/Hs3btX1P2JFtKNTY39rkV7iomJQVNTk1hd8WCHab8J2u2uH0lTULBdC1Ohod9vTsthA7QZ7qFoKtR0P3G4zAZ9jx+znbXvrr4osvXQp3uup8XKzo\/JCqgfVAPVZzgqGwR7RT5yq\/Uwdv6hNkKfboJuvftJWkOhDSud62zXwrCs\/yd9O9WVQ1dogvpBtaMG3vFpTbm9a5Cg3ZbbFdTmYmgKlV2DiIN6oFDXvV1VAazbtXCUWLzVzh0ntF2P07gB0GV6HMNRHV6G3uXnYEAuP5WJZu\/evaIGtWg16aioKDQ0NPgU1A0NDYiOiharKx5qYTsKGI4KMHR7TdvPfdhxploN5RPuS91OHHaMcrTbe6mDeq19KzB1msd66Ur0Wh6nAVNkl8Ka7bbE8cdvv\/t6bn\/MVQUoWy4gd4cFOT1+ajEgVzB0W+r63rAcNgDLy1xC1TFIMCw7AMvqFCSetQFQdm3sa525zoTKo2roD3adIFVk66Hfr0HlMTtyOv\/wexkE7D8DO1J6ObFKA+EM6QULFgx6X6KFdFJSEmpqaiAIwoC3rampQWKSn2Kp7gxsgMvMDV\/2YUIlsqDvrR6tKoBxgw0a15kdJD+eMzLSs1xeVEPp8TZMVPYVYN5OHLpynKNQP+ixY9U8aPEyztQBKdkroS3M7Qx7r7OG+qPWBhOUWOn2PnWEsM5WCziPgIOAYUW0cocgCDhx4oRP2544ccKncO+X+KlQArCd9b1Y4Jh6p+5zlOEsXRiW9VDji58KJUyw1brt3f1EI\/lFZ813mc1x7sFqhXGDWroOdQweHFJQYO3qk7OM5lqXHoxam0mU\/VD\/LViwQJRRNCBiSM+ZMwdmsxk1NTUD2q6mpganTp3y4+XhHWfaPWp8lhKhl4tGEqFM7wr2WpsJyin9GdkokLNeDzUMeNnrL5ijL64hbq\/QQXd0IMfj3jfqD8d5CfUGI6zWrnJU9\/Dy\/APasc60qYMoAzjKWabuO4YJ3WcLKbJLu8J6oLNDEpVQw4YzbrXsjpG850cE8hsxAxoQMaQjIyOxaNEiGAwGNDQ09GubhoYGGAwGLF68eNAXshiWebn6r+NkiCK7tOMEStdrudW9Xdzg+IhoKtRAWPVfeHObFvP6W76Iz8HK5Y6Tit5mBiiySx3zqDv6odmfBf3ygRypa9\/6ujKRXLkGpWOWTfd13D4FmYuRu63nmTr9lZKhBbblurwfLCheZgA6Zgs5Rvmun746\/qh4+\/TmNYg7xKuR5XEy1DEIUCNrNqvNQ0XMgAZEvnfHnDlzcOXKFbz44ovQarW9TsmrqamBwWDAvffeO8hRtOOjYkEfa3U\/ceTCy4maXteHAjmbrOjp1I7bhRXovm\/31wFLia5zpOOtXc9lvfeNulMgZ1MZbEIuBGcwp+th3K6EZlklTHU5naNr7QYlXhYEOMbY6l5m6gyAqgDWg0rkZwroLOq5XJGoyC5FmU1wPwG5vAxWb3XpeDWy0nXQZQqo3GBE6WzP47RiaokAjaDrWCbSMZBkQmJjY9tdFzz77LNYt27doHZaVVWF3bt3IzU1FWlpaV7vgmc2m7Fo0aIguwue42IUW7dZIb1N2wtORUVFg34fEg0nRUVF2LFjR7flfrlV6Zw5c5Camoqqqiq89dZbqD1fi8amRkRFRSEpKQmCIECv1wfh\/aRTUHBQj\/xMDYRC5zKOdIioZ3676X9kZCQyMzOlux+HXPFeC0Q0AHx8FhGRjDGkiYhkjCFNRCRjDGkiIhljSBMRyRhDmohIxrxOwdO8wIuNSVrzOXwgAtDLPOkTz985lP0g6pT2q68AOK7AIgp2fruYhWiwXnrppSFt793DMzF1ahT+7RcN2LnrgyFtWyoqlQpms1jPCJO\/\/h5vaGgICp9T4mfPTMbt2+349fNnsHmr74\/4O378OGbNmoWxY8cOeFuGNBGA+\/95NKZOjcInnzag2tYqdXdIYm1tjmD+5NMG\/O7\/3YMN66dhZtpYfPZZA86db8bnXzTg8y8a0dzs\/\/cKQ5oIwE8enwQA+PNfLwCYIG1nSDZef+Miqs804NWt9+HhBXF4eEGc2+tfnXME9hf\/aMTnnzd0hHcDWlraROsDQ5qCXkREKHKyHcH8RnkdlFMZ0tTlw49uYN5DH+AHaeOgVEZhqjIayclRuOfuUbhzciTunByJeZl3uG1z9qtmWD4DPqoegc\/PhiMk5LbP7TOkKegteEiBmOgwvPn2JVy9dkvq7pAM1dXdxFt\/u4GwqBEIjQ5DWNQohEWOR8SECYhJiEPk+AkIHzUe7SPGo7VtDG43xwC3OuJ1HNDe3uxz2+EqlX+emNrU1IQjR47AYrHg3LlzaGxsRHR0NCZPnoyUlBTMnTsXUVFRfmmbAoO\/3puenslzPOH+5KlRnW0OVdtyEEzHCgz8eFtHfQctk1mv+O4AABtbSURBVB7GrfH397jObQC3Gx3\/PzIMmBDVjpg7bmLU6GaMG9MAYLzP\/Q33PNM5a9Ysn3fmdOTIEbz++utITU3FwoULu930\/4MPPsCaNWvw2GOPYe7cuYNujwLTUMw6SJwUiX++7weovdCCV7Y4HqQcTDMegulYgYEdb0xyBsbd96+InOQI57bWm2htrMftb+vR2mRHa0M9WhvqcbuhHrcbL+F2gx2tjfVoa7nRbV8rjx\/3uc+ilzsqKipgsViwevXqbo\/PiomJ6XzGoEajwauvvorLly8jO5vPgiJpPL7U8bSF13d5e2ggBZuQsJEYdc+PMO6+JzBy3BS0t7ej4cxBXPloK1oufSJJn0QNaWd5Y82aNYiJiel13eTkZKxZswYbN25EbGwsR9Q05EJCgH\/NdTxb8s9\/uSBxb0hKYRFjMfaffoKxwuMIjRqH9rbbuP7pHlz5cAtuXzsnad9EC+mmpia8\/vrrWL16dZ8B7RQTE4Mnn3wSJSUlSEtL86FGXY+dK2ZinbGXVZ7ZBds6MWpuZryg3If5tucwedcKzFzrpVFf2jpphnm6Cl1bmWE+qYJq+uB6S32bM3s8EuJH4r0T13DufJPU3SEJhI+djNiUJxFzzyMIDRuJ9ptNuGrZgWuW7bjdUC919wCIGNJHjhxBampqr08I9yY5ORmpqak4cuQI5s+fP8BW47B0qw1Lnd+efAHKpcAu23MQ\/VTIyX3Y\/Mx8PAegHgA0RXh\/61J0zZo04wXlEigxgKDu7K9zfcc+sNMmfv+pm8cfSwAA\/OWvHEUHm6gEFcbevwwxU9RASAham6\/isnkzrn38V681ZSmJdhsbi8WCGTNm+LTtjBkzYLFYxOqKX5grNyMvq7foVOHpFzXAF9WQx99f6s3o0WF4+OE4fNvQijff5r9YUAgJxa07ZiAp50+YlL0FMd+Zi1sNdah\/9zc4+6eHcOXkK7ILaEDEkD537tyAR9FOycnJOHfOj3Wfky9AqVR2fq3Y5fJLeXEnVihXYOcu13VWYOdF1x3Uo\/oLDaYlidj2yRegXLoZwGYsUSrxwknHKHozgM1LlVAWOc9A12PnCqXLPl6A67lpc5ESyqKdbuus2FXfcVw9HQ8t+lE8IkeGYvebdUNyaS9JKzQsEhMX\/A6N036GiHgBN6\/U4NLBQnz1p4dw\/eO\/ov227\/OY\/U20ckdjY2O\/a9GeYmJi0NjYKFZX3NTvWoGZa4GiYzYsTYAjvGbPxAq8j61LnMUKI9atnYZdNkeZoX7XCsyc\/QKmOcsmFw9jH+bjNwm9tWTGK2uBomNdJZDe234Otp1wL8\/YdgEd5Y7npjv2+YJyCTY\/swu2rY5RvLlIiSVKj5LOH9eheqcNtq3oCP+ZUGqK8L7NhjjnNs\/tRIZbeSa4\/Xip4x\/zNf71CnhhUbGYtPAljIy7B6HN9fj68Ato+NIodbf6TbSRdHR0NBoaGnzatqGhAdHR0WJ1xUU9Du81QvPib7DUGbAJS\/GbFzUw7j3sVpbI29kVenFLfoMizWb8vmPUW\/\/uPmBBhnvAGddhptJ1hLsEm2FEdeeNsvrfdo9O7sNm5GGXS41btW4X8rAZ+066rKcpwtPOE43T5yMPQF5+VyBPnqbpT2tBY6oyCqn3j8GZM004eeq61N0hPxoxXonEpX\/FyLh70GL\/AjGfDK+ABkQM6cmTJ6OmpsanbWtqajB58mSxuuLiHKqNwLTvuI8f4344HxpjNboKLJ6ljDhMuwswVjvWOFdt7LYPdIxUbS5fu54BNi91lhb623bP6r+sBjTT4P6TUWH+M0D1ly4xf9c0jpAH4Kc\/cb2ZEgWqyImpSMp5FSOi49B47j3U7tEi9Nbw+6MsWkinpKTggw98uwfvBx98gJSUFLG60rfz1TD2e2Uz9v0xD\/P7MSXOMcp1HU0Ptm1v6lH9xaB2ENRCQ0Pw+GMJaGsD\/vo6QzpQjZr2L5j0yMsIHTkKNz5\/Cxf2\/hztN4fnNEvRQnru3Lk4derUgEfTNTU1OHXqlJ8uZpmMaRqPUSe8jVA9g9URhJppkzun3g18Slx\/2+5Z3HemAd1G3d5H6NQ\/mRmxuCN2BPZX2nH5Mm+mFIjGT38a8fOKEBIaisvvv4RLh3RA2\/A9OSxaSEdFReGxxx7Dq6++2u\/adENDA1599VU89thjfrrZUhwyFmhgXPvLrtkNF3fil2uN0HjUmDcv7Zo1Ub\/rl1hnzMPPl8Sh\/stqR1j3Q\/2u32NzZ324H20nTYMG1ajuPHflEezT5yMPm7GkqGs+h7loCTajfyN76u7Hj08EAPyVJwwDT2gYJjygR+yMfLS3tuLi\/jW4Yt4sda8GTdTLwufOnYvLly9j48aNePLJJ3udkldTU4NXX3218454\/hK3ZCts33kBytlKrOtYpnnRdWYHAGhQ9CKwRKns+D6vY\/ZEPXbuBea\/4GXUalyHmcp17ss8LnDps+2EDMzXrMO62Urs61iesUCDdWtnQrnXsa\/nbO9j2oqZ6OxaZ99ooGJjR2DBfAXs39zE3\/fzYcuBJGRkFCbO\/x2iEqej7ea3uLD3f6P5wodSd0sUot9gKTs7G7GxsSgpKUFqaipmzJjh9S54p06dEv8ueNOfg83W0\/Lnet\/2h97WicPSrVu7rRq3ZCtsSwbSp57a9rhi0uu+u6\/jSrXOBvdDVuE5jx\/CgPobwB7NcdxM6bXXeTOlQBIWMwGTHvkDRo5Pxq1vL+LCWz\/Dratnpe6WaPxy0\/+5c+ciLS0NR44cwTvvvOP1ftIbN27k\/aRpSD3ZcTOlv\/z1a4l7QmIZMV6JxB+9grDoWLTUf4qv385HW\/NVqbslKr89mSUqKgrz58\/34X4cROK7758cD5o99eF1nLENz7P85C4ycQYmzf8vhIyMQsO5Y6j72y\/Q3toidbdEx8dnJSzFVltPxQQKFD95vONmSq\/xhGEgGHX3w4jX\/BoIDcW1T8thP\/J\/gXbxHv4qJwxpCnjhI0KQvTgBzTfbULGbIT3cxaY9i\/GpeWhvb8c3x36La5Y\/Sd0lv2JIU8Bb8C9xGDsmDK\/vuojGxsAcbQWL8TNWYXxqHgCg7u8FaKg5JHGP\/I8hTQHPWer482u8wnA4G\/Xd+Yid\/gzabzbh67dWovnSx1J3aUiIdjELkRxNTIiAZm4svjzbhPfevyZ1d8hHUYkzMCHz\/wJtbbiw79+CJqABjqQpwC3tePoK50YPXyMVdyHhod8hJCQUlw7r0FTr2z2ChqseQzrtV18NZT+I\/CL3JxPR3h6Cv7zGudHDUfioBExauAmhIyLxzYmXcOPzt6TuUr889dRTyMvLE2VfXkP6xSxvl+0RDZ1DIpwP+sHMsZicFAnjkW9QV3dz8DukIRUaMRqTFjkuVLn22W5cPTV87sOxZcsWbNmypfP748eP+7wvryGdlpbm8w6JxHBIhJR23kyJc6OHn5CwCExaWIoRY5LQ+NUx2I0bpO6SZHjikAJSdHQoFv1oAq7fuI29f+eDZoeVkFAkzP8tIuIFtNRZcXHfLwL2QpX+YEhTQPrRwxMQOTIUO3fV4fatdqm7QwOg0BQi+s7ZuHX9PL5+Jz8gL\/UeiD5nd9RevO23xtvR8y9PUsIISdum4e3xpR2lDj4ia1gZr8rD2HsWo7XxMr7e8zTaWm5I3SXJheevvBOlL\/c8k6Md7Sj\/29D+oHIeGt35\/2\/8bWifSebaNg1P35kShR+kjcXHH9\/AJ59+K3V3qJ9Gf3chYmc+i9bbjotVbn\/LcwkAEF74f5Q4\/v4VfPhR70HcYt\/S6+tiiVA8Jau2N27cOCRtA8CaNWska19ubQ9G5yiaT18ZNqISZ2DCA3q0t7ehbu+\/4eblaqm7JBvhAPBy6b3I\/JcPcONG788By1j8C7925vDu3\/b4msbPbRt7aVvsEPGmt0D0d\/tybdtXjz\/muLn\/G7t5ActwMFJxN+IX\/BcQGopL+9cG3cUqfQl9\/8Q1TE6KxH+WfE\/qvhANWsbcWExMiMCety7h+jX\/ndMgcYSPSsCkR\/6AsPAofPP+f+PbMwek7pLshK7M\/wRXr9\/GgvkK\/PTHE6XuD9GgPL604zJwljpkLyxirONilchxjotVzN0fVUdAaN2lFvyv\/\/0JAGDN6p4fHEskd2PGhmPRIxNwqf4WDh+5LHV3qBchYRGY+KM\/YMSYJDR8eSSoL1bpSygAVB66jDffvoSE+JFS94fIZzmLHLXonbs47U7WQsMcF6so7kFLnRV1f18T1Ber9KXzYpbC9f\/Atw29nzgkkjPnZeCv7eQJQzlTqJ9D9J2zcfNKDS68\/Sza225J3SVZ6wzpS5duYeNva6TsC5HPpiqjkPJPo2D+6DqqzzRI3R3qwfjpz2Ds93Jwu\/EbXHg7H603h\/Y6iOHI7bLwLVvPS9UPokF54qeTAACvvc4ThnI1+rsLETtjFdpuNeLCWz\/jxSr95BbSrax20DAUGhqCx5Yk4Natdux+85LU3SEvou6c3XmxyoV3fs6LVQaAN1iiYW9e5h24I3YE9u6r59xoGRqpuBsJ8\/8fEBKCSwfWofnCh1J3aVhhSNOw1\/mILM6Nlp0RY5Iw6ZE\/IDRsJOzv\/ScvVvEBQ5qGtTFjwzEv8w5crLuJI0evSN0dchEWMRYTnRerWF\/DtY+2S92lYYkhTcPa448lYMSIELz+xkW0tfG+0XIRGh7luFhlVILjYpV3fyN1l4YthjQNa0\/mJgIAdpTxQbOyERqG+AX\/hQjFPWi68FHHxSr8A+orhjQNW4IwClOnRuHUh9fx1blmqbtDHSZk\/BrRiTNw89pZXHyHF6sMFkOahq0fO2+m9DovA5eL2LR8jL5rIW411uPC7mfQdqtR6i4Ne+EqlUrqPhB51dt7MywcePyxMbh5CzhjmwiVStw7OAbT74VYx3orLh2NSi3Q2oLYf\/wnFPckAUgSZd9i8se\/7YIFC7Bw4ULR9wsA4Waz2W3BrFmz\/NIQ0UB5vjddLXxoAkbFfB+736zDsWOfitquSqXqte1AItaxRt05GxPTngTabuPrt1bJdi60v\/5tzWYznn\/++R5fP378uM\/7ZrmDhqUfP+4sdfBmSlKLiL8PE\/\/ltwgJCcGlyudkG9DDFUOahp077hiBBzSxjrnRJt43Wkojxk3BxIW\/Q0h4BOzvvsiLVfyAIU3DzuNLJiI0FHj9jYuc2SWh0Og7MPGRPyAsYiyuWv6Eax\/\/ReouBSSGNA07zse8cW60dMJiJmDSw5swYlQCvq3+O7451vODnGlwwqXuANFAqO4fg6lTo3DSzLnRUhk59juYuOhlhMdMQGPtB6g7sE7qLgU0hjQNKz9e2vH0Fd43WhIRd9yNiT\/6A8Iix6Gx9n3U\/e0XUncp4A0opA\/vlu4jjVHCtjdu3ChZ21K3L\/Wxu4qICMWjOfFovtmG8gqG9FCLiL8Pkx4uRejIGDR8eQQX\/14AtPHWsP7W75COUDzlz37Itu01a9ZI1rbU7Ut97J4WzI9DdFQoKvZcQmMjH1w6lKKS0jDxIccsjhtf7MWlQ4V8eOwQ6TOk7ZdboZ4ZPRR9cWszKWEE6i\/flqxtkp\/HeRm4JGK+o0H8g8UICQvDNevrsL\/7H7xh0hDqM6QVsWEo\/9uNoehLp5yHRgMA4mLD8cbfhvZBlc62SV7i40dibvp4XLjYgiMm3jd6qIz+7gLEZT6PkJAQXDn5Ci5\/UCp1l4JOv8sdLfYt\/uxHJ2+lDSnbHsqarLfywlC1L7e2PS1d4hhF79zFWvRQGfdPubhjzmogJATfvFuMqx+XSd2loDSgE4cZi\/17Jre3E5NStj0UtdneAtHf7cu1bVf\/mut4Gvif\/8JSx1CInf4zjJ+xEmhvxyXjr3Hj091Sdylo8WIWkq2I+PsAADPTxmJyUiTnRg+RO+ascQQ0gLr9v2RAS4zzpEm2knJexdX\/2YHHF78DgHOjh8KEBzZg9N0Po631Jur2\/jsaz\/t+9zYSB0fSJFutzVcx7r4nsLXhv3Hy62TOjfaz+Pm\/dQT0rUZceHMlA1omGNIkW+f+vBhoPYGmOgX+ffvPEfH9p4AQvmXFFhIeiUmPvIxRyRlobb6KryuWo\/niR1J3izrwHU+y1dpyDS9mbcK\/L3kDba1NiJ2Rj6RHdyB87GSpuxYw2sOjMOlHLyMqKQ23GuvxdfmTaPnmC6m7RS4Y0iRbk5OiMPsH4\/DDMYdwbkcOGms\/QETc9zDlp29i7H0\/lbp7AeHb769DZPx9uHX9PGrf+FfcvPaV1F0iDwxpki3XB83ebriEC28+A7vpP9DWehOKOWsw8Ud\/RHj0BIl7OTyN+u58THmyEm1RSWi5fAa15U+i9Vs+5UaOGNIkWz\/9ieOOd65zo6+d3olzry1B86WPEZ04A5N\/8gZG3\/2IVF0cdsJGxWPiwpcQn\/UfCI++AxEX9uHr3cvR2sQn3MgVQ5pkKyF+JD44da3b3Ojb186htlyLy++\/hJCwKEx4QI+JC3+PsIixEvVU\/kJCwzD+\/qcw5Sd7EH3nbNz8phrnd\/4YkV+9jraWob3tAw0M50mTrPX4oNn2Nlwxb8a3Xx5GwvwSRN85B3f+ZDfqDv0KjV9VDW0nZS4yIQVxD\/waI8dOQfvtFlx+73e4YtkOtLUCU1RSdy8gPfXUU8jLyxNlXwxpkrU33+q9Tnrr8hmc+\/Ni3PGDf8e4+5\/ExIW\/x40v9uLyyVLcvlY7RL2Up7CIsbjjh2sw+q6FAICm2pO4dGR90P9chsKWLVuwZUvXPYeOH\/d9zjlDmmSr7C8XcONGa7\/W\/ea9\/0TDl0ZMyHoeo+9agNF3LcC3tkpc\/XAbWi594ueeys\/oux\/BHbN\/gbDIcWhtuQb7sd\/i28\/elLpb5AOGNMnWHzefG9D6zRc\/wvm\/PoZx0\/Mw9t6lGKXMwihlFhprP8DVjwxo+uqYn3oqHyPGJGFCxnpETkoFANz4Yi\/sVRvR1nxV4p6RrxjSJFtf\/KNxwNu03W7C5ff+G1dPbsboe5dgXMoTiE6cgejEGWi59AmufLQNDbZDAfdUkZCwkRifmodx9y9HSGg4bjdcQv2h9by0OwAwpCkgtd1uwjXLn3Dt479gzF2PYOz9TyJiwveR8OBG3Lx6Ftc+fBXXv3grIJ7RF5U4A3Ga9RgxZhLa29tx9eMyXHnvJbTdbpK6ayQChjQFtrbbuP5ZBa5\/VoFRynkYr1qBkXH3IC5Dh3EzV+HaR3\/CjdO7hl2ghY9KwChlFiLvnIWYybMBADe\/qcYl43q0XDotce9ITAxpChrf2g7gW9sBRCX9AONVTyEqcToUs3+BcdPzcOPj13D1f\/4s69rtiNipiEnOwKjvZCBiwvc7l9+6fh7XP63AVfNWCXtH\/sKQpqDTdP49NJ1\/DxGKezBelYeYqZkYn\/o0xv7zk7j+aTnQaJK6i50iJtyLmORMxEx9ACPHTulc3vLN52i0GdFQc4g3RApwDGkKWi32z3BxfwFGjr0TY+9fgTHfW4Rxwo9xDT\/G1DSgqe5\/cPNyNW5dPoOWS5\/gpv3zISmLRCXOwKjkBxCdnIHwUfGdy5suWtBQcxiNZypx6wbnOgcLhjQFvZvXvkK9cT2ufPASRt+9CPF3zUbjiImIir8PUR2P8HK6df08Wr75B27aP8PN+s\/RcuUfuH3960H3ISJewOjvP4oY5QMIHzmmc3njuffQ8OUhNJw5yPtrBCmGNFGH2w31uGLejGSY8ZnZjLCIsYiYcC8i4r6PiHgBEXHfw4gxSRgxJglIzujcrv1mE1rsn6H5m0+A1laEjYgBRkYjdGQ0QsNjEDoyBiEjoxEyIhphI2IQOiK6xz60327BtzWH0Wg7hIYvjWi7+e1QHDrJGEOaqAetLdfQeO4YGs91XQQTFjEWI+MdwR05wRHc4TETEDnpfkROur\/vfTZfxc1GO9parqGt+QbaWq6j9eZ1tDVfQ8ulT9B47jjaW1v8eVg0zDCkiQagteUamr465nb1YmjUeEROuBcRd9yDtrabaG++gdab19HafA1tN6+jrfk62lquo+3WwC\/OIWJIEw1SW9MVNJ59F41n35W6KxSABhTSh3f\/1l\/9kHXbGzdulKxtqduX+tiJgl2\/QzpC8ZQ\/+yHbttesWSNZ21K3L\/WxE1E\/Q\/rRh7qmBLWjHSEI8VuHnG14a3souLZNRCS1PkM6KWHEUPTDq8QElsyJKLj1OwWHqjbp7SN2MLQtdftya5uIHAY0VPX3L1NvoRDIbUvdvlzbJiI+LZyISNYY0kREMsaQJiKSsXCVSiV1H4i8kvK9GUy\/F8F0rIB\/jnfBggVYuHCh6PsFgHCz2ey2YNasWX5piGigPN+bQ0WlUknW9lALpmMF\/He8ZrMZzz\/\/fI+vHz\/u+wOBWe4gIpIxhjQRkYwxpImIZIwhTUQkYwxpIiIZY0gTEckYQ5qISMYY0kREMsaQJiKSMYY0EZGMMaSJiGSMIU1EJGMMaSIiGWNIExHJGEOaiEjGGNJERDLGkCYikjGGNBGRjIUPZOWNGzf6qx9sW6btS33sRMGu3yG9Zs0af\/aDbcuwfamPnYhY7iAikjWGNBGRjPW73DFUtUlvH7GDoW2p25db20TD2VNPPYW8vDxR9jWgE4f+\/mXqLRQCuW2p25dr20TD1ZYtW7Bly5bO748fP+7zvljuICKSMYY0EZGMMaSJiGSMIU1EJGMMaSIiGWNIExHJGEOaiEjGGNJERDLGkCYikjGGNBGRjDGkiYhkjCFNRCRjDGkiIhljSBMRyRhDmohIxhjSREQyxpAmIpIxhjQRkYwxpImIZIwhTUQkYwxpIiIZY0gTEclYuEqlkroPRF5J+d4Mpt+LYDpWwD\/Hu2DBAixcuFD0\/QJAuNlsdlswa9YsvzRENFCe782holKpJGt7qAXTsQL+O16z2Yznn3++x9ePHz\/u877DB7Lyxo0bfW5osIK1banbl\/rYiYJdv0N6zZo1\/uwH25Zh+1IfOxHxxCERkawxpImIZKzf5Y6hqk16+4gdDG1L3b7c2iYihwGdOPT3L1NvoRDIbUvdvlzbJiKWO4iIZI0hTUQkYwxpIiIZY0gTEckYQ5qISMYY0kREMsaQJiKSMYY0EZGMMaSJiGSMIU1EJGMMaSIiGWNIExHJGEOaiEjGGNJERDLGkCYikjGGNBGRjA3opv9ERNS3p556Cnl5eaLsiyFNRCSyLVu2YMuWLZ3fHz9+3Od9sdxBRCRjDGkiIhljSBMRyRhDmohIxhjSREQyNqDZHRs3bvRXP9i2TNuX+tiJgl2\/Q3rNmjX+7AfblmH7Uh87EbHcQUQka15H0kVFRUPdDyIi8qJbSL\/00ks+7UilUsFsNg+6Q8NBMB0rEHzHSyQnLHcQEckYQ5qISMb+P5\/KiN2uI+bFAAAAAElFTkSuQmCC","width":287}
%---
%[control:button:1b1a]
%   data: {"callbackCode":"curloc = matlab.desktop.editor.getActiveFilename; if contains(curloc,\"Scripts\"), rootdir = extractBefore(curloc,filesep+\"Scripts\"); cd(rootdir); elseif contains(curloc,\"InstructorResources\"), rootdir = extractBefore(curloc,filesep+\"InstructorResources\"); cd(rootdir); else, error(\"Unexpected location: \" + curloc); end","label":"Return Here","run":"Callback"}
%---
%[control:button:6547]
%   data: {"label":"Open example","run":"Section"}
%---
%[control:button:74fc]
%   data: {"callbackCode":"curloc = matlab.desktop.editor.getActiveFilename; if contains(curloc,\"Scripts\"), rootdir = extractBefore(curloc,filesep+\"Scripts\"); cd(rootdir); elseif contains(curloc,\"InstructorResources\"), rootdir = extractBefore(curloc,filesep+\"InstructorResources\"); cd(rootdir); else, error(\"Unexpected location: \" + curloc); end","label":"Return Here","run":"Callback"}
%---
