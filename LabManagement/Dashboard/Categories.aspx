<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="LabManagement.Dashboard.WebForm3" %>

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
            var currentCategoryId;
            var $categoriesTable = $("#categoriesTable tbody");

            function clearFormInputs() {
                $("#cName").val("");
                $("#cDec").val("");
                $("#cNameUpdate").val("");
                $("#cDecUpdate").val("");
            }

            function loadCategories() {
                $.get("../api/categories", function (data) {
                    $categoriesTable.empty();

                    $.each(data, function (index, category) {
                        var row = `<tr>
                                <td>${category.Name}</td>
                                <td>${category.Description || ""}</td>
                                <td>
                                    <a href='#' class='edit' data-id='${category.Id}'>Edit</a>
                                    <a href='#' class='delete' data-id='${category.Id}'>Delete</a>
                                </td>
                            </tr>`;
                        $categoriesTable.append(row);
                    });
                });
            }

            loadCategories();

            $("#insertBtn").click(function (e) {
                e.preventDefault();

                var categoryName = $("#cName").val();
                var categoryDescription = $("#cDec").val();

                $.ajax({
                    url: "../api/categories",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Name: categoryName, Description: categoryDescription }),
                    success: function () {
                        loadCategories();
                        clearFormInputs();
                    },
                    error: function (error) {
                        console.error("Error creating category:", error);
                        alert("Error creating category.");
                    }
                });
            });

            $categoriesTable.on("click", ".edit", function () {
                currentCategoryId = $(this).data("id");
                $.get("../api/categories/" + currentCategoryId, function (data) {
                    $("#cNameUpdate").val(data.Name);
                    $("#cDecUpdate").val(data.Description);
                    $('#editCategoryModal').modal('show');
                });
            });

            $categoriesTable.on("click", ".delete", function () {
                var categoryId = $(this).data("id");

                if (confirm("Are you sure you want to delete this category?")) {
                    $.ajax({
                        url: "../api/categories/" + categoryId,
                        type: "DELETE",
                        success: function () {
                            loadCategories();
                        },
                        error: function () {
                            alert("Error deleting category.");
                        }
                    });
                }
            });

            $("#UpdateBtn").click(function (e) {
                e.preventDefault();

                var categoryName = $("#cNameUpdate").val();
                var categoryDescription = $("#cDecUpdate").val();

                $.ajax({
                    url: "../api/categories/" + currentCategoryId,
                    type: "PUT",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Id: currentCategoryId, Name: categoryName, Description: categoryDescription }),
                    success: function () {
                        loadCategories();
                        clearFormInputs();
                    },
                    error: function (error) {
                        console.error("Error updating category:", error);
                        alert("Error updating category.");
                    }
                });
            });

        });

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="modal" id="editCategoryModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Category</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="cNameUpdate">Category Name:</label>
                        <input id="cNameUpdate" type="text" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="cDecUpdate">Description:</label>
                        <textarea id="cDecUpdate" class="form-control" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="UpdateBtn" type="button" class="btn btn-primary">Update</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="cat">
                    <div class="catCont">
                        <div class="form-group">
                            <label for="cName">Category Name:</label>
                            <input id="cName" type="text" class="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="cDec">Description:</label>
                            <textarea id="cDec" class="form-control" rows="3"></textarea>
                        </div>

                        <div style="display: flex; flex-direction: row">
                            <button id="insertBtn" type="button" class="btn btn-primary">Create</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <table id="categoriesTable" class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Category Name</th>
                            <th>Description</th>
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
