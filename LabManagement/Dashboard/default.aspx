<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="LabManagement.Dashboard.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Additional custom styles can be added here if needed */
        .summary {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .item {
            margin-bottom: 10px;
        }

            .item span {
                font-weight: bold;
                margin-right: 5px;
            }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <script>
        window.onload = function () {
            var isAuthorized = sessionStorage.getItem('authorized');
            if (isAuthorized !== 'true') {
                window.location.href = '../default.aspx';
            }
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h2>Inventory Overview</h2>
        <div class="summary">
            <div class="item bg-light p-3 rounded">
                <span>Total Items:</span>
                <asp:Label runat="server" ID="tItem">1000</asp:Label>
            </div>
            <div class="item bg-light p-3 rounded">
                <span>Critical Items:</span>
                <asp:Label runat="server" ID="cItem">1000</asp:Label>
            </div>
            <div class="item bg-light p-3 rounded">
                <span>Low Stock Items:</span>
                <asp:Label runat="server" ID="tLowStock">1000</asp:Label>
            </div>
            <div class="item bg-light p-3 rounded">
                <span>Expired Items:</span>
                <asp:Label runat="server" ID="tExpired">1000</asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
