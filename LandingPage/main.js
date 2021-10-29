function navActive() {
  window.addEventListener("scroll", () => {
    const pos = window.pageYOffset;
    document.querySelectorAll("section").forEach((section) => {
      const top = section.offsetTop - 250;
      const bottom = top + section.offsetHeight;
      if (top <= pos && pos < bottom) {
        document
          .querySelector(`nav ul li a[href='#${section.id}']`)
          .classList.add("nav-active");
        console.log(
          document.querySelector(`nav ul li a[href='#${section.id}']`)
        );
      } else {
        document
          .querySelector(`nav ul li a[href='#${section.id}']`)
          .classList.remove("nav-active");
      }
    });
  });
}
navActive();

window.sr = ScrollReveal();
sr.reveal(".animate-left", {
  origin: "left",
  duration: 1000,
  distance: "25rem",
  delay: 300,
});
sr.reveal(".animate-right", {
  origin: "right",
  duration: 1000,
  distance: "25rem",
  delay: 600,
});
sr.reveal(".animate-top", {
  origin: "top",
  duration: 1000,
  distance: "25rem",
  delay: 600,
});

sr.reveal(".animate-bottom", {
  origin: "bottom",
  duration: 1000,
  distance: "25rem",
  delay: 600,
});
sr.reveal(".animate-bottom-1200", {
  origin: "bottom",
  duration: 1000,
  distance: "25rem",
  delay: 1200,
});
sr.reveal(".animate-bottom-900", {
  origin: "bottom",
  duration: 1000,
  distance: "25rem",
  delay: 900,
});
sr.reveal(".animate-bottom-1500", {
  origin: "bottom",
  duration: 1000,
  distance: "25rem",
  delay: 1500,
});
