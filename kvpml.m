%kvpml 'Estimate Fractal Dimension of Image Based on P(m,L) (K1)'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros vpml.pane file
%
% Parameters: 
% InputFile: i 'Input Image ', required: 'input image'
% Integer: l 'Lower window size', default: 3: 'select the initial size of the sliding window'
% Integer: u 'Upper window size', default: 5: 'select the final size of the sliding window'
% Integer: s 'Window step size ', default: 2: 'select the window step size or interval'
% Integer: q 'Range of moments ', default: 3: 'select the range of moments (-r/2 <= 0 >= r/2)'
% OutputFile: o1 'Output Image ', required: 'resulting multiband fractal dimension output image'
% OutputFile: o2 'Output FD Image ', required: 'output image specifying fractal dimension of each class'
% OutputFile: f1 'Output ASCII File', optional: 'output file for P(m,L) statistics'
%
% Example: [o1, o2, f1] = kvpml(i, {'i','';'l',3;'u',5;'s',2;'q',3;'o1','';'o2','';'f1',''})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% vpml - Estimate Fractal Dimension of Image Based on P(m,L)  (K1)
%
%  DESCRIPTION
% .I vpml
% estimates the fractal dimension of an image based on the probability 
% that there are m pixels within a window of size L centered on a pixel 
% from a particular class.  For a selected range of window sizes (L), 
% the window is centered on the first occurrence of the pixel belonging 
% to a particular class.  The number of pixels within a window of size L, 
% belonging to a specific class are counted (including the center pixel 
% of the window), and a "histogram" is formed as the window is moved over 
% the image.  This "histogram" represents the total number of occurrences,
% m, of a class of pixels in a window of size L.  From this, a normalized 
% histogram is formed, which yields an estimate of the probability density 
% function, P(m,L), for each window size L.  
% 
% All selected moments (q) of the P(m,L) distributions for each of the 
% desired window sizes are determined, and a linear regression or "best fit
% line" is found for the moment generating function, log(M(L))^1/q, versus
% the log of the window size, log(L).  The slope of the "best fit line"
% provides an estimate for the fractal dimension, D.
% 
% The center pixel of the largest window, Lmax, is replaced with the computed
% fractal dimension based on the probability density function, P(m,L).
% The largest window size, Lmax, determines the resulting size of the fractal
% dimension image.  This results in a border of size (Lmax / 2) around the
% image, which is set to zero. 
% 
% The input arguments are described as follows:
% 
%  "-i" 15
% specifies the input image, which must be of data type BYTE or INTEGER.  
% The input image must be a single band image.
% 
%  "-o1" 15
% specifies the output image, which will be a multiband image representing
% the fractal dimension of the input image for each of the specified
% moments.  The resulting output image will be of data storage type
% FLOAT, and will have a border of pixels of value zero.  The size of
% the border will be determined by the size of the largest window
% specified.  This can be determined from the following formulation,
% (Lmax -1) / 2 = border size.  Where Lmax is the size of the largest
% window used.  For example, if the largest window size is 9, then the
% border size will be (9 - 1) / 2 = 4 pixels.
% 
%  "-o2" 15
% specifies fractal dimension image, representing the fractal dimension 
% vectors for each class and moment.  This image will always have a row 
% size of 1 and a column size determined by the number of classes in the
% input image.  The number of data bands will be equal to the number of
% moments used in the estimation of the fractal dimension.
% 
%  "-f1" 15
% uses an ASCII file as output for the image information specifying the
% size of the input image, number of classes in the input image, and the
% range of moments used in the estimation of the fractal dimension.  Also
% included is a listing of the fractal dimensions for each class and 
% moment.
% 
%  "-l" 15
% specifies the initial or lower size of the sliding window.  This MUST be
% an odd number resulting in a window with a center pixel.  This means that
% the minimum size of the sliding window is 3 x 3.  The default value is
% 3, resulting in an initial window size of 3 x 3.
% 
%  "-u" 15
% specifies the final or upper size of the sliding window.  This MUST also
% be an odd number resulting in a window with a center pixel.  The size of
% the upper window MUST be at least one step greater than the lower window
% size.  That is, if the lower window is 3 x 3, then the minimum size of 
% the upper window must be 5 x 5, or one step greater than the lower window.
% This is necessary, since there must be at least two points for a best
% fit line to be formed determining the slope and ultimately the fractal
% dimension.
% 
%  "-s" 15
% specifies the step size or interval used when specifying a range of
% window sizes.  The default value is two, corresponding to the next odd
% window size with a center pixel.  This may be helpful when a wide range 
% of window sizes is required, as it will reduce the number of points 
% generated for the best fit line and hence the number of calculations.
% 
%  "-q" 15
% specifies the range of moments to base the P(m,L) fractal dimension
% calculations on.  This must be an odd number, corresponding to the
% number of moments centered on zero.  For example, a value of 5 would
% result in the computation of the fractal dimension for the range of
% moments, -2, -1, 0, 1, 2.  The default value is 3, resulting in the
% range of -1, 0, 1.
% 
% The input image MUST be of data storage type BYTE or INTEGER.
%
%  
%
%  EXAMPLES
% 
% vpml -i in_img -o1 out_img1 -o2 out_img2 -f1 file1 -u 11 -s 4 -q 5
% this will estimate the fractal dimension of the in_img using a
% range of sliding window sizes from 3 x 3 (default lower value of 3)
% to an upper size of 11 x 11, with a step size of 4.  This means that
% windows of size 3 x 3, 7 x 7, and 11 x 11 will be used in the fractal
% dimension calculation.  A value of 5 was selected for the number of
% moments to be calculated, meaning that the fractal dimension will be
% computed for the range of moments, -2, -1, 0, 1, 2.  The resulting
% output image, out_img1 will consist of a five-band FLOAT image with 
% each band representing the fractal dimension for a particular moment, q.
% The out_img2 will consist of a single row, five-band image specifying 
% the fractal dimension for each class of the input image and moment, q.
% The ASCII file1 will provide the user with information on the size of 
% the input image, number of classes, and the resulting fractal dimensions 
% for each class and moment.
%
%  "SEE ALSO"
% vfractal(1)
%
%  RESTRICTIONS 
% 
% The input image MUST be of data storage type BYTE or INTEGER. 
% The output images are of data storage type FLOAT.
%
%  REFERENCES 
% A reference for the pml algorithm is p. 67 of The Science of Fract.
% Images edited by Hienz-Otto Peitgen and Dietmar Saupe.
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kvpml(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kvpml(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'l', 3;'u', 5;'s', 2;'q', 3;'o1', '__output';'o2', '__output';'f1', '__output'};
maxval={0,10000,10000,10000,1000,0,0,1};
minval={0,3,5,2,3,0,0,1};
istoggle=[0,1,1,1,1,0,0,1];
was_set=istoggle * 0;
paramtype={'InputFile','Integer','Integer','Integer','Integer','OutputFile','OutputFile','OutputFile'};
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
[varargout{:}]=callKhoros([w 'vpml"  '],Inputs,narglist);