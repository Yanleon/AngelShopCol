# Configuración

Centraliza variables en `.env` y el resto en el panel de administración (Configuración → …). No subas secretos al repositorio.

## Variables clave en `.env`
- **Aplicación:** `APP_NAME`, `APP_URL`, `APP_ADMIN_URL`, `APP_ENV`, `APP_DEBUG`, `APP_LOCALE`, `APP_TIMEZONE`
- **Vite:** `VITE_HOST`, `VITE_PORT` (útil en dev dentro de contenedores)
- **Base de datos:** `DB_CONNECTION`, `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`, `DB_PREFIX`
- **Cache/colas/sesión:** `CACHE_DRIVER`, `QUEUE_DRIVER`, `SESSION_DRIVER`, `SESSION_LIFETIME`, `REDIS_*`
- **Correo:** `MAIL_MAILER`, `MAIL_HOST`, `MAIL_PORT`, `MAIL_USERNAME`, `MAIL_PASSWORD`, `MAIL_ENCRYPTION`, `MAIL_FROM_*`, `ADMIN_MAIL_*`
- **API de tasas:** `FIXER_API_KEY`, `EXCHANGE_RATES_API_KEY`, `EXCHANGE_RATES_API_ENDPOINT`
- **Social login:** `FACEBOOK_*`, `TWITTER_*`, `GOOGLE_*`, `LINKEDIN_*`, `GITHUB_*`
- **Facebook Pixel:** `FACEBOOK_PIXEL_ID` (usado en layout y success de checkout)

## Configuración en panel (admin)
- **Métodos de pago:** Configuración → Métodos de pago
  - **Bold Payment:** título, descripción, `merchant_id`, `api_key`, `secret_key`, `sandbox`, `button_style`, `logo`, `active`.
  - **Epayco:** título, nombre tienda, `url_response`, `url_confirmation`, descripción, `cust_id_client`, `p_key`, `public_key`, logo, `active`, `testing_mode`.
- **Diseño y tema:** Configuración → General → Diseño (colores, fuente, radios, CSS custom) usados en `components/layouts/index.blade.php`.
- **Contenido personalizado:** Configuración → Contenido → CSS/JS personalizados (inyectados en layout).

## Endpoints de callback
- Bold: `/bold/checkout`, `/bold/callback`, `/bold/generate-signature`, `/bold/config`
- Epayco: `/epayco/standard/set-order`, `/create-order`, `/success`, `/ipn`
Asegura que las URLs registradas en las pasarelas coincidan con `APP_URL`.

## Buenas prácticas
- Usa valores de sandbox en entornos de prueba (`sandbox` en Bold, `testing_mode` en Epayco).
- Nunca commitees `.env`; usa `.env.example` como plantilla.
- Tras cambios de `.env` en producción: `php artisan config:cache && php artisan route:cache`.
