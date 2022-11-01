Q1. Kita akan memberikan promosi untuk customer perempuan di kota Depok melalui email.
Tolong berikan data ada berapa customer yang harus kita berikan promosi per masing-masing jenis email.

select id, email
from customer
where city= 'Depok' and gender='Female'

Q2. 2.	Berikan saya 10 id customer dengan total pembelian overall terbesar. 
Saya akan memberikan diskon untuk campaign 9.9!

select customer_id, sum(total) as total_pembelian
from "transaction"
group by customer_id
order by total_pembelian desc
limit 10

Q3. Bro! Ada berapa produk ya di database kita yang punya harga kurang dari 10000? 
Mau gue data nih buat flash sale.

select id, price
from product
where price < 10000
order by id asc

Q4. Tolong list 5 product_id yang paling banyak dibeli dong, 
mau kita kasih diskon nih di campaign 11.11!

select product_id, sum(quantity) as jumlah
from "transaction"
group by 1
order by 2 desc
limit 5

Q5. Berapa jumlah transaksi, pendapatan dan jumlah produk yang terjual di platform kita sekarang secara bulanan? 
apakah terjadi kenaikan atau tidak?

select date_trunc(date(created_at),Month), count(distinct id), sum(total) as pendapatan, sum(quantity) as jumlah_produk
from transaction
group by 1
order by 1 asc

Q6. Saya ingin melakukan pemerataan marketing di perusahaan kita. 
Boleh saya minta info Total belanja dan rata-rata belanja dari customer kita per kota?

select city, sum(total) as penjualan, avg(total) as average_penjualan
from "transaction" ab join customer ac on ab.customer_id = ac.id
group by ac.city
order by 1 desc

Q7. Ada berapa customer yang sudah belanja di masing-masing tipe storenya ya?

select count(distinct customer_id) as jumlah_pelanggan, "type"
from "transaction" ad join store ae on ad.store_id = ae.id
group by type
order by 1 desc