# Team API — คู่มืออ้างอิง

ใช้ผ่าน `kol.sh` เท่านั้น (ต้องมีคีย์ส่วนตัว)

- ไม่มีราคา / ค่าตัว / QO ในข้อมูลนี้ — ถามราคาให้ติดต่อทีม KOL
- ห้ามส่งรายชื่อออกนอกบริษัท
- คีย์เป็นของแต่ละคน ห้ามแชร์ (ถูกปิดได้ทันที)

## เรียกใช้

`kol.sh <function> '<json>'` — ที่อยู่ API และ apikey อยู่ใน `config.json`

### 1) `kol_count` — นับจำนวน (ไม่จำกัด, ไม่มีรายชื่อ)

```json
{"p_key": "njk_...", "p_filters": {"category": ["Automobiles"], "vehicle": ["รถยนต์"]}, "p_group": "tier"}
```
`p_group` (ไม่ใส่ก็ได้): `tier` `grade` `region` `province` `vehicle` `brand_ok` `brand_level` `trend`

### 2) `kol_search` — รายชื่อ (สูงสุด 50 คน/ครั้ง)

```json
{"p_key": "njk_...", "p_filters": {"category": ["Food"], "tier": ["Micro"], "region": ["อีสาน"], "brand_ok": "ใช่"},
 "p_limit": 30, "p_sort": "score"}
```
`p_sort`: `score` (ค่าเริ่มต้น) `median_views` `er` `followers`

### 3) `kol_lookalike` — KOL ที่คล้ายกับ handle ตัวอย่าง (นับโควตาเดียวกัน)

```json
{"p_key": "njk_...", "p_handle": "bankzilla_", "p_filters": {"not_region": "กรุงเทพและปริมณฑล"}, "p_limit": 20}
```
ได้กลับ: `similarity` (0–100), `why`, `k` (ข้อมูล KOL)

### 4) `kol_profile` — ข้อมูลล่าสุดของรายชื่อที่ระบุ (≤50/ครั้ง; ชื่อที่ได้ไปแล้วใน 24 ชม. ไม่กินโควตาซ้ำ)

```json
{"p_key": "njk_...", "p_handles": ["bankzilla_", "nut_fe"]}
```

## ตัวกรอง (`p_filters`) — ใส่เฉพาะที่ต้องการ

| key | ตัวอย่าง | ความหมาย |
|---|---|---|
| `category` | `["Food","Beauty"]` | หมวดเนื้อหา (ค้นแบบมีคำนี้อยู่) |
| `tier` | `["Nano","Micro","Macro","Mega","Sub-1K"]` | |
| `grade` | `["A","B"]` | เกรดจากคะแนนผลงาน |
| `region` | `["อีสาน","ภาคเหนือ","ภาคใต้","ภาคกลาง","ภาคตะวันออก","ภาคตะวันตก","กรุงเทพและปริมณฑล"]` | |
| `not_region` | `"กรุงเทพและปริมณฑล"` | = ต่างจังหวัด (เฉพาะคนที่รู้จังหวัด) |
| `province` | `["เชียงใหม่"]` | |
| `vehicle` | `["รถยนต์","มอไซ","ทั้งสอง","ไม่ชัด"]` | เฉพาะหมวดรถ (แยกจากแคปชัน/bio) |
| `brand_level` | `["ใช่ (ยืนยัน)","น่าจะเคย (แคปชัน)"]` | ระดับงานแบรนด์: **ใช่ (ยืนยัน)** = ป้าย sponsored/งานที่จ้างผ่านแพลตฟอร์ม · **น่าจะเคย (แคปชัน)** = เจอ #ad/#sponsored/#pr, "ร่วมกับ…", @บัญชีแบรนด์ หรือ hashtag แบรนด์ในแคปชัน · `ไม่พบ` |
| `affiliate` | `"exclude"` / `"only"` | ตัด/เอาเฉพาะคนที่ขายของ affiliate (#tiktokshop, ตะกร้า, พิกัด) |
| `live` | `"only"` / `"any"` | `only` = ไลฟ์ขายของ (bio บอกว่าไลฟ์เป็นประจำ + ติดตะกร้า/ขายของ) · `any` = bio บอกว่าไลฟ์ (รวมไลฟ์เกม/วาดรูป) |
| `brand_ok` | `"ใช่"` / `"ไม่พบ"` | (แบบเก่า) = ใช่ (ยืนยัน) เท่านั้น |
| `brand_name` | `["oppo","kfc"]` | เจอชื่อแบรนด์ในแคปชันคลิป sponsored หรือสัญญาณจากแคปชัน |
| `keyword` | `["แม่ลูก"]` | คำใน bio / แคปชัน sponsored |
| `hashtag` | `["ไวน์","craftbeer","โซจู"]` | hashtag ที่ใช้ใน ~15 คลิปล่าสุด (ค้นแบบมีคำนี้อยู่ในแท็ก) — ดีกว่า `keyword` สำหรับหาสายคอนเทนต์ |
| `min_tag_hits` | `2` | ต้องเจออย่างน้อยกี่แท็ก (ค่าเริ่มต้น 1) — ใส่ 2–3 เพื่อเอาคนที่ทำเรื่องนั้นจริงจัง |
| `min_views` / `max_views` | `10000` | ยอดวิวกลาง |
| `min_er` | `5` | ER % |
| `min_female` | `60` | % ผู้ชมหญิง |
| `min_th` | `70` | % ผู้ชมไทย |

## ฟิลด์ที่ได้กลับ
handle, name, link, followers, tier, category, median_views, er, female_pct, top_age, th_pct, persona, bio,
province, region, grade, score, trend, sponsored, platform_orders, brand_ok, brand_caps, vehicle, updated_at, brand_level, brand_signals, affiliate, live

## Error
- `invalid or disabled key` — คีย์ผิด/ถูกปิด
- `daily limit reached` — คีย์นี้ครบโควตา 24 ชม. (ใช้ `kol_count` ได้ต่อ)
