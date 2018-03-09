function [] = parsave(fname,denoised_images,original_images,missed_from,missed_to)
save(fname,'denoised_images','original_images','missed_from','missed_to');
end
