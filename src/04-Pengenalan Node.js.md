# Pengenalan Node.js

Node.js adalah runtime Javascript yang dibangun di mesin Javascript V8 Chrome untuk memudahkan pembuatan aplikasi jaringan cepat dan skalabel.

Node js bukanlah bahasa pemrograman, melainkan runtime environment untuk mengeksekusi kode javascript di sisi server (server-side).

Sehingga memungkinkan kita untuk mengembangkan aplikasi web menggunakan bahasa pemrograman javascript di sisi server (server-side).

Layaknya PHP, Phyton, Ruby dan lainnya.

Tidak hanya itu, node.js juga include dengan berbagai modul library javascript yang dapat digunakan secara instan.

Seperti http modul, file system, dan lain sebagainya.

Jadi, dapat disimpulkan bahwa node.js adalah runtime environment + library javascript.

## Kekuatan Node.js

Node.js menggunakan model I / O non-blocking yang bersifat event-driven yang membuatnya ringan dan efisien, sempurna untuk aplikasi real-time data-intensif yang berjalan di perangkat terdistribusi.

Untuk lebih jelasnya, berikut penjabarannya:

### Asynchronous and Event Driven

Semua pustaka Node.js API adalah asynchronous, artinya, non-blocking. Ini pada dasarnya berarti server berbasis Node.js tidak pernah menunggu API untuk mengembalikan data.

Server pindah ke API berikutnya setelah memanggilnya dan mekanisme pemberitahuan event Node.js membantu server untuk mendapatkan respons dari panggilan API sebelumnya.

### Sangat Cepat

Dibangun di Google Chrome V8 JavaScript Engine, pustaka Node.js sangat cepat dalam eksekusi kode.

### Single Threaded tetapi Highly Scalable

Node.js menggunakan model bergulir tunggal dengan perulangan peristiwa.

Mekanisme event membantu server untuk merespons dengan cara non-blocking dan menjadikan server sangat skalabel dibandingkan dengan server tradisional yang membuat untaian terbatas untuk menangani permintaan.

Node.js menggunakan program bergulir tunggal dan program yang sama dapat memberikan layanan ke jumlah permintaan yang jauh lebih besar daripada server tradisional seperti Apache HTTP Server.

### Tidak Ada Buffer

Aplikasi Node.js tidak pernah menyangga data apa pun. Aplikasi ini hanya menghasilkan data dalam potongan.

### Lisensi

Node.js dirilis di bawah lisensi MIT.

## Hello World

Hal selanjutnya yang harus dilakukan adalah membuat program Hello World!.

Silahkan buka teks editor dan tulis kode berikut:

```js
console.log('Hello World!');
```

Simpan dengan nama `hello-world.js`.

Setelah itu, eksekusi dengan perintah:

```sh
node hello-world.js
```

Maka hasilnya:

```
Hello World!
```

## NPM

Salah satu tool yang akan sering digunakan dalam Nodejs adalah NPM (Node Package Manager). NPM sudah otomatis terinstal saat kita menginstal Nodejs.

NPM dapat kita gunakan untuk:

* Membuat Project Baru;
* Menginstal modul atau library;
* Menjalankan skrip command line.

Pada kesempatan ini, kita akan belajar tiga hal tersebut dan juga mengenal file `package.json`.

### Membuat Project Baru dengan NPM

Pertama kita harus menyediakan direktori untuk project-nya. Silahkan buat direktori baru dengan perintah ini:

```sh
mkdir belajar-npm
cd belajar-npm
npm init
```

Maka NPM akan meminta kita untuk mengisi data project yang akan dibuat.
Membuat Project Nodejs baru dengan NPM

Silahkan diisi saja apa adanya, karena nanti kita bisa modifikasi lagi.

Perintah npm init akan membuat file package.json yang isinya seperti ini:

```json
{
  "name": "belajar-npm",
  "version": "0.1.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Ganesha <reekoheek@gmail.com> (http://sagara.id)",
  "license": "ISC"
}
```

### File package.json

File package.json adalah file yang berisi deskripsi dari project Nodejs. NPM membutuhkan file ini untuk bisa bekerja.

Informasi project berisi nama, versi, dan deskripsi. Lalu di bagian script, berisi skrip-skrip bash atau command line untuk dieksekusi dengan NPM.

Selain properti-properti di atas, masih ada lagi properti lain:

* `dependencies` berisi keterangan modul atau library yang dibutuhkan aplikasi;
* `devDependencies` berisi keterangan modul atau library yang dibutuhkan untuk pengembangan aplikasi.

### Menginstal Modul dengan NPM

Apabila kita membutuhkan modul atau library, kita bisa menyuruh NPM untuk menginstalnya.

Perintahnya seperti ini:

```sh
npm install <nama modul>
```

Kita bisa mencari nama modul di website NPM.

Sebagai contoh, kita coba install modul Momentjs. Momentjs adalah modul Javascript untuk untuk parse, validasi, dan manipulasi waktu.

```sh
npm install moment
```

Perintah ini akan men-download library Momenjs dan menambahkannya ke dalam package.json.

dan di dalam package.json akan ditambahkan seperti ini.

```json
{
  "name": "belajar-npm",
  "version": "0.1.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Ganesha <reekoheek@gmail.com> (http://sagara.id)",
  "license": "ISC",
  "dependencies": {
    "moment": "^2.20.1"
  }
}
```

Selain itu, perintah npm install juga akan membuat file baru bernama package-lock.json. File ini bertugas mengunci versi modul-modul yang sudah terinstal.

## Modul

Saat mengembangkan aplikasi dengan Nodejs, kita tidak akan bisa lepas dari penggunaan Modul. Kadang juga bisa memperlambat proses development, karena banyak sekali modul yang harus dipilih.

Saat ini Nodejs memiliki jutaan modul yang didistribusikan dalam bentuk paket. Modul-modul ini dapat kita install dengan NPM dan juga kita bisa buat sendiri.

Pada kesempatan ini, kita akan belajar cara menggunakan modul Nodejs dimulai dari:

* Pengertian Modul Nodejs;
* Menggunakan Modul Build-in;
* Menggunakan Modul dari NPM;
* Membuat Modul Sendiri.

### Pengertian Modul

Modul bisa disamakan seperti library yang berisi fungsi-fungsi untuk digunakan di dalam aplikasi. Sehingga kita tidak perlu membuat sendiri fungsi dari nol.

Sebelum bisa digunakan, modul harus diimpor terlebih dahulu.

Modul Nodejs didistribusikan dalam bentuk paket yang bisa di-download dan diinstal dengan paket manager seperti NPM dan Yarn.

Modul yang diinstal dengan paket manager akan didefinisikan dalam file package.json dan package-lock.json.

Nodejs memiliki banyak modul bawaan (build-in) yang bisa kita manfaatkan dalam membuat aplikasi. Modul-modul ini tidak perlu kita install dengan NPM, karena suda disediakan sejak kita install Nodejs.

Contoh beberapa modul bawaan:

* http untuk melakukan HTTP Request dan membuat server HTTP.
* fs untuk bekerja dengan file sistem.
* url untuk parsing string dari URL.
* querystring untuk bekerja query string.
* os menyediakan informasi tentang sistem operasi.
* dll.

Cara mengimpor modul build-in ke dalam aplikasi adalah menggunakan fungsi require().

Contoh:

```js
let http = require('http');
```

Artinya: kita akan mengimpor modul http lalu membuat objek http untuk menampung modul tersebut.

Setelah diimpor, barulah modul tersebut dapat digunakan seperti ini:

```js
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('Hello World!');
}).listen(8080);
```

### Menggunakan Modul dari NPM

Cara menggunakan modul dari NPM, sama seperti menggunakan modul build-in. Perbedaannya adalah kita harus install dulu modulnya dengan NPM, baru bisa diimpor dengan fungsi `require()`.

Buatlah project baru dengan nama `belajar-modul-nodejs`.

```sh
mkdir belajar-modul-nodejs
cd belajar-modul-nodejs/
npm init --yes
```

Keterangan: Parameter --yes berfungsi untuk membuat file package.json secara default.

Setelah itu, silahkan install modul yang diinginkan.

Sebagai contoh, kita akan menginstal modul momentjs:

```sh
npm install moment
```

Setelah terinstall, akan ada direktori baru berbnama node_modules.
Instalasi Modul Nodejs dengan NPM

Di sanalah semua modul yang terinstal dengan NPM akan disimpan.

Berikutnya, silahkan buat file index.js dengan isi sebagai berikut.

```js
// impor modul momentjs
let moment = require('moment');

// menggunakan modul momentjs
console.log('Sekarang: ' + moment().format('D MMMM YYYY, h:mm:ss a'));
```

Coba jalankan dengan perintah:

```sh
node index.js
```

Maka hasilnya akan seperti ini:

```
Sekarang: 4 February 2019, 0:00:22 am
```

### Membuat Modul Sendiri

Saat modul yang kita butuhkan tidak ada di dalam build-in dan NPM, maka kita harus buat sendiri.

Cara membuat modul Nodejs sangatlah mudah. Tinggal membuat fungsi, objek, ataupun class lalu diekspor.

Contoh: `salam.js`

```js
exports.salamPagi = function () {
    return 'Selamat Pagi!';
};
```

Kita harus mendaftarkan fungsi ke dalam properti objek exports agar dapat digunakan diluar file. Setelah itu, baru kita bisa impor.

Misalnya akan kita gunakan pada file index.js.

```js
// impor modul momentjs dan salam
var moment = require('moment');
var salam = require('./salam');

// menggunakan modul
console.log(salam.salamPagi());
console.log('Sekarang: ' + moment().format('D MMMM YYYY, h:mm:ss a'));
```

Saat kita eksekusi file index.js, maka akan menghasilkan seperti ini:

```
Selamat Pagi!
Sekarang: 4 February 2019, 0:00:22 am
```
