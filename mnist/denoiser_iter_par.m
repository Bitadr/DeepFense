
patch_size=[7,7];
load('mnist_dicts_7.mat');
for i=1:size(class_dictionaries,1)
    dic=class_dictionaries(i,:,:);
    dic=reshape(dic,size(class_dictionaries,2),size(class_dictionaries,3));
    class_dictionaries(i,:,:)=normc(dic);
end

method='Deepfool'
iters=[2,3,5,10,20,50,100];
epsilons=[1];
K=32;
num_classes=size(class_dictionaries,1)
for eps=epsilons
    all_perturbed={}
    all_missed_to={}
    all_missed_from={}
    all_original={}
    for iter_id=1:length(iters)
        iter=iters(iter_id);
        images_directory=[method,'/',num2str(iter),'iterations/eps',num2str(eps),'/perturbed.mat'];
        load(images_directory);
        all_perturbed{iter_id}=perturbed_images;
        all_missed_to{iter_id}=missed_to;
        all_missed_from{iter_id}=missed_from;
        all_original{iter_id}=original_images;
    end
    parfor iter_id=1:length(iters)
        addpath /home/mohammad/ompbox
        iter=iters(iter_id);
        images_directory=[method,'/',num2str(iter),'iterations/eps',num2str(eps),'/perturbed.mat'];
        %images_directory='original_data/mnist.mat'
        %images_directory='gan_data/mnist.mat'
        %if exist(images_directory)~=2
            %continue
        %end
        %load(images_directory);
        perturbed_images=all_perturbed{iter_id};
        missed_to=all_missed_to{iter_id};
        missed_from=all_missed_from{iter_id};
        original_images=all_original{iter_id};

        perturbed_images=double(perturbed_images)/max(max(max(perturbed_images)));
        denoised_images=zeros(size(perturbed_images));
        for i=1:num_classes
            inds=find(missed_to==i-1);
            if length(inds)==0
                continue;
            end
            images=perturbed_images(inds,:);
            images=reshape(images,size(images,1),28,28);
            images=permute(images,[3,2,1]);
            dic=class_dictionaries(i,:,:);
            dic=reshape(dic,size(dic,2),size(dic,3));
            denoised=image_denoise(images,patch_size,dic,K);
            denoised=permute(denoised,[3,2,1]);
            denoised=reshape(denoised,size(denoised,1),784);
            denoised_images(inds,:)=denoised;
        end
        %dif=denoised_images-perturbed_images;
        %dif=abs(dif);
        %dif=mean(sum(sum(dif,3),2))
        images_directory=[method,'/',num2str(iter),'iterations/eps',num2str(eps),'/denoised',num2str(K),'.mat'];
        %images_directory=['original_data','/denoised',num2str(K),'.mat']
        %images_directory=['gan_data','/denoised',num2str(K),'.mat']
        parsave(images_directory,denoised_images,original_images,missed_from,missed_to)
    end
end
