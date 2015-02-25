function [ complexUnscaledPressure, Dx ] = load_h101_pressure_file(  )

    file = 'C:\Users\vchaplin\Documents\HiFU\code\h101_3D_unscaled_pressure_REAL.txt';
    fID = fopen(file);
    
    dims = fscanf(fID,'%e %e %e', 3);
    Dx = fscanf(fID,'%e %e %e', 3);
    realdata = fscanf(fID,'%e');
    
    fclose(fID);
    
    file = 'C:\Users\vchaplin\Documents\HiFU\code\h101_3D_unscaled_pressure_IMAG.txt';
    fID = fopen(file);
    
    dims = fscanf(fID,'%e %e %e', 3);
    Dx = fscanf(fID,'%e %e %e', 3);
    imagdata = fscanf(fID,'%e');
    
    fclose(fID);
    
    Dx=Dx';
    
    complexUnscaledPressure = reshape( realdata + 1i*imagdata, dims' );
    
    
end

