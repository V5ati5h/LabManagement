<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="LabManagement.Dashboard.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Inventory Overview</h2>
        <div class="summary">
            <div class="item">
                <span>Total Items:</span>
                <span>1000</span>
            </div>
            <div class="item">
                <span>Critical Items:</span>
                <span>5</span>
            </div>
            <div class="item">
                <span>Low Stock Items:</span>
                <span>20</span>
            </div>
            <div class="item">
                <span>Expired Items:</span>
                <span>10</span>
            </div>
        </div>
        <!-- Add any other dashboard elements here -->
    </div>
</asp:Content>
