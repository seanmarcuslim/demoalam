update public.guides
set
  title_en = 'Phishing link checklist before you enter OTPs or passwords',
  title_fil = 'Phishing link checklist bago maglagay ng OTP o password',
  tagline_en = 'Check links, fake login pages, OTP requests, and sender pressure before giving any details.',
  tagline_fil = 'I-check ang link, fake login page, OTP request, at pressure bago magbigay ng kahit anong details.',
  tags = array['phishing', 'scam', 'link', 'otp', 'password', 'fake login', 'smishing', 'vishing', 'online safety', 'gcash'],
  keywords_en = 'phishing scam link otp password mpin fake login smishing vishing online safety gcash account takeover suspicious message',
  keywords_fil = 'phishing scam link otp password mpin fake login smishing vishing online safety gcash account takeover kahina hinalang message',
  official_sources = '[
    {"title":"Threats to Security and Privacy","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/threats-security-privacy/"},
    {"title":"Report a scam","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4413295284377-Report-a-scam"},
    {"title":"Report someone trying to register their device to my account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/36349842359193-Report-someone-trying-to-register-their-device-to-my-account"}
  ]'::jsonb,
  updated_at = now()
where slug = 'phishing-link-checklist';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'phishing-link-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'what_to_know',
    1,
    '{"title":"Phishing tries to make you act before you think","body":"Phishing messages copy real brands, support pages, delivery notices, job offers, or e-wallet alerts so you enter OTPs, passwords, MPINs, card details, or IDs on a fake page."}'::jsonb,
    '{"title":"Pinapamadali ka ng phishing bago ka makapag-isip","body":"Ginagaya ng phishing messages ang real brands, support pages, delivery notices, job offers, o e-wallet alerts para ilagay mo ang OTP, password, MPIN, card details, o IDs sa fake page."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'warning',
    2,
    '{"title":"Never enter OTPs, MPINs, or passwords from a link someone sent","body":"If a message tells you to verify, unlock, claim, refund, or avoid account closure, do not use the link. Open the official app or website yourself.","severity":"high"}'::jsonb,
    '{"title":"Huwag maglagay ng OTP, MPIN, o password mula sa pinadalang link","body":"Kung sinasabi ng message na kailangan mag-verify, unlock, claim, refund, o iwas account closure, huwag gamitin ang link. Ikaw mismo ang magbukas ng official app o website.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    3,
    '{"title":"Check the sender and pressure tactic","body":"Scam messages often create panic or excitement so you skip checking. Slow down if the message threatens account closure, says you won money, claims urgent verification, or asks you to reply with a code.","step_number":1,"items":["Unknown or spoofed sender","Urgent deadline or threat","Prize, refund, job, or loan promise","Request for OTP, MPIN, password, or ID","Instruction to keep it secret"]}'::jsonb,
    '{"title":"I-check ang sender at pressure tactic","body":"Madalas gumagawa ng panic o excitement ang scam messages para hindi ka na mag-check. Huminto muna kapag may threat na ma-close ang account, nanalo ka raw, urgent verification, o pinapa-reply ang code.","step_number":1,"items":["Unknown o spoofed sender","Urgent deadline o pananakot","Prize, refund, trabaho, o loan promise","Hingi ng OTP, MPIN, password, o ID","Instruction na itago ito sa iba"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    4,
    '{"title":"Inspect the link before tapping","body":"A fake link may use misspellings, extra words, shortened URLs, or lookalike domains. Do not trust a link just because it has a brand name somewhere in it.","step_number":2,"items":["Misspelled brand or domain","Extra words before or after the brand name","Shortened link that hides the destination","HTTP instead of HTTPS on login pages","Random numbers, symbols, or strange subdomains"]}'::jsonb,
    '{"title":"Suriin ang link bago i-tap","body":"Ang fake link ay pwedeng may maling spelling, dagdag na words, shortened URL, o lookalike domain. Huwag magtiwala dahil may brand name lang sa link.","step_number":2,"items":["Maling spelling ng brand o domain","Dagdag na words bago o pagkatapos ng brand name","Shortened link na tinatago ang destination","HTTP imbes na HTTPS sa login page","Random numbers, symbols, o kakaibang subdomains"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    5,
    '{"title":"Use the safe route instead","body":"If the message might be real, do not use the message link. Open the official app, type the official website yourself, or contact support from inside the official app.","step_number":3,"items":["Open the official app directly","Type the official website yourself","Use Help Center inside the app","Search official contact details yourself","Report and block the sender if suspicious"]}'::jsonb,
    '{"title":"Gamitin ang safe route","body":"Kung baka totoo ang message, huwag pa rin gamitin ang link. Buksan ang official app, i-type mismo ang official website, o kontakin ang support mula sa loob ng official app.","step_number":3,"items":["Buksan mismo ang official app","I-type mismo ang official website","Gamitin ang Help Center sa loob ng app","Hanapin mismo ang official contact details","I-report at i-block ang sender kung suspicious"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'tip',
    6,
    '{"title":"Use this 10-second question","body":"Ask this before entering anything on a page.","sample":"Did I open this page myself from the official app or website, or did someone send me here through chat, SMS, email, ad, or a shortened link?"}'::jsonb,
    '{"title":"Gamitin itong 10-second question","body":"Itanong ito bago maglagay ng kahit anong details sa page.","sample":"Ako ba mismo ang nagbukas ng page mula sa official app o website, o may nagdala sa akin dito gamit ang chat, SMS, email, ad, o shortened link?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'mistake',
    7,
    '{"title":"Trusting a page because it looks professional","body":"Scam pages can copy logos, colors, forms, and customer support language. The safer test is where the page came from and whether the official app confirms the same issue."}'::jsonb,
    '{"title":"Nagtitiwala dahil professional tingnan ang page","body":"Kayang kopyahin ng scam pages ang logos, colors, forms, at customer support language. Mas safe na test kung saan nanggaling ang page at kung confirmed din sa official app ang parehong issue."}'::jsonb
  );
