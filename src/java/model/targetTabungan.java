package model;

public class targetTabungan {

    private int id;  // Tambahkan ID untuk target tabungan
    private String namaTarget;
    private double jumlahTarget;
    private double jumlahdikumpulkan;

    public targetTabungan() {
    }

    public targetTabungan(String namaTarget, double jumlahTarget) {
        this.namaTarget = namaTarget;
        this.jumlahTarget = jumlahTarget;
        this.jumlahdikumpulkan = 0;
    }

    public targetTabungan(int id, String namaTarget, double jumlahTarget, double jumlahdikumpulkan) {
        this.id = id;
        this.namaTarget = namaTarget;
        this.jumlahTarget = jumlahTarget;
        this.jumlahdikumpulkan = jumlahdikumpulkan;
    }

    public String getNamaTarget() {
        return namaTarget;
    }

    public void setNamaTarget(String namaTarget) {
        this.namaTarget = namaTarget;
    }

    public double getJumlahTarget() {
        return jumlahTarget;
    }

    public void setJumlahTarget(double jumlahTarget) {
        this.jumlahTarget = jumlahTarget;
    }

    public double getJumlahDikumpulkan() {
        return jumlahdikumpulkan;
    }

    public void setJumlahDikumpulkan(double jumlahdikumpulkan) {
        this.jumlahdikumpulkan = jumlahdikumpulkan;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
