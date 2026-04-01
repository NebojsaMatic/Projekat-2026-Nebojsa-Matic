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
    public partial class Registracija : Form
    {
        public Registracija()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string baza = Program.user;
            if (textBox4.Text == textBox5.Text)
            {
                SqlConnection veza = Konekcija.Connect(baza);
                string provera = "SELECT COUNT(*) FROM korisnik WHERE email='" + textBox3.Text + "'";
                SqlCommand komanda = new SqlCommand(provera, veza);
                veza.Open();
                int ima = (int)  komanda.ExecuteScalar();
                veza.Close();
                if (ima > 0)
                {
                    MessageBox.Show("Ima takav email.");
                }
                else
                {
                    string naredba = "INSERT INTO korisnik VALUES('";
                    naredba += textBox3.Text + "','";
                    naredba += textBox4.Text + "', 0)";
                    veza.Open();
                    SqlCommand uradi = new SqlCommand(naredba, veza);
                    uradi.ExecuteNonQuery();
                    veza.Close();
                    MessageBox.Show("Uradio sam");
                }
            }
            else
            {
                MessageBox.Show("Ponovljena lozinka nije dobra");
            }
        }
    }
}
