%kkgenobj 'Generate a software object from scratch.'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kgenobj.pane file
%
% Parameters: 
% String: tb 'Toolbox Name ', default: ' ': 'toolbox name'
% String: oname 'Object Name ', default: ' ': 'object name'
% String: description 'Short Description', default: ' ': 'short description of object'
% String: temp_obj 'Template Object ', default: ' ': 'Software object to use as a template'
% String: temp_tb 'Template Toolbox', default: ' ': 'Toolbox Template Object is in. If not specified, it assumes the toolbox for the new object'
% String: bname 'Binary Name ', default: ' ': 'binary name'
% String: icon_name 'Icon Name', default: ' ': 'name for icon or glyph'
% String: author 'Author', default: ' ': 'name of object author'
% String: email 'Email Address', default: ' ': 'email address of object author'
% Toggle: form 'Form UIS File', default: 0: 'Start a *.form file for the object'
% MultiChoice: lang 'Alternate programming language', default: 1: 'none'
% String: dummy 'none', default: 'none': 'C++'
% String: dummy 'C++', default: 'C++': 'fortran'
% String: dummy 'fortran', default: 'fortran': 'perl'
% String: dummy 'perl', default: 'perl': 'csh'
% String: dummy 'csh', default: 'csh': 'sh'
% String: dummy 'sh', default: 'sh': 'ksh'
% String: dummy 'ksh', default: 'ksh': 'Alternate programming language'
%    Choices are:
% MultiChoice: type 'Object Type', default: 1: 'kroutine'
% String: dummy 'kroutine', default: 'kroutine': 'xvroutine'
% String: dummy 'xvroutine', default: 'xvroutine': 'example'
% String: dummy 'example', default: 'example': 'testsuite'
% String: dummy 'testsuite', default: 'testsuite': 'library'
% String: dummy 'library (library)', default: 'library': 'script'
% String: dummy 'script (shell script)', default: 'script': 'pane'
% String: dummy 'pane (pane only)', default: 'pane': 'type of object'
%    Choices are:
% Toggle: pane 'Pane UIS File', default: 0: 'Start a *.pane file for the object'
% String: cat 'Category Name ', default: ' ': 'category name'
% String: subcat 'Subcategory Name ', default: ' ': 'subcategory name'
% Toggle: lib 'Generate l*.c file?', default: 0: 'Allow the user to specify whether or not to create a l*.c file'
% String: lname 'library object name', default: 'lname': 'library object to associate l*.c with'
%
% Example: kkgenobj( {'tb',' ';'oname',' ';'description',' ';'temp_obj',' ';'temp_tb',' ';'bname',' ';'icon_name',' ';'author',' ';'email',' ';'form',0;'lang',1;'dummy','none';'dummy','C++';'dummy','fortran';'dummy','perl';'dummy','csh';'dummy','sh';'dummy','ksh';'type',1;'dummy','kroutine';'dummy','xvroutine';'dummy','example';'dummy','testsuite';'dummy','library';'dummy','script';'dummy','pane';'pane',0;'cat',' ';'subcat',' ';'lib',0;'lname','lname'})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kgenobj - Generate a software object from scratch.
%
%  DESCRIPTION
% "Kgenobj" is the tool that creates new software objects.  It requires the
% name of a toolbox in which to create the software object, a name for the 
% new object, and the type of object.  In addition, there are a variety of other
% optional arguments that allow you to configure your software object as desired;
% for example, specification of a binary name that differs from the object name,
% whether or not the object is to be installed in "cantata", and so on.
% Specifying a template object is much like doing a copy/rename.  This is useful 
% when creating a new object that is to be similar to an existing object.
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
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkgenobj(varargin)
Inputs={};
if nargin ==0
  arglist={'',''};
elseif nargin ==1
  arglist=varargin{1};
else error('Usage: [out1,..] = kkgenobj(arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'tb', ' ';'oname', ' ';'description', ' ';'temp_obj', ' ';'temp_tb', ' ';'bname', ' ';'icon_name', ' ';'author', ' ';'email', ' ';'form', 0;'lang', 1;'dummy', 'none';'dummy', 'C++';'dummy', 'fortran';'dummy', 'perl';'dummy', 'csh';'dummy', 'sh';'dummy', 'ksh';'type', 1;'dummy', 'kroutine';'dummy', 'xvroutine';'dummy', 'example';'dummy', 'testsuite';'dummy', 'library';'dummy', 'script';'dummy', 'pane';'pane', 0;'cat', ' ';'subcat', ' ';'lib', 0;'lname', 'lname'};
maxval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[0,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'String','String','String','String','String','String','String','String','String','Toggle','MultiChoice','String','String','String','String','String','String','String','MultiChoice','String','String','String','String','String','String','String','Toggle','String','String','Toggle','String'};
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
callKhoros([w 'kgenobj"  '],Inputs,narglist);
