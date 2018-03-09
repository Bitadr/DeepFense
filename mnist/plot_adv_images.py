import scipy.io as sio
import os
import matplotlib.pyplot as plt 
import numpy as np
images_in_row=5
images_in_col=5
image_shape=[28,28]


methods=['FGS','Deepfool','CW','BIM-b','JSMA']
for method in methods:
	this_dir=method
	n_iter_dirs=[os.path.join(this_dir,d) for d in os.listdir(this_dir)]
	for niter_d in n_iter_dirs:
		eps_dirs=[os.path.join(niter_d,d) for d in os.listdir(niter_d)]
		for e_d in eps_dirs:
			d=os.path.join(e_d,'perturbed.mat')
			dic=sio.loadmat(d)
			X_pert=dic['perturbed_images']

			inds=np.random.permutation(X_pert.shape[0])
			inds=inds[0:images_in_row*images_in_col]
			images=np.squeeze(X_pert[inds]).reshape([-1]+image_shape)
			for i in range(images_in_row):
				for j in range(images_in_col):
					plt.subplot(images_in_row,images_in_col,i*images_in_col+j+1)
					plt.xticks([])
					plt.yticks([])
					if (i*images_in_col+j)<len(images):
						plt.imshow(images[i*images_in_col+j],cmap='gray')
			plt.savefig(e_d+'/samples')