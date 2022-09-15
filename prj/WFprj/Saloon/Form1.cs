using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

    namespace Saloon
    {
    public partial class Form1 : Form
    {
        private static string ConnectionString = @"Host=localhost;Port=5433;User Id=postgres; Password=root; Database=mag";
        public Form1()
        {
            InitializeComponent();
        }
        private static string ConnectionDB()
        {
            using (NpgsqlConnection con = GetConnection())
            {
                con.Open();
                if (con.State == System.Data.ConnectionState.Open)
                {
                    con.Close();
                    return "Connected";
                    // Console.WriteLine("Connected");
                }
                return "Not connected";
            }
        }

        //This function for order... but i don't know about work of this
        private static string DisconnectionDB()
        {
            using (NpgsqlConnection con = GetConnection())
            {
                con.Close();
                if (con.State == System.Data.ConnectionState.Closed)
                {
                    return "Disconnected";
                    // Console.WriteLine("Connected");
                }
                return "Not disconnected";
            }
        }

        private static NpgsqlConnection GetConnection()
        {
            return new NpgsqlConnection(ConnectionString);
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            //TestConnection();
        }

        private void btnConnectDB_Click(object sender, EventArgs e)
        {
            tbResult.Text = ConnectionDB();
        }

        private void btnDisConnectDB_Click(object sender, EventArgs e)
        {
            tbResult.Text = DisconnectionDB();
        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            if (tbUID.Text != "")
            {
                int uid_client = Convert.ToInt32(tbUID.Text);
                string commandText = $"SELECT findwithfeedback()";
                using (NpgsqlConnection con = GetConnection())
                {
                    con.Open();
                    //NpgsqlCommand com = new NpgsqlCommand("get_client");
                    using (NpgsqlCommand cmd = new NpgsqlCommand("get_client", con))
                    {
                        //cmd.Parameters.AddWithValue("@uid_client", uid_client);
                        //cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandType = CommandType.StoredProcedure;
                        var result = cmd.ExecuteReader();
                        //result.GetName(1);
                        while(result.Read())
                        {
                            tbResFind.Text = tbResFind.Text + result["username"].ToString();
                        }
                        
                        //using (objectyreader = cmd.ExecuteScalar())
                        //    while (reader.Read())
                        //    {
                        //        tbResFind.Text = reader.ToString();
                        //    }
                    }
                }
            }
        }
    }
    }
