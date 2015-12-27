<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FindAndFollow.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1
        {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="auto-style1">
        <strong>Default page</strong><br />
        Check DataSource:</div>
        <asp:SqlDataSource ID="FindAndFollowDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:FindAndFollowConnectionString %>" 
            
            SelectCommand="SELECT [CarBrand], [Model], [SiteUrl], [Price], [ModelYear], [PageCreatedOn], [CreatedOn] FROM [CarParsing]">
        </asp:SqlDataSource>
        <asp:Button ID="BtnUploadData" runat="server" OnClick="BtnUploadData_Click" 
            Text="Upload Data" />
    </form>
</body>
</html>
