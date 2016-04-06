CREATE TABLE [dbo].[tblTransactions] (
    [transEntry]    INT          IDENTITY (1, 1) NOT NULL,
    [transactionID] VARCHAR (25) NULL,
    [amount]        MONEY        NULL,
    [customerName]  VARCHAR (25) NULL,
    [transType]     VARCHAR (25) NULL
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_tblTransactions_7_1582628681__K1]
    ON [dbo].[tblTransactions]([transEntry] ASC);

