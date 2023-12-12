<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LabManagement.Dashboard.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .container {
            height: 100vh;
            width: 70vw;
            margin: auto;
        }

        .items, .itemsUpdate {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            background-color: rgba(0, 0, 0, 0.32);
            opacity: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 99988;
        }

        .itemsCont, .itemsUpdateCont {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        button {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 15px;
            margin: 0.5rem;
            border: none;
            cursor: pointer;
        }

            button:hover {
                background-color: #0056b3;
            }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        $(document).ready(function () {
            // Function to load categories into dropdown
            function loadCategories(ddElement) {
                // Simulate categories data
                var categories = [
                    { Id: 1, Name: "Category 1" },
                    { Id: 2, Name: "Category 2" },
                    // Add more categories as needed
                ];

                ddElement.empty(); // Clear existing options

                // Add default option
                ddElement.append($("<option></option>").val("").text("Select Category"));

                // Add categories to the dropdown
                $.each(categories, function (index, category) {
                    ddElement.append($("<option></option>").val(category.Id).text(category.Name));
                });
            }

            // Function to simulate loading items
            function loadItems() {
                // Simulate item data
                var data = [
                    { Code: "001", Name: "Item 1", Quantity: 10, Available: 5, Supplier: "Supplier 1", ExpirationDate: "2023-12-31", Id: 1 },
                    { Code: "002", Name: "Item 2", Quantity: 20, Available: 15, Supplier: "Supplier 2", ExpirationDate: "2023-12-31", Id: 2 },
                    // Add more items as needed
                ];

                $("#inventoryTable tbody").empty();

                $.each(data, function (index, item) {
                    var row = "<tr>" +
                        "<td>" + item.Code + "</td>" +
                        "<td>" + item.Name + "</td>" +
                        "<td>" + item.Quantity + "</td>" +
                        "<td>" + item.Available + "</td>" +
                        "<td>" + item.Supplier + "</td>" +
                        "<td>" + item.ExpirationDate + "</td>" +
                        "<td>" +
                        "<a href='#' class='edit-link' data-id='" + item.Id + "'>Edit</a> <a href='#' class='delete-link' data-id='" + item.Id + "'>Delete</a>" +
                        "</td>" +
                        "</tr>";
                    $("#inventoryTable tbody").append(row);
                });
            }

            // Load categories for create form
            loadCategories($("#ddCat"));
            loadCategories($("#ddCatUpdate"));

            // Load items on page load
            loadItems();

            // Event handler for Create button click (Create)
            $("#insertBtn").click(function () {
                $(".items").css('visibility', 'visible');
            });

            $("#closeBtn").click(function () {
                $(".items").css('visibility', 'hidden');
            });

            // Event handler for Update button click (Update)
            $("#createBtnUpdate").click(function () {
                $(".itemsUpdate").css('visibility', 'visible');
            });

            $("#closeBtnUpdate").click(function () {
                $(".itemsUpdate").css('visibility', 'hidden');
            });

            // Event handler for Add items button click
            $("#createBtn").click(function () {
                // You can add additional functionality here
                alert("Add items button clicked");
            });

            // Other existing code...
        });
    </script>

    <!-- Your existing HTML -->


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="items">
            <div class="itemsCont">
                <h3 style="text-align: center;">Add new item</h3>
                <br />
                <div>
                    <div class="form-group">
                        <div>
                            <label for="code">Code:</label>
                            <input id="code" type="text" />
                        </div>
                        <div>
                            <label for="name">Name:</label>
                            <input id="name" type="text" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="ddCat">Category:</label>
                        <select id="ddCat"></select>

                        <label for="ddStud">For Students:</label>
                        <select id="ddStud">
                            <option value="0">MSC</option>
                            <option value="1">BSC</option>
                            <option value="2">JRc</option>
                            <option value="3">All</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <div>
                            <label for="supplier">Supplier:</label>
                            <input id="supplier" type="text" />
                        </div>
                        <div>
                            <label for="quantity">Quantity:</label>
                            <input id="quantity" type="text" />
                        </div>
                    </div>

                    <div class="form-group">
                        <div>
                            <label for="pPrice">Purchase Price:</label>
                            <input id="pPrice" type="text" />
                        </div>
                        <div>
                            <label for="avilable">Avilable:</label>
                            <input id="avilable" type="text" />
                        </div>
                    </div>

                    <label for="eDate">Expiration Date:</label>
                    <input id="eDate" type="text" />

                    <div class="form-group">
                        <button id="insertBtn" type="button" class="btn btn-primary">Create</button>
                        <button id="closeBtn" type="button" class="btn btn-primary">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="itemsUpdate">

            <div class="itemsUpdateCont">
                <h3 style="text-align: center;">Update item</h3>
                <div>
                    <div class="form-group">
                        <div>
                            <label for="codeUpdate">Code:</label>
                            <input id="codeUpdate" type="text" />
                        </div>
                        <div>
                            <label for="nameUpdate">Name:</label>
                            <input id="nameUpdate" type="text" />
                        </div>
                    </div>

                    <div class="form-group">
                        <div>
                            <label for="ddCatUpdate">Category:</label>
                            <select id="ddCatUpdate"></select>
                        </div>
                        <div>
                            <label for="ddStudUpdate">For Students:</label>
                            <select id="ddStudUpdate">
                                <option value="0">MSC</option>
                                <option value="1">BSC</option>
                                <option value="2">JRc</option>
                                <option value="3">All</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div>
                            <label for="supplierUpdate">Supplier:</label>
                            <input id="supplierUpdate" type="text" />
                        </div>
                        <div>
                            <label for="quantityUpdate">Quantity:</label>
                            <input id="quantityUpdate" type="text" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div>
                            <label for="pPriceUpdate">Purchase Price:</label>
                            <input id="pPriceUpdate" type="text" />
                        </div>
                        <div>
                            <label for="avilableUpdate">Avilable:</label>
                            <input id="avilableUpdate" type="text" />
                        </div>
                    </div>

                    <label for="eDateUpdate">Expiration Date:</label>
                    <input id="eDateUpdate" type="text" />

                    <div class="form-group">
                        <button id="insertBtnUpdate" type="button" class="btn btn-primary">Create</button>
                        <button id="closeBtnUpdate" type="button" class="btn btn-primary">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <button id="createBtn">Add items</button>
        <br />
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
    </div>

</asp:Content>
