function [ Tmom, Tfsd, Tprep, Tsom ] = Calc_Philips_Tmom( sliceOrientation, prepDir, fatShiftDir )
% [ Tmom, Tfsd, Tprep, Tsom ] = Calc_Philips_Tmom( sliceOrientation, prepDir, fatShiftDir )
%   Tmom = Tsom*Tprep*Tfsd.  Converts MPS -> L'P'H'
%   Tsom  converts NWV -> L'P'H'
%   Use Calc_Philips_Tang to get L'P'H' -> LPH


%From Philips PlanScan Geometry

%NWV - left-handed visualization coordinates
%LPH - patient coordinates (right handed, isocenter orgin)
%L'P'H' - angulated patient coordinates (right handed, isocenter orgin)
%MPS - [Readout, preparation, slice]  coordinates (right handed, isocenter orgin)

% convert slice to integer value if necessary (probably not)
if strcmpi( sliceOrientation, 'Transverse' ) 
    sliceOrientation=1;
elseif strcmpi( sliceOrientation, 'Sagittal' )
    sliceOrientation=2;
elseif strcmpi( sliceOrientation, 'Coronal' )
    sliceOrientation=3;
end

% convert to short name
if strcmpi( prepDir, 'Anterior-Posterior' ) 
    prepDir='AP';
elseif strcmpi( prepDir, 'Posterior-Anterior' )
    prepDir='PA';
elseif strcmpi( prepDir, 'Right-Left' )
    prepDir='RL';
elseif strcmpi( prepDir, 'Left-Right' )
    prepDir='LR';
elseif strcmpi( prepDir, 'Feet-Head'  )
    prepDir='FH';
elseif strcmpi( prepDir, 'Head-Feet' )
    prepDir='HF';
end

%direction name to index map
nm=containers.Map( ...
{'AP', 'PA', 'FH', 'HF', 'RL', 'LR', 'A', 'P', 'F', 'H', 'R', 'L'}, ... 
[   1,    1,    2,    2,    3,    3,   1,   2,   3,   4,   5,  6] );

%% define lookup table for fat shift direction

% the MPS --> pM,pP,pS conversion depends on all three directions
% (slicedir, prepdir, fat-shift dir), so make it a 3-d array
% First dim will correspond to the slice orientation, second to the preparation dir,
% third to the fat shift dir.
pPMSPossibleFlipTable=zeros([3,3,6]);

% Arbitrarily define integer flags to represent the MPS->pMPS flip axis
p=1; m=2; s=3;

% Transverse slices
pPMSPossibleFlipTablep(1, nm('RL'), [nm('R') nm('L') nm('F') nm('H') nm('A') nm('P')]) = [p m m s m p];
pPMSPossibleFlipTablep(1, nm('AP'), [nm('R') nm('L') nm('F') nm('H') nm('A') nm('P')]) = [m p m s m p];
% Sagital slices
pPMSPossibleFlipTablep(2, nm('FH'), [nm('R') nm('L') nm('F') nm('H') nm('A') nm('P')]) = [s m p m m p];
pPMSPossibleFlipTablep(2, nm('AP'), [nm('R') nm('L') nm('F') nm('H') nm('A') nm('P')]) = [s m p m p m];
% Coronal slices
pPMSPossibleFlipTablep(3, nm('FH'), [nm('R') nm('L') nm('F') nm('H') nm('A') nm('P')]) = [m p p m m s];
pPMSPossibleFlipTablep(3, nm('RL'), [nm('R') nm('L') nm('F') nm('H') nm('A') nm('P')]) = [p m p m m s];


%% Now determine Tfsd by geting the actual flip direection value for our input scan parameters
flipAx = pPMSPossibleFlipTablep(sliceOrientation, nm(prepDir), nm(fatShiftDir));

Tfsd = eye(3);
if flipAx == m
    Tfsd(1,1) = -1;
elseif flipAx == p
    Tfsd(2,2) = -1;
elseif flipAx == s
    Tfsd(3,3) = -1;
end

%% Calc Tsom and Tprep

para = 1; %parallel
perp = 2; %perpendicular

tprepDirs = zeros(3,3);


tprepDirs(1,[nm('FH') nm('AP') nm('RL')]) = [0 perp para];
tprepDirs(2,[nm('FH') nm('AP') nm('RL')]) = [perp para 0];
tprepDirs(3,[nm('FH') nm('AP') nm('RL')]) = [perp 0 para];

perpendicularTprep = tprepDirs(sliceOrientation, nm(prepDir));

% Tprep
if perpendicularTprep==perp
    %If W is perpindicular to P
    Tprep = [ [0 -1 0]; [1 0 0]; [0 0 1]; ];
elseif perpendicularTprep==para
    %If W is parallel to P 
    Tprep = [ [1 0 0]; [0 1 0]; [0 0 1]; ];
else     
    disp('Invalid slice orientation+preparation direction')
end

%Tsom converts (N,W,V) to (L',P',H')
if sliceOrientation == 1              %%% Transversal
    
    Tsom = [ [ 0 -1  0];
             [-1  0  0]; 
             [ 0  0  1]; ] ;
         
%      if strcmpi( prepDir, 'AP' ) || strcmpi( prepDir, 'PA' )
%          perpendicularTprep = 1;
%      elseif strcmpi( prepDir, 'RL' ) || strcmpi( prepDir, 'LR' )
%          perpendicularTprep = 0;
%      else
%          print('Invalid slice orientation+preparation direction')
%      end
         
elseif  sliceOrientation == 2         %%% Sagittal
    
    Tsom = [ [0 0 -1];
             [0 -1 0]; 
             [1 0  0]; ];
         
%     if strcmpi( prepDir, 'AP' ) || strcmpi( prepDir, 'PA' )
%          perpendicularTprep = 0;
%      elseif strcmpi( prepDir, 'FH' ) || strcmpi( prepDir, 'HF' )
%          perpendicularTprep = 1;
%      else
%          print('Invalid slice orientation+preparation direction')
%      end
         
elseif  sliceOrientation == 3        %%%% Coronal
    
    Tsom = [ [0 -1 0];
             [0 0 1]; 
             [1 0 0]; ];
         
%     if strcmpi( prepDir, 'RL' ) || strcmpi( prepDir, 'LR' )
%          perpendicularTprep = 0;
%      elseif strcmpi( prepDir, 'FH' ) || strcmpi( prepDir, 'HF' )
%          perpendicularTprep = 1;
%      else
%          print('Invalid slice orientation+preparation direction')
%      end
end

Tmom = Tsom*Tprep*Tfsd;


