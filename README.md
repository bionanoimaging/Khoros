The toobox provides the "glue" to call executables from the khoros toolbox from within Matlab.
It also provides binaries for a few home-written khoros glyphs.
Installation Instructions:
Clone the repository and copy it into a folder accessible by Matlab

In the code below change "khorosBin" to the binary folder appropriate to your system (if it is not Windows).
The following lines should be added to your startup.m file in Matlab:

PublicPATH='Y:\MATLAB\Toolboxes\';  % All the public toolboxes are in here. CHANGE THIS IF NEEDED TO YOUR INSTALLATION PATH
%% Initialize Khoros
global KhorosOutput %KhorosOuput is returned to this global variable
global KhorosRoot
KhorosRoot=[PublicPATH '\khoros\khorosBin\'];
addpath([PublicPATH '\khoros']);
addpath([PublicPATH '\khoros\khorosBin']);
