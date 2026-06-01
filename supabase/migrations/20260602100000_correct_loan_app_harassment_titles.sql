-- Correct swapped title_en and title_fil for loan-app-harassment-evidence-checklist
-- Issue: title_en contains Filipino text, title_fil contains English text
-- Fix: Swap values to restore bilingual standard compliance

-- BEFORE correction:
--   title_en = 'Checklist ng ebidensya sa loan app harassment' (Filipino - INCORRECT)
--   title_fil = 'Loan app harassment evidence checklist' (English - INCORRECT)

-- AFTER correction:
--   title_en = 'Loan app harassment evidence checklist' (English - CORRECT)
--   title_fil = 'Checklist ng ebidensya sa loan app harassment' (Filipino - CORRECT)

-- Validation query (run before applying migration):
-- select slug, title_en, title_fil from public.guides 
-- where slug = 'loan-app-harassment-evidence-checklist';

update public.guides
set
  title_en = 'Loan app harassment evidence checklist',
  title_fil = 'Checklist ng ebidensya sa loan app harassment',
  updated_at = now()
where slug = 'loan-app-harassment-evidence-checklist';

-- Validation query (run after applying migration):
-- select slug, title_en, title_fil from public.guides 
-- where slug = 'loan-app-harassment-evidence-checklist';
