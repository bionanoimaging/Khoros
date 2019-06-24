%kkmegaclip 'Clip the Range of Values in Data Object'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kmegaclip.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'Input file'
% OutputFile: o 'Output ', required: 'output file'
% InputFile: ilc 'Lower Cutoff Values File', optional: 'File containing lower cutoff values'
% InputFile: iuc 'Upper Cutoff Values File', optional: 'File containing upper cutoff values'
%
% Example: o = kkmegaclip({i, ilc, iuc}, {'i','';'o','';'ilc','';'iuc',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kmegaclip - Clip the Range of Values in Data Object
%
%  DESCRIPTION
% The "MegaClip" operator (kmegaclip) performs clipping on the Input 
% data object (i), limiting the range of values in the object.  Upper and 
% lower cutoff values can be specified as either single constant values 
% (lc, uc), or sets of values passed in as data objects (ilc, iuc).  It is 
% not necessary to specify both the Upper Cutoff and the Lower Cutoff. 
% 
% All data values in the Input object that are LESS THAN the Lower Cutoff 
% are set to the Lower Cutoff in the resulting Output object, unless the 
% alternate "Lower Cutoff Output Value" (fval) is explicitly provided.  If 
% this value is provided, clipped data are set to that value instead of the 
% Lower Cutoff.  Likewise, data values GREATER THAN the Upper Cutoff are set 
% to the Upper Cutoff, unless the alternate "Upper Cutoff Output Value" is 
% explicitly provided.  All other data remain the same.  
% "Exception":  Any time that both the upper and lower cutoff values are 
% provided, and the upper cutoff is LESS THAN the lower cutoff, then data 
% values between the two cutoffs are always set equal to the "Lower Cutoff 
% Output Value" (fval).
% 
% The following four diagrams illustrate how the data is clipped for different 
% combinations of upper and lower cutoffs.  The plots are example data 
% histograms.  Clipping output assignment rules are given following the diagrams.
% .KS
% 
%  "\fBLower Cutoff Only:"" 5
% 
% 
% \f(CW
%      lower cutoff result:       |<-F->|<----T---->|
%                                 |     | :     .   |
%                                 |    .:.:.  .:::  |
%                                 |:. .::::::.::::: |
%                                 |::::::::::::::::.|
%                                 ------|------------
%                                       lower cutoff (lc)
% 
%         if value <  lc  cutoff result = False
%         if value >= lc  cutoff result = True
% "
% 
% .KE
% .KS
% 
%  "\fBUpper Cutoff Only:"" 5
% 
% 
% \f(CW
%         upper cutoff result:    |<----T---->|<-F->|
%                                 |       :   | .   |
%                                 |    .:.:.  .:::  |
%                                 |:. .::::::.::::: |
%                                 |::::::::::::::::.|
%                                 ------------|------
%                                             upper cutoff (uc)
% 
%         if value >  uc  cutoff result = False
%         if value <= uc  cutoff result = True
% "
% 
% .KE
% .KS
% 
%  "\fBUpper Cutoff is Greater than Lower Cutoff:""  5
% When both upper and lower cutoff values are specified, and the upper cutoff
% is GREATER THAN the lower cutoff, the combined cutoff result is the logical 
% AND of the individual results.
% 
% 
% \f(CW
%         lower cutoff result:    |<-F->|<----T---->|
%         upper cutoff result:    |<----T---->|<-F->|
% 
%         combined cutoff result: |<-F->|<-T->|<-F->|
%                                 |     | :   | .   |
%                                 |    .:.:.  .:::  |
%                                 |:. .::::::.::::: |
%                                 |::::::::::::::::.|
%                                 ------|-----|------
%                                      lc     uc
% 
%         if value <  lc OR  value >  uc  cutoff result = False
%         if value >= lc AND value <= uc  cutoff result = True
% "
% 
% .KE
% .KS
% 
%  "\fBUpper Cutoff is Less than Lower Cutoff:""  5
% When both upper and lower cutoff values are specified, but the upper cutoff
% is LESS THAN the lower cutoff, the combined cutoff result is the logical 
% OR of the individual results.  (Specifying the lower cutoff to be greater
% than the upper cutoff inverts the operation.)
% In this case, the false value assigned to the output will always be fval.
% 
% 
% \f(CW
%         upper cutoff result:    |<-T->|<----F---->|
%         lower cutoff result:    |<----F---->|<-T->|
% 
%         combined cutoff result: |<-T->|<-F->|<-T->|
%                                 |     | :   | .   |
%                                 |    .:.:.  .:::  |
%                                 |:. .::::::.::::: |
%                                 |::::::::::::::::.|
%                                 ------|-----|------
%                                      uc     lc
% 
%         if value <  lc AND value >  uc  cutoff result = False
%         if value >= lc OR  value <= uc  cutoff result = True
% "
% 
% .KE
% 
% Clipping results are assigned according to the following rules.  ("Lower
% result" and "upper result" are either the clipping values or fval and 
% tval - see discussion above.)
% 
%  "1.  When lower cutoff < upper cutoff" 5
% If the data value is less than the lower cutoff, set the
% output value to "lower result".
% If the data value is greater than the upper cutoff, set
% the output value to "upper result".
% Otherwise, the data value remains the same.
% 
%  "2.  When upper cutoff < lower cutoff" 5
% If the data value is less than the upper cutoff and
% it is greater than the lower cutoff, set output
% value to the "lower result".
% Otherwise, the data value remains the same.
% 
% When upper and lower cutoff values are equal, the only data values that
% are evaluated as TRUE are those that are equal to the cutoff values.
% 
%  "Data Type" 5
% .cI $DATAMANIP/repos/shared/man/sections/value_type_1input
% 
%  "Data Objects of Different Sizes" 5
% If, in addition to the input data object (i), upper or lower cutoff
% objects (ilc, iuc) are supplied,
% the source objects can be of different sizes.  If the sizes are different,
% the size of the destination object's data will be the the same as that of
% the input data object.  When resizing the cutoff objects, the data is
% zero padded, or truncated to the size of the input object.
% Alignment between the input files will always be the upper-left hand corner,
% position (0,0,0,0,0).
% 
%  "Map Data - Single Input" 5
% .cI $DATAMANIP/repos/shared/man/sections/map_1input
% 
%  "Map Data - Multiple Input Objects" 5
% .cI $DATAMANIP/repos/shared/man/sections/map_2input
% 
%  "Validity Mask - Single Input" 5
% .cI $DATAMANIP/repos/shared/man/sections/mask_1input
% 
%  "Validity Mask - Multiple Input Objects" 5
% .cI $DATAMANIP/repos/shared/man/sections/mask_2input
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
% Executing "MegaClip" runs the program \fIkclip\fP with the -thresh 
% option set to FALSE (-thresh 0).
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
% DATAMANIP::kclipabove, DATAMANIP::kclipbelow, DATAMANIP::kclipin, 
% DATAMANIP::kclipout, DATAMANIP::kclip
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkmegaclip(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkmegaclip(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'o', '__output';'ilc', '__input';'iuc', '__input'};
maxval={0,0,1,1};
minval={0,0,1,1};
istoggle=[0,0,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','OutputFile','InputFile','InputFile'};
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
[varargout{:}]=callKhoros([w 'kclip"  -thresh'],Inputs,narglist);
