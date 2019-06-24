
%isdeployed
if ~isdeployed
addpath('C:\cygwin\gnumex-1.11\'); 
addpath('C:\Program Files\dip\io\'); 

diproot = 'C:\Program Files\dip\';
addpath([ diproot 'dipimage']); 
addpath([ diproot 'dipimage/diplib'],'-begin'); 
addpath([ diproot 'dipimage/aliases']); 
% addpath([ diproot '060']);
addpath([ diproot 'khoros']);
%addpath([ diproot 'fitting']);
addpath([ diproot '\matlab_tools\']); 
%addpath([ diproot '\io\']); 
%addpath([ diproot 'FastICA_23']);
addpath(['C:\Program Files\dip\PEM\']);
addpath(['C:\Program Files\dip\060\']);
addpath(['C:\Program Files\dip\CPP_PEM\']);
addpath(['C:\Program Files\dip\Optimize\']);

dip_initialise;
dipsetpref('imagefilepath',[diproot 'StandardImages']);
dipsetpref('CommandFilePath', [diproot '060'])
dipsetpref('DefaultMappingMode','lin');

global KhorosOutput %KhorosOuput is returned to this global variable
dipsetpref('TrueSize','off')
global para
set(0,'DefaultFigurePaperType','A4');
end
% dipimage

%\\mobi1\WinApps\dip\bin add this to the system path
%add to classpath.txt \\mobi1\WinApps\dip\View5D.jar
