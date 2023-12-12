<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="LabManagement.Dashboard.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

        .cat, .catUpdate {
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

        .catCont, .catUpdateCont {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
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

        .cat {
            display: none;
        }
    </style>
    <script>
        $(document).ready(function () {
            var currentCategoryId;
            var $cat = $(".cat");
            var $catUpdate = $(".catUpdate");
            var $categoriesTable = $("#categoriesTable tbody");

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

                    $catUpdate.hide();
                });
            }

            function showCategoryForm($form) {
                $form.show();
            }

            function hideCategoryForm($form) {
                $form.hide();
            }

            function clearFormInputs() {
                $(".form-control").val("");
            }

            loadCategories();

            $("#createBtn").click(function () {
                showCategoryForm($cat);
            });

            $("#closeBtn").click(function () {
                hideCategoryForm($cat);
            });

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
                        clearFormInputs();
                        hideCategoryForm($cat);
                        loadCategories();
                    },
                    error: function (error) {
                        console.error("Error creating category:", error);
                        alert("Error creating category.");
                    }
                });
            });

            $categoriesTable.on("click", ".edit", function () {
                currentCategoryId = $(this).data("id");
                showCategoryForm($catUpdate);

                $.get("../api/categories/" + currentCategoryId, function (data) {
                    $("#cNameUpdate").val(data.Name);
                    $("#cDecUpdate").val(data.Description);
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
                        clearFormInputs();
                        hideCategoryForm($catUpdate);
                        loadCategories();
                    },
                    error: function (error) {
                        console.error("Error updating category:", error);
                        alert("Error updating category.");
                    }
                });
            });

            $("#closeUpdateBtn").click(function () {
                hideCategoryForm($catUpdate);
            });

        });

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
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
                    <button id="closeBtn" type="button" class="btn btn-primary">Close</button>
                </div>
            </div>
        </div>

        <div class="catUpdate">
            <div class="catUpdateCont">
                <div class="form-group">
                    <label for="cNameUpdate">Category Name:</label>
                    <input id="cNameUpdate" type="text" class="form-control" />
                </div>

                <div class="form-group">
                    <label for="cDecUpdate">Description:</label>
                    <textarea id="cDecUpdate" class="form-control" rows="3"></textarea>
                </div>

                <div style="display: flex; flex-direction: row">
                    <button id="UpdateBtn" type="button" class="btn btn-primary">Update</button>
                    <button id="closeUpdateBtn" type="button" class="btn btn-primary">Close</button>
                </div>
            </div>
        </div>

        <button id="createBtn">Add category</button>

        <table id="categoriesTable">
            <thead>
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

</asp:Content>
