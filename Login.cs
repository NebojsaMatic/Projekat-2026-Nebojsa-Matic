using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Projekat_2026_Nebojsa_Matic
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // Nebojsa Matic
            comboBox1.SelectedIndex = 0;
        }

        private void btnlogin_Click(object sender, EventArgs e)
        {
            if (txtemail.Text == "" || txtlozinka.Text == "")
                    {
                MessageBox.Show("Morate uneti email i lozinku!");
            }
            else
            {
                string lokacija = comboBox1.SelectedItem.ToString();
                SqlConnection veza = Konekcija.Connect(lokacija);
                DataTable podaci = new DataTable();
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM korisnik WHERE email='" + txtemail.Text + "'", veza);
                adapter.Fill(podaci);
                int count = podaci.Rows.Count;
                if (count == 0)
                {
                    MessageBox.Show("Email ne postoji");
                }
                else
                {
                    /*
                    string prvi = podaci.Rows[0]["lozinka"].ToString();
                    string drugi = txtlozinka.Text;
                    bool isti = prvi.Equals(drugi);
                    bool jednaki = String.Equals(prvi, drugi);
                    int poredak = String.Compare(prvi, drugi);
                    */
                    if (podaci.Rows[0]["lozinka"].ToString() == txtlozinka.Text)
                    {
                        MessageBox.Show("Uspesno ste se ulogovali!");
                        this.Hide();
                        Glavna forma = new Glavna();
                        forma.Show();
                    }
                    else
                    {
                        MessageBox.Show("Pogresna lozinka.");
                    }
                }
            }
        }

        private void buttonregistracija_Click(object sender, EventArgs e)
        {
            Program.user = comboBox1.SelectedItem.ToString();
            Registracija nova = new Registracija();
            nova.Show();
        }
    }
}
