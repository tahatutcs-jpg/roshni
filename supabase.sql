-- Run once in Supabase: SQL Editor > New query > paste > Run.
-- 1) CHANGE the admin email below before running.
create table items(id uuid primary key default gen_random_uuid(),kind text not null check(kind in('project','event','service')),title text not null,location text,summary text,body text,goal numeric default 0,raised numeric default 0,event_date date,event_time text,icon text,images text[] default '{}',created_at timestamptz default now());
create table messages(id uuid primary key default gen_random_uuid(),name text,phone text,topic text,message text,created_at timestamptz default now());
alter table items enable row level security;
alter table messages enable row level security;
create or replace function is_admin() returns boolean language sql stable as $$select coalesce(auth.jwt()->>'email','') in ('taha.tutcs@gmail.com')$$;
create policy "public read items" on items for select using(true);
create policy "admin write items" on items for all using(is_admin()) with check(is_admin());
create policy "anyone can send message" on messages for insert with check(true);
create policy "admin read messages" on messages for select using(is_admin());
create policy "admin delete messages" on messages for delete using(is_admin());
insert into storage.buckets(id,name,public) values('media','media',true) on conflict do nothing;
create policy "public read media" on storage.objects for select using(bucket_id='media');
create policy "admin write media" on storage.objects for all using(bucket_id='media' and is_admin()) with check(bucket_id='media' and is_admin());
-- Sample content (delete from the admin portal once you add your own)
insert into items(kind,title,location,summary,goal,raised,icon) values
('project','Clean Water for Thar','Tharparkar, Sindh','Solar RO plants and hand pumps for remote desert villages.',4500000,3150000,'💧'),
('project','Schools After the Floods','Dadu and Rajanpur','Rebuilding flood-damaged classrooms for 2,000 children.',6000000,4200000,'🏫'),
('project','Hunar Women Skills Centres','Lyari, Karachi and Peshawar','Stitching and digital-skills training that creates steady income.',2400000,1560000,'🧵');
insert into items(kind,title,location,summary,event_date,event_time) values
('event','Winter Warmth Drive','Quetta','Blankets and warm clothing for families.','2026-12-14','10:00 AM'),
('event','Ramadan Ration Drive','Lahore, Karachi, Islamabad','Ration packs for 5,000 families.','2027-02-06','After Asr');
insert into items(kind,title,summary,icon) values
('service','Education support','Scholarships, school rebuilding and teacher training.','📚'),
('service','Clean water and sanitation','Hand pumps, RO plants and hygiene training.','🚰'),
('service','Healthcare camps','Free medical camps in under-served areas.','🏥'),
('service','Disaster relief','Food, shelter and rehabilitation after floods and earthquakes.','🛶'),
('service','Skills and livelihoods','Vocational training and micro-grants.','🛠️'),
('service','Zakat and Sadaqah','Your giving delivered to the deserving, with reporting.','🤲');
