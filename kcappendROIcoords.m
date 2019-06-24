%kcappendROIcoords 'Append and label multiple ROI coordinates files '
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros cappendROIcoords.pane file
%
% Parameters: 
% InputFile: ipre 'Input Pre-appended', optional: 'input pre-appended multiple coordinates file'
% InputFile: i1 'Input 1', required: 'Input first single coordinates file'
% InputFile: i2 'Input 2', optional: 'Input second single coordinates file'
% InputFile: i3 'Input 3', optional: 'Input third single coordinates file'
% InputFile: i4 'Input 4', optional: 'Input fourth single coordinates file'
% InputFile: i5 'Input 5', optional: 'Input fifth single coordinates file'
% InputFile: i6 'Input 6', optional: 'Input sixth single coordinates file'
% InputFile: i7 'Input 7', optional: 'Input seventh coordinates file'
% InputFile: i8 'Input 8', optional: 'Input eight coordinates file'
% InputFile: i9 'Input 9', optional: 'Input ninth coordinates file'
% InputFile: i10 'Input 10', optional: 'Input tenth coordinates file'
% OutputFile: o 'Output', required: 'Resulting output appended coordinates file'
%
% Example: o = kcappendROIcoords({ipre, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10}, {'ipre','';'i1','';'i2','';'i3','';'i4','';'i5','';'i6','';'i7','';'i8','';'i9','';'i10','';'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% cappendROIcoords - Append and label multiple ROI coordinates files
%
%  DESCRIPTION
% This routine is used to create a file with several coordinate files with indexes. Its input are several files in the Coords file format ([-i1], [-i2] ... [-i10] parameters). The indexes or labels for the output file will be created based on the order of the input files. 
% The Coords file is an ASCII file, its format is:
% * lines starting with # or / are considered as comments
% * lines with less than 7 characters on it are ignored
% * each line should have 4 coordinates: start column, start row, width, height, separated by one or more spaces.
% The MCoords (multiple coordinates) format of the output file is:
% * lines starting with # or / are considered as comments
% * lines with less than 9 characters on it are ignored
% * each line should have 5 values: index of class, start column, start row, width, height, separated by one or more spaces.
% The output of this routine ([-o] parameter) will usually be used by a "cROIfrommcoords" file to create a image for classification and evaluation of the samples, please see the kman page for \fIcROIfrommcoords\fP for more information. If more than 10 Coords file must be concatenated by this routine, the output of this routine can also serve as a pre-appended input to it ([-ipre] parameter), so multiple instances of this routine can be called in cascade to append more than 10 files.
%
%  
%
%  EXAMPLES
% All examples for the Classify toolbox are listed on the Classify Toolbox Manual. For an example of the usage of this routine, please see the example workspace Classify:workspaces:MINDIST-EvalSamples.
%
%  "SEE ALSO"
% cROIfrommcoords
%
%  RESTRICTIONS 
% Expect the input files to be on the Coords format. If a pre-appended file is given (in the case there are more than 10 files to be appended) this file must be in the MCoords format.
%
%  REFERENCES 
% All references for the Classify toolbox are listed on the Classify Toolbox Manual.
%
%  COPYRIGHT
% Copyright (C) 1997 Rafael Santos. Khoros (C) Khoral Research, Inc.
% 


function varargout = kcappendROIcoords(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kcappendROIcoords(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'ipre', '__input';'i1', '__input';'i2', '__input';'i3', '__input';'i4', '__input';'i5', '__input';'i6', '__input';'i7', '__input';'i8', '__input';'i9', '__input';'i10', '__input';'o', '__output'};
maxval={1,0,1,1,1,1,1,1,1,1,1,0};
minval={1,0,1,1,1,1,1,1,1,1,1,0};
istoggle=[1,0,1,1,1,1,1,1,1,1,1,0];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','InputFile','InputFile','InputFile','InputFile','InputFile','InputFile','InputFile','InputFile','InputFile','OutputFile'};
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
[varargout{:}]=callKhoros([w 'cappendROIcoords"  '],Inputs,narglist);