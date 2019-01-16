% estimate first level for each sub

dataDir     = '/Users/wbr/walter/fmri/sms_scan_analyses/data_for_spm/firstlevel_5_3_18';
scriptdir   = '/Users/wbr/walter/fmri/sms_scan_analyses/firstlevel_sms_scan/batch_firstlevel_simplestmodel'; % fileparts(mfilename('fullpath'));

subjects    = {'s001' 's002' 's003' 's004' 's007' 's009' 's010' 's011' 's015' 's016' 's018' 's019' 's020' 's022' 's023' 's024' 's025'}; % 's008'

cd(sprintf('%s', dataDir))

    %--Loop over subjects
for i = 1:length(subjects)
    cd(sprintf('%s', subjects{i}))
    matlabbatch{1}.spm.stats.con.spmmat = cellstr(sprintf('%s/%s/spm.mat', dataDir,subjects{i}));
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'intact';
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1];
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'scrambled';
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 0 0 1];
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'random';
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [0 0 0 0 0 0 1];
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'intact-increasing';
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [0 1];
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'scrambled-increasing';
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 0 1];
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'random-increasing';
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 0 0 0 1];
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'all_fixed';
    matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = [1/2 0 0 1/2];
    matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'all_fixed-increasing';
    matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = [0 1/2 0 0 1/2];
    matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'all_noschema';
    matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = [0 0 0 1/2 0 0 1/2];
    matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'all_noschema-increasing';
    matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = [0 0 0 0 1/2 0 0 1/2 0];
    matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'repl';

    matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'allconds';
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights = [1/3 0 0 1/3 0 0 1/3];
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'allconds-increasing';
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights = [0 1/3 0 0 1/3 0 0 1/3 0];
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'repl';

    matlabbatch{1}.spm.stats.con.delete = 1;
    
    spm('defaults','fmri');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    
    clear matlabbatch
    
    fprintf('\nVectory for %s!!\n', subjects{i})
 
    cd ..
end



% run


