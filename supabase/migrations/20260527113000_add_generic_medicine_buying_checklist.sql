insert into public.guides (
  slug,
  category_id,
  title_en,
  title_fil,
  tagline_en,
  tagline_fil,
  is_featured,
  is_urgent,
  is_published,
  read_time_min,
  difficulty,
  estimated_time,
  estimated_cost,
  tags,
  keywords_en,
  keywords_fil,
  official_sources,
  published_at,
  updated_at
)
values (
  'generic-medicine-buying-checklist',
  (select id from public.categories where slug = 'healthcare'),
  'Generic medicine buying checklist before you pay',
  'Generic medicine checklist bago bumili',
  'Compare the generic name, buy from licensed pharmacies, and avoid fake or unregistered medicines.',
  'I-compare ang generic name, bumili sa licensed pharmacy, at umiwas sa fake o unregistered na gamot.',
  true,
  false,
  true,
  6,
  'madali',
  '5-15 minuto mag-check',
  'Libre magtanong; presyo depende sa gamot',
  array[
    'healthcare',
    'medicine',
    'generic medicine',
    'gamot',
    'pharmacy',
    'licensed pharmacy',
    'fda verification',
    'counterfeit medicine',
    'fake medicine',
    'prescription',
    'reseta',
    'medicine price'
  ],
  'generic medicine gamot medicine price cheaper medicine pharmacy licensed pharmacy fda verification fda registered counterfeit medicine fake medicine unregistered medicine prescription reseta active ingredient brand name generic name drug product verification portal buy medicine online safety',
  'generic medicine gamot medicine price mas murang gamot pharmacy licensed pharmacy fda verification fda registered counterfeit medicine fake medicine unregistered medicine prescription reseta active ingredient brand name generic name drug product verification portal bumili gamot online safety',
  '[
    {"title":"FDA Verification Portal","publisher":"Food and Drug Administration Philippines","url":"https://verification.fda.gov.ph/"},
    {"title":"FDA Verification Portal Circular","publisher":"Food and Drug Administration Philippines","url":"https://www.fda.gov.ph/fda-circular-no-2023-008-guidelines-on-the-publishing-of-package-insert-and-patient-information-leaflet-of-registered-drug-products-in-the-food-and-drug-administration-fda-verification-portal-sys/"},
    {"title":"DOH promotes affordability and effectiveness of generic drugs","publisher":"DOH Bicol Center for Health Development","url":"https://bicol.doh.gov.ph/news-releases/doh-bicol-chd-promotes-affordability-and-effectiveness-of-generic-drugs/"},
    {"title":"DOH promotes use of generic medicines as safe, effective alternative","publisher":"Philippine Information Agency","url":"https://pia.gov.ph/news/doh-promotes-use-of-generic-medicines-as-safe-effective-alternative/"},
    {"title":"Republic Act No. 6675 - Generics Act of 1988","publisher":"Supreme Court E-Library","url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/6411"}
  ]'::jsonb,
  now(),
  now()
)
on conflict (slug) do update
set
  category_id = excluded.category_id,
  title_en = excluded.title_en,
  title_fil = excluded.title_fil,
  tagline_en = excluded.tagline_en,
  tagline_fil = excluded.tagline_fil,
  is_featured = excluded.is_featured,
  is_urgent = excluded.is_urgent,
  is_published = excluded.is_published,
  read_time_min = excluded.read_time_min,
  difficulty = excluded.difficulty,
  estimated_time = excluded.estimated_time,
  estimated_cost = excluded.estimated_cost,
  tags = excluded.tags,
  keywords_en = excluded.keywords_en,
  keywords_fil = excluded.keywords_fil,
  official_sources = excluded.official_sources,
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'generic-medicine-buying-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Generic does not mean fake or weak",
      "body":"A generic medicine is identified by its active ingredient or generic name. The safer question is not only branded versus generic. Ask whether the medicine matches the prescription, is bought from a licensed pharmacy, and can be verified through official channels when needed.",
      "items":["Check the generic name or active ingredient, not only the brand","Ask the pharmacist for available generic options if appropriate","Buy from licensed pharmacies, not random sellers or suspicious online listings","Be careful with medicines that are extremely cheap, repacked, unlabeled, or sold without proper details","If unsure, ask a pharmacist or doctor before switching"]
    }$$::jsonb,
    $${
      "title":"Hindi ibig sabihin na fake o mahina ang generic",
      "body":"Ang generic medicine ay nakikilala sa active ingredient o generic name. Hindi lang branded versus generic ang tanong. Mas mahalaga kung tugma ito sa reseta, binili sa licensed pharmacy, at puwedeng ma-verify sa official channels kung kailangan.",
      "items":["I-check ang generic name o active ingredient, hindi brand lang","Tanungin ang pharmacist kung may available na generic options kung applicable","Bumili sa licensed pharmacy, hindi sa random sellers o kahina-hinalang online listings","Mag-ingat sa gamot na sobrang mura, repacked, walang label, o kulang ang details","Kung hindi sigurado, magtanong muna sa pharmacist o doctor bago magpalit"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not change prescribed medicine blindly",
      "body":"This guide helps you ask smarter buying and verification questions. It does not replace medical advice. Do not stop, change dose, or switch medicines without asking a pharmacist or doctor, especially for maintenance medicines, antibiotics, insulin, heart medicines, pregnancy-related medicines, or medicines for children.",
      "severity":"high",
      "items":["Do not buy medicine only because it is the cheapest option online","Do not trust sellers who cannot show complete product details","Do not use medicine with damaged packaging, unclear labels, or suspicious smell/color","Do not share prescription medicines with another person","Do not ignore allergic reactions or unusual side effects"]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag basta magpalit ng niresetang gamot",
      "body":"Ang guide na ito ay para tulungan kang magtanong at mag-verify bago bumili. Hindi ito kapalit ng medical advice. Huwag basta huminto, magbago ng dose, o magpalit ng gamot nang hindi nagtatanong sa pharmacist o doctor, lalo na sa maintenance medicines, antibiotics, insulin, heart medicines, pregnancy-related medicines, o gamot ng bata.",
      "severity":"high",
      "items":["Huwag bumili ng gamot dahil lang pinakamura ito online","Huwag magtiwala sa seller na hindi makapagbigay ng kumpletong product details","Huwag gumamit ng gamot na sira ang packaging, malabo ang label, o kahina-hinala ang amoy/kulay","Huwag ipagamit sa ibang tao ang prescription medicine mo","Huwag balewalain ang allergic reaction o kakaibang side effects"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'step',
    3,
    $${
      "title":"Compare the prescription with the label",
      "body":"Before paying, check whether the medicine being sold matches what was prescribed or recommended.",
      "step_number":1,
      "items":["Generic name or active ingredient","Strength or dosage, such as mg or mcg","Dosage form, such as tablet, capsule, syrup, drops, or injection","Quantity and directions from the prescription","Expiration date and packaging condition"]
    }$$::jsonb,
    $${
      "title":"I-compare ang reseta at label",
      "body":"Bago magbayad, i-check kung tugma ang gamot na ibinebenta sa nireseta o nirekomenda.",
      "step_number":1,
      "items":["Generic name o active ingredient","Strength o dosage tulad ng mg o mcg","Dosage form tulad ng tablet, capsule, syrup, drops, o injection","Quantity at directions mula sa reseta","Expiration date at kondisyon ng packaging"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'step',
    4,
    $${
      "title":"Ask the pharmacist before choosing the cheaper option",
      "body":"A cheaper generic may be appropriate, but confirm the match first instead of guessing.",
      "step_number":2,
      "items":["May generic equivalent po ba ito?","Pareho po ba ang active ingredient, strength, and dosage form?","Safe po ba itong substitute sa prescription ko?","May special instruction ba sa pag-inom o pag-store?","May side effects or warning signs ba na dapat bantayan?"]
    }$$::jsonb,
    $${
      "title":"Magtanong sa pharmacist bago piliin ang mas mura",
      "body":"Puwedeng okay ang mas murang generic, pero i-confirm muna ang match imbes na manghula.",
      "step_number":2,
      "items":["May generic equivalent po ba ito?","Pareho po ba ang active ingredient, strength, at dosage form?","Safe po ba itong substitute sa prescription ko?","May special instruction ba sa pag-inom o pag-store?","May side effects o warning signs ba na dapat bantayan?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'step',
    5,
    $${
      "title":"Verify if the seller or product feels suspicious",
      "body":"If the medicine is unfamiliar, very cheap, bought online, or being sold outside a normal pharmacy setting, slow down and verify.",
      "step_number":3,
      "items":["Use the FDA Verification Portal when product details are available","Check if the pharmacy or seller is legitimate and licensed","Avoid loose tablets with no proper label, lot number, or expiration date","Keep the receipt, packaging, and seller details","Report suspicious or counterfeit medicine concerns through official channels"]
    }$$::jsonb,
    $${
      "title":"Mag-verify kung kahina-hinala ang seller o produkto",
      "body":"Kung unfamiliar ang gamot, sobrang mura, binili online, o binebenta sa hindi normal na pharmacy setting, huminto muna at mag-verify.",
      "step_number":3,
      "items":["Gamitin ang FDA Verification Portal kung may product details","I-check kung legit at licensed ang pharmacy o seller","Iwasan ang loose tablets na walang maayos na label, lot number, o expiration date","Itabi ang resibo, packaging, at seller details","I-report sa official channels ang suspicious o counterfeit medicine concerns"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'mistake',
    6,
    $${
      "title":"Common medicine-buying mistakes",
      "body":"These mistakes can waste money or put the patient at risk.",
      "items":["Buying only by brand color or packaging look","Assuming all cheaper medicines are fake","Assuming all expensive medicines are automatically better","Switching medicine without checking active ingredient, strength, and dosage form","Buying from random online sellers because the price is lower","Throwing away the receipt and packaging before checking the medicine"]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali sa pagbili ng gamot",
      "body":"Puwedeng masayang ang pera o malagay sa risk ang pasyente dahil sa mistakes na ito.",
      "items":["Bumibili base lang sa kulay o itsura ng packaging","Ina-assume na fake lahat ng mas murang gamot","Ina-assume na automatic mas maganda ang mas mahal na gamot","Nagpapalit ng gamot nang hindi chine-check ang active ingredient, strength, at dosage form","Bumibili sa random online sellers dahil mas mura","Tinatapon agad ang resibo at packaging bago ma-check ang gamot"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'tip',
    7,
    $${
      "title":"Buying checklist",
      "body":"Use this before paying for medicine.",
      "items":["Generic name or active ingredient checked","Strength and dosage form matched with prescription","Licensed pharmacy or legitimate seller checked","Expiration date and packaging checked","Receipt kept","FDA verification considered if product or seller feels suspicious","Pharmacist questions asked before switching"]
    }$$::jsonb,
    $${
      "title":"Checklist bago bumili",
      "body":"Gamitin ito bago magbayad ng gamot.",
      "items":["Na-check ang generic name o active ingredient","Tugma ang strength at dosage form sa reseta","Na-check ang licensed pharmacy o legitimate seller","Na-check ang expiration date at packaging","Naitabi ang resibo","Na-consider ang FDA verification kung suspicious ang product o seller","Nakapagtanong sa pharmacist bago magpalit"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'tip',
    8,
    $${
      "title":"Sample question to the pharmacist",
      "body":"Use this when you want a cheaper option but do not want to guess.",
      "sample":"Hello po. Ito po ang prescription ko. May generic equivalent po ba na same active ingredient, same strength, and same dosage form? Safe po ba itong substitute, and may instructions po ba na kailangan kong sundin?"
    }$$::jsonb,
    $${
      "title":"Sample question sa pharmacist",
      "body":"Gamitin ito kapag gusto mo ng mas mura pero ayaw mong manghula.",
      "sample":"Hello po. Ito po ang prescription ko. May generic equivalent po ba na same active ingredient, same strength, at same dosage form? Safe po ba itong substitute, at may instructions po ba na kailangan kong sundin?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'generic-medicine-buying-checklist'),
    'tip',
    9,
    $${
      "title":"What to expect",
      "body":"A pharmacist may offer several brands or generic options with different prices. The right choice should match the prescription and be bought from a legitimate source. If the medicine is for a serious condition or you feel unsure, ask the doctor or pharmacist before switching."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng may ibigay ang pharmacist na iba't ibang brands o generic options na magkakaiba ang presyo. Ang tamang piliin ay dapat tugma sa reseta at galing sa legitimate source. Kung para sa seryosong kondisyon ang gamot o hindi ka sigurado, magtanong muna sa doctor o pharmacist bago magpalit."
    }$$::jsonb
  );
