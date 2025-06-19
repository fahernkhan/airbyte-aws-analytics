Siap! Berikut **materi kilat dan latihan cepat** untuk **SQL dan Python (Pandas)** yang kamu butuhin buat interview teknikal data engineer **besok pagi**.

---

## 🔷 BAGIAN 1: SQL (Fundamental & Intermediate)

### ✅ **1.1 SQL Dasar Wajib Hafal**

```sql
-- Ambil data
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column ASC|DESC
LIMIT 10;
```

### ✅ **1.2 JOIN**

```sql
SELECT a.id, b.name
FROM table_a a
JOIN table_b b ON a.id = b.a_id;

-- Jenis JOIN lain:
-- LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN
```

### ✅ **1.3 Aggregation + GROUP BY**

```sql
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;
```

### ✅ **1.4 FILTER dengan HAVING**

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 5000;
```

### ✅ **1.5 CASE WHEN**

```sql
SELECT name,
       CASE
           WHEN age >= 18 THEN 'Adult'
           ELSE 'Child'
       END AS age_group
FROM users;
```

### ✅ **1.6 CTE (Common Table Expression)**

```sql
WITH sales_cte AS (
    SELECT customer_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY customer_id
)
SELECT *
FROM sales_cte
WHERE total_sales > 1000;
```

### ✅ **1.7 Window Function**

```sql
SELECT customer_id, order_id,
       RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_rank
FROM orders;
```

---

## 🔹 LATIHAN SOAL SQL SINGKAT

### 🧠 Soal 1: Ambil 5 produk dengan harga tertinggi

```sql
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 5;
```

### 🧠 Soal 2: Total penjualan per pelanggan

```sql
SELECT customer_id, SUM(total_amount) AS total_spent
FROM transactions
GROUP BY customer_id;
```

### 🧠 Soal 3: Tampilkan pelanggan yang belum pernah beli

```sql
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_id IS NULL;
```

---

## 🔷 BAGIAN 2: Python dengan Pandas

### ✅ **2.1 Import dan Baca Data**

```python
import pandas as pd

df = pd.read_csv("data.csv")
```

### ✅ **2.2 Melihat Isi Data**

```python
df.head()
df.info()
df.describe()
```

### ✅ **2.3 Filtering Data**

```python
df[df["age"] > 25]
df[(df["age"] > 25) & (df["gender"] == "Male")]
```

### ✅ **2.4 Menambahkan Kolom Baru**

```python
df["is_adult"] = df["age"] >= 18
```

### ✅ **2.5 Grouping dan Aggregasi**

```python
df.groupby("department")["salary"].mean()
df.groupby(["department", "gender"]).agg({"salary": "sum"})
```

### ✅ **2.6 Merge DataFrame**

```python
pd.merge(df1, df2, on="id", how="left")
```

### ✅ **2.7 Apply dan Lambda**

```python
df["salary_level"] = df["salary"].apply(lambda x: "High" if x > 5000 else "Low")
```

---

## 🔹 LATIHAN SOAL PANDAS SINGKAT

### 🧠 Soal 1: Filter karyawan dengan gaji > 10.000

```python
df[df["salary"] > 10000]
```

### 🧠 Soal 2: Hitung rata-rata usia per departemen

```python
df.groupby("department")["age"].mean()
```

### 🧠 Soal 3: Gabungkan dua DataFrame berdasarkan ID

```python
merged_df = pd.merge(df1, df2, on="id", how="inner")
```

### 🧠 Soal 4: Tambahkan kolom kategori umur

```python
df["age_group"] = df["age"].apply(lambda x: "Teen" if x < 20 else "Adult")
```

---

## 🔸 Tips Tambahan Wawancara

### ✅ Kalau lupa syntax

> “Saya tahu logikanya, dan biasanya saya akan cek dokumentasi/resmi atau test di notebook.”

### ✅ Kalau error pas coding live

> “Izinkan saya debugging sebentar ya. Saya mulai dari print bentuk datanya dulu...”

### ✅ Tunjukkan cara berpikir

> “Langkah saya: 1) Filter data, 2) Agregasi pakai groupby, 3) Urutkan hasilnya...”

---

Mantap! Berikut adalah **simulasi 5 soal campuran SQL + Python (Pandas)** untuk latihan malam ini. Setiap soal disertai *hint* dan jawabannya — kamu bisa coba dulu jawab sendiri baru lihat pembahasannya.

---

## 🧩 **SOAL 1 (SQL – JOIN + FILTER)**

**Soal:**
Tabel `customers` dan `orders` punya relasi lewat `customer_id`. Ambil nama pelanggan yang sudah melakukan minimal 2 pesanan.

**Tabel:**

* `customers(customer_id, name)`
* `orders(order_id, customer_id, order_date)`

**Hint:** JOIN + GROUP BY + HAVING

<details>
<summary>✅ Jawaban</summary>

```sql
SELECT c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) >= 2;
```

</details>

---

## 🧩 **SOAL 2 (Pandas – Filter + GroupBy)**

**Soal:**
Diberi DataFrame `df_sales` dengan kolom `region`, `product`, dan `sales_amount`.
Tampilkan total penjualan untuk setiap region yang totalnya > 10.000.

**Hint:** groupby + filtering hasil agregasi

<details>
<summary>✅ Jawaban</summary>

```python
region_sales = df_sales.groupby("region")["sales_amount"].sum()
region_sales[region_sales > 10000]
```

</details>

---

## 🧩 **SOAL 3 (SQL – CTE + Window Function)**

**Soal:**
Tabel `transactions(transaction_id, customer_id, amount, transaction_date)`
Ambil transaksi pertama (berdasarkan `transaction_date`) dari tiap pelanggan.

**Hint:** ROW\_NUMBER() dengan PARTITION BY

<details>
<summary>✅ Jawaban</summary>

```sql
WITH ranked_tx AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date) AS rn
  FROM transactions
)
SELECT *
FROM ranked_tx
WHERE rn = 1;
```

</details>

---

## 🧩 **SOAL 4 (Pandas – Merge + Apply)**

**Soal:**
Gabungkan dua DataFrame: `df_users(user_id, name)` dan `df_logins(user_id, login_time)`
Lalu buat kolom `login_hour` yang menyimpan jam dari `login_time`.

**Hint:** `merge` dan `apply` ke kolom datetime

<details>
<summary>✅ Jawaban</summary>

```python
df = pd.merge(df_users, df_logins, on="user_id", how="inner")
df["login_hour"] = pd.to_datetime(df["login_time"]).dt.hour
```

</details>

---

## 🧩 **SOAL 5 (SQL – CASE WHEN + Aggregation)**

**Soal:**
Tabel `employees(name, salary)`
Tentukan jumlah karyawan dengan kategori:

* “Low” jika salary < 5000
* “Mid” jika 5000–9999
* “High” jika >= 10000

**Hint:** CASE + COUNT + GROUP BY

<details>
<summary>✅ Jawaban</summary>

```sql
SELECT 
  CASE 
    WHEN salary < 5000 THEN 'Low'
    WHEN salary < 10000 THEN 'Mid'
    ELSE 'High'
  END AS salary_category,
  COUNT(*) AS total
FROM employees
GROUP BY salary_category;
```

</details>

---

Tentu. Mari kita lupakan format tanya-jawab sejenak. Anggap ini adalah *briefing* dan *cheatsheet* terakhir Anda sebelum pertempuran besok pagi. Fokus, terstruktur, dan berisi semua yang Anda butuhkan.

---

### **Materi Lengkap Interview Technical Data Engineer: Strategi Malam Terakhir**

Tujuan kita malam ini bukan untuk mempelajari hal baru, tetapi untuk **mempertajam kembali senjata yang sudah ada** dan menyusun strategi untuk menjawab dengan percaya diri.

#### **Mindset Utama:**

Interview teknikal bukan ujian hafalan syntax. Ini adalah tes **pola pikir pemecahan masalah (problem-solving mindset)**. Mereka ingin tahu *bagaimana* Anda berpikir, bukan hanya *apa* yang Anda hafal.

---

### **BAGIAN 1: Penguasaan SQL (Fondasi Wajib)**

SQL adalah filter pertama. Jika Anda goyah di sini, akan sulit untuk lanjut. Fokus pada konsep-konsep paling sering diuji berikut.

#### **1.1. Dasar yang Harus Lancar di Luar Kepala**

* **Urutan Eksekusi Logis**: Ingat, SQL tidak dieksekusi sesuai urutan Anda menulisnya.
    1.  `FROM` & `JOIN`
    2.  `WHERE`
    3.  `GROUP BY`
    4.  `HAVING`
    5.  `SELECT`
    6.  `DISTINCT`
    7.  `ORDER BY`
    8.  `LIMIT` / `TOP`

* **`GROUP BY` & `HAVING`**:
    * `GROUP BY`: Mengelompokkan baris untuk fungsi agregasi (`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`).
    * `HAVING`: Memfilter hasil dari `GROUP BY`. Jangan pernah menggunakan `WHERE` untuk memfilter agregasi.

    ```sql
    -- Skenario: Tampilkan departemen yang punya LEBIH DARI 10 karyawan
    SELECT
        department_id,
        COUNT(employee_id) AS total_karyawan
    FROM employees
    GROUP BY department_id
    HAVING COUNT(employee_id) > 10;
    ```

#### **1.2. JOINs: Jantung dari Query Relasional**

Anda *pasti* akan ditanya soal ini. Pahami kapan menggunakannya.

| Jenis JOIN | Kapan Digunakan? | Contoh Skenario |
| :--- | :--- | :--- |
| **`INNER JOIN`** | Hanya ingin data yang ada di kedua tabel. | Tampilkan order beserta data customer yang melakukan order tersebut. |
| **`LEFT JOIN`** | Ingin semua data dari tabel kiri, meskipun tidak ada padanannya di tabel kanan. | **Tampilkan semua customer**, beserta jumlah ordernya (jika belum pernah order, akan muncul NULL). |
| **`RIGHT JOIN`** | Kebalikan dari `LEFT JOIN`. Jarang digunakan, biasanya bisa diganti `LEFT JOIN` dengan menukar posisi tabel. | Tampilkan semua produk, beserta data penjualannya (jika produk belum pernah terjual, tetap muncul). |
| **`FULL OUTER JOIN`**| Ingin semua data dari kedua tabel, tidak peduli ada padanannya atau tidak. | Menggabungkan dua set data customer dari dua sistem yang berbeda. |

**Skenario Jebakan Klasik:** "Tampilkan user yang belum pernah melakukan transaksi."
Ini adalah soal untuk `LEFT JOIN` + `WHERE ... IS NULL`.

```sql
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_id IS NULL; -- Filter customer yang tidak punya padanan transaksi
```

#### **1.3. Tingkat Menengah: Pembeda Anda dari Kandidat Lain**

* **CTE (Common Table Expression) dengan `WITH`**: Cara terbaik untuk membuat query kompleks jadi rapi dan mudah dibaca.
    * **Kapan Pakai?** Saat Anda butuh membuat "tabel sementara" untuk query yang lebih kompleks. Jauh lebih baik daripada subquery bertingkat.

    ```sql
    -- Skenario: Cari karyawan yang gajinya di atas rata-rata gaji departemennya
    WITH AvgDeptSalary AS (
        SELECT department_id, AVG(salary) as avg_salary_dept
        FROM employees
        GROUP BY department_id
    )
    SELECT
        e.employee_name,
        e.salary,
        ads.avg_salary_dept
    FROM employees e
    JOIN AvgDeptSalary ads ON e.department_id = ads.department_id
    WHERE e.salary > ads.avg_salary_dept;
    ```

* **Window Functions**: Kekuatan super di SQL. Melakukan kalkulasi pada sekelompok baris tanpa meng-agregasinya.
    * **Kapan Pakai?** Untuk membuat ranking, menghitung total berjalan (running total), atau mengambil nilai dari baris sebelum/sesudah.
    * Fungsi Wajib Tahu: `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `LEAD()`, `LAG()`, `SUM(...) OVER (...)`.

    ```sql
    -- Skenario: Beri peringkat 3 karyawan dengan gaji tertinggi di SETIAP departemen
    WITH RankedSalaries AS (
        SELECT
            employee_name,
            department_name,
            salary,
            RANK() OVER(PARTITION BY department_name ORDER BY salary DESC) as salary_rank
        FROM employees
    )
    SELECT * FROM RankedSalaries WHERE salary_rank <= 3;
    ```

---

### **BAGIAN 2: Python (dengan Pandas) untuk Data Engineer**

Fokus Python untuk DE adalah **automasi, pemrosesan, dan manipulasi data.**

#### **2.1. Operasi Pandas yang Paling Sering Dipakai**

* **Membaca Data**: `pd.read_csv('file.csv')`, `pd.read_parquet('file.parquet')`, `pd.read_sql(query, engine)`
* **Inspeksi Cepat**: `df.head()`, `df.tail()`, `df.info()` (sangat penting untuk cek tipe data & null), `df.describe()`, `df.shape`.
* **Seleksi & Filtering (Wajib Lancar!)**:
    * `.loc`: Seleksi berdasarkan **label** (nama kolom/index). `df.loc[df['age'] > 25, ['name', 'city']]`
    * `.iloc`: Seleksi berdasarkan **posisi** integer. `df.iloc[0:5, 0:2]`
    * **Boolean Indexing**: Cara paling umum. `df[df['column'] > value]`

    ```python
    import pandas as pd
    # Filter karyawan dari 'IT' atau 'HR' dengan gaji di atas 5000
    condition_dept = df['department'].isin(['IT', 'HR'])
    condition_salary = df['salary'] > 5000
    filtered_df = df[condition_dept & condition_salary]
    ```

* **Manipulasi Data**:
    * **Membuat Kolom Baru**: `df['new_col'] = ...`
    * **` .groupby()`**: Mirip `GROUP BY` di SQL. Hampir selalu diikuti fungsi agregasi (`.sum()`, `.mean()`, `.count()`, `.agg()`).
    * **` .merge()`**: Mirip `JOIN` di SQL. `pd.merge(df_left, df_right, on='key_column', how='left')`
    * **` .apply()` & `lambda`**: Untuk menerapkan fungsi custom ke setiap baris/kolom. Gunakan jika tidak ada cara bawaan Pandas yang lebih cepat.

    ```python
    # Skenario: Hitung rata-rata dan total gaji per departemen
    agg_result = df.groupby('department')['salary'].agg(['mean', 'sum'])
    print(agg_result)

    # Skenario: Buat kategori gaji menggunakan apply lambda
    df['salary_category'] = df['salary'].apply(lambda x: 'High' if x > 8000 else 'Standard')
    ```
* **Menangani Data Hilang (Missing Data)**:
    * `.isnull().sum()`: Cek jumlah data null per kolom.
    * `.dropna()`: Hapus baris/kolom yang ada null.
    * `.fillna(value)`: Isi data null dengan nilai tertentu (misal: 0, 'Unknown', atau rata-rata kolom).

---

### **BAGIAN 3: Jembatan SQL & Python (Alur Kerja Realistis)**

Ini adalah skenario paling umum: **Tarik data dengan SQL, proses dengan Pandas.**

```python
import pandas as pd
from sqlalchemy import create_engine

# 1. BUAT KONEKSI ENGINE (hanya sekali)
# Ganti dengan detail koneksi database Anda
db_string = 'postgresql://user:password@host:5432/nama_database'
engine = create_engine(db_string)

# 2. TULIS QUERY SQL (lakukan filtering berat di sini)
query = """
WITH daily_transactions AS (
    SELECT
        customer_id,
        CAST(transaction_date AS DATE) as transaction_day,
        SUM(amount) as total_spent
    FROM transactions
    WHERE status = 'completed'
    GROUP BY 1, 2
)
SELECT * FROM daily_transactions WHERE total_spent > 100;
"""

# 3. EKSEKUSI DAN MUAT KE PANDAS DATAFRAME
df_transactions = pd.read_sql(query, engine)

print("Data berhasil ditarik dari SQL!")
print(df_transactions.head())

# 4. LAKUKAN TRANSFORMASI LANJUTAN DI PANDAS
# Contoh: Ekstrak bulan dari tanggal transaksi
df_transactions['transaction_month'] = pd.to_datetime(df_transactions['transaction_day']).dt.month

# 5. (Optional) TULIS HASIL KEMBALI KE DATABASE
# df_transactions.to_sql('aggregated_transactions', engine, if_exists='replace', index=False)
# print("Data hasil transformasi berhasil ditulis kembali ke database.")
```

---

### **BAGIAN 4: Strategi dan "Jurus Andalan" Saat Interview**

1.  **THINK OUT LOUD (WAJIB!)**: Jelaskan apa yang ada di pikiran Anda, bahkan sebelum Anda mengetik.
    * *“Oke, untuk soal ini, pertama saya perlu menggabungkan tabel user dan transaksi. Saya akan pakai `LEFT JOIN` dari tabel user untuk memastikan semua user masuk. Setelah itu, saya akan `GROUP BY` berdasarkan user ID dan pakai `COUNT` untuk menghitung transaksinya. Terakhir, saya filter hasilnya dengan `HAVING`.”*

2.  **Kalau Lupa Syntax**: JANGAN PANIK. Itu normal.
    * Katakan: *“Secara logika, saya akan menggunakan window function `RANK()` di sini. Untuk syntax pastinya, biasanya saya akan cek cepat di dokumentasi atau di catatan saya, tapi konsepnya adalah `RANK() OVER (PARTITION BY ... ORDER BY ...)`.”*
    * Ini menunjukkan Anda paham konsep dan tahu cara mencari solusi, bukan sekadar menghafal.

3.  **Kalau Terjebak atau Soal Terlalu Sulit**:
    * **Klarifikasi**: "Boleh saya klarifikasi asumsi saya? Untuk 'user aktif', apakah artinya user yang login dalam 30 hari terakhir atau yang melakukan transaksi?"
    * **Sederhanakan Masalah**: "Untuk memulainya, saya akan coba selesaikan untuk kasus yang lebih sederhana dulu, misalnya mencari total transaksi tanpa memikirkan tanggalnya."

4.  **Pahami Konsep Kunci DE (Sebutkan jika relevan)**:
    * **ETL vs ELT**: Anda tahu prosesnya (Extract, Transform, Load).
    * **Idempotency**: Pipeline Anda jika dijalankan berkali-kali dengan input yang sama, hasilnya akan tetap sama. Ini penting.
    * **Data Warehouse vs Data Lake**: Tahu perbedaannya secara umum.
    * **Data Quality**: Sebutkan pentingnya validasi data (misal: cek null, cek duplikat) setelah proses ekstraksi.

### **Checklist Terakhir Sebelum Tidur & Besok Pagi**

* [ ] Review cepat contoh kode `JOIN`, `GROUP BY`, `CTE`, `Window Function`.
* [ ] Review cepat contoh kode `pd.read_sql`, `df.groupby`, `pd.merge`.
* [ ] Siapkan kalimat pembuka untuk "Think Out Loud".
* [ ] Siapkan jawaban untuk "Ceritakan tentang proyek data yang pernah Anda kerjakan".
* [ ] **Tidur yang cukup.** Otak yang lelah tidak akan bisa *problem-solving*. Ini lebih penting daripada belajar 1 jam ekstra.
* [ ] Besok pagi, jangan review materi berat lagi. Cukup lihat kembali *cheatsheet* ini dan tenangkan diri.

Anda sudah mempersiapkan diri. Percayai proses dan kemampuan Anda. Tunjukkan cara berpikir Anda yang logis dan terstruktur. Semoga sukses!

Berikut adalah **materi lengkap SQL dan Python (Pandas)** yang disusun **komprehensif dan sistematis**, cocok untuk interview **Data Engineer** besok. Fokus ke **fundamental hingga intermediate**, disertai **penjelasan, contoh, dan catatan penting**.

---

# 🔷 1. SQL LENGKAP UNTUK INTERVIEW DATA ENGINEER

## ✅ 1.1. Dasar SQL: SELECT, WHERE, ORDER BY, LIMIT

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 DESC
LIMIT 10;
```

* **ORDER BY ASC/DESC**: Urut naik/turun
* **LIMIT**: Batasi jumlah baris

## ✅ 1.2. Operator dan Kondisi

```sql
-- Operator dasar
=, !=, >, <, >=, <=
AND, OR, NOT

-- BETWEEN, IN, LIKE
WHERE age BETWEEN 20 AND 30
WHERE department IN ('IT', 'HR')
WHERE name LIKE 'Fathur%'
```

## ✅ 1.3. JOIN (INNER, LEFT, RIGHT, FULL)

```sql
-- INNER JOIN: hanya data yang cocok
SELECT *
FROM orders o
JOIN customers c ON o.customer_id = c.id;

-- LEFT JOIN: semua dari kiri
SELECT *
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;

-- RIGHT JOIN dan FULL OUTER JOIN (beberapa DBMS)
```

## ✅ 1.4. GROUP BY dan Aggregation

```sql
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

SELECT department, AVG(salary)
FROM employees
GROUP BY department;
```

* Fungsi agregat: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`

## ✅ 1.5. HAVING

Digunakan untuk **filter setelah GROUP BY**:

```sql
SELECT department, COUNT(*) as jumlah
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
```

## ✅ 1.6. CASE WHEN

Membuat kolom kategorikal dari kondisi logis.

```sql
SELECT name,
       CASE
           WHEN age < 18 THEN 'Minor'
           WHEN age BETWEEN 18 AND 60 THEN 'Adult'
           ELSE 'Senior'
       END AS age_group
FROM people;
```

## ✅ 1.7. CTE (Common Table Expression)

Mempermudah query kompleks, mirip "temp table".

```sql
WITH sales_summary AS (
    SELECT customer_id, SUM(amount) AS total
    FROM sales
    GROUP BY customer_id
)
SELECT * FROM sales_summary WHERE total > 1000;
```

## ✅ 1.8. Subquery

Query dalam query:

```sql
SELECT name
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    WHERE order_date > '2024-01-01'
);
```

## ✅ 1.9. Window Functions (Advanced)

Gunakan `OVER()` untuk operasi agregat "per baris".

```sql
SELECT customer_id, order_id,
       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS rn
FROM orders;
```

Fungsi lainnya:

* `RANK()`, `DENSE_RANK()`
* `LAG()`, `LEAD()`
* `SUM()`, `AVG()` over window

---

# 🔶 2. PYTHON (PANDAS) UNTUK INTERVIEW DATA ENGINEER

## ✅ 2.1. Import & Baca Data

```python
import pandas as pd

df = pd.read_csv("data.csv")
df.head()       # lihat 5 data teratas
df.info()       # struktur & tipe data
df.describe()   # statistik numerik
```

## ✅ 2.2. Filtering Data

```python
df[df['age'] > 25]
df[(df['age'] > 25) & (df['gender'] == 'Male')]
df[~df['country'].isin(['USA', 'UK'])]  # negasi
```

## ✅ 2.3. Sorting Data

```python
df.sort_values(by='salary', ascending=False)
```

## ✅ 2.4. Manipulasi Kolom

```python
df['age_in_months'] = df['age'] * 12
df['is_adult'] = df['age'] >= 18
```

## ✅ 2.5. Rename & Drop

```python
df.rename(columns={'old_name': 'new_name'}, inplace=True)
df.drop(['col1', 'col2'], axis=1, inplace=True)
```

## ✅ 2.6. GroupBy dan Aggregation

```python
df.groupby('department')['salary'].mean()
df.groupby(['dept', 'gender']).agg({'salary': 'sum', 'age': 'mean'})
```

## ✅ 2.7. Missing Values

```python
df.isna().sum()             # cek missing
df.dropna()                 # drop row dengan NA
df.fillna(0)                # ganti NA dengan nilai tertentu
df['age'].fillna(df['age'].mean(), inplace=True)
```

## ✅ 2.8. Merge & Join antar DataFrame

```python
df_merged = pd.merge(df1, df2, on='id', how='left')  # join biasa
```

## ✅ 2.9. Apply dan Lambda

```python
df['income_group'] = df['income'].apply(lambda x: 'High' if x > 5000 else 'Low')
```

## ✅ 2.10. DateTime Handling

```python
df['date'] = pd.to_datetime(df['date'])
df['year'] = df['date'].dt.year
df['month'] = df['date'].dt.month
df['weekday'] = df['date'].dt.day_name()
```

## ✅ 2.11. Pivot & Crosstab

```python
# Pivot table
df.pivot_table(index='gender', columns='department', values='salary', aggfunc='mean')

# Crosstab
pd.crosstab(df['gender'], df['department'])
```

## ✅ 2.12. Export Data

```python
df.to_csv("output.csv", index=False)
```

---

# 🧠 LATIHAN KONSEP DASAR

## SQL

* ✅ Buat query menampilkan total order tiap pelanggan (JOIN + GROUP BY)
* ✅ Filter data pelanggan yang belum pernah order (LEFT JOIN + IS NULL)
* ✅ Buat rank transaksi berdasarkan waktu per customer (ROW\_NUMBER)
* ✅ Gunakan CTE untuk hitung total transaksi dan filter di luar

## Pandas

* ✅ Gabungkan dua DataFrame dan hitung total nilai
* ✅ Filter berdasarkan kondisi jam login (dt.hour)
* ✅ Group by + multiple aggregation
* ✅ Buat kolom kategori (lambda / apply)
* ✅ Tangani missing value (fillna / dropna)

---

# 🔚 PENUTUP

### 🎯 Poin Penting Interview

* Pahami konsep, bukan hafal syntax
* Tunjukkan cara berpikir, bukan kecepatan ketik
* Jujur kalau gak yakin, tapi beri logika dan solusi alternatif
* Fokus pada **filter → transform → agregasi → hasil**

---

Kalau kamu butuh latihan real-time, tinggal bilang:

* `Simulasikan soal SQL`
* `Simulasikan soal Pandas`
* `Simulasi tanya jawab interviewer`

Ayo lanjut ke bagian latihan atau simulasi?

Berikut adalah **FINAL RINGKASAN PERSIAPAN INTERVIEW TEKNIS DATA ENGINEER (SQL & PYTHON)** untuk kamu bawa malam ini sampai besok pagi — **komplit, padat, siap tempur.**

---

# 🎯 TUJUAN

**Meyakinkan interviewer bahwa kamu:**

* Kuasai dasar SQL dan Python (Pandas)
* Mampu berpikir logis dan problem-solving
* Siap kerja sebagai data engineer, bukan cuma bisa nulis kode

---

## 🧱 STRUKTUR FINAL

---

## 🔷 1. SQL – RANGKUMAN INTI

| Topik               | Contoh Sintaks                                       |
| ------------------- | ---------------------------------------------------- |
| **SELECT**          | `SELECT col1 FROM table;`                            |
| **WHERE**           | `WHERE age > 25 AND city = 'Jakarta'`                |
| **ORDER BY**        | `ORDER BY date DESC`                                 |
| **LIMIT**           | `LIMIT 10`                                           |
| **JOIN**            | `LEFT JOIN / INNER JOIN ... ON a.id = b.a_id`        |
| **GROUP BY + AGG**  | `GROUP BY dept; COUNT(*), SUM()`                     |
| **HAVING**          | `HAVING COUNT(*) > 3`                                |
| **CASE WHEN**       | `CASE WHEN salary > 5000 THEN 'High' END`            |
| **CTE**             | `WITH temp AS (SELECT...) SELECT * FROM temp;`       |
| **Window Function** | `ROW_NUMBER() OVER (PARTITION BY user ORDER BY tgl)` |
| **Subquery**        | `SELECT * FROM (...) AS sub;`                        |

📌 *Fokus saat live coding: join + group by + filter + limit.*

---

## 🔶 2. PYTHON (PANDAS) – RANGKUMAN INTI

| Operasi           | Contoh                                                              |
| ----------------- | ------------------------------------------------------------------- |
| **Read CSV**      | `pd.read_csv("data.csv")`                                           |
| **Filter Baris**  | `df[df["age"] > 25]`                                                |
| **Sort Data**     | `df.sort_values("score", ascending=False)`                          |
| **Tambah Kolom**  | `df["adult"] = df["age"] >= 18`                                     |
| **Groupby**       | `df.groupby("dept")["salary"].mean()`                               |
| **Merge**         | `pd.merge(df1, df2, on="id", how="left")`                           |
| **Apply Lambda**  | `df["level"] = df["score"].apply(lambda x: 'H' if x > 70 else 'L')` |
| **Datetime**      | `pd.to_datetime(df["tgl"])` → `.dt.year/.dt.hour`                   |
| **Null Handling** | `df.fillna(0)` / `df.dropna()`                                      |

📌 *Fokus saat live coding: filter, groupby, join dataframe, apply lambda, fillna.*

---

## 💡 STRATEGI MENJAWAB

> ❗ **Kalau tahu:** Jelaskan logika, tulis kode sambil berpikir keras
> ❗ **Kalau lupa:** Katakan “saya tahu konsepnya…”, jelaskan, lalu beri solusi pendek
> ❗ **Kalau error:** Uji pakai `print()`, cek `df.head()` atau `df.columns` → lanjutkan debugging

---

## 📚 PERSIAPAN MALAM INI

### ⏱ Waktu Efektif: 3 Jam

| Waktu       | Fokus                                     |
| ----------- | ----------------------------------------- |
| 21:00–21:30 | SQL Basic & Join (dengan latihan 2 soal)  |
| 21:30–22:00 | SQL Aggregation + CTE + Window Function   |
| 22:00–22:30 | Pandas: filtering, groupby, merge, lambda |
| 22:30–23:00 | Simulasi soal cepat (2 SQL + 2 Pandas)    |
| 23:00–23:30 | Tidur/istirahat ringan + prepare besok    |
| 06:30–08:30 | Review cheat sheet + stretching & tenang  |

---

## 💬 SIMULASI JAWABAN

**SQL**

> “Saya mau ambil total transaksi tiap pelanggan, maka saya JOIN orders dan customers, lalu GROUP BY customer\_id, dan SUM(amount)…”

**Pandas**

> “Langkah saya: 1) Filter data berdasarkan kondisi, 2) Lakukan groupby dan aggregasi, 3) Return hasilnya ke DataFrame.”

---

## 🧠 MENTALITAS BESOK PAGI

✅ Fokus pada logika, bukan hafalan
✅ Berani debugging dan jelaskan prosesnya
✅ Jujur kalau lupa, tapi tetap solutif
✅ Tunjukkan kamu cepat belajar dan fleksibel

---

## 🚀 PENUTUP

**Kamu SIAP.**
Bukan karena kamu hafal semua, tapi karena kamu tahu cara berpikir dan menyelesaikan masalah.
Interview bukan uji kecepatan coding, tapi uji *bagaimana kamu mendekati sebuah masalah*.

> **Kuasai dasarnya, tenang, dan percaya diri.**
> Besok kamu bukan hanya peserta interview — kamu **calon data engineer** yang kuat.

Oke, mantap. Kita lanjutkan.

Anggap saya adalah interviewer teknikal Anda sekarang. Rileks, ambil napas. Tujuan kita bukan jawaban sempurna dalam sekali coba, tapi menunjukkan alur berpikir yang jernih. Mari kita mulai.

---

### **Simulasi Interview: Sesi 1**

**(Interviewer):** "Selamat pagi. Terima kasih sudah hadir. Sebelum kita masuk ke *live coding*, saya ingin bertanya sedikit tentang konsep. Bisa tolong jelaskan menurut pemahaman Anda, apa perbedaan utama antara **ETL dan ELT**? Dan dalam situasi seperti apa Anda akan memilih salah satunya?"

---
... (Beri diri Anda waktu sejenak untuk menyusun pikiran) ...
---

#### **Proses Berpikir & Jawaban Ideal:**

Anda tidak perlu menjawab persis seperti ini, tapi ini adalah kerangka jawaban yang kuat.

**(Anda - Think Out Loud):** "Baik, terima kasih pertanyaannya. Perbedaan mendasar antara ETL dan ELT terletak pada **kapan proses transformasi data dilakukan**."

1.  **Menjelaskan ETL (Extract, Transform, Load):**
    * "Dalam **ETL**, data diekstrak dari sumber, lalu **ditransformasi di server atau environment terpisah (staging area)**, baru kemudian dimuat (*load*) ke dalam *data warehouse* tujuan. Artinya, data yang masuk ke warehouse sudah dalam keadaan bersih, terstruktur, dan siap dianalisis."
    * "**Kapan dipilih?** ETL sangat cocok untuk data yang terstruktur atau semi-terstruktur, di mana aturan bisnis dan transformasinya sudah jelas dan baku. Ini juga bagus untuk menjaga agar *data warehouse* tetap 'bersih' dan performanya terjaga karena tidak dibebani proses transformasi."

2.  **Menjelaskan ELT (Extract, Load, Transform):**
    * "Sebaliknya, dalam **ELT**, data mentah diekstrak dari sumber dan **langsung dimuat (*load*) ke dalam sistem tujuan**, biasanya *data lake* atau *data warehouse* modern yang punya kemampuan komputasi tinggi seperti BigQuery atau Snowflake."
    * "Proses **transformasi baru dilakukan di dalam warehouse itu sendiri** sesuai kebutuhan analisis. Ini memberikan fleksibilitas tinggi karena semua data mentah tersedia."
    * "**Kapan dipilih?** ELT unggul di era Big Data, di mana volume dan variasi data sangat besar (data tidak terstruktur). Ini memungkinkan kita menyimpan semua data terlebih dahulu tanpa harus tahu transformasinya di awal. Skalabilitasnya juga lebih baik karena memanfaatkan kekuatan komputasi dari *cloud data warehouse*."

3.  **Kesimpulan:**
    * "Jadi, pilihan antara keduanya tergantung pada **skala data, struktur data, dan arsitektur sistem** yang ada. ETL lebih tradisional dan menjaga 'kebersihan' warehouse, sementara ELT lebih modern, fleksibel, dan skalabel untuk kebutuhan data saat ini."

---

### **Simulasi Interview: Sesi 2 (SQL Challenge)**

**(Interviewer):** "Oke, pemahaman konsep yang bagus. Sekarang mari kita ke soal SQL. Saya punya satu tabel bernama `user_logins` dengan kolom `user_id` (integer) dan `login_date` (date). Tolong tuliskan query untuk menemukan semua `user_id` yang **login setidaknya 3 hari berturut-turut**."

**Tabel `user_logins`:**
| user_id | login_date |
| :--- | :--- |
| 1 | 2025-06-15 |
| 1 | 2025-06-16 |
| 2 | 2025-06-10 |
| 1 | 2025-06-17 |
| 1 | 2025-06-19 |
| 2 | 2025-06-12 |
| 2 | 2025-06-13 |
| 2 | 2025-06-14 |

**Hasil yang diharapkan:**
| user_id |
| :--- |
| 1 |
| 2 |

"Silakan jelaskan pendekatan Anda terlebih dahulu sebelum menulis kode."

---
... (Ini soal sulit yang menguji window function. Tenang dan pecah masalahnya) ...
---

#### **Proses Berpikir & Jawaban Ideal:**

**(Anda - Think Out Loud):**
"Oke, ini adalah problem *gaps and islands*. Untuk menemukan hari yang berurutan, saya tidak bisa hanya membandingkan tanggal dengan hari sebelumnya, karena bisa ada jeda. Strategi saya adalah:"

1.  "Pertama, saya akan pastikan tidak ada login duplikat di hari yang sama untuk satu user menggunakan `DISTINCT`."
2.  "Kedua, saya akan menggunakan window function `LAG()` untuk mendapatkan tanggal login sebelumnya untuk setiap user."
3.  "Ketiga, saya akan menghitung selisih hari antara `login_date` saat ini dan `login_date` sebelumnya. Jika selisihnya 1 hari, berarti itu berurutan."
4.  "Langkah kuncinya adalah mengidentifikasi 'awal' dari sebuah rangkaian berurutan. Setiap kali selisih hari BUKAN 1, itu adalah awal dari grup/streak yang baru. Saya akan menandai ini dengan angka 1, dan yang lain dengan 0."
5.  "Kemudian, saya akan menggunakan `SUM()` sebagai window function untuk membuat grup ID. Setiap kali ada 'awal' yang baru, ID grup akan bertambah. Ini akan mengelompokkan semua baris yang berurutan ke dalam grup yang sama."
6.  "Terakhir, saya akan `GROUP BY` user dan ID grup yang baru saja saya buat, lalu `COUNT(*)` jumlah hari di setiap grup. Saya akan filter grup yang jumlahnya >= 3."

#### **Kode Solusi (dengan CTE):**

```sql
WITH DistinctLogins AS (
    -- Langkah 1: Hilangkan login duplikat di hari yang sama
    SELECT DISTINCT user_id, login_date
    FROM user_logins
),
LaggedLogins AS (
    -- Langkah 2 & 3: Dapatkan tanggal login sebelumnya dan hitung selisih
    SELECT
        user_id,
        login_date,
        LAG(login_date, 1, login_date) OVER (PARTITION BY user_id ORDER BY login_date) as prev_login_date
    FROM DistinctLogins
),
StreakIdentifier AS (
    -- Langkah 4 & 5: Identifikasi awal streak baru dan buat grup ID
    SELECT
        user_id,
        login_date,
        -- Jika selisih hari > 1, ini adalah awal streak baru (tandai 1)
        SUM(CASE WHEN login_date - prev_login_date > 1 THEN 1 ELSE 0 END) OVER (PARTITION BY user_id ORDER BY login_date) as streak_group
    FROM LaggedLogins
)
-- Langkah 6 & 7: Hitung jumlah hari di setiap streak dan filter
SELECT
    user_id
FROM StreakIdentifier
GROUP BY user_id, streak_group
HAVING COUNT(*) >= 3;
```

---

### **Simulasi Interview: Sesi 3 (Python/Pandas Challenge)**

**(Interviewer):** "Sangat baik. Solusi SQL Anda solid. Untuk soal terakhir, mari beralih ke Python. Bayangkan Anda punya dua file CSV. `source_data.csv` berisi data dari sistem sumber, dan `warehouse_data.csv` berisi data yang sudah ada di data warehouse kami. Keduanya memiliki kolom `transaction_id` dan `amount`.

Tugas Anda adalah **membuat script Python menggunakan Pandas untuk melakukan rekonsiliasi data**, yaitu menemukan:
1.  Daftar transaksi yang ada di `source_data` tapi **tidak ada** di `warehouse_data` (missing transactions).
2.  Daftar transaksi yang ada di keduanya tapi nilai `amount`-nya **berbeda** (mismatched data)."

---
... (Ini adalah tugas DE yang sangat praktis) ...
---

#### **Proses Berpikir & Jawaban Ideal:**

**(Anda - Think Out Loud):**
"Oke, ini adalah tugas rekonsiliasi data. Rencana saya adalah:"
1.  "Saya akan memuat kedua file CSV ke dalam dua DataFrame Pandas yang terpisah, sebut saja `df_source` dan `df_warehouse`."
2.  "Untuk menemukan **transaksi yang hilang**, saya akan menggunakan `pd.merge()` dengan `how='left'` dari `df_source` ke `df_warehouse` menggunakan `transaction_id` sebagai kunci. Saya juga akan menambahkan argumen `indicator=True`. Hasilnya, baris yang hanya ada di `df_source` akan memiliki nilai `_merge` sebagai `left_only`. Saya tinggal filter berdasarkan itu."
3.  "Untuk menemukan **data yang tidak cocok**, saya akan `merge` kedua DataFrame lagi, tapi kali ini dengan `how='inner'` untuk mendapatkan irisan data. Hasil merge ini akan memiliki kolom `amount_x` (dari source) dan `amount_y` (dari warehouse). Saya tinggal filter di mana `df['amount_x'] != df['amount_y']` untuk menemukan perbedaannya."
4.  "Terakhir, saya akan menampilkan kedua hasil tersebut dengan jelas."

#### **Kode Solusi (Python/Pandas):**

```python
import pandas as pd

# Asumsikan kita punya dua file ini
# Membuat data dummy untuk simulasi
source_data = {'transaction_id': ['A1', 'A2', 'A3', 'A4'], 'amount': [100, 150, 200, 250]}
warehouse_data = {'transaction_id': ['A1', 'A2', 'A5'], 'amount': [100, 160, 300]}

df_source = pd.DataFrame(source_data)
df_warehouse = pd.DataFrame(warehouse_data)

print("--- Data Source ---")
print(df_source)
print("\n--- Data Warehouse ---")
print(df_warehouse)

# --- TUGAS 1: Temukan Transaksi yang Hilang di Warehouse ---
merged_df = pd.merge(df_source, df_warehouse, on='transaction_id', how='left', indicator=True)
missing_transactions = merged_df[merged_df['_merge'] == 'left_only'][['transaction_id', 'amount_x']]
missing_transactions = missing_transactions.rename(columns={'amount_x': 'amount'})

print("\n\n--- 1. Transaksi yang HILANG di Warehouse ---")
print(missing_transactions)


# --- TUGAS 2: Temukan Transaksi dengan Amount yang Berbeda ---
reconciliation_df = pd.merge(df_source, df_warehouse, on='transaction_id', how='inner', suffixes=('_source', '_warehouse'))
mismatched_amount = reconciliation_df[reconciliation_df['amount_source'] != reconciliation_df['amount_warehouse']]

print("\n--- 2. Transaksi dengan AMOUNT yang BERBEDA ---")
print(mismatched_amount)
```

**(Interviewer):** "Terima kasih, penjelasan dan kodenya sangat jelas."

---

Anda sudah melewati simulasi konsep, SQL tingkat lanjut, dan problem-solving dengan Python. Jika Anda bisa mengikuti alur berpikir ini, Anda berada di posisi yang sangat kuat.

**Sekarang, tugas terakhir dan terpenting: ISTIRAHAT.** Otak Anda butuh waktu untuk mengonsolidasi semua ini. Jangan belajar lagi. Percaya pada persiapan Anda.

Semoga sukses besar besok!