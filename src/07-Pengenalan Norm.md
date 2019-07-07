# Pengenalan Norm

Norm adalah lapisan tengah untuk mengakses sumber data baik berbentuk
database, file, nosql, dan lain sebagainya.

Norm memiliki fitur-fitur sebagai berikut:

* Adaptive persistency, anda dapat secara mudah memperluas dukungan terhadap
sumber data dengan membuat adapter baru,
* Menggunakan banyak koneksi dalam satu aplikasi,
* Menggunakan pendekatan NoSQL,

## Penggunaan

Untuk melakukan instalasi pada project yang sudah tersedia dilakukan dengan
pustaka melalui npm sebagai berikut,

```sh
npm i node-norm
```

Berikut di bawah ini adalah cara penggunaannya,

```js
const { Manager } = require('node-norm');
const manager = new Manager({
  connections: [
    {
      name: 'default',
      adapter: require('node-norm/adapters/disk'), // change with constructor of adapter
      schemas: [
        {
          name: 'friend',
        }
      ],
    },
  ],
});

manager.runSession(async session => {
  let friend = { first_name: 'John', last_name: 'Doe' };

  await session.factory('friend').insert(friend).save();

  console.log('Great, we have new friend');

  let theFriend = await session.factory('friend').single();

  console.log(`We have friend, hello ${theFriend.first_name}!`)
});
```

Anda dapat mengganti adapter untuk mengakses jenis sumber data berbeda, contohnya untuk mengakses sumber data yang berupa database mysql anda dapat menggunakan `node-norm-mysql` sebagai adapternya.

```js
const { Manager } = require('node-norm');
const manager = new Manager({
  connections: [
    {
      name: 'default',
      adapter: require('node-norm-mysql'),
      host: 'localhost',
      user: 'root',
      password: 'secret',
      database: 'foo',
      schemas: [
        {
          name: 'bar',
        }
      ],
    },
  ],
});

```

## Schema

Skema adalah mekanisme opsional untuk menentukan tipe data bidang, filter / validasi, atau perilaku yang dapat diamati.

Skema didefinisikan sebagai bagian dari opsi koneksi untuk setiap skema koleksi data. Anda dapat melihat koleksi sebagai tabel di dunia DBMS.

Schema mendefinisikan nama, field-field, dan observer-observer yang dimiliki oleh skema tersebut.

### Cara Penggunaan

```js
const manager = new Manager({
  connections: [
    // this is one of connection option
    {
      adapter: //...
      schemas: [
        // this is collection schema
        {
          name: 'cute_collection',
          fields: [
            // field schemas
          ],
          observers: [
            // observers
          ],
        }
      ],
    }
  ]
});
```

## Field

Pendefinisian field adalah opsional. Anda membutuhkan skema hanya jika anda
ingin memaksa field untuk berlaku sebagai sebuah tipe data yang spesifik atau
mengimplementasikan filter/validasi.

Setiap field di-extend dari kelas `NField`.

```js
const NField = require('node-norm/schemas/nfield');
```

Beberapa field bawaan adalah sebagai berikut:

* `NBoolean`
* `NDateTime`
* `NDouble`
* `NInteger`
* `NList`
* `NMap`
* `NReference`
* `NString`

## Filter

Filter melakukan preproses terhadap sebuah record sebelum record tersebut dimasukkan ke dalam sistem pada saat menambahkan atau mengubah datanya. Pre proses tersebut antara lain berfungsi sebagai validasi data, memperkaya data, atau membersihkan data.


```js
new NString('fieldName').filter(
  'required',
  ['default', '1'],
);
```

Berikut ini adalah beberapa filter bawaan:

* are
* default
* email
* enum
* exists
* notEmpty
* required
* requiredIf
* unique

## Observer

Anda dapat memasang observer untuk melakukan prosedur tambahan pada saat terjadinya penambahan record maupun pengubahan record. Perilaku observer mirip dengan perilaku trigger pada sistem basis data relasional (RDBMS). Perbedaannya dengan sistem trigger adalah, anda dapat mendefinisikan prosedur sebelum terjadinya aktivitas (insert maupun update) dan/atau sesudah terjadinya aktivitas tersebut.

Observer memiliki metode-metode sebagai berikut,

* `async #insert ({ query }, next)`
* `async #update ({ query }, next)`

Berikut ini adalah contoh membuat observer

```js
class SomeObserver {
  async insert ({ query }, next) {
    // do something here before inserting data

    await next();

    // do something here after data inserted
  }

  async update ({ query }, next) {
    // do something here before updating data

    await next();

    // do something here after data updated
  }
}
```
