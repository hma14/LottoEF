CREATE TABLE [dbo].[tblReceipt] (
    [userName]      VARCHAR (20) NULL,
    [TransactionID] VARCHAR (25) NULL,
    [CCType]        VARCHAR (20) NULL,
    [CCNumber]      VARCHAR (20) NULL,
    [CCExpiryDate]  VARCHAR (12) NULL,
    [FullName]      VARCHAR (20) NULL,
    [MemberPlan]    VARCHAR (25) NULL,
    [StartDate]     VARCHAR (12) NULL,
    [ExpiredDate]   VARCHAR (12) NULL
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_tblReceipt_7_1630628852__K5]
    ON [dbo].[tblReceipt]([CCExpiryDate] ASC);

