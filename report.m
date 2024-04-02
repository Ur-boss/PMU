%%

function report
    global CFG_1 CFG_2_3 DATA CMD HDR SADF
    
    disp('Session report: ');
    disp(['  Total sent command frames: ', int2str(CMD.counter)]);
    disp(['  Total received packages: ', int2str(HDR.counter + DATA.counter  + CFG_1.counter + CFG_2_3.counter)]);
    disp(['    Total received DATA frames: ', int2str(DATA.counter)]);
    disp(['    Total received CFG-1 frames: ', int2str(CFG_1.counter)]);
    disp(['    Total received CFG-2 or CFG-3 frames: ', int2str(CFG_2_3.counter)]);
    disp(['    Total received  HDR frames: ', int2str(HDR.counter)]);
    disp(['  Total received corrupted packages: ', int2str(HDR.counter_error + DATA.counter_error  + CFG_1.counter_error + CFG_2_3.counter_error + SADF.counter_error)]);
    disp(['    Total received corrupted DATA frames: ', int2str(DATA.counter_error)]);
    disp(['    Total received corrupted CFG-1 frames: ', int2str(CFG_1.counter_error)]);
    disp(['    Total received corrupted CFG-2 or CFG-3 frames: ', int2str(CFG_2_3.counter_error)]);
    disp(['    Total received corrupted HDR frames: ', int2str(HDR.counter_error)]);
    disp(['    Total received unknown TCP/UDP packets/frames: ', int2str(SADF.counter_error)]);
    disp(['  Total received duplicated packages: ', int2str(DATA.counter_duplicated + CFG_1.counter_duplicated + CFG_2_3.counter_duplicated)]);
    disp(['    Total received duplicated DATA frames: ', int2str(DATA.counter_duplicated)]);
    disp(['    Total received duplicated CFG-1 frames: ', int2str(CFG_1.counter_duplicated)]);
    disp(['    Total received duplicated CFG-2 or CFG-3 frames: ', int2str(CFG_2_3.counter_duplicated)]);
    disp(['  Total received not-in-order DATA frames: ', int2str(DATA.counter_notOrder)]);
    disp(['  Total discarded DATA frames: ', int2str(DATA.counter_discarded)]);
  end
