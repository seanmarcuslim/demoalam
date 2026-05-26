-- Fix Social Pension cost label so it works in both English and Filipino UI.
-- The estimated_cost field is not bilingual, so keep it language-neutral.

update public.guides
set
  estimated_cost = 'Official channels only',
  updated_at = now()
where slug = 'social-pension-indigent-senior-citizens';
