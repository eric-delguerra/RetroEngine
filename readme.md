# RetroEngine - Love2D Engine Framework ![MIT License](https://img.shields.io/badge/license-MIT-green) ![Build Status](https://img.shields.io/badge/build-passing-brightgreen)

**RetroEngine** est un framework personnalisé pour Love2D, conçu pour gérer des moteurs de jeux rétro, comme le Game Boy (GB). Il supporte une configuration dynamique.

## Table des Matières
- [Fonctionnalités](#fonctionnalités)
- [Structure du projet](#structure-du-projet)
- [Installation et Utilisation](#installation-et-utilisation)
- [Documentation](#documentation)
- [Contribution](#contribution)
- [Licence](#licence)

## Fonctionnalités
- **Animation de démarrage** : Logo et animation de démarrage personnalisables.
- **Moteur personnalisable** : Chaque moteur est défini par des propriétés (nom, mode, couleurs, polices, etc.) qui peuvent être chargées dynamiquement.
- **Configuration flexible** : Possibilité de surcharge des propriétés de moteur via des configurations utilisateur.
- **Évolutif** : Support pour différentes résolutions avec gestion de mise à l'échelle.

---

## Structure du projet

```bash
RetroEngine/
│
├── Engines/          # Contient les fichiers de configuration des différents moteurs (GB, etc.)
├── Fonts/            # Dossier contenant les polices utilisées par les moteurs
├── Images/           # Dossier contenant les images, comme le logo d'intro
├── Sounds/           # Dossier contenant les sons, comme l'intro musicale
├── RetroEngine.lua   # Fichier principal de la librairie RetroEngine
└── main.lua          # Fichier d'exemple qui utilise RetroEngine
```
## Installation et Utilisation

### Pré-requis
- Love2D : Assurez-vous que Love2D est installé. Vous pouvez le télécharger sur https://love2d.org/

### Instructions
1. Clonez ce dépôt dans votre projet Love2D.
2. Organisez vos fichiers comme indiqué dans la structure du projet :
   - RetroEngine/Engines/
   - RetroEngine/Fonts/
   - RetroEngine/Images/
   - RetroEngine/Sounds/
   - RetroEngine.lua (fichier principal)
   - main.lua (fichier d'exemple)
3. Utilisez RetroEngine dans votre projet Love2D. Voici un exemple de code pour démarrer le moteur dans le fichier main.lua :

```lua
local RE = require('RetroEngine/RetroEngine'):new('GB')

function love.load()
    RE:load()
end

function love.update(dt)
    RE:update(dt)
    if RE:hasBooted() then
        -- Logique du jeu ici
    end
end

function love.draw()
    RE:draw()
end

function love.keypressed(key)
    -- Gestion des entrées clavier
end
```

## Documentation

### Initialisation de l'Engine

Pour initialiser le moteur, vous devez spécifier le type d'engine que vous souhaitez utiliser. Vous pouvez aussi passer une configuration personnalisée.

```lua
local engine = RetroEngine:new('GB', {
    boot_speed = 100,
    boot_end_timer = 2,
    font_name = "PixelFont"
})
```

### Méthodes principales

- `load()` : Initialise le moteur, configure la fenêtre Love2D et charge les polices et couleurs.
- `update(dt)` : Gère l'animation d'intro et les mises à jour d'état du moteur.
- `draw()` : Affiche l'animation d'intro ou l'écran de jeu selon l'état d'initialisation du moteur.
- `resize(pNewScale)` : Redimensionne l'écran selon un nouveau facteur d'échelle.
- `hasBooted()` : Retourne un booléen indiquant si l'animation d'intro est terminée.

### Propriétés de l'Engine

Lors de la création d'une instance `RetroEngine`, vous pouvez configurer diverses propriétés comme :

- `boot_speed` : Vitesse de défilement du logo d'intro.
- `boot_end_timer` : Durée avant la fin de l'animation de boot.
- `font_name` : Nom de la police utilisée dans l'engine.
- `mode` : Dimensions et échelle de la fenêtre (défini dans les fichiers de moteur comme `GB.lua`).

### Fonctionnalités supplémentaires

1. **Animation d'intro** : Le moteur dispose d'une animation de démarrage qui affiche un logo en défilement. La vitesse et la durée de cette animation peuvent être configurées via `boot_speed` et `boot_end_timer`.

2. **Personnalisation des couleurs** : Le moteur charge les couleurs prédéfinies depuis le fichier de configuration de l'engine (par exemple `GB.lua`). Les propriétés suivantes sont disponibles :
   - `colors.primary` : Couleur principale utilisée pour le texte et les formes.
   - `backgroundColor` : Couleur d'arrière-plan de l'écran de jeu.

3. **Affichage du logo** : Le moteur permet d'afficher un logo personnalisé lors du boot via l'image définie dans `RE.logo`.

### Exemple de fichier de moteur (GB.lua)

Voici un exemple simple de fichier `GB.lua` qui peut être utilisé avec le `RetroEngine` :

```lua
local GB = {}

GB.name = "Game Boy Engine"
GB.mode = { width = 160, height = 144, scale = 3 }
GB.colors = {
    primary = {0.3, 0.7, 0.3},
    background_dark = {0.1, 0.1, 0.1}
}
GB.font_size = 8
GB.font_name = "PixelFont"
GB.boot = {
    scroll_x = 0,
    scroll_y = 0,
    sound = "gameboy"
}

return GB
```
Dans cet exemple, nous avons défini les propriétés comme la taille de la fenêtre (`mode`), les couleurs (`colors`) et la police (`font_name`) qui seront utilisées dans l'engine.

## Contribution
Si vous avez des idées pour améliorer RetroEngine, n'hésitez pas à soumettre un pull request ou à ouvrir une issue.

## Licence
Ce projet est sous licence MIT.
