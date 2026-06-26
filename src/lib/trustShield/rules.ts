import type {
  LocalizedTrustDecisionRule,
  LocalizedTrustScenario,
} from './types'

export const trustShieldScenarios: LocalizedTrustScenario[] = [
  {
    id: 'otp_request',
    label_en: 'Someone asked for OTP or approval',
    label_fil: 'May nanghingi ng OTP o approval',
    short_en: 'Codes, passkeys, prompts, screen sharing, or device registration',
    short_fil: 'Code, passkey, prompt, screen sharing, o device registration',
  },
  {
    id: 'advance_payment',
    label_en: 'Someone wants advance payment',
    label_fil: 'May nanghihingi ng advance payment',
    short_en: 'Reservation, deposit, processing fee, or trust money',
    short_fil: 'Reservation, deposit, processing fee, o tiwala money',
  },
  {
    id: 'suspicious_link',
    label_en: 'Suspicious link',
    label_fil: 'Kahina-hinalang link',
    short_en: 'Promo, account warning, delivery, or login link',
    short_fil: 'Promo, account warning, delivery, o login link',
  },
  {
    id: 'bank_ewallet_message',
    label_en: 'Bank/e-wallet message',
    label_fil: 'Bank/e-wallet message',
    short_en: 'Caller, text, or chat claims to be official support',
    short_fil: 'Tumawag, nag-text, o nag-chat bilang official support',
  },
]

export const trustShieldRules: LocalizedTrustDecisionRule[] = [
  {
    id: 'otp_request',
    situation_en: 'Someone is asking for your OTP, approval, passkey, PIN, password, or screen sharing.',
    situation_fil: 'May nanghihingi ng OTP, approval, passkey, PIN, password, o screen sharing.',
    riskLevel: 'HIGH_RISK',
    why_en:
      'Banks and e-wallets are moving away from SMS/email OTPs for high-risk transactions by June 30, 2026, but the safety rule stays the same: never share or approve unknown access. OTPs, passkeys, prompts, and device registration can let someone move money or take over your account.',
    why_fil:
      'Lumalayo na ang banks at e-wallets sa SMS/email OTP para sa high-risk transactions pagsapit ng June 30, 2026, pero pareho pa rin ang safety rule: huwag mag-share o mag-approve ng unknown access. Ang OTP, passkey, prompt, at device registration ay puwedeng gamitin para makagalaw ng pera o makuha ang account mo.',
    warningSigns_en: [
      'They ask for an OTP, PIN, password, passkey, approval code, or device registration.',
      'They ask you to approve an in-app prompt you did not start.',
      'They want you to share your screen or install a remote access app.',
      'They say they are from a bank, GCash, Maya, or support and pressure you to act quickly.',
    ],
    warningSigns_fil: [
      'Humihingi sila ng OTP, PIN, password, passkey, approval code, o device registration.',
      'Pinapa-approve ka nila ng in-app prompt na hindi ikaw ang nagsimula.',
      'Gusto nilang i-share mo ang screen mo o mag-install ng remote access app.',
      'Sabi nila galing sila sa bank, GCash, Maya, o support at minamadali ka.',
    ],
    recommendedAction_en: [
      'Do not share codes, PINs, passwords, passkeys, or approval prompts.',
      'Do not approve prompts or device registrations you did not start.',
      'Stop screen sharing immediately.',
      'End the call or chat.',
      'Open the official app or hotline yourself and check alerts.',
      'Change your password, MPIN, or passkey settings if you already shared or approved anything.',
    ],
    recommendedAction_fil: [
      'Huwag ibigay ang code, PIN, password, passkey, o approval prompt.',
      'Huwag mag-approve ng prompt o device registration na hindi ikaw ang nagsimula.',
      'Itigil agad ang screen sharing.',
      'Tapusin ang tawag o chat.',
      'Ikaw mismo ang magbukas ng official app o hotline at i-check ang alerts.',
      'Palitan ang password, MPIN, o passkey settings kung may naibigay o na-approve ka na.',
    ],
    relatedGuides: [
      'phishing-link-checklist',
      'gcash-maya-account-recovery-first-hour',
      'gcash-scam-red-flags',
    ],
    sources_en: [
      'Official bank or e-wallet support channels',
      'BSP consumer protection reminders',
      'BSP context on moving away from SMS/email OTPs for high-risk transactions by June 30, 2026',
    ],
    sources_fil: [
      'Official bank o e-wallet support channels',
      'BSP consumer protection reminders',
      'BSP context sa paglipat palayo sa SMS/email OTP para sa high-risk transactions pagsapit ng June 30, 2026',
    ],
    recoverySteps_en: [
      'Secure the account first.',
      'Remove unknown devices or passkeys if the app shows them.',
      'Preserve screenshots and transaction alerts.',
      'Report through official support channels.',
    ],
    recoverySteps_fil: [
      'I-secure muna ang account.',
      'Tanggalin ang unknown devices o passkeys kung makikita sa app.',
      'I-save ang screenshots at transaction alerts.',
      'Mag-report sa official support channels.',
    ],
    shareText_en:
      'Reminder: Never share OTPs, PINs, passwords, passkeys, approval codes, or approve unknown prompts. Real support will not need them.',
    shareText_fil:
      'Paalala: Huwag mag-share ng OTP, PIN, password, passkey, approval code, o mag-approve ng unknown prompt. Hindi ito kailangan ng tunay na support.',
  },
  {
    id: 'advance_payment',
    situation_en: 'Someone wants money first before giving the item, job, help, or service.',
    situation_fil: 'May nanghihingi muna ng pera bago ibigay ang item, trabaho, tulong, o serbisyo.',
    riskLevel: 'VERIFY_FIRST',
    why_en:
      'Advance payment is not always a scam, but it becomes risky when the seller, recruiter, or helper cannot be verified through trusted channels.',
    why_fil:
      'Hindi laging scam ang advance payment, pero delikado kapag hindi ma-verify ang seller, recruiter, o helper sa trusted channels.',
    warningSigns_en: [
      'They ask for a reservation, processing fee, trust deposit, or unlock fee.',
      'They refuse meetups, receipts, official pages, or verifiable identity.',
      'They use urgency: "last slot," "today only," or "send now."',
    ],
    warningSigns_fil: [
      'Humihingi sila ng reservation, processing fee, trust deposit, o unlock fee.',
      'Ayaw nila ng meetup, resibo, official page, o verifiable identity.',
      'May pressure: "last slot," "today only," o "send now."',
    ],
    recommendedAction_en: [
      'Pause before paying.',
      'Verify the person or page outside the chat.',
      'Ask for official receipt, registered business details, or safer payment terms.',
      'If it is a job or scholarship offer, never pay just to apply.',
    ],
    recommendedAction_fil: [
      'Huminto muna bago magbayad.',
      'I-verify ang tao o page sa labas ng chat.',
      'Humingi ng official receipt, registered business details, o mas ligtas na payment terms.',
      'Kung job o scholarship offer ito, huwag magbayad para lang makapag-apply.',
    ],
    relatedGuides: [
      'fake-job-offer-red-flags',
      'gcash-scam-red-flags',
      'loan-red-flags-before-borrowing',
    ],
    sources_en: [
      'Official company, school, or agency channels',
      'SEC/DTI verification when a business or lending offer is involved',
    ],
    sources_fil: [
      'Official company, school, o agency channels',
      'SEC/DTI verification kapag business o lending offer ang involved',
    ],
    shareText_en:
      'Before paying a deposit or processing fee, verify outside the chat and avoid rushed payment.',
    shareText_fil:
      'Bago magbayad ng deposit o processing fee, mag-verify sa labas ng chat at iwasan ang minamadaling bayad.',
  },
  {
    id: 'suspicious_link',
    situation_en: 'Someone sent a link and wants you to log in, claim, verify, or update details.',
    situation_fil: 'May nagpadala ng link at gusto kang mag-login, mag-claim, mag-verify, o mag-update ng details.',
    riskLevel: 'HIGH_RISK',
    why_en:
      'Suspicious links can steal passwords, OTPs, card details, or account access. The message may look official even when the site is fake.',
    why_fil:
      'Puwedeng magnakaw ng password, OTP, card details, o account access ang kahina-hinalang link. Puwedeng magmukhang official ang message kahit fake ang site.',
    warningSigns_en: [
      'The link came from chat, SMS, or a shortened URL.',
      'It asks for OTP, MPIN, password, card details, or ID photos.',
      'It threatens account closure or promises a reward.',
    ],
    warningSigns_fil: [
      'Galing sa chat, SMS, o shortened URL ang link.',
      'Humihingi ito ng OTP, MPIN, password, card details, o ID photos.',
      'May pananakot na ma-close ang account o pangakong reward.',
    ],
    recommendedAction_en: [
      'Do not open or enter details.',
      'Go to the official app or website manually.',
      'If you already clicked, change passwords and secure accounts.',
      'Warn family or classmates if the link is spreading.',
    ],
    recommendedAction_fil: [
      'Huwag buksan o maglagay ng details.',
      'Mano-manong pumunta sa official app o website.',
      'Kung na-click mo na, palitan ang passwords at i-secure ang accounts.',
      'Sabihan ang family o classmates kung kumakalat ang link.',
    ],
    relatedGuides: [
      'phishing-link-checklist',
      'gcash-maya-account-recovery-first-hour',
      'gcash-scam-red-flags',
    ],
    sources_en: [
      'Official app or website typed manually',
      'Official support channels for the affected account',
    ],
    sources_fil: [
      'Official app o website na ikaw mismo ang nag-type',
      'Official support channels ng affected account',
    ],
    recoverySteps_en: [
      'Disconnect from the suspicious page.',
      'Change passwords from the official app or site.',
      'Check recent transactions and login alerts.',
    ],
    recoverySteps_fil: [
      'Umalis sa suspicious page.',
      'Palitan ang password mula sa official app o site.',
      'I-check ang recent transactions at login alerts.',
    ],
    shareText_en:
      'Do not enter OTPs, passwords, or card details through links sent by chat or SMS.',
    shareText_fil:
      'Huwag maglagay ng OTP, password, o card details sa links na pinadala sa chat o SMS.',
  },
  {
    id: 'bank_ewallet_message',
    situation_en: 'A message or caller claims to be from a bank, GCash, Maya, or e-wallet support.',
    situation_fil: 'May message o tumatawag na nagsasabing galing sa bank, GCash, Maya, o e-wallet support.',
    riskLevel: 'VERIFY_FIRST',
    why_en:
      'Real support teams may contact users, but scammers copy names, logos, caller IDs, and scripts. Verification must happen through official channels you open yourself.',
    why_fil:
      'Puwedeng may tunay na support na kokontak sa users, pero ginagaya ng scammers ang pangalan, logo, caller ID, at script. Dapat ikaw mismo ang mag-verify sa official channels.',
    warningSigns_en: [
      'They ask for OTP, MPIN, password, card number, or remote access.',
      'They say your account will be blocked unless you act now.',
      'They move the conversation to a personal number or chat app.',
    ],
    warningSigns_fil: [
      'Humihingi sila ng OTP, MPIN, password, card number, o remote access.',
      'Sabi nila maba-block ang account kung hindi ka kikilos agad.',
      'Nililipat nila ang usapan sa personal number o chat app.',
    ],
    recommendedAction_en: [
      'Do not answer security questions in the call or chat.',
      'Close the message and open the official app or hotline yourself.',
      'Check alerts and transaction history.',
      'Report impersonation if they asked for codes or money.',
    ],
    recommendedAction_fil: [
      'Huwag sagutin ang security questions sa tawag o chat.',
      'Isara ang message at ikaw mismo ang magbukas ng official app o hotline.',
      'I-check ang alerts at transaction history.',
      'I-report ang impersonation kung nanghingi sila ng code o pera.',
    ],
    relatedGuides: [
      'gcash-scam-red-flags',
      'gcash-maya-account-recovery-first-hour',
      'phishing-link-checklist',
    ],
    sources_en: [
      'Official bank or e-wallet app',
      'Official hotline or verified support page',
    ],
    sources_fil: [
      'Official bank o e-wallet app',
      'Official hotline o verified support page',
    ],
    recoverySteps_en: [
      'Secure e-wallet, email, and SIM access.',
      'Preserve the number, screenshots, and transaction alerts.',
      'Report through official support.',
    ],
    recoverySteps_fil: [
      'I-secure ang e-wallet, email, at SIM access.',
      'I-save ang number, screenshots, at transaction alerts.',
      'Mag-report sa official support.',
    ],
    shareText_en:
      'Verify bank or e-wallet messages only through official apps, hotlines, or verified support pages.',
    shareText_fil:
      'I-verify ang bank o e-wallet messages gamit lang ang official app, hotline, o verified support page.',
  },
]
