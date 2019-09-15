
filename='eurusd60.csv';

[dow, tm, open, high, low, close]=load_ohlc_data_from_csv(filename);

y = calculate_actions(close);


figure(1);
plot(close);
hold on;
plot_action(close, y(:,1), 'og')
plot_action(close, y(:,3), 'or')
hold off;

