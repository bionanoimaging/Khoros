%kkmsquish 'Compress Map to One Column by Means of Average, RMS, or MAX'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kmsquish.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'First Input data object'
% MultiChoice: t 'Squishing scheme', default: 1: 'squishing scheme (1)average, (2)RMS, (3)Maximum'
%    Choices are:
%   1: 'Average of map columns'
%   2: 'RMS value of map columns'
%   3: 'Maximum value of mape columns'
% OutputFile: o 'Output', required: 'Resulting output data object'
%
% Example: o = kkmsquish(i, {'i','';'t',1;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kmsquish - Compress Map to One Column by Means of Average, RMS, or MAX
%
%  DESCRIPTION
% kmsquish compresses a map down to one column, effectively
% converting the map to a "greyscale" map. An example of
% this operation is encountered when trying to print a
% pseudocolor RGB image on a B/W laser printer: the RGB
% color information must be somehow converted to greyscale
% in order for the printer to know how to dither the image
% during printing.
% 
% kmsquish is very happy to operate on simple 3-column
% maps, such as would be encountered when processing a
% color image in any of the standard coordinate systems
% (ntscRGB, etc). However, kmsquish is not limited to 3 column
% maps - it will operate on maps with any number of cloumns.
% 
% The conversion from multiple columns to a single column
% is done by computing a grey level for each row of the map,
% one at a time.  For t=1, the grey level for a row is the 
% average of the columns in the row. For t=2, the grey 
% level is the RMS value of the columns in the row. For t=3,
% the grey level is the maximum value found in the colums of
% the row. Clearly, these schemes are not optimal in any sense,
% but one of them will usually give an acceptable result.
% 
% Ordinarily (map=0), the map is the only part of the input
% object that is modified. The value data is not touched; it
% still points to various rows in the map just as before the
% compression. If map=1, the value data is pulled thru the
% map and the map segment itself is removed. If mask data
% is present, then this operation proceeds as described in
% the man page for kmapdata(1).
%
%  
%
%  EXAMPLES
% 
% Squishing and mapping an image that is to be printed.
% kmsquish -i ball.xv.color -o ball.ready.to.print
% here, -m pand -t do not need to be specified since the defaults are
% set correctly.
%
%  "SEE ALSO"
% igamut(1), kmapdata(1)
%
%  RESTRICTIONS 
% Complex data is not supported.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkmsquish(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkmsquish(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'t', 1;'o', '__output'};
maxval={0,0,0};
minval={0,0,0};
istoggle=[0,0,0];
was_set=istoggle * 0;
paramtype={'InputFile','MultiChoice','OutputFile'};
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
[varargout{:}]=callKhoros([w 'kmsquish"  '],Inputs,narglist);