document.addEventListener("DOMContentLoaded", function () {
  const container = document.createElement("div");
  container.id = "sidebar-container";
  document.body.prepend(container);

  fetch("sidebar.html")
    .then((res) => res.text())
    .then((data) => {
      container.innerHTML = data;

      // 🔥 Hide/show admin/user links depending on the page
      applySidebarRoleFilter();

      initSidebarFunctions();
      highlightActivePage();
      setupOutsideClickClose();
    });

  function initSidebarFunctions() {
    const sidebar = document.getElementById("mySidebar");

    // OPEN SIDEBAR
    window.openNav = function () {
      sidebar.style.width = "250px";
      sidebar.classList.add("open");
    };

    // CLOSE SIDEBAR
    window.closeNav = function () {
      sidebar.style.width = "0";
      sidebar.classList.remove("open");
    };

    // Logout modal
    const logoutModal = document.getElementById("logoutModal");
    const yesLogout = document.getElementById("yesLogout");
    const noLogout = document.getElementById("noLogout");

    window.showLogoutModal = function () {
      logoutModal.style.display = "flex";
    };

    yesLogout.addEventListener("click", () => {
      window.location.href = "index.html";
    });

    noLogout.addEventListener("click", () => {
      logoutModal.style.display = "none";
    });
  }

  function highlightActivePage() {
    const links = document.querySelectorAll("#mySidebar a");
    const currentPage = window.location.pathname.split("/").pop();

    links.forEach(link => {
      const linkHref = link.getAttribute("href");

      if (linkHref === currentPage) {
        link.classList.add("active-link");
      }
    });
  }

  function setupOutsideClickClose() {
    document.addEventListener("click", function (e) {
      const sidebar = document.getElementById("mySidebar");
      const isMenuButton = e.target.classList.contains("menu-btn") ||
                           e.target.classList.contains("menu-icon");

      if (sidebar.style.width === "250px" &&
          !sidebar.contains(e.target) &&
          !isMenuButton) {
        closeNav();
      }
    });
  }

  const spookyMessages = {
    zombie: [
      "🧟 Ughhh... I'll eat you!",
      "🧟 Braaains... Give me brains!",
      "🧟 You disturbed my eternal rest!",
      "🧟 Join us... in the darkness!",
      "🧟 Fresh meat detected!"
    ],
    web: [
      "🕷️ You disturbed the spider's web!",
      "🕸️ The spider is watching you...",
      "🕷️ Careful! Don't get caught!",
      "🕸️ Ssssss... the spider hisses!",
      "🕷️ You're tangled in my web now!"
    ],
    pumpkin: [
      "🎃 Happy Halloween! Boo!",
      "🎃 Trick or treat, smell my feet!",
      "🎃 The pumpkin king awakens!",
      "🎃 Jack-o'-lantern is watching!",
      "🎃 This pumpkin has a dark secret..."
    ]
  };

  window.showSpookyMessage = function(type) {
    const toast = document.getElementById("spookyToast");
    const messages = spookyMessages[type];
    const randomMessage = messages[Math.floor(Math.random() * messages.length)];

    toast.textContent = randomMessage;
    toast.classList.add("show");

    try {
      const audio = new Audio('horror-playhouse-404813.mp3');
      audio.volume = 0.2;
      audio.play();
    } catch (error) {
      console.log('Audio playback failed:', error);
    }

    setTimeout(() => {
      toast.classList.remove("show");
    }, 3000);
  };

});  // ← THIS closes the DOMContentLoaded function properly

// 🔥 Role filter OUTSIDE of DOMContentLoaded (correct)
function applySidebarRoleFilter() {
  const userLinks = document.querySelector(".user-links");
  const adminLinks = document.querySelector(".admin-links");

  if (typeof isAdmin !== "undefined" && isAdmin === true) {
    userLinks.style.display = "none";
    adminLinks.style.display = "block";
  } else {
    adminLinks.style.display = "none";
    userLinks.style.display = "block";
  }
}
