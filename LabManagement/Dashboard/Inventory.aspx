<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LabManagement.Dashboard.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // Function to load items and populate the table
            function loadItems() {
                $.get("../api/items", function (data) {
                    // Clear existing table rows
                    $("#inventoryTable tbody").empty();

                    // Populate the table with received data
                    $.each(data, function (index, item) {
                        var row = "<tr>" +
                            "<td>" + item.Code + "</td>" +
                            "<td>" + item.Name + "</td>" +
                            "<td>" + item.Quantity + "</td>" +
                            "<td>" + item.Available + "</td>" +
                            "<td>" + item.Location + "</td>" +
                            "<td>" + item.Supplier + "</td>" +
                            "<td>" + item.ExpirationDate + "</td>" +
                            "<td>" +
                            "<a href='#' class='edit-link' data-id='" + item.Id + "'>Edit</a> <a href='#' class='delete-link' data-id='" + item.Id + "'>Delete</a>" +
                            "</td>" +
                            "</tr>";
                        $("#inventoryTable tbody").append(row);
                    });
                });
            }

            // Initial load when the page is ready
            loadItems();

            $("#inventoryTable").on("click", ".edit-link", function () {
                var itemId = $(this).data("id");
                // Implement edit functionality (e.g., open a modal with item details for editing)
                // Fetch the category details and implement your edit logic here...

                // For demonstration, let's just show an alert
                alert("Edit clicked for category with ID: " + itemId);
            });

            $("#inventoryTable").on("click", ".delete-link", function () {
                var itemId = $(this).data("id");
                // Implement delete functionality
                if (confirm("Are you sure you want to delete this item?")) {
                    $.ajax({
                        url: "../api/items/" + itemId,
                        type: "DELETE",
                        success: function () {
                            // Reload items after successful deletion
                            loadItems();
                        },
                        error: function () {
                            alert("Error deleting item.");
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Style for the form container */
        .container {
            max-width: 600px;
            margin: auto;
        }

        /* Style for the category form */
        .category-form {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Style for form groups */
        .form-group {
            margin-bottom: 15px;
        }

        /* Style for labels */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* Style for text inputs and textarea */
        input[type="text"],
        select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        /* Style for the Create button */
        #insertBtn {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
        }

            /* Hover effect for the Create button */
            #insertBtn:hover {
                background-color: #0056b3;
            }
    </style>
    <div class="container">
        <div class="category-form">
            <h3>Create New Category</h3>
            <div>
                <label for="code">Code:</label>
                <asp:TextBox ID="code" runat="server" type="text" required="true"></asp:TextBox>

                <label for="name">Name:</label>
                <asp:TextBox ID="name" runat="server" type="text" required="true"></asp:TextBox>

                <label for="ddCat">Category:</label>
                <asp:DropDownList ID="ddCat" runat="server" AutoPostBack="false" OnSelectedIndexChanged="ddCat_SelectedIndexChanged">
                </asp:DropDownList>

                <label for="ddStud">For Students:</label>
                <asp:DropDownList ID="ddStud" runat="server" AutoPostBack="false">
                    <asp:ListItem Value="0">MSC</asp:ListItem>
                    <asp:ListItem Value="1">BSC</asp:ListItem>
                    <asp:ListItem Value="2">JRc</asp:ListItem>
                    <asp:ListItem Value="3">All</asp:ListItem>
                </asp:DropDownList>

                <label for="supplier">Supplier:</label>
                <asp:TextBox ID="supplier" runat="server" type="text" required="true"></asp:TextBox>

                <label for="quantity">Quantity:</label>
                <asp:TextBox ID="quantity" runat="server" type="text" required="true"></asp:TextBox>

                <label for="pPrice">Purchase Price:</label>
                <asp:TextBox ID="pPrice" runat="server" type="text" required="true"></asp:TextBox>

                <label for="avilable">Avilable:</label>
                <asp:TextBox ID="avilable" runat="server" type="text" required="true"></asp:TextBox>

                <label for="eDate">Expiration Date:</label>
                <asp:TextBox ID="eDate" runat="server" type="text" required="true"></asp:TextBox>

                <asp:Button ID="insertBtn" runat="server" OnClick="insertData" Text="Create" />
            </div>
        </div>
    </div>
    <section class="inventory-section">
        <h2>View Inventory</h2>
        <table id="inventoryTable">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Available</th>
                    <th>Location</th>
                    <th>Supplier</th>
                    <th>Expiration date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Table rows will be dynamically populated here -->
            </tbody>
        </table>
    </section>
</asp:Content>
