# nj-kol — เครื่องมือค้น KOL ของทีม Native Jump

ปลั๊กอิน Claude Code สำหรับทีม Native Jump: ค้น KOL, หาคนคล้าย และทำเด็คเสนอลูกค้า

> ใช้งานได้เฉพาะคนที่ได้รับ **คีย์ส่วนตัว** (`njk_…`) จากผู้ดูแลระบบของ Native Jump
> repo นี้ไม่มีข้อมูลหรือรหัสลับ

## ติดตั้ง

```bash
claude plugin marketplace add kanthorn-create/nj-kol-skills
```

```bash
claude plugin install nj-kol@nativejump-kol
```

บันทึกคีย์ส่วนตัว (วางคีย์เมื่อระบบถาม ตัวอักษรจะไม่แสดง):

```bash
read -s "K?วางคีย์ NJ KOL แล้ว Enter: " && printf '%s' "$K" > ~/.nj_kol_key && chmod 600 ~/.nj_kol_key && echo " บันทึกแล้ว"
```

อัปเดตเวอร์ชันใหม่: `claude plugin marketplace update nativejump-kol`

## Skills

| Skill | ทำอะไร |
|---|---|
| `kol-search` | ค้น/นับ KOL |
| `kol-lookalike` | หา KOL ที่คล้ายกับคนตัวอย่าง |
| `kol-shortlist-deck` | ทำเด็คเสนอลูกค้า |

## กติกา
ห้ามส่งรายชื่อออกนอกบริษัท · ห้ามแชร์คีย์
