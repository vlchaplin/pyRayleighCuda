function [ deltaTseries, axis0_mm, axis1_mm, slice_axis_mm, dyntimes, im ] = GetDeltaTemp4D_PAR( parrec, is_RI_image, maskMagThreshold, angle2tempFactor )
%GetDeltaTemp4D Open the PAR file and compute temperature shift
%   is_RI_image  - 0 if image is in Real and Imaginary parts, 1 if Mag &
%   Phase
%   maskMagThreshold - fraction b/w 0.0 and 1.0.  

    flipSliceDir=0;
    flipSliceAxisLabelDir=1;

    im = vuOpenImage(parrec);

    if flipSliceDir
        im.Data = flip(im.Data,3);
    end

    if is_RI_image
        tempComplex = im.Data(:,:,:,1,:) + 1j*im.Data(:,:,:,2,:);

        im.Data(:,:,:,1,:) = abs(tempComplex);
        im.Data(:,:,:,2,:) = angle(tempComplex);

        clear('tempComplex');
    end
    
    if ~exist('angle2tempFactor','var')
       angle2tempFactor = 1.0 / (42.576*0.01*3.0*0.016*pi);
    end

    slice_thick_col=23;
    slice_gap_col=24;

    pix_dx_col=29;
    dyn_time_col=32;


    dyntimes = im.Parms.tags(1:2*im.Dims(3):im.Dims(5)*im.Dims(3)*2, dyn_time_col);

    [dyntimes,dynamicIdxReorder] = sort(dyntimes);

    %im.Data = im.Data(:,:,:,:,dynamicIdxReorder);
    
    magmeanForMask = mean(im.Data(:,:,:, 1, :),5);
    outsideVox = ( magmeanForMask/ max(magmeanForMask(:)) < maskMagThreshold );
    
    idx1=1;
    nslice = im.Dims(3);
    ndynamics = im.Dims(5);

    slice_axis_mm = zeros([1 nslice]);

    axis0_mm = (1:im.Dims(1))*im.Spc(1);
    axis1_mm = (1:im.Dims(2))*im.Spc(2);

    deltaTseries =  zeros(im.Dims([1,2,3,5]));

    refStack = (im.Data(:,:,:,1,idx1).*exp(1i*im.Data(:,:,:,2,idx1)));

    for dn=2:ndynamics

        complexStack = squeeze( (im.Data(:,:,:,1,dn).*exp(1i*im.Data(:,:,:,2,dn))) );
        deltaTseries(:,:,:,dn) = (1-outsideVox).*angle(refStack.*conj(complexStack)) * angle2tempFactor;
    end

end

