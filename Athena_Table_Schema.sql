CREATE EXTERNAL TABLE IF NOT EXISTS stock_data (
    Open double,
    High double,
    Low double,
    Close double,
    Adj_Close double,
    Volume bigint
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  'separatorChar' = ',',
  'quoteChar' = '"',
  'escapeChar' = '\\',
  'skip.header.line.count' = '1' 
)
LOCATION 's3://stockmarketproj/stock-data/'
TBLPROPERTIES ('has_encrypted_data'='false');
