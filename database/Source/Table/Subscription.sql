CREATE TABLE [Subscription]
    (
        SubscriptionId     INT IDENTITY(1, 1) NOT NULL,
        UserId             INT NOT NULL,
        DateStart          DATE NOT NULL,
        DateEnd            DATE NOT NULL,
		Type			   TINYINT NOT NULL,
        CreatedOn          DATETIME2 NOT NULL
    )
    ;

/*

Type:
1 - new car
2 - car was updated (for example updated price)

*/