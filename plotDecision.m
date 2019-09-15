function plotDecision( x, price, y )
  
  l = length(y);
  
  minimal = min(price);
  maximal = max(price);
  mm = (maximal-minimal)*0.1;
  
  
  figure;    

  %axes([min(x);max(y);minimal-mm;maximal+mm]);

  plot ( x, price(1:l) .* y, '+r');  

  hold on;

  plot ( x, price(1:l));  
  
  
  
end

