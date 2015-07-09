dir = 'C:\Users\Vandiver\Data\sonalleve\polya_20150526';


t2file = [dir,'\Chaplin_99999_WIP_T2W_TSE_CLEAR_22_1.PAR'];

Tfile = [dir,'\Chaplin_99999_WIP_TemperatureMapping_CLEAR_8_1.PAR'];

T2im = vuOpenImage(t2file);

TempIm = vuOpenImage(Tfile);


complexImStack = squeeze( (TempIm.Data(:,:,:,1,:).*exp(1i*TempIm.Data(:,:,:,2,:)))  );

deltaTstack = angle(repmat(complexImStack(:,:,:,1), [1 1 1 60]) .* conj( complexImStack )) / (42.576*0.01*3.0*0.016*pi);



t2im = flip( permute(T2im.Data, [1 3 2]), 2);

deltaTmeta = vuGenerateMetaImage(TempIm.Data(:,:,:,1,2), TempIm.Spc, TempIm.Origin );
T2meta = vuGenerateMetaImage(double(t2im), T2im.Spc([1 3 2]), T2im.Origin([1 3 2]) );

%%

%T2meta.Data = double(T2meta.Data);
%deltaTmeta.Data = squeeze(deltaTstack(:,:,:,1));

[reg_im, reg_strct] = vuRigidRegistration(  deltaTmeta, T2meta );


%%
figure(4)
colormap('gray');
subplot(121);
%imagesc(squeeze( deltaTstack(:,:,1,10) ));
%imagesc(squeeze( TempIm.Data(:,:,3,1,50) ));
%imagesc( squeeze(reg_im.Data(:,:,2) ) );
colorbar();
axis equal tight;
subplot(122);

imagesc( squeeze( T2im.Data(:,194,:) ));

figure(5);
colormap('gray');
imagesc( squeeze( t2im(:,:,194) ));

%imagesc(squeeze( t2im(:,19,:)+1 ));
