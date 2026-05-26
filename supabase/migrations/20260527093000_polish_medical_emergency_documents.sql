update public.guides
set
  title_en = 'Medical emergency documents checklist',
  title_fil = 'Medical emergency documents na dapat ihanda',
  tagline_en = 'Prepare IDs, contacts, PhilHealth/HMO details, medicine notes, and billing questions before panic starts.',
  tagline_fil = 'Ihanda ang IDs, contacts, PhilHealth/HMO details, gamot notes, at billing questions bago magsimula ang panic.',
  read_time_min = 6,
  estimated_time = '15-30 minuto maghanda',
  estimated_cost = 'Libre maghanda; hospital costs vary',
  difficulty = 'madali',
  is_urgent = true,
  tags = array[
    'emergency',
    'medical emergency',
    'hospital',
    'hospital documents',
    'philhealth',
    'hmo',
    'billing',
    'social service',
    'ambulance',
    '911',
    'patient documents'
  ],
  keywords_en = 'medical emergency hospital documents hospital emergency patient documents philhealth hmo emergency contact social service medical social worker billing ambulance 911 medicine allergies medical notes hospital admission discharge assistance',
  keywords_fil = 'medical emergency hospital documents hospital emergency patient documents philhealth hmo emergency contact social service medical social worker billing ambulansya 911 gamot allergies medical notes hospital admission discharge assistance',
  updated_at = now()
where slug = 'medical-emergency-documents';

update public.guide_sections
set
  content_en = '{
    "title":"Prepare documents before there is panic",
    "body":"This guide is not medical advice. It is a document and communication checklist so a patient or companion can move faster during an emergency, hospital visit, transfer, billing concern, or discharge preparation.",
    "items":[
      "Emergency help and patient safety come before paperwork",
      "A small identity pack can speed up admission and family coordination",
      "Medicine, allergy, and condition notes help avoid guessing under pressure",
      "PhilHealth, HMO, billing, and social service questions should be asked early",
      "Only give documents to official hospital staff or verified desks"
    ]
  }'::jsonb,
  content_fil = '{
    "title":"Maghanda ng documents bago may panic",
    "body":"Hindi ito medical advice. Document at communication checklist ito para mas mabilis kumilos ang pasyente o kasama kapag may emergency, hospital visit, transfer, billing concern, o discharge preparation.",
    "items":[
      "Emergency help at patient safety muna bago papeles",
      "Mas mabilis ang admission at family coordination kapag may identity pack",
      "Medicine, allergy, at condition notes ang iwas-hula habang pressured",
      "Dapat maagang itanong ang PhilHealth, HMO, billing, at social service",
      "Sa official hospital staff o verified desks lang ibigay ang documents"
    ]
  }'::jsonb
where guide_id = (select id from public.guides where slug = 'medical-emergency-documents')
  and section_type = 'what_to_know'
  and order_index = 1;

update public.guide_sections
set
  content_en = jsonb_set(
    content_en,
    '{title}',
    to_jsonb('START HERE: do not hand original documents to random people'::text)
  ),
  content_fil = jsonb_set(
    content_fil,
    '{title}',
    to_jsonb('UNAHIN ITO: huwag ibigay ang original documents sa kung sinu-sino'::text)
  )
where guide_id = (select id from public.guides where slug = 'medical-emergency-documents')
  and section_type = 'warning'
  and order_index = 6;

update public.guide_sections
set
  content_en = jsonb_set(
    content_en,
    '{items}',
    '[
      "Official hospital admitting, billing, claims, or social service desk only",
      "Ask for staff name, desk/unit, and receipt or receiving copy if documents are collected",
      "Keep photos or copies of IDs, PhilHealth/HMO papers, prescriptions, and receipts",
      "Do not pay fixers promising faster PhilHealth, HMO, or assistance approval",
      "Do not share OTP, bank login, e-wallet login, or full ID photos through random links"
    ]'::jsonb
  ),
  content_fil = jsonb_set(
    content_fil,
    '{items}',
    '[
      "Official hospital admitting, billing, claims, o social service desk lang",
      "Itanong ang staff name, desk/unit, at receipt o receiving copy kung kinolekta ang documents",
      "Magtabi ng photos o copies ng IDs, PhilHealth/HMO papers, prescriptions, at receipts",
      "Huwag magbayad sa fixer na nangangakong bibilisan ang PhilHealth, HMO, o assistance approval",
      "Huwag mag-share ng OTP, bank login, e-wallet login, o full ID photos sa random links"
    ]'::jsonb
  )
where guide_id = (select id from public.guides where slug = 'medical-emergency-documents')
  and section_type = 'warning'
  and order_index = 6;
