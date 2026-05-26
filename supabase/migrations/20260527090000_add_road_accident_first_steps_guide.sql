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
  'road-accident-first-steps',
  (select id from public.categories where slug = 'emergency'),
  'Road accident first steps before leaving the scene',
  'Road accident first steps bago umalis sa lugar',
  'Check safety, call help, document what happened, and avoid rushed settlements or missing reports.',
  'Unahin ang safety, tumawag ng tulong, i-document ang nangyari, at iwasan ang madaliang areglo o kulang na report.',
  true,
  true,
  true,
  7,
  'katamtaman',
  '10-60 minuto',
  'Libre mag-report; possible towing, hospital, repair, or document costs',
  array[
    'emergency',
    'road accident',
    'road crash',
    'traffic accident',
    'car accident',
    'motorcycle accident',
    'police report',
    'insurance claim',
    'mmda',
    '911',
    'lto'
  ],
  'road accident road crash traffic accident car accident motorcycle accident collision police report incident report blotter insurance claim photos evidence 911 mmda lto towing hospital settlement injury hit and run',
  'road accident road crash traffic accident car accident motorcycle accident banggaan police report incident report blotter insurance claim photos ebidensya 911 mmda lto towing hospital areglo injury hit and run',
  '[
    {"title":"911 unified hotline speeds up response to road crashes","publisher":"Philippine Information Agency","url":"https://pia.gov.ph/news/911-to-the-rescue-unified-hotline-speeds-up-response-to-road-crashes-saves-lives/"},
    {"title":"PNP at the frontlines: how 911 calls activate police response","publisher":"Philippine National Police","url":"https://pnp.gov.ph/pnp-at-the-frontlines-how-911-calls-activate-swift-and-coordinated-police-response/"},
    {"title":"MMDA FAQs - What To Do During Vehicular Accidents","publisher":"Metropolitan Manila Development Authority","url":"https://mmda.gov.ph/faq.html"},
    {"title":"Road and Traffic Rules - In Case of a Road Crash","publisher":"Land Transportation Office","url":"https://lto.gov.ph/wp-content/uploads/2023/09/RO102_CDE_Road_and_Traffic_Rules_Rules-on-the-road.pdf"},
    {"title":"CitiSend Incident Reporting App","publisher":"Land Transportation Office","url":"https://lto.gov.ph/citisend-incident-reporting-app/"}
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
where guide_id = (select id from public.guides where slug = 'road-accident-first-steps');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'what_to_know',
    1,
    $${
      "title":"A road accident is first a safety problem, then a document problem",
      "body":"After a crash, people often panic, argue, move vehicles too quickly, or accept a rushed settlement. Slow down. This guide is not legal or medical advice. It helps you prioritize safety, emergency help, evidence, police or traffic reporting, and insurance documents.",
      "items":[
        "Check injuries before arguing about fault",
        "Call 911 or local emergency responders if anyone is hurt or in danger",
        "Do not leave without helping, reporting, or getting proper details",
        "Take photos before moving vehicles if it is safe and allowed",
        "A written report may matter later for insurance, repair, or disputes"
      ]
    }$$::jsonb,
    $${
      "title":"Ang road accident ay safety problem muna, bago document problem",
      "body":"Pagkatapos ng banggaan, madalas nagpapanic, nagtatalo, minamadaling ilipat ang sasakyan, o pumapayag agad sa areglo. Huminto muna. Hindi ito legal o medical advice. Gabay ito para unahin ang safety, emergency help, ebidensya, police o traffic reporting, at insurance documents.",
      "items":[
        "I-check muna kung may nasaktan bago makipagtalo kung sino ang may kasalanan",
        "Tumawag sa 911 o local emergency responders kung may sugatan o delikado",
        "Huwag umalis nang walang tulong, report, o tamang details",
        "Kumuha ng photos bago ilipat ang sasakyan kung safe at pwede",
        "Puwedeng kailanganin ang written report para sa insurance, repair, o dispute"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'warning',
    2,
    $${
      "title":"START HERE: do not let pressure decide for you",
      "body":"If someone is injured, there is road danger, a driver wants to leave, or money is being demanded immediately, focus on safety and official reporting first. Do not sign, pay, admit fault, or accept a private settlement while shocked or confused.",
      "severity":"high",
      "items":[
        "Do not leave an injured person without help",
        "Do not block traffic longer than necessary if authorities tell you to move",
        "Do not sign a settlement you do not understand",
        "Do not hand over your license, OR/CR, phone, or ID to a stranger",
        "Do not pay a fixer, fake enforcer, or random towing helper"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag magpadala sa pressure",
      "body":"Kung may sugatan, delikado ang daan, gustong umalis ng driver, o may nanghihingi agad ng pera, unahin ang safety at official reporting. Huwag pumirma, magbayad, umamin ng fault, o pumayag sa private areglo habang shocked o nalilito.",
      "severity":"high",
      "items":[
        "Huwag iwan ang sugatan nang walang tulong",
        "Huwag humarang sa traffic nang mas matagal kaysa kailangan kung pinapalipat na ng authorities",
        "Huwag pumirma sa areglo na hindi mo naiintindihan",
        "Huwag ibigay ang license, OR/CR, phone, o ID sa stranger",
        "Huwag magbayad sa fixer, fake enforcer, o random towing helper"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'step',
    3,
    $${
      "title":"First 2 minutes: check people and danger",
      "body":"Before documents and arguments, check if people are safe. Move only if staying in place creates more danger.",
      "step_number":1,
      "items":[
        "Check yourself, passengers, riders, pedestrians, and the other vehicle",
        "Turn on hazard lights if available",
        "Move away from fire, smoke, leaking fuel, or fast traffic",
        "Call 911 if there are injuries, trapped persons, fire, danger, or hit-and-run",
        "Tell responders the exact location, landmarks, direction of travel, number of vehicles, and injuries"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 2 minuto: i-check ang tao at panganib",
      "body":"Bago ang documents at argumento, i-check kung ligtas ang mga tao. Lumipat lang kung mas delikado manatili sa puwesto.",
      "step_number":1,
      "items":[
        "I-check ang sarili, pasahero, riders, pedestrians, at kabilang sasakyan",
        "I-on ang hazard lights kung meron",
        "Lumayo sa apoy, usok, tumatagas na fuel, o mabilis na traffic",
        "Tumawag sa 911 kung may sugatan, na-trap, sunog, danger, o hit-and-run",
        "Sabihin ang exact location, landmarks, direction of travel, dami ng sasakyan, at injuries"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'step',
    4,
    $${
      "title":"Document the scene before details disappear",
      "body":"If it is safe, take quick evidence before vehicles are moved, debris is cleared, or people leave.",
      "step_number":2,
      "items":[
        "Wide photos showing vehicle positions, lane, signs, traffic lights, skid marks, debris, and weather",
        "Close photos of damage, plate numbers, OR/CR if shown voluntarily, license if shown voluntarily, and driver details",
        "Photos of injuries only if respectful and necessary for documentation",
        "Names and contact details of drivers, passengers, witnesses, responding officers, and traffic enforcers",
        "Time, location, direction, road condition, and short notes while memory is fresh"
      ]
    }$$::jsonb,
    $${
      "title":"I-document ang scene bago mawala ang details",
      "body":"Kung safe, kumuha agad ng ebidensya bago ilipat ang sasakyan, linisin ang debris, o umalis ang mga tao.",
      "step_number":2,
      "items":[
        "Wide photos ng vehicle positions, lane, signs, traffic lights, skid marks, debris, at weather",
        "Close photos ng damage, plate numbers, OR/CR kung kusang ipinakita, license kung kusang ipinakita, at driver details",
        "Photos ng injuries kung respectful at kailangan talaga sa documentation",
        "Names at contact details ng drivers, passengers, witnesses, responding officers, at traffic enforcers",
        "Time, location, direction, road condition, at maikling notes habang fresh pa ang memory"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'step',
    5,
    $${
      "title":"Get official reporting guidance",
      "body":"For injuries, hit-and-run, disputed fault, public road obstruction, insurance claims, or major damage, ask the responding police or traffic authority what report is needed.",
      "step_number":3,
      "items":[
        "Ask whether police, traffic investigator, barangay, MMDA, LGU traffic unit, or highway patrol should handle it",
        "Ask where and when to get the police report or traffic accident report",
        "Ask what documents are needed for insurance or repair claims",
        "Ask for the name, unit, station, contact number, and reference number if available",
        "If in Metro Manila, check official MMDA or local traffic channels for road assistance"
      ]
    }$$::jsonb,
    $${
      "title":"Kumuha ng official reporting guidance",
      "body":"Kung may injury, hit-and-run, dispute sa fault, obstruction sa public road, insurance claim, o malaking damage, itanong sa responding police o traffic authority kung anong report ang kailangan.",
      "step_number":3,
      "items":[
        "Itanong kung police, traffic investigator, barangay, MMDA, LGU traffic unit, o highway patrol ang dapat humawak",
        "Itanong saan at kailan makukuha ang police report o traffic accident report",
        "Itanong anong documents ang kailangan para sa insurance o repair claims",
        "Kunin ang name, unit, station, contact number, at reference number kung meron",
        "Kung nasa Metro Manila, i-check ang official MMDA o local traffic channels para sa road assistance"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'step',
    6,
    $${
      "title":"Call insurance before agreeing to repair or settlement",
      "body":"If a vehicle is insured, contact the insurer or agent as soon as possible. Some claims need photos, police report, estimate, and inspection before repair.",
      "step_number":4,
      "items":[
        "Ask what documents they require before repair",
        "Ask if moving the vehicle, towing, or repair needs approval",
        "Ask if a police report or traffic accident report is required",
        "Ask how to submit photos, estimate, OR/CR, license, and claim form",
        "Do not agree to a final settlement until you understand repair, medical, and claim consequences"
      ]
    }$$::jsonb,
    $${
      "title":"Tawagan ang insurance bago pumayag sa repair o areglo",
      "body":"Kung insured ang sasakyan, kontakin agad ang insurer o agent. May claims na kailangan ng photos, police report, estimate, at inspection bago ipa-repair.",
      "step_number":4,
      "items":[
        "Itanong anong documents ang kailangan bago repair",
        "Itanong kung kailangan ng approval bago ilipat, i-tow, o ipaayos ang sasakyan",
        "Itanong kung kailangan ang police report o traffic accident report",
        "Itanong paano isusubmit ang photos, estimate, OR/CR, license, at claim form",
        "Huwag pumayag sa final settlement hangga't hindi malinaw ang repair, medical, at claim consequences"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'mistake',
    7,
    $${
      "title":"Common mistakes after a crash",
      "body":"Most mistakes happen because people want the problem to end quickly. Quick is not always safe.",
      "items":[
        "Leaving before exchanging details or reporting when needed",
        "Arguing on the road while people are unsafe",
        "Moving vehicles before taking photos when it was safe to document first",
        "Paying cash without receipt, written agreement, or verified identity",
        "Signing a settlement while injured, shocked, or confused",
        "Not saving witness names, officer details, towing details, or report reference",
        "Posting plate numbers, IDs, injuries, or faces publicly before thinking about privacy and safety"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes pagkatapos ng banggaan",
      "body":"Madalas nangyayari ang mistakes dahil gusto nang matapos agad ang problema. Hindi laging safe ang mabilis.",
      "items":[
        "Umalis bago makipagpalitan ng details o mag-report kung kailangan",
        "Nakikipagtalo sa daan habang hindi pa safe ang mga tao",
        "Inilipat ang sasakyan bago kumuha ng photos kahit safe namang mag-document muna",
        "Nagbayad ng cash nang walang resibo, written agreement, o verified identity",
        "Pumirma sa areglo habang injured, shocked, o nalilito",
        "Hindi sinave ang witness names, officer details, towing details, o report reference",
        "Nag-post publicly ng plate number, IDs, injuries, o mukha bago isipin ang privacy at safety"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'tip',
    8,
    $${
      "title":"Crash documentation checklist",
      "body":"Use this before leaving the scene if it is safe.",
      "items":[
        "Photos and videos of vehicle positions, damage, plates, road signs, lane, and traffic lights",
        "Driver names, contact numbers, license details if voluntarily shown, and vehicle plate numbers",
        "Witness names and contact numbers",
        "Responding officer, enforcer, station, unit, and reference number",
        "Tow truck name, plate, operator, fee, and destination if towing is used",
        "Hospital, clinic, or ambulance details if anyone was treated",
        "Insurance claim instructions and deadline"
      ]
    }$$::jsonb,
    $${
      "title":"Crash documentation checklist",
      "body":"Gamitin ito bago umalis sa scene kung safe.",
      "items":[
        "Photos at videos ng vehicle positions, damage, plates, road signs, lane, at traffic lights",
        "Driver names, contact numbers, license details kung kusang ipinakita, at vehicle plate numbers",
        "Witness names at contact numbers",
        "Responding officer, enforcer, station, unit, at reference number",
        "Tow truck name, plate, operator, fee, at destination kung may towing",
        "Hospital, clinic, o ambulance details kung may ginamot",
        "Insurance claim instructions at deadline"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'tip',
    9,
    $${
      "title":"Sample call or message",
      "body":"Use this when calling emergency responders, police, traffic office, insurance, or family.",
      "sample":"Road accident po at [exact location/landmark]. May [number] vehicles involved. May [injured / no visible injury / trapped person / fire / fuel leak]. We need [ambulance / police / traffic assistance / towing guidance]. My name is [name], callback number [number]."
    }$$::jsonb,
    $${
      "title":"Sample call o message",
      "body":"Gamitin ito kapag tatawag sa emergency responders, police, traffic office, insurance, o family.",
      "sample":"May road accident po sa [exact location/landmark]. May [number] sasakyan na involved. May [sugatan / walang visible injury / na-trap / sunog / fuel leak]. Kailangan po namin ng [ambulance / police / traffic assistance / towing guidance]. Ako po si [name], callback number [number]."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'road-accident-first-steps'),
    'tip',
    10,
    $${
      "title":"What to expect",
      "body":"Minor crashes may be settled faster if there are no injuries and both sides understand the agreement, but injuries, disputes, hit-and-run, major damage, public obstruction, or insurance claims can require official reports and follow-up. Keep records even if everyone seems friendly at the scene."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Mas mabilis minsan ang minor crashes kung walang injury at malinaw sa magkabilang side ang agreement, pero kapag may injury, dispute, hit-and-run, malaking damage, obstruction sa public road, o insurance claim, puwedeng kailangan ng official reports at follow-up. Magtabi ng records kahit mukhang maayos ang usapan sa scene."
    }$$::jsonb
  );
