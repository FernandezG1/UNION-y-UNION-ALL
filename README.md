# RetailChain — Consolidación de Inventario con UNION y UNION ALL

Proyecto práctico para consolidar datos de múltiples sucursales utilizando operadores de conjuntos en SQL, comparando el impacto analítico y de rendimiento entre `UNION` y `UNION ALL`.

---

## 📋 Descripción de las Consultas

### 1. Reporte de Catálogo Unificado (`UNION`)
* **Pregunta de negocio:** ¿Qué productos únicos comercializa la empresa en toda su red de sucursales?
* **Funcionamiento:** Se utilizó `UNION` combinando las columnas de identificación y categoría (`id_producto`, `nombre_producto`, `categoria`) para fusionar ambas sucursales, eliminando automáticamente las filas completamente duplicadas.

### 2. Auditoría de Stock Total (`UNION ALL`)
* **Pregunta de negocio:** ¿Cuántos registros físicos de stock existen en total entre ambas sucursales?
* **Funcionamiento:** Se utilizó `UNION ALL` incluyendo la columna `stock` para fusionar verticalmente ambas tablas **sin aplicar filtros de duplicados**, conservando todos los registros físicos de stock de cada sucursal por igual.

---

## 🔍 Preguntas y Respuestas del Análisis

### 1. ¿Cuántas filas devuelve cada consulta y por qué son distintas?
* **`UNION` devuelve 11 filas** porque al evaluar el catálogo unificado de productos, detecta los registros que se repiten exactamente en ambas sucursales y aplica una deduplicación automática.
* **`UNION ALL` devuelve 14 filas en total** (7 registros de la sucursal norte + 7 registros de la sucursal sur), ya que conserva todos los registros sin importar que el producto ya figurara en la otra tabla.

### 2. ¿Qué filas específicas elimina el `UNION`?
El operador `UNION` elimina los duplicados exactos de las filas que se encuentran presentes tanto en `inventario_sucursal_norte` como en `inventario_sucursal_sur`. Específicamente, elimina las repeticiones de los productos:
1. **ID 103:** *Monitor 4K 27"*
2. **ID 104:** *Teclado Mecánico*
3. **ID 106:** *SSD Externo 1TB*
Al proyectar las columnas de identificación, `UNION` detecta que estas filas son exactamente iguales en ambas consultas y las consolida en una sola aparición por producto.

### 3. ¿Por qué `UNION ALL` es más eficiente que `UNION`?
* `UNION ALL` es una operación de bajo costo computacional: simplemente toma los datos de una tabla y los apila debajo de la otra de forma secuencial.
* Por el contrario, **`UNION` realiza una operación adicional y costosa en memoria:** un proceso de ordenamiento y filtrado (*sort/distinct*) para identificar y descartar las filas duplicadas.

### 4. ¿En qué casos de negocio usarías cada uno?
* **Casos para `UNION`:** Consolidar una lista única de clientes activos a partir de bases de datos de distintas campañas de marketing (para evitar enviar correos duplicados).
* **Casos para `UNION ALL`:** Consolidar registros históricos de transacciones o logs de auditoría de múltiples servidores para análisis de volumen y modelados con IA.

### 5. ¿Qué pasa si las columnas de ambas consultas no coinciden en número o tipo?
Si las consultas tienen diferente cantidad de columnas o si los tipos de datos en la misma posición no son compatibles, el motor SQL arrojará un **error de ejecución** impidiendo completar la operación.
