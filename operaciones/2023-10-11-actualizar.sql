set search_path = base;

ALTER TABLE operativos
  ADD column habilitacion_boton_formulario jsonb default null;