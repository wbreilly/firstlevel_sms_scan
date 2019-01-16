% second level batch
% Use group single condition betas to compute 

clear all
clc

subj_betas = {'intact' 'scrambled' 'random' 'intact_increasing' 'scrambled_increasing' 'random_increasing'};
subjects    = {'s001' 's002' 's003' 's004' 's007' 's008' 's009' 's010' 's011' 's015' 's016' 's018' 's019' 's020' 's022' 's023' 's024' 's025'};

for ibeta = 6

    
    conDir     = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/second_level/contrasts/%s', subj_betas{ibeta});
    mkdir(conDir)
    cd(conDir)
    

    matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(conDir);
    scans = {};
    for i = 1:length(subjects)
       scans{i,1} = sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18/%s/con_000%d.nii,1', subjects{i},ibeta);
    end
    matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = cellstr(scans);
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
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

end %ibeta