# COS HUB 🎭 (Philippine Cosplay Buy & Rent Marketplace)

COS HUB is a cross-platform Flutter application tailored for the Philippine cosplay community. It provides a peer-to-peer marketplace where cosplayers can list authentic costumes and props for **Outright Sale (Buy Brand New / Preloved)** or **Short-Term Rental** with refundable security deposits, size selection, and optional eKYC verification.

---

## 🌟 Researched Costume & Prop Catalog

The catalog features researched and verified cosplays from iconic Anime, Gaming, Movie, and Comic franchises with high-resolution imagery and detailed clothing piece inclusions:

1. **Furina (Archon of Fontaine)** — *Genshin Impact*
   - Victorian blue frock coat & vest, dual-tone silver hydro wig, ribbon top hat, ruffled lace jabot collar, white gloves.
   - Listed by: Cristian Ordoñez (`@cristian_cos`) • Calamba, Laguna
2. **Usagi Tsukino (Super Sailor Moon)** — *Pretty Guardian Sailor Moon*
   - Sailor fuku bodice, pleated navy skirt, crimson back bow, gold crescent moon tiara, red choker, elbow satin gloves, boot covers.
   - Listed by: Sailor Amai (`@amai_guardian`) • Quezon City, Metro Manila
3. **Tanjiro Kamado** — *Demon Slayer: Kimetsu no Yaiba*
   - Green & black checkered haori, Demon Slayer corps gakuran uniform, white kyahan leg wraps, con-safe nichirin katana prop, hanafuda earrings.
   - Listed by: Kenji Kamado Crafts (`@kenji_props`) • Pasig City, Metro Manila
4. **Daedric Dragon Knight** — *The Elder Scrolls V: Skyrim*
   - Full horned Daedric helm with crimson glow slits, spiked articulated EVA cuirass & pauldrons, gauntlets, and dragon greatsword prop.
   - Listed by: IronForge PH (`@ironforge_cos`) • Davao City
5. **David Martinez** — *Cyberpunk: Edgerunners*
   - Neon yellow EMT bomber jacket, illuminated LED cyan high-collar spine insert, cargo pants, crossbody rig harness, cyberware gloves.
   - Listed by: Kusarine & Hyou (`@nightcity_edgerunners`) • Makati City, Metro Manila
6. **Kotori Minami (Stage Dress)** — *Love Live! School Idol Project*
   - Ruffled mint & lavender idol stage dress, petticoat, oversized star bow headband, wrist cuffs, microphone headset prop.
   - Listed by: Miyu Idol Wardrobe (`@miyu_idols`) • Mandaluyong, Metro Manila
7. **Din Djarin (The Mandalorian)** — *Star Wars: The Mandalorian*
   - Chrome Beskar helmet with T-visor, textured armor plates, weathered flight suit, flak vest, cartridge bandolier, cape, blaster pistol.
   - Listed by: Mando Armory PH (`@thisistheway_ph`) • Cebu City

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
