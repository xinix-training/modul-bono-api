# Kebutuhan Dasar

Untuk melakukan pemrograman web dengan menggunakan Node.js maka dibutuhkan
instalasi beberapa piranti lunak. Piranti lunak yang dipasang dibagi menjadi dua
macam, yaitu platform sistem dan platform pengembangan.

## Platform Sistem

Platform sistem adalah platform utama yang dibutuhkan untuk mengembangkan dan
nantinya untuk menjalankan aplikasi yang anda bangun di server.

### Node.js

Node.js dapat diunduh melalui halaman website resminya di https://nodejs.org.
Untuk mengembangkan aplikasi yang membutuhkan stabilitas tinggi maka disarankan
untuk mengunduh paket instalasi LTS (Long Term Support), namun jika anda ingin
menggunakan fitur-fitur terbaru dari Node.js, anda dapat mengunduh paket
instalasi terbaru.

Piranti lunak NPM (Node Package Manager) akan dipasang bersamaan dengan Node.js,
NPM nantinya berfungsi untuk melakukan instalasi pustaka-pustaka pihak ketiga
yang dapat digunakan dalam pengembangan aplikasi anda.

## Platform Pengembangan

Platform pengembangan adalah platform yang direkomendasikan untuk dipasang untuk
membantu proses pengembangan lebih baik.

### Git

Git berfungsi untuk melakukan manajemen source code. Git digunakan untuk
mengunduh source code pelatihan dari server. Instalasi git dapat dilakukan
dengan mengunjungi website https://git-scm.com/.

### Visual Studio Code

Visual Studio Code adalah sebuah text editor yang handal untuk pengembangan
piranti lunak. Anda dapat mengunduh paket instalasinya melalui https://code.visualstudio.com/.

Selain Visual Studio Code, anda juga dapat menggunakan text
editor pilihan anda sendiri, seperti Sublime Text, TextEdit, Notepad, dan
lain sebagainya.

### Postman

Postman adalah sebuah aplikasi klien untuk melakukan pengetesan web service. Untuk mengunduh paket instalasi dapat melalui https://www.getpostman.com/.

### Editorconfig

Editorconfig digunakan untuk membantu penyeragaman penulisan pada source code
pada aplikasi yang anda dan tim kembangkan bersama sehingga mengurangi
kemungkinan terjadinya konflik karena perbedaan lingkungan sistem pengembangan,
misalnya antara sistem operasi Windows dengan Linux.

Editorconfig dipasang sebagai ekstensi dari Visual Studio Code.

### Eslint

Eslint digunakan untuk melakukan pengecekan dan penyeragaman gaya pemrograman
di lingkungan Javascript. Tujuan penggunaannya adalah agar pemrograman dapat
dilakukan lebih efisien dan menghasilkan source code yang memiliki standar yang
sama di antara pemrogram-pemrogram yang berbeda dalam satu tim yang sama.

Eslint dipasang melalui npm. Eslint dapat dipasang secara global maupun
dipasang untuk masing-masing proyek. Berikut ini adalah cara instalasi eslint
secara global.

```sh
npm i eslint -g
```

Disarankan lebih lanjut untuk memasang ekstensi Visual Studio Code agar text
editor mampu mengenali eslint dan menampilkan hasilnya secara terintegrasi di
layar anda.
