#!/bin/bash

log_yaz() {
    local islem_detayi=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') -> $islem_detayi" >> log.txt
}

son_islem_getir() {
    if [[ -f log.txt ]]; then
        echo -e "\n--- SON 3 İŞLEM GEÇMİŞİ ---"
        tail -n 3 log.txt
        echo "--------------------------"
    else
        echo -e "\n(Henüz işlem geçmişi bulunmuyor.)"
    fi
}

aritmetik_ifade() {
    while true; do
        read -p "İfade girin (çıkış: q): " a
        if [[ "$a" == "q" || "$a" == "Q" ]]; then
            clear
            break
        fi
        sonuc=$(echo "scale=5; $a" | bc -l)
        echo "$sonuc"
        log_yaz "Aritmetik: $a = $sonuc"
    done
}

us_al() {
    while true; do
        read -p "taban & üs (çıkış: q): " a b
        if [[ "$a" == "q" || "$a" == "Q" ]]; then
            clear
            break
        fi
        sonuc=$(echo "scale=5; $a^$b" | bc -l)
        echo "$sonuc"
        log_yaz "Üs Alma: $a^$b = $sonuc"
    done
}

karakok() {
    while true; do
        read -p "Sayi (çıkış: q): " a 
        if [[ "$a" == "q" || "$a" == "Q" ]]; then
            clear
            break
        fi
        sonuc=$(echo "scale=5; sqrt($a)" | bc -l)
        echo "$sonuc"
        log_yaz "Karekök: sqrt($a) = $sonuc"
    done
}

trigonometri() {
    while true; do
        read -p "sin/cos x (örn: sin 0.5) (çıkış: q): " a b
        if [[ "$a" == "q" || "$a" == "Q" ]]; then
            clear
            break
        elif [[ "$a" == "sin" || "$a" == "SIN" ]]; then
            sonuc=$(echo "scale=5; s($b)" | bc -l)
            echo "$sonuc"
            log_yaz "Trigonometri: sin($b) = $sonuc"
        elif [[ "$a" == "cos" || "$a" == "COS" ]]; then
            sonuc=$(echo "scale=5; c($b)" | bc -l)
            echo "$sonuc"
            log_yaz "Trigonometri: cos($b) = $sonuc"
        else
            echo "Geçersiz (sadece sin/cos desteklenir)"
        fi  
    done
}

polinomYapisi(){
    numParam=$#
    params=("$@")
    ifade=""
    x=0
    for (( i=$(($#-1)); i>-1; i-- )) do
        if (( i == 0 )); then
            ifade+="${params[$x]}"
        elif ((i == 1)); then
            ifade+="${params[$x]}x + "
        else
            ifade+="${params[$x]}x^$i + "
        fi
        ((x+=1))
    done
    echo "P(x) = $ifade"
}

degerHesapla(){
    numParam=$#
    params=("$@")
    sonuc=0
    j=$((numParam-1))

    read -p "x degeri (çıkış: q): " x
    if [[ "$x" == "q" || "$x" == "Q" ]]; then
            clear
            return 1
    fi
    
    for (( i=0; i < $numParam; i++ )); do
        (( sonuc += params[j] * x**i ))
        ((j-=1))
    done
    
    echo "--------------"
    echo "| f($x) = $sonuc |"
    echo "--------------"
    log_yaz "Polinom Hesap: f($x) = $sonuc"
}

paraDegerHesapla(){
    x=${1}
    shift
    params=("$@")

    numParam=${#params[@]}
    ifade=""
    for (( i=0; i<numParam; i++ )); do
        j=$((numParam - 1 - i)) 
        if [ "$ifade" = "" ]; then
             ifade="${params[j]}*($x^$i)"
        else
             ifade+="+${params[j]}*($x^$i)"
        fi
    done

    echo "scale=5; $ifade" | bc -l
}

ciz(){
    numParam=$#
    params=("$@")
    read -p "Aralık girin (başlangıç bitiş): " aD uD
    clear
    polinomYapisi "${params[@]}"
    scale=0.2
    
    printf "\n"
    printf "%5s | %s\n" "x" "y ekseni (*)"
    printf "______|____________________________________________________________________\n"
    
    for ((i=$aD; i <= $uD; i++)); do
        y_float=$(paraDegerHesapla "$i" "${params[@]}")
        
        y_scaled=$(echo "$y_float * $scale" | bc -l)
        y_int=${y_scaled%.*}
        
        if (( y_int < 0 )); then
            abs_y_int=$(( -y_int ))
            
            printf "%4d|" "$i"
            
            for ((j=0; j < abs_y_int; j++)); do
                printf " "
            done
            printf "*\n"
            
        else
            printf "%4d|" "$i"
            j=0
            while (( j<y_int )); do
                printf " "
                ((j+=1))
            done
            printf "*\n"
        fi
    done
    printf "______|____________________________________________________________________\n"
}

polinom_hesap(){
    echo "Polinom katsayılarını girin (sabit katsayı en sonda olmalı, örn: 1 2 3 4):"
    read -a params
    polinomYapisi "${params[@]}"
    while true; do
        degerHesapla "${params[@]}"
        if [[ $? -eq 1 ]]; then
            break
        fi
    done
}

grafik_ciz(){
    echo "Polinom katsayılarını girin (sabit katsayı en sonda olmalı, örn: 1 2 3 4):"
    read -a params
    polinomYapisi "${params[@]}"
    ciz "${params[@]}"
}

logaritma() {
    while true; do
        read -p "İşlem (ln/exp) ve Sayı (örn: ln 10) (çıkış: q): " islem sayi
        
        if [[ "$islem" == "q" || "$islem" == "Q" ]]; then
            clear
            break
        fi

        case "$islem" in
            ln)
                sonuc=$(echo "scale=5; l($sayi)" | bc -l)
                echo "ln($sayi) = $sonuc"
                log_yaz "Logaritma: ln($sayi) = $sonuc"
                ;;
            exp)
                sonuc=$(echo "scale=5; e($sayi)" | bc -l)
                echo "e^$sayi = $sonuc"
                log_yaz "Üstel: e^$sayi = $sonuc"
                ;;
            *)
                echo "Geçersiz işlem. Lütfen 'ln' veya 'exp' girin."
                ;;
        esac
    done
}

fact_hesapla() {
    local n=$1
    local sonuc=1
    
    if (( n <= 1 )); then
        echo 1
    else
        for (( i=1; i<=n; i++ )); do
            (( sonuc *= i ))
        done
        echo $sonuc
    fi
}

faktoriyel() {
    while true; do
        read -p "Faktöriyelini hesaplamak istediğiniz tam sayıyı girin (çıkış: q): " n
        
        if [[ "$n" == "q" || "$n" == "Q" ]]; then
            clear
            break
        fi
        
        if ! [[ "$n" =~ ^[0-9]+$ ]]; then
            echo "Geçersiz giriş. Lütfen pozitif bir tam sayı girin."
            continue
        fi

        if (( n < 0 )); then
            echo "Negatif sayıların faktöriyeli tanımsızdır."
            continue
        fi

        if (( n == 0 )); then
            echo "0! = 1"
            continue
        fi

        sonuc=$(fact_hesapla "$n")
        echo "$n! = $sonuc"
        log_yaz "Faktöriyel: $n! = $sonuc"
    done
}

derece_radyan_donusum() {
    PI=$(echo "scale=10; 4*a(1)" | bc -l)

    while true; do
        echo "  d2r: Derece -> Radyan"
        echo "  r2d: Radyan -> Derece"
        read -p "Dönüşüm (d2r/r2d) ve Değer (örn: d2r 90) (çıkış: q): " yon deger
        
        if [[ "$yon" == "q" || "$yon" == "Q" ]]; then
            clear
            break
        fi

        case "$yon" in
            d2r)
                sonuc=$(echo "scale=5; $deger * ($PI / 180)" | bc -l)
                echo "$deger derece = $sonuc radyan"
                log_yaz "Dönüşüm: $deger Derece -> $sonuc Radyan"
                ;;
            r2d)
                sonuc=$(echo "scale=5; $deger * (180 / $PI)" | bc -l)
                echo "$deger radyan = $sonuc derece"
                log_yaz "Dönüşüm: $deger Radyan -> $sonuc Derece"
                ;;
            *)
                echo "Geçersiz yön. Lütfen 'd2r' veya 'r2d' girin."
                ;;
        esac
    done
}

mod_alma() {
    echo -e "\n--- Mod Alma (Kalan Bulma) ---"
    while true; do
        read -p "Modu alınacak sayı ve bölen (örn: 10 3) (çıkış: q): " a b
        if [[ "$a" == "q" || "$a" == "Q" ]]; then 
        clear 
        break; 
        fi
        
        if [[ -z "$b" ]]; then
            echo "Lütfen iki sayı girin (Bölünen ve Bölen)."
            continue
        fi

        if [ "$b" -eq 0 ]; then
            echo "Hata: Bir sayı 0'a bölünemez (mod alınamaz)."
            continue
        fi
        
        sonuc=$(( a % b ))
        
        echo "-----------------------------"
        echo "$a % $b = $sonuc"
        echo "-----------------------------"
        log_yaz "Mod: $a % $b = $sonuc"
    done
}

taban_donusum() {
    while true; do
        echo -e "\n--- Taban Aritmetiği ve Dönüşüm ---"
        echo "Örnek Girişler -> Binary: 2, Octal: 8, Decimal: 10, Hex: 16"
        
        read -p "Giriş Tabanı Nedir? (Çıkış için q): " giris_tabani
        if [[ "$giris_tabani" == "q" || "$giris_tabani" == "Q" ]]; then 
        clear 
        break; 
        fi

        read -p "Hedef (Çıkış) Tabanı Nedir?: " hedef_taban

        read -p "Dönüştürülecek Sayı: " sayi
        
        sayi=${sayi^^}
        
        sonuc=$(echo "obase=$hedef_taban; ibase=$giris_tabani; $sayi" | bc 2>/dev/null)
        
        if [[ -z "$sonuc" ]]; then
            echo "Hata: Geçersiz sayı veya taban girişi yaptınız!"
        else
            echo "-----------------------------------------"
            echo "Sonuç: ($sayi) base-$giris_tabani  ==>  ($sonuc) base-$hedef_taban"
            echo "-----------------------------------------"
            log_yaz "Taban: ($sayi) taban-$giris_tabani -> ($sonuc) taban-$hedef_taban"
        fi
    done
}

perm_komb() {
    while true; do
        echo -e "\n--- Permütasyon (nPr) ve Kombinasyon (nCr) ---"
        echo "  1) Permütasyon Hesapla (Sıralama)"
        echo "  2) Kombinasyon Hesapla (Seçme)"
        read -p "Seçim (çıkış: q): " secim
        
        if [[ "$secim" == "q" || "$secim" == "Q" ]]; then 
        clear 
        break;
        fi
        
        if [[ "$secim" == "1" || "$secim" == "2" ]]; then
            read -p "n ve r değerlerini girin (örn: 5 2): " n r
            
            if (( n < r )); then
                echo "Hata: 'n' sayısı 'r' sayısından küçük olamaz."
                continue
            fi
            
            pay=$(fact_hesapla "$n")          
            fark=$(( n - r ))
            payda_p=$(fact_hesapla "$fark")   
            
            if [[ "$secim" == "1" ]]; then
                sonuc=$(echo "$pay / $payda_p" | bc)
                echo "P($n, $r) = $sonuc"
                log_yaz "Permütasyon: P($n,$r) = $sonuc"
                
            elif [[ "$secim" == "2" ]]; then
                payda_r=$(fact_hesapla "$r")
                tam_payda=$(( payda_r * payda_p ))
                sonuc=$(echo "$pay / $tam_payda" | bc)
                echo "C($n, $r) = $sonuc"
                log_yaz "Kombinasyon: C($n,$r) = $sonuc"
            fi
        else
            echo "Geçersiz seçim."
        fi
    done
}

ortalama_hesapla() {
    while true; do
        echo -e "\n--- Ortalama Hesaplama Modu ---"
        echo "Sayıları sırayla girin."
        echo "  [b] -> Hesapla ve Yeni İşleme Geç"
        echo "  [q] -> Ana Menüye Çık"
        
        toplam=0
        adet=0
        
        while true; do
            read -p "Sayi $(($adet + 1)): " giris
            
            if [[ "$giris" == "q" || "$giris" == "Q" ]]; then
                clear 
                return 0
            fi
            
            if [[ "$giris" == "b" || "$giris" == "B" ]]; then
                if (( adet > 0 )); then
                    sonuc=$(echo "scale=2; $toplam / $adet" | bc -l)
                    echo "-----------------------------"
                    echo "Sonuçlar:"
                    echo "  Adet: $adet"
                    echo "  Toplam: $toplam"
                    echo "  Ortalama: $sonuc"
                    echo "-----------------------------"
                    log_yaz "İstatistik: $adet sayının ortalaması = $sonuc"
                    echo "Yeni hesaplama başlıyor..."
                    sleep 1
                else
                    echo "Hiç sayı girmediniz! Yeni işlem başlatılıyor."
                fi
                break
            fi
            
            if ! [[ "$giris" =~ ^-?[0-9]*\.?[0-9]+$ ]]; then
                echo "Hata: Geçersiz giriş. Lütfen sayı girin, 'b' ile hesaplayın veya 'q' ile çıkın."
                continue
            fi
            
            toplam=$(echo "$toplam + $giris" | bc -l)
            ((adet++))
        done
    done
}

log_terminal_yaz() {
    while true; do
        echo -e "\n--- Log Görüntüleme ---"
        read -p "Kaç satır görmek istiyorsunuz? (çıkış: q): " satir_sayisi
        
        if [[ "$satir_sayisi" == "q" || "$satir_sayisi" == "Q" ]]; then
            clear
            break
        fi
        
        if ! [[ "$satir_sayisi" =~ ^[0-9]+$ ]]; then
            echo "Geçersiz giriş. Lütfen pozitif bir tam sayı girin."
            continue
        fi
        
        if [[ -f log.txt ]]; then
            echo -e "\n--- Son $satir_sayisi İşlem ---"
            tail -n "$satir_sayisi" log.txt
            echo "-----------------------------"
        else
            echo "Log dosyası bulunamadı."
        fi
    done
}

clear

cat << "EOF"

      ____            _        _____      _            _       _             
     |  _ \          | |      / ____|    | |          | |     | |            
     | |_) | __ _ ___| |__   | |     __ _| | ___ _   _| | __ _| |_ ___  _ __ 
     |  _ < / _` / __| '_ \  | |    / _` | |/ __| | | | |/ _` | __/ _ \| '__|
     | |_) | (_| \__ \ | | | | |___| (_| | | (__| |_| | | (_| | || (_) | |   
     |____/ \__,_|___/_| |_|  \_____\__,_|_|\___|\__,_|_|\__,_|\__\___/|_|   
                                                                             

EOF

son_islem_getir

while true; do
    echo -e "\n------ Hesap Makine Menüsü ------"
    echo "Lütfen bir seçenek numarası girin ve 'q' ile alt menülerden çıkın."
    echo "--------------------------------------------------------------------------------------"
    
    echo "1) Aritmetik İfade (Örn: (2+6)*7/8)"
    echo "2) Üs Alma (Örn: 2 3 -> 8)"
    echo "3) Karakök (Örn: 16)"
    echo "4) Trigonometri (Örn: sin 0.5 veya cos 1)"
    echo "5) Polinom Hesaplama (Örn: Katsayılar: 1 0 -4, sonra x=3 girilir)"
    echo "6) Polinom Grafik Çizme (Örn: Katsayılar: 1 -2 0, Aralık: -3 5)"
    echo "7) Logaritma/Üstel (Örn: ln 10 veya exp 2)"
    echo "8) Faktöriyel (Örn: 5 -> 120)"
    echo "9) Derece/Radyan Dönüşümü (Örn: d2r 90 veya r2d 1.57)"
    echo "10) Mod Alma (Kalan Bulma)"
    echo "11) Taban Dönüşümü (Binary/Octal/Decimal/Hex)"  
    echo "12) Permütasyon/Kombinasyon (nPr / nCr)"
    echo "13) Ortalama Hesaplama (İstatistik)"
    echo "14) Log Görüntüleme (İşlem Geçmişi)"
    echo "0) Çıkış"
    echo "--------------------------------------------------------------------------------------"
    echo -n "Seçim yap: "
    read secim

    case $secim in
    1)
        aritmetik_ifade
        ;;
    2)
        us_al
        ;;
    3)
        karakok
        ;;
    4)
        trigonometri
        ;;
    5)
        polinom_hesap
        ;;
    6)
        grafik_ciz
        ;;
    7)
        logaritma
        ;;
    8)
        faktoriyel
        ;;
    9)
        derece_radyan_donusum
        ;;
    10) 
        mod_alma
        ;;
    11)  
        taban_donusum
        ;;
    12)
        perm_komb
        ;;
    13) 
        ortalama_hesapla
        ;;
    14)
        log_terminal_yaz
        ;;
    0)
        echo "Hesap makinesi kapatılıyor. Görüşmek üzere!"
        break
        ;;
    *)
        echo "Geçersiz seçim. Lütfen menüdeki numaralardan birini girin."
        ;;
    esac

done
