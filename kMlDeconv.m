%kMlDeconv 'Deconvolution using ML/EM algorithm '
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros MlDeconv.pane file
%
% Parameters: 
% Integer: n 'Iterations', default: 60: 'Number of iterations until algorythm stops'
% Double: fX 'Reduction Factor X', default: 1: 'Reduction Factor X '
% Double: fY 'Y', default: 1: 'Reduction Factor Y'
% Double: fZ 'Z', default: 1: 'Reduction Factor Z'
% Double: ZX 'ZX Aspect', default: 1: 'Pixel-Z-Size / Pixel-X-Size'
% Double: HD 'HD Aspect', default: 0: 'Hight of Objetc above 0-Plane / Distance from turning-point of movable table'
% Integer: rW 'Border (Pixels)', default: 4: 'a gaussian Window will be applied'
% Toggle: SepRec 'No first Measurement', default: 0: 'first coordinates are only used for defining reconstruction geometry'
% Double: mf 'Maximal Rel. Frequency X/Y', default: 0.8: 'Higher frequencies are suppressed in X/Y direction'
% Double: mzf 'Z', default: 0.4: 'Higher frequencies are suppressed in Z-direction'
% InputFile: i 'Measured Image', required: 'Measured confocal image'
% InputFile: p 'PSF', required: 'PSF needed for ML algorithm (same size as measured data)'
% InputFile: s 'Start File', optional: 'file to start iteration with'
% InputFile: Over 'Overrelaxation Table', optional: 'Table for Overrelaxation Factors'
% InputFile: v 'Match File', optional: 'file containing points to match'
% OutputFile: o 'Recon. Image', required: 'Resulting output data object'
% OutputFile: c 'Correction Image', required: 'Correction Image'
% OutputFile: f 'Fwd Projected File', optional: 'forward proj. guess'
% OutputFile: hf 'HF Content Output', optional: 'energy of highest 10% frequences'
%
% Example: [o, c, f, hf] = kMlDeconv({i, p, s, Over, v}, {'n',60;'fX',1;'fY',1;'fZ',1;'ZX',1;'HD',0;'rW',4;'SepRec',0;'mf',0.8;'mzf',0.4;'i','';'p','';'s','';'Over','';'v','';'o','';'c','';'f','';'hf',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% MlDeconv - Deconvolution using ML/EM algorithm
%
%  DESCRIPTION
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1996-2003, Rainer Heintzmann,  All rights reserved.
% 


function varargout = kMlDeconv(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kMlDeconv(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'n', 60;'fX', 1;'fY', 1;'fZ', 1;'ZX', 1;'HD', 0;'rW', 4;'SepRec', 0;'mf', 0.8;'mzf', 0.4;'i', '__input';'p', '__input';'s', '__input';'Over', '__input';'v', '__input';'o', '__output';'c', '__output';'f', '__output';'hf', '__output'};
maxval={1000,10,10,10,10,10,2,0,2,2,0,0,1,1,1,0,0,1,1};
minval={1,0,0,0,0,-10,2,0,0,0,0,0,1,1,1,0,0,1,1};
istoggle=[0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,1,1];
was_set=istoggle * 0;
paramtype={'Integer','Double','Double','Double','Double','Double','Integer','Toggle','Double','Double','InputFile','InputFile','InputFile','InputFile','InputFile','OutputFile','OutputFile','OutputFile','OutputFile'};
% identify the input arrays and assign them to the arguments as stated by the user
if ~iscell(Inputs)
Inputs = {Inputs};
end
NumReqOutputs=2; nextinput=1; nextoutput=1;
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
[varargout{:}]=callKhoros([w 'confocrec"  -k'],Inputs,narglist);
