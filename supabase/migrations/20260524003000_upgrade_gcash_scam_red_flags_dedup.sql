update public.guides
set
  title_en = 'GCash scam red flags before you send money',
  title_fil = 'GCash scam signs bago ka magpadala ng pera',
  tagline_en = 'Pause, verify the recipient, and protect OTP, MPIN, and account access before sending money.',
  tagline_fil = 'Huminto muna, i-verify ang recipient, at protektahan ang OTP, MPIN, at account access bago magpadala.',
  read_time_min = 6,
  estimated_time = '5-20 minuto',
  estimated_cost = 'Libre',
  difficulty = 'madali',
  is_urgent = true,
  tags = array['gcash', 'scam', 'money', 'otp', 'mpin', 'phishing', 'online safety', 'fake support'],
  keywords_en = 'gcash scam money otp mpin phishing fake support fake seller wrong send account takeover online safety report scam unauthorized transaction',
  keywords_fil = 'gcash scam pera otp mpin phishing fake support fake seller maling send account takeover online safety report scam unauthorized transaction',
  official_sources = '[
    {"title":"Report a scam","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4413295284377-I-think-I-was-scammed-What-do-I-do"},
    {"title":"Report unauthorized transactions in my GCash account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4416637093145-Report-unauthorized-transactions-in-my-GCash-account"},
    {"title":"How can I protect my GCash account?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/19578518834457-How-can-I-protect-my-GCash-account"}
  ]'::jsonb,
  updated_at = now()
where slug = 'gcash-scam-red-flags';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'gcash-scam-red-flags'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'what_to_know',
    1,
    '{"title":"Most GCash scams use pressure, trust, or fake urgency","body":"Scammers often pretend to be relatives, sellers, buyers, support agents, recruiters, or refund processors. The goal is to make you send money, reveal OTP or MPIN, click a link, or approve a device/account action before you verify.","items":["A real support agent should not ask for OTP or MPIN","A familiar name or profile picture can still be fake or compromised","Screenshots and receipts can be edited","Urgent excuses are used to stop you from thinking","Verify through a separate trusted channel before sending money"]}'::jsonb,
    '{"title":"Kadalasang ginagamit ng GCash scams ang pressure, tiwala, o fake urgency","body":"Madalas magpanggap ang scammers bilang kamag-anak, seller, buyer, support agent, recruiter, o refund processor. Ang goal ay mapadala ka ng pera, OTP o MPIN, mapag-click ng link, o mapa-approve ng device/account action bago ka makapag-verify.","items":["Hindi dapat humingi ng OTP o MPIN ang totoong support","Puwedeng fake o compromised kahit familiar ang pangalan o profile picture","Puwedeng i-edit ang screenshots at receipts","Ginagamit ang urgent excuses para hindi ka makapag-isip","Mag-verify sa hiwalay na trusted channel bago magpadala"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'warning',
    2,
    '{"title":"START HERE: never share OTP, MPIN, password, or screen-sharing access","body":"If someone asks for OTP, MPIN, password, backup code, device registration approval, or screen-sharing, treat it as a scam signal. Stop the transaction and use official GCash support routes only.","severity":"high","items":["OTP or MPIN request","Screen-sharing or remote access request","Link to verify, refund, unlock, or claim money","Processing fee before refund or prize release","Pressure to keep the conversation secret"]}'::jsonb,
    '{"title":"UNAHIN ITO: huwag ibigay ang OTP, MPIN, password, o screen-sharing access","body":"Kung may humihingi ng OTP, MPIN, password, backup code, device registration approval, o screen-sharing, ituring itong scam signal. Itigil ang transaction at official GCash support routes lang ang gamitin.","severity":"high","items":["Hingi ng OTP o MPIN","Hingi ng screen-sharing o remote access","Link para mag-verify, refund, unlock, o claim ng pera","Processing fee bago raw refund o prize release","Pinapasekreto ang usapan"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    3,
    '{"title":"Verify the person or merchant outside the chat","body":"Do not rely on the same chat where the request came from. Use another trusted contact, official shop page, or known phone number before sending money.","step_number":1,"items":["Call the person using a saved trusted number","Check if the merchant has an official page or website","Compare account name, number, and transaction reason","Ask one detail only the real person or seller should know","Do not send if the person refuses verification"]}'::jsonb,
    '{"title":"I-verify ang tao o merchant sa labas ng chat","body":"Huwag umasa sa parehong chat kung saan nanggaling ang request. Gumamit ng ibang trusted contact, official shop page, o kilalang phone number bago magpadala.","step_number":1,"items":["Tawagan ang tao gamit ang saved trusted number","I-check kung may official page o website ang merchant","I-compare ang account name, number, at dahilan ng transaction","Magtanong ng isang detail na dapat alam lang ng totoong tao o seller","Huwag magpadala kung ayaw magpa-verify"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    4,
    '{"title":"Check the red flags before sending","body":"One red flag is enough to pause. Two or more red flags means you should stop and verify through official or trusted routes first.","step_number":2,"items":["Rush: send now, emergency, last slot, final warning","Secrecy: do not tell family, bank, or support","Fee: pay first before refund, prize, job, or loan release","Link: login, verify, claim, or unlock through a sent link","Mismatch: account name, story, number, or page details do not match"]}'::jsonb,
    '{"title":"I-check ang red flags bago magpadala","body":"Isang red flag pa lang, sapat na para huminto muna. Kapag dalawa o higit pa, itigil at mag-verify muna sa official o trusted routes.","step_number":2,"items":["Rush: send now, emergency, last slot, final warning","Secrecy: huwag sabihin sa family, bank, o support","Fee: bayad muna bago refund, prize, trabaho, o loan release","Link: login, verify, claim, o unlock gamit ang pinadalang link","Mismatch: hindi tugma ang account name, kwento, number, o page details"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    5,
    '{"title":"If you already sent money or entered details","body":"Act quickly. Save evidence, report through official GCash support, and secure account access. Do not pay anyone promising guaranteed recovery.","step_number":3,"items":["Take screenshots of chat, profile, number, QR, link, and receipt","Report the scam or unauthorized transaction through official GCash Help Center","Change MPIN/password from the official app if needed","Do not send OTP, MPIN, or more money to recovery helpers","Warn close contacts if your account or identity may be misused"]}'::jsonb,
    '{"title":"Kung nakapagpadala ka na o nakapaglagay ng details","body":"Kumilos agad. I-save ang ebidensya, mag-report sa official GCash support, at i-secure ang account access. Huwag magbayad sa nangangako ng guaranteed recovery.","step_number":3,"items":["I-screenshot ang chat, profile, number, QR, link, at receipt","I-report ang scam o unauthorized transaction sa official GCash Help Center","Palitan ang MPIN/password sa official app kung kailangan","Huwag magbigay ng OTP, MPIN, o dagdag pera sa recovery helpers","I-warning ang close contacts kung puwedeng ma-misuse ang account o identity mo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'mistake',
    6,
    '{"title":"Common mistakes that make GCash scams worse","body":"Most damage grows when people panic, hide the incident, or trust another unofficial helper after the first scam.","items":["Sending a second payment to fix the first problem","Posting full transaction details publicly","Deleting chat before saving evidence","Believing edited screenshots or fake receipts","Trusting comments that say they can recover funds for a fee","Waiting too long before reporting unauthorized transactions"]}'::jsonb,
    '{"title":"Karaniwang pagkakamali na nagpapalala ng GCash scams","body":"Mas lumalaki ang damage kapag nagpapanic, tinatago ang nangyari, o nagtitiwala ulit sa unofficial helper pagkatapos ng unang scam.","items":["Nagpapadala ng pangalawang bayad para ayusin daw ang unang problema","Pinopost publicly ang full transaction details","Binubura ang chat bago mag-save ng ebidensya","Naniniwala sa edited screenshots o fake receipts","Nagtitiwala sa comments na kaya raw i-recover ang funds kapalit ng fee","Masyadong matagal bago mag-report ng unauthorized transactions"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'tip',
    7,
    '{"title":"Sample message before sending money","body":"Use a direct verification message. A real person or merchant should not be offended by basic safety checks.","sample":"Before I send, please confirm the exact amount, reason, account name, and one detail from our previous transaction/conversation. I will also verify through your official page or saved number first."}'::jsonb,
    '{"title":"Sample message bago magpadala ng pera","body":"Diretsong verification message ang gamitin. Hindi dapat ma-offend ang totoong tao o merchant sa basic safety check.","sample":"Bago po ako mag-send, paki-confirm ang exact amount, reason, account name, at isang detail mula sa previous transaction/conversation natin. I-ve-verify ko rin muna sa official page o saved number ninyo."}'::jsonb
  );
