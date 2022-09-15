using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
namespace Saloon
{
    static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }

        //private static void TestConnection()
        //{
        //    using (NpgsqlConnection con=GetConnection())
        //    {
        //        if(con.State==System.Data.ConnectionState.Open)
        //        {
        //            Console.WriteLine("Connected");
        //        }
        //    }
        //}
        //private static NpgsqlConnection GetConnection()
        //{
        //    return new NpgsqlConnection(@"Server=localhost;Port=5432;User Id=postgres; Password=root; Database=mag");
        //}
    }
}
