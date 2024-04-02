%%
function UDPcallback(~, event)
    global SADF
    
    SADF.UDP_received = SADF.UDP_received +1;
    SADF.UDP_size_sum(SADF.UDP_received) = event.Data.DatagramLength;
end

