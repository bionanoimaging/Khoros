%kkstats 'Compute Statistics of Data Object'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros kstats.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'Input object'
% InputFile: igate 'Gating Input', optional: 'Gating input data object'
% OutputFile: f 'ASCII Output ', optional: 'Formatted ASCII output file'
% OutputFile: o 'Binary Output', optional: 'Binary output statistics file'
% Toggle: whole 'Whole Data Set', default: 0: 'compute single set of statistics for entire data set'
% Toggle: w 'Width ', default: 0: 'include width in processing unit'
% Toggle: h 'Height ', default: 0: 'include height in processing unit'
% Toggle: d 'Depth ', default: 0: 'include depth in processing unit'
% Toggle: t 'Time ', default: 0: 'include time in processing unit'
% Toggle: e 'Element', default: 0: 'include elements in processing unit'
% Toggle: all 'Calculate ALL Statistics', default: 0: 'compute and store all statistics information'
% Toggle: mean 'mean', default: 0: 'compute mean'
% Toggle: sum 'total integral', default: 0: 'compute total integral'
% Toggle: var 'variance', default: 0: 'compute variance'
% Toggle: wmin 'width coordinate', default: 0: 'store width coordinate of the minimum value'
% Toggle: psum 'pos part of integral', default: 0: 'compute positive part of integral'
% Toggle: sd 'std deviation', default: 0: 'compute standard deviation'
% Toggle: hmin 'height coordinate', default: 0: 'store height coordinate of the minimum value'
% Toggle: nsum 'neg part of integral', default: 0: 'compute negative part of integral'
% Toggle: rms 'rms', default: 0: 'compute root mean square'
% Toggle: dmin 'depth coordinate', default: 0: 'store depth coordinate of the minimum value'
% Toggle: pts 'total contributing pts', default: 0: 'compute total number of contributing points'
% Toggle: skew 'skewness', default: 0: 'compute skewness'
% Toggle: tmin 'time coordinate', default: 0: 'store time coordinate of the minimum value'
% Toggle: ppts 'positive points', default: 0: 'compute number of positive contributing points'
% Toggle: kur 'kurtosis', default: 0: 'compute kurtosis'
% Toggle: emin 'elements coordinate', default: 0: 'store elements coordinate of the minimum value'
% Toggle: npts 'negative points', default: 0: 'compute number of negative contributing points'
% Toggle: minval 'minimum', default: 0: 'compute minimum value'
% Toggle: zpts 'zero points', default: 0: 'compute number of zero-valued contributing pts'
% Toggle: maxval 'maximum', default: 0: 'compute maximum value'
% Toggle: wmax 'width coordinate', default: 0: 'store width coordinate of the maximum value'
% Toggle: wsize 'data width', default: 0: 'store size of objects width dimension'
% Toggle: hmax 'height coordinate', default: 0: 'store height coordinate of the maximum value'
% Toggle: hsize 'data height', default: 0: 'store size of objects height dimension'
% Toggle: dmax 'depth coordinate', default: 0: 'store depth coordinate of the maximum value'
% Toggle: dsize 'data depth', default: 0: 'store size of objects depth dimension'
% Toggle: tmax 'time coordinate', default: 0: 'store time coordinate of the maximum value'
% Toggle: tsize 'time size', default: 0: 'store size of objects time dimension'
% Toggle: emax 'elements coordinate', default: 0: 'store elements coordinate of the maximum value'
% Toggle: esize 'elements size', default: 0: 'store size of objects elements dimension'
%
% Example: [f, o] = kkstats({i, igate}, {'i','';'igate','';'f','';'o','';'whole',0;'w',0;'h',0;'d',0;'t',0;'e',0;'all',0;'mean',0;'sum',0;'var',0;'wmin',0;'psum',0;'sd',0;'hmin',0;'nsum',0;'rms',0;'dmin',0;'pts',0;'skew',0;'tmin',0;'ppts',0;'kur',0;'emin',0;'npts',0;'minval',0;'zpts',0;'maxval',0;'wmax',0;'wsize',0;'hmax',0;'hsize',0;'dmax',0;'dsize',0;'tmax',0;'tsize',0;'emax',0;'esize',0})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% kstats - Compute Statistics of Data Object
%
%  DESCRIPTION
% .I kstats 
% computes the mean, variance, standard deviation, RMS level, skew, kurtosis, 
% minimum value, maximum value, and integral (positive, negative, and total 
% sums) of the Input data object (i).  Information such as the number of 
% unmasked or ungated points (positive, negative, zero-valued, and total counts), 
% the coordinates of the minimum and maximum values, and the dimensions of the 
% data object are also provided. 
% .so $DATAMANIP/repos/shared/man/sections/mask_stats
% .so $DATAMANIP/repos/shared/man/sections/map_force
% All statistics and information will reflect the mapping.  For example,
% if the dimensions of the data are requested (wsize, hsize, etc), kstats
% returns the dimensionality after mapping.  
% .cI $DATAMANIP/repos/shared/man/sections/fail_1input
% All statistics are calculated as double, and the Binary Output data type 
% is double.
% 
% Location and time data do not affect the statistics calculations, and are
% not transferred to the output object.
% 
% A flag can be set for each statistic and information option so that a 
% subset of all available options can be calculated and stored or printed.  
% The flags are mutually exclusive with the "Calculate All Statistics"
% flag (all).  (The command line flag names are: mean, var, sd, rms, skew, 
% kur, minval, maxval, wmin, hmin, dmin, tmin, emin, wmax, hmax, dmax, tmax, 
% emax, sum, psum, nsum, pts, ppts, npts, zpts, wsize, hsize, dsize, tsize, 
% and esize.) If no flag is specified when running kstats from the command 
% line, all statistics and information will be stored.
% 
% Statistics are computed according to the equations given below.  In the 
% equations, N is the number of samples, SUM is the sum from i=0 to i=N-1, 
% and x(i) is the sample value of x at i.
% 
%  "Mean (-mean)"
% mean = (1/N) * SUM(x(i))  i=0..N-1
% 
%  "Variance (-var)"
% variance = (1/(N-1)) * (SUM (x(i) - mean)**2)  i=0..N-1
% 
%  "Standard Deviation (-sd)"
% standard deviation = sqrt(variance)
% 
%  "RMS (-rms)"
% RMS  = sqrt(1/N * SUM(x(i)**2))  i=0..N-1
% 
%  "Skewness (-skew)"
% Skewness is a measure of the tendency of the deviations from the mean to be
% larger in one direction than in the other.  It is a measure of the asymmetry 
% of a distribution about its mean.  A positive skew value signifies a 
% distribution whose tail extends out towards more positive x, and a negative 
% tail signifies a distribution whose tail extends out towards more negative x.
% Population skewness is unitless and is defined as:
% E[((x-mean)/(stddev))**3],
% where stddev is the standard deviation of the data.
% .I kstats
% computes the sample skewness as:
% skew = 1/N * SUM( ((x(i) - mean)/stddev) **3 )  i=0..N-1
% If the variance is equal to zero, skewness will be set to 0.0.
% 
%  "Kurtosis"
% Kurtosis is a unitless measure of the tail heaviness of a distribution
% and is defined as:
% E[((x-mean)/(stddev))^4] - 3,
% where stddev is the standard deviation of the data.
% .I kstats
% computes the sample kurtosis as:
% kurtosis= (1/N * SUM( ((x(i) - mean)/stddev) **4)) - 3  i=0..N-1
% If the variance is equal to zero, kurtosis will be set to 0.0.
% 
%  "Sums or Integrals (-sum, -psum, -nsum)"
% total integral = SUM x(i)
% positive part of integral = SUM x(i),  for all x(i) > 0
% negative part of integral = SUM x(i),  for all x(i) < 0
% 
%  "Define Processing Unit"
% To support analysis of subregions within the data object, such as lines, 
% planes, volumes, and vectors, an option for defining processing units, or 
% regions, is provided.  These regions are defined by the settings of the 
% Processing Unit options, which can be either the Whole Data Set (whole), 
% or any combination of Width (w), Height (h), Depth (d), Time (t), and 
% Elements (e).  Statistics for each region will be computed and printed 
% separately. If none of these flags are supplied, then a single set of 
% statistics will be computed for the entire data object.  
% 
%  "Gating Input"
% .so $DATAMANIP/repos/shared/man/sections/gate_simple
% 
%  "ASCII Output"
% The "ASCII Output" (f) option allows the user to specify a device or file 
% for printing the specified information in formatted ASCII.  A filename
% of # will send the output to stderr.  If neither an "ASCII Output"
% or a "Binary Output" is supplied, the formatted ASCII will automatically
% go to stdout.
% 
%  "Binary Output"
% If the "Binary Output" (-o) is selected, the selected statistics and 
% information are stored in as double float data in the given file.  
% Each statistic is stored as an element of a N-D vector defined along the 
% "elements" dimension of the output object.  N is the number of statistics 
% and information specified by the user.  The order in which the information
% is stored in the statistics vector is given in the output object's comment 
% attribute.
% When M sets of statistics are calculated for M multiple regions of the 
% input data object (see discussion on independent region analysis above),
% the statistics vectors are incremented along the width dimension of the 
% output statistics object - the output object would have a resulting 
% dimensionality of width=M, elements=N (height = depth = time = 1).  For 
% example, if the input data object had the dimensionality width = 256, 
% height = 256, elements = 7 (depth = time = 1), and the user defined the 
% analysis regions to be width-height, the output statistics object would 
% have dimensionality width = 7, elements = N (height = depth = time = 1).  
% Where the vector at w=0 would contain information pertaining to the first 
% region (starting at w=0, h=0, d=0, t=0, e=0), the vector at w=1 would 
% contain information about the second region (starting at w=0, h=0, d=0, t=0, 
% e=1), and so forth.
%
%  
%
%  EXAMPLES
% kstats -i object.xv -f ascii -all
% 
% Will create an ASCII statitics file.  Since the -region option is not specified,
% kstats defaults to calculating statistical information for the object
% as a whole.
% kstats -i object.xv -f ascii_file -region -e
% 
% Will create an ASCII statistics file. The statistical information is now 
% calculated by slicing the object along the element dimension. For example,
% on a 3-band RGB color image, this would compute the statistics for each
% RGB vector.
%
%  "SEE ALSO"
%
%  RESTRICTIONS 
% kstats cannot compute complex statistics at this time.  If you wish to 
% process the real and imaginary components of a complex data set 
% independently, first separate components using kcmplx2real.
% 
% In the current implementation, the statistics are accumulated.  This 
% can result in overflow.  kstats will be rewritten in the future 
% to better handle large values and large data sets.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkstats(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkstats(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'igate', '__input';'f', '__output';'o', '__output';'whole', 0;'w', 0;'h', 0;'d', 0;'t', 0;'e', 0;'all', 0;'mean', 0;'sum', 0;'var', 0;'wmin', 0;'psum', 0;'sd', 0;'hmin', 0;'nsum', 0;'rms', 0;'dmin', 0;'pts', 0;'skew', 0;'tmin', 0;'ppts', 0;'kur', 0;'emin', 0;'npts', 0;'minval', 0;'zpts', 0;'maxval', 0;'wmax', 0;'wsize', 0;'hmax', 0;'hsize', 0;'dmax', 0;'dsize', 0;'tmax', 0;'tsize', 0;'emax', 0;'esize', 0};
maxval={0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','InputFile','OutputFile','OutputFile','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle'};
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
[varargout{:}]=callKhoros([w 'kstats"  '],Inputs,narglist);
