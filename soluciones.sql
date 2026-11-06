-- ══════════════════════════════════════════
-- RetailChain — UNION y UNION ALL
-- Autor: [Gonzalo Fernandez]
-- Fecha: [06/11/2026]
-- ══════════════════════════════════════════
-- ══════════════════════════════════════════ --
-- RetailChain — UNION y UNION ALL 
-- ══════════════════════════════════════════ --

-- ── CONSULTA 1: UNION ──────────────────── --
-- Reporte de Catálogo Unificado (Productos únicos comercializados)
SELECT id_producto, nombre_producto, categoria 
FROM inventario_sucursal_norte
UNION
SELECT id_producto, nombre_producto, categoria 
FROM inventario_sucursal_sur;


-- ── CONSULTA 2: UNION ALL ──────────────── --
-- Auditoría de Stock Total (Mantiene todos los registros físicos con su stock)
SELECT id_producto, nombre_producto, categoria, stock 
FROM inventario_sucursal_norte
UNION ALL
SELECT id_producto, nombre_producto, categoria, stock 
FROM inventario_sucursal_sur;


-- ── CONSULTA 3: COMPARACIÓN DE RESULTADOS (Demostración) ─ --
-- Conteo usando UNION (Debe devolver menor cantidad por la deduplicación)
SELECT COUNT(*) AS filas_union     
FROM (
    SELECT id_producto, nombre_producto, categoria 
    FROM inventario_sucursal_norte
    UNION
    SELECT id_producto, nombre_producto, categoria 
    FROM inventario_sucursal_sur
) AS resultado_union; 

-- Conteo usando UNION ALL (Debe devolver el total bruto de filas: 7 Norte + 7 Sur = 14)
SELECT COUNT(*) AS filas_union_all 
FROM (
    SELECT id_producto, nombre_producto, categoria, stock 
    FROM inventario_sucursal_norte
    UNION ALL
    SELECT id_producto, nombre_producto, categoria, stock 
    FROM inventario_sucursal_sur
) AS resultado_union_all;
