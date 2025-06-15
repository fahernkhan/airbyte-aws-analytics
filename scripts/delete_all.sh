#!/bin/bash

echo "Memulai proses pembersihan TOTAL Docker..."

# --- Hentikan Semua Container ---
echo "🔴 Menghentikan semua container..."
if docker ps -aq | grep -q .; then
    docker stop $(docker ps -aq)
    echo "✅ Semua container telah dihentikan."
else
    echo "ℹ️ Tidak ada container yang sedang berjalan."
fi

# --- Hapus Semua Container ---
echo "🗑️ Menghapus semua container..."
if docker ps -aq | grep -q .; then
    docker rm $(docker ps -aq)
    echo "✅ Semua container telah dihapus."
else
    echo "ℹ️ Tidak ada container yang perlu dihapus."
fi

# --- Hapus Semua Image ---
echo "🖼️ Menghapus semua image..."
if docker images -q | grep -q .; then
    docker rmi -f $(docker images -q)
    echo "✅ Semua image telah dihapus."
else
    echo "ℹ️ Tidak ada image yang ditemukan."
fi

# --- Hapus Semua Volume ---
echo "📦 Menghapus semua volume..."
if docker volume ls -q | grep -q .; then
    docker volume rm $(docker volume ls -q)
    echo "✅ Semua volume telah dihapus."
else
    echo "ℹ️ Tidak ada volume yang ditemukan."
fi

# --- Hapus Semua Network Kecuali Default ---
echo "🌐 Menghapus semua network non-default..."
NON_DEFAULT_NETWORKS=$(docker network ls | grep -vE 'bridge|host|none' | awk 'NR>1 {print $1}')
if [ -n "$NON_DEFAULT_NETWORKS" ]; then
    docker network rm $NON_DEFAULT_NETWORKS
    echo "✅ Semua network non-default telah dihapus."
else
    echo "ℹ️ Tidak ada network non-default yang ditemukan."
fi

# --- Bersihkan Semua Cache Builder ---
echo "🧹 Menghapus semua builder cache..."
docker builder prune -a --force
echo "✅ Semua builder cache telah dibersihkan."

# --- Tampilkan Penggunaan Disk Setelah Pembersihan ---
echo "📊 Penggunaan disk Docker setelah pembersihan:"
docker system df

echo "✅ Pembersihan Docker total selesai!"
