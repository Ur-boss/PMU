%%
function discreteDerivative()
global DATA SADF fig1 
global values   % v dv Ddv
   
    
    if strcmpi(SADF.Connection_primary.status, 'open') == 1
            
       values.v = [DATA.TimeStamp(1:DATA.index_max,1) DATA.Angle(1:DATA.index_max,1,1)];   
       tm = values.v(:,1)*24*60*60;
       tm = tm - tm(1); 
       h =  tm(2) - tm(1);   % step-size time  diff(x);
       values.v(:,1) = tm; 

        df = diff(values.v(:,2))/h;
        Ddf = diff(values.v(:,2),2)/h;
        values.dv = df;
        values.Ddv = Ddf;

        figure(fig1)
        
        if DATA.counter < 20
            subplot(1,2,1);
            xlim([0 2]);
            stairs(values.v(:,1),values.v(:,2));
            ax = gca;
            ax.XTick = values.v(:,1);
            title('voltage flow');
            xlabel('timestamp (UTC)'); ylabel('Voltage (Volt)');
            legend('Curve');
            grid on;
            set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'XTickLabelRotation', 45)
            set(findall(gca, 'Type', 'Line'),'LineWidth',1);
            
        else
            subplot(1,2,1);
                currentXLim = xlim;
                newXLim = [currentXLim(1)+1, currentXLim(2) + 1];  % Extend x-axis by 100 units
                xlim(newXLim);
            stairs(values.v(end-18:end,1),values.v(end-18:end,2));
            ax = gca;
            ax.XTick = values.v(end-18:end,1);
            title('voltage flow');
            xlabel('timestamp (UTC)'); ylabel('Voltage (Volt)');
            legend('Curve');
            grid on;
            set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'XTickLabelRotation', 45)
            set(findall(gca, 'Type', 'Line'),'LineWidth',1);
            
        end    
       
        subplot(1,2,2);
        xlim([-400 400]); ylim([-500 500]);
        plot(values.dv(2:end),values.Ddv(:));
        ax = gca;
       % ax.XTick = values.dv(1:end-1,1);
        title('Unknown voltage flow');
        xlabel('Single Derivative (dv/dt) --->'); ylabel('Double Derivative D(dv/dt) --->');
        legend('Curve');
        grid on;
        set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'XTickLabelRotation', 45)
        set(findall(gca, 'Type', 'Line'),'LineWidth',1);
        drawnow;        
        
    end
    
end
    
