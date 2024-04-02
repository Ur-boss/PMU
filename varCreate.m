global SADF
global ActivePower ReactivePower
ActivePower = ActivePower1;
ReactivePower = ReactivePower1;

%% SIMULATION SETTINGS
SADF.verbose_info = Verbose_info;                      %Show status window output (SADF), default(false) - speed increase
SADF.verbose_debug = Verbose_debug;                     %Show command window output (PMU Messages), default(false) - speed increase
SADF.session_report = Session_report1;                    %Print SADF session report, default(true)
SADF.sim_time = Sim_time;                        %Max run time in SECONDS


%% PMU/PDC CONNECTION SETTINGS
SADF.com_mode = Com_mode;                          %For 'Commanded mode' select: true; for 'Spontaneous mode' select: false
SADF.protocol = Protocol;                         %Transport protocol used, select: 'tcp'; 'udp'; or mixed 'tcp/udp' (where udp protocol and primary interface are for receiving DATA, and tcp protocol and secondary interface are for sending CMD and receiving HDR, CFG-1, CFG-2, CFG-3)

% Primary interface, used for 'tcp', 'udp' mode as outgoing and incoming connecton; and for mixed 'tcp/udp' mode as udp incoming connection
SADF.ip_address_primary = Ip_address_primary;       %PMU/PDC Primary interface IP Address
SADF.port_primary = Port_primary;                      %PMU/PDC Primary interface port number

% Secondary interface, used only for mixed 'tcp/udp' mode as a tcp incomming and outgoing connection
SADF.ip_address_secondary = '10.60.4.117';     %PMU/PDC Secondary interface IP Address, used only in case of mixed 'tcp/udp' transport protocol is used. Primary interface is used for incoming 'udp' connection configuration.
SADF.port_secondary = 6006;                    %PMU/PDC Secondary interface port number, used only in case of mixed 'tcp/udp' transport protocol is used. Primary interface is used for incoming 'udp' connection configuration.

% PMU/PDC device settings
SADF.device_id = Device_id;                            %PMU/PDC ID value
SADF.conf_fr_ver = Conf_fr_ver;                          %For IEEE C37.118-2005 select: 2; for  IEEE C37.118-2011 select: 3
