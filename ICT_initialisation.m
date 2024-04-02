function ICT_initialisation()
    global  SADF
%   disp('---------------------------->Successfully run : ICT_intialisation<-------------');
    if  isfield(SADF,'Connection_primary') 
        if SADF.verbose_info || SADF.verbose_debug
            disp(' ');
            disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    PMU/PDC primary connection reset in progress']);
        end
        
        stopasync(SADF.Connection_primary);
        fclose(SADF.Connection_primary);
        flushinput(SADF.Connection_primary);
        delete(SADF.Connection_primary);
        SADF = rmfield(SADF,'Connection_primary');
        
        SADF.DATA_recieved = false;
        SADF.HDR_recieved = false;
        SADF.CFG_1_recieved = false;
        SADF.CFG_2_3_recieved = false;
        
        if SADF.verbose_info || SADF.verbose_debug
            disp(' ');
            disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    PMU/PDC primary connection closed']);
            disp(' ');
        end
    end
    
    
    if  isfield(SADF,'Connection_secondary') %isa(SADF.Connection_primary,'tcpip')
        if SADF.verbose_info || SADF.verbose_debug
            disp(' ');
            disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    PMU/PDC secondary connection reset in progress']);
        end
        
        stopasync(SADF.Connection_secondary);
        fclose(SADF.Connection_secondary);
        flushinput(SADF.Connection_secondary);
        delete(SADF.Connection_secondary);
        SADF = rmfield(SADF,'Connection_secondary');
        
        
        SADF.DATA_recieved = false;
        SADF.HDR_recieved = false;
        SADF.CFG_1_recieved = false;
        SADF.CFG_2_3_recieved = false;
        
        if SADF.verbose_info || SADF.verbose_debug
            disp(' ');
            disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    PMU/PDC secondary connection closed']);
            disp(' ');
        end
    end
    
    
    if strcmpi(SADF.protocol,'tcp') && SADF.com_mode
        SADF.tcp = true;
        SADF.udp = false;
        SADF.tcp_udp = false;
        SADF.Connection_primary = tcpip(SADF.ip_address_primary, SADF.port_primary, 'NetworkRole', 'client');
        set(SADF.Connection_primary, 'InputBufferSize', 204800);
        set(SADF.Connection_primary, 'OutputBufferSize', 204800);
        set(SADF.Connection_primary, 'ByteOrder', 'bigEndian');
        set(SADF.Connection_primary, 'TransferDelay', 'off');
        set(SADF.Connection_primary, 'ReadAsyncMode', 'continuous');
        set(SADF.Connection_primary, 'Terminator','')
        fopen(SADF.Connection_primary);
        
        if strcmpi(SADF.Connection_primary.status, 'open')
            if SADF.verbose_info || SADF.verbose_debug
                disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    TCP primary connection with PMU/PDC established, commanded mode']);
                disp('_______________________________________________________________________________________________________');
                disp(' ');
            end
        end
        
    elseif strcmpi(SADF.protocol,'udp')
        SADF.tcp = false;
        SADF.udp = true;
        SADF.tcp_udp = false;
        SADF.Connection_primary = udp(SADF.ip_address_primary, SADF.port_primary);
        set(SADF.Connection_primary, 'InputBufferSize', 65535*100);
        set(SADF.Connection_primary, 'OutputBufferSize', 65535*100);
        set(SADF.Connection_primary, 'InputDatagramPacketSize',65535);
        set(SADF.Connection_primary, 'Terminator','')
        set(SADF.Connection_primary, 'ByteOrder', 'bigEndian');
        set(SADF.Connection_primary, 'ReadAsyncMode', 'continuous');
        set(SADF.Connection_primary, 'LocalPortMode', 'manual');
        set(SADF.Connection_primary, 'LocalPort', SADF.port_primary);
        fopen(SADF.Connection_primary);
        
        if ~SADF.com_mode
            set(SADF.Connection_primary, 'DatagramReceivedFcn',{@UDPcallback});
            SADF.resend_wait = Inf;
        end
        
        if strcmpi(SADF.Connection_primary.status, 'open')
            if SADF.verbose_info || SADF.verbose_debug
                if SADF.com_mode
                    disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    UDP primary connection with PMU/PDC available, commanded mode']);
                else
                    disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    UDP primary connection with PMU/PDC available, spontaneous mode']);
                end
                disp('_______________________________________________________________________________________________________');
                disp(' ');
            end
        end
        
    elseif strcmpi(SADF.protocol,'tcp/udp') && SADF.com_mode
        SADF.tcp = false;
        SADF.udp = false;
        SADF.tcp_udp = true;
        
        SADF.Connection_primary = udp(SADF.ip_address_primary, SADF.port_primary);
        set(SADF.Connection_primary, 'InputBufferSize', 65535*100);
        set(SADF.Connection_primary, 'OutputBufferSize', 65535*100);
        set(SADF.Connection_primary, 'InputDatagramPacketSize',65535);
        set(SADF.Connection_primary, 'ByteOrder', 'bigEndian');
        set(SADF.Connection_primary, 'ReadAsyncMode', 'continuous');
        set(SADF.Connection_primary, 'LocalPortMode', 'manual');
        set(SADF.Connection_primary, 'Terminator','')
        set(SADF.Connection_primary, 'LocalPort', SADF.port_primary);
        
        fopen(SADF.Connection_primary);
        
        if strcmpi(SADF.Connection_primary.status, 'open')
            if SADF.verbose_info || SADF.verbose_debug
                disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    UDP primary connection with PMU/PDC available, commanded mode']);
                disp('_______________________________________________________________________________________________________');
                disp(' ');
            end
        end
        
        SADF.Connection_secondary = tcpip(SADF.ip_address_secondary, SADF.port_secondary, 'NetworkRole', 'client');
        set(SADF.Connection_secondary, 'InputBufferSize', 204800);
        set(SADF.Connection_secondary, 'OutputBufferSize', 204800);
        set(SADF.Connection_secondary, 'ByteOrder', 'bigEndian');
        set(SADF.Connection_secondary, 'TransferDelay', 'off');
        set(SADF.Connection_secondary, 'ReadAsyncMode', 'continuous');
        fopen(SADF.Connection_secondary);
        if strcmpi(SADF.Connection_secondary.status, 'open')
            
            if SADF.verbose_info || SADF.verbose_debug
                disp([datestr(now, 'yyyy-mm-dd HH:MM:SS.FFF') '    TCP secondary connection with PMU/PDC established, commanded mode']);
                disp('_______________________________________________________________________________________________________');
                disp(' ');
            end
        end
        
    else
        warning('The TCP/UDP connection parameters provided are invalid.')
        warning('Simulation terminated.')
        return
    end
end
