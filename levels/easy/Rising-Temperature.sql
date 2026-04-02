select w.id from Weather w join Weather w2 on (w.recordDate=w2.recordDate + INTERVAL '1 day') where w.temperature > w2.temperature;
