# Archider Hyprland Environment

Welcome to **Archider**, a highly customized Hyprland setup with Rofi themes, Spotify color schemes, and a polished workflow designed for both aesthetic appeal and productivity. This repository contains all configuration files, scripts, and themes required to reproduce a sleek and efficient desktop environment on Arch Linux (or compatible distributions).

---

## Overview

This setup includes:

- **Hyprland Configuration**
  - Multi-monitor support
  - Custom gaps, borders, and dwindle layout
  - Animated transitions for windows and workspaces
  - Window rules and special workspace management
  - Color schemes integrated via `myColors.conf`
  - Lock screen via `hyprlock` with image, blur, and dynamic labels

- **Rofi Configuration**
  - Multiple `.rasi` files:
    - `config.rasi` – General behavior and keyboard navigation
    - `aplicacion.rasi` – Application menu, custom icons, and styling
    - `scheme-selector.rasi` – Color scheme selector with large icons
  - Themes support via `current-theme.rasi`
  - Keyboard-driven navigation with mouse support
  - Scrollbar, input bar, listview, and element styling

- **Spotify Color Schemes**
  - Fully customizable color palettes for Spotify-inspired UIs
  - Includes dark, dark-dracula, dark-ocean, dark-neon, dark-rose-pine, dark-sunrise, light, light-dracula, light-neon, light-ocean, light-rose-pine, light-sunrise
  - Provides consistent UI styling for themes and external apps

- **Custom Scripts**
  - Startup scripts (`apps.conf`) for autostart applications and services
  - Environment variables (`env.conf`) optimized for NVIDIA + Wayland
  - Brightness and volume control scripts
  - Theme switching scripts for Hyprland and Rofi

- **Input Configuration**
  - Keyboard layout, natural touchpad scrolling, and cursor behavior
  - Full control of hardware cursors for Wayland

- **Animations and Visual Effects**
  - Configurable easing functions for window transitions
  - Blur effects and rounded corners
  - Smooth workspace and window animations
  - Toggleable floating windows

- **Window Rules**
  - Predefined floating rules for tools like `nmtui`, `bluetoothctl`, `pavucontrol`
  - Workspace assignments for apps like Spotify
  - Custom monitor movement shortcuts

- **Keybindings**
  - System-wide keybindings for:
    - Application launchers
    - Workspace management
    - Window focus and movement
    - Audio & media controls
    - Brightness adjustment
    - Screenshot and OCR utilities
  - Supports both XF86 keys and fallback shortcuts

- **Hyprlock Lock Screen**
  - Custom background images per monitor
  - Blur, vibrancy, and contrast settings
  - Input field with dynamic dots, colors, and fonts
  - Display of date, time, username, currently playing song, network info, and keyboard layout

---

## Installation

> **Requirements:** Arch Linux or compatible distribution, Hyprland, Rofi, pamixer, playerctl, brightnessctl, swww, hyprlock

1. Clone the repository to your `~/.config` folder:

```bash
git clone https://github.com/Haidex3/Archider.git ~/.config/Archider
```

2. Copy the configurations to the appropriate locations:

```bash
cp -r ~/.config/Archider/hypr ~/.config/
cp -r ~/.config/Archider/rofi ~/.config/
```

3. Install required packages:

```bash
sudo pacman -S hyprland rofi pamixer playerctl brightnessctl swww hyprlock
```

4. Launch Hyprland with this configuration:

```bash
Hyprland
```

---

## Usage

* Press **Super + [key]** for window, workspace, and system shortcuts (see `keyblinds.conf`)
* Use **Rofi menus** for:

  * Application launcher (`aplicacion.rasi`)
  * Color scheme selector (`scheme-selector.rasi`)
* Switch themes with your scripts via Rofi or direct execution
* Spotify color schemes automatically apply consistent UI styling
* External monitors, brightness, and audio are fully manageable with defined shortcuts

---

## Customization

* **Colors:** Edit `myColors.conf` or Spotify `.conf` themes to adjust UI colors
* **Rofi Themes:** Modify `current-theme.rasi` or individual `.rasi` files for layout, spacing, and font changes
* **Animations:** Tweak `animations.conf` for custom window easing and duration
* **Keybindings:** Change or add keys in `keyblinds.conf`
* **Window Rules:** Modify `rules.conf` to float or assign apps to specific workspaces

---

## Keybindings Examples

| Action                | Shortcut                  |
|-----------------------|--------------------------|
| Launch Rofi App Menu  | Super + D                |
| Switch Workspace      | Super + [1–9]            |
| Move Window           | Super + Shift + [Arrows] |
| Volume Control        | XF86AudioRaise/Lower      |
| Brightness Control    | XF86MonBrightnessUp/Down |
| Screenshot            | Super + Shift + S         |
| Toggle Floating       | Super + F                |
| Focus Next/Prev Window| Super + Tab / Shift+Tab   |

---

## Window Rules Examples

| Application       | Behavior                     | Workspace |
|------------------|-------------------------------|-----------|
| nmtui             | Floating, center             | Any       |
| bluetoothctl      | Floating, small window       | Any       |
| Spotify           | Assign to workspace 3        | 3         |
| pavucontrol       | Floating, center             | Any       |

---

## Themes & Colors

- **Dark:** neon, ocean, rose-pine, sunrise, dracula  
- **Light:** neon, ocean, rose-pine, sunrise, dracula  
- **Rofi Themes:** Select via `current-theme.rasi` or Rofi script  
- **Spotify Colors:** Apply to UI consistently across apps  

---

## Hyprlock Features

- Per-monitor background images
- Blur, vibrancy, and contrast control
- Input field with dynamic dots and colors
- Show date, time, username, currently playing song
- Keyboard layout indicator
- Optional network & system info

---

## Scripts Included

- `apps.conf` – autostart apps & services  
- `env.conf` – environment variables  
- Brightness & volume scripts  
- Theme switcher scripts for Hyprland & Rofi  
- Lock screen launcher script  

---

## License

This project is **open source**, free to adapt, redistribute, and customize under the MIT license.

---

## Credits

* **Author:** Haidex3  
* **GitHub:** [https://github.com/Haidex3/Archider](https://github.com/Haidex3/Archider)  
* **Inspired by:** Hyprland, Rofi, modern Spotify color palettes, and minimal neon themes

