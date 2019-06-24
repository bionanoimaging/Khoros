%kkgenmanual 'Generates the manual for a toolbox.'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kgenmanual.pane file
%
% Parameters: 
% String: tb 'Toolbox Name ', default: ' ': 'toolbox name'
% InputFile: i 'Input filename (chaptername.man)', required: 'Input Filename'
% OutputFile: o 'Output filename (chaptername.ms)', required: 'Output Filename'
%
% Example: o = kkgenmanual(i, {'tb',' ';'i','';'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kgenmanual - Generates the manual for a toolbox.
%
%  DESCRIPTION
% .I Kgenmanual 
% will process a Khoros manual (*.man) file and create a roff
% (*.ms) file. For complete details on writing documentation with Khoros and
% the documentation convensions, please refer to the Khoros manual, Programmer's
% Volume, Chapter 6, Writing Documentation.
% 
% The Khoros manual file must be written in a roff format. There are some special
% roff commands that kgenmanual will search for and process. The resulting roff
% file must then be processed by eqn, tbl and Xroff, where Xroff might be groff,
% psroff, eroff, etc. Khoros has a complete make system for formatting and 
% printing documentation.
% 
% Special roff Commands
% 
%  .so 10
% The .so command is a normal roff command, but kgenmanual will expand the
% path so that the correct file is included. It is recommended that a full
% path is not specified  It is recommended that a full
% path is not specified. 
% Syntax: .so {filename}, where the filename can be of the form 
% $TOOLBOX_NAME/path/file, or ../path/file or ./file. 
% 
%  .function 10
% The .function command will include a library function 
% description in the document. This is real handy for documenting libray. To
% include the appropriate function headers within the document, it is 
% necessary to specify the library object name, and the fuction to include.
% Syntax: .function {library object name} {function name}
% 
%  .help 10
% The .help command is used to include online help files into a printed 
% manual. This is a nice function for reuse of documentation. The starting
% section number must be specified and the path to the file to include
% must be specified. Since the convention when writing documentation 
% is to use the .NH {section level} macro, it is important to have the
% ability to set the starting {section level} when including an online help.
% For example, in the online help page the section levels specified are 
% probably level 1. In the written documentation the online might need
% to be included as a level 2. The .help command allows this to be specified.
% Syntax: .help {section level} {filename}, where the filename can be of the form
% $TOOLBOX_NAME/path/file, or ../path/file.
% 
%  .PSPIC 10
% The .PSPIC command will allow the inclusion of postscript files into the
% document. Note, this function only works with groff. The postscript file
% that will be included must be encapsulated postscript. The filename and
% optionally the width and height in inches can be specified.
% Syntax: .PSPIC {filename} {width} {height}, where the filename can be 
% of the form $TOOLBOX_NAME/path/file, or ../path/file, and width and
% height are specifed in inches.
%
%  
%
%  EXAMPLES
% 
% look at one of the chapters in $KHOROS/manual/ToolboxProg for an
% example and consult the Programmer's Volume, Chapter 6, Writing
% Documetation.
%
%  "SEE ALSO"
% kgenman(1), kgenmake(1), kgenimake(1)
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkgenmanual(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkgenmanual(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'tb', ' ';'i', '__input';'o', '__output'};
maxval={0,0,0};
minval={0,0,0};
istoggle=[0,0,0];
was_set=istoggle * 0;
paramtype={'String','InputFile','OutputFile'};
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
[varargout{:}]=callKhoros([w 'kgenmanual"  '],Inputs,narglist);
