%kputplot2 'Non-Interactive 2D Plot Display'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros putplot2.pane file
%
% Parameters: 
% InputFile: i 'Input File', required: 'File containing 2D plot'
% Integer: x 'X Placement', default: -1: 'X location for GUI autoplacement'
% Integer: width 'Window Width ', default: 512: 'Window width'
% Integer: y 'Y Placement', default: -1: 'Y location for GUI autoplacement'
% Integer: height 'Window Height', default: 512: 'Window height'
% Double: update 'Update time', default: 2: 'How often to check input file for modification'
%
% Example: kputplot2(i, {'i','';'x',-1;'width',512;'y',-1;'height',512;'update',2})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% putplot2 - Non-Interactive 2D Plot Display
%
%  DESCRIPTION
% Putplot2 is a visualization program that displays data as a 2D plot.
% There are many parameters which control how the plot is displayed.  For
% example, an axis may be displayed and the plot type, line type, marker
% type, and plot color can also be specified.
% 
% It is possible to display a 2D axis with 2D plots using the [-axis2d]
% argument.  By default, 2D plots are displayed \fBwithout" axes.
% 
% When displaying a 2D plot, the plot type can be specified using the 
% [-ptype2d] argument.  There are six valid plot types which are as follows:
% 
%  "" 5
% 1 - Line
% 2 - Discrete
% 3 - Bar Graph
% 4 - Poly Marker
% 5 - Line Marker
% 
% A line type can also be specified when displaying 2D plots using the [-ltype2d]
% argument.  There are seven valid line types which are as follows:
% 
%  "" 5
% 1 - Solid
% 2 - Dotted
% 3 - Dot Dash
% 4 - Short Dash
% 5 - Long Dash
% 6 - Odd Dashed
% 7 - Grid Dotted
% 
% A marker type can be specified when displaying 2D plots using the
% [-mtype2d] argument.  Note that marker type only has an effect when
% plot type is set to Poly Marker or Line Marker.  There are sixteen
% valid marker types which are as follows:
% 
%  "" 5
% 1 -  Arc
% 2 -  Bow Tie
% 3 -  Box
% 4 -  Caret
% 5 -  Circle
% 6 -  Cross
% 7 -  Dagger
% 8 -  Diamond
% 9 -  Dot
% 10 - Hexagon
% 11 - Point
% 12 - Square
% 13 - Triangle
% 14 - V
% 15 - X
% 16 - Pixel
% 
% A plot foreground color can be specified when displaying 2D plots using the 
% [-pcolor2d] argument.  Note that the plot color is not used with plot
% types that are automatically colored such as "color marker" and
% "color line".  The plot color can be any valid color supported on your
% display.  For a list of available colors, run the command "% xcolors".
% 
% By default, the visualization display will share its colormap with all
% other applications running at the same time; that is, it does not not use a
% .I "private colormap",
% but rather makes use of the
% .I "default colormap".
% It is possible to specify that the visualization display allocate its
% own private colormap or "grab" all available colors for its own use.
% This is done using the [-priv] argument.  When [-priv] is specified,
% moving the mouse pointer into the display window will cause the display
% to have its private colormap installed; moving the pointer out of the
% display window will cause the private colormap to be de-installed.  This
% results in the technoflashing phenomenon characteristic of private
% colormap installation.
% 
% Color allocation can also be controlled and set to either
% .I "read-only"
% or
% .I "read/write"
% using the [-alloc] argument.  When set to
% .I "read only",
% once a color cell has been allocated, it can have its color set only once;
% from then on, the color cell can be shared by multiple applications, but
% not changed.  If the visualization display requires the color displayed
% to change, it must re-allocate the color cell, forcing a re-display of
% data.  This can be an expensive procedure.  In contrast, after a
% .I "read/write"
% color cell is allocated, it can have its color changed at any time
% without re-allocation; the data being displayed does not need to be
% redisplayed, and the color update process is much more efficient.
% However, the colors used in the visualization display cannot be shared by
% other applications.
% 
% The input file containing the data to be plotted is monitored by default;
% the file is checked every 2 seconds for change, and if it has been 
% modified, the plot is updated accordingly.  The interval at which the
% input file is checked for modification may be specified using the [-update]
% argument.
% 
% On creation, the plot display window may be placed manually (the default
% method), or placed automatically.  For automatic placement of the plot
% window, specify the desired location in device (screen) coordinates using
% the [-x] and [-y] arguments.
% 
% While the display window should be created with a default size that is
% appropriate to plot the data, a width and height for the window can be
% specified explicitly using the [-width] and [-height] arguments, where
% values represent number of pixels.  Alternatively, you may allow the
% plot window to size itself initially, and then use the window manager
% to interactively modify its size as desired.
%
%  
%
%  EXAMPLES
% % putplot2 -i plot2d:sine
%
%  "SEE ALSO"
% putdata(1), putplot3(1)
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kputplot2(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kputplot2(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'x', -1;'width', 512;'y', -1;'height', 512;'update', 2};
maxval={0,1000,1000,1000,1000,1};
minval={0,-1,-1,-1,-1,1};
istoggle=[0,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','Integer','Integer','Integer','Integer','Double'};
% identify the input arrays and assign them to the arguments as stated by the user
if ~iscell(Inputs)
Inputs = {Inputs};
end
NumReqOutputs=0; nextinput=1; nextoutput=1;
  for ii=1:size(arglist,1)
  wasmatched=0;
  for jj=1:size(narglist,1)
   if strcmp(arglist{ii,1},narglist{jj,1})  % a given argument was matched to the possible arguments
     wasmatched = 1;
     was_set(jj) = 1;
     if strcmp(narglist{jj,2}, '__input')
      if (nextinput > length(Inputs)) 
        error(['Input ' narglist{jj,1} ' has no corresponding input!']); 
      end
      narglist{jj,2} = 'OK_in';
      nextinput = nextinput + 1;
     elseif strcmp(narglist{jj,2}, '__output')
      if (nextoutput > nargout) 
        error(['Output nr. ' narglist{jj,1} ' is not present in the assignment list of outputs !']); 
      end
      if (isempty(arglist{ii,2}))
        narglist{jj,2} = 'OK_out';
      else
        narglist{jj,2} = arglist{ii,2};
      end

      nextoutput = nextoutput + 1;
      if (minval{jj} == 0)  
         NumReqOutputs = NumReqOutputs - 1;
      end
     elseif isstr(arglist{ii,2})
      narglist{jj,2} = arglist{ii,2};
     else
        if strcmp(paramtype{jj}, 'Integer') & (round(arglist{ii,2}) ~= arglist{ii,2})
            error(['Argument ' arglist{ii,1} ' is of integer type but non-integer number ' arglist{ii,2} ' was supplied']);
        end
        if (minval{jj} ~= 0 | maxval{jj} ~= 0)
          if (minval{jj} == 1 & maxval{jj} == 1 & arglist{ii,2} < 0)
            error(['Argument ' arglist{ii,1} ' must be bigger or equal to zero!']);
          elseif (minval{jj} == -1 & maxval{jj} == -1 & arglist{ii,2} > 0)
            error(['Argument ' arglist{ii,1} ' must be smaller or equal to zero!']);
          elseif (minval{jj} == 2 & maxval{jj} == 2 & arglist{ii,2} <= 0)
            error(['Argument ' arglist{ii,1} ' must be bigger than zero!']);
          elseif (minval{jj} == -2 & maxval{jj} == -2 & arglist{ii,2} >= 0)
            error(['Argument ' arglist{ii,1} ' must be smaller than zero!']);
          elseif (minval{jj} ~= maxval{jj} & arglist{ii,2} < minval{jj})
            error(['Argument ' arglist{ii,1} ' must be bigger than ' num2str(minval{jj})]);
          elseif (minval{jj} ~= maxval{jj} & arglist{ii,2} > maxval{jj})
            error(['Argument ' arglist{ii,1} ' must be smaller than ' num2str(maxval{jj})]);
          end
        end
     end
     if ~strcmp(narglist{jj,2},'OK_out') &  ~strcmp(narglist{jj,2},'OK_in') 
       narglist{jj,2} = arglist{ii,2};
     end
   end
   end
   if (wasmatched == 0 & ~strcmp(arglist{ii,1},''))
        error(['Argument ' arglist{ii,1} ' is not a valid argument for this function']);
   end
end
% match the remaining inputs/outputs to the unused arguments and test for missing required inputs
 for jj=1:size(narglist,1)
     if  strcmp(paramtype{jj}, 'Toggle')
        if (narglist{jj,2} ==0)
          narglist{jj,1} = ''; 
        end;
        narglist{jj,2} = ''; 
     end;
     if  ~strcmp(narglist{jj,2},'__input') && ~strcmp(narglist{jj,2},'__output') && istoggle(jj) && ~ was_set(jj)
          narglist{jj,1} = ''; 
          narglist{jj,2} = ''; 
     end;
     if strcmp(narglist{jj,2}, '__input')
      if (minval{jj} == 0)  % meaning this input is required
        if (nextinput > size(Inputs)) 
           error(['Required input ' narglist{jj,1} ' has no corresponding input in the list!']); 
        else
          narglist{jj,2} = 'OK_in';
          nextinput = nextinput + 1;
        end
      else  % this is an optional input
        if (nextinput <= length(Inputs)) 
          narglist{jj,2} = 'OK_in';
          nextinput = nextinput + 1;
        else 
          narglist{jj,1} = '';
          narglist{jj,2} = '';
        end;
      end;
     else 
     if strcmp(narglist{jj,2}, '__output')
      if (minval{jj} == 0) % this is a required output
        if (nextoutput > nargout & nargout > 1) 
           error(['Required output ' narglist{jj,1} ' is not stated in the assignment list!']); 
        else
          narglist{jj,2} = 'OK_out';
          nextoutput = nextoutput + 1;
          NumReqOutputs = NumReqOutputs-1;
        end
      else % this is an optional output
        if (nargout - nextoutput >= NumReqOutputs) 
          narglist{jj,2} = 'OK_out';
          nextoutput = nextoutput + 1;
        else 
          narglist{jj,1} = '';
          narglist{jj,2} = '';
        end;
      end
     end
  end
end
if nargout
   varargout = cell(1,nargout);
else
  varargout = cell(0);
end
if ispc
  w='"C:\Program Files\dip\khorosBin\';
else
[s,w] = system('which cantata');
w=['"' w(1:end-8)];
end
global KhorosRoot
if exist('KhorosRoot')
if ~isempty(KhorosRoot)
w=['"' KhorosRoot];
end
end
callKhoros([w 'putdata"  -plot2d'],Inputs,narglist);
