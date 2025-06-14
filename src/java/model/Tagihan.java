/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;

/**
 *
 * @author Lenovo
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

public class Tagihan {
    private int id;
    private String namaTagihan;
    private double jumlahTagihan;
    private Date tanggalDue;

    private Date reminderDate;

public Date getReminderDate() {
    return reminderDate;
}

public void setReminderDate(Date reminderDate) {
    this.reminderDate = reminderDate;
}

    // Constructor tanpa ID (untuk saat tambah data baru)
    public Tagihan(String namaTagihan, double jumlahTagihan, Date tanggalDue) {
        this.namaTagihan = namaTagihan;
        this.jumlahTagihan = jumlahTagihan;
        this.tanggalDue = tanggalDue;
    }

    // Getter dan Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNamaTagihan() {
        return namaTagihan;
    }

    public void setNamaTagihan(String namaTagihan) {
        this.namaTagihan = namaTagihan;
    }

    public double getJumlahTagihan() {
        return jumlahTagihan;
    }

    public void setJumlahTagihan(double jumlahTagihan) {
        this.jumlahTagihan = jumlahTagihan;
    }

    public Date getTanggalDue() {
        return tanggalDue;
    }

    public void setTanggalDue(Date tanggalDue) {
        this.tanggalDue = tanggalDue;
    }
}