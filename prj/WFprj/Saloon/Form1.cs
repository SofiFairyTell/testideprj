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
                    return "Connected";
                       // Console.WriteLine("Connected");
                    }
                    return "Not connected";
                }
            }

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
                return new NpgsqlConnection(@"Host=localhost;Port=5433;User Id=postgres; Password=root; Database=mag");
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
    }
    }
