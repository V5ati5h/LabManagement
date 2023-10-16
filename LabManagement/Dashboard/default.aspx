<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="LabManagement.Dashboard.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Inventory Overview</h2>
        <div class="summary">
            <div class="item">
                <span>Total Items:</span>
                <asp:Label runat="server" ID="tItem">1000</asp:Label>
            </div>
            <div class="item">
                <span>Critical Items:</span>
                <asp:Label runat="server" ID="cItem">1000</asp:Label>
            </div>
            <div class="item">
                <span>Low Stock Items:</span>
                <asp:Label runat="server" ID="tLowStock">1000</asp:Label>
            </div>
            <div class="item">
                <span>Expired Items:</span>
                <asp:Label runat="server" ID="tExpored">1000</asp:Label>
            </div>
        </div>
        <!-- Add any other dashboard elements here -->
    </div>
</asp:Content>
