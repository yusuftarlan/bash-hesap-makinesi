# 🧮 Bash Calculator (BashHesapMakinesi)

Bash ile yazılmış, terminal üzerinde çalışan gelişmiş bir hesap makinesi uygulamasıdır. Temel aritmetik işlemlerden polinom grafik çizimine kadar birçok matematiksel işlemi destekler.

![Bash](https://img.shields.io/badge/Bash-5.0+-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)


---

## 📋 İçindekiler

- [Özellikler](#-özellikler)
- [Gereksinimler](#-gereksinimler)
- [Kurulum](#-kurulum)
- [Kullanım](#-kullanım)
- [Ekran Görüntüleri](#-ekran-görüntüleri)
- [Katkıda Bulunma](#-katkıda-bulunma)


---

## ✨ Özellikler

| # | Özellik | Açıklama |
|---|---------|----------|
| 1 | **Aritmetik İfade** | Kompleks matematiksel ifadeler hesaplama `(2+6)*7/8` |
| 2 | **Üs Alma** | Taban ve üs değerleri ile hesaplama `2^3 = 8` |
| 3 | **Karekök** | Sayıların karekökünü hesaplama `√16 = 4` |
| 4 | **Trigonometri** | Sinüs ve Kosinüs hesaplamaları `sin(x)`, `cos(x)` |
| 5 | **Polinom Hesaplama** | Polinom fonksiyonlarında değer hesaplama |
| 6 | **Polinom Grafik Çizimi** | Terminal üzerinde ASCII grafik çizimi |
| 7 | **Logaritma/Üstel** | Doğal logaritma `ln(x)` ve üstel fonksiyon `e^x` |
| 8 | **Faktöriyel** | Faktöriyel hesaplama `n!` |
| 9 | **Derece/Radyan Dönüşümü** | Açı birimlerini dönüştürme |
| 10 | **Mod Alma** | Kalan bulma işlemi `a % b` |
| 11 | **Taban Dönüşümü** | Binary, Octal, Decimal, Hexadecimal arası dönüşüm |
| 12 | **Permütasyon/Kombinasyon** | `P(n,r)` ve `C(n,r)` hesaplamaları |
| 13 | **Ortalama Hesaplama** | İstatistiksel ortalama hesaplama |
| 14 | **Log Görüntüleme** | Tüm işlem geçmişini görüntüleme |

### 🎯 Ek Özellikler

- ✅ **İşlem Geçmişi Kaydı**: Tüm hesaplamalar `log.txt` dosyasına tarih/saat damgası ile kaydedilir
- ✅ **Son 3 İşlem Görüntüleme**: Program başlangıcında son işlemler gösterilir
- ✅ **Kullanıcı Dostu Arayüz**: ASCII art banner ve düzenli menü yapısı
- ✅ **Hata Kontrolü**: Geçersiz girişler için uyarı mesajları

---

## 📦 Gereksinimler

- **Bash** (5.0 veya üzeri önerilir)
- **bc** (Basic Calculator - Hassas matematiksel hesaplamalar için)

`bc` kurulu değilse:

```bash
# Debian/Ubuntu
sudo apt-get install bc

# Fedora/RHEL
sudo dnf install bc

# Arch Linux
sudo pacman -S bc

# macOS (Homebrew)
brew install bc
```

---

## 🚀 Kurulum

1. **Repository'yi klonlayın:**
   ```bash
   git clone https://github.com/<kullanici-adi>/BashHesapMakinesi.git
   cd BashHesapMakinesi
   ```

2. **Çalıştırma izni verin:**
   ```bash
   chmod +x main.sh
   ```

3. **Programı başlatın:**
   ```bash
   ./main.sh
   ```

---

## 📖 Kullanım

### Ana Menü

Program başladığında aşağıdaki menü ile karşılaşırsınız:

```
      ____            _        _____      _            _       _             
     |  _ \          | |      / ____|    | |          | |     | |            
     | |_) | __ _ ___| |__   | |     __ _| | ___ _   _| | __ _| |_ ___  _ __ 
     |  _ < / _` / __| '_ \  | |    / _` | |/ __| | | | |/ _` | __/ _ \| '__|
     | |_) | (_| \__ \ | | | | |___| (_| | | (__| |_| | | (_| | || (_) | |   
     |____/ \__,_|___/_| |_|  \_____\__,_|_|\___|\__,_|_|\__,_|\__\___/|_|   

------ Hesap Makine Menüsü ------
1) Aritmetik İfade
2) Üs Alma
3) Karakök
...
0) Çıkış
```

### Örnek Kullanımlar

#### 🔢 Aritmetik İfade
```
İfade girin (çıkış: q): (5+3)*2-10/5
Sonuç: 14
```

#### 📐 Polinom Hesaplama
```
Polinom katsayılarını girin: 1 -2 3
P(x) = 1x^2 + -2x + 3
x degeri: 2
f(2) = 3
```

#### 📊 Polinom Grafik Çizimi
```
Katsayılar: 1 0 -4
Aralık: -3 3

    x | y ekseni (*)
______|_____________________
   -3 |          *
   -2 |    *
   -1 |        *
    0 |      *
    1 |        *
    2 |    *
    3 |          *
```

#### 🔄 Taban Dönüşümü
```
Giriş Tabanı: 10
Hedef Tabanı: 2
Sayı: 255
Sonuç: (255) base-10 ==> (11111111) base-2
```

### ⌨️ Kısayollar

| Tuş | İşlev |
|-----|-------|
| `q` veya `Q` | Alt menüden çıkış / Ana menüye dönüş |
| `b` veya `B` | Ortalama hesaplamada sonucu göster |
| `0` | Programdan çıkış |

---

## 📸 Ekran Görüntüleri

```
--- SON 3 İŞLEM GEÇMİŞİ ---
2026-01-02 14:30:45 -> Aritmetik: 5+3 = 8
2026-01-02 14:31:02 -> Karekök: sqrt(16) = 4
2026-01-02 14:31:15 -> Faktöriyel: 5! = 120
--------------------------
```

---

## 📁 Proje Yapısı

```
BashHesapMakinesi/
├── main.sh        # Ana uygulama dosyası
├── log.txt        # İşlem geçmişi (otomatik oluşturulur)
└── README.md      # Bu dosya
```

---

## 🤝 Katkıda Bulunma

1. Bu repository'yi fork edin
2. Yeni bir branch oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeni-ozellik`)
5. Pull Request açın

### 💡 Önerilen İyileştirmeler

- [ ] Tanjant ve kotanjant fonksiyonları ekleme
- [ ] Matris işlemleri
- [ ] Denklem çözücü
- [ ] Renklendirme (ANSI color codes)
- [ ] Konfigürasyon dosyası desteği

---



---

## 👨‍💻 Yazar

**Yusuf**

- GitHub: [@yusuf](https://github.com/yusuf)

---

<p align="center">
  ⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!
</p>
