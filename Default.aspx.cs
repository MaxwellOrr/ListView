using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private string searchTxt;

    public bool EmailCheck(string Email)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DNNAssingmentConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand();

        //Create SQL command for checking emails
        cmd.CommandText = "SELECT *  FROM Accounts WHERE user_email = @Email";

        //Uses the Email variable and creates a new sql variable for use in the sql commandtext
        cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = Email;

        cmd.Connection = conn;

        conn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        while(dr.Read())
        {
            if (dr.HasRows == true)
            {
                string script = "alert(\"Email Already Exists!\");";
                ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", script, true);
                return true; //Returnr True if Email already exists
            }

        }
        return false; //Return False if Email does not exists
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //Validate all fields
        fnameRequired.Validate();
        lnameRequired.Validate();
        userNameRequired.Validate();
        emailRequired.Validate();
        emailValdiation.Validate();
        
        //Assign all variables from text fields
        string FirstName = fname.Text;
        string LastName = lname.Text;
        string UserName = userName.Text;
        string Email = email.Text;
        if(EmailCheck(Email))
        {
            return;

        }

        
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DNNAssingmentConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand();

       
        cmd.CommandText = "INSERT INTO Accounts (user_fname, user_lname, username, user_email, date_joined) VALUES (@FirstName, @LastName, @UserName, @Email, @DateJoined)";

        //Uses the values from textfield variable and creates a new sql variable for use in the sql commandtext
        cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = FirstName;
        cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = LastName;
        cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = UserName;
        cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = Email;
        cmd.Parameters.Add("@DateJoined", SqlDbType.DateTime).Value = DateTime.Now;
        cmd.Connection = conn;

        conn.Open();

        cmd.ExecuteNonQuery();

        conn.Close();
        ListView1.DataBind();

        //Clear textboxes after the listview has been updated
        fname.Text = "";
        lname.Text = "";
        userName.Text = "";
        email.Text = "";
    }






    protected void searchlist(object sender, EventArgs e)
    {
       
        ListView1.DataSourceID = null;

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DNNAssingmentConnectionString"].ToString()))
        {


            string Sql1 = "SELECT  * FROM Accounts WHERE user_fname Like @search";
            conn.Open();
            using (SqlDataAdapter Madpt = new SqlDataAdapter(Sql1, conn))
            {

                //Create new datasource using the sql query created from search textbox
                Madpt.SelectCommand.Parameters.AddWithValue("@search", "%" + search.Text.Trim() + "%");
                DataTable dTable = new DataTable();
                Madpt.Fill(dTable);
                Session["SearchResults"] = dTable;
                ListView1.DataSource = Session["SearchResults"];
                ListView1.DataBind();
            }


            conn.Close();
        }


    }
}
