
namespace Saloon
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnConnectDB = new System.Windows.Forms.Button();
            this.tbResult = new System.Windows.Forms.TextBox();
            this.btnDisConnectDB = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnConnectDB
            // 
            this.btnConnectDB.Location = new System.Drawing.Point(247, 28);
            this.btnConnectDB.Name = "btnConnectDB";
            this.btnConnectDB.Size = new System.Drawing.Size(157, 23);
            this.btnConnectDB.TabIndex = 0;
            this.btnConnectDB.Text = "Подключиться к БД";
            this.btnConnectDB.UseVisualStyleBackColor = true;
            this.btnConnectDB.Click += new System.EventHandler(this.btnConnectDB_Click);
            // 
            // tbResult
            // 
            this.tbResult.Location = new System.Drawing.Point(33, 28);
            this.tbResult.Name = "tbResult";
            this.tbResult.Size = new System.Drawing.Size(178, 23);
            this.tbResult.TabIndex = 1;
            // 
            // btnDisConnectDB
            // 
            this.btnDisConnectDB.Location = new System.Drawing.Point(421, 28);
            this.btnDisConnectDB.Name = "btnDisConnectDB";
            this.btnDisConnectDB.Size = new System.Drawing.Size(157, 23);
            this.btnDisConnectDB.TabIndex = 2;
            this.btnDisConnectDB.Text = "Отключится от БД";
            this.btnDisConnectDB.UseVisualStyleBackColor = true;
            this.btnDisConnectDB.Click += new System.EventHandler(this.btnDisConnectDB_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnDisConnectDB);
            this.Controls.Add(this.tbResult);
            this.Controls.Add(this.btnConnectDB);
            this.Name = "Form1";
            this.Text = "Мой салон";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnConnectDB;
        public System.Windows.Forms.TextBox tbResult;
        private System.Windows.Forms.Button btnDisConnectDB;
    }
}

