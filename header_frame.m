%%
function header_frame(data_raw)
    global SADF HDR
%   disp('---------------------------->Successfully run : IEEE_C37_118_2 -- header frame<-------------');
    SADF.HDR_recieved = true;
    SADF.reset_wait = toc(SADF.sim_start) + 10;
    HDR.counter = HDR.counter + 1;
    HDR.DeviceID(HDR.counter, 1) = swapbytes(typecast((data_raw(5:6)), 'uint16'));
    HDR.SOC(HDR.counter, 1) =datenum([1970 1 1 0 0 double(swapbytes(typecast((data_raw(7:10)), 'uint32')))]);
    Time_Quality = dec2bin(data_raw(11),8);
    tmp_FOS = dec2bin(data_raw(12:14),8)';
    FOS = bin2dec(tmp_FOS(1:end));
    
    if (SADF.verbose_info || SADF.verbose_debug)
        disp([   datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    RCV - IEEE C37.118.2 HDR']);
    end
    
    if (SADF.verbose_debug)
        
        HDR.RAW_header(1:length(data_raw), HDR.counter) = data_raw;
        
        switch Time_Quality(5:8)
            case '1111'
                leapTQ = ('"Fault-clock failure, time not reliable"');
            case '1011'
                leapTQ = ('"Time within 10 s of UTC"');
            case '1010'
                leapTQ = ('"Time within 1 s of UTC"');
            case '1001'
                leapTQ = ('"Time within 10^-1 s of UTC"');
            case '1000'
                leapTQ = ('"Time within 10^-2 s of UTC"');
            case '0111'
                leapTQ = ('"Time within 10^-3 s of UTC"');
            case '0110'
                leapTQ = ('"Time within 10^-4 s of UTC"');
            case '0101'
                leapTQ = ('"Time within 10^-5 s of UTC"');
            case '0100'
                leapTQ = ('"Time within 10^-6 s of UTC"');
            case '0011'
                leapTQ = ('"Time within 10^-7 s of UTC"');
            case '0010'
                leapTQ = ('"Time within 10^-8 s of UTC"');
            case '0001'
                leapTQ = ('"Time within 10^-9 s of UTC"');
            case '0000'
                leapTQ = ('"Normal operation, clock locked to UTC traceable source"');
            otherwise
                leapTQ = ('"error reading"');
        end
        
        disp('  Synchronization word (hex): "AA01"');  %Checked before entered
        disp(['  Framesize: ' num2str(swapbytes(typecast((data_raw(3:4)),'uint16'))) ' Bytes']);
        disp(['  PMU/PDC ID number: ' num2str(HDR.DeviceID(HDR.counter, 1))]);
        disp(['  SOC timestamp: ' datestr(HDR.SOC(HDR.counter, 1), 'yyyy.mm.dd HH:MM:SS')]);
        disp('  Time quality flags: ');
        if Time_Quality(2) == '1'; disp('    Leap second direction'); end
        if Time_Quality(3) == '1'; disp('    Leap second occurred'); end
        if Time_Quality(4) == '1'; disp('    Leap second pending'); end
        disp(['    Time quality indicator: ' leapTQ]);
        disp(['  Fraction of second (raw): ' num2str(FOS)]);
    end
    
    a1 = 15 ;
    a2 = swapbytes(typecast((data_raw(3:4)),'uint16')) - 2; %Frame size - CHKsum
    HDR.Content(HDR.counter, :)  = (data_raw(a1:a2))';
    
    if (SADF.verbose_debug)
        disp('  ## Header message (raw) START ##');
        disp(char(HDR.Content(HDR.counter, :) ))
        disp('  ## Header message (raw) END ##');
    end
    
    a1 = a2 + 1;
    a2 = a2 + 2;
    
    if (SADF.verbose_debug)
        disp(['  Checksum (hex): "' dec2hex(swapbytes(typecast((data_raw(a1:a2)),'uint16'))) '" [correct]'])   %Checksum (checked before we enter into data frame script)
        disp('_______________________________________________________________________________________________________');
        disp(' ');
    end
end
