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

        private void btnRegistruj_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text == "" || txtLozinka.Text == "" || txtPotvrdiLozinku.Text == "")
            {
                MessageBox.Show("Data polja su obavezna.");
                return;
            }

            if (txtLozinka.Text != txtPotvrdiLozinku.Text)
            {
                MessageBox.Show("Lozinke se ne poklapaju.");
                return;
            }

            SqlConnection veza = Konekcija.Connect();
            string provera = "SELECT COUNT(*) FROM Korisnik WHERE email='" + txtEmail.Text + "'";
            SqlCommand komanda = new SqlCommand(provera, veza);
            veza.Open();
            int ima = (int)komanda.ExecuteScalar();
            veza.Close();

            if (ima > 0)
            {
                MessageBox.Show("Korisnik sa tim emailom vec postoji.");
                return;
            }

            string naredba = "INSERT INTO Korisnik(email, loz, uloga) VALUES('" +
                txtEmail.Text + "', '" + txtLozinka.Text + "', 0)";
            SqlCommand dodaj = new SqlCommand(naredba, veza);
            veza.Open();
            dodaj.ExecuteNonQuery();
            veza.Close();

            MessageBox.Show("Registracija uspesna! Mozete se prijaviti.");
            this.Close();
        }
    }
}
