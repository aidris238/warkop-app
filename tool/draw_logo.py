"""Gambar logo cangkir kopi Warkop: jelas di ukuran kecil, cocok launcher + header."""
from PIL import Image, ImageDraw

S = 1024
BROWN = (124, 74, 18, 255)
WHITE = (255, 255, 255, 255)
CREAM = (255, 243, 224, 255)
COFFEE = (183, 121, 31, 255)

img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
d = ImageDraw.Draw(img)

# Latar: kotak membulat coklat kopi
d.rounded_rectangle([0, 0, S, S], radius=230, fill=BROWN)

# Uap: lengkung S lebih besar & dekat cangkir (tidak seperti mata)
d.arc([380, 170, 500, 360], start=190, end=350, fill=WHITE, width=40)
d.arc([520, 140, 640, 330], start=190, end=350, fill=WHITE, width=40)

# Badan cangkir: trapesium putih (digambar dulu, gagang menempel)
d.polygon([(282, 400), (700, 400), (636, 690), (346, 690)], fill=WHITE)

# Gagang menempel badan (overlap, bukan melayang)
d.arc([610, 410, 860, 630], start=270, end=90, fill=WHITE, width=64)

# Permukaan kopi
d.ellipse([300, 372, 682, 448], fill=COFFEE)
d.ellipse([330, 384, 652, 436], fill=(146, 90, 20, 255))

# Tatakan (saucer)
d.ellipse([236, 690, 746, 800], fill=WHITE)
d.ellipse([300, 706, 682, 784], fill=CREAM)

img.save("assets/icon.png")
print("logo ok:", img.size)

# Launcher Android: tulis langsung ke mipmap
src = img
sizes = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}
for folder, px in sizes.items():
    p = f"android/app/src/main/res/{folder}/ic_launcher.png"
    src.resize((px, px), Image.Resampling.LANCZOS).save(p)
    print("wrote", p)
