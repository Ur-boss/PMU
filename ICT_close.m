%%

function ICT_close()
    global SADF
    disp('---------------------------->Successfully run : ICT_close<-------------');
    %Send STOP Request to PMU/PDC
    if SADF.DATA_recieved && SADF.com_mode
        command_frame('0001', 'sync');
    end
    
    if  isfield(SADF,'Connection_primary')
        stopasync(SADF.Connection_primary);
        fclose(SADF.Connection_primary);
        flushinput(SADF.Connection_primary);
        delete(SADF.Connection_primary);
        SADF = rmfield(SADF,'Connection_primary');
    end
    
    if  isfield(SADF,'Connection_secondary')
        stopasync(SADF.Connection_secondary);
        fclose(SADF.Connection_secondary);
        flushinput(SADF.Connection_secondary);
        delete(SADF.Connection_secondary);
        SADF = rmfield(SADF,'Connection_secondary');
    end
    
    instrreset
    
    if SADF.verbose_info || SADF.verbose_debug
        disp(' ');
        disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    PMU/PDC connection closed']);
        disp('_______________________________________________________________________________________________________');
        disp(' ');
    end
end
