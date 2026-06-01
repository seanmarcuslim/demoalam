-- Fix confirmed EN/FIL mapping issues found during localization mapping audit.
-- Scope:
-- 1. gcash-maya-account-recovery-first-hour: English tagline only.
-- 2. national-id-problems-checklist: Filipino title only.

update public.guides
set
  tagline_en = 'Secure your SIM, email, passwords, and e-wallet access before panicking or trying to recover funds.',
  updated_at = now()
where slug = 'gcash-maya-account-recovery-first-hour';

update public.guides
set
  title_fil = 'Checklist sa problema sa National ID',
  updated_at = now()
where slug = 'national-id-problems-checklist';
