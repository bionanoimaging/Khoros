%kcmindist_classify 'Classify an object using the Minimum Distance algorithm'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros cmindist_classify.pane file
%
% Parameters: 
% InputFile: iimage 'Input Image', required: 'input image file'
% InputFile: isigs 'Input Signatures', required: 'input signatures file'
% Integer: distancerank 'Use distance rank', default: 1: 'distance rank integer'
% OutputFile: oclass 'Output Classified', required: 'output classified image'
% OutputFile: oprob 'Output Probabilities', optional: 'output a posteriori probabilities'
% OutputFile: oinfo 'Output Information', optional: 'output information about classification'
%
% Example: [oclass, oprob, oinfo] = kcmindist_classify({iimage, isigs}, {'iimage','';'isigs','';'distancerank',1;'oclass','';'oprob','';'oinfo',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% cmindist_classify - Classify an object using the Minimum Distance algorithm
%
%  DESCRIPTION
% This routine classifies an object using the Minimum Distance classification algorithm (or, more precisely, the Minimum Euclidean Distance to Class Means algorithm). The Minimum Distance algorithm is a simple algorithm that assigns a class C to a pixel X if the distance of a prototype of C to the vector X is the smallest between all known classes. More details about the Minimum Distance classifier are on the Classify Toolbox Manual.
% This routine requires an input object to be classified (specified by the parameter [-iimage]) and a set of classes's signatures object created by "cmindist_signature" and appended by \fIkappend\fP (specified by the parameter [-isigs]).
% This routine will create the output classification result in the file specified by [-oclass]. Optionally the final distances for each point and each class can be created if the parameter [-oprob] is used. If a file is specified in the  parameter [-oinfo] the classification results will be written to that file in ASCII (can get large for large images).
% The expected dimensions of the input and output objects are shown below:
% The input object which will be classified will have dimensions WxHxDxTxF, where F is the number of features. If it has mask, the masked points won't be classified, and the corresponding points in the output will have value 0 and mask 0.
% The input signatures must have dimensions Fx2x1xNx1, where N is the number of classes. It must be created by using "cmindist_signature" and \fIkappend\fP. 
% The output object (specified with the parameter [-oclass]) will have dimensions WxHxDxTx1, and its value segment will have values on the range 0..N, where 0 means that the pixel was rejected (see below). It will also have a corresponding mask segment with values 0 for the rejected pixels and 1 for the non-rejected pixels. The values for the pixels will be associated accordingly to the order the signatures were appended with "kappend".
% If the parameter [-oprob] is used, it will have dimensions WxHxDxTxN.
% Alternatively to the Minimum Distance classification, the second (or third, or N-th) distance result can be obtained by specifying an index in the [-distancerank] parameter.
% Points can be optionally rejected (with value and mask 0 in the output) if their distance to the center (or mean) in the signature is larger than an absolute value (specified with the [-reject] parameter) or a number of standard deviations (specified with the [-reject] parameter and the [-usestddev] flag).
% Please refer to the Classify toolbox manual or for one of the example workspaces for usage examples and details.
%
%  
%
%  EXAMPLES
% All examples for the Classify toolbox are listed on the Classify Toolbox Manual. For examples of this program, please see the Classify:workspaces:MINDIST and Classify:workspaces:MINDIST-Classify example workspaces.
%
%  "SEE ALSO"
% cmindist_signature, kappend.
%
%  RESTRICTIONS 
% Expects the signatures to be valid signatures for the Minimum Distance algorithm.
%
%  REFERENCES 
% All references for the Classify toolbox are listed on the Classify Toolbox Manual.
%
%  COPYRIGHT
% Copyright (C) 1997 Rafael Santos. Khoros (C) Khoral Research, Inc.
% 


function varargout = kcmindist_classify(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kcmindist_classify(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'iimage', '__input';'isigs', '__input';'distancerank', 1;'oclass', '__output';'oprob', '__output';'oinfo', '__output'};
maxval={0,0,2,0,1,1};
minval={0,0,2,0,1,1};
istoggle=[0,0,1,0,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','Integer','OutputFile','OutputFile','OutputFile'};
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
[varargout{:}]=callKhoros([w 'cmindist_classify"  '],Inputs,narglist);
