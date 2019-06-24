%kcclassreport 'Create a report for the classification results'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros cclassreport.pane file
%
% Parameters: 
% InputFile: i 'Input Classification Result', required: 'classification result file name'
% InputFile: icsf 'Input Classes Specification File', required: 'input classes specification file'
% MultiChoice: omode 'Output Mode', default: 1: 'output mode toggle'
%    Choices are:
%   1: 'Text'
%   2: 'LaTeX'
%   3: 'HTML'
%   4: 'CSV'
% OutputFile: o 'Output Report', optional: 'text report based on the input'
%
% Example: o = kcclassreport({i, icsf}, {'i','';'icsf','';'omode',1;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% cclassreport - Create a report for the classification results
%
%  DESCRIPTION
% This program use the classification result from any classifier in the Classify toolbox (paseed in [-i] parameter) and a Class Specification File (passed in the [-icsf] parameter) to create a report for the classification. The report will contain, for each class in the Class Specification File, the title for the class, the number of pixels classified as that class, the percentage of pixels classified as that class and optionally the area for that class (if specified in the user interface). Options for this program and the related file formats are described below:
% The Text (ASCII) format option ([-omode 1]) formats the output using spaces to make a simple table. The fields in the report are evenly-spaced, making it easy for further text processing by perl or another similar utility.
% The LaTeX format option ([-omode 2]) formats the output as a LaTeX table, complete with caption and label. It can be included in any LaTeX file with the \\input command or read as a block of text using a text editor. The caption for the table will contain the file name of the classification result used for the generation of the report, and should be changed for reports - a reminder of this will appear when you run latex. For references about LaTeX, please refer to the Classify Toolbox Manual.
% The HTML format option ([-omode 3]) also create a table formatted in HTML, including caption, ready for inclusion in HTML documents. The caption should be changed by the user, originally the file name will be used as caption.
% The CSV format option ([-omode 4]) create a comma-delimited file (where the fields are separated by commas) which can be read/imported by Excel and other spreadsheet applications. One caveat: if the class names in the Class Specification File has commas on it, the application reading the CSV report will get confused, some manual editing will be necessary.
% The CSF (Class Specification File) is an ASCII file used to get the classes names for the report. Its format is very simple:
% * lines starting with # or / are considered as comments
% * each line defines a class: the first token is the index for that class, the second, third and fourth defines the red, green and blue values to be used for the thematic maps and the rest of the line defines the title for the class.
% Example: the line
% 3 255 255 0 This is the yellow class
% defines the color for the class index 3 (255,255,0 = Yellow) and the title for the class index 3 ("This is the yellow class")
% \fBImportant:" the index for the class in the Class Specification Format must \fBnot\fP be zero: the class zero is reserved for pixels which were rejected by the classification process. In other words, the classes indexes should be larger or equal to 1 (one).
% The user can optionally provide a scale (with the [-scale] and [-scaleunit] parameters) for the pixels in the images and a string representing the units. For example, for Landsat TM-5 images (except for band 6), each pixel represents 30x30 meters in the ground, so the user could specify a scale of 1 pixel = 900 m2 or 1 pixel = 0.0009 km2. The predefined units are pixels, mm2, cm2, m2 and km2, but the user can specify different units. If the scale is specified, the report will contain the area in pixels and in the specified unit.
% Output can be redirected to a file if the parameter [-o] is specified, otherwise output will be to kstdout.
%
%  
%
%  EXAMPLES
% All examples for the Classify toolbox are listed on the Classify Toolbox Manual. For an example of this program, please see the example workspace Classify:workspaces:MAXLIK.
%
%  "SEE ALSO"
% ccompare, cthematicmap
%
%  RESTRICTIONS 
%
%  REFERENCES 
% All references for the Classify toolbox are listed on the Classify Toolbox Manual.
%
%  COPYRIGHT
% Copyright (C) 1997 Rafael Santos. Khoros (C) Khoral Research, Inc.
% 


function varargout = kcclassreport(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kcclassreport(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'icsf', '__input';'omode', 1;'o', '__output'};
maxval={0,0,0,1};
minval={0,0,0,1};
istoggle=[0,0,0,1];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','MultiChoice','OutputFile'};
% identify the input arrays and assign them to the arguments as stated by the user
if ~iscell(Inputs)
Inputs = {Inputs};
end
NumReqOutputs=0; nextinput=1; nextoutput=1;
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
[varargout{:}]=callKhoros([w 'cclassreport"  '],Inputs,narglist);
