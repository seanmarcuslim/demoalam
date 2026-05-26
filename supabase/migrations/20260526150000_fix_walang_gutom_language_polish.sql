-- Fix small language inconsistencies found during Expo Web verification.
-- Keep estimated_time language-neutral because the field is not bilingual.

update public.guides
set
  estimated_time = '30-60 min',
  updated_at = now()
where slug = 'walang-gutom-food-credits-checklist';

update public.guide_sections
set
  content_en = '{"title":"Ask this before submitting anything","body":"Use a specific question so the office can answer with the current process in your area.","sample":"Hello. I would like to ask about the DSWD Walang Gutom Program. Is validation, EBT card distribution, or redemption active in [barangay/city/province]? How can our household verify if we are included, where is the official list or schedule, and which accredited store should we go to?"}'::jsonb
where guide_id = (select id from public.guides where slug = 'walang-gutom-food-credits-checklist')
  and order_index = 5;
