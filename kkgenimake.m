%kkgenimake 'Create or update Imakefile according to directory contents'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kgenimake.pane file
%
% Parameters: 
% String: tb 'Toolbox Name', default: ' ': 'Toolbox name'
% Toggle: recreate 'Recreate', default: 0: 'Recreate Imakefile from template'
% String: oname 'Object Name ', default: ' ': 'The object name'
% Toggle: dir 'Directory Imakefile', default: 0: 'create directory imakefile'
% Toggle: mdir 'Manual Directory Imakefile', default: 0: 'create manual directory imakefile'
% Toggle: example 'Example Imakefile', default: 0: 'create example imakefile'
% Toggle: manual 'Manual Imakefile', default: 0: 'create manual imakefile'
% Toggle: xexample 'X11 Example Imakefile', default: 0: 'create X11 example imakefile'
% Toggle: mindex 'Manual Index Imakefile', default: 0: 'create manual index Imakefile'
% Toggle: testsuite 'Testsuite Imakefile', default: 0: 'create testsuite imakefile'
% Toggle: mglossary 'Manual Glossary Imakefile', default: 0: 'create manual glossary Imakefile'
%
% Example: kkgenimake( {'tb',' ';'recreate',0;'oname',' ';'dir',0;'mdir',0;'example',0;'manual',0;'xexample',0;'mindex',0;'testsuite',0;'mglossary',0})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kgenimake - Create or update Imakefile according to directory contents
%
%  DESCRIPTION
% This program creates an Imakefile, assuming one does not already
% exist, or updates an already existing one to contain information
% sufficient to make the files contained in the directory.
% If an Imakefile does not exist, kgenimake copies a template, specified on the 
% command  line with [-type], into the current directory and then proceeds 
% to update it. If the [-tb] option is specified with the name of a
% valid toolbox, the resulting Imakefile will contain the project include file
% for that toolbox. If the [-tb] option is not specified, the current toolbox's
% Imakefile is used.  Updating is accomplished by looking at the names of all
% the files in the current directory and updating any existing "definition" that
% kgenimake knows about.
% .PP
% kgenimake uses the following templates that can be found in 
% \f(CW$BOOTSTRAP/repos/config/imake_config/Templates/":
% 
% 
% .B Imakefile.library
% Library template file
% 
% 
% .B Imakefile.kroutine
% Program template file
% 
% 
% .B Imakefile.xvroutine
% X11 Program template file
% 
% 
% .B Imakefile.dir
% Directory template file
% 
% 
% .B Imakefile.csh
% Csh Script template file
% 
% 
% .B Imakefile.sh
% Sh Script template file
% 
% 
% .B Imakefile.ksh
% Ksh Script template file
% 
% 
% .B Imakefile.perl
% Perl Script template file
% 
% 
% .B Imakefile.example
% Example Program template file
% 
% 
% .B Imakefile.xexample
% X11 Example Program template file
% 
% 
% .B Imakefile.testsuite
% Testsuite Program template file
% 
% 
% .B Imakefile.pane
% Pane Object template file
% .PP
% Since additional explanation of some of the arguments may be helpful, these
% are as follows:
% 
%  type:
% If the Imakefile does not exist, this option is required and specifies
% which of the templates to use (see FILES below).  There are five (5)
% known types:
% 1) library
% This option uses the library template which will create an Imakefile
% which will make, and optionally install, a library of the name specified
% with the -name option.
% 2) dir
% This option uses the directory template which will create an Imakefile
% that knows about subdirectories and will `cd' into them one at a time
% to continue the make.
% 3) script (csh, sh, ksh, perl)
% This option uses the script template which will create an Imakefile
% that knows about shell scripts and how to install them correctly.
% 4) kroutine
% This option uses the program template which will create an Imakefile
% which will make, and optionally install, a general, non-X11 program of
% the name specified with the -name option.
% 5) xvroutine
% This option uses the X11 program template which will create an Imakefile
% which will make,and optionally install, a program of the name specified
% with the -name option that uses the X11 libraries.
% 6) fkroutine
% This option uses the program template which will create an Imakefile
% which will make, and optionally install, a general, non-X11 program that
% depends on FORTRAN of the name specified with the -name option.
% 7) fxvroutine
% This option uses the X11 program template which will create an Imakefile
% which will make,and optionally install, a program of the name specified
% with the -name option that uses the X11 libraries and depends on FORTRAN.
% 
%  toolbox:
% This option is only used when an Imakefile does not exist. The toolbox
% option specifies the toolbox that the routine is associated with. Valid
% toolboxes can be listed using "craftsman". The resulting Imakefile will
% contain a "#include" for the toolbox project file. The toolbox project file
% must be located in $TOOLBOX_NAME/repos/config/imake_conf and called
% $TOOLBOX_NAME.def. If the 
% toolbox option is not specified then the resulting Imakefile will
% contain "#include <Toolbox.def>" which is the default. This file is
% located in KHOROS_HOME/repos/config/imake_conf and is intended only
% for those who are working directly in Khoros source.
% 
%  name:
% This option is only used when an Imakefile does not exist and the type,
% specified with the -type option, is one of: lib, prog or xprog.  If
% the type is `lib', then this option specifies the name of the library
% which gets created (see examples).  If the type is `prog' or `xprog',
% then this option specifies the name of the program that gets created.
% 
%  "output file:"
% This option allow the user to specify an alternate output file to use other
% than the default file of `Imakefile'.
% 
% KNOWN FIELDS:
% .in +1i
% 
%  TOOLBOX 15
% This field contains the name of the toolbox so that the Imakefile can
% be regenerated automatically.
% 
%  SUBDIRS 15
% This field is used in the "directory" template and specifies all subdirectories
% found in the current directory.
% 
%  SRCS
% This field is used in the "library", "program", and "X program" templates to
% specify sources, not including FORTRAN sources (see below), which exist in
% the current directory.  Sources currently
% consist of files with the following suffixes: '.c', '.y' and '.l'.
% 
%  OBJS
% This field is used in the "library", "program", and "X program" templates to
% specify resulting objects, not including FORTRAN objects (see below).  Entries
% in this field are created by changing the suffix on the files specified in
% SRCS to a '.o'.
% 
%  FSRCS
% This field is used in the "library" template to
% specify FORTRAN sources which exist in the current directory.  FORTRAN
% source is considered separately because
% the other sources, which all produce C code, can be created for use in shared
% libraries whereas FORTRAN source can not (this is true depending on the machine
% and version of f77 you have).
% 
%  FOBJS
% This field is used in the "library" template to
% specify FORTRAN objects only.  Entries in this field are created by changing
% the suffix on the files specified in FSRCS to a '.o'.
% 
%  HEADERS
% This field is used in the "library", "program", and "X program" templates to
% specify include files, files with a '.h' suffix, which exist in the
% current directory.
% 
%  SCRIPTS
% This field is used in the "scripts" template to
% specify script files, files with a '.csh' suffix, which exist in the
% current directory.
% 
%  LIBRARY_NAME
% This field is used in the "library" template to specify the name of the
% resultant library.  This field gets defined with the name specified with
% the "-name" argument.
% 
%  PROGRAM_NAME
% This field is used in the "program" and "X program" templates to specify
% the name of the resultant programs.  This field gets defined with the name
% specified with the "-name" argument.
% 
%  SCRIPT_NAME
% This field is used in the "library" template to specify
% the name of the directory in which shell scripts sit.
%  This field gets defined with the name specified with the "-name" argument.
% .in -1i
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


function varargout = kkgenimake(varargin)
Inputs={};
if nargin ==0
  arglist={'',''};
elseif nargin ==1
  arglist=varargin{1};
else error('Usage: [out1,..] = kkgenimake(arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'tb', ' ';'recreate', 0;'oname', ' ';'dir', 0;'mdir', 0;'example', 0;'manual', 0;'xexample', 0;'mindex', 0;'testsuite', 0;'mglossary', 0};
maxval={0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0};
istoggle=[1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'String','Toggle','String','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle'};
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
callKhoros([w 'kgenimake"  '],Inputs,narglist);
