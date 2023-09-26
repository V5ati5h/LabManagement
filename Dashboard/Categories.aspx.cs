using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Reflection;
using System.Security.Cryptography;
using System.Xml.Linq;

namespace LabManagement.Dashboard
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["strcon"].ConnectionString);
            loadData();
        }

        protected void insertData(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Tbl_Categories(name, description, lastUpdate) VALUES (@name, @dec, @date);", conn)
                {
                    CommandType = CommandType.Text
                };
                cmd.Parameters.AddWithValue("@name", cName.Text);
                cmd.Parameters.AddWithValue("@dec", cDec.Text);
                cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString());
                conn.Open();
                int k = cmd.ExecuteNonQuery();
                if (k != 0)
                {
                    Response.Redirect("Categories.aspx");
                }
                conn.Close();

            }
            catch (Exception ex)
            {
            }
        }

        protected void loadData()
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Tbl_Categories", conn);
            cmd.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter dsa = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dsa.Fill(dt);
            gridview.DataSource = dt;
            gridview.DataBind();
            conn.Close();
        }

        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridview.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            gridview.EditIndex = e.NewEditIndex;
            loadData();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = gridview.Rows[e.RowIndex];
                int id = Convert.ToInt32(gridview.DataKeys[e.RowIndex].Values[0]);
                string name = (row.Cells[2].Controls[0] as TextBox).Text;
                string description = (row.Cells[3].Controls[0] as TextBox).Text;
                SqlCommand cmd = new SqlCommand("UPDATE Tbl_Categories SET name=@name, description=@description, lastUpdate=@lastUpdate WHERE id=@id;", conn)
                {
                    CommandType = CommandType.Text
                };
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@lastUpdate", DateTime.Now.ToString());
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                gridview.EditIndex = -1;
                Response.Redirect("Categories.aspx");
            }
            catch (Exception ex)
            {

            }
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            gridview.EditIndex = -1;
            loadData();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gridview.Rows[e.RowIndex];
            int id = Convert.ToInt32(gridview.DataKeys[e.RowIndex].Values[0]);
            SqlCommand cmd = new SqlCommand("Delete From Tbl_Categories where id = @id;", conn)
            {
                CommandType = CommandType.Text
            };
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("Categories.aspx");
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != gridview.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }
    }
}