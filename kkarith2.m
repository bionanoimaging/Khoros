%kkarith2 'Dual Operator Pointwise Arithmetic'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros karith2.pane file
%
% Parameters: 
% InputFile: i1 'Input 1', required: 'first input data object'
% OutputFile: o 'Output', required: 'resulting output data object'
% InputFile: i2 'Input 2', optional: 'second input data object'
% Toggle: add 'Add', default: 0: 'Add: o = i1 + (i2 or val)'
% Toggle: hypot 'Hypotenuse', default: 0: 'Hypotenuse: o = sqrt(i1*i1 + (i2*i2* or val*val))'
% Toggle: sub 'Subtract', default: 0: 'Subtract: o = i1 - (i2 or val)'
% Toggle: atan2 'atan(y/x)', default: 0: 'atan2: o = arc tangent (i1 / (i2 or val)'
% Toggle: subfrom 'Subtract From', default: 0: 'Subtract From: o = (i2 or val) - i1'
% Toggle: mul 'Multiply', default: 0: 'Multiply: o = i1 * (i2 or val)'
% Toggle: div 'Divide', default: 0: 'Divide: o = i1 / (i2 or val)'
% Toggle: ldexp 'ldexp', default: 0: 'ldexp: i1 * 2 ** (i2 or val)'
% Toggle: divinto 'Divide Into', default: 0: 'Divide Into: o = (i2 or val) / i1'
% Toggle: pow 'Power', default: 0: 'Power: o = i1 raised to power of (i2 or val)'
% Toggle: absdiff 'Absolute Difference', default: 0: 'Absolute Difference: o = | i1 - (i2 or val) |'
% Toggle: min 'Minimum', default: 0: 'Minimum: Returns lower value between i1 and (i2 or val)'
% Toggle: max 'Maximum', default: 0: 'Maximum: Returns higher value between i1 and (i2 or val)'
% Toggle: mod 'Modulo', default: 0: 'Modulus: o = remainder (i1/i2)'
%
% Example: o = kkarith2({i1, i2}, {'i1','';'o','';'i2','';'add',0;'hypot',0;'sub',0;'atan2',0;'subfrom',0;'mul',0;'div',0;'ldexp',0;'divinto',0;'pow',0;'absdiff',0;'min',0;'max',0;'mod',0})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% karith2 - Dual Operator Pointwise Arithmetic
%
%  DESCRIPTION
% "karith2" performs the operation specified by the operator flag (-add, 
% -sub, etc.) between each point in \fBInput 1" and either the corresponding 
% point in \fBInput 2" or the real (and imaginary) \fBConstant\fP values, 
% which ever the user specifies.
% The "karith2" operators are: Add, Subtract, Subtract From, Multiply, 
% Divide, Divide Into, Power, 
% Absolute Difference, Minimum, Maximum, Modulo, Hypotenuse, atan2, and ldexp.
% 
% 
%  "Data Type - Single Input" 5
% .cI $DATAMANIP/repos/shared/man/sections/value_type_1input
% 
%  "Data Type - Two Input Objects" 5
% .cI $DATAMANIP/repos/shared/man/sections/value_type_2input
% 
%  "Map Data - Single Input" 5
% .cI $DATAMANIP/repos/shared/man/sections/map_1input
% 
%  "Map Data - Two Input Objects" 5
% .cI $DATAMANIP/repos/shared/man/sections/map_2input
% 
%  "Validity Mask" 5
% .cI $DATAMANIP/repos/shared/man/sections/mask_2input
% 
%  "Input Objects of Different Sizes" 5
% .cI $DATAMANIP/repos/shared/man/sections/resize_2input
% The values used to pad the data when input files are not the same size are 
% determined by the operation.  The default pad value of (0.0, 0.0) will be 
% used for the Add (-add), Subtract (-sub), Subtract From (-subfrom), 
% Absolute Difference (-absdiff), 
% Minimum (-min), Maximum (-max), Hypotenuse (-hypot), and ldexp operations.  
% The default pad value of (1.0, 0.0) will be used for the Multiply (-mul), 
% Divide (-div), Divide Into (-divinto), Power (-pow), Modulo (-mod) and 
% atan2 operations.
% 
%  "Explicit Location and Time Data - Single Input" 5
% .cI $DATAMANIP/repos/shared/man/sections/loc_and_time_1input
% 
%  "Explicit Location and Time Data - Two Input Objects" 5
% .cI $DATAMANIP/repos/shared/man/sections/loc_and_time_2input
% 
%  "Failure Modes - Single Input"
% .cI $DATAMANIP/repos/shared/man/sections/fail_1input
% 
%  "Failure Modes - Two Input Objects"
% .cI $DATAMANIP/repos/shared/man/sections/fail_2input
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
% DATAMANIP::kabsdiff, DATAMANIP::kadd, DATAMANIP::katan2, DATAMANIP::kcube, 
% DATAMANIP::kdeg2rad, DATAMANIP::kdiv, DATAMANIP::kdivinto, DATAMANIP::khypot, 
% DATAMANIP::kldexp, DATAMANIP::kmaximum, DATAMANIP::kminimum, DATAMANIP::kmod, 
% DATAMANIP::kmul, DATAMANIP::kpow, DATAMANIP::krad2deg, DATAMANIP::ksqr, 
% DATAMANIP::ksub, DATAMANIP::ksubfrom
%
%  RESTRICTIONS 
% Operations on complex data are supported only for add, subtract, subtract
% from, multiply, divide, divide into, and power at this time.  For other 
% operations, if the input object is complex, only the real component of 
% the data is processed, and the output object is real.
% For additional complex operators, see DATAMANIP::kcmplx, 
% DATAMANIP::kcmplx2real, DATAMANIP::kreal2cmplx, and
% the associated cantata pane objects (phase, magnitude, etc).
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkarith2(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkarith2(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i1', '__input';'o', '__output';'i2', '__input';'add', 0;'hypot', 0;'sub', 0;'atan2', 0;'subfrom', 0;'mul', 0;'div', 0;'ldexp', 0;'divinto', 0;'pow', 0;'absdiff', 0;'min', 0;'max', 0;'mod', 0};
maxval={0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','OutputFile','InputFile','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle'};
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
[varargout{:}]=callKhoros([w 'karith2"  '],Inputs,narglist);
