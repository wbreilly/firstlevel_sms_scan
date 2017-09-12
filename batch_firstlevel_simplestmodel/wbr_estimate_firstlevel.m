% estimate first level for each sub

dataDir     = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_9_12_17_spikeregs';
scriptdir   = '/Users/wbr/walter/fmri/sms_scan_analyses/firstlevel_sms_scan/batch_firstlevel_simplestmodel'; % fileparts(mfilename('fullpath'));

subjects    = {'s001' 's002' 's003' 's004' 's007' 's008'};

cd(sprintf('%s', dataDir))

    %--Loop over subjects
for i = 1:length(subjects)
    cd(sprintf('%s', subjects{i}))
    matlabbatch{i}.spm.stats.fmri_est.spmmat = cellstr(sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_9_12_17_spikeregs/%s/spm.mat', subjects{i}));
    matlabbatch{i}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{i}.spm.stats.fmri_est.method.Classical = 1;
 
    cd ..
end

% run
spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

