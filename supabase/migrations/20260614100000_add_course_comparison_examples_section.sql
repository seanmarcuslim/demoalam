do $migration$
declare
  target_guide_id uuid;
begin
  select id
  into target_guide_id
  from public.guides
  where slug = 'compare-3-course-options-checklist';

  if target_guide_id is null then
    raise exception 'Guide compare-3-course-options-checklist not found';
  end if;

  if not exists (
    select 1
    from public.guide_sections
    where guide_id = target_guide_id
      and content_en->>'title' = 'Start with real course options, not a blank page'
  ) then
    update public.guide_sections
    set order_index = order_index + 1
    where guide_id = target_guide_id
      and order_index >= 4;

    insert into public.guide_sections (
      guide_id,
      section_type,
      order_index,
      content_en,
      content_fil
    )
    values (
      target_guide_id,
      'tip',
      4,
      $json${
        "title":"Start with real course options, not a blank page",
        "body":"These are not final recommendations. Use them as starting examples so you can compare real paths instead of staring at an empty list. Pick three that honestly fit your situation, then test them using cost, daily work, skills, and backup paths.",
        "items":[
          "People / helping: Education, Psychology, Social Work, Public Administration, HR-related business courses, TESDA caregiving or community-service training",
          "Technical / systems: Information Technology, Computer Science, Engineering, Electronics, Automotive, Electrical Installation, Computer Systems Servicing",
          "Creative / communication: Communication, Multimedia Arts, Design-related programs, Architecture, content or digital media paths",
          "Business / operations: Accountancy, Business Administration, Entrepreneurship, Office Administration, Tourism, Hospitality, logistics or operations paths",
          "Care / public service: Nursing, Midwifery, Medical Technology, Radiologic Technology, Criminology, Social Work, emergency or safety-related training",
          "Faster skills path: TESDA courses, short certifications, apprenticeships, portfolio-based skills, or work-study options"
        ]
      }$json$::jsonb,
      $json${
        "title":"Magsimula sa totoong course options, hindi blank page",
        "body":"Hindi final recommendations ang listahang ito. Starting examples ito para may totoong paths kang maikumpara, hindi blangkong papel lang. Pumili ng tatlong honest na bagay sa sitwasyon mo, tapos i-test gamit ang gastos, daily work, skills, at backup paths.",
        "items":[
          "People / helping: Education, Psychology, Social Work, Public Administration, HR-related business courses, TESDA caregiving o community-service training",
          "Technical / systems: Information Technology, Computer Science, Engineering, Electronics, Automotive, Electrical Installation, Computer Systems Servicing",
          "Creative / communication: Communication, Multimedia Arts, design-related programs, Architecture, content o digital media paths",
          "Business / operations: Accountancy, Business Administration, Entrepreneurship, Office Administration, Tourism, Hospitality, logistics o operations paths",
          "Care / public service: Nursing, Midwifery, Medical Technology, Radiologic Technology, Criminology, Social Work, emergency o safety-related training",
          "Faster skills path: TESDA courses, short certifications, apprenticeships, portfolio-based skills, o work-study options"
        ]
      }$json$::jsonb
    );
  end if;

  update public.guides
  set
    keywords_en = keywords_en || ' course examples course options nursing criminology accountancy it computer science education psychology tesda caregiving hospitality tourism engineering multimedia arts',
    keywords_fil = keywords_fil || ' course examples course options nursing criminology accountancy it computer science education psychology tesda caregiving hospitality tourism engineering multimedia arts anong course',
    updated_at = now()
  where id = target_guide_id;
end $migration$;
