/**
 * Northern Signal page: asymmetrical signal rail, editorial dark surface,
 * glacier-blue operational accents, and no unverified release promises.
 */
import { useState } from "react";
import {
  ArrowDownRight,
  ArrowUpRight,
  Check,
  ChevronDown,
  CircleDot,
  Cpu,
  Download,
  ExternalLink,
  Github,
  Globe2,
  HardDrive,
  Languages,
  Laptop,
  ShieldCheck,
  Wifi,
} from "lucide-react";

type Copy = {
  nav: { build: string; features: string; install: string; source: string };
  hero: { label: string; titleA: string; titleB: string; body: string; build: string; source: string; detail: string };
  status: { eyebrow: string; title: string; body: string; itemA: string; itemB: string; itemC: string };
  features: { eyebrow: string; title: string; body: string; cards: Array<{ title: string; body: string; tag: string }> };
  install: { eyebrow: string; title: string; steps: Array<{ heading: string; detail: string }> };
  transparency: { label: string; title: string; body: string; checks: string[]; source: string };
  footer: string;
};

const copy: Record<"en" | "vi", Copy> = {
  en: {
    nav: { build: "Build status", features: "Desktop", install: "Install", source: "Source" },
    hero: {
      label: "MinOS Desktop / Noble amd64",
      titleA: "A clear desktop,",
      titleB: "Mint above Ubuntu.",
      body: "MinOS is a lean Linux Mint Cinnamon desktop on Ubuntu 24.04 Noble. English is the default language, and MinOS Update Center notifies you without applying updates on its own.",
      build: "Read build status",
      source: "Browse source",
      detail: "ISO download remains disabled until the boot paths and installer are verified in a VM.",
    },
    status: {
      eyebrow: "Release signal · 24.04.4",
      title: "In build verification",
      body: "The image is being assembled as a Linux Mint Cinnamon distribution layer on Ubuntu 24.04 Noble amd64. It is not yet a published, production-tested download.",
      itemA: "Cinnamon desktop profile",
      itemB: "Live session + Calamares installer",
      itemC: "BIOS and UEFI boot paths under test",
    },
    features: {
      eyebrow: "The desktop signal",
      title: "Practical by default. Intentional in every layer.",
      body: "The image concentrates on a lightweight Cinnamon desktop, a transparent installer path and sensible hardware utilities—without claiming universal device or game compatibility.",
      cards: [
        { title: "Familiar, not bloated", body: "Cinnamon is kept lean and styled for an immediately understandable desktop workflow.", tag: "CINNAMON" },
        { title: "Control the update", body: "MinOS Update Center is powered by Mint Update Manager. It notifies you, while you decide when to review and apply updates.", tag: "MINTUPDATE" },
        { title: "Ready for applications", body: "Chrome, Firefox, VLC, File Roller, Bottles, WPS Office and Zalo Web are included. Flatpak and Flathub extend the catalog.", tag: "FLATPAK" },
        { title: "Install with context", body: "Calamares runs from the Live session and presents an installation slideshow in English and Vietnamese.", tag: "CALAMARES" },
      ],
    },
    install: {
      eyebrow: "From Live to yours",
      title: "A small, explicit path to installation.",
      steps: [
        { heading: "01 / Start MinOS", detail: "Boot into the Live session to inspect the desktop before any disk changes." },
        { heading: "02 / Open the installer", detail: "Calamares walks through language, keyboard, storage, users and a concise MinOS introduction." },
        { heading: "03 / Choose updates", detail: "After installation, Mint Update Manager notifies you; only you apply updates. Windows boot detection is configured but needs real-disk validation." },
      ],
    },
    transparency: {
      label: "A precise promise",
      title: "Source first. Claims second.",
      body: "MinOS will publish an ISO only with a matching SHA-256 checksum and an explicit test record. Firmware branding before the bootloader cannot be controlled by the distribution.",
      checks: ["English default, Vietnamese locale available", "Wi-Fi power saving disabled for NetworkManager connections", "BIOS uses a mascot-only splash; UEFI vendor branding is controlled by firmware", "Unsigned standalone UEFI path requires Secure Boot to be off"],
      source: "Open the repository",
    },
    footer: "MinOS Desktop · Linux Mint Cinnamon on Ubuntu 24.04.",
  },
  vi: {
    nav: { build: "Trạng thái build", features: "Desktop", install: "Cài đặt", source: "Mã nguồn" },
    hero: {
      label: "MinOS Desktop / Noble amd64",
      titleA: "Một desktop rõ ràng,",
      titleB: "Mint trên nền Ubuntu.",
      body: "MinOS là desktop Linux Mint Cinnamon tinh gọn trên Ubuntu 24.04 Noble. English là ngôn ngữ mặc định; MinOS Update Center chỉ thông báo, không tự cài cập nhật.",
      build: "Xem trạng thái build",
      source: "Xem mã nguồn",
      detail: "Nút tải ISO vẫn tắt cho đến khi đường boot và installer được kiểm tra trên máy ảo.",
    },
    status: {
      eyebrow: "Tín hiệu phát hành · 24.04.4",
      title: "Đang kiểm thử build",
      body: "Image đang được dựng theo lớp phân phối Linux Mint Cinnamon trên Ubuntu 24.04 Noble amd64. Đây chưa phải bản tải xuống đã được kiểm thử sản xuất.",
      itemA: "Profile desktop Cinnamon",
      itemB: "Live session + Calamares installer",
      itemC: "Đường boot BIOS và UEFI đang thử nghiệm",
    },
    features: {
      eyebrow: "Tín hiệu desktop",
      title: "Thực dụng theo mặc định. Có chủ đích ở mọi lớp.",
      body: "Image tập trung vào Cinnamon nhẹ, đường cài đặt minh bạch và tiện ích phần cứng hợp lý—không cam kết tương thích tuyệt đối với mọi thiết bị hay trò chơi.",
      cards: [
        { title: "Quen thuộc, không nặng nề", body: "Cinnamon được giữ gọn và định hình cho luồng desktop dễ hiểu ngay từ đầu.", tag: "CINNAMON" },
        { title: "Bạn kiểm soát cập nhật", body: "MinOS Update Center dùng Mint Update Manager. Nó thông báo update; bạn tự quyết định xem và cài đặt.", tag: "MINTUPDATE" },
        { title: "Sẵn sàng cho ứng dụng", body: "Chrome, Firefox, VLC, File Roller, Bottles, WPS Office và Zalo Web có sẵn. Flatpak/Flathub mở rộng kho ứng dụng.", tag: "FLATPAK" },
        { title: "Cài đặt có ngữ cảnh", body: "Calamares chạy từ Live session và hiển thị slideshow cài đặt bằng English lẫn tiếng Việt.", tag: "CALAMARES" },
      ],
    },
    install: {
      eyebrow: "Từ Live thành của bạn",
      title: "Một đường cài đặt nhỏ gọn, rõ ràng.",
      steps: [
        { heading: "01 / Khởi động MinOS", detail: "Vào Live session để xem desktop trước khi thực hiện thay đổi nào trên ổ đĩa." },
        { heading: "02 / Mở installer", detail: "Calamares dẫn qua ngôn ngữ, bàn phím, lưu trữ, tài khoản và giới thiệu ngắn về MinOS." },
        { heading: "03 / Chọn cập nhật", detail: "Sau cài đặt, Mint Update Manager sẽ thông báo; bạn tự chọn thời điểm cài. Dò Windows đã cấu hình nhưng cần xác thực trên ổ đĩa thật." },
      ],
    },
    transparency: {
      label: "Cam kết chính xác",
      title: "Mã nguồn trước. Cam kết sau.",
      body: "MinOS chỉ phát hành ISO cùng SHA-256 và biên bản kiểm thử rõ ràng. Distro không thể kiểm soát logo firmware trước khi bootloader chạy.",
      checks: ["English mặc định, có sẵn locale tiếng Việt", "Tắt Wi-Fi power saving cho kết nối NetworkManager", "BIOS dùng mascot không chữ; logo hãng UEFI do firmware quyết định", "Đường UEFI standalone chưa ký, cần tắt Secure Boot"],
      source: "Mở repository",
    },
    footer: "MinOS Desktop · Linux Mint Cinnamon trên Ubuntu 24.04.",
  },
};

const icons = [Laptop, ShieldCheck, Globe2, HardDrive];

export default function Home() {
  const [lang, setLang] = useState<"en" | "vi">("en");
  const t = copy[lang];

  return (
    <div className="min-h-screen overflow-x-hidden bg-[#080c11] text-[#e9f3f7] selection:bg-[#5de1ff] selection:text-[#081017]">
      <div className="signal-grain pointer-events-none fixed inset-0 z-0 opacity-50" />
      <header className="relative z-20 mx-auto flex w-full max-w-[1440px] items-center justify-between px-5 py-5 sm:px-9 lg:px-14">
        <a href="#top" className="group flex items-center gap-3" aria-label="MinOS Desktop home">
          <span className="relative grid size-11 place-items-center overflow-hidden rounded-full border border-[#5de1ff]/35 bg-[#102130] shadow-[0_0_40px_rgba(93,225,255,.14)]">
            <img src="/manus-storage/minos-penguin-mark_75aeb33a.png" alt="" className="size-9 object-contain" />
          </span>
          <span className="leading-none"><span className="block font-mono text-[10px] tracking-[0.32em] text-[#5de1ff]">MINOS</span><span className="mt-1 block text-xs tracking-[0.2em] text-[#a7bbc4]">DESKTOP</span></span>
        </a>
        <nav className="hidden items-center gap-6 text-sm text-[#a7bbc4] md:flex" aria-label="Primary navigation">
          <a className="nav-link" href="#build">{t.nav.build}</a><a className="nav-link" href="#desktop">{t.nav.features}</a><a className="nav-link" href="#install">{t.nav.install}</a>
        </nav>
        <div className="flex items-center gap-3">
          <div className="flex rounded-full border border-white/10 bg-white/[.035] p-1 font-mono text-[10px]">
            {(["en", "vi"] as const).map((key) => <button key={key} onClick={() => setLang(key)} className={`rounded-full px-2.5 py-1.5 transition ${lang === key ? "bg-[#5de1ff] text-[#071017]" : "text-[#a7bbc4] hover:text-white"}`}>{key.toUpperCase()}</button>)}
          </div>
          <a href="https://github.com/MinhNekoYT-Alt/MinOS" className="hidden items-center gap-2 rounded-full border border-white/10 px-4 py-2 text-sm text-white transition hover:border-[#5de1ff]/60 hover:bg-[#5de1ff]/10 sm:flex"><Github className="size-4" />{t.nav.source}</a>
        </div>
      </header>

      <main id="top" className="relative z-10">
        <section className="relative mx-auto grid min-h-[720px] max-w-[1440px] overflow-hidden border-y border-white/10 lg:grid-cols-[minmax(0,1.08fr)_minmax(450px,.92fr)]">
          <div className="relative flex flex-col justify-between px-5 pb-10 pt-20 sm:px-9 lg:px-14 lg:py-24">
            <div className="absolute bottom-0 left-0 top-0 w-px bg-[#5de1ff]/45" />
            <div className="absolute left-0 top-24 h-32 w-1 bg-[#5de1ff]" />
            <div className="hero-orb absolute -left-24 top-1/4 size-80 rounded-full bg-[#5de1ff]/10 blur-3xl" />
            <div className="relative max-w-3xl">
              <p className="mb-7 flex items-center gap-2 font-mono text-[11px] uppercase tracking-[0.19em] text-[#5de1ff]"><CircleDot className="size-3" /> {t.hero.label}</p>
              <h1 className="max-w-2xl font-display text-[clamp(3.3rem,7vw,6.8rem)] font-medium leading-[.91] tracking-[-.065em] text-white"><span className="block">{t.hero.titleA}</span><span className="block text-[#5de1ff]">{t.hero.titleB}</span></h1>
              <p className="mt-8 max-w-xl text-lg leading-8 text-[#b8c8cf]">{t.hero.body}</p>
              <div className="mt-10 flex flex-wrap gap-3"><a href="#build" className="signal-button"><ArrowDownRight className="size-4" />{t.hero.build}</a><a href="https://github.com/MinhNekoYT-Alt/MinOS" className="ghost-button"><Github className="size-4" />{t.hero.source}</a></div>
            </div>
            <p className="relative mt-16 flex max-w-lg items-start gap-3 border-l border-[#5de1ff]/50 pl-4 font-mono text-xs leading-5 text-[#91a8b2]"><Download className="mt-0.5 size-4 shrink-0 text-[#5de1ff]" />{t.hero.detail}</p>
          </div>
          <div className="relative min-h-[480px] overflow-hidden border-t border-white/10 lg:border-l lg:border-t-0">
            <img src="/manus-storage/minos-northern-signal-hero_0e08e785.png" alt="Abstract MinOS glacial wallpaper" className="absolute inset-0 size-full object-cover" />
            <div className="absolute inset-0 bg-gradient-to-tr from-[#081017]/80 via-transparent to-[#081017]/20" />
            <div className="absolute inset-x-6 bottom-7 flex justify-between border-t border-white/20 pt-4 font-mono text-[10px] uppercase tracking-[0.16em] text-white/70 sm:inset-x-10"><span>Signal Glacier</span><span>24.04 / amd64</span></div>
          </div>
        </section>

        <section id="build" className="relative mx-auto max-w-[1440px] border-b border-white/10 px-5 py-20 sm:px-9 lg:px-14">
          <div className="grid gap-8 lg:grid-cols-[.85fr_1.15fr] lg:items-end">
            <div><p className="eyebrow">{t.status.eyebrow}</p><h2 className="mt-4 font-display text-4xl tracking-[-.05em] text-white sm:text-5xl">{t.status.title}</h2></div>
            <p className="max-w-2xl text-lg leading-8 text-[#b8c8cf]">{t.status.body}</p>
          </div>
          <div className="mt-12 grid divide-y divide-white/10 border-y border-white/10 md:grid-cols-3 md:divide-x md:divide-y-0">
            {[t.status.itemA, t.status.itemB, t.status.itemC].map((item, index) => <div key={item} className="flex min-h-28 items-center gap-4 py-6 md:px-6 md:first:pl-0"><span className="font-mono text-xs text-[#5de1ff]">0{index + 1}</span><span className="text-base leading-6 text-[#d6e2e6]">{item}</span></div>)}
          </div>
        </section>

        <section id="desktop" className="relative mx-auto max-w-[1440px] px-5 py-24 sm:px-9 lg:px-14">
          <div className="grid gap-12 xl:grid-cols-[minmax(300px,.7fr)_minmax(0,1.3fr)]">
            <div className="xl:sticky xl:top-10 xl:self-start"><p className="eyebrow">{t.features.eyebrow}</p><h2 className="mt-4 max-w-md font-display text-4xl tracking-[-.05em] text-white sm:text-5xl">{t.features.title}</h2><p className="mt-6 max-w-md leading-7 text-[#9eb2bc]">{t.features.body}</p><div className="mt-10 overflow-hidden border border-white/10 bg-[#0d151c]"><img src="/manus-storage/minos-desktop-preview_9e976312.png" alt="MinOS desktop concept preview" className="aspect-[16/10] size-full object-cover opacity-90 transition duration-500 hover:scale-[1.025]" /></div></div>
            <div className="grid gap-px bg-white/10 sm:grid-cols-2">{t.features.cards.map((card, i) => { const Icon = icons[i]; return <article key={card.title} className="group min-h-72 bg-[#080c11] p-7 transition hover:bg-[#0c161d]"><div className="flex items-start justify-between"><Icon className="size-6 text-[#5de1ff]" /><span className="font-mono text-[10px] tracking-[0.18em] text-[#6f8a96]">{card.tag}</span></div><div className="mt-24"><h3 className="font-display text-2xl tracking-[-.035em] text-white">{card.title}</h3><p className="mt-3 leading-7 text-[#9eb2bc]">{card.body}</p></div><ArrowUpRight className="mt-5 size-4 text-[#5de1ff] opacity-0 transition duration-200 group-hover:translate-x-1 group-hover:-translate-y-1 group-hover:opacity-100" /></article>})}</div>
          </div>
        </section>

        <section id="install" className="relative overflow-hidden border-y border-white/10 bg-[#0d151c]">
          <img src="/manus-storage/minos-boot-surface_56071243.png" alt="" className="absolute inset-0 size-full object-cover opacity-25" />
          <div className="relative mx-auto max-w-[1440px] px-5 py-24 sm:px-9 lg:px-14"><div className="max-w-2xl"><p className="eyebrow">{t.install.eyebrow}</p><h2 className="mt-4 font-display text-4xl tracking-[-.05em] text-white sm:text-5xl">{t.install.title}</h2></div><div className="mt-16 grid gap-0 border-l border-white/15 lg:grid-cols-3 lg:border-l-0">{t.install.steps.map((step, i) => <article key={step.heading} className="relative border-b border-white/15 py-8 pl-7 lg:border-b-0 lg:border-r lg:px-8 lg:first:pl-0"><span className="absolute -left-[5px] top-10 size-2 rounded-full bg-[#5de1ff] lg:left-auto lg:right-[-5px]">{i === 2 ? "" : ""}</span><h3 className="font-mono text-xs tracking-[0.14em] text-[#5de1ff]">{step.heading}</h3><p className="mt-4 max-w-sm text-lg leading-7 text-[#d9e7ea]">{step.detail}</p></article>)}</div></div>
        </section>

        <section className="relative mx-auto grid max-w-[1440px] gap-12 px-5 py-24 sm:px-9 lg:grid-cols-[.9fr_1.1fr] lg:px-14">
          <div><p className="eyebrow">{t.transparency.label}</p><h2 className="mt-4 max-w-md font-display text-4xl tracking-[-.05em] text-white sm:text-5xl">{t.transparency.title}</h2></div>
          <div><p className="max-w-2xl text-lg leading-8 text-[#b8c8cf]">{t.transparency.body}</p><ul className="mt-9 space-y-4">{t.transparency.checks.map((check) => <li key={check} className="flex gap-3 text-[#d7e3e6]"><Check className="mt-0.5 size-5 shrink-0 text-[#5de1ff]" />{check}</li>)}</ul><a href="https://github.com/MinhNekoYT-Alt/MinOS" className="mt-10 inline-flex items-center gap-2 border-b border-[#5de1ff] pb-2 text-sm text-[#5de1ff] transition hover:gap-3">{t.transparency.source}<ExternalLink className="size-4" /></a></div>
        </section>
      </main>

      <footer className="relative z-10 border-t border-white/10 px-5 py-8 sm:px-9 lg:px-14"><div className="mx-auto flex max-w-[1440px] flex-col justify-between gap-4 text-xs text-[#76909b] sm:flex-row"><p>{t.footer}</p><a href="#top" className="inline-flex items-center gap-2 text-[#a7bbc4] transition hover:text-[#5de1ff]"><ChevronDown className="size-4 rotate-180" />Back to signal</a></div></footer>
    </div>
  );
}
