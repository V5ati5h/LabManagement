<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="LabManagement.Dashboard.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Categories</h2>
        <div class="category-form">
            <h3>Create New Category</h3>
            <form id="createCategoryForm">
                <label for="categoryName">Category Name:</label>
                <input type="text" id="categoryName" required>
                <label for="categoryDescription">Description:</label>
                <textarea id="categoryDescription" required></textarea>
                <button type="submit">Create</button>
            </form>
        </div>
        <div class="category-list">
            <!-- Category list will be displayed here using JavaScript -->
        </div>
    </div>
</asp:Content>
