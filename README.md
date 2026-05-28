<a id="T_DEF03274"></a>

# <span style="color:rgb(213,80,0)">Introduction to Quadcopter Modeling & Simulation</span>

Pranav Lad, Dhruv Chandel 

<a id="H_053613DF"></a>


[![View on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/XXXXX-PROJECTNAME) or [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=README.mlx)

[![MATLAB Versions Tested](https://img.shields.io/endpoint?url=https://mathworks-teaching-resources.github.io/Quadcopter-Modeling-Simulation/TestedWith.json)](https://mathworks-teaching-resources.github.io/Quadcopter-Modeling-Simulation/)

**Curriculum Module**

_Created with R2025a. Compatible with R2025a and later releases._

# Information

This curriculum module contains interactive [MATLAB® live scripts](https://www.mathworks.com/products/matlab/live-editor.html) that teach the fundamental principles behind how a quadcopter operates.

<p style="text-align:left">
   <img src="Images/DroneScene.png" width="737" alt="DroneScene.png">
</p>

<a id="H_F00D98E4"></a>

## Background

You can use these live scripts as demonstrations in lectures, class activities, or interactive assignments outside class. Starting from the basics of mathematical modeling, we will build up to a full simulation of a quadcopter delivering a package. We will also look at different fidelities of simulation ranging from simple cuboidal navigation models to detailed physical models to photorealistic simulations suitable for testing sensing and perception algorithms. Further resources are provided for student projects, competitions and researchers looking to develop their skills further for industrial applications or research.

The instructions inside the live scripts will guide you through the exercises and activities. Get started with each live script by running it one section at a time. To stop running the script or a section midway (for example, when an animation is in progress), use the <img src="Images/EndIcon.png" width="19" alt="EndIcon.png"> Stop button in the **RUN** section of the **Live Editor** tab in the MATLAB Toolstrip.

## Contact Us

Contact the [MathWorks Educator Content Development Team](mailto:onlineteaching@mathworks.com) if you would like to request assistance, provide feedback, or if you have a question.

<a id="H_30BC7141"></a>

## Prerequisites

It is expected that students going through this course should be familiar with the basics of MATLAB programming and working with the Simulink environment. They should also have a basic understanding of ordinary differential equations, physics, and numerical simulations. Additionally, a knowledge of basic Control Systems and Physical Modeling with Simscape will also be helpful. 

To help with the background requirements, Online Self\-Paced Courses are available on MATLAB Academy, which the students can use to learn more:

<u>**Fundamental introductions to the tools and environments**</u>

- [**MATLAB Onramp**](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted)
- [**Simulink Onramp**](https://matlabacademy.mathworks.com/details/simulink-onramp/simulink)
- [**Simscape Onramp**](https://matlabacademy.mathworks.com/details/simscape-onramp/simscape)

<u>**Targeted learning for specific workflows**</u>

[**Quick introductions**](https://matlabacademy.mathworks.com/?page=1&fq=onramp&sort=featured)

- [Control Design Onramp with Simulink](https://matlabacademy.mathworks.com/details/control-design-onramp-with-simulink/controls)
- [Circuit Simulation Onramp](https://matlabacademy.mathworks.com/details/circuit-simulation-onramp/circuits)
- [Power Electronics Simulation Onramp](https://matlabacademy.mathworks.com/details/power-electronics-simulation-onramp/powerelectronics)
- [Multibody Simulation Onramp](https://matlabacademy.mathworks.com/details/multibody-simulation-onramp/ormb)
- [Simscape Battery Onramp](https://matlabacademy.mathworks.com/details/simscape-battery-onramp/orsb)

[**Doing math with MATLAB**](https://matlabacademy.mathworks.com/?page=1&fq=mathematics-and-optimization&sort=featured)

- [Introduction to Linear Algebra](https://matlabacademy.mathworks.com/details/introduction-to-linear-algebra-with-matlab/linalg)
- [Introduction to Solving Ordinary Differential Equations](https://matlabacademy.mathworks.com/details/introduction-to-solving-ordinary-differential-equations/otmlsode)

[**Physical modeling**](https://matlabacademy.mathworks.com/?page=1&fq=physical-modeling&sort=featured)

- [Motor Modeling with Simscape Electrical](https://matlabacademy.mathworks.com/details/motor-modeling-with-simscape-electrical/otslmmse)
- [Battery State Estimation](https://matlabacademy.mathworks.com/details/battery-state-estimation/otslbse)

[**Control Systems**](https://matlabacademy.mathworks.com/?page=1&fq=control-systems&sort=featured)

- [Control System Modeling Essentials](https://matlabacademy.mathworks.com/details/control-system-modeling-essentials/otmlslcsme)
- [PID Control Techniques](https://matlabacademy.mathworks.com/details/pid-control-techniques/otmlslpct)

Each of these courses awards a certificate upon completion. The courses can also be assigned as homework alongside the course.

<a id="H_330E72C3"></a>

## Getting Started

### Accessing the Module

### **On MATLAB Online:**

Use the [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-and-Simulation&project=UAV.prj) link to download the module. You will be prompted to log in or create a MathWorks account. The project will be loaded, and you will see an app with several navigation options to get you started.

### **On Desktop:**

Download or clone this repository. Open MATLAB, navigate to the folder containing these scripts and double\-click on [UAV.prj](<matlab: openProject("UAV.prj")>). It will add the appropriate files to your MATLAB path, set up your starting directory, and open an app that asks you where you would like to start. 

Ensure you have all the required products ([listed below](#H_E850B4FF)) installed. If you need to include a product, add it using the Add\-On Explorer. To install an add\-on, go to the **Home** tab and select  <img src="Images/AddOnsIcon.png" width="16" alt="AddOnsIcon.png"> **Add-Ons** > **Get Add-Ons**. 

<a id="H_E850B4FF"></a>

## Products

[MATLAB®](http://www.mathworks.com/products/matlab.html), [Simulink®](https://www.mathworks.com/products/simulink.html),  [Stateflow®](https://www.mathworks.com/products/stateflow.html), [Aerospace Blockset](https://www.mathworks.com/products/aerospace-blockset.html), and [Simulink® Real\-Time™](https://www.mathworks.com/products/simulink-real-time.html) are used throughout. The [RigidTransforms](#M_5db9) script also uses the [Image Processing Toolbox™](https://www.mathworks.com/products/image-processing.html), and the [Computer Vision Toolbox™](https://www.mathworks.com/products/computer-vision.html). The [Trajectory Generation](#M_3cef) script also uses the [Robotics System Toolbox™](https://www.mathworks.com/products/robotics.html). The [QuadcopterBasics](#M_531f) script and [PropellerModel](#M_72c8) script also use the [Symbolic Math Toolbox™](https://www.mathworks.com/products/symbolic.html). The [QuadcopterMovement](#M_8e4a) script uses the [UAV Toolbox™](https://www.mathworks.com/products/uav.html).

<a id="H_E8C62B23"></a>

# Learning Materials
<a id="TMP_8fac"></a>

## Mathematical Background
<a id="TMP_3d4b"></a>

###  **1.** [**Projectile Motion**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/ProjectileMotion.mlx)

Introduction to numerical modeling & simulation of differential equations.

||||
| :-- | :-- | :-- |
| <img src="Images/ParabolicEquation.png" width="171" alt="ParabolicEquation.png"> <br>  | **In this script, students will...** <br> $\bullet$ Practice creating numerical simulation models in MATLAB and Simulink.  <br>  | **Models referenced** <br> $\bullet$ [Projectile\_1D.slx](./Models/Projectile_1D.slx) <br> $\bullet$ [Projectile\_1D\_WithDrag.slx](./Models/Projectile_1D_WithDrag.slx) <br>   |

<a id="TMP_9e30"></a>

###  **2.** [**Rigid Transforms**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/RigidTransforms.mlx)

Introduction to mathematical modeling with six degrees of freedom.

||||
| :-- | :-- | :-- |
| <img src="Images/SixDOFBlock.png" width="171" alt="SixDOFBlock.png"> <br>  | **In this script, students will...** <br> $\bullet$ Learn about movement in 6 degrees\-of\-freedom. <br>  | **Models referenced** <br> $\bullet$ Modeling a Six Degree of Freedom Motion Platform <br>   |

<a id="TMP_8a3f"></a>

## **Modeling a Quadcopter**
<a id="M_72c8"></a>

###  **3.** [**Propeller Model**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/PropellerModel.mlx)

Create a simple propeller model using blade element theory and dimensional analysis.

||||
| :-- | :-- | :-- |
| <img src="Images/PropellerBlock.png" width="171" alt="PropellerBlock.png"> <br>  | **In this script, students will...** <br> $\bullet$ Construct a minimal physical model of a quadcopter propeller. <br> $\bullet$ Understand how rotor speed produces thrust and torque. <br> $\bullet$ Understand how thrust and torque depend on the width of a rotor. <br>  | **Models referenced** <br> $\bullet$ [SimplePropellerModel.slx](./Models/SimplePropellerModel.slx) <br>   |

<a id="M_531f"></a>

###  **4.** [**Quadcopter Basics**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/QuadcopterBasics.mlx)

Describe the basic components of a quadcopter and explore a simple physical model.

||||
| :-- | :-- | :-- |
| <img src="Images/QuadcopterSchematics.png" width="171" alt="QuadcopterSchematics.png"> <br>  | **In this script, students will...** <br> $\bullet$ Learn the fundamental components of a physical quadcopter <br> $\bullet$ Learn how to balance forces to model a quadcopter hovering <br>  |   |

<a id="M_8e4a"></a>

###  **5.** [**Quadcopter Movement**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/QuadcopterMovement.mlx)

Explore the implications of moving in a 3D world.

||||
| :-- | :-- | :-- |
| <img src="Images/PitchRollYaw.png" width="171" alt="PitchRollYaw.png"> <br>  | **In this script, students will...** <br> $\bullet$ Learn the fundamentals of quadcopter movement: elevation, pitch, roll, and yaw <br>  | **Models referenced** <br> $\bullet$ [UAV\_Sim.slx](./Models/UAV_Sim.slx) <br>   |

<a id="TMP_369f"></a>

###  **6.** [**Quadcopter Control**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/QuadcopterControl.mlx)

Investigate using PID control systems on a quadcopter.

||||
| :-- | :-- | :-- |
| <img src="Images/PIDScope.png" width="171" alt="PIDScope.png"> <br>  | **In this script, students will...** <br> $\bullet$ Learn how to implement hover control in a Simulink model.  <br> $\bullet$ Learn how to implement directional controls in a Simulink model. <br> $\bullet$ Practice tuning a PID controller. <br>  | **Models referenced** <br> $\bullet$ [QuadcopterPID_Vertical.slx](./Models/QuadcopterPID_Vertical.slx) <br> $\bullet$ [UAV\_Hover\_Sim.slx](./Models/UAV_Hover_Sim.slx) <br> $\bullet$ [XY\_Control.slx](./Models/XY_Control.slx) <br>   |

<a id="TMP_6d41"></a>

## **Improving Fidelity**
<a id="TMP_3c3e"></a>

###  **7.** [**Multidomain Physical Modeling**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/MultidomainPhysicalModeling.mlx)

Improve the fidelity of a quadcopter model with Simscape elements.

||||
| :-- | :-- | :-- |
| <img src="Images/SimscapeFamily.png" width="171" alt="SimscapeFamily.png"> <br>  | **In this script, students will...** <br> $\bullet$ Use pulse width modulation on a DC motor <br> $\bullet$ Model a propeller in Simscape <br>  | **Models referenced** <br> $\bullet$ Build and Simulate a Simple DC Motor <br> $\bullet$ [Propeller_Model.slx](./Models/Propeller_Model.slx) <br> $\bullet$ [Propeller\_Ref\_Speed.slx](./Models/Propeller_Ref_Speed.slx) <br>   |

<a id="M_3cef"></a>

###  **8.** [**Trajectory Generation**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/ExampleCollectionOnTrajectories.mlx)

Explore two documentation examples on trajectory generation

||||
| :-- | :-- | :-- |
| <img src="Images/MinimumJerk.png" width="171" alt="MinimumJerk.png"> <br>  | **In this script, students will...** <br> $\bullet$ Explore the effects of planning trajectories to minimize jerk <br> $\bullet$ Learn about Simscape Results Explorer, spatial contact forces and applications of multibody modeling <br>  | **Models referenced** <br> $\bullet$ Generate Minimum Jerk Trajectory <br> $\bullet$ Package Delivery Quadcopter Example <br>   |

<a id="TMP_0492"></a>

###  **9.** [**Quadcopter Package Delivery**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/QuadcopterFromFEX.mlx)
||||
| :-- | :-- | :-- |
| <img src="Images/Quadcopter.png" width="171" alt="Quadcopter.png"> <br>  | **In this script, students will...** <br> $\bullet$ Explore the fully implemented model to see the various subsystems \- electrical, mechanical and maneuver controller. <br> $\bullet$ Work on exercises on motor sizing, testing stability and range, integrating a 3D propeller, and more. <br>  | **Models referenced** <br> $\bullet$ Quadcopter Drone Model in Simscape <br>   |

<a id="TMP_89b5"></a>

###  **10.** [**Sensor Fusion**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/SensorFusion.mlx)

Explore two documentation examples on trajectory generation

||||
| :-- | :-- | :-- |
| <img src="Images/GroundTruth.png" width="171" alt="GroundTruth.png"> <br>  | **In this script, students will...** <br> $\bullet$ Learn about combining measurements from different sensors to estimate the location <br> $\bullet$ Design a Kalman Filter to estimate the angular position of a pendulum <br> $\bullet$ Design an Extended Kalman Filter to estimate the angular position of the nonlinear pendulum system <br>  | **Models referenced** <br> $\bullet$ IMU and GPS Fusion for Inertial Navigation <br> $\bullet$ virtualPendulumModel.slx (Kalman Filter Lab) <br>   |

<a id="TMP_4f0f"></a>

###  **11.** [**Scenario Generation**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/ScenarioGeneration.mlx)

Explore a variety of high\- and low\-fidelity scenarios.

||||
| :-- | :-- | :-- |
| <img src="Images/SimpleCity.png" width="171" alt="SimpleCity.png"> <br>  | **In this script, students will...** <br> $\bullet$ Explore building low\-fidelity scenarios to test trajectories <br> $\bullet$ Explore the capabilities of Unreal Engine for building high\-fidelity, photo\-realistic scenarios <br> $\bullet$ Consider how much fidelity is necessary to answer different modeling questions <br>  | **Models referenced** <br> $\bullet$ UAV Scenario Tutorial <br> $\bullet$ Plan Minimum Snap Trajectory for Quadrotor <br> $\bullet$ Simulate Simple Flight Scenario and Sensor in Unreal Engine Environment <br> $\bullet$ UAV Package Delivery System <br>   |

<a id="TMP_5954"></a>

## [**Next Steps**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation&project=UAV.prj&file=Scripts/NextSteps.mlx)

Suggest additional directions that students may be interested in exploring including Advanced Control, Working with ROS and Gazebo, and the Challenge Projects.

<a id="H_F61733D7"></a>

# License

The license for this module is available in the [LICENSE.md](https://github.com/MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation/blob/release/LICENSE.md).

# Related Courseware Modules

## [Engineering Problem Solving](https://www.mathworks.com/matlabcentral/fileexchange/180430-engineering-problem-solving)
|||
| :-- | :-- |
| <img src="Images/EngProbSolve.png" width="171" alt="EngProbSolve.png"> <br>  | **Available on:** <br> [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/180430-engineering-problem-solving)  <br> [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Engineering-Problem-Solving&project=EngineeringProblemSolving.prj&file=README.mlx) <br> [GitHub](https://github.com/MathWorks-Teaching-Resources/Engineering-Problem-Solving) <br>   |

## [Introduction to Robotics](https://www.mathworks.com/matlabcentral/fileexchange/181503-introduction-to-robotics-university-of-cape-town) \- University of Cape Town
|||
| :-- | :-- |
| <img src="Images/CapeTown.png" width="171" alt="CapeTown.png"> <br>  | **Available on:** <br> [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/181503-introduction-to-robotics-university-of-cape-town)  <br> [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=ArnoldPretoriusUCT/Introduction-to-Robotics) <br> [GitHub](https://github.com/ArnoldPretoriusUCT/Introduction-to-Robotics) <br>   |

Or feel free to explore our other [modular courseware content](https://www.mathworks.com/matlabcentral/fileexchange/?q=author%3A%22MathWorks+Educator+Content+Development+Team%22&sort=relevancy).

# Educator Resources
- [Educator Page](https://www.mathworks.com/academia/educators.html)

<a id="H_0FA5DA18"></a>

# Contribute 

Looking for more? Find an issue? Have a suggestion? Please contact the [MathWorks Educator Content Development team](mailto:%20onlineteaching@mathworks.com). If you want to contribute directly to this project, you can find information about how to do so in the [CONTRIBUTING.md](https://github.com/MathWorks-Teaching-Resources/Quadcopter-Modeling-Simulation/blob/release/CONTRIBUTING.md) page on GitHub.

 *©* Copyright 2026 The MathWorks, Inc
