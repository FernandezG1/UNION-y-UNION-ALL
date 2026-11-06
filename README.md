# RetailChain — Consolidación de Inventario con UNION y UNION ALL

Proyecto práctico para consolidar datos de múltiples sucursales utilizando operadores de conjuntos en SQL, comparando el impacto analítico y de rendimiento entre `UNION` y `UNION ALL`.

---

## 📋 Descripción de las Consultas

### 1. Reporte de Catálogo Unificado (`UNION`)
* **Pregunta de negocio:** ¿Qué productos únicos comercializa la empresa en toda su red de sucursales?
* **Funcionamiento:** Se utilizó `UNION` para combinar las tablas `inventario_sucursal_norte` e `inventario_sucursal_sur`, eliminando automáticamente las **filas completamente duplicadas** (filas donde coinciden exactamente `id_producto`, `nombre_producto`, `categoria` y `stock`).

### 2. Auditoría de Stock Total (`UNION ALL`)
* **Pregunta de negocio:** ¿Cuántos registros físicos de stock existen en total entre ambas sucursales?
* **Funcionamiento:** Se utilizó `UNION ALL` para fusionar verticalmente ambas tablas **sin aplicar filtros de duplicados**, conservando todos los registros físicos de stock de cada sucursal por igual.

---

## 🔍 Preguntas y Respuestas del Análisis

### 1. ¿Cuántas filas devuelve cada consulta y por qué son distintas?
* **`UNION` devuelve menos filas** (en este caso, 10 filas) porque al encontrar productos que se repiten exactamente en ambas sucursales con los mismos atributos, el operador deduplica el resultado.
* **`UNION ALL` devuelve más filas** (12 filas en total: 7 de la sucursal norte + 5 de la sur), ya que conserva todos los registros sin importar si el producto físico o ID ya figuraba en la otra tabla.

### 2. ¿Por qué `UNION ALL` es más eficiente que `UNION`?
* `UNION ALL` es una operación de bajo costo computacional: simplemente toma los datos de una tabla y los apila debajo de la otra de forma secuencial.
* Por el contrario, **`UNION` realiza una operación adicional y costosa en memoria:** un proceso de ordenamiento y filtrado (*sort/distinct*) para identificar y descartar las filas duplicadas. En bases de datos masivas, esto requiere más recursos de CPU y memoria RAM.

### 3. ¿En qué casos de negocio usarías cada uno?
* **Casos para `UNION`:**
  1. Consolidar una lista única de clientes activos a partir de bases de datos de distintas campañas de marketing (para evitar enviar correos duplicados).
  2. Generar un catálogo general de precios vigentes combinando los catálogos de tiendas online y físicas para mostrar productos únicos al cliente final.
* **Casos para `UNION ALL`:**
  1. Consolidar registros históricos de transacciones o logs de auditoría de múltiples servidores para análisis de volumen y modelados predictivos con IA.
  2. Calcular la facturación total sumando tickets de venta de diferentes sucursales regionales donde no importa que los ítems o precios se repitan.

### 4. ¿Qué pasa si las columnas de ambas consultas no coinciden en número o tipo?
* **Error de sintaxis y compatibilidad:** Si las consultas tienen diferente cantidad de columnas (por ejemplo, seleccionar 4 columnas en la primera y 3 en la segunda), o si los tipos de datos en la misma posición no son compatibles (intentar unir una columna de texto con una numérica), el motor SQL arrojará un **error de ejecución** impidiendo completar la operación.
