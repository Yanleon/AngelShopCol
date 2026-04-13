# Instalación y arranque

Sigue estos pasos en un entorno limpio. Revisa `config/services.php` y `.env.example` para ver todas las variables disponibles.

## Requisitos
- PHP 8.1+ con extensiones: intl, mbstring, openssl, pdo_mysql, curl, tokenizer
- Composer 2.x
- Node 18+ y npm
- MySQL/MariaDB
- Opcional: Redis (cache/colas)

## Pasos
1) Clonar el repo y entrar al proyecto.
2) Instalar dependencias PHP:
   ```sh
   composer install
   ```
3) Instalar dependencias JS:
   ```sh
   npm install
   ```
4) Copiar entorno y ajustar valores:
   ```sh
   cp .env.example .env
   ```
   - Define `APP_URL` y `APP_ADMIN_URL`.
   - Configura DB (`DB_HOST`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`).
5) Generar key de aplicación:
   ```sh
   php artisan key:generate
   ```
6) Enlazar almacenamiento público:
   ```sh
   php artisan storage:link
   ```
7) Base de datos:
   - Si partes de cero: `php artisan migrate --seed` (si tienes seeds) o solo `migrate`.
   - Si tienes un dump previo: restaura el SQL en tu motor.
8) Compilar assets (producción):
   ```sh
   npm run build
   ```
   En desarrollo usa `npm run dev` o `npm run dev -- --host` si expones la Vite dev server.
9) Levantar servidor:
   ```sh
   php artisan serve
   ```

## Checks rápidos
- `php artisan config:cache` después de ajustar `.env` en producción.
- Revisa permisos de `storage/` y `bootstrap/cache/` si estás en Linux.
- Verifica que las URLs de callback de Epayco/Bold coincidan con tu `APP_URL`.
