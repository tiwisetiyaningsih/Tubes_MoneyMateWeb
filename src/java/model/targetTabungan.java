package model;

public class targetTabungan {
    private int id;  // Tambahkan ID untuk target tabungan
    private String namaTarget;
    private double jumlahTarget;
    private double jumlahdikumpulkan;

    // Konstruktor tanpa tanggalTarget
    public targetTabungan() {}

    // Konstruktor dengan namaTarget dan jumlahTarget
    public targetTabungan(String namaTarget, double jumlahTarget) {
        this.namaTarget = namaTarget;
        this.jumlahTarget = jumlahTarget;
        this.jumlahdikumpulkan = 0; // Default jumlah terkumpul adalah 0
    }
    // Konstruktor dengan id, namaTarget, jumlahTarget, dan jumlahdikumpulkan
    public targetTabungan(int id, String namaTarget, double jumlahTarget, double jumlahdikumpulkan) {
        this.id = id;
        this.namaTarget = namaTarget;
        this.jumlahTarget = jumlahTarget;
        this.jumlahdikumpulkan = jumlahdikumpulkan;
    }

    // Getter dan Setter untuk namaTarget
    public String getNamaTarget() {
        return namaTarget;
    }

    public void setNamaTarget(String namaTarget) {
        this.namaTarget = namaTarget;
    }

    // Getter dan Setter untuk jumlahTarget
    public double getJumlahTarget() {
        return jumlahTarget;
    }

    public void setJumlahTarget(double jumlahTarget) {
        this.jumlahTarget = jumlahTarget;
    }

    // Getter dan Setter untuk jumlahdikumpulkan
    public double getJumlahDikumpulkan() {
        return jumlahdikumpulkan;
    }

    public void setJumlahDikumpulkan(double jumlahdikumpulkan) {
        this.jumlahdikumpulkan = jumlahdikumpulkan;
    }

    // Getter dan Setter untuk id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}