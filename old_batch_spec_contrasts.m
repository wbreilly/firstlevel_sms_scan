% estimate first level for each sub

dataDir     = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_9_12_17_spike_noderiv';
scriptdir   = '/Users/wbr/walter/fmri/sms_scan_analyses/firstlevel_sms_scan/batch_firstlevel_simplestmodel'; % fileparts(mfilename('fullpath'));

subjects    = {'s001' 's002' 's003' 's004' 's007' 's008' 's009' 's010' 's011' 's015' 's016' 's018' 's019' };

cd(sprintf('%s', dataDir))

    %--Loop over subjects
for i = 1:length(subjects)
    cd(sprintf('%s', subjects{i}))
   
    
    
    matlabbatch{i}.spm.stats.con.spmmat = cellstr(sprintf('/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_9_12_17_spike_noderiv/%s/spm.mat', subjects{i}));
    matlabbatch{i}.spm.stats.con.consess{1}.tcon.name = 'i > s-f';
    matlabbatch{i}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
    matlabbatch{i}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{2}.tcon.name = 's-f > i';
    matlabbatch{i}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
    matlabbatch{i}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{3}.tcon.name = 'i > s-r';
    matlabbatch{i}.spm.stats.con.consess{3}.tcon.weights = [1 0 -1];
    matlabbatch{i}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{4}.tcon.name = 's-r > i';
    matlabbatch{i}.spm.stats.con.consess{4}.tcon.weights = [-1 0 1];
    matlabbatch{i}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{5}.tcon.name = 'i > s-f & s-r';
    matlabbatch{i}.spm.stats.con.consess{5}.tcon.weights = [1 -1/2 -1/2];
    matlabbatch{i}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{6}.tcon.name = ' s-f & s-r > i';
    matlabbatch{i}.spm.stats.con.consess{6}.tcon.weights = [-1 1/2 1/2];
    matlabbatch{i}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{7}.tcon.name = ' s-r > i & s-f ';
    matlabbatch{i}.spm.stats.con.consess{7}.tcon.weights = [-1/2 -1/2 1];
    matlabbatch{i}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{8}.tcon.name = 'i & s-f > s-r';
    matlabbatch{i}.spm.stats.con.consess{8}.tcon.weights = [1/2 1/2 -1];
    matlabbatch{i}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.consess{9}.tcon.name = 's-f > s-r';
    matlabbatch{i}.spm.stats.con.consess{9}.tcon.weights = [0 1 -1];
    matlabbatch{i}.spm.stats.con.consess{9}.tcon.sessrep = 'repl';
    matlabbatch{i}.spm.stats.con.delete = 1;
    
 
    cd ..
end

% run
spm('defaults','fmri');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);

