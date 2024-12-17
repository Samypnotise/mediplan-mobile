# Mediplan

## Points demandés

### Soins à domicile

Personnel qui effectue des tournées vers des patients en partant d’un centre de soin

- [x] Un serveur qui envoie aux soignants des tournées à réaliser
- [ ] Le soignant sur l’appli, peut visualiser sa tournée sur la carte / un planning (vue jour / semaine)
- [x] Partie synchronisation avec l’agenda personnel
- [x] Geo guidage de visite en visite (google maps entre chaque visite)
- [ ] Saisir le rapport de fin de visite sous forme écrite ou enregistrement vocal et l’envoyer au serveur
- [ ] Échange de mission entre deux soignants
- [ ] Un soignant peut demander une aide et les soignants à proximité ou ceux qui ont le temps de réaliser l’aide

---

# 🚀 Procédé d'Installation

---

## 🛠️ Prérequis

Avant de commencer, assurez-vous d'avoir :

1. **Un système d'exploitation pris en charge** :
   - Windows, macOS, ou Linux
2. **Un éditeur de code** (au choix) :
   - [Visual Studio Code](https://code.visualstudio.com/) (recommandé)
   - [Android Studio](https://developer.android.com/studio)
   - IntelliJ IDEA
3. **Git** :
   - Télécharger et installer [Git](https://git-scm.com/).

---

## 🔧 Étape 1 : Installation du SDK Flutter

1. **Téléchargez le SDK Flutter** :

   - Rendez-vous sur le site officiel : [flutter.dev](https://flutter.dev)
   - Téléchargez la version du SDK correspondant à votre OS.

   - Sur **macOS** ou **Linux**, utilisez `git` :

     ```bash
     git clone https://github.com/flutter/flutter.git -b stable
     ```

2. **Ajoutez Flutter à votre `PATH`** :

   - Sur **macOS** ou **Linux** : Ajoutez la ligne suivante à votre fichier `~/.zshrc` ou `~/.bashrc` :

     ```bash
     export PATH="$PATH:`pwd`/flutter/bin"
     ```

     Rechargez le shell avec :

     ```bash
     source ~/.zshrc
     ```

   - Sur **Windows** :
     - Ajoutez `C:\path\to\flutter\bin` à la variable d'environnement `Path`.

3. **Vérifiez l'installation** :

   Ouvrez un terminal et tapez :

   ```bash
   flutter --versionn
   ```

## ✅ Étape 2 : Configuration de Flutter

1. **Exécutez `flutter doctor`** :

   ```bash
   flutter doctor
   ```

   Cette commande vérifie si toutes les dépendances nécessaires sont installées.

2. **Installez les dépendances manquantes** (selon `flutter doctor`) :

   - **Android** :

     - Installez **Android Studio**.
     - Ouvrez **Android Studio**, allez dans **SDK Manager** et installez la dernière version du **SDK Android**.
     - Ajoutez un émulateur dans **AVD Manager**.

   - **iOS** (macOS uniquement) :

     - Installez **Xcode** depuis l’App Store.
     - Ouvrez **Xcode** et acceptez les conditions d’utilisation.
     - Installez les outils en ligne de commande :

       ```bash
       sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
       sudo xcodebuild -runFirstLaunch
       ```

   - **Éditeur de code** :
     - Installez le plugin **Flutter** dans votre éditeur préféré :
       - **VSCode** : Recherchez “Flutter” dans les extensions.
       - **Android Studio** : Allez dans Plugins > Rechercher “Flutter”.

## 📱 Étape 3 : Configuration des périphériques

1. **Configurer un émulateur** :

   - **Android** : Créez un émulateur avec AVD Manager dans Android Studio.
   - **iOS** : Utilisez le simulateur iOS avec Xcode.

2. **Utiliser un périphérique physique** :

   - **Android** :
     - Activez le **Mode Développeur** et le **Débogage USB**.
     - Connectez votre téléphone via USB.
   - **iOS** :
     - Connectez votre iPhone via USB.
     - Autorisez les connexions de confiance.

3. **Listez les périphériques disponibles** :

   ```bash
   flutter devices
   ```

## 🚀 Étape 4 : Lancer le projet Mediplan

1. **Naviguer vers le projet Flutter existant** :

   Ouvrez le terminal et placez-vous dans le répertoire du projet :

   ```bash
   cd chemin/vers/votre/projet
   ```

2. **Vérifiez que tous les packages sont installés** :

   Si vous avez cloné le projet ou l'avez récupéré d'un autre endroit, assurez-vous que toutes les dépendances sont bien installées en exécutant :

   ```bash
   flutter pub get
   ```

3. **Exécutez le projet** :

   - Pour lancer l'application sur un émulateur ou un périphérique connecté :

     ```bash
     flutter run
     ```

   Cela lancera l'application Flutter sur le périphérique cible par défaut.

4. **Options utiles** :

   - **Hot Reload** : Appuyez sur `r` dans le terminal pendant l'exécution pour recharger les modifications.
   - **Hot Restart** : Appuyez sur `R` pour redémarrer complètement l'application.
   - **Exécuter sur un périphérique spécifique** : Si vous avez plusieurs périphériques connectés, utilisez :

     ```bash
     flutter run -d <device_id>
     ```

     Remplacez `<device_id>` par l'ID du périphérique que vous souhaitez utiliser, que vous pouvez obtenir avec la commande `flutter devices`.

## 🐞 Étape 5 : Débogage et tests

1. **Vérifiez les problèmes potentiels** :

   ```bash
   flutter analyze
   ```

2. **Lancez les tests** :

   Pour exécuter les tests unitaires :

   ```bash
   flutter test
   ```

3. **Consultez les logs** :

   Pour afficher les logs de votre application en temps réel :

   ```bash
   flutter logs
   ```
