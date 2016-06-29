function [ coords ] = read_sonalleve_xml( file )

    file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt'
    nlines = countlines(file);
    
    if nlines <= 2 
        return;
    end
    
    nells = (nlines - 2)/3;
    
    fid=fopen(file);
    fgetl(fid);
    
    data=fscanf(fid,'%*s %f %*s\n', [1 nlines-1]);
    
    coords=reshape(data,3,nells);
    
    
    fclose(fid);

end

