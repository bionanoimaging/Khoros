%kkextract 'Extract Rectangular Region from Object'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kextract.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'Input object'
% Integer: wsize 'Width ', default: 1: 'Specifies the region width'
% Integer: hsize 'Height ', default: 1: 'Specifies the region height'
% Integer: dsize 'Depth ', default: 1: 'Specifies the region depth'
% Integer: tsize 'Time ', default: 1: 'Specifies the region size on time dimension'
% Integer: esize 'Elements', default: 1: 'Specifies the region size on elements dimension'
% Integer: woff 'Width ', default: 0: 'Specifies origin of region on width dimension'
% Integer: hoff 'Height ', default: 0: 'Specifies origin of region on height dimension'
% Integer: doff 'Depth ', default: 0: 'Specifies origin of region on depth dimension'
% Integer: toff 'Time ', default: 0: 'Specifies origin of region on time dimension'
% Integer: eoff 'Elements', default: 0: 'Specifies origin of region on elements dimension'
% OutputFile: o 'Output', required: 'Resulting output region'
%
% Example: o = kkextract(i, {'i','';'wsize',1;'hsize',1;'dsize',1;'tsize',1;'esize',1;'woff',0;'hoff',0;'doff',0;'toff',0;'eoff',0;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kextract - Extract Rectangular Region from Object
%
%  DESCRIPTION
% 
% The "Extract Region" operator (kextract) extracts a region of data
% from the source object "Input" (i) and places it in the destination 
% object "Output" (o).  The region size is specified by the Width (wsize), 
% Height (hsize), Depth (dsize), Time (tsize), and Elements (esize) Region
% Size parameters.  The region will be extracted starting at the point defined 
% by the Region Origin parameters, Width (woff), Height (hoff), Depth (doff), 
% Time (toff), and Elements (eoff).  The datum at this starting point will be 
% placed at the origin (0,0,0,0,0) in the destination object.  
% 
% The output data object size for each dimension is determined first by the 
% Region Size parameters "if" they are specified, and then by the Region 
% Origin parameters in combination with the original source data size.  In other 
% words, if the size for a dimension is not selected on the graphical user 
% interface (or explicitly specified when running kextract from the command 
% line), all data on that dimension will be extracted, starting at the specified 
% origin.   This will ensure the following behavior.  Given an input data file 
% with dimensions (width=100, height=100, depth=10, time=1, elements = 1), 
% and the following "specified" parameters:  
% 	
% 	Region Size:  Width = 50, Height = 50
% 	Region Origin:  Width = 2, Height = 2, Depth = 2
% 
% the output object size will be (width=50, height=50, depth=8, time=1, 
% elements = 1).
% 
% The extract operation is based on implicit indexing.  This means that if 
% location or time data exist, the extract operation is not done in terms 
% an interpretation of the location/time data values, but in terms of the
% implicit indexing of these data (which is specified by the width, height, 
% depth, time, elements indices of the polymorphic data model).  This program 
% can operate on any combination of value, mask, location and/or time data 
% in the input object.  Map data is unaffected by the extract operation.
% 
% If the "Region Origin" and/or the \fIRegion Size\fP fall outside of 
% the size of the input object, destination object value, location, and time
% data will be padded with zero, and mask data will be padded with one.
% 
% The subobject position attribute of a data object defines the coordinates 
% at which that subobject is located in its parent data object.  
% The "Record Region Origin" option (subpos) allows the extract operator to
% set the sub-object position attribute in the output object to the Region 
% origin.  If this option is set to "Yes", the subobject position of the 
% output object will be set to (woff, hoff, doff, toff, eoff).  If "Record
% Region Origin" is set to "No", the output subobject position is set to 
% (0,0,0,0,0).  Programs like the insert operator (kinsert) can use this 
% attribute for automatically inserting the subregion back into the original 
% after processing.  
% 
% The subobject position attribute can also be explicitly set by using the 
% Set Data Attributes operator (ksetdattr), and can be printed using the 
% Print File Information operator (kfileinfo).
% 
% The destination object data types are the same as the source object
% data types.
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
% This program has not yet been updated to completely support the
% polymorphic data model.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkextract(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkextract(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'wsize', 1;'hsize', 1;'dsize', 1;'tsize', 1;'esize', 1;'woff', 0;'hoff', 0;'doff', 0;'toff', 0;'eoff', 0;'o', '__output'};
maxval={0,2,2,2,2,2,0,0,0,0,0,0};
minval={0,2,2,2,2,2,0,0,0,0,0,0};
istoggle=[0,1,1,1,1,1,1,1,1,1,1,0];
was_set=istoggle * 0;
paramtype={'InputFile','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','OutputFile'};
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
[varargout{:}]=callKhoros([w 'kextract"  '],Inputs,narglist);