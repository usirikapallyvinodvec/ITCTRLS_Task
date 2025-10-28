<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ITCTRLS_Task.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>

  
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #eef3ff, #dce6ff);
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #004aad;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .grid-container {
            width: 95%;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow-x: auto; 
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px; 
        }

        .gridview th {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: left;
            white-space: nowrap;
        }

        .gridview td {
            border: 1px solid #ccc;
            padding: 10px;
            vertical-align: middle;
            word-wrap: break-word;
        }

        img.app-photo {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
        }

       
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            margin: 2px;
        }

        .btn-view { background-color: #17a2b8; color: white; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; color: white; }

        .btn-logout {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 18px;
            margin-top: 20px;
            float: right;
            cursor: pointer;
        }

      
        .details-panel, .edit-panel {
            display: none;
            margin-top: 20px;
            background-color: #f9fbff;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #cfd8dc;
        }

        .details-panel h3, .edit-panel h3 {
            color: #007bff;
            margin-bottom: 10px;
        }

        .edit-panel input {
            width: 100%;
            margin-bottom: 8px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn-update {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
        }

     
        @media screen and (max-width: 768px) {
            body {
                padding: 10px;
            }

            .grid-container {
                padding: 10px;
            }

            h2 {
                font-size: 20px;
            }

            .gridview {
                font-size: 13px;
                min-width: 600px;
            }

            .btn {
                padding: 4px 8px;
                font-size: 12px;
            }

            .btn-logout {
                width: 100%;
                float: none;
                display: block;
                margin: 20px auto 0 auto;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <h2>Admin Dashboard - Applicant Details</h2>

   
        <div class="grid-container">
            <asp:GridView ID="GridViewApplicants" runat="server" AutoGenerateColumns="False"
                CssClass="gridview" OnRowCommand="GridViewApplicants_RowCommand">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="Age" HeaderText="Age" />
                    <asp:BoundField DataField="Education" HeaderText="Education" />
                    <asp:BoundField DataField="Languages" HeaderText="Languages" />
                    <asp:BoundField DataField="FatherName" HeaderText="Father Name" />
                    <asp:BoundField DataField="MobileNumber" HeaderText="Mobile No." />
                    <asp:BoundField DataField="Email" HeaderText="Email" />

                    <asp:ImageField DataImageUrlField="PhotoPath"
                        DataImageUrlFormatString="~/Uploads/{0}"
                        HeaderText="Photo"
                        NullDisplayText="No Photo"
                        AlternateText="No Image"
                        ControlStyle-Width="80"
                        ControlStyle-Height="80" />

                    <asp:BoundField DataField="MessageBox" HeaderText="Message" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button runat="server" CommandName="View" CommandArgument='<%# Eval("Email") %>'
                                Text="View" CssClass="btn btn-view" />
                            <asp:Button runat="server" CommandName="EditRow" CommandArgument='<%# Eval("Email") %>'
                                Text="Edit" CssClass="btn btn-edit" />
                            <asp:Button runat="server" CommandName="Del" CommandArgument='<%# Eval("Email") %>'
                                Text="Delete" CssClass="btn btn-delete"
                                OnClientClick="return confirm('Are you sure you want to delete this record?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="details-panel" id="DetailsPanel" runat="server">
                <div style="display:flex;justify-content:space-between;align-items:center;">
                    <h3>Applicant Details</h3>
                    <button type="button" onclick="closeDetails()" style="background:none;border:none;font-size:20px;cursor:pointer;">&times;</button>
                </div>
                <asp:Literal ID="LiteralDetails" runat="server"></asp:Literal>
            </div>

            <div class="edit-panel" id="EditPanel" runat="server">
                <h3>Edit Applicant Details</h3>
                <asp:HiddenField ID="HiddenEmail" runat="server" />
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name"></asp:TextBox>
                <asp:TextBox ID="txtAge" runat="server" placeholder="Age"></asp:TextBox>
                <asp:TextBox ID="txtEducation" runat="server" placeholder="Education"></asp:TextBox>
                <asp:TextBox ID="txtLanguages" runat="server" placeholder="Languages"></asp:TextBox>
                <asp:TextBox ID="txtFatherName" runat="server" placeholder="Father Name"></asp:TextBox>
                <asp:TextBox ID="txtMobileNumber" runat="server" placeholder="Mobile Number"></asp:TextBox>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
                <asp:TextBox ID="txtMessage" runat="server" placeholder="Message"></asp:TextBox>
                <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn-update" OnClick="BtnUpdate_Click" />
            </div>
        </div>

        <asp:Button ID="BtnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="BtnLogout_Click" />
    </form>

    <script>
        function closeDetails() {
            document.getElementById('<%= DetailsPanel.ClientID %>').style.display = 'none';
        }
    </script>
</body>
</html>
