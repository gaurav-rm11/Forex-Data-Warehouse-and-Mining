/*1. Roll-Up (Drill-Up):
Roll-up is an aggregation operation where data is summarized at a higher level. to aggregate trades by month or year instead of daily data:
*/
SELECT 
    d.Month, 
    d.Year,
    bc.CurrencyCode AS BaseCurrency,
    tc.CurrencyCode AS TargetCurrency,
    SUM(f.TradeAmount) AS TotalTradeAmount
FROM 
    Fact_Trades f
JOIN 
    Dim_Date d ON f.DateKey = d.DateKey
JOIN 
    Dim_CurrencyPair cp ON f.CurrencyPairKey = cp.CurrencyPairKey
JOIN 
    Dim_Currency bc ON cp.BaseCurrency = bc.CurrencyKey
JOIN 
    Dim_Currency tc ON cp.TargetCurrency = tc.CurrencyKey
GROUP BY 
    d.Month, 
    d.Year, 
    bc.CurrencyCode,
    tc.CurrencyCode
ORDER BY 
    d.Year, 
    d.Month,
    bc.CurrencyCode,
    tc.CurrencyCode;

/*2. Drill-Down (Roll-Down):
Drill-down is the opposite of roll-up, where you go from a higher level of data to a more detailed level. After aggregating by month, we can drill down to see data on daily context.
*/
SELECT 
    d.Date,
    bc.CurrencyCode AS BaseCurrency,
    tc.CurrencyCode AS TargetCurrency,
    SUM(f.TradeAmount) AS TotalTradeAmount
FROM 
    Fact_Trades f
JOIN 
    Dim_Date d ON f.DateKey = d.DateKey
JOIN 
    Dim_CurrencyPair cp ON f.CurrencyPairKey = cp.CurrencyPairKey
JOIN 
    Dim_Currency bc ON cp.BaseCurrency = bc.CurrencyKey
JOIN 
    Dim_Currency tc ON cp.TargetCurrency = tc.CurrencyKey
GROUP BY 
    d.Date, 
    bc.CurrencyCode,
    tc.CurrencyCode
ORDER BY 
    d.Date, 
    bc.CurrencyCode,
    tc.CurrencyCode;

/*3. Slice:
This operation involves selecting a single dimension and viewing a subset of the data. For instance, you might want to see all trades related to a specific currency pair.
*/
SELECT f.TradeID, u.UserName, c1.CurrencyCode AS BaseCurrency, c2.CurrencyCode AS TargetCurrency, f.TradeAmount, f.ProfitLoss
FROM Fact_Trades f
JOIN Dim_CurrencyPair cp ON f.CurrencyPairKey = cp.CurrencyPairKey
JOIN Dim_Currency c1 ON cp.BaseCurrency = c1.CurrencyKey
JOIN Dim_Currency c2 ON cp.TargetCurrency = c2.CurrencyKey
JOIN Dim_User u ON f.UserKey = u.UserKey
WHERE c1.CurrencyCode = 'USD' AND c2.CurrencyCode = 'EUR';


/*4. Dice:
Dice involves filtering the data on more than one dimension, creating a sub-cube from the data.
Query: Dice on USD/INR Currency Pair and Buy TradeType
*/
SELECT f.TradeID, u.UserName, c1.CurrencyCode AS BaseCurrency, c2.CurrencyCode AS TargetCurrency, f.TradeAmount, f.ProfitLoss
FROM Fact_Trades f
JOIN Dim_CurrencyPair cp ON f.CurrencyPairKey = cp.CurrencyPairKey
JOIN Dim_Currency c1 ON cp.BaseCurrency = c1.CurrencyKey
JOIN Dim_Currency c2 ON cp.TargetCurrency = c2.CurrencyKey
JOIN Dim_User u ON f.UserKey = u.UserKey
JOIN Dim_TradeType tt ON f.TradeTypeKey = tt.TradeTypeKey
WHERE c1.CurrencyCode = 'USD' AND c2.CurrencyCode = 'INR' AND tt.TradeType = 'Sell';


/*5. Pivot:
Pivoting is about rearranging the dimensions to view the data from different perspectives. This is commonly done in reporting tools, we can simulate it in SQL by using conditional aggregation.
*/
SELECT d.Year,
    SUM(CASE WHEN tt.TradeType = 'Buy' THEN f.TradeAmount ELSE 0 END) AS BuyAmount,
    SUM(CASE WHEN tt.TradeType = 'Sell' THEN f.TradeAmount ELSE 0 END) AS SellAmount
FROM Fact_Trades f
JOIN Dim_Date d ON f.DateKey = d.DateKey
JOIN Dim_TradeType tt ON f.TradeTypeKey = tt.TradeTypeKey
GROUP BY d.Year;


