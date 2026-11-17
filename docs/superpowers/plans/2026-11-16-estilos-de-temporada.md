# Estilos de temporada Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Sección admin "Estilos de temporada" para crear eventos con CSS y activar uno a la vez; la tienda inyecta el CSS activo.

**Architecture:** Nuevo paquete `Webkul\SeasonalStyle` (modelo, repositorio, migración) calcado de `Webkul\DescriptionTemplate`. CRUD en Admin (controlador + datagrid + vista modal) bajo Configuración. La tienda lee el CSS activo vía `SeasonalStyleRepository::activeCss()` (cacheado).

**Tech Stack:** Laravel / Bagisto 2.x, Blade + Vue 3 (componentes admin), Pest.

**Spec:** `docs/superpowers/specs/2026-11-16-estilos-de-temporada-design.md`

## Global Constraints

- Tabla `seasonal_styles` (`id`, `name` string, `css` longText nullable, `is_active` boolean default false, timestamps).
- Máximo un registro con `is_active = true`.
- Menú/ACL `settings.seasonal_styles`, rutas `admin.settings.seasonal_styles.*`.
- Nombre visible: "Estilos de temporada" (es) / "Seasonal Styles" (en).
- Clave de caché: `seasonal_style.active_css`; se olvida en create/update/toggle/delete.
- El CSS impreso nunca contiene `</style` (case-insensitive).
- CSS del evento se imprime después de `general.content.custom_scripts.custom_css`.

## Review Focus

- Activar B cuando A está activo → A queda inactivo (test en Task 2).
- Activar el ya activo → ninguno activo (test en Task 2).
- CSS con `</STYLE><script>` → no sale de la etiqueta (test en Task 1).
- Eliminar el evento activo → tienda sin CSS de evento y caché limpia (test en Task 2).
- Ningún evento creado (tabla vacía) → tienda funciona igual que antes (test en Task 3).

---

### Task 1: Paquete SeasonalStyle (modelo, repo, migración)

**Files:**
- Create: `packages/Webkul/SeasonalStyle/{composer.json, database/migrations/2026_11_16_000000_create_seasonal_styles_table.php, src/Models/SeasonalStyle.php, src/Repositories/SeasonalStyleRepository.php, src/Providers/SeasonalStyleServiceProvider.php}`
- Modify: `composer.json` (psr-4 `Webkul\\SeasonalStyle\\`), `config/app.php` (provider)
- Test: `packages/Webkul/Admin/tests/Feature/Settings/SeasonalStyleTest.php`

**Interfaces — Produces:**
- `SeasonalStyleRepository::activate(int $id): void` — alterna: si estaba activo lo desactiva; si no, desactiva todos y activa éste (transacción). Olvida caché.
- `SeasonalStyleRepository::activeCss(): string` — CSS activo sanitizado, `''` si ninguno; cacheado `rememberForever`.
- `SeasonalStyleRepository::forgetCache(): void`
- Modelo casts `is_active => boolean`.

- [ ] Test: `activeCss()` neutraliza `</STYLE>` → `expect(...)->not->toContain('</style')` (case-insensitive).
- [ ] Implementar, `composer dump-autoload`, `php artisan migrate`, test pasa.

### Task 2: Admin CRUD + activar

**Files:**
- Create: `Admin/src/Http/Controllers/Settings/SeasonalStyleController.php`, `Admin/src/DataGrids/Settings/SeasonalStyleDataGrid.php`, `Admin/src/Http/Resources/SeasonalStyleResource.php`, `Admin/src/Resources/views/settings/seasonal-styles/index.blade.php`
- Modify: `Admin/src/Routes/settings-routes.php`, `Admin/src/Config/menu.php`, `Admin/src/Config/acl.php`, `Admin/src/Resources/lang/{es,en}/app.php`

Rutas: `GET ''` index, `POST ''` store, `GET edit/{id}` edit, `PUT edit` update, `POST toggle/{id}` toggle, `DELETE edit/{id}` delete.
Validación: `name` required|string, `css` nullable|string.

- [ ] Tests: index 200 con título; store crea; update edita; toggle A luego B → solo B activo; toggle B de nuevo → ninguno; delete del activo → `activeCss() === ''`.
- [ ] Implementar; tests pasan.

### Task 3: Tienda

**Files:** Modify `Shop/src/Resources/views/components/layouts/index.blade.php` (tras `custom_css`).

- [ ] Test (Shop feature): con evento activo, home contiene su CSS; sin eventos, home 200.
- [ ] Implementar con `app(SeasonalStyleRepository::class)->activeCss()`; tests pasan.
- [ ] Verificación manual en navegador local; commit.
