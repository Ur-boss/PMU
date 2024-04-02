%%

function error_frame(CMD, data_raw)
    global SADF CFG_1 CFG_2_3 HDR DATA
    disp('---------------------------->Successfully run : IEEE_C37_118_2 -- error_frame<-------------');
    switch CMD
        case 1
            msg='IEEE C37.118.2 DATA, corrupted';
            DATA.counter_error = DATA.counter_error + 1;
            if SADF.verbose_debug
                DATA.RAW_data_error(1:length(data_raw), DATA.counter_error) = data_raw;
            end
        case 1.1
            msg='IEEE C37.118.2 DATA, discarded - IDCODE does not match';
            DATA.counter_discarded = DATA.counter_discarded + 1;
            if SADF.verbose_debug
                DATA.RAW_data_error(1:length(data_raw), DATA.counter_discarded) = data_raw;
            end
        case 1.2
            msg='IEEE C37.118.2 DATA, discarded - waiting for CFG-2 or CFG-3';
            DATA.counter_discarded = DATA.counter_discarded + 1;
            if SADF.verbose_debug
                DATA.RAW_data_discarded(1:length(data_raw), DATA.counter_discarded) = data_raw;
            end
        case 1.3
            msg='IEEE C37.118.2 DATA, discarded - waiting for CFG-2 or CFG-3 and IDCODE does not match';
            DATA.counter_discarded = DATA.counter_discarded + 1;
            if SADF.verbose_debug
                DATA.RAW_data_discarded(1:length(data_raw), DATA.counter_discarded) = data_raw;
            end
        case 2
            msg='IEEE C37.118.2 HDR, corrupted';
            HDR.counter_error = HDR.counter_error + 1;
            if SADF.verbose_debug
                HDR.RAW_header_error(1:length(data_raw), HDR.counter_error) = data_raw;
            end
        case 2.1
            msg='IEEE C37.118.2 HDR, IDCODE does not match';
            HDR.counter_error = HDR.counter_error + 1;
            if SADF.verbose_debug
                HDR.RAW_header_error(1:length(data_raw), HDR.counter_error) = data_raw;
            end
        case 3
            msg='IEEE C37.118.2 CFG-1, corrupted';
            CFG_1.counter_error = CFG_1.counter_error + 1;
            if SADF.verbose_debug
                CFG_1.RAW_config_1_error(1:length(data_raw), CFG_1.counter_error) = data_raw;
            end
        case 3.1
            msg='IEEE C37.118.2 CFG-1, IDCODE does not match';
            CFG_1.counter_error = CFG_1.counter_error + 1;
            if SADF.verbose_debug
                CFG_1.RAW_config_1_error(1:length(data_raw), CFG_1.counter_error) = data_raw;
            end
        case 4
            msg='IEEE C37.118.2 CFG-2, corrupted';
            CFG_2_3.counter_error = CFG_2_3.counter_error + 1;
            if SADF.verbose_debug
                CFG_2_3.RAW_config_2_3_error(1:length(data_raw), CFG_2_3.counter_error) = data_raw;
            end
        case 4.1
            msg='IEEE C37.118.2 CFG-2, IDCODE does not match';
            CFG_2_3.counter_error = CFG_2_3.counter_error + 1;
            if SADF.verbose_debug
                CFG_2_3.RAW_config_2_3_error(1:length(data_raw), CFG_2_3.counter_error) = data_raw;
            end
        case 5
            msg='IEEE C37.118.2 CFG-3, corrupted';
            CFG_2_3.counter_error = CFG_2_3.counter_error + 1;
            if SADF.verbose_debug
                CFG_2_3.RAW_config_2_3_error(1:length(data_raw), CFG_2_3.counter_error) = data_raw;
            end
        case 5.1
            msg='IEEE C37.118.2 CFG-3, IDCODE does not match';
            CFG_2_3.counter_error = CFG_2_3.counter_error + 1;
            if SADF.verbose_debug
                CFG_2_3.RAW_config_2_3_error(1:length(data_raw), CFG_2_3.counter_error) = data_raw;
            end
        case 6
            msg='corrupted/unknown UDP/TCP packet';
            SADF.counter_error = SADF.counter_error + 1;
            if SADF.verbose_debug
                SADF.RAW_data_unknown(1:length(data_raw), SADF.counter_error) = data_raw;
            end
        otherwise
            msg='corrupted/unknown UDP/TCP packet';
            SADF.counter_error = SADF.counter_error + 1;
            if SADF.verbose_debug
                SADF.RAW_data_unknown(1:length(data_raw), SADF.counter_error) = data_raw;
            end
    end
    
    if SADF.verbose_info || SADF.verbose_debug
        disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    RCV - ' msg]);
        if (SADF.verbose_debug)
            disp('_______________________________________________________________________________________________________');
            disp(' ');
        end
    end
    
    flushinput(SADF.Connection_primary); %Empty TCP/UDP buffers
    
    if ~SADF.com_mode
        SADF.UDP_received = 0;
        SADF.UDP_processed = 0;
        SADF.UDP_size_sum = NaN(SADF.sim_time * 50,1);
    end
    
    
end
