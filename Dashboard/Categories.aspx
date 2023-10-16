<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="LabManagement.Dashboard.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // Function to load categories and populate the table
            function loadCategories() {
                $.get("../api/categories", function (data) {
                    // Clear existing table rows
                    $("#categoriesTable tbody").empty();

                    // Populate the table with received data
                    $.each(data, function (index, category) {
                        var row = "<tr>" +
                            "<td>" + category.Name + "</td>" +
                            "<td>" + (category.Description || "") + "</td>" +
                            "<td>" +
                            "<a href='#' class='edit' data-id='" + category.Id + "'>Edit</a>" +
                            "<a href='#' class='delete' data-id='" + category.Id + "'>Delete</a>" +
                            "</td>" +
                            "</tr>";
                        $("#categoriesTable tbody").append(row);
                    });
                });
            }

            // Initial load when the page is ready
            loadCategories();

            $("#insertBtn").click(function (e) {
                e.preventDefault(); // Prevent the default form submission

                var categoryName = $("#cName").val();
                var categoryDescription = $("#cDec").val();

                // Make an AJAX request to insert the category
                $.ajax({
                    url: "../api/categories",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Name: categoryName, Description: categoryDescription }),
                    success: function () {

                        // Clear input fields
                        $("#cName").val("");
                        $("#cDec").val("");

                        // Reload categories after insertion
                        loadCategories();
                    },
                    error: function (error) {
                        console.error("Error creating category:", error);  // Add this line
                        alert("Error creating category.");
                    }
                });
            });

            // Event delegation for edit and delete buttons
            $("#categoriesTable").on("click", ".edit", function () {
                var categoryId = $(this).data("id");
                // Fetch the category details and implement your edit logic here...

                // For demonstration, let's just show an alert
                alert("Edit clicked for category with ID: " + categoryId);
            });

            $("#categoriesTable").on("click", ".delete", function () {
                var categoryId = $(this).data("id");
                // Implement your delete logic here...

                // For demonstration, let's confirm deletion with an alert
                if (confirm("Are you sure you want to delete this category?")) {
                    // Make an AJAX request to delete the category
                    $.ajax({
                        url: "../api/categories/" + categoryId,
                        type: "DELETE",
                        success: function () {
                            // Reload categories after deletion
                            loadCategories();
                        },
                        error: function () {
                            alert("Error deleting category.");
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Sample CSS for Excel-like styling */
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

        /* Style for the form container */
.catCont {
    max-width: 400px;
    margin: auto;
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
textarea {
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

        /* Additional styling can be added here */
    </style>
    <div class="Holder">
        <div class="catCont">
    <div class="form-group">
        <label for="cName">Category Name:</label>
        <input id="cName" type="text" class="form-control" required />
    </div>
    
    <div class="form-group">
        <label for="cDec">Description:</label>
        <textarea id="cDec" class="form-control" rows="3" required></textarea>
    </div>

    <button id="insertBtn" type="button" class="btn btn-primary">Create</button>
</div>

        <table id="categoriesTable" >
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
