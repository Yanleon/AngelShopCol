# Estilos de temporada (CSS por evento) — Diseño

Fecha: 2026-11-16

## Intención

Hoy la tienda tiene un único campo de CSS personalizado (Configuración → Contenido →
Scripts Personalizados → `custom_css`). Para vestir la tienda en una fecha especial
(Black Friday, Navidad, Amor y Amistad…) hay que borrar y pegar CSS cada vez.

Se quiere una sección del admin donde se **creen eventos con nombre y su propio CSS**,
se guarden todos, y el administrador **active a mano** el que quiera mostrar en la tienda.

## Objetivos

- Crear, editar y eliminar eventos libremente (nombre + CSS). Sin límite de cantidad.
- Activar / desactivar un evento con un clic desde el listado.
- **Un solo evento activo a la vez**: activar uno desactiva el que estuviera activo.
- La tienda aplica el CSS del evento activo en todas las páginas.

## No-objetivos

- Activación automática por fechas (decisión del usuario: se activa a mano).
- JavaScript por evento, banners, imágenes o cambios de contenido. Solo CSS.
- Vista previa antes de activar.
- Estilos distintos por canal o idioma (la tienda usa un solo canal, `default`).

## Anti-objetivos

- Que un CSS de evento rompa la tienda y no haya forma rápida de quitarlo: siempre debe
  bastar con pulsar "Desactivar" en el listado.
- Que el CSS de un evento pueda cerrar la etiqueta `<style>` e inyectar HTML.
- Que el CSS general (`custom_css`) deje de funcionar o cambie de comportamiento.

## Enfoques considerados

| Enfoque | Qué implica | Resultado |
|---|---|---|
| **A. Sección propia con tabla en BD** | Migración, modelo, CRUD en el admin, listado | **Elegido** por el usuario: permite *crear* eventos ilimitados |
| B. Espacios fijos en Configuración | N campos "nombre + CSS" + selector de evento activo | Descartado: número fijo, página larga, no se crean/borran de verdad |
| C. Campo repetible en Configuración | — | Descartado: la pantalla de Configuración de Bagisto no soporta repetidores |

## Diseño

### Nombre y ubicación

- Nombre en el admin: **"Estilos de temporada"**. Se evita "Eventos" porque ya existe
  Marketing → Comunicaciones → **Eventos** (eventos de email de Bagisto) y confundiría.
- Ubicación: menú **Configuración** (settings), junto a *Temas* y *Plantillas de descripción*.
  Clave de menú `settings.seasonal_styles`, ruta `admin.settings.seasonal_styles.index`.

### Datos

Tabla `seasonal_styles`:

| Columna | Tipo | Notas |
|---|---|---|
| `id` | increments | |
| `name` | string | requerido, ej. "Navidad" |
| `css` | longText, nullable | CSS libre |
| `is_active` | boolean, default `false` | máximo una fila en `true` |
| timestamps | | |

### Paquete

Copiar la estructura de `packages/Webkul/DescriptionTemplate`:

- `packages/Webkul/SeasonalStyle/` con `composer.json`, `database/migrations/`,
  `src/Models/SeasonalStyle.php`, `src/Repositories/SeasonalStyleRepository.php`,
  `src/Providers/SeasonalStyleServiceProvider.php` (carga migraciones).
- Registrar el provider en `config/app.php` y el namespace en `composer.json` (autoload PSR-4),
  luego `composer dump-autoload`.

### Admin

Mismo patrón que `DescriptionTemplateController` + `DescriptionTemplateDataGrid` +
`settings/description-templates/index.blade.php`:

- **Listado** (datagrid): Nombre, Estado (Activo / Inactivo), Actualizado.
  Acciones por fila: Editar, Activar/Desactivar, Eliminar.
- **Crear / Editar** en ventana emergente: campo *Nombre* y área grande *CSS*
  (fuente monoespaciada). Ayuda corta bajo el área: "Escribe CSS sin la etiqueta `<style>`".
- **Activar** (`POST .../toggle/{id}`): dentro de una transacción, pone `is_active = false`
  en todos y `true` en el elegido. Si el elegido ya estaba activo, lo desactiva
  (queda ninguno activo).
- Eliminar un evento activo simplemente deja la tienda sin evento.
- Entrada en `acl.php` (`settings.seasonal_styles` con create/edit/delete) para que los
  roles puedan controlarlo, igual que las plantillas de descripción.
- Textos en `lang/es/app.php` y `lang/en/app.php`.

### Tienda

En `packages/Webkul/Shop/src/Resources/views/components/layouts/index.blade.php`, dentro
del mismo `<style>`, **justo después** de `custom_css` general (así el evento puede
sobrescribirlo):

```blade
{!! core()->getConfigData('general.content.custom_scripts.custom_css') !!}

{{-- Estilo de temporada activo --}}
{!! $activeSeasonalCss !!}
```

- Se obtiene con una consulta `where('is_active', true)->value('css')`.
  Se cachea (`Cache::rememberForever('seasonal_style.active_css')`) y la caché se borra
  en cada crear/editar/activar/eliminar.
- Antes de imprimir, se neutraliza cualquier `</style` (insensible a mayúsculas) para que
  el CSS no pueda salir de la etiqueta.

## Decisiones tomadas por mí (corregibles)

- Nombre "Estilos de temporada" y ubicación en el menú Configuración.
- Activar un evento ya activo lo desactiva (botón de alternar).
- Caché del CSS activo para no consultar la BD en cada página.
- Sin vista previa ni fechas en esta versión.

## Para quien lo construya

- Estilo visual del listado y del modal: seguir el de Plantillas de descripción.
- Si existe un control de editor de código en los componentes del admin, se puede usar
  para el campo CSS; si no, un textarea monoespaciado es suficiente.
- Verificar en el admin real: crear dos eventos, activar uno, comprobar en la tienda,
  activar el otro y confirmar que el primero se apagó.
