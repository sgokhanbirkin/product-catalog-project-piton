Ürün Kataloğu Projesi, ürünleri gözden geçirme, kategorileri yönetme ve ürün detaylarını görüntüleme için geliştirilmiş bir Flutter tabanlı uygulamadır. Kullanıcı kimlik doğrulaması, dil lokalizasyonu ve ürün listeleme gibi işlevsellikler sunan modern ve temiz bir arayüz sağlar.

Özellikler
	•	Kullanıcı Kimlik Doğrulama: Kullanıcılar giriş yapabilir ve kişiselleştirilmiş özelliklere erişebilir.
	•	Ürün Listeleme: Kategorilere göre ürünleri gezebilir ve ürünler arayabilirsiniz.
	•	Lokalizasyon: Birden fazla dil desteği (şu an için Türkçe ve İngilizce).
	•	Splash Ekranı: Kimlik doğrulama token’ı kontrol edilip yönlendirme yapılır.
	•	Kategori Yönetimi: Ürünler kategorilere ayrılır ve kategoriye göre filtrelenebilir.



Teknolojik Yığın (Tech Stack)
	•	Flutter: Çapraz platform mobil uygulama geliştirme.
	•	Riverpod: Durum yönetimi.
	•	Hive: Ürün ve kategori verilerini yerel olarak saklamak için.
	•	Easy Localization: Dil çevirisi ve lokalizasyon.
	•	Dio: HTTP istekleri.
	•	AutoRoute: Yönlendirme yönetimi.

Başlarken

Projeyi yerel olarak çalıştırmak için aşağıdaki adımları izleyin:

Gereksinimler
	1.	Flutter SDK: Flutter’ı kurduğunuzdan emin olun. Kurulum için bu kılavuzu takip edebilirsiniz.
	2.	Dart: Dart, Flutter ile birlikte gelir, ancak en son sürümünü kullandığınızdan emin olun.
	3.	Xcode: iOS üzerinde geliştirme yapmak için (macOS için).
	4.	Android Studio: Android üzerinde geliştirme yapmak için.


  Kurulum

Projenin çalışabilmesi için aşağıdaki adımları izleyebilirsiniz:
	1.	Flutter SDK’yı indirip yükleyin: Flutter SDK
	2.	Bağımlılıkları yüklemek için proje dizininde terminal açın ve aşağıdaki komutu çalıştırın:

 flutter pub get
 
 flutter run

 Proje kök dizininde bir .env dosyası oluşturun. Bu dosya, backend API bağlantısı gibi hassas bilgileri saklamak için kullanılacaktır.

 # API URL

API_BASE_URL=https://example.com/api

Ekran Görüntüleri


https://github.com/user-attachments/assets/70cb55ca-bb79-43cd-90a3-795f5a7d2cce



![simulator_screenshot_4A8AABDA-244B-461E-BA71-7D385F117E8B](https://github.com/user-attachments/assets/54297ef3-2891-48d8-977a-4f6dc7661e69)
![simulator_screenshot_6EA60DF8-4756-4F2E-B253-5C2A7740F3E6](https://github.com/user-attachments/assets/bdaaf069-ca65-486b-8bad-fb8572981560)
 ![simulator_screenshot_DEC0F5E8-26F4-4325-98F2-C62301076195](https://github.com/user-attachments/assets/482ab578-7989-44b4-829b-7feea906c912)
![simulator_screenshot_29B24358-9977-4E71-AFE2-8420998885BC](https://github.com/user-attachments/assets/1e1f3021-8440-4235-9f4f-986dbca0fb42)
 ![simulator_screenshot_BD9EF0FB-7E24-46D2-811D-ED54CF3CD392](https://github.com/user-attachments/assets/73e8271a-a934-4ce1-93c9-7f801e0ef7df)
