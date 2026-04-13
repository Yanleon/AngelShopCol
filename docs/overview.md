# Visión general

Este proyecto es una tienda basada en Bagisto 2.x (Laravel 10, PHP 8.1+) con personalizaciones para pagos locales y reportes adicionales. Está pensado para un equipo mixto (desarrollo, operaciones y negocio) que necesita desplegar, operar y evolucionar la tienda sin depender de conocimiento tácito.

## Stack y módulos
- **Framework:** Laravel 10 + Bagisto 2.x
- **Frontend:** Vite, Vue, Tailwind (componentes de Bagisto)
- **Backend:** PHP 8.1+, MySQL/MariaDB; Redis opcional para cache/cola
- **Integraciones propias:**
  - `Webkul\BoldPayment`: pago con Bold (checkout, callback, firma y botón en onepage)
  - `Webkul\Epayco`: pago con Epayco (Smart Button, IPN y callbacks)
  - Reporte de **uso de cupones** en Marketing → Promociones

## Estructura rápida
- `packages/Webkul/BoldPayment`: módulo Bold
- `packages/Webkul/Epayco`: módulo Epayco
- `packages/Webkul/Admin/src/DataGrids/.../CouponUsageDataGrid.php`: reporte de cupones
- `packages/Webkul/Shop/src/Resources/views/checkout/onepage/index.blade.php`: checkout en un paso con botones Bold/Epayco/PayPal
- `config/services.php`: credenciales de terceros (Facebook Pixel, social, etc.)
- `resources/`, `routes/`, `app/`: código estándar de Laravel/Bagisto

## Roles principales
- **Admin de tienda:** configura métodos de pago y revisa reportes.
- **Soporte/ops:** despliega versiones, ajusta .env y supervisa errores.
- **Dev:** mantiene módulos, corrige bugs y agrega features.

## Flujo de alto nivel
1) Cliente navega y arma carrito → checkout en un paso.
2) Selecciona método de pago (PayPal, Epayco, Bold). Para Bold/Epayco se muestran botones dedicados.
3) Pasarelas redirigen a callbacks (`/bold/callback`, `/epayco/standard/success`/`ipn`).
4) Orden se marca pagada, se muestra pantalla de éxito personalizada.
5) Marketing puede auditar cupones en el nuevo reporte.
