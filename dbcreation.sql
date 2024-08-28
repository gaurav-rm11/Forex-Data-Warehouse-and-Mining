CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    Date DATE,
    DayOfWeek VARCHAR(10),
    Month INT,
    Quarter INT,
    Year INT
);

CREATE TABLE Dim_Currency (
    CurrencyKey INT PRIMARY KEY,
    CurrencyCode VARCHAR(3),
    CurrencyName VARCHAR(50),
    Country VARCHAR(50),
    Region VARCHAR(50)
);


CREATE TABLE Dim_Country (
    CountryKey INT PRIMARY KEY,
    CountryName VARCHAR(50),
    Region VARCHAR(50),
    CurrencyKey INT,
    FOREIGN KEY (CurrencyKey) REFERENCES Dim_Currency(CurrencyKey)
);


CREATE TABLE Dim_CurrencyPair (
    CurrencyPairKey INT PRIMARY KEY,
    BaseCurrency INT,
    TargetCurrency INT,
    FOREIGN KEY (BaseCurrency) REFERENCES Dim_Currency(CurrencyKey),
    FOREIGN KEY (TargetCurrency) REFERENCES Dim_Currency(CurrencyKey)
);


CREATE TABLE Dim_User (
    UserKey INT PRIMARY KEY,
    UserID VARCHAR(50),
    UserName VARCHAR(100),
    UserCountry VARCHAR(50),
    UserType VARCHAR(20)
);


CREATE TABLE Dim_Source (
    SourceKey INT PRIMARY KEY,
    SourceName VARCHAR(100),
    SourceCountry VARCHAR(50),
    SourceType VARCHAR(50),
    CountryKey INT,
    FOREIGN KEY (CountryKey) REFERENCES Dim_Country(CountryKey)
);


CREATE TABLE Dim_TradeType (
    TradeTypeKey INT PRIMARY KEY,
    TradeType VARCHAR(10),
    Description VARCHAR(100)
);


CREATE TABLE Fact_Trades (
    TradeID INT PRIMARY KEY,
    DateKey INT,
    CurrencyPairKey INT,
    UserKey INT,
    SourceKey INT,
    TradeTypeKey INT,
    TradeAmount DECIMAL(18,2),
    TradePrice DECIMAL(18,4),
    TradeType VARCHAR(10),
    Commission DECIMAL(10,2),
    ProfitLoss DECIMAL(18,2),
    ExchangeRate DECIMAL(18,4),
    FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
    FOREIGN KEY (CurrencyPairKey) REFERENCES Dim_CurrencyPair(CurrencyPairKey),
    FOREIGN KEY (UserKey) REFERENCES Dim_User(UserKey),
    FOREIGN KEY (SourceKey) REFERENCES Dim_Source(SourceKey),
    FOREIGN KEY (TradeTypeKey) REFERENCES Dim_TradeType(TradeTypeKey)
);