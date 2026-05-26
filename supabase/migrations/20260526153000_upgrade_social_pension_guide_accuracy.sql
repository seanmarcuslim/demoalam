-- Upgrade Social Pension guide with newer DSWD accuracy points.
-- Goal: clarify eligibility, waitlist/oldest-priority context, ID concerns, and scam risks.

update public.guides
set
  title_en = 'Social pension for indigent seniors: what to check first',
  title_fil = 'Social pension ng indigent seniors: mga dapat i-check muna',
  tagline_en = 'Check eligibility, waitlist status, required IDs, payout process, and fake pension registration red flags.',
  tagline_fil = 'I-check ang eligibility, waitlist status, kailangang ID, payout process, at red flags ng fake pension registration.',
  read_time_min = 8,
  estimated_time = '30-60 min',
  estimated_cost = 'Libre sa official channels',
  tags = array[
    'dswd',
    'social pension',
    'senior citizen',
    'indigent senior citizen',
    'osca',
    'pension',
    'financial assistance',
    'waitlist',
    'philsys',
    'gobyerno',
    'matanda',
    'senior'
  ],
  keywords_en = 'dswd social pension indigent senior citizens osca lswdo mswdo quarterly payout stipend waitlist oldest priority philsys national id government assistance',
  keywords_fil = 'dswd social pension indigent senior citizen osca lswdo mswdo quarterly payout stipend waitlist oldest priority philsys national id gobyerno tulong senior pensyon',
  official_sources = '[
    {"title":"DSWD reiterates guidelines, requirements for Social Pension Program for indigent seniors","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-reiterates-guidelines-requirements-for-social-pension-program-for-indigent-seniors/"},
    {"title":"DSWD chief assures indigent seniors without PhilSys ID they can still claim monthly social pension","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-chief-assures-indigent-seniors-without-philsys-id-they-can-still-claim-monthly-social-pension/"},
    {"title":"DSWD 2026 SocPen budget to benefit wait-listed seniors","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswds-2026-socpen-budget-to-benefit-171000-wait-listed-seniors-oldest-indigent-elderly-are-top-priority/"},
    {"title":"Expanded Senior Citizens Act of 2010","publisher":"Official Gazette","url":"https://www.officialgazette.gov.ph/2010/02/15/republic-act-no-9994/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'social-pension-indigent-senior-citizens';

update public.guide_sections
set
  content_en = '{"title":"Social pension is for qualified indigent senior citizens","body":"The DSWD Social Pension Program supports qualified indigent senior citizens. It is not automatic for every senior citizen. DSWD has stated that the stipend is Php1,000 per month and is usually distributed quarterly, but inclusion still depends on official validation, local records, and program lists.","items":["Usually coordinated through OSCA, LGU social welfare offices, and DSWD Field Offices","The program is for indigent seniors, not all senior citizens automatically","Qualified beneficiaries may receive Php1,000 per month, usually released quarterly","Waitlist, validation, and replacement rules may affect timing","Never pay someone promising faster inclusion or guaranteed payout"]}'::jsonb,
  content_fil = '{"title":"Ang social pension ay para sa qualified indigent senior citizens","body":"Ang DSWD Social Pension Program ay para sa qualified indigent senior citizens. Hindi ito automatic para sa lahat ng senior citizen. Ayon sa DSWD, Php1,000 kada buwan ang stipend at kadalasang nire-release quarterly, pero ang inclusion ay depende pa rin sa official validation, local records, at program lists.","items":["Madalas coordinated sa OSCA, LGU social welfare offices, at DSWD Field Offices","Para ito sa indigent seniors, hindi automatic para sa lahat ng senior citizens","Ang qualified beneficiaries ay maaaring makatanggap ng Php1,000 kada buwan, kadalasang quarterly ang release","Maaaring makaapekto ang waitlist, validation, at replacement rules sa timing","Huwag magbayad sa taong nangangakong mapapabilis ang inclusion o guaranteed payout"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'social-pension-indigent-senior-citizens')
  and order_index = 1;

update public.guide_sections
set
  content_en = '{"title":"Prepare the basic requirements before asking","body":"DSWD has said requirements may include a completed social pension application form and a National ID or other government-issued ID. Local offices may still ask for extra proof depending on the case and local records.","step_number":2,"items":["Senior citizen ID, National ID, or another government-issued ID","Completed social pension application form if required by the office","Birthdate proof if the ID is unclear","Complete address and contact number","Proof of no pension or no stable income if requested","Medical, disability, or frailty details if relevant","Representative ID and authorization if a family member will ask or claim"]}'::jsonb,
  content_fil = '{"title":"Ihanda ang basic requirements bago magtanong","body":"Ayon sa DSWD, maaaring kasama sa requirements ang completed social pension application form at National ID o ibang government-issued ID. Maaari pa ring humingi ang local offices ng dagdag na proof depende sa case at local records.","step_number":2,"items":["Senior citizen ID, National ID, o ibang government-issued ID","Completed social pension application form kung hinihingi ng office","Proof ng birthdate kung hindi malinaw sa ID","Kumpletong address at contact number","Proof na walang pension o stable income kung hinihingi","Medical, disability, o frailty details kung relevant","ID ng representative at authorization kung kapamilya ang magtatanong o magke-claim"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'social-pension-indigent-senior-citizens')
  and order_index = 3;

update public.guide_sections
set
  content_en = '{"title":"Ask about validation, waitlist, and payout process","body":"A clearer question helps the office give a useful answer. Ask about requirements, validation schedule, waitlist status, and official payout process. Do not ask a fixer for guaranteed approval.","sample":"Hello. We have a senior citizen aged 60+ with no regular pension or stable income. How can we check the official validation or waitlist status for DSWD Social Pension, what requirements are needed, and where should we verify the payout process?"}'::jsonb,
  content_fil = '{"title":"Itanong ang validation, waitlist, at payout process","body":"Mas helpful ang sagot ng office kapag malinaw ang tanong. Itanong ang requirements, validation schedule, waitlist status, at official payout process. Huwag magtanong sa fixer para sa guaranteed approval.","sample":"Hello po. May senior citizen po kami na 60+ at walang regular pension o stable income. Paano po namin mache-check ang official validation o waitlist status para sa DSWD Social Pension, anong requirements ang kailangan, at saan po dapat i-verify ang payout process?"}'::jsonb
where guide_id = (select id from public.guides where slug = 'social-pension-indigent-senior-citizens')
  and order_index = 5;

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'social-pension-indigent-senior-citizens')
  and order_index in (9, 10);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'tip',
    9,
    '{"title":"If the senior has no PhilSys ID yet","body":"DSWD has stated that indigent senior beneficiaries without a PhilSys ID can still claim their stipend. Do not let anyone use lack of PhilSys ID as a reason to charge a fee or demand personal account details.","items":["Ask what alternative government-issued ID or proof is accepted","Ask the official office, not a random messenger account","Bring available IDs and local records","Never give OTP, PIN, password, or e-wallet login","Keep the official instruction or announcement screenshot"]}'::jsonb,
    '{"title":"Kung wala pang PhilSys ID ang senior","body":"Sinabi ng DSWD na ang indigent senior beneficiaries na walang PhilSys ID ay maaari pa ring mag-claim ng stipend. Huwag hayaang gawing dahilan ng kahit sino ang kawalan ng PhilSys ID para maningil o humingi ng personal account details.","items":["Itanong kung anong alternative government-issued ID o proof ang tinatanggap","Sa official office magtanong, hindi sa random messenger account","Dalhin ang available IDs at local records","Huwag magbigay ng OTP, PIN, password, o e-wallet login","Itabi ang official instruction o announcement screenshot"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'tip',
    10,
    '{"title":"What to expect with waitlists","body":"DSWD has discussed prioritizing the oldest indigent seniors from waitlists and local records. Being qualified does not always mean immediate payout. Ask for the official status and next step instead of relying on rumors.","items":["Ask if the senior is active, waitlisted, for validation, or missing requirements","Ask which office owns the next step: OSCA, LGU social welfare office, or DSWD Field Office","Ask when the next validation or payout announcement is expected","Keep records of the office, date, and instruction received","Do not pay for priority listing"]}'::jsonb,
    '{"title":"Ano ang aasahan sa waitlist","body":"Ayon sa DSWD updates, may prioritization para sa pinakamatatandang indigent seniors mula sa waitlists at local records. Kahit mukhang qualified, hindi laging ibig sabihin immediate payout. Itanong ang official status at next step imbes na umasa sa chismis.","items":["Itanong kung active, waitlisted, for validation, o kulang sa requirements ang senior","Itanong kung aling office ang may next step: OSCA, LGU social welfare office, o DSWD Field Office","Itanong kung kailan inaasahan ang next validation o payout announcement","Itabi ang record ng office, date, at instruction na natanggap","Huwag magbayad para ma-priority sa listahan"]}'::jsonb
  );
