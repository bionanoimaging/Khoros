%kcxretouch 'Interactively retouch (paint) a classified image'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros cxretouch.pane file
%
% Parameters: 
% InputFile: iclass 'Input Classified Image', required: 'input classified image'
% InputFile: icsf 'Input Class Specification File', required: 'input class specification file'
% OutputFile: o 'Output Retouched Image', required: 'Resulting output data object'
%
% Example: o = kcxretouch({iclass, icsf}, {'iclass','';'icsf','';'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% cxretouch - Interactively retouch (paint) a classified image
%
%  DESCRIPTION
% Interactive Retouch (cxretouch xvroutine) allows the user to interactively retouch classification results. It is intended to be used for removal of small non-classified areas and region-constrained mode filtering.
% This program is \fBnot\fp a full-featured graphics editor - if that's what you want I'd suggest you to export the classification results to a ppm file with "kformats" and use xpaint or a similar program. Alternatively you can use the netpbm package or xv program to convert the ppm output to gif, tiff, bmp, etc. formats which can be edited with most Windows graphics packages.
% The advantages of using this program is that it will work on the native data of the classification results, i.e. preserving the map, mask and value data used by the Khoros Polymorphic Data Services to represent classified data. 
% This xvroutine expects as inputs the classified result [-iclass] and the Class Specification File for that classification task [-icsf], which will be used to get the classes' labels and colors. Its output [-o] will be the edited result. The input classified result \fBmust" have a map segment, i.e. it should be the output of a cthematicmap operator.
% The xvroutine will have a workspace for display of the classified image, zoom over the pointer position, a selector for the classes present in the Class Specification File (plus the "rejected" class), a button that will allow the present class to be selected from the classified image, seven buttons for area size selection (1x1, 3x3, 5x5, 9x9, 13x13, 25x25, 49x49), a mode selector (see below), buttons for polygon region selection (rectangle, ellipse, polyline, freehand).
% Editing can be done in three modes: 
% 1- Paint mode: the user selects a class from the class selector, a square region button or a polygon selection button and paints by clicking on the regions in the image.
% 2- Mode filtering mode: the user selects a region size and click over it, the program will apply a mode filter over the region. The mode filter mode (no, it is not redundant) can be selected in the Mode menu button. The mode filter will eliminate small misclassified regions.  
% 3- Masking mode - the same as paint mode except that it will mask the "painted" regions as if they were rejected by the classifier. This more can be activated by choosing the Rejected class in the Class selector or by choosing the mode Reject (mask) in the mode selector.
% The xvroutine also have primitive (1-level) undo and redo functions, with the respective buttons.
%
%  
%
%  EXAMPLES
% All examples for the Classify toolbox are listed on the Classify Toolbox Manual. For an example of this xvroutine, please see the Classify:workspaces:MINDIST-Classify example workspace.
%
%  "SEE ALSO"
% cthematicmap, csimplemode, Class Specification File format in the Classify Toolbox Manual.
%
%  RESTRICTIONS 
% Expect the parameter [-icsf] to point to a valid Class Specification file, and the parameters [-iclass] to be a result  of classification with one of the classifiers in this toolbox, preferably with a map applied with cthematicmap.
% Due to a refresh bug, when you select the paint or mode filter over large regions the program will take some time to refresh the window, if the window loses the focus it will appear black temporarily. This does \fBnot" have any effect on the image, and after the paint/mode processing it will return to the normal.
%
%  REFERENCES 
% All references for the Classify toolbox are listed on the Classify Toolbox Manual.
%
%  COPYRIGHT
% Copyright (C) 1997 Rafael Santos. Khoros (C) Khoral Research, Inc.
% 


function varargout = kcxretouch(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kcxretouch(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'iclass', '__input';'icsf', '__input';'o', '__output'};
maxval={0,0,0};
minval={0,0,0};
istoggle=[0,0,0];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','OutputFile'};
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
[varargout{:}]=callKhoros([w 'cxretouch"  '],Inputs,narglist);
