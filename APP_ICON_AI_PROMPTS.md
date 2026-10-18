# App Icon Generation Prompts — Ayez Ahlaq (عايز أحلق)

جاهزين تلصقهم في أي أداة AI image generation (Midjourney, DALL-E, Ideogram, إلخ). كل برومبت بيطلع صورة مربعة 1024×1024px — الأصل الأساسي (master) اللي منه هتتقص كل مقاسات iOS وAndroid بعدين.

**مهم قبل ما تولّد:** سيب هامش أمان (safe zone) — الشعار والحرف "ع" لازم يكونوا في المنتصف، متلزقينش على الحواف، لأن:
- **iOS**: بيدوّر الزوايا أوتوماتيك (rounded square) — أي حاجة قريبة من الزوايا هتتقص شكلها.
- **Android (adaptive icon)**: بيقص لدائرة أو مربع بزوايا دائرية حسب جهاز المستخدم — أي حاجة في أطراف الصورة ممكن تختفي تمامًا. المساحة الآمنة الفعلية هي أصغر دايرة جوه المربع (تقريبًا 66% من المساحة في النص).

---

## Prompt 1 — Dark icon (الافتراضي / الأساسي)

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: a pair of open barber scissors, crossed in an X shape, rendered in a warm brass-gold gradient — lightest gold #E3C273 at the tip highlights, transitioning through #D9AE49 and #C6982F, to a deeper shade #A97F26 at the shadow edges. Metallic but flat/vector style, not photorealistic — clean geometric shapes, smooth gradient, soft highlight along the blade edge.

Below or integrated near the scissors, a single Arabic letter "ع" (ain) in the same brass-gold gradient family, bold, geometric Arabic calligraphic style, simple enough to stay legible at small sizes (down to 48px) — NOT a full word, just the one letter, positioned so it reads as a small mark/monogram rather than a text label. Keep it minimal, iconic, not a literal typographic wordmark.

Critical safe-zone requirement: keep the entire scissors + letter composition within the center 70% of the canvas, with generous even padding on all four sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle.

Style: premium barbershop aesthetic, warm and elegant, not flat corporate tech style — think old-school gold-leaf signage crossed with modern flat vector icon design. High contrast between the gold mark and the dark background. No text other than the single "ع" letter. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the scissors mark, the letter, and the gradient background.
```

---

## Prompt 2 — Light icon (البديل الفاتح)

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: warm sand/off-white, radial gradient from #FBF8F2 center to #F5F0E5 edges — soft, warm ivory tone, not stark pure white, not cold gray.

Center composition: a pair of open barber scissors, crossed in an X shape, rendered in a darker brass-gold gradient for contrast against the light background — from #B98D22 at the highlight edges through #8F6C1F mid-tone to #5E4714 at the deepest shadow areas. Flat/vector style, not photorealistic — clean geometric shapes, smooth gradient, soft highlight along the blade edge, same silhouette and proportions as the dark variant of this icon (same scissors shape, just recolored for light background contrast).

Below or integrated near the scissors, a single Arabic letter "ع" (ain) in the same darker brass-gold gradient family (#8F6C1F range), bold, geometric Arabic calligraphic style, simple enough to stay legible at small sizes (down to 48px) — NOT a full word, just the one letter, positioned so it reads as a small mark/monogram rather than a text label. Keep it minimal, iconic, not a literal typographic wordmark.

Critical safe-zone requirement: keep the entire scissors + letter composition within the center 70% of the canvas, with generous even padding on all four sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle.

Style: premium barbershop aesthetic, warm and elegant, not flat corporate tech style — think old-school gold-leaf signage crossed with modern flat vector icon design. Strong contrast between the dark gold mark and the light warm background. No text other than the single "ع" letter. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the scissors mark, the letter, and the gradient background.
```

---

## Prompt 3 — Dark icon, no lettering (mark only)

نفس تكوين المقص والألوان، بس من غير حرف "ع" خالص — الأيقونة نفسها هي العلامة، من غير أي نص.

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: a pair of open barber scissors, crossed in an X shape, rendered in a warm brass-gold gradient — lightest gold #E3C273 at the tip highlights, transitioning through #D9AE49 and #C6982F, to a deeper shade #A97F26 at the shadow edges. Metallic but flat/vector style, not photorealistic — clean geometric shapes, smooth gradient, soft highlight along the blade edge. This is the ONLY element in the composition — no letters, no text, no monogram, no additional symbols.

Critical safe-zone requirement: keep the scissors mark within the center 70% of the canvas, with generous even padding on all four sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle.

Style: premium barbershop aesthetic, warm and elegant, not flat corporate tech style — think old-school gold-leaf signage crossed with modern flat vector icon design. High contrast between the gold mark and the dark background. Absolutely no text or lettering anywhere in the image. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the scissors mark and the gradient background.
```

**Light variant (نفس اللوجيك، من غير حرف):** خد Prompt 2 فوق واحذف الفقرة اللي فيها "ع" منه، وضيف بدالها "This is the ONLY element in the composition — no letters, no text, no monogram, no additional symbols." زي ما فوق بالظبط.

---

## Prompt 4 — Dark icon, straight razor mark (بدل المقص)

موس حلاقة (straight razor / cut-throat razor) بدل المقص — شكل تاني قوي وواضح في الأحجام الصغيرة، وله دلالة barbershop قديمة وأنيقة (زي لافتات الحلاقين الكلاسيكية).

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: a classic straight razor (cut-throat razor), shown open/unfolded at a slight diagonal angle, blade pointing up-right, handle pointing down-left. Rendered in a warm brass-gold gradient — lightest gold #E3C273 along the blade's cutting edge highlight, transitioning through #D9AE49 and #C6982F across the blade body, to a deeper shade #A97F26 on the handle and shadow areas. The handle can have a subtle darker brown/ink accent (#3E362B) to distinguish it from the blade, like a wood or horn handle. Flat/vector style, not photorealistic — clean geometric shapes, smooth gradient, a single soft highlight line along the blade edge to suggest sharpness and metal.

Critical safe-zone requirement: keep the entire razor silhouette within the center 70% of the canvas, with generous even padding on all four sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle. The diagonal angle should still read clearly and balanced within a square frame, not feel cramped into a corner.

Style: premium old-school barbershop aesthetic, warm and elegant, not flat corporate tech style — think vintage gold-leaf barber signage crossed with modern flat vector icon design. High contrast between the gold mark and the dark background. No text, no lettering, no additional symbols. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the razor mark and the gradient background.
```

**Light variant:** نفس التكوين، بس الخلفية `#FBF8F2` → `#F5F0E5` (رملي فاتح) والموس بتدرج ذهبي أغمق `#B98D22` → `#8F6C1F` → `#5E4714` — بنفس المنطق اللي في Prompt 2.

---

## Prompt 5 — Dark icon, barber pole (اتجاه مختلف خالص — مش أداة حلاقة)

بدل ما نركّز على أداة معينة (مقص/موس)، ده رمز الحلاقة العالمي نفسه: **عمود الحلاقة الملوّن (barber pole)** — أي حد في أي بلد يشوفه يعرف على طول إنها حلاقة، من غير ما يحتاج يتعرف على شكل أداة بعينها. هنا بألوان البراند الذهبي/الأسود بدل الأحمر-أزرق-أبيض التقليدي، عشان يفضل مطابق للهوية.

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: a classic barber pole, shown as a simplified flat vector cylinder standing upright, with the traditional diagonal spiral stripe pattern. Instead of the usual red-white-blue, use the brand's warm palette: alternating diagonal stripes of brass-gold gradient (#E3C273 to #C6982F to #A97F26) and warm ivory (#F3ECDD), spiraling around the cylinder body. The pole has simple rounded cap details at the top and bottom in a deeper gold tone (#8F6C1F), like small dome finials. Flat/vector geometric style, not photorealistic — clean shapes, smooth gradients within each stripe, no glossy 3D rendering.

Critical safe-zone requirement: keep the entire pole silhouette (including top and bottom caps) within the center 65% of the canvas height, with generous even padding on all sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle. The pole should be tall enough to read clearly as a barber pole but not so tall it feels cramped against the top/bottom edges.

Style: premium barbershop aesthetic, warm and elegant, not flat corporate tech style — think vintage gold-leaf barbershop signage crossed with modern flat vector icon design. High contrast between the gold/ivory pole and the dark background. No text, no lettering, no additional symbols. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the barber pole mark and the gradient background.
```

**Light variant:** نفس التكوين، الخلفية `#FBF8F2` → `#F5F0E5` (رملي فاتح)، والعمود بنفس تبادل الشرائط بس الذهب أغمق شوية (`#B98D22` → `#8F6C1F` → `#5E4714`) عشان يبين على الخلفية الفاتحة، والشرائط التانية تبقى لون `#1C1916` غامق بدل الـ ivory الفاتح — نفس منطق باقي الـ prompts.

**لو عايز الاسم "ع" جوه العمود ده كمان:** ضيف الفقرة دي بعد فقرة الـ Center composition:
> A single Arabic letter "ع" (ain) in a warm ivory tone (#F3ECDD), small and centered on the pole's middle section, bold and simple enough to stay legible at 48px, blended naturally into the stripe pattern rather than floating on top of it.

---

## Prompt 6 — Dark icon, simple gold ring/dot mark (شكل بسيط جدًا وواضح — زي seal/stamp)

مفيش أداة، مفيش عمود، مفيش تعقيد — دايرة واحدة بسيطة بتدرج ذهبي، بإحساس ختم/seal فاخر، زي شعارات البراندات الفاخرة (دايرة واحدة نضيفة، مش شكلين متداخلين).

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: a single simple ring (circle outline, not filled), thick and confident stroke width (about 8% of the circle's diameter), rendered in a warm brass-gold gradient — lightest gold #E3C273 at the top, transitioning smoothly through #D9AE49 and #C6982F, to a deeper shade #A97F26 at the bottom, like a gold seal or coin edge catching light from above. Perfectly centered, perfectly round, no other shapes overlapping it — just one clean ring. Flat vector style, smooth gradient around the ring, no 3D bevel, no glossy highlight spots, just the gradient itself suggesting dimension.

Critical safe-zone requirement: keep the ring within the center 60% of the canvas, centered, with generous even padding on all sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle.

Style: premium, minimal, confident luxury brand seal aesthetic — think a wax seal or a coin emblem, extremely simple and instantly recognizable even at 48px. Warm and elegant, not flat corporate tech style, not playful. High contrast between the gold ring and the dark background. No text, no lettering, no recognizable object (no scissors, no razor, no pole, no comb). No photographic textures, no drop shadows outside the ring itself, no background patterns or extra elements — just the single gold ring and the gradient background.
```

**Light variant:** نفس التكوين بالظبط، الخلفية `#FBF8F2` → `#F5F0E5` (رملي فاتح)، والدايرة بتدرج ذهبي أغمق `#B98D22` → `#8F6C1F` → `#5E4714` عشان تبين بوضوح على الخلفية الفاتحة.

---

## Prompt 7 — Dark icon, abstract geometric مبني على حرف "ع" منحوت هندسيًا

لو حابب الشكل يفضل مجرد بصريًا بس يحمل معنى الاسم من غير ما يبقى "حرف مكتوب" واضح — الحرف "ع" بيتحوّل لشكل هندسي مجرد (منحنيين متقاطعين) بدل خط calligraphy عادي، فيبقى حد يعرف إنه "ع" لو دقّق، لكن أول وهلة هو شكل تجريدي أنيق.

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: an abstract geometric interpretation of the Arabic letter "ع" (ain) — reduced to its core structural gesture: a large open curve sweeping from upper-right down and around to a small closed loop at the bottom-left, rendered not as handwritten calligraphy but as a bold, confident geometric ribbon shape with consistent stroke width, in a warm brass-gold gradient (#E3C273 to #D9AE49 to #C6982F to #A97F26 along the curve's length, lightest at the top, deepest at the bottom loop). The shape should read first as an elegant abstract swoosh/mark, with the letter identity as a secondary discovery, not an obvious text label. Flat vector style, smooth continuous curve, consistent ribbon width throughout, no serif or calligraphic flourishes.

Critical safe-zone requirement: keep the entire mark within the center 65% of the canvas, centered, with generous even padding on all sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle.

Style: premium, minimal, modern luxury brand aesthetic — think a boutique fashion house monogram, confident and abstract rather than a literal typographic letter. Warm and elegant, not flat corporate tech style. High contrast between the gold mark and the dark background. No additional text beyond this single abstracted mark. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the abstract gold mark and the gradient background.
```

**Light variant:** نفس التكوين، الخلفية `#FBF8F2` → `#F5F0E5`، والشكل بتدرج ذهبي أغمق `#B98D22` → `#8F6C1F` → `#5E4714`.

---

## Prompt 8 — Dark icon, barber chair silhouette (رمز مباشر ومفهوم فورًا — زي أيقونات تطبيقات الحجز)

مش أداة حلاقة، ومش شكل مجرد لخبط — **كرسي الحلاقة نفسه**، رمز واضح ومباشر بيقول "حجز عند حلاق" من أول نظرة، بسيط بصريًا زي دايرة لكن معناه فوري ومفهوم لأي حد، زي الأيقونات اللي بتشوفها في تطبيقات حجز الصالونات.

```
Flat vector app icon design, 1024x1024px, square canvas, no rounded corners in the artwork itself (platform will apply masking).

Background: deep warm near-black charcoal, radial gradient from #1C1916 center to #14120F edges — subtle, not flat, warm undertone not cold blue-black.

Center composition: a simplified, iconic side-view silhouette of a classic barber chair — the kind with a high curved backrest, a seat, armrests, and a pedestal base, reduced to its most recognizable flat shapes (think the universal "barber chair" icon used in booking apps, but redrawn with premium detailing). Rendered as a solid flat silhouette filled with a warm brass-gold gradient — lightest gold #E3C273 at the top of the backrest, transitioning through #D9AE49 and #C6982F through the seat, to a deeper #A97F26 at the base. Clean, confident, simplified shapes — no fabric texture, no upholstery detail, no small parts like levers or wheels. Just the iconic silhouette everyone recognizes instantly as a barber/salon chair.

Critical safe-zone requirement: keep the entire chair silhouette within the center 65% of the canvas, centered, with generous even padding on all sides — nothing should touch or extend near any edge or corner, since iOS will round the corners and Android will crop to a circle or squircle.

Style: premium barbershop aesthetic, warm and elegant, not flat corporate tech style, not a cheap generic app-icon clipart look — think a boutique salon's refined take on a familiar symbol. High contrast between the gold silhouette and the dark background. No text, no lettering, no additional symbols. No photographic textures, no drop shadows outside the mark itself, no background patterns or extra elements — just the chair silhouette and the gradient background.
```

**Light variant:** نفس التكوين، الخلفية `#FBF8F2` → `#F5F0E5` (رملي فاتح)، والكرسي بتدرج ذهبي أغمق `#B98D22` → `#8F6C1F` → `#5E4714`.

---

## بعد ما تولّد الصورتين

1. تأكد الاتنين نفس التكوين بالظبط (نفس مكان المقص، نفس مكان الحرف) — الفرق بينهم لازم يكون بس في الألوان، عشان الأيقونتين يتقروا كأنهم نفس البراند في وضعين مختلفين.
2. لو الأداة رجعت الصورة بزوايا مدورة أو خلفية شفافة، اطلب نسخة "square, no transparency, no rounded corners" عشان الماستر يبقى مربع كامل 100%.
3. الملف الحالي للأيقونة في المشروع: `assets/images/app_icon.png` (1024×1024) — هيتستبدل بالماستر الجديد.
4. لسه مفيش أداة `flutter_launcher_icons` متظبطة في المشروع، فالمقاسات بتتحط يدوي في:
   - iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/` (حاليًا مقاس واحد بس 1024×1024 اسمه `icon-ios-1024.png` — مفيش مقاسات تانية متطلوبة هناك دلوقتي)
   - Android: `android/app/src/main/res/mipmap-*/` (5 مجلدات بكثافات مختلفة: mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi، كل واحد فيه `ic_launcher.webp` و`ic_launcher_round.webp` و`ic_launcher_foreground.webp`)
   
   قولّي لو عايزني أضيف `flutter_launcher_icons` package وأعمل السكريبت اللي بياخد الماستر 1024×1024 ويولّد كل المقاسات دي أوتوماتيك بدل التعامل اليدوي.
