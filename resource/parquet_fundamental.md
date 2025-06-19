# **Apache Parquet: Panduan Lengkap dengan Contoh & Best Practices**

## **📌 Daftar Isi**
1. [Apa Itu Parquet?](#-apa-itu-parquet)  
2. [Struktur File Parquet](#-struktur-file-parquet)  
3. [Keunggulan Parquet](#-keunggulan-parquet)  
4. [Perbandingan dengan Format Lain](#-perbandingan-dengan-format-lain)  
5. [Optimalisasi Parquet](#-optimalisasi-parquet)  
6. [Tools yang Mendukung Parquet](#-tools-yang-mendukung-parquet)  
7. [Contoh Praktis](#-contoh-praktis)  
8. [Best Practices](#-best-practices)  

---

## **🔍 Apa Itu Parquet?**
Apache Parquet adalah **format file kolumnar** (columnar storage) yang dirancang untuk efisiensi penyimpanan dan pemrosesan data besar.  
- **Dikembangkan oleh:** Apache (bekerja sama dengan Cloudera dan Twitter).  
- **Tujuan utama:** Mengoptimalkan *read performance* untuk query analitik.  

### **Ciri Khas Parquet**
✅ **Binary Format**: Data disimpan dalam bentuk biner (bukan teks seperti CSV/JSON).  
✅ **Kolumnar**: Menyimpan per kolom, bukan per baris (seperti row-based: CSV, Avro).  
✅ **Kompresi Tinggi**: Mendukung berbagai codec (Snappy, ZSTD, GZIP).  
✅ **Schema Evolution**: Bisa menangani perubahan schema (tambah/hapus kolom).  

---

## **📂 Struktur File Parquet**
```bash
file.parquet
├── Row Groups (Block)
│   ├── Column Chunk (Kolom 1)
│   │   ├── Page 1
│   │   ├── Page 2
│   │   └── Metadata (min/max, nilai unik)
│   ├── Column Chunk (Kolom 2)
│   └── ...
├── Metadata (Footer)
│   ├── Schema
│   ├── Daftar Row Groups
│   └── Key-Value Metadata (contoh: `created_by: Spark 3.5`)
└── Magic Number ("PAR1" di header & footer)
```

### **Konsep Penting**
| **Term**          | **Penjelasan**                                                                 |
|-------------------|-------------------------------------------------------------------------------|
| **Row Group**     | Block data (misal: 128MB). Bisa dibaca independen.                           |
| **Column Chunk**  | Data per kolom dalam 1 Row Group.                                            |
| **Page**          | Unit terkecil dalam Parquet (biasanya 1MB). Memiliki header + data.         |
| **Dictionary**    | Menyimpan nilai unik untuk kompresi (optimal untuk kolom kategorikal).      |
| **Footer**        | Metadata global (schema, total rows, dll).                                  |

---

## **⚡ Keunggulan Parquet**
### **1. Efisiensi Penyimpanan**
- **Kompresi tinggi** (3-10x lebih kecil dari CSV).  
- **Dictionary Encoding** untuk kolom dengan nilai berulang (e.g., `gender: Male/Female`).  

### **2. Performa Baca Cepat**
- **Column pruning**: Hanya baca kolom yang dibutuhkan (contoh: `SELECT name FROM table`).  
- **Predicate pushdown**: Filter data langsung di level storage (e.g., `WHERE age > 30`).  

### **3. Kompatibilitas Luas**
- Didukung oleh **Spark, Athena, BigQuery, Pandas, dll**.  
- Bisa dipakai di **data lake (S3, GCS, HDFS)**.  

---

## **🆚 Perbandingan dengan Format Lain**
| **Format** | **Storage** | **Kompresi** | **Schema** | **Use Case**               |
|------------|------------|-------------|------------|----------------------------|
| **Parquet** | Kolumnar   | Tinggi      | Ya         | Analitik, Data Lake        |
| **CSV**    | Row-based  | Rendah      | Tidak      | Pertukaran data sederhana  |
| **Avro**   | Row-based  | Tinggi      | Ya         | Streaming (Kafka)          |
| **ORC**    | Kolumnar   | Tinggi      | Ya         | Hive, Hadoop               |

> **Catatan:**  
> - Parquet vs ORC: Parquet lebih fleksibel (tidak terikat Hive), ORC lebih cepat di Hive.  
> - Parquet vs Avro: Avro lebih cocok untuk *serialization*, Parquet untuk *analytical querying*.  

---

## **🎯 Optimalisasi Parquet**
### **1. Pengaturan Ukuran**
| **Parameter**         | **Nilai Default** | **Rekomendasi**       | **Dampak**                              |
|----------------------|------------------|-----------------------|-----------------------------------------|
| **Row Group Size**   | 128 MB           | 128 MB - 1 GB         | Semakin besar = baca lebih cepat.       |
| **Page Size**        | 1 MB             | 1 MB - 8 MB           | Mempengaruhi granularitas filtering.    |
| **Dictionary Size**  | 1 MB             | Sesuaikan dengan data | Jika terlalu kecil, encoding gagal.     |

### **2. Kompresi**
| **Codec**   | **Rasio** | **Kecepatan** | **Rekomendasi**                     |
|------------|----------|--------------|-------------------------------------|
| **ZSTD**   | ⭐⭐⭐⭐⭐ | ⭐⭐⭐        | Terbaik untuk kebanyakan kasus.     |
| **Snappy** | ⭐⭐⭐     | ⭐⭐⭐⭐⭐      | Cepat, rasio kompresi sedang.       |
| **GZIP**   | ⭐⭐⭐⭐    | ⭐⭐          | Kompresi tinggi, tapi lambat.       |

### **3. Encoding**
- **Dictionary Encoding**: Aktifkan untuk kolom dengan kardinalitas rendah (e.g., `country`, `status`).  
- **Delta Encoding**: Cocok untuk kolom berurutan (e.g., `timestamp`, `ID`).  

---

## **🛠 Tools yang Mendukung Parquet**
| **Tool**       | **Fungsi**                          | **Contoh Penggunaan**                     |
|----------------|------------------------------------|------------------------------------------|
| **Spark**      | Pemrosesan besar                   | `df.write.parquet("s3://path")`          |
| **Pandas**     | Analisis data                      | `pd.read_parquet("file.parquet")`        |
| **Athena**     | Query langsung dari S3             | `CREATE TABLE ... STORED AS PARQUET`     |
| **Airbyte**    | ETL ke data lake                   | Output Destination = Parquet             |
| **DuckDB**     | OLAP in-memory                     | `SELECT * FROM 'file.parquet'`           |

---

## **🔧 Contoh Praktis**
### **1. Membuat File Parquet dengan PySpark**
```python
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("ParquetExample").getOrCreate()
data = [("Fathur", 28), ("Budi", 35)]
df = spark.createDataFrame(data, ["name", "age"])

# Simpan dengan kompresi ZSTD
df.write.parquet(
    "output.parquet",
    compression="zstd",
    mode="overwrite"
)
```

### **2. Membaca Parquet di Pandas**
```python
import pandas as pd

df = pd.read_parquet("output.parquet")
print(df.head())
```

### **3. Optimalkan Row Group Size di Airbyte**
```yaml
format:
  parquet:
    block_size_mb: 256  # Row Group Size
    compression_codec: "zstd"
    dictionary_encoding: true
```

---

## **📌 Best Practices**
1. **Partisi Data**  
   - Pisahkan data berdasarkan kolom sering difilter (e.g., `date`, `region`).  
   - Contoh: `s3://bucket/year=2024/month=03/file.parquet`.

2. **Hindari File Terlalu Kecil**  
   - Gabungkan file kecil menjadi **>64MB** untuk hindari *small files problem*.

3. **Monitor Kompresi**  
   - Tes rasio kompresi dengan data real sebelum produksi.

4. **Gunakan Metadata**  
   - Tambahkan deskripsi schema di footer (e.g., `author: Fathur`).

5. **Schema Evolution**  
   - Jika kolom bertambah, gunakan *merge schema*:  
     ```python
     spark.read.option("mergeSchema", "true").parquet("path")
     ```

---

## **🎯 Kesimpulan**
Parquet adalah **format terbaik untuk data lake dan analitik** karena:
- **Efisiensi penyimpanan** (kompresi + encoding).  
- **Performa baca cepat** (columnar + predicate pushdown).  
- **Kompatibilitas luas** (Spark, Pandas, Athena, dll).  

Gunakan **ZSTD + Dictionary Encoding + Row Group 128MB** untuk kebanyakan kasus!  

**🚀 Tertarik mencoba?** Coba ekspor data dari database ke Parquet via Airbyte hari ini!