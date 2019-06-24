%kkecho 'Echo attributes of toolbox or software object'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kecho.pane file
%
% Parameters: 
% String: tb 'Toolbox Name', default: ' ': 'toolbox name'
% MultiChoice: echo 'What To Echo?', default: 1: 'list all the toolbox objects'
% String: dummy 'toolboxes', default: 'toolboxes': 'echo the path of the object'
% String: dummy 'path', default: 'path': 'echo the binary path of the object'
% String: dummy 'binpath', default: 'binpath': 'list Lex source code files in the object'
% String: dummy 'lsrc', default: 'lsrc': 'list all files in the object'
% String: dummy 'allfiles', default: 'allfiles': 'list the software objects in a toolbox'
% String: dummy 'objects', default: 'objects': 'echo the library path of the object'
% String: dummy 'libpath', default: 'libpath': 'list all source code files in the object'
% String: dummy 'allsrc', default: 'allsrc': 'list C source code files in the object'
% String: dummy 'src', default: 'src': 'echo object category string'
% String: dummy 'category', default: 'category': 'echo object subcategory string'
% String: dummy 'subcategory', default: 'subcategory': 'echo the software objects binary name'
% String: dummy 'bname', default: 'bname': 'list all FORTRAN source code in the object'
% String: dummy 'fsrc', default: 'fsrc': 'echo the icon name for the object'
% String: dummy 'icon', default: 'icon': 'echo all string attributes'
% String: dummy 'object-info', default: 'object-info': 'echo the short description of the object'
% String: dummy 'description', default: 'description': 'list YACC source code files in the object'
% String: dummy 'ysrc', default: 'ysrc': 'echo the version string for the object'
% String: dummy 'version', default: 'version': 'echo the point of contact string'
% String: dummy 'poc', default: 'poc': 'echo the email address of the point of contact'
% String: dummy 'email', default: 'email': 'list the keywords associated with the object'
% String: dummy 'keywords', default: 'keywords': 'echo the object type'
% String: dummy 'type', default: 'type': 'echo the associated library'
% String: dummy 'alib', default: 'alib': 'echo the configuration name used at build time'
% String: dummy 'config-name', default: 'config-name': 'what to echo'
%    Choices are:
% Toggle: fullpath 'Generate explicit path', default: 0: 'Colonel Flag'
% String: oname 'Object Name', default: ' ': 'Program or Library Object Name'
% String: type 'Object Type', default: ' ': 'type of object'
%
% Example: kkecho( {'tb',' ';'echo',1;'dummy','toolboxes';'dummy','path';'dummy','binpath';'dummy','lsrc';'dummy','allfiles';'dummy','objects';'dummy','libpath';'dummy','allsrc';'dummy','src';'dummy','category';'dummy','subcategory';'dummy','bname';'dummy','fsrc';'dummy','icon';'dummy','object-info';'dummy','description';'dummy','ysrc';'dummy','version';'dummy','poc';'dummy','email';'dummy','keywords';'dummy','type';'dummy','alib';'dummy','config-name';'fullpath',0;'oname',' ';'type',' '})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kecho - Echo attributes of toolbox or software object
%
%  DESCRIPTION
% \fBkecho" is utility for printing information about toolboxes and
% software objects.
% Although it can be useful to run from the command-line,
% it is most useful when writing shell scripts where you want to
% iterate over toolboxes and software objects.
% For example,
% the following bourne shell script will print out the path to
% all software objects in all available toolboxes:
% 
% 
%     #!/bin/sh
%     for toolbox in `kecho -echo toolboxes`; do
%         echo "Toolbox: $toolbox"
%         for object in `kecho -tb $toolbox -echo objects`; do
%             OPATH=`kecho -tb $toolbox -oname $object -echo path`
%             echo "    Object: $object"
%             echo "        Path: $OPATH"
%         done
%     done
% 
% 
% Note that this is not the most efficient approach in terms of run-time,
% but using kecho in this way makes it easy to write one-off tools.
% 
% The simplest use of \fBkecho" is to determine the list of available
% toolboxes:
% 
% 
%     % kecho -echo toolboxes
%     BOOTSTRAP DATASERV DESIGN DATAMANIP ENVISION
% 
% 
% You can use the \fB-tb toolbox" switch to request information
% about a particular toolbox:
% 
% 
%     % kecho -tb bootstrap -echo path
%     /usr/local/khoros/bootstrap
% 
%     % kecho -tb dataserv -echo objects
%     kdatafmt kgdbm_dump kapputils kappserv kdataccess kdataman
% 
% 
% The \fB-type object-type" switch can only be used in combination
% with \fB-tb" and the \fB-echo objects\fP switches:
% 
% 
%     % kecho -tb bootstrap -type library -echo objects
%     kclui kexpr kutils klibm klibdb kcodegen kforms ktestutils kcms
% 
% 
% Most of the "echo options" are for use with software objects.
% For example,
% the following examples show how you can get various software
% object attributes using \fBkecho":
% 
% 
%     % kecho -tb datamanip -oname kadd -echo category
%     Arithmetic
% 
%     % kecho -tb datamanip -oname kadd -echo description
%     Output = Input 1 + (Input 2 or Constant)
% 
%     % kecho -tb datamanip -oname kadd -echo version
%     2.0.5
% 
% 
%
%  
%
%  EXAMPLES
% List all available toolboxes:
% % kecho -echo toolboxes 
% List all objects in the BOOTSTRAP toolbox:
% % kecho -tb bootstrap -echo objects
% List all xvroutines in the BOOTSTRAP toolbox:
% % kecho -tb bootstrap -type xvroutine -echo objects
% List path to 'guise' software object:
% % kecho -tb design -oname guise -echo path
% List all source code associated with the 'guise' software object:
% % kecho -tb design -oname guise -echo allsrc
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkecho(varargin)
Inputs={};
if nargin ==0
  arglist={'',''};
elseif nargin ==1
  arglist=varargin{1};
else error('Usage: [out1,..] = kkecho(arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'tb', ' ';'echo', 1;'dummy', 'toolboxes';'dummy', 'path';'dummy', 'binpath';'dummy', 'lsrc';'dummy', 'allfiles';'dummy', 'objects';'dummy', 'libpath';'dummy', 'allsrc';'dummy', 'src';'dummy', 'category';'dummy', 'subcategory';'dummy', 'bname';'dummy', 'fsrc';'dummy', 'icon';'dummy', 'object-info';'dummy', 'description';'dummy', 'ysrc';'dummy', 'version';'dummy', 'poc';'dummy', 'email';'dummy', 'keywords';'dummy', 'type';'dummy', 'alib';'dummy', 'config-name';'fullpath', 0;'oname', ' ';'type', ' '};
maxval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'String','MultiChoice','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','String','Toggle','String','String'};
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
  varargout = cell(0);
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
callKhoros([w 'kecho"  '],Inputs,narglist);