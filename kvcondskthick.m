%kvcondskthick 'Conditional Exoskeleton by Thickening'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros vcondskthick.pane file
%
% Parameters: 
% InputFile: i1 'Input Image #1', required: 'first input image'
% InputFile: i2 'Input Image #2', required: 'second input image'
% InputFile: str1 'Struct Element 1', required: 'Structuring Element'
% InputFile: str2 'Struct Element 2', required: 'Structuring Element'
% MultiChoice: r 'Struct El. Rotation Step', default: 1: 'Rotation step'
%    Choices are:
%   1: '1 '
%   2: '2 '
%   3: '4 '
% OutputFile: o 'Output Image ', required: 'resulting output image'
%
% Example: o = kvcondskthick({i1, i2, str1, str2}, {'i1','';'i2','';'str1','';'str2','';'r',1;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% vcondskthick - Conditional Exoskeleton by Thickening
%
%  DESCRIPTION
% .I vcondskthick
% will do the conditional exoskeleton by thickening of an input image by a conditional image and a set of structuring elements.
% 
% The two input images must be of the same size and have the same
% number of data bands.  The input 
% images may be of the same or different data types.  If the input
% images are of different data types, then all input images will be 
% upcast to the highest input image data type.  The output 
% image data type will be the same as that of the highest data type 
% of the input images.
% 
% Some useful pairs of structuring elements:
% 
%                               0 0 0    1 1 1
%   Conditional Segmentation    0 1 0    0 0 0
%                               1 1 1    0 0 0
% 
%                               0 0 0    1 0 0
%   Pseudo Convex Hull          0 1 1    1 0 0
%                               0 0 0    1 0 0
% 
%                               1 0 0    0 0 0
%   Convex Hull                 1 0 0    0 1 0
%                               1 0 0    0 0 0
% 
%                               0 0 0    1 1 1
%   Homotopic Pruning           0 1 0    1 0 1
%                               0 0 0    1 1 1
%
%  
%
%  EXAMPLES
% vcondskthick -i1 ball.xv -i2 feath.xv -str1 b272.str -str2 b273.str -r 1 -o outimage.xv
% 
% Will do the conditional exoskeleton by thickening of image 1 "ball.xv" by the structuring set b272.str and b273.str using "feath.xv" as a conditional image, rotating the struct. els. 1 step after each iteration, with the resulting image written to "outimage.xv".
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
% .I vcondskthick
% can be defined for all data types supported by Khoros, but at the moment it has been implemented just for the bit and unsigned char types.
% The structuring elements are subsets of the 3x3 matrix and the origin is always at the center of this matrix.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993-1997 Junior Barrera, Roberto Lotufo.  All rights reserved.
% 


function varargout = kvcondskthick(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kvcondskthick(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i1', '__input';'i2', '__input';'str1', '__input';'str2', '__input';'r', 1;'o', '__output'};
maxval={0,0,0,0,0,0};
minval={0,0,0,0,0,0};
istoggle=[0,0,0,0,0,0];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','InputFile','InputFile','MultiChoice','OutputFile'};
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
[varargout{:}]=callKhoros([w 'vcondskthick"  '],Inputs,narglist);
