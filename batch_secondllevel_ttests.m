% second level batch
% use the individual betas at subject level to compute group betas for each
% regressor. Then, in results viewer, compute contrasts betweeen group
% betas

clear all
clc

subjects    = {'s001' 's002' 's003' 's004' 's007' 's009' 's010' 's011' 's015' 's016' 's018' 's019' 's020' 's022' 's023' 's024' 's025'}; %'s008'

conds = {'intact' 'scrambled' 'random' 'intact_increasing' 'scrambled_increasing' 'random_increasing' 'all_fixed' 'all_fixed-increasing' 'all_noschema' 'all_noschema-increasing'};
% all combos of conditions
cond_pairs = nchoosek(1:6,2);
cond_pairs = [cond_pairs; 7 3; 8 6; 1 9; 4 10];


for ittest = 1:length(cond_pairs)

    contrast = strcat(conds{cond_pairs(ittest,1)}, '_',conds{cond_pairs(ittest,2)});
    % The hell does noIM mean?? 
    conDir     = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/second_level/group_contrasts_noIM/%s', contrast);
    mkdir(conDir)
%     cd(conDir)
    
    % select the appropriate spmTs for every subject
    for isub = 1:length(subjects)
       scans = {};
       scans{1,1} = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/%s/con_00%02d.nii', subjects{isub},cond_pairs(ittest,1));
       scans{2,1} = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/%s/con_00%02d.nii', subjects{isub},cond_pairs(ittest,2));  
       matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(isub).scans = cellstr(scans);
    end
    % where to put the spm.mat for each ttest
    matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(conDir);
  
    matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;


    % run
    spm('defaults','fmri');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);

    % estimate
    clear matlabbatch
    spmfile = fullfile(conDir, 'spm.mat');
    matlabbatch{1}.spm.stats.fmri_est.spmmat = cellstr(spmfile);
    matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
    % run
    spm('defaults','fmri');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    
    clear matlabbatch

end %icon

