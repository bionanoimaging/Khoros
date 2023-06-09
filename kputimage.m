%kputimage 'Non-Interactive Image Display'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros putimage.pane file
%
% Parameters: 
% InputFile: i 'Input File', required: 'File containing image'
% InputFile: cmap 'Input Colormap ', optional: 'File containing alternate colormap filename'
% InputFile: clip 'Input Clip Gate', optional: 'File containing clip mask'
% Integer: xoffset 'Image X Offset', default: 0: 'Specifies the horizontal offset within the image display'
% Integer: yoffset 'Image Y Offset', default: 0: 'Specifies the vertical offset within the image display'
% String: redfn 'Define Map Function For Red ', default: 'M0': 'Provides an equation that specifies the red map column'
% String: greenfn 'Define Map Function For Green ', default: 'M1': 'Provides an equation that specifies the green map column'
% String: bluefn 'Define Map Function For Blue ', default: 'M2': 'Provides an equation that specifies the blue map column'
% Integer: x 'X Placement', default: -1: 'X location for GUI autoplacement'
% Integer: width 'Window Width ', default: 512: 'Window width'
% Integer: y 'Y Placement', default: -1: 'Y location for GUI autoplacement'
% Integer: height 'Window Height', default: 512: 'Window height'
% Double: update 'Update time', default: 2: 'How often to check input file for modification'
%
% Example: kputimage({i, cmap, clip}, {'i','';'cmap','';'clip','';'xoffset',0;'yoffset',0;'redfn','M0';'greenfn','M1';'bluefn','M2';'x',-1;'width',512;'y',-1;'height',512;'update',2})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% putimage - Non-Interactive Image Display
%
%  DESCRIPTION
% Putimage is a visualization program that displays image data.  It
% provides no mechanism for image interaction or modification; it simply
% takes input data and displays it as an image on the screen.
% 
% The input file containing the data to be displayed as an image is
% monitored by default; the file is checked every 2 seconds for change,
% and if it has been modified, the image display is updated accordingly.
% The interval at which the input file is checked for modification may
% be specified using the [-update] option.  A value of 0 disables
% checking.
% 
% A clip mask may be used to dictate the portion of the data that is
% displayed using the [-clip] argument.  Clip masks are discussed in
% Chapter 1 of this volume, Introduction to the Envision Toolbox Manual.
% 
% An alternate input color map may be used to change the current color
% map using the [-cmap] argument.  Colormaps are discussed in Chapter 1
% of this volume, Introduction to the Envision Toolbox Manual
% 
% The horizontal and vertical offsets within the image display window
% can be specified using the [-xoffset] and [-yoffset] arguments.  These
% offsets specify the upper left corner of the image that appears in the
% display window.  For small images which fit entirely within the image
% display window, this will always be (0,0).  However for large images
% that must use a "pan icon" because the image will not fit entirely
% within the image window, the x and y offsets may be any value ranging
% from 0 to the width/height of the image display window.
% 
% When displaying images of data type "complex", a complex
% conversion value may be specified which dictates how complex data is
% converted for display using the [-complex] argument.  There are nine
% different complex conversion types:
% 
%  "" 5
% 1 - Real
% 2 - Imaginary
% 3 - Phase
% 4 - Magnitude
% 5 - Log Magnitude + 1
% 6 - Log Magnitude
% 7 - Log Magnitude Sqrt + 1
% 8 - Log Magnitude Sqrt
% 9 - Magnitude Sqrt 
% 
% When displaying image data, it is possible to specify how data is
% normalized for display using the [-normaltype] argument.  Before
% images are displayed by the image object, normalization must be done
% in order to ensure that the pixel values of the image fall within a
% certain range.  Normalization can be one or two types: local or
% global.  With "local" normalization, the normalization procedure
% is performed locally using the maximum and minimum values of each of
% the red, green, and blue map columns.  For "global" normalization,
% the normalization procedure is performed globally over all of the
% three columns displayed as red, green, and blue.
% 
% When data is normalized for display, it is possible to specify the algorithm
% that defines how data is normalized by using the [-normalmethod] argument.
% Normalization may be a simple stretch over the values that may be displayed
% on a workstation, or any of three variations on a standard deviation
% normalization may be used.  For a simple normalization of values to within
% displayable intensity bounds, set "Range:  Maximum".  Alternatively, images can
% have contrast increased or reduced using one of the standard deviation
% normalizations.  The four different normalization methods are:
% 
%  "" 5
% 1 - Range:  Maximum
% 2 - Range:  +/-1 Standard Deviations
% 3 - Range:  +/-2 Standard Deviations
% 4 - Range:  +/-3 Standard Deviations
% 
% When a colormap is present, it is possible to define which column (or
% columns) in the color map is displayed as red, green, and blue using
% the [-redcol], [-greencol], and [-bluecol] arguments.  An image with a
% simple colormap has three map columns associated with it, where the
% pixels in the image are used to index into the map columns; the first
% map column defines the red values, the second map column defines the
% green values, and the third map column defines the blue values.  In
% this way, the color for each pixel in the image is defined.  However,
% for images that may have multiple map columns present, such as a
% clustered image, it may be useful to view any of the map columns as
% red, green, or blue.
% 
% 
% Similar to specifying which map column(s) are displayed as red, green,
% and blue, it is possible to define a function representing the colors
% using the [-redfn], [-greenfn], and [-bluefn] arguments.  With images
% having colormaps made up of more than three columns, such as those
% produced by clustering algorithms, it is often informative to be able
% to apply a function to the values in those map columns in order to
% define the values that will be displayed for each of the red, green, and
% blue columns.  For example, in an image having 6 map columns, you
% might define the red intensity of pixel 10 as 
% \f(CW
% (map column 2)[10]+ (map column 3)[10]/ map columns 4)[10].  
% "
% In this case, the "Red Function"
% may be set to the string defining the function to be applied in order
% to produce the values that will be used as red.  Functions must have
% \fBonly" variable \fBM\fP, where \fBM\fP stands for "map column";
% following each \fBM" must be a number \fBstarting at zero\fP and
% ranging to \fBN-1", where \fBN\fP is the number of map columns
% available in the image.  For example, a valid function for red might
% be: 
% \f(CW
% (M2 - M3)/(M2 + M3) or (M0 + M1 + M2)/(M3 - M4).  
% "
% Equation values follow the standard rules of precedence; evaluation
% proceeds from left to right, and use of parentheses is fully
% supported.
% In a more simple use, the "Red Function" may also be the variable representing
% the map column which is to be used to specify the red values of the pixels in
% the image.  For example, if you wanted the fourth map column to define the
% red values of the pixels in the image, (remember that map column numbering
% begins at 0), you could set "Red Function" to:  M3.  You can also set the
% "Red Function" to a constant, if desired.  For example, if you wanted the
% red values of all the pixels in the image to be 200, you could set "Red
% Function" to 200.
% By default, the "Red Function" is set to \fBM0", or the first map
% column, the "Green Function" is set to \fBM1", or the second map
% column, and the "Blue Function" is set to \fBM2", or the third map
% column. Thus, the defaults produce results that you would normally expect for
% an image with a colormap where no function was being applied.
% 
% By default, Putimage will share its colormap with all other
% applications running at the same time; that is, it does not not use a
% .I "private colormap",
% but rather makes use of the
% .I "default colormap".
% It is possible to specify that Putimage allocate its own private
% colormap or "grab" all available colors for its own use.  This is done
% using the [-priv] argument.  When [-priv] is specified, moving the
% mouse pointer into the display window will cause the display to have
% its private colormap installed; moving the pointer out of the display
% window will cause the private colormap to be de-installed.  This
% results in the "technoflashing" phenomenon characteristic of private
% colormap installation.
% 
% Color allocation can also be controlled and set to either
% .I "read-only"
% or
% .I "read/write"
% using the [-alloc] argument.  When set to
% .I "read-only",
% once a color cell has been allocated, it can have its color set only
% once; from then on, the color cell can be shared by multiple
% applications, but not changed.  If Putimage requires the color
% displayed to change, it must re-allocate the color cell, forcing a
% re-display of data.  This can be an expensive procedure.  In contrast,
% after a
% .I read/write
% color cell is allocated, it can have its color changed at any time
% without re-allocation; the data being displayed does not need to be
% redisplayed, and the color update process is much more efficient.
% However, the colors used in Putimage cannot be shared by other
% applications.
% 
% On creation, the image display window may be placed manually (the default
% method), or placed automatically.  For automatic placement of the image
% window, specify the desired location in device (screen) coordinates using
% the [-x] and [-y] arguments.
% 
% While the image display window should be created with a default size that
% is appropriate to display the data, a width and height for the window can
% be specified explicitly using the [-width] and [-height] arguments.  Note
% that the interactive resizing of the image display window using the window
% manager is currently NOT supported.
%
%  
%
%  EXAMPLES
% % putimage -i image:ball
% % putimage -i image:mandril
%
%  "SEE ALSO"
% putdata(1)
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kputimage(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kputimage(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'cmap', '__input';'clip', '__input';'xoffset', 0;'yoffset', 0;'redfn', 'M0';'greenfn', 'M1';'bluefn', 'M2';'x', -1;'width', 512;'y', -1;'height', 512;'update', 2};
maxval={0,1,1,10000,10000,0,0,0,1000,1000,1000,1000,1};
minval={0,1,1,0,0,0,0,0,-1,-1,-1,-1,1};
istoggle=[0,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','InputFile','Integer','Integer','String','String','String','Integer','Integer','Integer','Integer','Double'};
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
callKhoros([w 'putdata"  -image'],Inputs,narglist);
