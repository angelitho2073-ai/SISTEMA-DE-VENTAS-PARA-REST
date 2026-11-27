-- Ejecuta este script en el SQL Editor de tu proyecto Supabase (gratuito)
-- para habilitar la sincronización en tiempo real entre todos los celulares, cocina y caja de Sabor Norteñito.

create table if not exists public.pos_sync_state (
  id text primary key,
  payload_json jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.pos_sync_state enable row level security;

create policy "allow_all_pos_sync"
  on public.pos_sync_state
  for all
  using (true)
  with check (true);

alter publication supabase_realtime add table public.pos_sync_state;
