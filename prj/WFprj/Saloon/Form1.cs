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
            private static void TestConnection()
            {
                using (NpgsqlConnection con = GetConnection())
                {
                    con.Open();
                    if (con.State == System.Data.ConnectionState.Open)
                    {
                        Console.WriteLine("Connected");
                    }
                }
            }
            private static NpgsqlConnection GetConnection()
            {
                return new NpgsqlConnection(@"Host=localhost;Port=5433;User Id=postgres; Password=root; Database=mag");
            }
            private void Form1_Load(object sender, EventArgs e)
            {
                TestConnection();
            }
        }
    }
