<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LabManagement.Dashboard.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

        $(document).ready(function () {
            if (typeof jQuery === 'undefined' || typeof jQuery.ui === 'undefined') {
                console.error('jQuery or jQuery UI is not loaded correctly.');
            } else {
                $('#eDate').datepicker({
                    dateFormat: 'yy-mm-dd',
                    autoclose: true,
                    todayHighlight: true
                });
                $('#eDateUpdate').datepicker({
                    dateFormat: 'yy-mm-dd',
                    autoclose: true,
                    todayHighlight: true
                });
            }

            function clearFormInputs() {
                $("#code").val("");
                $("#name").val("");
                $("#supplier").val("");
                $("#quantity").val("");
                $("#pPrice").val("");
                $("#avilable").val("");
                $("#eDate").val("");
                $("#codeUpdate").val("");
                $("#nameUpdate").val("");
                $("#supplierUpdate").val("");
                $("#quantityUpdate").val("");
                $("#pPriceUpdate").val("");
                $("#avilableUpdate").val("");
                $("#eDateUpdate").val("");
            }

            function loadCategories() {
                $.ajax({
                    url: "../api/categories",
                    type: "GET",
                    success: function (data) {
                        $("#ddCat").empty();
                        $.each(data, function (index, category) {
                            $("#ddCat").append($('<option></option>').val(category.Id).text(category.Name));
                        });
                    },
                    error: function (error) {
                        console.error("Error fetching categories:", error);
                        alert("Error fetching categories.");
                    }
                });
            }

            function loadCategoriesForUpdate() {
                $.ajax({
                    url: "../api/categories",
                    type: "GET",
                    success: function (data) {
                        $("#ddCatUpdate").empty();
                        $.each(data, function (index, category) {
                            $("#ddCatUpdate").append($('<option></option>').val(category.Id).text(category.Name));
                        });
                    },
                    error: function (error) {
                        console.error("Error fetching categories for update:", error);
                        alert("Error fetching categories for update.");
                    }
                });
            }

            loadCategories();

            function loadItemsFromApi() {
                $.ajax({
                    url: "../api/items",
                    type: "GET",
                    success: function (data) {
                        displayItemsInTable(data);
                    },
                    error: function (error) {
                        console.error("Error fetching items:", error);
                        alert("Error fetching items.");
                    }
                });
            }

            function displayItemsInTable(items) {
                $("#inventoryTable tbody").empty();

                $.each(items, function (index, item) {
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
            loadItemsFromApi();

            $("#insertBtn").click(function () {
                var inputDate = $('#eDate').val();

                if (!moment(inputDate, 'YYYY-MM-DD', true).isValid()) {
                    alert('Please enter a valid date in YYYY-MM-DD format.');
                    return;
                }
                var newItem = {
                    Code: $("#code").val(),
                    Name: $("#name").val(),
                    CategoryId: $("#ddCat").val(),
                    ForStud: $("#ddStud").val(),
                    Supplier: $("#supplier").val(),
                    Quantity: $("#quantity").val(),
                    PurchesePrice: $("#pPrice").val(),
                    Available: $("#avilable").val(),
                    ExpirationDate: inputDate,
                    LastUpdate: null
                };

                $.ajax({
                    url: "../api/items",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(newItem),
                    success: function (data) {
                        loadItemsFromApi();
                        clearFormInputs();
                    },
                    error: function (error) {
                        console.error("Error inserting item:", error);
                        alert("Error inserting item.");
                    }
                });
            });

            $('#updateItemModal').on('show.bs.modal', function (event) {
                loadCategoriesForUpdate();

                var button = $(event.relatedTarget);
                var itemId = button.data('id');

                $.ajax({
                    url: "../api/items/" + itemId,
                    type: "GET",
                    success: function (data) {
                        $("#codeUpdate").val(data.Code);
                        $("#nameUpdate").val(data.Name);
                        $("#ddCatUpdate").val(data.CategoryId);
                        $("#ddStudUpdate").val(data.ForStud);
                        $("#supplierUpdate").val(data.Supplier);
                        $("#quantityUpdate").val(data.Quantity);
                        $("#pPriceUpdate").val(data.PurchesePrice);
                        $("#avilableUpdate").val(data.Available);
                        $("#eDateUpdate").datepicker("setDate", new Date(data.ExpirationDate));
                    },
                    error: function () {
                        alert("Error fetching item details for update.");
                    }
                });
            });

            $("#inventoryTable").on("click", ".edit-link", function () {
                var itemId = $(this).data("id");

                // Fetch item details by ID and populate the update modal
                $.ajax({
                    url: "../api/items/" + itemId,
                    type: "GET",
                    success: function (data) {
                        $("#codeUpdate").val(data.Code);
                        $("#nameUpdate").val(data.Name);
                        $('#updateItemModal').modal('show');
                    },
                    error: function (error) {
                        console.error("Error fetching item details for update:", error);
                        alert("Error fetching item details for update.");
                    }
                });
            });

            $("#insertBtnUpdate").click(function () {
                var updatedItem = {
                    Code: $("#codeUpdate").val(),
                    Name: $("#nameUpdate").val(),
                    CategoryId: $("#ddCatUpdate").val(),
                    ForStud: $("#ddStudUpdate").val(),
                    Supplier: $("#supplierUpdate").val(),
                    Quantity: $("#quantityUpdate").val(),
                    PurchesePrice: $("#pPriceUpdate").val(),
                    Available: $("#avilableUpdate").val(),
                    ExpirationDate: $("#eDateUpdate").val(),
                    LastUpdate: null // You might want to set this value if needed
                };

                var currentItemId = $(this).data("id");

                $.ajax({
                    url: "../api/items/" + currentItemId,
                    type: "PUT",
                    contentType: "application/json",
                    data: JSON.stringify(updatedItem),
                    success: function () {
                        $('#updateItemModal').modal('hide');
                        loadItemsFromApi();
                        clearFormInputs();
                    },
                    error: function () {
                        alert("Error updating item.");
                    }
                });
            });


            $("#inventoryTable").on("click", ".delete-link", function () {
                var itemId = $(this).data("id");

                if (confirm("Are you sure you want to delete this item?")) {
                    $.ajax({
                        url: "../api/items/" + itemId,
                        type: "DELETE",
                        success: function () {
                            loadItemsFromApi();
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

    <div class="modal fade" id="updateItemModal" tabindex="-1" role="dialog" aria-labelledby="updateItemModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateItemModalLabel">Update Item</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="codeUpdate" class="form-label">Code:</label>
                        <input id="codeUpdate" type="text" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="nameUpdate" class="form-label">Name:</label>
                        <input id="nameUpdate" type="text" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="ddCatUpdate" class="form-label">Category:</label>
                        <select id="ddCatUpdate" class="form-control"></select>
                    </div>
                    <div class="form-group">
                        <label for="ddStudUpdate" class="form-label">For Students:</label>
                        <select id="ddStudUpdate" class="form-control">
                            <option value="0">MSC</option>
                            <option value="1">BSC</option>
                            <option value="2">JRc</option>
                            <option value="3">All</option>
                        </select>
                    </div>
                    <!-- Other input fields and form groups -->
                    <div class="form-group">
                        <label for="eDateUpdate" class="form-label">Expiration Date:</label>
                        <input id="eDateUpdate" type="text" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="insertBtnUpdate" type="button" class="btn btn-primary">Update</button>
                    <button id="closeBtnUpdate" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>



    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">Add new item</h3>
                        <form>
                            <div class="mb-3">
                                <label for="code" class="form-label">Code:</label>
                                <input id="code" type="text" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="name" class="form-label">Name:</label>
                                <input id="name" type="text" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="ddCat" class="form-label">Category:</label>
                                <select id="ddCat" class="form-select"></select>
                            </div>
                            <div class="mb-3">
                                <label for="ddStud" class="form-label">For Students:</label>
                                <select id="ddStud" class="form-select">
                                    <option value="0">MSC</option>
                                    <option value="1">BSC</option>
                                    <option value="2">JRc</option>
                                    <option value="3">All</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="supplier" class="form-label">Supplier:</label>
                                <input id="supplier" type="text" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="quantity" class="form-label">Quantity:</label>
                                <input id="quantity" type="text" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="pPrice" class="form-label">Purchase Price:</label>
                                <input id="pPrice" type="text" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="avilable" class="form-label">Available:</label>
                                <input id="avilable" type="text" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="eDate" class="form-label">Expiration Date:</label>
                                <input id="eDate" type="text" class="form-control">
                            </div>
                            <div class="d-grid">
                                <button id="insertBtn" type="button" class="btn btn-primary">Create</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <table id="inventoryTable" class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Code</th>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Available</th>
                            <th>Supplier</th>
                            <th>Expiration date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Categories will be dynamically populated here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
