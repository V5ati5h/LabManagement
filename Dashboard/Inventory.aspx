<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LabManagement.Dashboard.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ConnString" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="code" HeaderText="code" SortExpression="code"></asp:BoundField>
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name"></asp:BoundField>
                <asp:BoundField DataField="category" HeaderText="category" SortExpression="category"></asp:BoundField>
                <asp:BoundField DataField="supplier" HeaderText="supplier" SortExpression="supplier"></asp:BoundField>
                <asp:BoundField DataField="quantity" HeaderText="quantity" SortExpression="quantity"></asp:BoundField>
                <asp:BoundField DataField="purchesePrice" HeaderText="purchesePrice" SortExpression="purchesePrice"></asp:BoundField>
                <asp:BoundField DataField="available" HeaderText="available" SortExpression="available"></asp:BoundField>
                <asp:BoundField DataField="expirationDate" HeaderText="expirationDate" SortExpression="expirationDate"></asp:BoundField>
                <asp:BoundField DataField="lastUpdate" HeaderText="lastUpdate" SortExpression="lastUpdate"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="ConnString" ConnectionString="<%$ ConnectionStrings:ConnString %>" SelectCommand="SELECT [code], [name], [category], [supplier], [quantity], [purchesePrice], [available], [expirationDate], [lastUpdate] FROM [Tbl_Items]"></asp:SqlDataSource>
    </div>
</asp:Content>
