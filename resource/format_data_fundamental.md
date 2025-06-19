# **Fundamental Data Formats: Panduan Lengkap untuk Pemula hingga Mahir**

## **📚 Daftar Isi**
1. [Pengantar Format Data](#-pengantar-format-data)  
2. [Struktur Dasar Format Data](#-struktur-dasar-format-data)  
3. [Text-Based Formats](#-text-based-formats)  
   - [CSV](#csv-comma-separated-values)  
   - [JSON](#json-javascript-object-notation)  
   - [XML](#xml-extensible-markup-language)  
4. [Binary Formats](#-binary-formats)  
   - [Parquet](#parquet)  
   - [Avro](#avro)  
   - [ORC](#orc-optimized-row-columnar)  
5. [Database-Specific Formats](#-database-specific-formats)  
   - [SQLite](#sqlite)  
   - [MySQL Binary Log](#mysql-binary-log)  
6. [Real-World Case Studies](#-real-world-case-studies)  
7. [Best Practices](#-best-practices)  
8. [Tools & Libraries](#-tools--libraries)  

---

## **🌐 Pengantar Format Data**
Format data adalah cara menyimpan dan mengorganisir informasi secara terstruktur. Pemilihan format memengaruhi:
- **Efisiensi penyimpanan**  
- **Kecepatan baca/tulis**  
- **Kompatibilitas dengan sistem**  

### **Kategori Utama**
| **Kategori**       | **Contoh Format**      | **Karakteristik**                  |
|--------------------|------------------------|-----------------------------------|
| **Text-Based**     | CSV, JSON, XML         | Mudah dibaca manusia, ukuran besar |
| **Binary**         | Parquet, Avro, ORC     | Efisien, cepat, kompresi tinggi   |
| **Database-Specific** | SQLite, MySQL BinLog | Dioptimalkan untuk DB tertentu    |

---

## **📐 Struktur Dasar Format Data**
### **1. Row vs Columnar Storage**
| **Tipe**          | **Contoh Format** | **Keunggulan**                     |
|-------------------|------------------|-----------------------------------|
| **Row-Based**     | CSV, Avro        | Cepat untuk operasi INSERT/UPDATE |
| **Columnar**      | Parquet, ORC     | Cepat untuk query analitik (SELECT) |

### **2. Schema vs Schema-less**
| **Tipe**          | **Contoh**       | **Fleksibilitas**                 |
|-------------------|------------------|-----------------------------------|
| **Schema**        | Parquet, Avro    | Ketat, perlu definisi struktur    |
| **Schema-less**   | JSON, XML        | Dinamis, bisa berubah tanpa skema |

---

## **📝 Text-Based Formats**
### **CSV (Comma-Separated Values)**
**Struktur:**
```csv
id,name,age
1,Fathur,28
2,Budi,35
```

**Karakteristik:**
- ✅ **Sederhana**: Mudah dibaca/ditulis oleh manusia.
- ❌ **Tidak efisien**: Tidak ada kompresi, tidak mendukung nested data.
- ❌ **Tidak ada tipe data**: Semua data berupa string.

**Real-World Case:**  
- Ekspor/import data dari spreadsheet (Excel, Google Sheets).  
- Log aplikasi sederhana.  

---

### **JSON (JavaScript Object Notation)**
**Struktur:**
```json
[
  {
    "id": 1,
    "name": "Fathur",
    "age": 28,
    "address": {
      "city": "Jakarta",
      "country": "Indonesia"
    }
  }
]
```

**Karakteristik:**
- ✅ **Struktur nested**: Mendukung objek kompleks.
- ❌ **Ukuran besar**: Kurang efisien dibanding binary format.
- ✅ **Schema-less**: Fleksibel untuk perubahan struktur.

**Real-World Case:**  
- API responses (RESTful services).  
- Konfigurasi aplikasi (e.g., `package.json`).  

---

### **XML (Extensible Markup Language)**
**Struktur:**
```xml
<users>
  <user>
    <id>1</id>
    <name>Fathur</name>
    <age>28</age>
  </user>
</users>
```

**Karakteristik:**
- ✅ **Validasi ketat**: Dukung XSD/DTD untuk validasi schema.
- ❌ **Verbose**: Banyak tag repetitif, ukuran besar.
- ✅ **Kompatibel luas**: Dipakai di SOAP, dokumen Office.

**Real-World Case:**  
- Dokumen Office (DOCX, XLSX sebenarnya adalah ZIP + XML).  
- Protokol enterprise (SOAP).  

---

## **🔢 Binary Formats**
### **Parquet**
**Struktur:**
```
file.parquet
├── Row Groups (Block)
│   ├── Column Chunk (Kolom 1)
│   │   ├── Page 1 (Data + Metadata)
│   └── ...
└── Footer (Schema, Stats)
```

**Karakteristik:**
- ✅ **Kolumnar**: Efisien untuk query analitik.
- ✅ **Kompresi tinggi**: ZSTD, Snappy, dll.
- ❌ **Tidak bisa dibaca manusia**: Perlu tools khusus.

**Real-World Case:**  
- Data lake (S3, HDFS).  
- OLAP (Athena, BigQuery).  

---

### **Avro**
**Struktur:**
```json
{
  "type": "record",
  "name": "User",
  "fields": [
    {"name": "id", "type": "int"},
    {"name": "name", "type": "string"}
  ]
}
```
+ Data binary dengan schema JSON.

**Karakteristik:**
- ✅ **Row-based**: Cocok untuk streaming (Kafka).
- ✅ **Schema evolution**: Bisa tambah kolom tanpa break.
- ❌ **Tidak efisien untuk query kolom tunggal**.

**Real-World Case:**  
- Event streaming (Kafka, PubSub).  
- Serialisasi data di Hadoop.  

---

### **ORC (Optimized Row Columnar)**
**Struktur:**
```
file.orc
├── Stripe 1
│   ├── Column 1 (Data + Index)
│   └── ...
└── Footer (Metadata)
```

**Karakteristik:**
- ✅ **Didesain untuk Hive**: Performa tinggi di Hadoop.
- ✅ **Kompresi lebih baik dari Parquet** (di beberapa kasus).
- ❌ **Kurang fleksibel**: Terikat ekosistem Hadoop.

**Real-World Case:**  
- Data warehouse di HDFS.  
- Tabel Hive dengan partisi.  

---

## **🗃 Database-Specific Formats**
### **SQLite**
**Struktur:**
- Single file binary (`.db` atau `.sqlite`).  
- Menyimpan tabel, index, schema dalam 1 file.  

**Real-World Case:**  
- Database lokal di mobile apps (Android, iOS).  
- Penyimpanan config aplikasi.  

---

### **MySQL Binary Log**
**Struktur:**
- Mencatat semua perubahan data (INSERT/UPDATE/DELETE).  
- Dipakai untuk replikasi dan recovery.  

**Real-World Case:**  
- Replikasi database master-slave.  
- CDC (Change Data Capture) untuk ETL.  

---

## **🏢 Real-World Case Studies**
### **1. ETL Pipeline dengan Parquet**
**Skenario:**  
- Source: PostgreSQL (transaksi e-commerce).  
- Destination: S3 (data lake).  
**Alur:**  
```
PostgreSQL → (Airbyte) → S3 (Parquet) → (Athena) → Analytics
```
**Mengapa Parquet?**  
- Efisien untuk query `SELECT product_id, SUM(price)`.  
- Kompresi mengurangi biaya S3.  

---

### **2. Logging dengan JSON vs Avro**
**Skala Kecil (JSON):**  
- File log aplikasi (debugging).  
**Skala Besar (Avro):**  
- Log event user di Kafka (jutaan event/hari).  

---

## **🎯 Best Practices**
1. **Pilih Format Berdasarkan Use Case**  
   - Analitik → **Parquet/ORC**.  
   - Streaming → **Avro**.  
   - Konfigurasi → **JSON**.  

2. **Optimalkan Ukuran File**  
   - Parquet: Row group 128MB-1GB.  
   - CSV: Batasi file <1GB (atau partisi).  

3. **Gunakan Kompresi**  
   - Parquet: **ZSTD** (optimal).  
   - Logs: **GZIP** (rasio tinggi).  

4. **Validasi Schema**  
   - Avro/Parquet: Definisikan schema eksplisit.  
   - JSON: Gunakan JSON Schema jika perlu validasi.  

---

## **🛠 Tools & Libraries**
| **Format** | **Tools**                  | **Library (Python)**       |
|------------|---------------------------|---------------------------|
| CSV        | Excel, Google Sheets       | `pandas.read_csv()`        |
| JSON       | jq, Postman               | `json.loads()`            |
| Parquet    | Athena, Spark             | `pyarrow.parquet`         |
| Avro       | Kafka, Avro Tools         | `fastavro`                |

---

## **📌 Kesimpulan**
- **CSV/JSON/XML**: Terbaik untuk **interoperabilitas** (manusia & sistem sederhana).  
- **Parquet/ORC**: Terbaik untuk **analitik & data lake**.  
- **Avro**: Terbaik untuk **streaming & serialisasi**.  

**🚀 Langkah Selanjutnya:**  
1. Coba ekspor data dari database ke Parquet.  
2. Bandingkan ukuran file CSV vs Parquet.  
3. Implementasi Avro untuk event streaming.  

**📖 Referensi:**  
- [Apache Parquet Docs](https://parquet.apache.org/)  
- [JSON Schema](https://json-schema.org/)  
- [Avro Specification](https://avro.apache.org/docs/current/spec.html)