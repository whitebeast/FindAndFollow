CREATE TABLE [dbo].[ErrorLog](
    [ErrorLogId]            [int] IDENTITY(1,1) NOT NULL,
    [ErrorNumber]           [int] NOT NULL,
    [ErrorSeverity]         [int] NULL,
    [ErrorState]            [int] NULL,
    [ErrorObject]           [nvarchar](126) NULL,
    [IsService]             [bit] NULL,
    [ErrorLine]             [int] NULL,
    [ErrorMessageShort]     [nvarchar](1000) NOT NULL,
    [ErrorMessageFull]      [nvarchar](4000) NOT NULL,
    [UserName]              [sysname] NOT NULL,
    [CreatedOn]             [datetime2] NOT NULL
)