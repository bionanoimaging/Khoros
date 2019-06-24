%kkformats 'Conversion Between the Formats Supported in Khoros 2'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kformats.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'Input data object'
% OutputFile: o 'Output', required: 'Resulting output data object'
% Toggle: ascii 'ASCII', default: 0: 'Output in ASCII format'
% Toggle: kdf 'KDF (Khoros 2.0 Data Format)', default: 0: 'Output as KDF (Khoros 2.0 Format)'
% Toggle: avs 'AVS', default: 0: 'Output in Application Visualization System (AVS) format'
% Toggle: xbm 'XBM', default: 0: 'Output in X Bitmap (XBM) format'
% Toggle: arf 'ARF', default: 0: 'Output in ARF Format'
% Toggle: viff 'VIFF (Khoros 1.0 Image Format)', default: 0: 'Output as Viff (Khoros 1.0 Image Format)'
% Toggle: pnm 'PNM', default: 0: 'Output in Portable Any Map (PNM) format'
% Toggle: xwd 'XWD', default: 0: 'Output in X Window Dump (XWD) format'
% Toggle: raw 'Raw', default: 0: 'Output in Raw (headerless) format'
% Toggle: xpm 'XPM', default: 0: 'Output in X Pixmap (XPM) format'
% Toggle: rast 'Sun Raster', default: 0: 'Output in Sun Raster format'
% String: format 'User Specified Supported Format ', default: ' ': 'Supported format not available via the format flags'
%
% Example: o = kkformats(i, {'i','';'o','';'ascii',0;'kdf',0;'avs',0;'xbm',0;'arf',0;'viff',0;'pnm',0;'xwd',0;'raw',0;'xpm',0;'rast',0;'format',' '})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kformats - Conversion Between the Formats Supported in Khoros 2
%
%  DESCRIPTION
% .I kformats
% converts between formats internally supported by Khoros 2.0.  
% Currently, these formats include
% 
%  "ASCII Format" 5
% 
%  "AVS - Application Visualization System (AVS) Format" 5
% 
%  "PNM - Portable Any Map" 5
% The PBM image file format describes the format used by the pbm conversion 
% routines.  The format was developed by Jef Poskanzer.
% The PNM format is really three different formats; PBM, PGM, &
% PPM.  The formats correspond to bitmap, greymap, and pixmap
% formats.
% 
%  "Raw (headerless) Format" 5
% 
%  "Sun Raster - Sun Rasterfile File Format" 5
% The Sun Raster file format describes the format used by
% the Sun Rasterfile File Format  conversion routines.  The format
% was developed by Sun Microsystems.
% 
%  "KDF - Khoros 2.0 Data File Format" 5
% 
%  "XBM - X Bitmap Format" 5
% 
%  "VIFF - Khoros Visualization/Image File Format (Khoros 1.0)" 5
% A Khoros Viff data file is organized as a 1Kbyte header followed by 
% additional information.  The first two bytes of the header tell what kind 
% of stuff the additional information is.  For Khoros image files, the 
% additional information consists of the maps, the location data, and then 
% the image or vector data.
% 
%  "XWD - X Window Dump Format" 5
% 
%  "XPM - X Pixmap Format" 5
% 
%  "User Specified Supported Format" 5
% This string entry allows the user to enter a supported format that 
% is not available in the list of formats described above.  The string
% is passed directly into the data services call that sets the format 
% attribute on the data object, so it must be accurate.
% 
%  "Importing Other Formats"
% We have not forgotten about other formats, such as TGA, FITS, and TIFF; 
% they are on the list of many to add to Khoros.  
% Khoros 2 is designed to be portable, therefore we made the decision 
% that each format that we bring on line should be implemented as a 
% portable solution.  (Otherwise we end up with a software management nightmare.)
% As a workaround until these other formats come on line, we recommend
% using an intermediate converter.  For example, the TIFF workaround would be 
% to get the PBMPLUS package, which has a TIFF reader in it. Use tiff2pbm 
% to convert your TIFF to a PBM image, which can then be read directly 
% without further conversion by any Khoros 2 program.
% 
%  "Postscript Output"
% For postscript output, use the ipostscr operator in the Image toolbox.
% The object is located under "Input/Output - Hardcopy Output - Postscript" 
% in cantata.
% 
%  "Format Restrictions"
% With the exception of the KDF format, each format is only capable of
% storing a subset of the polymorphic data model.  For example, no
% format except KDF will be able to store the Time segment.  User
% defined attributes, as well, typically will be lost.  Furthermore,
% even though all formats can store the Value segment, each format has
% its own restrictions on the data type and dimensionality that can be
% stored.  Floating point and complex data will typically be lost.
% This routine will print out some indication of what is being lost
% when a conversion is performed.
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
% IMAGE::ipostscr(1)
%
%  RESTRICTIONS 
% If the input data cannot be represented on the output format, kformats will- Conversion Between Khoros 2.0 Supported Formats
% fail.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkformats(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkformats(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'o', '__output';'ascii', 0;'kdf', 0;'avs', 0;'xbm', 0;'arf', 0;'viff', 0;'pnm', 0;'xwd', 0;'raw', 0;'xpm', 0;'rast', 0;'format', ' '};
maxval={0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[0,0,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','OutputFile','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','String'};
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
[varargout{:}]=callKhoros([w 'kformats"  '],Inputs,narglist);
