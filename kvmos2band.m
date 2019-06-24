%kvmos2band 'Convert Mosaic Image to Multiband Image (K1)'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros vmos2band.pane file
%
% Parameters: 
% InputFile: i 'Input Image ', required: 'input image'
% Integer: r 'Number of rows per subimage ', default: 16: 'number of subimage rows (must be equal for all subimages)'
% Integer: c 'Number of columns per subimage ', default: 16: 'number of subimage columns (must be equal for all subimages)'
% Integer: bs 'Subimage border size (inner border) ', default: 0: 'Subimage border size in pixels (inner borders)'
% Integer: bm 'Mosaic border size (outer border) ', default: 0: 'Mosaic image border size in pixels (outer border)'
% Integer: x 'Horizontal index of first subimage ', default: 0: 'Horizontal index of first subimage (will be first band)'
% Integer: y 'Vertical index of first subimage ', default: 0: 'Vertical index of first subimage (will be first band)'
% Integer: s 'Subimage skip value ', default: 0: 'Number of subimages to skip (periodic) when putting subimages into band format'
% Integer: n 'Number of subimages to be banded ', default: 1: 'Number of subimages to be put into band format'
% OutputFile: o 'Output Image', required: 'resulting output image'
%
% Example: o = kvmos2band(i, {'i','';'r',16;'c',16;'bs',0;'bm',0;'x',0;'y',0;'s',0;'n',1;'o',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% vmos2band - Convert Mosaic Image to Multiband Image  (K1)
%
%  DESCRIPTION
% .I vmos2band
% converts a mosaic input image to an output image in which each
% subimage of the input mosaic constitutes a band of the output image.
% 
% The output image generated by vmos2band will be (r-2*bs) rows by (c-2*bs) 
% columns with n bands, where r and c are the number of rows and columns 
% per subimage, bs is the subimage border size, and n is the number of subimages
% that are to be put into band format.  Vmos2band assumes that all 
% subimages are same size (r*c) and all subimages have the same border size (bs).
% Subimages from the input mosaic image are assigned to bands in the multiband 
% output image in the following manner:
% The first subimage specified is assigned to the first band in the output
% image.  Subsequent bands are assigned subsequent subimages
% indexed from left to right, top to bottom.
% Vmos2band accepts VIFF data_types (excluding VFF_TYP_BIT) and 
% returns that same data_type.
% If a map is associated with the input mosaic image, the same map will be
% assigned to the output multiband image.
% 
% Vmos2band does not work on explicit location data and will return an error
% when such an image is encountered.  No output image will be created.
% 
% " number of columns and number of rows in subimages "
% The -r and -c options are used to specify the number of rows and the 
% number of columns, respectively, per subimage.  Vmos2band assumes that
% all subimages in the mosaic image are the same size.  The -r and -c
% values SHOULD include any borders associated with the subimages.
% The default subimage row and column sizes are 16 pixels.
% "subimage border size"
% .P
% The -bs option allows the user to specify the subimage border size
% in pixels.  Again, this parameter will be applied to all subimages
% in the mosaic.  When vmos2band converts the mosaic image to a multiband
% image, the subimage borders will be removed from the subimages before
% storing them in bands.  The size of the output image will therefore
% be (r-2*bs) rows by (c-2*bs) columns by n bands.
% The default subimage border size is 0 pixels.
% "overall mosaic image border size"
% The -bm option allows the user to specify, in pixels, the size of 
% an outer border that should be removed from the mosaic image before 
% extracting the subimages.  The overall mosaic image border
% and the subimage borders are independent.  
% The default overall mosaic image border size is 0 pixels.
% "horizontal and vertical offset of first subimage to be banded"
% The user can specify the first subimage in the mosaic that will be put into
% the multiband output image by using the -x (horizontal offset) and -y 
% (vertical offset) options.  The specified subimage will then be the 
% first band in the output image.  The indices, x and y, index through the 
% subimages (they are NOT indices through the input mosaic image rows 
% and columns).  Therefore, if a mosaic image contained
% 9 4-row by 4-col subimages arranged as 3 subimages in the horizontal 
% direction by 3 subimages in the vertical direction, the center 
% subimage would be indexed by x=1, y=1 (not by x=4, y=4).
% The default first subimage is the first subimage in the mosaic (x=0, y=0).
% "number of subimages to be put into band format"
% The user can also specify how many images will be put into band format, 
% starting with the first subimage (described above),
% by specifying the -n option.  If the specified number of subimages
% cannot be extracted, vmos2band will return an error and the output
% image will not be created.  If the -n option is not specified, vmos2band
% calculates the number of subimages that will be banded, taking into account
% both the subimage skip value and the first subimage offsets.
% "subimage skip value"
% The subimage skip value option (-s) allows the user to specify that 
% the next s subimages be skipped each time a subimage is stored as a 
% band.  For example, a skip value of s=1 in a 3x3 subimage mosaic would
% band the subimages in a checkerboard pattern (every other subimage is 
% a band in the output image).
% When applying the subimage skip value, vmos2band looks at the series of
% subimages as a linear array.  Therefore, the row/column arrangement of 
% subimages does not affect how the skipping occurs.
%
%  
%
%  EXAMPLES
% vmos2band -i mosaic.xv -o band.xv -r 18 -c 18 -bs 1 -n 3
% Will return a 3 band image of dimension 16 rows by 16 cols.
% Since there is a border of 1 (-bs 1) around the image, the
% resulting image is 16 rows by 16 cols.
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
% Vmos2band does not work on VFF_TYP_BIT data files.
% Vmos2band does not work on explicit location data and will return an error
% when such an image is encountered.  No output image will be created.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kvmos2band(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kvmos2band(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'r', 16;'c', 16;'bs', 0;'bm', 0;'x', 0;'y', 0;'s', 0;'n', 1;'o', '__output'};
maxval={0,1,1,1,1,1,1,1,1,0};
minval={0,1,1,1,1,1,1,1,1,0};
istoggle=[0,1,1,1,1,1,1,1,1,0];
was_set=istoggle * 0;
paramtype={'InputFile','Integer','Integer','Integer','Integer','Integer','Integer','Integer','Integer','OutputFile'};
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
[varargout{:}]=callKhoros([w 'vmos2band"  '],Inputs,narglist);
