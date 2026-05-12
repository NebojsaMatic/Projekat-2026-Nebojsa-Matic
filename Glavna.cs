using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Projekat_2026_Nebojsa_Matic
{
    public partial class Glavna : Form
    {
        public Glavna()
        {
            InitializeComponent();
        }


        private void Glavna_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void ligeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Liga p = new Liga();
            p.ShowDialog();
        }

        private void kluboviToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Klubovi p = new Klubovi();
            p.ShowDialog();
        }

        private void menadzeriToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Menadzeri p = new Menadzeri();
            p.ShowDialog();
        }

        private void igraciToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Igraci p = new Igraci();
            p.ShowDialog();
        }

        private void meceviToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Mecevi p = new Mecevi();
            p.ShowDialog();
        }

        private void dogadjajiToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Dogadjaji p = new Dogadjaji();
            p.ShowDialog();
        }

        private void timIgracToolStripMenuItem_Click(object sender, EventArgs e)
        {
            TimIgrac p = new TimIgrac();
            p.ShowDialog();
        }

        private void timMenadzerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            TimMenadzer p = new TimMenadzer();
            p.ShowDialog();
        }

        private void mecDogadjajToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MecDogadjaj p = new MecDogadjaj();
            p.ShowDialog();
        }

        private void korisniciToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Korisnici p = new Korisnici();
            p.ShowDialog();
        }

        private void Glavna_Load(object sender, EventArgs e)
        {
            administracijaToolStripMenuItem.Visible = (Program.uloga == 1);
        }
    }
}
