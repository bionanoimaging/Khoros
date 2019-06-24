%kkimpulse 'Generate Object Containing Impulse Value Data'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kimpulse.pane file
%
% Parameters: 
% Integer: wsize 'Width ', default: 512: 'Width of impulse value data'
% Integer: wnum 'Num. along Width ', default: 1: 'Number of impulses generated along the width dimension'
% Integer: hsize 'Height ', default: 512: 'Height of impulse value data'
% Integer: hnum 'Num. along Height ', default: 1: 'Number of impulses generated along the height dimension'
% Integer: dsize 'Depth ', default: 1: 'Depth of impulse value data'
% Integer: dnum 'Num. along Depth ', default: 1: 'Number of impulses generated along the depth dimension'
% Integer: tsize 'Time ', default: 1: 'Time of impulse value data'
% Integer: tnum 'Num. along Time ', default: 1: 'Number of impulses generated along the time dimension'
% Integer: esize 'Elements ', default: 1: 'Element dimension of impulse value data'
% Integer: enum 'Num. along Elements ', default: 1: 'Number of impulses generated along the element dimension'
% Integer: wsp 'Width Spacing ', default: 256: 'Spacing between two impulses along the width dimension'
% Integer: woff 'Width Offset ', default: 0: 'Offset of first impulse along width dimension'
% Integer: hsp 'Height Spacing ', default: 256: 'Spacing between two impulses along the height dimension'
% Integer: hoff 'Height Offset ', default: 0: 'Offset of first impulse along height dimension'
% Integer: dsp 'Depth Spacing ', default: 1: 'Spacing between two impulses along the depth dimension'
% Integer: doff 'Depth Offset ', default: 0: 'Offset of first impulse along depth dimension'
% Integer: tsp 'Time Spacing ', default: 1: 'Spacing between two impulses along the time dimension'
% Integer: toff 'Time Offset ', default: 0: 'Offset of first impulse along time dimension'
% Integer: esp 'Element Spacing ', default: 1: 'Spacing between two impulses along the element dimension'
% Integer: eoff 'Element Offset ', default: 0: 'Offset of the first impulse along the element dimension'
% OutputFile: o 'Output', required: 'Output file containing impulse value data'
%
% Example: o = kkimpulse( {'wsize',512;'wnum',1;'hsize',512;'hnum',1;'dsize',1;'dnum',1;'tsize',1;'tnum',1;'esize',1;'enum',1;'wsp',256;'woff',0;'hsp',256;'hoff',0;'dsp',1;'doff',0;'tsp',1;'toff',0;'esp',1;'eoff',0;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kimpulse - Generate Object Containing Impulse Value Data
%
%  DESCRIPTION
% .I kimpulse
% creates a data object with impulses in the value segment. The dimension of the 
% object is Width * Height * Depth * Time * Elements. The data type of the
% value segment can be \fBbit, byte, unsigned byte, short, unsigned short,
% integer, unsigned integer, long, unsigned long, float, double, complex" 
% and \fBdouble complex".
% 
% The value assumed to each impulse can be specified (-fgreal and -fgimag). Both 
% the real and imaginary component of the value assumed by the impulse, are 
% accepted but the imaginary value is used only when the output type is 
% complex or double complex. The value assumed by the background is  
% specified by the -bgreal and -bgimag variables. Like the impulse value, the
% imaginary background value is used only when the output type is complex or
% double complex.
% 
% The spacing (period) of the impulses can be specified for each of the 5 
% dimensions 
% of the output object (-wsp -hsp -dsp -tsp & -esp). The number of impulses
% along each dimension can also be specified (-wnum -hnum -dnum -tnum & -enum).
% This parameter is useful if impulses are not desired beyond a certain point in 
% each dimension. If the number of impulses specified is greater than the number
% obtained by dividing the size of the object by the spacing between impulses
% then the latter denotes the number of impulses along a dimension.
% 
% It is also possible to specify an offset for each of the 5 dimensions. The 
% first impulse is generated relative to the offset value specified by the 
% variables -woff -hoff -doff -toff -eoff. An error message is generated if
% the offset specified is greater than the size of that dimension.
%
%  
%
%  EXAMPLES
% % kimpulse -wsize 512 -hsize 512 -w_off 255 -h_off 255 -w_num 1 -h_num 1 -o example
% 
% creates an image example of size 512x512 with an impulse of value 255 in the 
% center. The background has the value 0.
% 
% % kimpulse -wsize 512 -hsize 512 -w_off 255 -h_off 255 -w_num 2 -h_num 2 -wsp 10 -hsp 20 -o exampl -fgreal 1.0 -bgreal 0.0 -fgimag 0.0 -bgimag 0.5 -type complex
% 
% creates a COMPLEX image example of size 512x512 with four impulses of 
% value (1.0,0.0). The background has the value (0.0,0.5). The impulses appear
% as an array with one corner at (255,255), with spacing (period) in the W 
% direction of 10 and in the H direction of 20.
%
%  "SEE ALSO"
% kgsin(1)
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkimpulse(varargin)
Inputs={};
if nargin ==0
  arglist={'',''};
elseif nargin ==1
  arglist=varargin{1};
else error('Usage: [out1,..] = kkimpulse(arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'wsize', 512;'wnum', 1;'hsize', 512;'hnum', 1;'dsize', 1;'dnum', 1;'tsize', 1;'tnum', 1;'esize', 1;'enum', 1;'wsp', 256;'woff', 0;'hsp', 256;'hoff', 0;'dsp', 1;'doff', 0;'tsp', 1;'toff', 0;'esp', 1;'eoff', 0;'o', '__output'};
maxval={2,2,2,2,2,2,2,2,2,2,2,1,2,1,2,1,2,1,2,1,0};
minval={2,2,2,2,2,2,2,2,2,2,2,1,2,1,2,1,2,1,2,1,0};
istoggle=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0];
was_set=istoggle * 0;
paramtype={'Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','OutputFile'};
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
[varargout{:}]=callKhoros([w 'kimpulse"  '],Inputs,narglist);
