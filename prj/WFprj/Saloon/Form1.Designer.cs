
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
            this.gbParam = new System.Windows.Forms.GroupBox();
            this.tbUID = new System.Windows.Forms.TextBox();
            this.lbUID = new System.Windows.Forms.Label();
            this.btnFind = new System.Windows.Forms.Button();
            this.gbResult = new System.Windows.Forms.GroupBox();
            this.tbResFind = new System.Windows.Forms.TextBox();
            this.gbParam.SuspendLayout();
            this.gbResult.SuspendLayout();
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
            // gbParam
            // 
            this.gbParam.Controls.Add(this.tbUID);
            this.gbParam.Controls.Add(this.lbUID);
            this.gbParam.Controls.Add(this.btnFind);
            this.gbParam.Location = new System.Drawing.Point(33, 86);
            this.gbParam.Name = "gbParam";
            this.gbParam.Size = new System.Drawing.Size(237, 241);
            this.gbParam.TabIndex = 3;
            this.gbParam.TabStop = false;
            this.gbParam.Text = "Параметры поиска";
            // 
            // tbUID
            // 
            this.tbUID.Location = new System.Drawing.Point(87, 36);
            this.tbUID.Name = "tbUID";
            this.tbUID.Size = new System.Drawing.Size(132, 23);
            this.tbUID.TabIndex = 3;
            // 
            // lbUID
            // 
            this.lbUID.AutoSize = true;
            this.lbUID.Location = new System.Drawing.Point(7, 36);
            this.lbUID.Name = "lbUID";
            this.lbUID.Size = new System.Drawing.Size(73, 15);
            this.lbUID.TabIndex = 2;
            this.lbUID.Text = "UID клиента";
            // 
            // btnFind
            // 
            this.btnFind.Location = new System.Drawing.Point(21, 212);
            this.btnFind.Name = "btnFind";
            this.btnFind.Size = new System.Drawing.Size(157, 23);
            this.btnFind.TabIndex = 1;
            this.btnFind.Text = "Искать";
            this.btnFind.UseVisualStyleBackColor = true;
            this.btnFind.Click += new System.EventHandler(this.btnFind_Click);
            // 
            // gbResult
            // 
            this.gbResult.Controls.Add(this.tbResFind);
            this.gbResult.Location = new System.Drawing.Point(304, 86);
            this.gbResult.Name = "gbResult";
            this.gbResult.Size = new System.Drawing.Size(237, 241);
            this.gbResult.TabIndex = 4;
            this.gbResult.TabStop = false;
            this.gbResult.Text = "Результаты поиска";
            // 
            // tbResFind
            // 
            this.tbResFind.Location = new System.Drawing.Point(19, 36);
            this.tbResFind.Multiline = true;
            this.tbResFind.Name = "tbResFind";
            this.tbResFind.Size = new System.Drawing.Size(212, 180);
            this.tbResFind.TabIndex = 0;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(590, 450);
            this.Controls.Add(this.gbResult);
            this.Controls.Add(this.gbParam);
            this.Controls.Add(this.btnDisConnectDB);
            this.Controls.Add(this.tbResult);
            this.Controls.Add(this.btnConnectDB);
            this.Name = "Form1";
            this.Text = "Мой салон";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.gbParam.ResumeLayout(false);
            this.gbParam.PerformLayout();
            this.gbResult.ResumeLayout(false);
            this.gbResult.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnConnectDB;
        public System.Windows.Forms.TextBox tbResult;
        private System.Windows.Forms.Button btnDisConnectDB;
        private System.Windows.Forms.GroupBox gbParam;
        private System.Windows.Forms.GroupBox gbResult;
        private System.Windows.Forms.TextBox tbUID;
        private System.Windows.Forms.Label lbUID;
        private System.Windows.Forms.Button btnFind;
        private System.Windows.Forms.TextBox tbResFind;
    }
}

