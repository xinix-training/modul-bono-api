# Pengenalan Teknologi Web

## Web dan Protokol REST JSON

Penggunaan Node.js yang revolusioner yaitu sebagai server. Seperti halnya menggunakan Apache - PHP, Nginx - PHP, Java - Tomcat - Apache atau IIS - ASP.NET sebagai pemroses data di sisi server, sekarang semua itu bisa tergantikan dengan memakai Javascript - Node.js.

`server-http.js`

```js
let http = require('http'),
  PORT = 3400;
let server = http.createServer(function(req, res){
  let body = "<pre>Haruskah belajar Node.js?</pre><p><h3>...Yo Mesto!</h3></p>"
  res.writeHead(200, {
    'Content-Length':body.length,
    'Content-Type':'text/html',
    'Pesan-Header':'Pengenalan Node.js'
  });

  res.write(body);
  res.end()
});

server.listen(PORT);
console.log("Port "+PORT+" : Node.js Server...");
```

Paket http merupakan paket bawaan dari platform Node.js yang mendukung penggunaan fitur-fitur protokol HTTP. Object server merupakan object yang dikembalikan dari fungsi createServer().

```js
let server = http.createServer([requestListener])
```

Tiap request yang terjadi akan ditangani oleh fungsi callback requestListener. Cara kerja callback ini hampir sama dengan ketika kita menekan tombol button html yang mempunyai atribut event onclick, jika ditekan maka fungsi yang teregistrasi oleh event onclick yaitu clickHandler(event) akan dijalankan.

`onclick-button.html`

```html
<script>
  function clickHandler(event){
    console.log(event.target.innerHTML+" Terus!");
  }
</script>

<button onclick="clickHandler(event)">TEKAN</button>
```

Sama halnya dengan callback requestListener pada object server ini jika ada request maka requestListener akan dijalankan

```js
function(req, res){
  let body = "<pre>Haruskah belajar Node.js?</pre><p><h3>...Yo Mesto!</h3></p>"
  res.writeHead(200, {
    'Content-Length': body.length,
    'Content-Type': 'text/html',
    'Pesan-Header': 'Pengenalan Node.js'
  });

  res.write(body);
  res.end();
}
```

Paket http Node.js memberikan keleluasan bagi developer untuk membangun server tingkat rendah. Bahkan mudah saja kalau harus men-setting nilai field header dari HTTP.

Seperti pada contoh diatas agar respon dari request diperlakukan sebagai HTML oleh browser maka nilai field Content-Type harus berupa text/html. Setting ini bisa dilakukan melalui metode writeHead(), res.setHeader(field, value) dan beberapa metode lainnya.

Untuk membaca header bisa dipakai fungsi seperti res.getHeader(field, value) dan untuk menghapus field header tertentu dengan memakai fungsi res.removeHeader(field). Perlu diingat bahwa setting header dilakukan sebelum fungsi res.write() atau res.end() di jalankan karena jika res.write() dijalankan tetapi kemudian ada perubahan field header maka perubahan ini akan diabaikan.

Satu hal lagi yaitu tentang kode status dari respon HTTP. Kode status ini bisa disetting selain 200 (request http sukses), misalnya bila diperlukan halaman error dengan kode status 404.

## HTTP Request

Sebuah aplikasi web berkomunikasi dengan perangkat lunak client melalui HTTP. HTTP, sebagai protokol yang berbicara menggunakan request dan response menjadikan aplikasi web bergantung kepada siklus ini untuk menghasilkan dokumen yang ingin diakses oleh pengguna. Secara umum, aplikasi web yang akan kita kembangkan harus memiliki satu cara untuk membaca HTTP Request dan mengembalikan HTTP Response ke pengguna.

Pada pengembangan web tradisional, kita umumnya menggunakan sebuah web server seperti Apache HTTPD atau nginx sebagai penyalur konten statis seperti HTML, CSS, Javascript, maupun gambar. Untuk menambahkan aplikasi web kita kemudian menggunakan penghubung antar web server dengan program yang dikenal dengan nama CGI (Common Gateway Interface).

CGI diimplementasikan pada web server sebagai antarmuka penghubung antara web server dengan program yang akan menghasilkan konten secara dinamis. Program-program CGI biasanya dikembangkan dalam bentuk script, meskipun dapat saja dikembangkan dalam bahasa apapun. Contoh dari bahasa pemrograman dan program yang hidup di dalam CGI adalah PHP.

### Pembacaan Data dari HTTP Request

Data dikirimkan dalam HTTP Request dalam dua cara, tergantung dari method yang dikirimkan:

* Melalui URL, dengan parameter yang diberikan. Digunakan oleh GET.
* Melalui entity body dalam HTTP Request. Digunakan untuk POST dan PUT.

Pada prakteknya terdapat satu cara lagi untuk mengirimkan data, yaitu melalui cookie, tetapi penggunaan cookie tidak akan terlalu efektif karena cookie dirancang untuk menyimpan data status pengguna. Sekarang mari kita lihat bagaimana cara untuk membaca data pada URL maupun entity body.

#### Pembacaan Data pada URL

Pembacaan data yang dikirimkan melalui URL biasanya dilakukan untuk request dengan method GET. Untuk melihat bagaimana GET mengirimkan data, kita terlebih dahlu harus mengerti tentang sintaks penulisan URL. Secara umum, sebuah URL memiliki sintaks seperti berikut (detil ada pada RFC 1738):

```
<scheme>://<user>:<password>@<host>:<port>/<path>?<query>#<fragment>
```

Apa makna dari setiap bagian dari URL di atas? Mari lihat dari tabel di bawah.

Nama|Deskripsi|Harus ada?
----|---------|----------
scheme|Protokol yang digunakan.|Ya
user|Nama pengguna.|Tidak
password|Password untuk nama pengguna.|Tidak
host|Hostname atau IP.|Ya
port|Port yang akan diakses. Beberapa protokol memiliki port standar (misal: HTTP = 80).|Tergantung Protokol
path|Lokasi data pada server|Tergantung Protokol
query|Digunakan untuk mengirimkan parameter kepada aplikasi.|Tidak
fragment|Nama dari bagian tertentu pada data (mis: judul pada buku).|Tidak

Misalnya jika diterapkan pada browser:

```
https://bert:password123@contoh.com:8080/data/rahasia?id=scp-0682&access=O5#desc
```

Bagian utama yang akan kita gunakan untuk membaca data pada method GET yaitu bagian dari query. Sintaks pembuatan query sendiri cukup mudah, yaitu:

```
?nama-parameter:nilai&nama-parameter:nilai&...
```

Misalkan pada URL contoh di atas, terdapat dua buah data yang dikirimkan melalui URL, yaitu:

Param|Nilai
-----|-----
id|scp-0682
access|O5

Untuk pembacaan nilai query kita dapat menggunakan modul url yang telah diberikan oleh NodeJS. Modul ini memiliki tiga fungsi utama:

* `url.parse`, membaca sebuah string URL menjadi objek.
* `url.format`, kebalikan dari url.parse, mengubah objek URL menjadi string.
* `url.resolve`, melengkapi URL sesuai dengan cara browser pada tag a.

Fungsi yang akan kita gunakan untuk membaca nilai query yaitu `url.parse`, seperti berikut:

```js
let url     = require('url');
let url_obj = url.parse('http://user:pass@contoh.com:8080/pa/th?query=sample&data=123#desc', true);

console.log(url_obj);
/*
{
  protocol: 'http:',
  slashes: true,
  auth: 'user:pass',
  host: 'contoh.com:8080',
  port: '8080',
  hostname: 'contoh.com',
  hash: '#desc',
  search: '?query=sample&data=123',
  query: { query: 'sample', data: '123' },
  pathname: '/pa/th',
  path: '/pa/th?query=sample&data=123',
  href: 'http://user:pass@contoh.com:8080/pa/th?query=sample&data=123#desc'
}
*/
```

Seperti yang dapat dilihat pada keluaran objek di atas, property yang ingin kita akses adalah url_obj.query. Fungsi `url.parse` sendiri dapat menerima tiga buah argumen, yaitu:

* Argumen pertama, urlStr, diisikan string URL yang ingin diubah menjadi objek.
* Argumen kedua, parseQueryString, sebuah boolean yang digunakan untuk menentukan apakah query string akan diubah menjadi objek atau tidak. Jika tidak diisikan akan dianggap bernilai false.
* Argumen ketiga, slashesDenoteHost, jika diisikan dengan true akan membaca //foo/bar menjadi { host: 'foo', pathname: '/bar' } bukan nilai standar { pathname: '//foo/bar' }. Jika tidak diisi dianggap false.

Sehingga jika kita ingin melanjutkan kode di atas dengan mencoba langsung mengambil query kita dapat melakukan pemanggilan terhadap parameternya langsung:

```js
console.log(url_obj.query);
// { query: 'sample', data: '123' }
```

Dengan menggunakan fungsi url.parse, pembacaan nilai parameter pada GET akan menjadi sangat mudah dan sederhana. Kita juga dapat menggunakan property lain untuk berbagai keperluan. Tiga property yang paling menarik dan sering digunakan yaitu pathname (tempat penyimpanan data dalam server), query (query string), dan hash (bagian spesifik dari dokumen).

#### Pembacaan Data dalam Entity Body

Beberapa method lain di luar GET mengirimkan data melalui entity body dari sebuah HTTP Request. Untuk mengakses data yang dikirimkan dengan cara ini, kita dapat melakukan buffering data ke dalam sebuah string. Pada NodeJS, data ini dapat dibaca melalui event data di dalam objek http.IncomingMessage. Ketika seluruh data telah selesai dibaca, maka event end akan dieksekusi. Berikut adalah contoh kode untuk pembacaan data:

```js
let data = '';
request.on('data', function (chunck) {
  data = data + chucnk;
});

request.on('end', function () {
  // lakukan sesuatu terhadap variabel data
  // yang sudah lengkap
});
```

Dari kode di atas kita dapat melihat bagaimana mengambil data dari entity body cukup mudah. Untuk request seperti PUT yang biasanya dikirimkan dalam bentuk data langsung, misalnya:

```
PUT /data/1234 HTTP/1.1
[berbagai header]

<appointmentRequest>
  <patient id = "jsmith"/>
</appointmentRequest>
```

yang jika kita ambil datanya menggunakan metode di atas maka variabel data akan berisi string XML sesuai dengan yang dikirimkan. Kita kemudian dapat menggunakan fungsi atau objek khusus untuk memproses string XML tersebut sesuai kebutuhan. Cara pemrosesan ini berlaku juga untuk request POST yang dikirimkan oleh client HTTP, baik dari aplikasi desktop maupun handphone.

Untuk request POST yang dikirimkan melalui form HTML, pemrosesan harus dilakukan dengan cara yang sedikit berbeda. Pengiriman data pada form HTML dikirimkan dengan menggunakan dua format encoding, yaitu:

* `application/x-www-form-urlencoded`, untuk pengiriman data ukuran kecil yang tidak melibatkan file. Format encoding menggunakan cara yang sama dengan query pada method GET.
* `multipart/form-data`, untuk pengiriman data skala besar atau yang melibatkan file. Menggunakan format encoding khusus yang dijelaskan secara rinci dalam RFC 2045 dan RFC 1867. Pembacaan format dapat dilakukan sesuai spesifikasi pada RFC 2388.

Kedua format kode di atas dapat diproses dengan menggunakan beberapa modul yang sudah ada. Pembaca lebih disarankan menggunakan modul yang telah tersedia karena pembacaan format data sesuai dengan spesifikasi RFC merupakan hal yang cukup panjang untuk dilakukan dan dibahas pada tulisan ini. (Perlu dicatat bahwa kesulitan pembahasan terjadi karena panjangnya spesifikasi, bukan sulit atau kompleks).

Untuk `application/x-www-form-urlencoded`, format data sama persis dengan yang ada dalam GET. Kita dapat menggunakan modul querystring untuk mempermudah ktia dalam memproses data yang datang dengan format ini. Modul querystring memiliki dua buah fungsi utama, yaitu:

* `querystring.parse`, yang mengambil sebuah string query GET dan mengembalikan objek. Misalnya, querystring.parse('a=1&b=2') akan mengembalikan {a: 1, b: 2}.
* `querystring.stringify`, kebalikan dari parse. Mengambil objek dan menjadikannya string. Misalnya, querystring.stringify({a: 1}) akan mengembalikan a=1.

Mari kita lihat bagaimana kita dapat menggunakan querystring untuk membaca data pada entity body. Misalnya sebuah request:

```
POST /data/mahasiswa HTTP/1.1
[berbagai header]

nama=Budi+Hartono&semester=6&jurusan=Teknik+Informatika
```

dapat kita proses dengan kode berikut:

```js
let data = "";
request.on('data', function (chunck) {
  data += chunck;
});

request.on('end', function () {
  let mhs = qs.parse(data);
  console.log(mhs);
});
```

akan memberikan kita keluaran sebuah objek javascript seperti berikut:

```js
{
  nama: 'Budi Hartono',
  semester: '6',
  jurusan: 'Teknik Informatika',
}
```
Konten yang dikirimkan dengan format multipart/form-data sendiri memiliki cara penyimpanan yang sedikit rumit. Misalnya untuk data yang sama dengan request sebelumnya, tetapi menggunakan format ini, request akan menjadi:

```
POST /data/mahasiswa HTTP/1.1
[berbagai header]
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="nama"

Budi Hartono
----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="semester"

6
----WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="jurusan"

Teknik Informatika
----WebKitFormBoundary7MA4YWxkTrZu0gW
```

Karena format ini menggunakan penyimpanan yang cukup panjang (terutama jika melibatkan file), maka kita tidak dapat membaca data ini secara langsung. Kita dapat menggunakan berbagai pustaka yang sudah ada untuk melakukan pembacaan data ini, misalnya node-multiparty. Untuk menggunakan node-multiparty, kita dapat terlebih dahulu menambahkan pustaka dengan perintah:

```sh
$ npm install multiparty
```

dan kemudian dapat menggunakannya seperti berikut:

```js
let multiparty = require('multiparty');
let form       = new multiparty.Form();

form.parse(request, function (err, fields, files)) {
  console.log({'fields': fields, 'files': files});
});

```

yang jika dijalankan akan menghasilkan:

```js
{
  fields:
  {
    nama:     [ 'Budi Hartono' ],
    semester: [ '6' ],
    jurusan:  [ 'Teknik Informatika' ]
  },
  files: {}
}
```


Pembahasan mendetail tentang penggunaan node-multiparty dapat dibaca pada dokumentasi pustaka tersebut. Perlu diingat juga bahwa meskipun format application/x-www-form-urlencoded dan multipart/form-data hanya digunakan untuk HTML Form pada standar, banyak client yang mengirimkan request POST, PUT, dan bahkan DELETE dengan menggunakan kedua format ini tanpa melalui form. Jika aplikasi server yang dikembangkan memang mendukung penggunaan request ini, cara pemrosesan yang digunakan tetap sama (dengan pustaka seperti node-multiparty). Begitupun, tentu saja penggunaan seperti ini tidak disarankan, karena bertentangan dengan standar.

Sampai di sini kita telah melihat bagaimana HTTP Request disimpan oleh NodeJS, serta bagaimana membaca data yang dikirimkan oleh HTTP Request. Sebelum melihat bagaimana membuat HTTP Request secara dinamis, kita akan mempelajari tentang HTTP Response terlebih dahulu pada bagian berikutnya.

## HTTP Response

Di bagian sebelumnya kita telah melihat bagaimana membaca dan menangani HTTP Request dari server NodeJS. Sekarang kita akan melihat bagaimana membangun HTTP Response yang diberikan oleh server NodeJS. HTTP Response yang diberikan oleh server NodeJS merupakan objek bertipe http.ServerResponse, yang juga mengimplementasikan antarmuka stream.Writable (dokumentasi stream.Writable). Karenanya, penulisan HTTP Response akan menggunakan konsep penulisan stream yang sama dengan bahasa pemrograman pada umumnya.

Secara sederhana, untuk menuliskan data dengan stream.Writable, kita akan melakukan dua hal berurutan:

* Menulis stream dengan memanggil fungsi stream.Writable.write. Fungsi menerima dua parameter, yaitu string yang akan ditulis dan encoding dari string yang digunakan.
* Menutup stream dengan memanggil fungsi stream.Writable.end. Fungsi tidak menerima parameter.

Pada sebuah kode server sederhana, penulisan respon akan dilakukan seperti berikut:

```js
let http = require("http");
let port = process.env.port || 1337;

let server = http.createServer(function(request, response) {
  response.write("Hello World");
  response.end();
});

server.listen(port, 'localhost');
```

Sebagai tambahan untuk HTTP, http.ServerResponse memiliki beberapa fungsi-fungsi tambahan, yaitu (semua fungsi di bawah adalah untuk objek http.ServerResponse):

* `writeContinue`, memberikan pesan HTTP/1.1 100 Continue kepada client.
* `writeHead`, menuliskan header dari HTTP Response kepada client. Menerima tiga buah argumen, yaitu sebuah angka kode status, string deskripsi status, dan objek header. Contoh penggunaan dapat dilihat pada kode di bawah (setelah daftar fungsi).
* `setHeader`, mengisikan nilai sebuah header. Jika header telah dibuat dengan writeHead atau setHeader sebelumnya maka nilai akan ditimpakan. Menerima dua buah argumen, yaitu string nama header dan string nilai header.
getHeader, mengambil isi dari header (case insensitive) sebelum dikirimkan ke pengguna. Menerima satu parameter, yaitu string nama header.
* `removeHeader`, menghapus header yang telah dibuat sebelumnya.
addTrailers, menambahkan HTTP Trailing Header (header yang berada di belakang message) kepada HTTP Response. Fungsi ini memiliki dua prasyarat: hanya untuk pesan HTTP 1.1 dan pesan harus memiliki header Trailer. Jika kedua syarat tidak terpenuhi, fungsi akan diabaikan. Menerima parameter berupa objek dengan format seperti pada fungsi writeHead.

Penggunaan semua fungsi-fungsi yang dijelaskan di atas cukup gamblang. Misalnya, untuk writeHead:

```js
response.writeHead(200, 'OK', {
  'Content-Length': content.length,
  'Content-Type': 'text/plain'
});
```

Daftar dari HTTP Header sendiri dapat ditemukan pada berbagai sumber, misalnya: RFC 2616, Wikipedia, dan Lampiran C (masih dalam pengembangan).

Perlu diingat juga bahwa HTTP Header harus selalu ditulis sebelum entity body dituliskan, karena http.ServerResponse merupakan stream yang harus dituliskan secara berurutan. Hal ini berarti konstruksi header HTTP dapat dilakukan dengan cukup mudah, hanya dengan mengikuti urutan penulisan pesan, yaitu:

* Panggil writeHeader untuk menuliskan HTTP Response Starting Line dan Header.
* Panggil write untuk menuliskan entity body, jika diperlukan kita juga dapat mengirimkan konten file dari sini.
* Panggil end untk mengirimkan kepada pengguna.
Misalnya, kita dapat menggunakan modul fs untuk membaca file dan menuliskan kontennya seperti berikut:

```js
let fs = require('fs');
let file = fs.createReadStream('./index.html');
let content = '';

file.on('data', function (data) {
  content += data;
});

file.on('end', function () {
  result = content;

  response.writeHead(200, 'OK', {
    'Content-Type': 'text/html',
    'Content-Length': result.length
  });

  response.write(result);
  response.end();
});
```

Seperti yang dapat dilihat pada kode di atas, penulisan HTTP Response cukup gamblang dan sederhana. Selanjutnya, kita akan melihat pembuatan sebuah HTTP Client dengan NodeJS, yang akan memerlukan kebalikan dari server NodeJS, yaitu pembuatan HTTP Request secara dinamis dan pembacaan HTTP Response.

## HTTP Method

Pada bagian ini kita akan membahas method HTTP secara mendetail. Pada bagian Protokol HTTP kita telah melihat sedikit mengenai method HTTP, dengan tujuh buah method utama yang dispesifikasikan oleh HTTP sebagai berikut:

Method|Deskripsi|Body wajib?
------|---------|-----------
GET|Ambil dokumen dari server|Tidak
HEAD|Ambil header dokumen dari server|Tidak
POST|Kirimkan data ke server untuk diproses|Ya
PUT|Simpan data yang ada di bagian Body ke server|Ya
TRACE|Ikuti jejak pesan dari proxy server sampai ke server|Tidak
OPTIONS|Temukan method apa saja yang dapat dijalankan oleh server|Tidak
DELETE|Hapus data dari server|Tidak

Di bagian ini kita akan membahas secara mendalam cara kerja dan kegunaan dari masing-masing method. Ingat bahwa tidak semua method diimplementasikan oleh setiap server HTTP yang ada. Agar dapat memenuhi standar HTTP versi 1.1, sebuah server hanya cukup mengimplementasikan GET dan HEAD saja.

Bahkan untuk server yang mengimplementasikan seluruh method, biasanya akan terdapat batasan-batasan penggunaan. Misalnya, method DELETE dan PUT hanya bisa dijalankan oleh pengguna-pengguna tertentu yang telah terautentikasi dengan hak akses tertentu. Pada mayoritas kasus, kita tidak ingin pengguna dapat secara bebas menambahkan dan menghapus data pada server, karena hal tersebut merupakan lobang keamanan yang besar. Tentu saja batasan seperti ini berbeda-beda untuk setiap kasus, dan seringkali menjadi fitur konfigurasi untuk pengguna.

#### Safe and Idempotent Method

Sebuah method HTTP dikatakan safe (aman) jika method tersebut tidak mengubah data atau sumber daya yang ada pada server. Misalnya, GET dan HEAD merupakan method yang dianggap aman, yang berarti penggunaan GET maupun HEAD tidak akan mengubah representasi data atau memicu aksi tertentu pada server.

Maksud dari "tidak memicu aksi tertentu" di sini adalah server tidak melakukan apapun ketika request dikirimkan. Misalkan jika kita sedang mengunjungi situs belanja seperti Amazon atau Lazada, jika kita menekan tombol "Beli" maka biasanya browser akan mengirimkan request ke server untuk mengeksekusi pembelian, memasukkan data pembelian ke basis data, pembayaran kartu kredit, dan seterusnya. Pada kasus ini terjadi sebuah "aksi tertentu" yang mengubah representasi data (pengguna tidak membeli menjadi membeli). Bandingkan jika kita membuka sebuah halaman blog di mana server hanya akan mengambil dan mengembalikan data blog kepada kita.

Tentu saja perubahan akan data mungkin saja terjadi ketika kita melakukan pemanggilan request GET, misalnya server yang mencatat jumlah pembaca artikel blog. Yang paling penting ialah representasi data tidak berubah dan pengguna tidak meminta perubahan tersebut. Sebuah artikel blog tetap merupakan artikel blog setelah request, dengan isi yang tetap sama. Jumlah pembaca sedniri merupakan efek samping yang tidak diminta oleh pengguna, dan tidak merubah representasi, sehingga GET tetap dianggap aman. Hal ini berarti request seperti ini:

```
GET /blog/7777/delete HTTP/1.1
```

tidak tepat, karena pemanggilan request akan menghapus artikel yang dituliskan pada blog.

Karena representasi data akan selalu sama pada setiap kali pemanggilan method yang aman, maka method jenis ini akan sangat mudah disimpan dalam cache, tanpa efek samping yang berarti pada data.

Sebuah method HTTP dikatakan idempotent jika method tersebut dapat dipanggil sebanyak berapa kalipun tanpa mengubah keluaran. Tidak penting apakah method dipanggil satu kali atau ratusan kali, hasil eksekusi akan selalu sama. Sekali lagi, maksud "hasil" di sini adalah hasil dalam arti representasi dan jenis data, bukan *isi* dari data itu sendiri. Isi data tentu saja dapat berubah, dan jika data berubah pemanggilan method akan memberikan "hasil" yang berbeda, meskipun representasi dan maknanya sama. Misalkan sebuah artikel berita dapat diperbaharui isinya oleh penulis, tetapi pengambilan data melalui URL dan method yang sama akan tetap terus mengembalikan artikel berita dengan identitas yang sama - apapun isi berita tersebut.

Perhatikan kedua contoh berikut:

```js
a = 4; // 1
a++;   // 2
```

Pada contoh kode di atas, kode yang ditandai 1 merupakan kode yang idempoten, karena nilai a akan selalu 4 berapa kalipun kode dijalankan. Kode yang bertanda 2 tidak idempoten karena nilai a akan berubah terus menerus pada tiap eksekusi baris tersebut. Kedua kode tersebut juga bukan merupakan kode yang aman, karena keduanya mengubah nilai a.

Sifat idempoten ini sangat penting untuk mengembangkan aplikasi server yang fault-tolerant (tahan banting). Misalnya ketika pengguna ingin memperbaharui sebuah data melalui POST. Karena POST bukan merupakan method yang idempoten, pengiriman request yang sama beberapa kali akan dapat menghasilkan pembaruan data yang salah. Akan terdapat banyak hal yang harus kita pertimbangkan ketika ingin memperbaharui data dengan method yang tidak idempoten, misalnya:

> Apa yang terjadi ketika request dikirimkan dan server mengalami timeout (terlalu lama memproses data sehingga dibatalkan)?

> Jika timeout terjadi, apakah data benar-benar telah diperbaharui? Bagaimana kita melakukan verifikasi terhadap hal ini?

> Bagaimana kita mengetahui apakah timeout terjadi ketika request dikirimkan atau ketika response dikirimkan?

Jika timeout terjadi ketika request, apakah aman untuk mengirimkan request sekali lagi?

Dan masih banyak pertanyaan lainnya lagi. Dengan menggunakan method yang idempoten, kita tahu bahwa kita dapat mengirimkan request sekali algi dengan aman karena respon dan hasil eksekusi dijamin sama setiap kalinya.

Berikut adalah status dari sifat idempoten dan keamanan masing-masing method standar.

Method|Idempoten|Aman
---|---|---
GET|Ya|Ya
HEAD|Ya|Ya
POST|Tidak|Tidak
PUT|Ya|Tidak
TRACE|Ya|Ya
OPTIONS|Ya|Ya
DELETE|Ya|Tidak

### GET
GET merupakan method yang paling umum dan paling banyak digunakan. GET digunakan untuk meminta data tertentu dari server. HTTP/1.1 mewajibkan seluruh web server untuk mengimplementasikan method ini.

Contoh di bawah memperlihatkan request dan response dari sebuah pesan GET:

```
// request
GET /blog/to-be-or-not-to-be.html HTTP/1.1
Host: contoh.com
Accept: *

// response
HTTP/1.1 200 OK
Content-type: text/html
Content-length: 8372

<html>
<head><title>To be or Not to Be</title>
...
```

Pada contoh ini, response GET akan memberikan isi HTML kepada client, yang kemudian dapat ditampilkan kepada pengguna.

### HEAD

Method HEAD melakukan hal yang sama dengan GET, dengan perbedaan utama yaitu pada HEAD server hanya akan mengembalikan Header HTTP pada response saja. Tidak ada Entity Body yang dikembalikan oleh HEAD. Hal ini akan memungkinkan client untuk melakukan cek atau verifikasi header dari sebuah data tanpa harus mengambil data tersebut (yang tentunya akan menghemat bandwidth). Dengan menggunakan HEAD kita dapat:

Mengetahui informasi tentang data (tipe data, ukuran, dst) tanpa harus mengambi data secara langsung.

Mengetahui apakah data ada atau tidak dengan melihat kode status yang dikembalikan.

Melihat apakah data telah diubah, melalui pembacaan Header.

Pengembang aplikasi web pada sisi server atau pengembang web server harus memastikan data Header yang dikembalikan oleh GET dan HEAD sama persis. Dukungan terhadap method HEAD juga diwajibkan oleh spesifikasi HTTP/1.1. Contoh berikut memperlihatkan request dan response dari HEAD:

```
// request
HEAD /blog/to-be-or-not-to-be.html HTTP/1.1
Host: contoh.com
Accept: *

// response
HTTP/1.1 200 OK
Content-type: text/html
Content-length: 8372
```

Perhatikan bagaimana perbedaan antara HEAD dengan GET hanya bahwa response HEAD tidak memiliki isi HTML.

### PUT

Method PUT menuliskan data pada server, sebagai kebalikan dari GET yang membaca data dari server. Beberapa sistem publikasi atau manajemen konten memungkinkan kita untuk membuat sebuah halaman web baru pada web server dengan menggunakan PUT.

Cara kerja PUT sangat sederhana, yaitu server membaca isi Entity Body dari request dan menggunakan isi tersebut untuk membuat halaman baru pada URL yang diberikan request, atau jika URL telah ada maka isi data akan ditimpakan. Karena PUT menggantikan data yang ada pada server, kebanyakan server biasanya mewajibkan autentikasi sebelum melakukan PUT. Pembahasan mengenai autentikasi akan dilakukan pada bagian selanjutnya.

Berikut adalah contoh dari request dan response dari PUT:

```
// request
PUT /data/pengguna.txt HTTP/1.1
Host: contoh.com
Content-type: text/plain
Content-length: 300

Daftar pengguna baru!

// response
HTTP/1.1 201 Created
Location: http://contoh.com/data/pengguna.txt
Content-type: text/plain
Content-length: 300

http://contoh.com/data/pengguna.txt
```

Perhatikan bagaimana pada PUT server dapat langsung memberikan lokasi data penyimpanan, dan bagaimana lokasi tersebut sama dengan URL yang diberikan oleh client pada request.

### POST

POST digunakan untuk mengirimkan data masukan pengguna ke server. Pada prakteknya, POST biasanya digunakan untuk mengambil data yang dimasukkan dari form HTML. Data yang diisikan pada form biasanya dikirimkan kepada server, dan server kemudian menentukan ke mana data akan dikirimkan selanjutnya (misal: disimpan ke *database atau diproses oleh aplikasi lain).

Perbedaan utama dari POST dan PUT adalah bahwa POST digunakan untuk mengirimkan data ke server dan server bebas menentukan apa yang akan dilakukan terhadap data tersebut. PUT digunakan hanya untuk menyimpan data ke dalam server, dalam bentuk apapun (misal: file, database, dst).

### TRACE

Ketika client mengirimkan request ke server, request mungkin saja harus melewati banyak server lain seperti Firewall, Proxy, atau Gateway sebelum sampai ke server yang sebenarnya dituju. Setiap server yang dikunjungi sebelum request sampai ke server yang sebenarnya dapat saja memodifikasi request HTTP yang dikirimkan. Method TRACE memungkinkan client untuk melihat request paling akhir yang diterima oleh server tujuan.

Sebuah request TRACE akan memulai perputaran diagnostik pada server tujuan. Ketika menerima request TRACE, server tujuan akan mengembalikan sebuah respon berisi request terakhir yang diterima oleh server, sehingga client dapat melihat bagian mana dari request asli yang dikirimkan yang mengalami perubahan ketika sampai di server. Gambar berikut memperlihatkan contoh cara kerja sederhana dari TRACE.

#### Cara Kerja TRACE

TRACE digunakan terutama untuk diagnostik, misalnya untuk memastikan request yang dikirimkan sampai ke tujuan sesuai dengan keinginan. Hal ini terutama paling berguna karena terkadang server yang berada di tengah client dan server dapat mengubah request atau meneruskan request ke tempat yang tidak diinginkan (misalnya cache).

Meskipun merupakan alat diagnostik yang baik, TRACE memiliki satu kelemahan utama: TRACE mengasumsikan bahwa perangkat yang berada di antara client dan server memperlakukan semua request (GET, POST, PUT, dst) sama. Pada prakteknya, banyak aplikasi server di lapangan yang memperlakukan masing-masing request berbeda, misalnya membuka cache untuk GET dan meneruskan request tanpa perubahan untuk POST. TRACE tidak memiliki mekanisme untuk mendeteksi hal-hal seperti ini.

Hal lain yang perlu dicatat adalah bahwa sebuah request TRACE tidak boleh memiliki Entity Body. Entity Body pada response dari TRACE hanya boleh berisi request dengan sama persis.

### OPTIONS

OPTIONS bertanya kepada server untuk mengetahui kemampuan yang dimiliki oleh server. Kita dapat meminta informasi method yang didukung oleh server untuk data (URL) tertentu. Hal ini dilakukan untuk mengantisipasi beberapa server yang hanya memberikan dukungan terbatas terhadap beberapa URL atau objek tertentu.

Dengan begitu, OPTIONS memberikan cara bagi aplikasi client untuk menentukan cara terbaik mengakses berbagai data yang ada dalam server tanpa harus selalu mengakses data secara langsung. Berikut adalah contoh request dan response yang mungkin terjadi dengan menggunakan OPTIONS:

```
// request
OPTIONS * HTTP/1.1
Host: contoh.com
Accept: *

// response
HTTP/1.1 200 OK
Allow: GET, POST, PUT, OPTIONS
Context-length: 0
```

### DELETE

DELETE, seperti namanya, meminta server untuk menghapus data yang ada pada server, sesuai dengan URL yang diberikan oleh client. Begitupun, client tidak diberi jaminan bahwa penghapusan akan dijalankan ketika menggunakan DELETE. Hal ini terjadi karena standar HTTP memperbolehkan server untuk menolak atau mengabaikan permintaan DELETE dari client.

## HTTP Status Code

Bagian ini merupakan referensi dari kode status yang ada pada HTTP, beserta makna dari kode status tersebut.

### Klasifikasi Kode Status

Kode Status HTTP dibagi ke dalam 5 kategori besar, yaitu:

Keseluruhan Kode|Kode yang Terdefinisi|Kategori
--|--|--
100 - 199|100 - 101|Informasional
200 - 299|200 - 206|Sukses
300 - 399|300 - 305|Redirection
400 - 499|400 - 415|Kesalahan Client
500 - 599|500 - 505|Kesalahan Server

### Daftar Kode Status HTTP

Tabel di bawah menunjukkan seluruh kode status HTTP yang ada, sesuai dengan spesifikasi HTTP/1.1.

Kode Status | Frase Alasan     | Makna
------------|------------------|-----------------------------------------------
100|Continue|Bagian awal dari request telah diterima. Lanjutkan pemrosesan.
101|Switching Protocol|Server beralih menggunakan protokol yang berbeda, sesuai permintaan client pada header Upgrade.
200|OK|Request berjalan sukses
201|Created|Data berhasil dibuat (untuk request yang membuat objek baru).
202|Accepted|Request diterima, tetapi server tidak melakukan apa-apa.
203|Non-Authoritative Information|Transaksi berhasil, tetapi informasi pada header dari response tidak berasal dari server asli, tapi dari kopi data.
204|No Content|Response hanya berisi header dan status line, tanpa body.
205|Reset Content|Kode yang dirancang khusus untuk browser; meminta browser menghapus isi dari semua elemen form HTML pada halaman aktif.
206|Partial Content|Request parsial berhasil.
300|Multiple Choices|Client memberikan request URL yang merujuk ke beberapa data. Kode dikirimkan dengan beberapa pilihan yang dapat dipilih client 301 Moved Permanently URL dari request telah dipindahkan. Response wajib berisi lokasi URL baru.
302|Found|Sama seperti 301, tetapi perpindahan hanya untuk sementara. URL data sementara diberikan melalui header Location.
303|See Other|Response dari request ada pada halaman lain, yang harus diambil dengan GET. Jika request merupakan POST, PUT, atau DELETE, asumsikan server telah menerima data dan redirect dilakukan dengan GET yang baru.
304|Not Modified|Mengindikasikan tidak ada perubahan data dari request sebelumnya.
305|Use Proxy|Data harus diakses dari proxy. Lokasi proxy diberikan di header Location.
306|Switch Proxy|Kode status tidak lagi digunakan untuk sekarang.
307|Temporary Redirect|Request harus dilakukan kembali pada URI lain untuk sementara. Server dianggap tidak menerima data, sehingga jika request awal merupakan POST maka request baru juga harus POST.
400|Bad Request|Client memberikan request yang tidak lengkap atau salah.
401|Unauthorized|Akses ditolak. Header autentikasi akan dikirimkan.
402|Payment Required|Belum digunakan, tetapi disiapkan untuk penggunaan pada masa depan.
403|Forbidden|Request ditolak oleh server.
404|Not Found|URL yang diminta tidak ditemukan pada server.
405|Method Not Allowed|Method tidak didukung server. Header daftar method yang didukung untuk URL tersebut harus ada pada response.
406|Not Acceptable|Jika client memberikan daftar format yang dapat dibaca, kode ini menandakan server tidak dapat memberikan data dalam format itu.
407|Proxy Authentication Required|Seperti 401, tetapi autentikasi dilakukan terhadap proxy.
408|Request Timeout|Client terlalu lama dalam menyelesaikan request.
409|Conflict|Request menyebabkan konflik pada data yang diminta.
410|Gone|Seperti 404, tetapi server pernah memiliki data tersebut.
411|Length Required|Request harus memiliki headaer Content-Length.
412|Precondition Failed|Diberikan jika client membuat conditional request dan kondisi tidak terpenuhi.
413|Request Entity Too Large|Entity pada request terlalu besar.
414|Request URI Too Long|URI yang dikirimkan kepada server terlalu panjang.
415|Unsupported Media Type|Format data yang dikirimkan tidak didukung oleh server.
416|Request Range Not Satisfiable|Tidak dapat memenuhi cakupan data, untuk request yang menintanya.
417|Expectation Failed Server|tidak dapat memenuhi parameter Expectation yang ada pada request.
500|Internal Server|Error Server mengalami error ketika memproses request.
501|Not Implemented Client|membuat request yang di luar kemampuan server.
502|Bad Gateway|Server proxy atau gateway menemukan response yang aneh dari titik berikutnya pada rantai response.
503|Service Unavailable|Server untuk sementara tidak dapat memproses request.
504|Gateway Timeout|Sama dengan 408 tetapi dari gateway atau proxy, bukan client.
505|HTTP Version Not Supported|Versi protokol tidak didukung oleh server.

## Arsitektur REST

REST (REpresentational State Transfer) merupakan standar arsitektur komunikasi berbasis web yang sering diterapkan dalam pengembangan layanan berbasis web. Umumnya menggunakan HTTP (Hypertext Transfer Protocol) sebagai protocol untuk komunikasi data. REST pertama kali diperkenalkan oleh Roy Fielding pada tahun 2000.

Pada arsitektur REST, REST server menyediakan resources(sumber daya/data) dan REST client mengakses dan menampilkan resource tersebut untuk penggunaan selanjutnya. Setiap resource diidentifikasi oleh URIs (Universal Resource Identifiers) atau global ID. Resource tersebut direpresentasikan dalam bentuk format teks, JSON atau XML. Pada umumnya formatnya menggunakan JSON dan XML.

### Keuntungan REST

* bahasa dan platform agnostic
* lebih sederhana/simpel untuk dikembangkan ketimbang SOAP
* mudah dipelajari, tidak bergantung pada tools
* ringkas, tidak membutuhkan layer pertukaran pesan (messaging) tambahan
* secara desain dan filosofi lebih dekat dengan web

### Kelemahan REST

* Mengasumsi model point-to-point komunikasi - tidak dapat digunakan untuk lingkungan komputasi terdistribusi di mana pesan akan melalui satu atau lebih perantara
* Kurangnya dukungan standar untuk keamanan, kebijakan, keandalan pesan, dll, sehingga layanan yang mempunyai persyaratan lebih canggih lebih sulit untuk dikembangkan ("dipecahkan sendiri")
* Berkaitan dengan model transport HTTP

Berikut metode HTTP yang umum digunakan dalam arsitektur berbasis REST.

* GET, menyediakan hanya akses baca pada resource
* PUT, digunakan untuk menciptakan resource baru
* DELETE,digunakan untuk menghapus resource
* POST,digunakan untuk memperbarui resource yang ada atau membuat resource baru
* OPTIONS,digunakan untuk mendapatkan operasi yang disupport pada resource

Web service adalah standar yang digunakan untuk melakukan pertukaran data antar aplikasi atau sistem, karena aplikasi yang melakukan pertukaran data bisa ditulis dengan bahasa pemrograman yang berbeda atau berjalan pada platform yang berbeda. Contoh implementasi dari web service antara lain adalah SOAP dan REST.

Web service yang berbasis arsitektur REST kemudian dikenal sebagai RESTful web services. Layanan web ini menggunakan metode HTTP untuk menerapkan konsep arsitektur REST.

### Cara Kerja RESTful web services

Sebuah client mengirimkan sebuah data atau request melalui HTTP Request dan kemudian server merespon melaluiHTTP Response. Komponen dari http request:

* Verb, HTTP method yang digunakan misalnya GET, POST, DELETE, PUT dll.
* Uniform Resource Identifier  (URI) untuk mengidentifikasikan lokasi resource pada server.
* HTTP Version, menunjukkan versi dari HTTP yang digunakan, contoh HTTP v1.1.
* Request Header, berisi metadata untuk HTTP Request. Contoh, type client/browser, format yang didukung oleh client, format dari body pesan, seting cache dll.
* Request Body, konten dari data.

Sedangkan komponen dari http response:

* Status/Response Code, mengindikasikan status server terhadap resource yang direquest. misal : 404, artinya resource tidak ditemukan dan 200 response OK.
* HTTP Version, menunjukkan versi dari HTTP yang digunakan, contoh HTTP v1.1.
* Response Header, berisi metadata untuk HTTP Response. Contoh, type server, panjang content, tipe content, waktu response, dll
* Response Body, konten dari data yang diberikan.

## Format JSON

JSON — singkatan untuk Javascript Object Notation — adalah sebuah format untuk berbagi data. Seperti dapat kita lihat dari namanya, JSON diturunkan dari bahasa pemrograman javascript, akan tetapi format ini tersedia bagi banyak bahasa lain termasuk Python, Ruby, PHP, dan Java. JSON biasanya dilafalkan seperti nama "Jason."

JSON menggunakan ekstensi .json saat ia berdiri sendiri. Saat didefinisikan di dalam format file lain (seperti di dalam .html), ia dapat tampil didalam tanda petik sebagai JSON string, atau ia dapat dimasukkan kedalam sebuah variabel. Format ini sangat mudah untuk ditransfer antar server web dengan klien atau browser.

Karena sangat mudah dibaca dan ringan, JSON memberikan alternatif lebih baik dari XML adn membutuhkan formatting yang tidak banyak. Panduan ini akan membantu pembaca untuk memahami apa itu JSON, bagaimana menggunakan data di file JSON, serta struktur dan sintaks dari format ini.

### Sintaks dan Struktur

Sebuah objek JSON adalah format data key-value yang biasanya di render di dalam kurung kurawal. Saat kita bekerja dengan JSON, kita akan sering melihat objek JSON disimpan di dalam sebuah file .json, tapi mereka juga dapat disimpan sebagai objek JSON atau string di dalam sebuah program.

Sebuah objek JSON terlihat seperti berikut ini:

```js
{
  "first_name" : "Sammy",
  "last_name" : "Shark",
  "location" : "Ocean",
  "online" : true,
  "followers" : 987
}
```

Meskipun contoh di atas sangat singkat dan JSON dapat memiliki isi yang sangat banyak, contoh di atas secara umum menggambarkan dua kurung kurawal { } di awal dan di akhir dengan pasangan key-value diantara kedua tanda kurang. Sebagian besar data yang dipakai di JSON dienkapsulasi di dalam sebuah objek JSON.

Pasangan key-value memiliki tanda titik dua diantara mereka "key" : "value". Setiap key-value dipisahkan oleh sebuah koma, sehingga ditengah isi sebuah JSON terlihat seperti in: "key" : "value", "key" : "value", "key": "value". Pada contoh di atas, nilai pertama pasangan key-value kita adalah "first_name" : "Sammy".

Key JSON berada di sebelah kiri tanda titik dua. Mereka perlu dibungkus oleh tanda petik dua seperti ini: "key", dan dapat berupa string apapun yang valid. Di dalam setiap objek, key haruslah unik. Key ini dapat memiliki spasi seperti di "first name", namun menambahkannya akan membuat kita lebih repot saat akan mengaksesnya di proses ngoding sehingga disarankan untuk menggunakna underscore seperti pada "first_name".

Value JSON ada di sebelah kanan tanda titik dua. Ada enam tipe data dasar yang bisa dipakai untuk mengisinya yaitu:

* strings
* numbers
* objects
* arrays
* Booleans (true atau false)
* null

Secara lebih luas, value juga dapat berisi tipe data yang lebih kompleks misalnya JSON object atau JSON array yang akan kita bahas di bagian berikutnya.

Setiap tipe data yang dimasukkan sebagai valu ke dalam JSON akan mengingat sintaksnya, jadi string akan diberikan tanpa petik, namun tidak dengan angka.

Meskipun di dalam file .json kita sering melihat format ini ditulis dalam beberapa baris, JSON juga dapat ditulis disatu baris saja.

```json
{ "first_name" : "Sammy", "last_name": "Shark",  "online" : true, }
```

Menulis format JSON dalam bentuk beberapa baris akan membantunya lebih mudah dibaca terutama saat sudah memiliki banyak data. Karena JSON mengabaikan spasi antara elemennya, kita bisa memberikan spasi antara key-value sehingga menjadi lebih mudah di baca:

```json
{
  "first_name"  :  "Sammy",
  "last_name"   :  "Shark",
  "online"      :  true
}
```

Penting juga untuk diingat, meskipun terlihat sama sebuah objek JSON tidak memiliki format yang sama dengan objek Javascript. Jadi, meskipun kita bisa menambah fungsi kedalam objek Javascript, kita tidak bisa menggunakannya sebagai valus di JSON. Kelebihan utama JSON adalah kemudahan dan kesiapannya untuk ditransfer antar bahasa pemrograman. Objek Javascript hanya bisa digunakan di dalam bahasa pemrograman Javascript.

Sejauh ini kita sudah melihat format JSON dalam bentuk yang sederhana, namun JSON Juga dapat menjadi lebih kompleks yang terdiri dari objek dan array bersarang. Kita akan membahas JSON yang lebih kompleks di bagian berikutnya.
Bekerja dengan Data Kompleks di JSON

JSON dapat menyimpan objek bersarang maupun array bersarang. Seperti data lain, objek atau array ini dapat disimpan ke dalam sebuah key

### Object Bersarang

Di dalam file users.json berikut, untuk empat pengguna ("sammy", "jesse", "drew", "jamie") ada sebuah objek JSON didalam setiap value key keempatnya yang memiliki key-nya sendiri ("username" dan "location") milik setiap user.

`users.json`

```json
{
  "sammy" : {
    "username"  : "SammyShark",
    "location"  : "Indian Ocean",
    "online"    : true,
    "followers" : 987
  },
  "jesse" : {
    "username"  : "JesseOctopus",
    "location"  : "Pacific Ocean",
    "online"    : false,
    "followers" : 432
  },
  "drew" : {
    "username"  : "DrewSquid",
    "location"  : "Atlantic Ocean",
    "online"    : false,
    "followers" : 321
  },
  "jamie" : {
    "username"  : "JamieMantisShrimp",
    "location"  : "Pacific Ocean",
    "online"    : true,
    "followers" : 654
  }
}
```

Pada contoh di atas, tanda kurung kurawal digunakan untuk membuat objek JSON bersarang di mana setiap username dan location masing-masing menjadi miliki keempat user. Seperti data lainnya, koma dipakai untuk memisahkan antar elemen.

### Array Bersarang

Data dapat dimasukkan ke dalam format JSON menggunakan array Javascript sebagai sebuah value. Javascript menggunakan kurung siku [ ] di awal dan akhir sebuah array. Array adalah sebuah koleksi terurutdan memiliki tipe data yang berbeda.

Kita dapat menggunakan array saat bekerja dengan banyak data yang dapat dikelompokkan, seperti profil sosial media yang dimiliki oleh seorang user.

Setelah kita membahas tentang array bersarang, profil user untuk Sammy dapat terlihat sebagai berikut:

`user_profile.json`

```json
{
  "first_name" : "Sammy",
  "last_name" : "Shark",
  "location" : "Ocean",
  "websites" : [
    {
      "description" : "work",
      "URL" : "https://www.digitalocean.com/"
    },
    {
      "desciption" : "tutorials",
      "URL" : "https://www.digitalocean.com/community/tutorials"
    }
  ],
  "social_media" : [
    {
      "description" : "twitter",
      "link" : "https://twitter.com/digitalocean"
    },
    {
      "description" : "facebook",
      "link" : "https://www.facebook.com/DigitalOceanCloudHosting"
    },
    {
      "description" : "github",
      "link" : "https://github.com/digitalocean"
    }
  ]
}
```
Key "websites" dan "social_media" dapat menggunakan array untuk menyimpan data yang dimiliki oleh Sammy berupa 2 link website dan 3 profil sosial media. Kita tahu bahwa data tersebut array karena ada kurung sikunya.

Menggunakan data bersarang di dalam format JSON memungkinkan kita untuk bekerja pada data yang lebih kompleks.
Perbandingan dengan XML

XML, atau eXtensible Markup Language, adalah sebuah cara untuk menyimpan data yang dapat dibaca baik oleh manusia maupun mesin. Format XML tersedia secara luas bagi banyak bahasa pemrograman.

XML sangat mirip dengan JSON tapi membutuhkan lebih banyak teks sehingga lebih panjang isinya dan lebih lama untuk membaca dan menulisnya. XML harus dibaca dengan sebuah XML parser, namun JSON dapat dibaca menggunakan fungsi standar. Juga seperti JSON, XML tidak bisa menggunakan array.

Kita akan melihat contoh data yang disimpan ke dalam format XML dan JSON.

`users.xml`

```xml
<users>
  <user>
    <username>SammyShark</username>
    <location>Indian Ocean</location>
  </user>
  <user>
    <username>JesseOctopus</username>
    <location>Pacific Ocean</location>
  </user>
  <user>
    <username>DrewSquir</username>
    <location>Atlantic Ocean</location>
  </user>
  <user>
    <username>JamieMantisShrimp</username>
    <location>Pacific Ocean</location>
  </user>
</users>
```

`users.json`

```json
{
  "users": [
    {
      "username": "SammyShark",
      "location" : "Indian Ocean"
    },
    {
      "username": "JesseOctopus",
      "location" : "Pacific Ocean"
    },
    {
      "username": "DrewSquid",
      "location" : "Atlantic Ocean"
    },
    {
      "username": "JamieMantisShrimp",
      "location" : "Pacific Ocean"
    }
  ]
}
```

Kita dapat lihat bahwa JSON jauh lebih ringkas dan tidak memerlukan tag penutup seperti halnya XML. Sebagai tambahan, XML tidak menggunakan sebuah array seperti yang tadi kita pelajari.

Jika pembaca sudah mengenal HTML, pembaca akan melihat kemiripan dari penggunaan tag-nya. Meski JSON lebih singkat dan lebih mudah dari XML serta dapat dipakai di berbagai situasi termasuk aplikasi AJAX, kita perlu memahami tipe proyek yang sedang dikerjakan sebelum memutuskan struktur data apa yang akan digunakan.
