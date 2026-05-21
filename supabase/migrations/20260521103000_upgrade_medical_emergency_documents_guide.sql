update public.guides
set
  title_en = 'Medical emergency documents checklist',
  title_fil = 'Medical emergency documents checklist',
  tagline_en = 'Prepare IDs, contacts, PhilHealth details, medicine notes, and billing questions before panic starts.',
  tagline_fil = 'Ihanda ang IDs, contacts, PhilHealth details, medicine notes, at billing questions bago magsimula ang panic.',
  keywords_en = 'medical emergency hospital documents philhealth emergency contact hmo social service billing ambulance 911',
  keywords_fil = 'medical emergency hospital dokumento philhealth emergency contact hmo social service billing ambulansya 911',
  official_sources = '[
    {"title":"Benefits","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/benefits/"},
    {"title":"Downloads","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/downloads/"},
    {"title":"Local Call Centers","publisher":"Emergency 911 National Office","url":"https://e911.gov.ph/local-call-centers/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'medical-emergency-documents';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'medical-emergency-documents'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'what_to_know',
    1,
    '{"title":"Prepare before there is panic","body":"This guide is not medical advice. It is a document and communication checklist so a patient or companion can move faster during an emergency, hospital visit, or transfer."}'::jsonb,
    '{"title":"Maghanda bago may panic","body":"Hindi ito medical advice. Document at communication checklist ito para mas mabilis kumilos ang pasyente o kasama kapag may emergency, hospital visit, o transfer."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'step',
    2,
    '{"title":"Save the emergency contact set","body":"Keep a printed or phone-accessible list of people and numbers to contact first. Include the national emergency hotline, local barangay or city emergency response number if you know it, nearest hospital, and one family decision-maker.","step_number":1,"items":["National emergency hotline: 911","Nearest hospital or clinic","Barangay/city emergency response number","Primary family contact","Backup contact if your phone is locked or dead"]}'::jsonb,
    '{"title":"I-save ang emergency contact set","body":"Maghanda ng printed o madaling buksan na listahan ng unang tatawagan. Isama ang national emergency hotline, barangay o city emergency response number kung alam mo, pinakamalapit na ospital, at isang family decision-maker.","step_number":1,"items":["National emergency hotline: 911","Pinakamalapit na hospital o clinic","Barangay/city emergency response number","Primary family contact","Backup contact kung locked o lowbat ang phone"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'step',
    3,
    '{"title":"Prepare the patient identity pack","body":"Put the patient details in one envelope or phone note. This helps admission, billing, PhilHealth checking, and contacting family if the patient cannot answer.","step_number":2,"items":["Valid ID or photo of ID","Full name and birthday","Address and emergency contact","PhilHealth number or Member Data Record if available","HMO card or company medical benefit details if any"]}'::jsonb,
    '{"title":"Ihanda ang patient identity pack","body":"Ilagay sa isang envelope o phone note ang patient details. Makakatulong ito sa admission, billing, PhilHealth checking, at pagtawag sa family kung hindi makasagot ang pasyente.","step_number":2,"items":["Valid ID o photo ng ID","Full name at birthday","Address at emergency contact","PhilHealth number o Member Data Record kung meron","HMO card o company medical benefit details kung meron"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'step',
    4,
    '{"title":"Write the medical notes that doctors ask for","body":"Do not guess during panic. Prepare a short note with current medicines, allergies, known conditions, recent procedures, and the time symptoms started.","step_number":3,"items":["Current medicines and dosage","Allergies to medicine or food","Known conditions like diabetes, asthma, hypertension, pregnancy","Recent surgery, confinement, or lab results","Time symptoms started and what happened before"]}'::jsonb,
    '{"title":"Isulat ang medical notes na madalas tinatanong","body":"Huwag manghula habang nagpapanic. Gumawa ng short note ng current medicines, allergies, known conditions, recent procedures, at oras kung kailan nagsimula ang symptoms.","step_number":3,"items":["Current medicines at dosage","Allergy sa gamot o pagkain","Known conditions tulad ng diabetes, asthma, hypertension, pregnancy","Recent surgery, confinement, o lab results","Oras nagsimula ang symptoms at ano ang nangyari bago iyon"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'tip',
    5,
    '{"title":"Ask about PhilHealth, billing, and social service early","body":"Once the patient is stable enough, ask where to verify PhilHealth eligibility, what documents are needed, and whether the hospital has a social service or medical social worker desk.","sample":"Where can we verify PhilHealth or HMO coverage, what documents do you need from us, and is there a social service desk we can ask about assistance?"}'::jsonb,
    '{"title":"Magtanong agad tungkol sa PhilHealth, billing, at social service","body":"Kapag stable na ang pasyente, itanong kung saan ipa-verify ang PhilHealth eligibility, anong documents ang kailangan, at kung may social service o medical social worker desk ang hospital.","sample":"Saan po pwedeng ipa-verify ang PhilHealth o HMO coverage, anong documents ang kailangan namin, at may social service desk po ba para magtanong tungkol sa assistance?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'warning',
    6,
    '{"title":"Do not hand original documents to random people","body":"Only give documents to official hospital staff, billing, admitting, or claims personnel. If someone offers to fix papers or speed up benefits for a fee, verify with the official hospital desk first.","severity":"high"}'::jsonb,
    '{"title":"Huwag ibigay ang original documents sa kung sinu-sino","body":"Ibigay lang ang documents sa official hospital staff, billing, admitting, o claims personnel. Kung may nag-aalok mag-ayos ng papeles o pabilisin ang benefits kapalit ng bayad, i-verify muna sa official hospital desk.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'mistake',
    7,
    '{"title":"Waiting until discharge before asking about documents","body":"Many families only ask about PhilHealth, HMO, social service, or receipts near discharge. Ask earlier so missing documents can be prepared while treatment is ongoing."}'::jsonb,
    '{"title":"Sa discharge pa lang nagtatanong tungkol sa documents","body":"Maraming pamilya ang nagtatanong lang tungkol sa PhilHealth, HMO, social service, o resibo kapag malapit na ang discharge. Magtanong nang mas maaga para maihanda ang kulang habang ongoing ang treatment."}'::jsonb
  );
