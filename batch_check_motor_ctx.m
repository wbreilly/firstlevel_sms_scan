% second level batch
% use the individual betas at subject level to compute group betas for each
% regressor. Then, in results viewer, compute contrasts betweeen group
% betas

clear all
clc

% subjects    = {'s001' 's002' 's003' 's004' 's007' 's009' 's010' 's011' 's015' 's016' 's018' 's019' 's020' 's022' 's023' 's024' 's025'};% 's008'

right_hand = {'s001' 's003' 's007' 's009' 's011' 's015' 's019' 's023' 's025'};
left_hand = {'s002' 's004' 's010' 's016' 's018' 's020' 's022' 's024'};
analysis = {'right_hand' 'left_hand'};
cond_idxs = [1, 2, 3];


for ittest = 1:2
    
    conDir     = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/second_level/group_contrasts/%snoIM', analysis{ittest});
    mkdir(conDir)
%     cd(conDir)
    
    % select subs based on hand counterbalancing
    if ittest == 1
        subjects = right_hand;
    else
        subjects = left_hand;
    end
    
    % select the appropriate con image for every subject
    scans = {};
    for isub = 1:length(subjects)
       scans{isub,1} = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/%s/con_0002.nii', subjects{isub});
    end

%%
    matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(conDir);
    matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = cellstr(scans);
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

%%

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

