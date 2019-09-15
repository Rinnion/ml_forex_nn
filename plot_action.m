function plot_action(close, action, symb);
  
  t(1:size(close,1),1:1)=nan
  ind = find(action(:,1)==1);
  t(ind)=close(ind);
  plot(t, symb);
  
end;