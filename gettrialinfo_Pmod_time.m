% gettrialinfo_sms_scan
% Walter Reilly
% created 5_6_18 for sms_scan to extract and create condition names, onsets,
% and durations, and PMODS for time at sequence level

clear all
clc

path = '/Users/WBR/drive/grad_school/DML_WBR/Sequences_Exp3/sms_scan_drive/sms_scan_fmri_copy/';

for isub =  [1 2 3 4 7 8 9 10 11 15 16 18 19 20 22 23 24 25 ]; % this is dumb. Just use strrep to get raw number
    for irrb = 1:3
        for iblock = 1:3

            load(sprintf('%ss%02d_rrb%d_%d.mat',path,isub,irrb,iblock));

            % cell array of condition names
            names = {'intact', 'scrambled', 'random'};
            % Long boxcar for each sequence?? 
            durations{1} = 0;
            durations{2} = 0;
            durations{3} = 0;
            
            %%
            % time modulation at sequence level, increasing
            % n mod is for condition number
            pmod = struct('name',{''},'param',{},'poly',{});
            % mod values for every trial in the intact and scarambled
            % conditions
            x =  repmat([1:5]',1,6);
            y=x(:)';
            for nmod = 1:2
                pmod(nmod).name{1} = sprintf('time_increasing_%s',names{nmod});
                pmod(nmod).param{1} = y;
                pmod(nmod).poly{1} = 1;
            end
            
            % for random
            x =  repmat([1:5]',1,3);
            y=x(:)';
            for nmod = 3
                pmod(nmod).name{1} = sprintf('time_increasing_%s',names{nmod});
                pmod(nmod).param{1} = y;
                pmod(nmod).poly{1} = 1;
            end
            
            %decreasing, for intact and scrambled
            x =  repmat([5 4 3 2 1]',1,6);
            y=x(:)';
            for nmod = 1:2
                pmod(nmod).name{2} = sprintf('time_decreasing_%s',names{nmod});
                pmod(nmod).param{2} = y;
                pmod(nmod).poly{2} = 1;
            end
            
            %decreasing, for random
            x =  repmat([5 4 3 2 1]',1,3);
            y=x(:)';
            for nmod = 3
                pmod(nmod).name{2} = sprintf('time_decreasing_%s',names{nmod});
                pmod(nmod).param{2} = y;
                pmod(nmod).poly{2} = 1;
            end
            
%%
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

            % write sequence onsets for each condition
            for icond = 1:length(intact_idx_tmp)
                if intact_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = (intact_idx_tmp(icond)-1) *25 + 8;
                end % end if  
            end % end icond

            % convert item sequence onsets to item onsets
            % jank
            onsets_tmp2 = [];
            for ionset = 1:length(onsets_tmp)
                onsets_tmp2 = [onsets_tmp2 onsets_tmp(ionset) onsets_tmp(ionset)+5 onsets_tmp(ionset)+10 onsets_tmp(ionset)+15 onsets_tmp(ionset)+20];
            end
            
            % finally put the onsets in the right place
            onsets{1} = onsets_tmp2;
            onsets_tmp = [];

            for icond = 1:length(scrambled_idx_tmp)
                if scrambled_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = (scrambled_idx_tmp(icond)-1) *25 + 8;
                end % end if  
            end % end icond
            
            % convert item sequence onsets to item onsets
            % jank
            onsets_tmp2 = [];
            for ionset = 1:length(onsets_tmp)
                onsets_tmp2 = [onsets_tmp2 onsets_tmp(ionset) onsets_tmp(ionset)+5 onsets_tmp(ionset)+10 onsets_tmp(ionset)+15 onsets_tmp(ionset)+20];
            end

            onsets{2} = onsets_tmp2;
            onsets_tmp = [];

            for icond = 1:length(random_idx_tmp)
                if random_idx_tmp(icond) == 1
                    onsets_tmp(1,icond) = 8;
                else
                    onsets_tmp(1,icond) = (random_idx_tmp(icond)-1) *25 + 8;
                end % end if  
            end % end icond
            
            % convert item sequence onsets to item onsets
            % jank
            onsets_tmp2 = [];
            for ionset = 1:length(onsets_tmp)
                onsets_tmp2 = [onsets_tmp2 onsets_tmp(ionset) onsets_tmp(ionset)+5 onsets_tmp(ionset)+10 onsets_tmp(ionset)+15 onsets_tmp(ionset)+20];
            end

            onsets{3} = onsets_tmp2;   
            
            
            %where to save condition files
            savepath = '/Users/wbr/walter/fmri/sms_scan_analyses/firstlevel_sms_scan/batch_firstlevel_simplestmodel/con_mats_Pmod_5_6_18/';
            
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
            save(sprintf('%sconfile_s%03d_Rifa_%d.mat',savepath,isub,run),'names', 'durations', 'onsets', 'pmod');
            
            clearvars -EXCEPT isub irrb iblock path
            
        end % end iblock
    end % end irrb
end % end isub














