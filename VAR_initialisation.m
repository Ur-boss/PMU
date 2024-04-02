function VAR_initialisation()
    global  SADF DATA CFG_1 CFG_2_3 CMD HDR values
    
    %% VARIABLES INITIALISATION
    SADF.counter_error = 0;
    HDR.counter_error = 0;
    DATA.counter_error = 0;
    CFG_1.counter_error = 0;
    CFG_2_3.counter_error = 0;
    CMD.counter = 0;
    DATA.counter = 0;
    DATA.counter_discarded = 0;
    DATA.counter_duplicated = 0;
    DATA.counter_notOrder = 0;
    DATA.index_max = 0;
    CFG_1.counter = 0;
    CFG_1.counter_duplicated = 0;
    CFG_2_3.counter = 0;
    CFG_2_3.counter_duplicated = 0;
    HDR.counter = 0;
    SADF.HDR_recieved = false;
    SADF.CFG_1_recieved = false;
    SADF.CFG_2_3_recieved = false;
    SADF.DATA_recieved = false;
    SADF.resend_wait = 0; %used for command resend
    SADF.resend_wait_2 = 0; %used to silence the communication channel
    SADF.sim_start = tic;
    SADF.reset_wait = toc(SADF.sim_start) + 10; % Use to reset ICT connection if nothing happens in 5 seconds
    values.v = [0 0];  
    values.Ddv = [0];
    
    if ~ strcmpi(SADF.protocol,'tcp') %if spontaneous mode
        SADF.UDP_firewall = false;
        SADF.UDP_received = 0;
        SADF.UDP_processed = 0;
        SADF.UDP_size_sum = NaN(SADF.sim_time * 50,1); % Here we assume the reporting rate will be 50
    end
end
