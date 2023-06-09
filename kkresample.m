%kkresample 'Resample Object Data'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kresample.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'Input Object'
% Toggle: center 'Place COA in middle of dimensions (unless overridden below)', default: 0: 'center'
% Integer: wc 'Width Coordinate of COA ', default: 0: 'Width coordinate for the center of action'
% Integer: hc 'Height Coordinate of COA ', default: 0: 'Height coordinate for the center of action'
% Integer: dc 'Depth Coordinate of COA ', default: 0: 'Depth coordinate for the center of action'
% Integer: tc 'Time Coordinate of COA ', default: 0: 'Time coordinate for the center of action'
% Integer: ec 'Elements Coordinate of COA ', default: 0: 'Elements coordinate for the center of action'
% OutputFile: o 'Output', required: 'Resulting output object'
%
% Example: o = kkresample(i, {'i','';'center',0;'wc',0;'hc',0;'dc',0;'tc',0;'ec',0;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kresample - Resample Object Data
%
%  DESCRIPTION
% .I kresample 
% is used to magnify or reduce the Input data object (i) by using the 
% selected interpolation method (inter).  (At this time, only pixel 
% replication is supported.)  Magnification factors greater than one 
% magnify the object, and magnification factors between zero and one 
% reduce the object.  
% 
% Pixel replication and subsampling are done on a floating point indexing 
% basis, where the data point index is obtained by truncating the cumulative
% floating point index.  Therefore, when the calculated replication factor 
% or the subsampling step size is non-integer, the resulting integer step
% size varies during the process.
% 
%  "Magnification Factors"
% Magnification factors for each dimension, Width (wmag), Height (hmag)
% Depth (dmag), Time (tmag), and Elements (emag) can be specified.  Magnification
% factors can be any value greater than zero.
% 
%  "Center of Action"
% The magnification or reduction is done about a center point that can be
% specified to be anywhere in the object (even outside of the object).
% The correct way to think about this is by analogy to a magnifying glass
% where you place the magnifying glass over the point of interest and then
% choose the lens to get the magnification you want.  The center of action 
% coordinates can be specified individually for each dimension (wc, hc, dc, 
% tc, ec) or, for convenience, the center of action can be automatically 
% computed to be in the middle of all dimensions.  This is accomplished
% by selecting the "center" flag.  Automatic centering can be overridden 
% on selected dimensions by explicitly specifying the centers of action 
% for those dimensions.
% 
%  "Output Object Size"
% The resultant output object size can either be the same as the original
% input object size if "Resize dimensions" is set to "No" (-resize 0), or 
% it can be resized to fit the magnified or reduced data set if "Resize 
% dimensions" is set to "Yes" (-resize 1).  
% If the user chooses not to resize the dimensionality of the output object, 
% and the input object is reduced (magnification 
% factor < 1.0) then unknown pixels are set to zero.  Likewise, if the 
% input object is magnified (magnification factor > 1.0) then input data 
% that would be mapped outside of the output object are lost.
% 
%  "Data Type"
% .cI $DATAMANIP/repos/shared/man/sections/value_type_1input
% If there is map and value data in the source object, and zero
% order interpolation (pixel replication) is used, the map is transferred
% to the destination object.  If any interpolation algorithm is used,
% the value data is mapped before the operation can begin and the
% destination will not have map data.
% 
%  "Failure Modes"
% .cI $DATAMANIP/repos/shared/man/sections/fail_1input
% This program fails if there is mask data and the operation uses anything
% other than zero order interpolation.  In other words, if value data
% is being replicated or subsample on grid, then the mask can be
% correspondingly replicated or subsampled.  (Bilinear interpolation can not
% be performed on mask data.)
% If explicit location or time data are available, the sampling algorithm
% can not resample these data yet, and will fail.  This will be implemented 
% later ....
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
% kshrink, kexpand
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkresample(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkresample(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'center', 0;'wc', 0;'hc', 0;'dc', 0;'tc', 0;'ec', 0;'o', '__output'};
maxval={0,0,1,1,1,1,1,0};
minval={0,0,1,1,1,1,1,0};
istoggle=[0,1,1,1,1,1,1,0];
was_set=istoggle * 0;
paramtype={'InputFile','Toggle','Integer','Integer','Integer','Integer','Integer','OutputFile'};
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
[varargout{:}]=callKhoros([w 'kresample"  '],Inputs,narglist);
