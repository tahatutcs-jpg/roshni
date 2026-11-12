# Roshni Foundation website (static site + Supabase admin)

Pages: /, /about, /services, /projects, /events, /item?id=..., /donate, /contact, /admin

## 1. Backend (10 minutes, free)
1. Create a project at supabase.com.
2. SQL Editor: open `supabase.sql`, change `admin@yourdomain.pk` to your email, run it.
3. Authentication > Users > Add user: your admin email and a strong password. Authentication > Sign In / Providers: turn off "Allow new users to sign up".
4. Project Settings > API: copy the Project URL and the anon public key into `config.js`.
5. Edit the rest of `config.js` (name, phone, bank details, stats).

## 2. Deploy on Vercel
- GitHub: push this folder to a repo, then vercel.com > Add New > Project > import it. Framework: Other. No build command.
- Or CLI: `npm i -g vercel`, then run `vercel --prod` in this folder.

## 3. Link your domain
Vercel project > Settings > Domains > Add `yourngo.org.pk` (or .org / .com).
At your registrar's DNS panel add the records Vercel shows. Normally:
- `A` record, name `@`, value `76.76.21.21`
- `CNAME` record, name `www`, value `cname.vercel-dns.com`
Or point the domain's nameservers to Vercel's. DNS can take from minutes to 24 hours. HTTPS is automatic.
Finally, in Supabase > Authentication > URL Configuration, set Site URL to your domain.

## 4. Manage content
Open `yourdomain/admin`, sign in, then add or edit projects, events and services, upload or remove photos, and read contact messages.
