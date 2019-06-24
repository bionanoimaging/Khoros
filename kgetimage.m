%kgetimage 'Capture image from screen to Khoros 2.1 KDF '
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros getimage.pane file
%
% Parameters: 
% Toggle: all 'Save ALL of window or screen?', default: 0: 'Save ALL of window or screen?'
% Toggle: decor 'Grab the window manager decoration?', default: 0: 'Grab the window manager decoration?'
% Toggle: b 'Output image in bitmap format?', default: 0: 'Output image in bitmap format?'
% OutputFile: o 'Output filename', required: 'Output filename'
% Toggle: screen 'Use screen as source', default: 0: 'Use screen as source'
% Toggle: win 'Use (interactively indicated) window as source', default: 0: 'Use (interactively indicated) window as source'
% String: wname 'Name/ID of source window (use % xwininfo)', default: ' ': 'Name/ID of source window'
% Toggle: ascii 'ASCII', default: 0: 'Output in ASCII format'
% Toggle: kdf 'Output in KDF (Khoros 2.1) format', default: 0: 'Output as KDF (Khoros 2.0 Format)'
% Toggle: avs 'AVS', default: 0: 'Output in Application Visualization System (AVS) format'
% Toggle: xbm 'XBM', default: 0: 'Output in X11 Bitmap (XBM) format'
% Toggle: pnm 'PNM', default: 0: 'Output in Portable Any Map (PNM) format'
% Toggle: viff 'VIFF (Khoros 1.0 Format--xvimage)', default: 0: 'Output as VIFF (Khoros 1.0 Format) (xvimage)'
% Toggle: eps 'Encapsulated Postscript', default: 0: 'Output in Encapsulated PostScript Format'
% Toggle: xwd 'XWD', default: 0: 'Output in X11 Window Dump (XWD) format'
% Toggle: raw 'Raw', default: 0: 'Output in Raw (headerless) format'
% Toggle: xpm 'XPM', default: 0: 'Output in X Window Pixmap (XPM) format'
% Toggle: rast 'Sun Raster', default: 0: 'Output in Sun Raster format'
%
% Example: o = kgetimage( {'all',0;'decor',0;'b',0;'o','';'screen',0;'win',0;'wname',' ';'ascii',0;'kdf',0;'avs',0;'xbm',0;'pnm',0;'viff',0;'eps',0;'xwd',0;'raw',0;'xpm',0;'rast',0})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% getimage - Capture image from screen to Khoros 2.1 KDF
%
%  DESCRIPTION
% 
% Getimage allows you to capture an area of a workstation screen (running X
% Windows, version 11, release 4, 5, or 6), and save it as an image.  A variety
% of output file formats are supported;  the default is the Khoros 2.0 VIFF
% file format.
% 
% Getimage provides a convenient way in which to create new images
% from windows displayed on the screen.  Images captured using getimage 
% may be displayed with
% \fBputimage"
% or manipulated using
% \fBeditimage".
% 
% The "source" of image capture with getimage may be a specific window,
% or the screen as a whole.  You may capture the entire source, or you may
% interactively specify a portion of the source to capture using a rubberbanding
% method.
% 
% Getimage supports capture of both 24-bit and 8-bit images.  The number planes
% captured depends on the display from which the image is captured.  For
% example, on a 24-bit display, capture of both 8-bit and 24-bit images is
% possible; the captured image will be 8-bit if the source of the captured
% image was 8-bit, or 24-bit if the source of the captured image was 24-bit.
% On an 8-bit display, an 8-bit image will be captured.
% 
% Getimage "cannot" handle capture of areas containing multiple or split
% visual displays, or areas containing multiple colormaps.
% 
% There are a number of different methods which may be used to capture 
% images using getimage:
% 
%  "1) Entire Screen"
% 
%  "2) Screen Area"
% 
%  "3) Entire Window, Interactive Specification"
% 
%  "4) Entire Window, Specification by Name/ID"
% 
%  "5) Window Area, Interactive Specification"
% 
%  "6) Window Area, Specification by Name/ID"
% 
% IMPORTANT NOTE: when a window is used as the image source, if the window
% indicated for image capture is obscured by any other windows, the image
% captured will also include the obscuring window(s).
% 
% 
%  "Entire Screen"
% This method provides a convenient way to capture the entire screen.
% Execute:
% .begin code
% % getimage -o {filename} -screen -all
% .end code
% This will cause getimage to capture the entire screen automatically.
% Note that the entire screen can also be captured interactively using the
% "Area of Interest on Screen" method.
% 
% 
%  "Screen Area"
% This method allows you to capture a specified portion of the screen,
% regardless of the number of windows which it may include.
% .begin code
% % getimage -o {filename} -screen
% .end code
% You will be prompted to rubber-band around the area of the screen to
% be captured.  To rubberband the area of interest, first click on the upper
% left hand corner of the desired portion of the screen; the cursor will change
% to look like the upper left hand corner of a box.  "Keeping the mouse
% button down", move the mouse to the lower right hand corner of the desired
% portion of the screen;  the active portion will be indicated by rubber banding.
% The rubber-banded portion of the screen will be extracted into "filename"
% as soon as you release the mouse button.
% 
% 
%  "Entire Window, Interactive Specification"
% This method lets you capture a single window in its entirety from the screen,
% interactively specifying the window that you want.
% .begin code
% % getimage -o {filename} -win -all
% .end code
% You will be prompted to click on the window which is to be captured.
% After you click on the desired window, the window will be captured as
% "filename", a Khoros 2.0 VIFF file.
% 
% 
%  "Entire Window, Specification by Name/ID"
% This method lets you capture a single window in its entirety from the screen,
% specifying the window that you want by its name or ID.  Being non-interactive,
% this method is better suited for automated image capture; it would be
% appropriate for execution from a script. Execute
% .begin code
% % getimage -o {filename} -wname {window_name} -all
% .end code
% or
% .begin code
% % getimage -o {filename} -wname {window_id} -all
% .end code
% 
% 
% If the name or ID of a window is unknown, you may use the X11 utility program
% "xwininfo" to obtain it.  If a window with the specified name or ID can't be
% found, getimage will exit with an error message.
% 
% 
%  "Window Area, Interactive Specification"
% This method lets you capture part of a single window, interactively specifying
% the window that you want, and then interactively specifying the area of
% interest within that window.
% .begin code
% % getimage -o {filename} -win
% .end code
% First, you will be prompted to click on the window which is to be captured.
% After you click on the desired window, you will then be prompted to rubber-band
% the area of interest within that window.  When rubber-banding, the cursor will
% be constrained to locations within the specified window, making it impossible
% to capture any area outside the window.
% 
% 
%  "Window Area, Specification by Name/ID"
% This method lets you capture part of a single window, specifying the
% the window that you want by its name or window ID, and then interactively
% specifying the area of interest within that window. Execute:
% .begin code
% % getimage -o {filename} -wname {window_name}
% .end code
% or
% .begin code
% % getimage -o {filename} -wname {window_id}
% .end code
% As mentioned previously, if the name or ID of a window is unknown, you may
% use the X11 utility program "xwininfo" to obtain it.
% 
% 
% You will be prompted to rubber-band the area of interest within the named
% window.  When rubber-banding, the cursor will be constrained to locations
% within the specified window, making it impossible to capture any area outside
% the window.
% 
% 
%  "Bitmap Format"
% Getimage supports output of images in bitmap format.  When the [-b] argument is
% used, getimage simply takes a pixmap and dithers it down to a bit
% (binary) image before outputting the image to the filename specified.
% 
% 
%  "Inclusion of Window Manager Decoration"
% By default, when a window is captured, the window manager decoration is not
% captured with the image.  The [-decor] argument specifies that the window
% manager decoration is to be included as part of the output image.  Thus, if
% the command "% getimage -o {filename} -decor" is executed, the window title
% bar, borders, etc, will be included along with the contents of the window.
% 
% 
%  "Output File Format"
% Using getimage, you may output the captured image in any file format
% supported by Khoros 2.  You may specify any of:
%     [-ascii]   ASCII format
%     [-viff]    VIFF (Khoros 2.0 Format)
%     [-avs]     Application Visualization System (AVS) format
%     [-xbm]     X11 Bitmap (XBM) format
%     [-pnm]     Portable Any Map (PNM) format
%     [-xvimage] Xvimage (Khoros 1.0 Format)
%     [-eps]     Encapsulated PostScript Format
%     [-xwd]     X11 Window Dump (XWD) format
%     [-raw]     Raw (headerless) format
%     [-xpm]     X Windows Pixmap (XPM) format
%     [-rast]    Output in Sun Raster format
% By default, the output file format is Khoros 2.0 VIFF.
%
%  
%
%  EXAMPLES
% % getimage -o filename
% % getimage -o filename -e
% % getimage -o filename -name 0x1c0000d
% % getimage -o filename -name "editimage"
% % getimage -o filename -decor
%
%  "SEE ALSO"
% putimage(1), editimage(1)
%
%  RESTRICTIONS 
% Getimage "cannot" handle capture of areas containing multiple visuals,
% or areas containing multiple colormaps.  The following examples give scenarios
% where these limitations may affect the performance of getimage.
% 
% 
% Example 1: On a display that supports multiple visuals within the same
% application (eg, 24-bit SGI Irix 5.2), suppose you have displayed a 24-bit
% image using editimage.  You then attempt to capture the entire editimage 
% application using "getimage -o outfile".  The captured image not "look right", 
% since the graphical user interface of editimage will be using 8 bits, while 
% the image itself will be using 24 bits, and getimage cannot support capture 
% of multiple visuals.   In the captured image, the graphical user interface 
% of editimage will look correct, while the image that was being displayed by 
% editimage will have a corrupted colormap.
% 
% 
% Example 2: On a 24-bit display (eg, a SparcStation 20 SX), suppose you have 
% displayed an image.  Using "getimage -o outfile -e", you attempt to capture
% a portion of the screen containing both the displayed image and the text
% from an xterm that is partially obscured by the image.  The displayed image
% uses one colormap, while the xterm in the background uses another colormap.
% In a similar effect as that described in example 1, the portion of the 
% captured image that contains the displayed image will have a corrupted 
% colormap, while the portion of the captured image containing the text of the 
% xterm will appear correctly.
% 
% 
% Example 3: On an 8-bit display (eg, a DecStation 5000 with an HX display),
% suppose you have displayed two images side by side using two separate 
% executions of putimage.  You then use "getimage -o outfile -e", and rubberband
% an area that includes the left half of one image and the right half of the
% other image.  In the captured image, neither of the images captured will have
% the correct colormap (the images will look black or "scrambled"), since 
% getimage cannot handle areas containing multiple colormaps.
%
%  REFERENCES 
% Getimage is covered in Chapter 7 of the Editimage Manual.
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kgetimage(varargin)
Inputs={};
if nargin ==0
  arglist={'',''};
elseif nargin ==1
  arglist=varargin{1};
else error('Usage: [out1,..] = kgetimage(arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'all', 0;'decor', 0;'b', 0;'o', '__output';'screen', 0;'win', 0;'wname', ' ';'ascii', 0;'kdf', 0;'avs', 0;'xbm', 0;'pnm', 0;'viff', 0;'eps', 0;'xwd', 0;'raw', 0;'xpm', 0;'rast', 0};
maxval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'Toggle','Toggle','Toggle','OutputFile','Toggle','Toggle','String','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle'};
% identify the input arrays and assign them to the arguments as stated by the user
if ~iscell(Inputs)
Inputs = {Inputs};
end
NumReqOutputs=1; nextinput=1; nextoutput=1;
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
  varargout = cell(1,1);
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
[varargout{:}]=callKhoros([w 'getimage"  '],Inputs,narglist);
