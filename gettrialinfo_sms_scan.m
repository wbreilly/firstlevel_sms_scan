% gettrialinfo_sms_scan
% Walter Reilly
% created 8_22_17 for sms_scan to extract ad create condition names, onsets,
% and durations

path = '/Users/WBR/drive/grad_school/DML_WBR/Sequences_Exp3/sms_scan_drive/sms_scan_fmri_copy/';

for isub = 1:4;
    for irrb = 1:3
        for iblock = 1:3

            load(sprintf('%ss%02d_rrb%d_%d.mat',path,isub,irrb,iblock));

            % cell array of condition names
            names = {'intact', 'scrmabled-fixed', 'scrambled-random'};
            % duration is always 5 TR's 
            durations = {'5','5','5'};

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
                    onsets_tmp(1,icond) = intact_idx_tmp(icond) *5 + 3;
                end % end if  
            end % end icond

            onsets{1} = onsets_tmp;
            onsets_tmp = [];

            for icond = 1:length(scrambled_idx_tmp)
                if scrambled_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = scrambled_idx_tmp(icond) *5 + 3;
                end % end if  
            end % end icond

            onsets{2} = onsets_tmp;
            onsets_tmp = [];

            for icond = 1:length(random_idx_tmp)
                if random_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = random_idx_tmp(icond) *5 + 3;
                end % end if  
            end % end icond

            onsets{3} = onsets_tmp;    

            savepath = '/Users/WBR/walter/fmri/sms_scan_analyses/firstlevel_data/';
            save(sprintf('%sfirstlevel_s%02d_rrb%d_%d.mat',savepath,isub,irrb,iblock),'names', 'durations', 'onsets');
            
            clearvars -EXCEPT isub irrb iblock path
            
        end % end iblock
    end % end irrb
end % end isub







