%kkarith1 'Single Operator Pointwise Arithmetic'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros karith1.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'input data object'
% OutputFile: o 'Output', required: 'resulting output data object'
% Toggle: abs 'absolute value', default: 0: 'Output = Absolute Value of input'
% Toggle: sin 'sine', default: 0: 'Output = Sine of Input'
% Toggle: sqrt 'square root', default: 0: 'Output = Square Root of Input'
% Toggle: asin 'arc sine', default: 0: 'Output = Arc Sine of Input'
% Toggle: cbrt 'cube root', default: 0: 'Output = Cube Root of Input'
% Toggle: cos 'cosine', default: 0: 'Output = Cosine of Input'
% Toggle: neg 'negate', default: 0: 'Output = Negative of Input'
% Toggle: acos 'arc cosine', default: 0: 'Output = Arc Cosine of Input'
% Toggle: recip 'reciprocal', default: 0: 'Output = Reciprocal of Input'
% Toggle: tan 'tangent', default: 0: 'Output = Tangent of Input'
% Toggle: ceil 'ceiling', default: 0: 'Output = integer Ceiling of Input'
% Toggle: atan 'arc tangent', default: 0: 'Output = Arc Tangent of Input'
% Toggle: floor 'floor', default: 0: 'Output = Integer Floor of Input'
% Toggle: sinh 'hyperbolic sine', default: 0: 'Output = Hyperbolic Sine of Input'
% Toggle: trunc 'truncate', default: 0: 'Output = integer Truncate of Input'
% Toggle: asinh 'hyperbolic arc sine', default: 0: 'Output = Hyperbolic Arc Sine of Input'
% Toggle: fract 'fraction', default: 0: 'Output = Fractional Part of Input'
% Toggle: cosh 'hyperbolic cosine', default: 0: 'Output = Hyperbolic Cosine of Input'
% Toggle: lgamma 'ln gamma', default: 0: 'Output = Natural log of Gamma Function of Input'
% Toggle: acosh 'hyperbolic arc cosine', default: 0: 'Output = Hyperbolic Arc Cosine of Input'
% Toggle: erf 'error function', default: 0: 'Output = Error Function of Input'
% Toggle: tanh 'hyperbolic tangent', default: 0: 'Output = Hyperbolic Tangent of Input'
% Toggle: erfc 'complementary error function', default: 0: 'Output = Complementary Error Function of Input'
% Toggle: atanh 'hyperbolic arc tangent', default: 0: 'Output = Hyperbolic Arc Tangent of Input'
% Toggle: sinc 'sinc: sin(x)/x', default: 0: 'Output = Sinc Function: sin(x)/x'
% Toggle: not 'NOT', default: 0: 'Bitwise NOT operation'
% Toggle: clear 'CLEAR (0)', default: 0: 'Bitwise CLEAR: set all valid bits to 0'
% Toggle: set 'SET (1)', default: 0: 'Bitwise SET: set all valid bits to 1'
%
% Example: o = kkarith1(i, {'i','';'o','';'abs',0;'sin',0;'sqrt',0;'asin',0;'cbrt',0;'cos',0;'neg',0;'acos',0;'recip',0;'tan',0;'ceil',0;'atan',0;'floor',0;'sinh',0;'trunc',0;'asinh',0;'fract',0;'cosh',0;'lgamma',0;'acosh',0;'erf',0;'tanh',0;'erfc',0;'atanh',0;'sinc',0;'not',0;'clear',0;'set',0})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% karith1 - Single Operator Pointwise Arithmetic
%
%  DESCRIPTION
% "karith1" performs the operation specified by the operator flag (-abs,
% -sqrt, etc.) on each point in the input data object, \fBInput".  
% The "karith1" operators are:  absolute value, square root, cube root, 
% negative, reciprocal, ceiling, floor, truncate, fraction, lgamma, error
% function, complementary error function, bitwise NOT, bitwise CLEAR, 
% bitwise SET, 
% sine, arc-sine, cosine, arc-cosine, tangent, arc-tangent, hyperbolic 
% sin and arc-sine, hyperbolic cosine and arc-cosine, hyperbolic tangent and
% arc-tangent, and the sinc (sin(x)/x) function.
% 
%  "Data Type" 5
% .cI $DATAMANIP/repos/shared/man/sections/value_type_1input
% 
%  "Map Data" 5
% .cI $DATAMANIP/repos/shared/man/sections/map_1input
% 
%  "Validity Mask" 5
% .cI $DATAMANIP/repos/shared/man/sections/mask_1input
% 
%  "Explicit Location and Time Data" 5
% .cI $DATAMANIP/repos/shared/man/sections/loc_and_time_1input
% 
%  "Failure Modes"
% .cI $DATAMANIP/repos/shared/man/sections/fail_1input
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
% Operations on complex data are not supported at this time.
% For the bitwise operations (not, set, clear), if the source data is
% floating point, it is cast to long integer before processing.  This
% may result in loss of precision. A warning will be presented on the standard
% output if this condition occurs.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkarith1(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkarith1(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'o', '__output';'abs', 0;'sin', 0;'sqrt', 0;'asin', 0;'cbrt', 0;'cos', 0;'neg', 0;'acos', 0;'recip', 0;'tan', 0;'ceil', 0;'atan', 0;'floor', 0;'sinh', 0;'trunc', 0;'asinh', 0;'fract', 0;'cosh', 0;'lgamma', 0;'acosh', 0;'erf', 0;'tanh', 0;'erfc', 0;'atanh', 0;'sinc', 0;'not', 0;'clear', 0;'set', 0};
maxval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','OutputFile','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle'};
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
[varargout{:}]=callKhoros([w 'karith1"  '],Inputs,narglist);
