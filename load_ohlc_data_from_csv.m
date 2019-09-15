function [dow, tm, open, high, low, close] = ...
  load_ohlc_data_from_csv(filename);
  
  f = fopen(filename);  
    
  fs='%s%s%s%s%s%s';  
  
  t = textscan(f, fs ,'Delimiter', ';');
  dow = strrep(t{1,1}(:,1), ',','.');
  tm = strrep(t{1,2}(:,1), ',','.');
  open = str2double(strrep(t{1,3}(:,1), ',','.'));
  high = str2double(strrep(t{1,4}(:,1), ',','.'));
  low = str2double(strrep(t{1,5}(:,1), ',','.'));
  close = str2double(strrep(t{1,6}(:,1), ',','.'));
  
  fclose(f);
  
end;