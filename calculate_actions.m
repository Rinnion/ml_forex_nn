function [y] = ...
  calculate_actions(close);
  
  shift = 3;
  diff = 0.003;
  
  closediff = close(1:end-shift,:) - close(shift+1:end,:);
  ybuy = (closediff) <= -diff;
  ysell = (closediff) >= diff;
  ycash = (ybuy+ysell) == 0;
  
  y=[ybuy,ycash,ysell];
  
end;