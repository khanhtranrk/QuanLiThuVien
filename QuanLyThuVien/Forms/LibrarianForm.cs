﻿using Bunifu.UI.WinForms;
using QuanLyThuVien.DataObject;
using QuanLyThuVien.Forms.LibrarianFroms;
using QuanLyThuVien.Repository;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyThuVien.Forms
{
    public partial class LibrarianForm : Form
    {
        private LibrarianRepository repository = new LibrarianRepository();
        private List<Librarian> librarians = new List<Librarian>();

        public LibrarianForm()
        {
            InitializeComponent();
        }

        private void RefreshData()
        {
            try
            {
                librarians = repository.FilterByKeyword(searchTB.Text);
                librarianDGV.DataSource = librarians;
                librarianDGV.Refresh();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Thông báo");
            }
        }

        private void LibrarianForm_Shown(object sender, EventArgs e)
        {
            RefreshData();
        }

        private void librarianDGV_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
                return;

            Librarian librarian = (Librarian)librarianDGV.Rows[e.RowIndex].DataBoundItem;

            DetailForm detailForm = new LibrarianFroms.DetailForm(librarian);
            detailForm.FormBorderStyle = FormBorderStyle.FixedSingle;
            detailForm.ShowDialog();

            if (detailForm.Successed)
                RefreshData();
        }

        private void creationBT_Click(object sender, EventArgs e)
        {
            DetailForm detailForm = new DetailForm();
            detailForm.FormBorderStyle = FormBorderStyle.FixedSingle;
            detailForm.ShowDialog();

            if (detailForm.Successed)
                RefreshData();
        }

        private void updateBT_Click(object sender, EventArgs e)
        {
            if (librarianDGV.SelectedRows.Count == 0)
                return;

            Librarian librarian = (Librarian)librarianDGV.CurrentRow.DataBoundItem;

            DetailForm detailForm = new DetailForm(librarian);
            detailForm.FormBorderStyle = FormBorderStyle.FixedSingle;
            detailForm.ShowDialog();

            if (detailForm.Successed)
                RefreshData();
        }

        private void searchTB_TextChange(object sender, EventArgs e)
        {
            RefreshData();
        }

        private void deleteBT_Click(object sender, EventArgs e)
        {
            if (librarianDGV.SelectedRows.Count == 0)
                return;

            Librarian librarian = (Librarian)librarianDGV.CurrentRow.DataBoundItem;

            try
            {
                repository.Delete(librarian.Id);
                RefreshData();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Thông báo");
            }
        }

        private void refreshBT_Click(object sender, EventArgs e)
        {
            RefreshData();
        }
    }
}
