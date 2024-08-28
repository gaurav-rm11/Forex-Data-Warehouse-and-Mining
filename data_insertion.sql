INSERT INTO Dim_Date (DateKey, Date, DayOfWeek, Month, Quarter, Year)
VALUES
(1, '2024-08-28', 'Wednesday', 8, 3, 2024),
(2, '2024-08-29', 'Thursday', 8, 3, 2024),
(3, '2024-08-30', 'Friday', 8, 3, 2024),
(4, '2024-08-31', 'Saturday', 8, 3, 2024),
(5, '2024-09-01', 'Sunday', 9, 3, 2024);



INSERT INTO Dim_Currency (CurrencyKey, CurrencyCode, CurrencyName, Country, Region)
VALUES
(1, 'USD', 'United States Dollar', 'United States', 'North America'),
(2, 'EUR', 'Euro', 'European Union', 'Europe'),
(3, 'INR', 'Indian Rupee', 'India', 'Asia'),
(4, 'GBP', 'British Pound', 'United Kingdom', 'Europe'),
(5, 'JPY', 'Japanese Yen', 'Japan', 'Asia');


INSERT INTO Dim_Country (CountryKey, CountryName, Region, CurrencyKey)
VALUES
(1, 'United States', 'North America', 1),
(2, 'Germany', 'Europe', 2),
(3, 'India', 'Asia', 3),
(4, 'United Kingdom', 'Europe', 4),
(5, 'Japan', 'Asia', 5);


INSERT INTO Dim_CurrencyPair (CurrencyPairKey, BaseCurrency, TargetCurrency)
VALUES
(1, 1, 2), -- USD/EUR
(2, 1, 3), -- USD/INR
(3, 2, 3), -- EUR/INR
(4, 3, 4), -- INR/GBP
(5, 4, 5); -- GBP/JPY


INSERT INTO Dim_User (UserKey, UserID, UserName, UserCountry, UserType)
VALUES
(1, 'USR001', 'George Soros', 'United States', 'Individual'),
(2, 'USR002', 'Gaurav Mahadeshwar', 'India', 'Individual'),
(3, 'USR003', 'Aditya Joshi', 'India', 'Individual'),
(4, 'USR004', 'Rakesh Jhunjhunwala', 'India', 'Business'),
(5, 'USR005', 'Michael Platt', 'United Kingdom', 'Business');


INSERT INTO Dim_Source (SourceKey, SourceName, SourceCountry, SourceType, CountryKey)
VALUES
(1, 'Reuters', 'United States', 'News Agency', 1),
(2, 'Bloomberg', 'United States', 'Financial Services', 1),
(3, 'Economic Times', 'India', 'News Agency', 3),
(4, 'BBC News', 'United Kingdom', 'News Agency', 4),
(5, 'Nikkei', 'Japan', 'Financial Services', 5);


INSERT INTO Dim_TradeType (TradeTypeKey, TradeType, Description)
VALUES
(1, 'Buy', 'Purchase of currency'),
(2, 'Sell', 'Sale of currency');


INSERT INTO Fact_Trades (TradeID, DateKey, CurrencyPairKey, UserKey, SourceKey, TradeTypeKey, TradeAmount, TradePrice, Commission, ProfitLoss, ExchangeRate)
VALUES
(1, 1, 1, 1, 1, 1, 1000.00, 1.1200, 10.00, 50.00, 1.1200),
(2, 2, 2, 2, 3, 2, 50000.00, 74.6500, 50.00, 250.00, 74.6500),
(3, 3, 3, 3, 3, 1, 2000.00, 88.5000, 15.00, 100.00, 88.5000),
(4, 4, 4, 4, 4, 2, 3000.00, 0.8500, 20.00, 150.00, 0.8500),
(5, 5, 5, 5, 5, 1, 70000.00, 150.2000, 70.00, 350.00, 150.2000),
(6, 2, 1, 2, 2, 1, 2500.00, 1.1300, 12.50, 60.00, 1.1300),
(7, 3, 2, 3, 3, 2, 45000.00, 75.0000, 45.00, 225.00, 75.0000),
(8, 1, 4, 4, 1, 1, 5000.00, 0.8600, 25.00, 125.00, 0.8600),
(9, 4, 3, 5, 4, 2, 60000.00, 88.8000, 60.00, 300.00, 88.8000),
(10, 5, 5, 1, 5, 1, 80000.00, 151.0000, 80.00, 400.00, 151.0000);

