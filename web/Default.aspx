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
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" 
            DataSourceID="FindAndFollowDataSource" ForeColor="#333333" GridLines="None" 
            style="text-align: center" Width="436px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="CarBrand" HeaderText="CarBrand" 
                    SortExpression="CarBrand" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                <asp:BoundField DataField="SiteUrl" HeaderText="SiteUrl" 
                    SortExpression="SiteUrl" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:BoundField DataField="ModelYear" HeaderText="ModelYear" 
                    SortExpression="ModelYear" />
                <asp:BoundField DataField="PageCreatedOn" HeaderText="PageCreatedOn" 
                    SortExpression="PageCreatedOn" />
                <asp:BoundField DataField="CreatedOn" HeaderText="CreatedOn" 
                    SortExpression="CreatedOn" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="FindAndFollowDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:FindAndFollowConnectionString %>" 
            
            SelectCommand="SELECT [CarBrand], [Model], [SiteUrl], [Price], [ModelYear], [PageCreatedOn], [CreatedOn] FROM [CarParsing]">
        </asp:SqlDataSource>
        <asp:Button ID="BtnUploadData" runat="server" OnClick="BtnUploadData_Click" 
            Text="Upload Data" />
    </form>
</body>
</html>
