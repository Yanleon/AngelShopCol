# Pagos: Bold y Epayco
  - `title` / `description`: texto mostrado al cliente.
  - `merchant_id`: id de comercio en Bold.
  - `api_key` y `secret_key`: credenciales para generar firmas y consumir el API.
  - `sandbox`: habilita modo pruebas.
  - `button_style`: variante del botón (ej. `dark-M`).
  - `logo`: imagen mostrada en checkout.
  - `active`: habilitar/deshabilitar.
  1) En checkout en un paso, al elegir Bold aparece `<v-bold-button>` que usa la librería `https://checkout.bold.co/library/boldPaymentButton.js`.
  2) Se consume `/bold/config` para cargar credenciales y el botón.
  3) Bold redirige a `/bold/callback`; la firma se valida (`/bold/generate-signature`).
  4) Si todo va bien, se limpia la sesión Bold y se finaliza la orden.
  - Checkout URL: `https://tu-dominio.com/bold/checkout`
  - Callback/return URL: `https://tu-dominio.com/bold/callback`
  - *Falta la API Key / llave secreta*: configura `api_key` y `secret_key` en admin.
  - *Botón no carga*: revisa `button_style` y que `/bold/config` responda 200 (comprueba consola del navegador).
  1) En checkout, al elegir Epayco aparece `<v-epayco-button>` (Smart Button).
  2) Orden preliminar se arma en `/epayco/standard/set-order` y `/create-order`.
  3) Epayco redirige a `/epayco/standard/success` (respuesta del cliente).
  4) Las notificaciones server-to-server llegan a `/epayco/standard/ipn` (CSRF deshabilitado para esta ruta) y confirman el pago.
  - URL de respuesta: `https://tu-dominio.com/epayco/standard/success`
  - URL de confirmación/IPN: `https://tu-dominio.com/epayco/standard/ipn`
  - IPN no llega: verifica que la URL de confirmación coincida exactamente, que sea pública y sin bloqueos de firewall.
  - Datos incompletos: completa `cust_id_client`, `p_key`, `public_key` y URLs antes de probar.
