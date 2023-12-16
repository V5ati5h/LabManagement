<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="LabManagement.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <style>
        body {
            overflow: hidden;
        }

        .center-div {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 50%;
        }

        .custom-button {
            margin-top: 3px;
            width: 45%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container center-div">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title text-center">Login</h3>
                </div>
                <div class="card-body">
                    <form>
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input id="username" type="text" class="form-control" name="username" />
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input id="password" type="password" class="form-control" name="password" />
                        </div>
                        <div class="text-center">
                            <button id="loginBtn" type="button" class="btn btn-primary custom-button" onclick="submitLoginForm()">Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        function submitLoginForm() {
            var username = document.getElementById('username').value;
            var password = document.getElementById('password').value;

            var hardcodedUsername = 'Admin';
            var hardcodedPassword = 'admin';

            if (username === hardcodedUsername && password === hardcodedPassword) {
                alert('Login Successful! Redirecting to dashboard.');

                // Store authorization information in session storage
                sessionStorage.setItem('authorized', 'true');

                window.location.href = 'dashboard/'; // Redirect to the dashboard page
            } else {
                alert('Invalid username or password.');
            }
        }
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</asp:Content>
