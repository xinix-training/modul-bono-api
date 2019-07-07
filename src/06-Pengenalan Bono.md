# Pengenalan Bono

Bono adalah sebuah kerangka kerja (framework) untuk membangun aplikasi web
berbasis Node.js yang bersifat modular dan ringan.

## Instalasi

Instalasi bono dilakukan dengan menggunakan NPM dengan skup instalasi pada project.

```sh
mkdir my-project
cd my-project
npm init
npm i bono --save
```

Tulislah kode berikut ini pada sebuah file yang bernama `app.js`

```js
const http = require('http');
const Bundle = require('bono');

let app = new Bundle();

app.get('/', ctx => 'Hello world!');

let server = http.Server(app.callback());
server.listen(3000, () => console.log('Listening on port 3000'));
```

Kemudian untuk menjalankan anda dapat menggunakan `node`, atau dalam fase
pengembangan anda dapat menggunakan `nodemon` (https://www.npmjs.com/package/nodemon).

```sh
node app.js
```

Jika menggunakan nodemon,

```sh
nodemon app.js
```

Sekarang aplikasi anda hidup di port 3000, dan anda dapat mengaksesnya melalui
http://localhost:3000 dari mesin lokal anda.

Saat ini aplikasi anda hanya memiliki satu buah route. Anda akan belajar
menggunakan bundle, middleware dan route sesaat lagi.

## Bundle

Bundle adalah sebuah konteks modul dari aplikasi anda yang dapat memiliki
middleware, route dan sub-sub bundle. Aplikasi itu sendiri adalah sebuah bundle.

Bundle adalah mekanisme untuk memisahkan urusan modul-modul yang berbeda. Anda dapat membuat bundel aplikasi yang mendelegasikan membedah setiap konteks permintaan untuk memisahkan sub bundel.

Anda dapat mengaitkan bundel apa pun sebagai sub bundel aplikasi yang lebih besar, artinya pemrogram dapat mendistribusikan bundel umum untuk digunakan oleh jenis aplikasi lain, dan menggunakan kembali bundel yang telah Anda tulis untuk proyek sebelumnya sebagai sub bundel proyek saat ini.

Bundel pada dasarnya adalah aplikasi Koa.js, jadi setiap metode dan properti yang dimiliki aplikasi Koa.js, Anda dapat menggunakannya dalam bundel.

```js
const http = require('http');
const Bundle = require('bono');

const auth = new Bundle();
auth.post('/login', async ctx => {
  let { username, password } = await ctx.parse();

  ctx.assert(username === 'foo' && password === 'bar', 401, 'Login failed!');
});

const app = new Bundle();
app.get('/', ctx => ctx.redirect('/auth/login'));
app.bundle('/auth', auth);

let server = http.Server(app.callback());
server.listen(3000, () => console.log('Listening on port 3000'));
```

### Extend Bundle

Anda dapat menyiapkan bundel generik untuk digunakan kembali dalam proyek Anda. Bundel ini dapat dikemas dalam paket terpisah juga.

Tulis kode di bawah ini dalam file `auth.js`.

```js
const Bundle = require('bono');

class AuthBundle extends Bundle {
  constructor () {
    super();

    this.post('/login', async ctx => {
      let { username, password } = await ctx.parse();

      ctx.assert(username === 'foo' && password === 'bar', 401, 'Login failed!');

      // append server side data

      return 'login success';
    });

    this.get('/logout', ctx => {
      // remove server side data

      return 'logout success';
    });
  }
}
```

Kemudian gunakan bundel tersebut dalam aplikasi.

```js
const http = require('http');
const Bundle = require('bono');
const AuthBundle = require('./auth');

const app = new Bundle();

app.bundle(new AuthBundle());

let server = http.Server(app.callback());
server.listen(3000, () => console.log('Listening on port 3000'));
```

## Middlewares

Bono middleware pada dasarnya adalah middleware Koa.js murni.

Middleware mengalir dengan cara yang lebih natural karena Anda mungkin terbiasa dengan alat serupa. Lain dengan implementasi middleware pada framework Connect yang hanya melewati kontrol melalui serangkaian fungsi sampai satu kembali, Koa menghasilkan "downstream", kemudian kontrol mengalir kembali "upstream".

Definisi Middleware mengambil struktur berikut:

```js
bundle.use(MIDDLEWARE)
```

Dimana, bundle adalah instance dari Bono bundle dan MIDDLEWARE adalah fungsi dengan argumen sebagai konteks permintaan Koa.js dan fungsi middleware berikutnya. MIDDLEWARE dapat berupa fungsi async.

```js
const http = require('http');
const Bundle = require('bono');

const app = new Bundle();

app.use(async (ctx, next) => {
  console.log('before route');

  await next();

  console.log('after route');
});

app.get('/', ctx => {
  console.log('route running');
  return 'Hello world!';
});

let server = http.Server(app.callback());
server.listen(3000, () => console.log('Listening on port 3000'));
```

Jalankan server dan buka URL http: // localhost: 3000 / dan Anda akan melihat `Hello world!`. Dalam log server, Anda dapat melihat,

```sh
$ node app.js
Listening on port 3000
before route
route running
after route
```

### Built-in Middlewares

Bono menyediakan middleware bawaan sebagai berikut:

#### JSON Middleware

```js
bundle.use(require('bono/middlewares/json')());
```

#### Logger Middleware

```js
bundle.use(require('bono/middlewares/logger')());
```

#### Not Found Middleware

```js
bundle.use(require('bono/middlewares/not-found')('404 Not Found'));
```

## Routing

Routing mengacu pada menentukan bagaimana suatu aplikasi merespons permintaan klien ke titik akhir tertentu, yang merupakan URI (atau jalur) dan metode permintaan HTTP khusus (GET, POST, dan sebagainya).

Setiap rute dapat memiliki satu atau lebih fungsi penangan, yang dieksekusi ketika rute tersebut cocok.

Definisi rute mengambil struktur berikut:

```js
bundle.METHOD(PATH, HANDLER)
```

Dimana, Bundel adalah turunan dari bundel Bono.

* `METODE` adalah metode permintaan HTTP, dalam huruf kecil.
* `PATH` adalah jalur di server.
* `HANDLER` adalah fungsi yang dijalankan saat rute dicocokkan.

`HANDLER` menerima konteks permintaan Koa.js sebagai argumen. `HANDLER` dapat berupa fungsi async.

## Context

Konteks Bono adalah konteks Koa.js dengan penambahan dalam API sebagai berikut:

* `ctx.parse()` - async method to parse request body
* `ctx.parameters` - object contains parameters from url

## CRUD

CRUD (Create, Read, Update, Delete) adalah sebuah mekanisme umum pengelolaan
data dimana aplikasi menyediakan fungsi-fungsi sebagai berikut:

* Create, membuat data baru
* Read, membaca data yang telah disimpan di dalam sistem
* Update, mengubah data yang telah tersimpan di dalam sistem
* Delete, menghapus data yang telah tersimpan di dalam sistem

Berikut ini adalah cara menggunakan pustaka `node-bono-norm` untuk membangun API server berbasis REST JSON.

```js
const Bundle = require('bono');
const NormBundle = require('bono-norm/bundle');
const config = {
  connections: [
    {
      name: 'default',
      adapter: require('node-norm/adapters/disk'),
    },
  ],
};

// create app bundle
const app = new Bundle();

// add middleware to use bono manager from bundle
app.use(require('bono-norm')(config));

// add json middleware to return data from bundle as json body
app.use(require('bono/middlewares/json')());

// add bundle with collection schema name
app.bundle('/user', new NormBundle({ schema: 'user' }));
```
