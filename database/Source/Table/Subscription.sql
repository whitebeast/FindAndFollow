CREATE TABLE [Subscription]
    (
        SubscriptionId     INT IDENTITY(1, 1) NOT NULL,
        UserId             INT NOT NULL,
        DateStart          DATE NOT NULL,
        DateEnd            DATE NOT NULL,
        CreatedOn          DATETIME2 NOT NULL
    )
    ;
