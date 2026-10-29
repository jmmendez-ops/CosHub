# COS HUB 🎭 (Philippine Cosplay Buy & Rent Marketplace)

COS HUB is a cross-platform Flutter application tailored for the Philippine cosplay community. It provides a peer-to-peer marketplace where cosplayers can list authentic costumes and props for **Outright Sale (Buy Brand New / Preloved)** or **Short-Term Rental** with refundable security deposits, size selection, and optional eKYC verification.

---

## 🌟 Researched Costume & Prop Catalog

The catalog features researched and verified cosplays from iconic Anime, Gaming, Movie, and Comic franchises with high-resolution imagery and detailed clothing piece inclusions:

1. **Cartethyia (Fleurdelys)** — *Wuthering Waves* `[Rent & Buy]`
   - Ethereal white and sea-blue layered gown, styled long silver wig with side braids, crystal thorn halo crown headpiece, silver armored gauntlets.
   - Listed by: Cristian Ordoñez (`@cristian_cos`) • Calamba, Laguna
2. **Usagi Tsukino (Super Sailor Moon)** — *Pretty Guardian Sailor Moon* `[Rent & Buy]`
   - Sailor fuku bodice, pleated navy skirt, crimson back bow, gold crescent moon tiara, red choker, elbow satin gloves, boot covers.
   - Listed by: Sailor Amai (`@amai_guardian`) • Quezon City, Metro Manila
3. **Tanjiro Kamado** — *Demon Slayer: Kimetsu no Yaiba* `[Rent & Buy]`
   - Green & black checkered haori, Demon Slayer corps gakuran uniform, white kyahan leg wraps, con-safe nichirin katana prop, hanafuda earrings.
   - Listed by: Kenji Kamado Crafts (`@kenji_props`) • Pasig City, Metro Manila
4. **Daedric Dragon Knight** — *The Elder Scrolls V: Skyrim* `[Rent Only]`
   - Full horned Daedric helm with crimson glow slits, spiked articulated EVA cuirass & pauldrons, gauntlets, and dragon greatsword prop.
   - Listed by: IronForge PH (`@ironforge_cos`) • Davao City
5. **David Martinez** — *Cyberpunk: Edgerunners* `[Rent & Buy]`
   - Neon yellow EMT bomber jacket, illuminated LED cyan high-collar spine insert, cargo pants, crossbody rig harness, cyberware gloves.
   - Listed by: Kusarine & Hyou (`@nightcity_edgerunners`) • Makati City, Metro Manila
6. **Kotori Minami (Stage Dress)** — *Love Live! School Idol Project* `[Rent & Buy]`
   - Ruffled mint & lavender idol stage dress, petticoat, oversized star bow headband, wrist cuffs, microphone headset prop.
   - Listed by: Miyu Idol Wardrobe (`@miyu_idols`) • Mandaluyong, Metro Manila
7. **Din Djarin (The Mandalorian)** — *Star Wars: The Mandalorian* `[Rent & Buy]`
   - Chrome Beskar helmet with T-visor, textured armor plates, weathered flight suit, flak vest, cartridge bandolier, cape, blaster pistol.
   - Listed by: Mando Armory PH (`@thisistheway_ph`) • Cebu City
8. **Furina (Archon of Fontaine)** — *Genshin Impact* `[Rent & Buy]`
   - Victorian blue frock coat & vest, dual-tone silver hydro wig with tails, ribbon top hat, ruffled lace jabot collar, white gloves.
   - Listed by: Lady Fontaine Studio (`@furina_ph`) • Pasay City, Metro Manila
9. **Kyojuro Rengoku (Flame Hashira)** — *Demon Slayer: Kimetsu no Yaiba* `[Rent & Buy]`
   - Flame-patterned gradient haori, black corps gakuran, fiery wig, and wood-core flame nichirin katana.
   - Listed by: Kenji Kamado Crafts (`@kenji_props`) • Pasig City, Metro Manila
10. **Princess Serenity** — *Pretty Guardian Sailor Moon* `[Rent Only]`
    - Haute couture empire-waist layered white chiffon gown, gold bustier rings, and detachable feather angel wings prop.
    - Listed by: Sailor Amai (`@amai_guardian`) • Quezon City, Metro Manila
11. **Emilia (Spirit Sorceress)** — *Re:Zero - Starting Life in Another World* `[Rent & Buy]`
    - Flared violet and white sorceress robe, crystal ice flower hairpiece, elf ear covers, and Puck companion plush.
    - Listed by: Miyu Idol Wardrobe (`@miyu_idols`) • Mandaluyong, Metro Manila
12. **Zenitsu Agatsuma** — *Demon Slayer: Kimetsu no Yaiba* `[Buy Only]`
    - Yellow triangle-patterned haori, black corps uniform, kyahan wraps, and lightning nichirin katana.
    - Listed by: Kenji Kamado Crafts (`@kenji_props`) • Pasig City, Metro Manila
13. **Nico Yazawa (Idol Stage Dress)** — *Love Live! School Idol Project* `[Rent & Buy]`
    - Hot pink frilled idol corset dress, multi-layer tulle crinoline, oversized bows, and stage wrist cuffs.
    - Listed by: Miyu Idol Wardrobe (`@miyu_idols`) • Mandaluyong, Metro Manila
14. **V (Cyberpunk Mercenary)** — *Cyberpunk 2077* `[Rent & Buy]`
    - Illuminated LED cyan high-collar Samurai bomber jacket, tactical cargo pants, knee armor, holster, and thermal katana.
    - Listed by: Kusarine & Hyou (`@nightcity_edgerunners`) • Makati City, Metro Manila

---

## 💳 Payment Options Setup (Mockup)

Users can configure their default Philippine payment options directly from the **Profile Modal** or **Checkout Screen**:
- **GCash**: Instant mobile wallet with configured phone number (e.g. `0956 123 3881`)
- **Maya**: Maya wallet & QR Ph setup (e.g. `0918 888 4567`)
- **Visa / Mastercard**: Cardholder info and card last 4 digits
- **Cash on Delivery (COD)**: Courier drop-off or convention meetup option
- **Persistence**: All payment settings are stored locally in `shared_preferences` and dynamically hydrated across checkout and profile views.

---

## 🚀 Quick Setup (All Platforms)

### Windows
Double-click `setup.bat` or run in PowerShell:
```powershell
.\setup.ps1
```
Or manually:
```cmd
setup.bat
```

### macOS & Linux
Make executable and run:
```bash
chmod +x setup.sh
./setup.sh
```

---

## 💻 Running the App

### 1. Web (Standalone Web Server — Recommended / Clean)
Run in optimized release mode without the Dart VM debug service, DevTools listener, or automated Chrome debug banner:
```bash
flutter run -d web-server --release --web-port=4200
```
Then open your everyday browser and go to:
👉 **`http://localhost:4200`**

### 2. Web (Direct Chrome Launch)
```bash
# Debug mode (with hot reload enabled)
flutter run -d chrome --web-port=4200

# Release mode (clean, no debug service)
flutter run -d chrome --release --web-port=4200
```
> **Note:** Port `4200` is pre-configured to avoid collisions with local backends.

### 3. Desktop Native
- **Windows:** `flutter run -d windows`
- **macOS:** `flutter run -d macos`
- **Linux:** `flutter run -d linux`

---

## 🌐 Sharing via ngrok Tunnel

To share your running Flutter Web app with friends or evaluators:
```bash
ngrok http 4200 --url renewed-oriole-exotic.ngrok-free.app
```
Then open:
👉 `https://renewed-oriole-exotic.ngrok-free.app`

---

## 🧪 Testing & Verification

```bash
flutter analyze
flutter test
```
- Code adheres to Flutter Material 3 standards with zero external dependencies.
- Smoke tests and widget trees pass with 0 warnings.
