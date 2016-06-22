<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/default.css">

</head>
<body>
    <form id="form1" runat="server">


        <!--Search  -->
        <div class="Search">
        
        <asp:TextBox ID="search" runat="server" placeholder="Search by First Name" ></asp:TextBox>
        <asp:Button ID="Button2" runat="server" OnClick="searchlist" Text="Search" CausesValidation="False"  cssclass="btn btn-info btn-lg"/>
        </div>
        <!--Create Users  -->
        <div class="Create">
        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Create User</button>
        </div>

        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Create User</h4>
                </div>
                <div class="modal-body">
                <label>First Name:</label>
                <asp:TextBox ID="fname" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="fnameRequired" runat="server" ControlToValidate="fname"
                ErrorMessage="First Name is a required field" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />

                <label>Last Name:</label>
                <asp:TextBox ID="lname" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="lnameRequired" runat="server" ControlToValidate="lname"
                ErrorMessage="Last Name is a required field" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />

                <label>Username:</label>
                <asp:TextBox ID="userName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="userNameRequired" runat="server" ControlToValidate="userName"
                ErrorMessage="Username is a required field" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />

                <label>Email:</label>
                <asp:TextBox ID="email" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="emailRequired" runat="server" ControlToValidate="email"
                ErrorMessage="Email is a required field" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="emailValdiation" runat="server"  ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ControlToValidate="email" ErrorMessage="Input a valid Email!"></asp:RegularExpressionValidator>
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button ID="Button1" CssClass="btn btn-default" runat="server" Text="Create" OnClick="Button1_Click" />
                </div>
            </div>
            </div>

        </div>

        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" AllowSorting="true">
          
            <EmptyDataTemplate>
                <table runat="server" class="table table-striped">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
 
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Label ID="user_fnameLabel" runat="server" Text='<%# Eval("user_fname") + " " + Eval("user_lname")  + "<br /> " +  Eval("username")%>'  />
                    </td>
                   
                    <td>
                        <asp:Label ID="user_emailLabel" runat="server" Text='<%# Eval("user_email") %>' />
                    </td>
                    <td>
                        <asp:Label ID="date_joinedLabel" runat="server" Text='<%# Eval("date_joined") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server" >
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table table-striped table-hover" >
                                <tr runat="server" style="">
                                    <th runat="server">Name </th>
                                    <th runat="server">Email</th>
                                    <th runat="server">Joined</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style=""></td>
                    </tr>
                </table>
            </LayoutTemplate>
           
        </asp:ListView>
        
        
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DNNAssingmentConnectionString %>" SelectCommand="SELECT * FROM [Accounts]"></asp:SqlDataSource>
    
    
    </form>
</body>
</html>
