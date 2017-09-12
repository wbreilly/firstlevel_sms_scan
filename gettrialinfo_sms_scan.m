% gettrialinfo_sms_scan
% Walter Reilly
% created 8_22_17 for sms_scan to extract ad create condition names, onsets,
% and durations

path = '/Users/WBR/drive/grad_school/DML_WBR/Sequences_Exp3/sms_scan_drive/sms_scan_fmri_copy/';

for isub = 8
    for irrb = 1:3
        for iblock = 1:3

            load(sprintf('%ss%02d_rrb%d_%d.mat',path,isub,irrb,iblock));

            % cell array of condition names
            names = {'intact', 'scrmabled-fixed', 'scrambled-random'};
            % duration is always 5 TR's 
            durations{1} = 25;
            durations{2} = 25;
            durations{3} = 25;
            
            % now get the onsets
            nreps = 3;
            allrunseq = [];
            for irep = 1:nreps
                allrunseq = [allrunseq;RETRIEVAL(irep).sequence(:,3:4)];
            end % end irep
            

            % identify which order within the run of each condition (ignoring specific
            % sequences for now)
            intact_idx_tmp = [];
            scrambled_idx_tmp = [];
            random_idx_tmp = [];

            for irow = 1:length(allrunseq)
                if strcmp(allrunseq(irow,1), 'intact')
                    intact_idx_tmp = [intact_idx_tmp; irow];
                elseif strcmp(allrunseq(irow,1), 'scrambled')
                    scrambled_idx_tmp = [scrambled_idx_tmp; irow];
                else
                    random_idx_tmp = [random_idx_tmp; irow];
                end % end if
            end % end irow

            % convert the idx's of sequence order into onsets for each condition
            % 7 dummy TR's at beginning so everything is +
            onsets = {};
            onsets_tmp = [];

            % write onsets for each condition
            for icond = 1:length(intact_idx_tmp)
                if intact_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = (intact_idx_tmp(icond)-1) *25 + 8;
                end % end if  
            end % end icond

            onsets{1} = onsets_tmp;
            onsets_tmp = [];

            for icond = 1:length(scrambled_idx_tmp)
                if scrambled_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = (scrambled_idx_tmp(icond)-1) *25 + 8;
                end % end if  
            end % end icond

            onsets{2} = onsets_tmp;
            onsets_tmp = [];

            for icond = 1:length(random_idx_tmp)
                if random_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = (random_idx_tmp(icond)-1) *25 + 8;
                end % end if  
            end % end icond

            onsets{3} = onsets_tmp;    
            
            %where to save condition files
            savepath = '/Users/WBR/walter/fmri/sms_scan_analyses/firstlevel_con_data/';
            
            % save with run naming convention (1-9)
            % dumb way
            
            if irrb == 1
                if iblock == 1;
                    run = 1;
                elseif iblock == 2
                    run = 2;
                else 
                    run = 3;
                end
            elseif irrb == 2
                if iblock == 1;
                    run = 4;
                elseif iblock == 2
                    run = 5;
                else 
                    run = 6;
                end
            else
                if iblock == 1;
                    run = 7;
                elseif iblock == 2
                    run = 8;
                else 
                    run = 9;
                end
            end
            
            % save
            save(sprintf('%sconfile_s%03d_Rifa_%d.mat',savepath,isub,run),'names', 'durations', 'onsets');
            
            clearvars -EXCEPT isub irrb iblock path
            
        end % end iblock
    end % end irrb
end % end isub














