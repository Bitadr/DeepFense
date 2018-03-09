function denoised = image_denoise(images,patch_size,dictionary,K)

ims=images;
shape_original=size(ims);
ims=reshape(ims,size(ims,1),size(ims,2)*size(ims,3));
cols=im2col(ims,patch_size,'distinct');
cols=double(cols);
size(cols)
projected=omp(dictionary'*cols,dictionary'*dictionary,K);
reconst_cols=dictionary*projected;
denoised=col2im(reconst_cols,patch_size,size(ims),'distinct');
%denoised=uint8(denoised);
denoised=reshape(denoised,shape_original);

end
