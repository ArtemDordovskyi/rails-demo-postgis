SELECT mg.osm_id,
       mg.geom_type,
       mg.landuse,
       mg.military,
       mg.building,
       mg.name,
       mg.operator,
       mg.geom
FROM military_geometries AS mg
WHERE EXISTS (
    SELECT 1
    FROM
        (SELECT geom
         FROM viirs_fire_events
        ) AS vfe
    WHERE ST_Contains(mg.geom, vfe.geom)
);
