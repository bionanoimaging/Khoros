%kgimpfacet 'Import FACET data'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros gimpfacet.pane file
%
% Parameters: 
% InputFile: i 'Input Facet Data ', required: 'input facet file'
% String: name 'Name ', default: 'facets': 'object name'
% OutputFile: o 'Output Geometry ', required: 'output geometry object'
%
% Example: o = kgimpfacet(i, {'i','';'name','facets';'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% gimpfacet - Import FACET data
%
%  DESCRIPTION
% .I gimpfacet 
% will input a file containing facet information into a data object
% using geometry services.   
% 
% The file will contain one or more "big parts", with each big part
% consisting of a list of XYZ points.  For each big part, there will
% be one or more "small parts", with each small part consisting of
% a number of facets.  Each facet is simply a triangle specified by
% three index numbers into the vertices list contained in the big part.
% 
% The resulting geometry will consist of a series of disjoint triangle
% primitives, with one primitive for every small part.  Note that each
% disjoint triangle primitive contains several triangles.  
% 
% All triangles in the format are specified to be RH.  RH normals will
% be generated for each triangle.
% 
% The following example illustrates the format of a facet file.  The
% explanations, separated by '->' should not appear in the facet file.
% 
% 
%     information line          
% 	      1                    <- 1 big part
%     square with fin                <- name of big part
%     0, 0.00 1.00 0.00 0.00         <- mirror, ax+by+cz-d = 0
% 	      5                    <- #nodes in big part
%     0.00  0.00  0.00               <- xyz of node 1
%     5.00  0.00  0.00                  separated by at least 1 space
%     5.00  5.00  0.00
%     5.00  0.00  0.00
%     5.00  5.00  4.00
% 	      2                    <- number of small parts
%     square                         <- name of 1st small part
% 	      2                    <- number of facets in 1st small part
%     1 2 3   1 0011 1               <- facet 1 has nodes 1,2,3 followed by
%     1 3 4   1 0011 2                  material index, group #, facet #
%     fin                            <- name of 2nd small part
% 	      2                    <- number of facets in 2nd small part
%     1 3 5   1 0011 1
% 
% 
% The material index, group #, and facet # are consumed but not used.
% In future releases, the material index may be used to add color to the
% geometry.
% 
% The facet file format is also known as the General Dynamics ACAD format.
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
% Copyright (C) 1996,1997 , The Regents of the University of California.  All rights reserved.
% 


function varargout = kgimpfacet(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kgimpfacet(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'name', 'facets';'o', '__output'};
maxval={0,0,0};
minval={0,0,0};
istoggle=[0,1,0];
was_set=istoggle * 0;
paramtype={'InputFile','String','OutputFile'};
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
[varargout{:}]=callKhoros([w 'gimpfacet"  '],Inputs,narglist);
