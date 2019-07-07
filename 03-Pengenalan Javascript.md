
# Pengenalan Javascript

Node.js adalah sebuah mesin dengan menggunakan bahasa pemrograman Javascript.
Untuk mengembangkan aplikasi Node.js, anda harus mengetahui dasar-dasar
pemrograman dengan Javascript.

## Tipe Data

Variable digunakan untuk menyimpan sebuah data. Dalam Javascript terdapat berbagai tipe data. Beberapa tipe data dasar antara lain adalah:

### String

String adalah tipe data yang biasa digunakan untuk merepresentasikan Kata atau kalimat.

### Number

Number adalah tipe data yang digunakan untuk merepresentasikan angka, baik bilangan bulat, real, exponensial dan lain sebagainya.

### Boolean

Boolean adalah tipe data yang digunakan untuk menyatakan ya atau tidak, true atau false.

### Array

Array adalah tipe data yang berupa kontainer untuk menampung satu atau lebih data. Array dapat menampung semua tipe data yang terdapat dalam javascript.

### Object

Object hampir mirip dengan Array. Bedanya, setiap elemen data yang ditampung di dalamnya memiliki nama atau "key".

### Function

Function adalah potongan potongan kode-kode instruksi yang dapat dipanggil berulang-ulang.
Ada 4 cara yang bisa kita lakukan untuk membuat fungsi di Javascript:

#### Membuat Fungsi dengan Cara Biasa

Cara ini paling sering digunakan, terutama buat yang baru belajar Javascript.

```js
function namaFungsi () {
  console.log("Hello World!");
}
```

#### Membuat Fungsi dengan Ekspresi

Cara membuat fungsi dengan ekspresi:

```js
let namaFungsi = function () {
  console.log("Hello World!");
}
```

Kita menggunakan variabel, lalu diisi dengan fungsi. Fungsi ini sebenarnya adalah fungsi anonim (anonymous function) atau fungsi tanpa nama.

#### Membuat Fungsi dengan Tanda Panah

Cara ini sering digunakan di kode Javascript masa kini, karena lebih sederhana. Akan tetapi sulit dipahami bagi pemula. Fungsi ini mulai muncul pada standar ES6.

Contoh:

```js
let namaFungsi = () => {
  console.log("Hello World!");
}
// atau seperti ini (jika isi fungsi hanya satu baris):
let namaFungsi = () => console.log("Hello World!");
```

Sebenarnya hampir sama dengan yang menggunakan ekspresi. Bedanya, kita menggunakan tanda panah (=>) sebagai ganti function.
Pembuatan fungsi dengan cara ini disebut arrow function.

#### Membuat Fungsi dengan Konstruktor

Cara ini sebenarnya tidak direkomendasikan oleh Developer Mozilla, karena terlihat kurang bagus. Soalnya body fungsinya dibuat dalam bentuk string yang dapat mempengaruhi kinerja engine javascript.

Contoh:

```js
let namaFungsi = new Function('console.log("Hello World!");');
```

Untuk yang masih pemula, saya rekomendasikan gunakan cara yang pertama dulu. Nanti kalau sudah terbiasa baru coba gunakan cara ke-2 dan ke-3.

### Undefined

Undefined merepresentasikan sebuah variabel yang belum didefinisikan tipe datanya.

### Null

Null adalah sebuah object spesial yang bernilai kosong.

## Struktur Percabangan

Dalam pemrograman terdapat sebuah mekanisme untuk melakukan percabangan prosedur
yang dilakukan oleh program.

### Percabangan IF

Jika anda pernah mempelajari bahasa pemograman lain, pastinya tidak asing dengan struktur IF. Struktur IF adalah stuktur kode pemograman ‘conditional’ yang akan membuat percabangan di dalam program. Dengan menggunakan struktur IF, kita bisa membuat 2 percabangan program yang akan dieksekusi jika ‘kondisi’ terpenuhi, dan akan menjalankan kode program lain jika ‘kondisi’ tidak terpenuhi.

Berikut adalah penulisan dasar alur logika IF:

```js
if (kondisi) {
  // kode program jika kondisi true
}
else {
  // kode program jika kondisi false
}
```

Kondisi di dalam struktur IF disini bisa berisi variabel dengan tipe data boolean, atau dengan kode program yang akan menghasilkan boolean, misalkan IF (a==b), atau IF (a>=b). Jika kondisi diisi dengan selain boolean (selain true atau false), maka hasilnya akan dikonversi menjadi boolean (tentang aturan konversi ini telah kita bahas pada tutorial tentang tipe data boolean).
Penulisan struktur IF di dalam Javascript, mirip dengan bahasa pemograman C++ atau PHP. Berikut adalah contoh penulisan struktur IF di dalam Javascript:

```js
let nama = 'ilkom';     //buat variabel String nama dan isi dengan "ilkom"
if (nama == 'ilkom') {  // cek apakah variabel nama berisi "ilkom"
  console.log('Berhasil!');
}
```

Kode program diatas tidak akan menjalankan perintah console.log("Berhasil!") jika variabel nama tidak berisi string "ilkom".

### Percabangan SWITCH

Struktur logika SWITCH dapat disederhanakan sebagai bentuk khusus dari struktur IF ELSE. SWITCH digunakan untuk percabangan kode program dimana kondisi yang diperiksa hanya 1 namun membutuhkan banyak opsi.

Struktur dasar penulisan SWITCH adalah sebagai berikut:

```js
switch (kondisi) {
case hasil_kondisi_1:
  // kode program jika kondisi sama dengan hasil_kondisi_1
  break;
case hasil_kondisi_2:
  // kode program jika kondisi sama dengan hasil_kondisi_2
  break;
default:
  // kode program untuk kondisi lainnya
  break;
}
```

Kondisi untuk inputan struktur SWITCH biasanya adalah variabel yang akan diperiksa. Hasil percabangan dari variabel tersebut akan ditangani oleh perintah case. Opsi default bisa ditambahkan untuk menangani kasus yang tidak ditangani oleh perintah case.

Agar lebih mudah dipahami, langsung saja kita masuk ke dalam kode program SWITCH dalam Javascript. Contoh program berikut mengambil contoh terakhir dalam tutorial percabangan ELSE IF sebelumnya, yakni kita memeriksa nilai dari variabel angka dan menampilkan hasilnya dalam bentuk huruf. Jika menggunakan struktur SWITCH, berikut adalah cara penulisannya:

```js
let angka=5;

switch (angka) {
case 1:
  console.log("Angka Satu");
  break;
case 2:
  console.log("Angka Dua");
  break;
case 3:
  console.log("Angka Tiga");
  break;
case 4:
  console.log("Angka Empat");
  break;
default:
  console.log("Bukan angka 1 - 4");
  break;
}
```

Setelah mendeklarasikan variabel a dan mengisi nilainya dengan angka 5, kemudian kita masuk ke struktur SWITCH.

Blok SWITCH diawali dan diakhiri dengan kurung kurawal. Dan kemudian untuk setiap kemungkinan yang terjadi dari variabel angka, ditampung dengan perintah case.

Perintah case diikuti dengan kondisi yang ingin di-’tampung’. Di dalam contoh diatas saya menampung isi variabel angka dengan case 1 untuk menangani kondisi jika angka==1, case 2 untuk menangani kondisi jika angka==2, dan seterusnya. Setiap case lalu diikuti dengan tanda titik dua (:).

Pada kondisi terakhir, terdapat perintah default yang tujuannya adalah untuk menampung kondisi jika seluruh kondisi case tidak tersedia. Contohnya, jika variabel angka berisi angka 0, maka kondisi case yang ada tidak tersedia untuk menangani hal ini, dan perintah default lah yang akan dijalankan.

Jika anda perhatikan dalam setiap case, saya menambahkan perintah break. Perintah break disini bertujuan untuk mengistruksikan kepada Javascript untuk segera keluar dari SWITCH jika salah satu case ditemukan. Jika kita tidak mencantumkan perintah break, maka seluruh perintah mulai dari case yang sesuai sampai ke bawah akan dijalankan. Berikut contohnya:

```js
let angka=3;

switch (angka) {
case 1:
  console.log("Angka Satu");
case 2:
  console.log("Angka Dua");
case 3:
  console.log("Angka Tiga");
case 4:
  console.log("Angka Empat");
default:
  console.log("Bukan angka 1 - 4");
}
```

Jika anda menjalankan kode Javascript tersebut, maka yang akan dihasilkan adalah:

```
Angka Tiga
Angka Empat
Bukan angka 1 – 4
```

Hal ini terjadi karena jika tanpa perintah break, struktur SWITCH akan mengeksekusi seluruh kode program dimulai dari posisi case yang dicapai.

Sepintas kebutuhan atas perintah break ini membuat kondisi SWITCH menjadi sedikit ribet, namun karena hal tersebut, kita bisa membuat perintah break seperti berikut ini:

```js
let angka=9;

switch (angka){
case 1:
case 2:
case 3:
case 4:
case 5:
  console.log("Angka berada antara 1-5");
  break;
case 6, 7, 8, 9, 10:
  console.log("Angka berada antara 6-10");
  break;
default:
  console.log("Bukan angka 1 - 10");
  break;
}
```

Contoh kode program tersebut akan berjalan sebagaimana mestinya.

## Struktur Perulangan

Dalam pemrograman terdapat struktur perulangan untuk melakukan prosedur secara
berulang tanpa harus menuliskan perintah-perintah kode secara berulang.

### Perulangan FOR

Struktur perulangan di dalam bahasa pemograman di gunakan untuk mengulang perintah program. Terdapat beberapa struktur perulangan yang didukung oleh Javascript, dan struktur perulangan pertama yang akan kita bahas adalah struktur perulangan FOR.

Jika anda telah mempelajari bahasa pemograman lain sebelumnya, perulangan for ini akan terasa familiar. Bagi yang baru mempelajari Javascript, jangan khawatir, kita akan mempelajarinya melalui contoh-contoh program sederhana.

Struktur perulangan for, biasanya membutuhkan 4 perintah, yaitu:

* Kondisi awal perulangan
* Kondisi akhir perulangan
* Baris program yang akan diulang
* Increment / kenaikkan dalam setiap perulangan

Berikut adalah format dasar yang digunakan dalam struktur for:

for (kondisiAwal, kondisiAkhir, increment) //baris program yang akan diulang
Agar lebih mudah dipahami, kita akan mulai menggunakan kode program sederhana.
Katakan kita ingin menampilkan kalimat "Saya sedang belajar Javascript" sebanyak 10 kali, berikut adalah contoh kode programnya:

```js
let i;
for (i=1;i<=10;i=i+1) {
  console.log("Saya sedang belajar Javascript");
}
```

Pada baris pertama program, saya mendeklarasikan variabel a dengan perintah let i. Variabel i ini adalah counter, atau penghitung untuk proses perulangan.
Baris for (i = 1; i <= 10; i = i+1), berarti: lakukan perulangan for, dimulai dari i = 1, lalukan perulangan selama i <= 10, dan naikkan nilai i sebanyak 1 angka pada tiap perulangan (i = i+1).

Di dalam kode program, kita juga bisa mengakses nilai dari variabel i, seperti kode berikut ini:

```js
let i;
for (i=1;i<=10;i++) {
  console.log(i + ". Saya sedang belajar Javascript");
}
```

Karena nilai i akan terus menaik, nilai i dalam blok perulangan juga akan naik. Penulisan i++ adalah sama dengan i=i+1.

Dengan mengubah 3 kondisi ini (nilai awal, nilai akhir, dan increment) kita bisa dengan mudah mengatur perulangan yang terjadi, bahkan bernilai mundur seperti contoh berikut ini:

```js
let i;
for (i=10;i>0;i--) console.log("Anak Ayam Turun "+i);
```

Jika baris yang akan diulang terdiri dari 2 baris atau lebih maka kita harus menggunakan tanda kurung kurawal untuk menandari awal dan akhir blok for, seperti berikut ini:

```js
let i;
for (i=10;i>0;i--) {
  console.log("Anak Ayam Turun")
  console.log(i);
}
```

Untuk program yang lebih rumit, kita bisa menggunakan nested loop, atau loop bersarang, yakni konsep penggunaan perulangan for di dalam perulangan for.

### Perulangan WHILE

Cara penulisan perulangan WHILE mirip dengan struktur logika IF, yakni kondisi perulangan akan diperiksa di awal. Jika kondisi bernilai TRUE, maka perulangan akan terus dilakukan sampai dengan nilai kondisi bernilai FALSE.

Berikut adalah penulisan dasar perulangan WHILE:

```js
while (kondisi) {
  //kode program counter
}
```

Kondisi akan selalu diperiksa pada setiap perulangan, dan kita bisa ‘mengendalikan’ kondisi ini pada bagian counter di dalam perulangan.

Berikut adalah contoh kode program untuk perulangan WHILE di dalam Javascript:

```js
let i=0;
while (i<10) {
  console.log("Saya sedang belajar Javascript");
  i++;
}
```

Dengan mengubah perintah di dalam counter, kita bisa melakukan perulangan mundur seperti contoh kita pada tutorial perulangan FOR:

```js
let i=10;
while (i>0) {
  console.log("Anak Ayam Turun "+i);
  i--;
}
```

Satu hal kunci yang membedakan struktur WHILE dengan FOR, adalah di dalam perulangan FOR kondisi akhir perulangan harus sudah diketahui pada awal program. Namun dalam perulangan WHILE, kita bisa membuat perulangan yang nilai akhir atau kondisinya belum diketahui pada saat perulangan dimulai.

Struktur perulangan DO WHILE sebenarnya adalah bentuk lain dari perulangan WHILE. Perbedaan keduanya terletak pada posisi pengecekan kondisi. Apabila dalam perulangan WHILE kondisi di cek pada awal perulangan, pada perulangan DO WHILE, kondisi perulangan di cek pada akhir perulangan.

Berikut adalah contoh kode program untuk perulangan DO WHILE di dalam Javascript:

```js
let i=1;
do {
  console.log("Saya sedang belajar Javascript");
  i++;
} while (i<=10)
```

Dampak dari proses pemeriksaan kondisi di akhir perulangan ini adalah, perulangan akan dikerjakan setidaknya 1 kali, walaupun kondisi perulangan tidak dipenuhi atau menghasilkan nilai FALSE, perhatikan contoh berikut ini:

```js
let i=100;
do {
  console.log("Saya sedang belajar Javascript");
  i++;
} while (i<=10)
```

Hasil akhir dari kode tersebut adalah kalimat "Saya sedang belajar Javascript" akan tetap ditampilkan meskipun kondisi perulangan sebenarnya tidak terpenuhi.

### Perulangan FOR IN

Perulangan FOR IN adakah perulangan khusus di dalam Javascript yang digunakan untuk menampilkan ‘isi’ dari sebuah objek. Objek yang digunakan dapat berupa Array, karena array pada dasarnya juga merupakan objek di dalam Javascript.

Saya belum membahas array dan objek secara detail sampai saat ini, jika anda belum paham tentang konsep dasar array dan objek Javascript, silahkan sementara lewati tutorial ini.

Perulangan FOR IN mirip dengan perulangan FOR EACH di dalam PHP. Berikut adalah penulisan dasar perulangan FOR IN dalam Javascript:

```js
for (variabel in objek) {
  // kode program
}
```

Perulangan di dalam FOR IN akan dijalankan sebanyak ‘isi’ dari objek. Jika objek tersebut adalah Array, maka perulangan akan dilakukan sebanyak data yang ada di dalam Array.
Kita akan langsung masuk ke dalam contoh program agar perulangan FOR IN lebih mudah dipahami. Berikut adalah contoh program FOR IN untuk menampilkan data dari sebuah array:

```js
let a=[5,4,3,2,1];       // pembuatan array
let b;                   // variabel penampung
for (b in a) {
  console.log("Isi array a adalah: "+a[b]);
}
```

Pada baris pertama contoh program diatas, saya membuat Array yang disimpan dalam variabel a . Variabel a berisi 5 nilai. Perulangan FOR IN akan menampilkan seluruh isi dari array a.
Jika digunakan untuk objek, perulangan FOR IN akan menampilkan seluruh property dan method dari objek tersebut. Berikut adalah contoh kode programnnya:

```js
//buat object objek1
let objek1 = {
  a: "Belajar Javascript",
  b: 12,
  c: true,
  d: "duniailkom",
  e: [1,2,3,4],
  f: { i: "test" },
  g: function(){}
};

let b;
for (b in objek1) {
  console.log(objek1[b]);
}
```

Dalam contoh diatas, saya membuat objek dengan nama objek1 dan membuat beberapa property serta 1 method. Kemudian objek1 ini ditampilkan dengan menggunakan perulangan FOR IN. Hasil yang ditampilkan merupakan nilai String dari masing-masing property objek.

Dalam tutorial kali ini, kita telah membahas tentang perulangan FOR IN yang bisa digunakan untuk menampilkan nilai Array, ataupun Objek. Untuk tutorial selanjutnya, masih berhubungan dengan Perulangan, kita akan membahas tentang perintah Break dan Continue dalam Javascript yang sering digunakan di dalam perulangan.

### Break dalam Perulangan

Perintah break jika digunakan di dalam perulangan berfungsi untuk ‘menghentikan paksa’ proses perulangan yang berlangsung. Kita juga telah melihat penggunaan perintah break dalam struktur SWITCH.

Break biasanya digunakan setelah kondisi IF, untuk menyeleksi ‘kapan’ perulangan harus dihentikan.

Agar lebih mudah dipahami, berikut adalah contoh cara penulisan perintah break dalam perulangan FOR:

```js
let i;
for (i=1;i<=10;i++)
{
  console.log("Perulangan ke - " + i);
  if (i==7) {
    break;
  }
}
```

Dalam contoh diatas, kondisi if (i==7) break akan menyebabkan perulangan FOR hanya berjalan sampai perulangan ke-7, setelah itu perulangan akan berhenti secara ‘prematur’.

### Continue dalam Perulangan

Jika perintah break jika digunakan untuk ‘menghentikan paksa’ proses perulangan yang berlangsung, perintah continue hanya akan menghentikan perulangan yang saat ini terjadi (1 iterasi saja), dan kemudian melanjutkan perulangan iterasi berikutnya, atau bisa disebut juga untuk ‘melewati’ 1 perulangan.

Sama seperti perintah break ,continue biasanya digunakan setelah kondisi IF yang digunakan untuk menyeleksi ‘kapan’ perulangan harus di-skip atau dilewati.

### Cara Penulisan Perintah Continue

Berikut adalah contoh program penggunaan perintah Continue dalam perulangan FOR:

```js
let i;
for (i=1;i<=10;i++) {
  if (i==7) {
    continue;
  }
  console.log("Perulangan ke - " + i);
}
```

Dari contoh di atas, perintah if (i==7) akan meyeleksi perulangan. Pada saat variabel counter i sama dengan 7, maka continue. Perintah continue menyebabkan fungsi console.log yang berada dibawahnya untuk di-’lewati’ dan perulangan akan lanjut ke i=8. Dari hasil program dapat dilihat bahwa "Perulangan ke- 7" tidak akan ditampilkan.
