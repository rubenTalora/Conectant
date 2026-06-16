create table if not exists public.associations (
  id text primary key,
  name text not null,
  type text not null default '',
  description text not null default '',
  contact text not null default '',
  website text not null default ''
);

create table if not exists public.centros (
  id text primary key,
  name text not null,
  address text not null default '',
  lat double precision not null default 0,
  lng double precision not null default 0,
  association_id text not null references public.associations(id),
  description text not null default ''
);

alter table public.associations enable row level security;
alter table public.centros enable row level security;

drop policy if exists "Public read associations" on public.associations;
create policy "Public read associations"
on public.associations
for select
to anon
using (true);

drop policy if exists "Public read centros" on public.centros;
create policy "Public read centros"
on public.centros
for select
to anon
using (true);

insert into public.associations (id, name, type, description, contact, website)
values
  (
    'a1',
    'Asociación de Fisioterapeutas de Ribera',
    'Organización',
    'Asociación profesional dedicada a promover la excelencia en fisioterapia y rehabilitación.',
    'info@fisioterapeutas-ribera.org',
    'www.fisioterapeutas-ribera.org'
  ),
  (
    'a2',
    'Fundación Rehabilitación Plus',
    'Organización',
    'Fundación dedicada a apoyar programas innovadores de rehabilitación y bienestar.',
    'info@rehabilitacion-plus.org',
    'www.rehabilitacion-plus.org'
  ),
  (
    'a3',
    'Colegio Profesional de Terapeutas',
    'Colegio',
    'Colegio oficial que agrupa y regula la actividad de profesionales de terapia.',
    'colegiados@colegio-terapeutas.es',
    'www.colegio-terapeutas.es'
  )
on conflict (id) do update set
  name = excluded.name,
  type = excluded.type,
  description = excluded.description,
  contact = excluded.contact,
  website = excluded.website;

insert into public.centros (
  id,
  name,
  address,
  lat,
  lng,
  association_id,
  description
)
values
  (
    '1',
    'Centro de Rehabilitación Ribera',
    'Calle Mayor, 12',
    40.4168,
    -3.7038,
    'a1',
    'Centro especializado en rehabilitación física y terapia ocupacional. Ofrecemos programas personalizados para recuperación tras lesiones y seguimiento continuo.'
  ),
  (
    '2',
    'Unidad de Terapia Avanzada',
    'Avenida del Sol, 45',
    40.4180,
    -3.7045,
    'a1',
    'Unidad con programas de terapia intensiva, equipos de última generación y equipos multidisciplinares orientados a la rehabilitación neurológica.'
  ),
  (
    '3',
    'Clínica Salud Ribera',
    'Plaza del Lago, 3',
    40.4195,
    -3.7020,
    'a2',
    'Clínica con atención primaria y especialidades médicas. Ideal para consultas rápidas y seguimiento.'
  )
on conflict (id) do update set
  name = excluded.name,
  address = excluded.address,
  lat = excluded.lat,
  lng = excluded.lng,
  association_id = excluded.association_id,
  description = excluded.description;
