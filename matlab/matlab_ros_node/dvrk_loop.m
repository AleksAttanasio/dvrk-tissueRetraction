%init script that instantiates "psm1" arm, homes it and testes it
dvrk_init
%desired execution rate in Hz
freq=20;
rate=rosrate(freq);
%setup button to stop looping
DlgH = figure('Renderer', 'painters', 'Position', [500 500 150 50]);
H = uicontrol('Style', 'PushButton', ...
                    'String', 'Break', ...
                    'Callback', 'delete(gcbf)');

%reset ros timer
reset(rate)     

%control loop
while (ishandle(H))
   disp(clock);
   waitfor(rate);
end


