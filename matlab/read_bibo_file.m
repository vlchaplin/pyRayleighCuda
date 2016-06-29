function [ sigV refV dx dy dz ] = read_bibo_file( filename )

%open file read only
fID = fopen(filename);

data_per_step=0;

%find the data block info
line = fgetl(fID);
while( isempty(strfind(line,'#Data')) )
    line = fgetl(fID);
end

data_per_step=fix(sscanf(line, '#Data per Step, %e',1));

%skip two lines
line = fgetl(fID);
line = fgetl(fID);

%read/parse sample grid info
gridstuff=fscanf(fID,'#%*c-Axis,%*e,%e,%d,%*s\n', [2 3]);

dx = gridstuff(1,1);
nxsteps=gridstuff(2,1);

dy = gridstuff(1,2);
nysteps=gridstuff(2,2);

dz = gridstuff(1,3);
nzsteps=gridstuff(2,3);

%allocate storage for the Sig(V) and Ref(V) columns
sigV=zeros(nxsteps,nysteps,nzsteps);
refV=zeros(nxsteps,nysteps,nzsteps);


%skip three lines
fgetl(fID);
fgetl(fID);
fgetl(fID);

totsteps=nxsteps*nysteps*nzsteps;

%read the data table
posidx=0;
while posidx<totsteps
    
    %read sections of the data using fscanf.  fields wtih * are skipped
    %5 quantities are read, in blocks of records = data_per_step (i.e., this many
    %lines are read per loop iteration)
    gridstuff=fscanf(fID,'%*e %e %e %e %e %e %*s %*s %*s %*s %*s %*s %*s %*s\n', [5 data_per_step]);
    posidx=posidx+1;
    
    %convert flat index to 3D-array subscript
    iz = floor( (posidx-1)/(nxsteps*nysteps)) + 1;
    iy = mod( floor((posidx-1)/nxsteps), nysteps) + 1;
    ix = mod( posidx-1 , nxsteps ) + 1;
     
    
    %at the end of each call fscanf() doesn't position fID to the end of record like it does internally
    %within each record block, so call fgetl() to position for the next
    %block read on the next loop.... another thing that makes matlab screwy 
    fgetl(fID);
    
    %store the average of the sigV and refV fields at this position
    sigV(ix,iy,iz) = sum(gridstuff(4,:))/data_per_step;
    refV(ix,iy,iz) = sum(gridstuff(5,:))/data_per_step;
    
end








fclose(fID);



end

