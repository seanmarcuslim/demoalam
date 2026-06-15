-- Make the Scam category reflect existing scam-prevention coverage.
-- This does not add fake depth or new guides; it reclassifies guides whose
-- primary user intent is scam detection before payment, OTP, or document sharing.

update public.guides
set
  category_id = (select id from public.categories where slug = 'scams'),
  updated_at = now()
where slug in (
  'gcash-scam-red-flags',
  'phishing-link-checklist',
  'fake-job-offer-red-flags'
);
