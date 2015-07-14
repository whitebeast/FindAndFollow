CREATE TABLE [SearchSite]
    (
        SearchSiteId     INT IDENTITY(1, 1) NOT NULL,
        SearchId         INT NOT NULL,
        SiteId           INT NOT NULL,
        CreatedOn        DATETIME2 NOT NULL
    )
    ;
